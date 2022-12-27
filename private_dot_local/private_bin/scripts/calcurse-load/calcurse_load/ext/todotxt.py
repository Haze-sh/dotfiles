import os
import re
import warnings
from pathlib import Path
from typing import Optional, Iterator, List, Set
from functools import lru_cache

from dataclasses import dataclass

from .abstract import Extension
from .utils import yield_lines

# parses, converts and reconstructs the TodoTxtTodo format
@dataclass
class TodoTxtTodo:
    priority: str
    text: str

    def __hash__(self) -> int:
        return hash(self.text)

    def convert(self) -> "CalcurseTodo":
        """
        >>> TodoTxtTodo(priority="(A)", text="some todo").convert()
        CalcurseTodo(priority=1, text='some todo')
        >>> TodoTxtTodo(priority="", text="some other todo (A)").convert()
        CalcurseTodo(priority=0, text='some other todo (A)')
        >>> TodoTxtTodo(priority="(C)", text="not important todo").convert()
        CalcurseTodo(priority=7, text='not important todo')
        """
        priority: int = {
            "(A)": 1,
            "(B)": 4,
            "(C)": 7,
        }.get(self.priority, 0)
        return CalcurseTodo(priority, self.text)

    @classmethod
    def parse_line(cls, line: str) -> "TodoTxtTodo":
        """
        Parse a todo.txt line, parse out the priority

        >>> TodoTxtTodo.parse_line("(A) some todo")
        TodoTxtTodo(priority='(A)', text='some todo')
        >>> TodoTxtTodo.parse_line("not important")
        TodoTxtTodo(priority='', text='not important')
        """
        prio, text = re.match(r"^(\([ABC]\))?(.*)", line.strip()).groups()  # type: ignore[union-attr]
        if prio is None:
            prio = ""
        return cls(priority=prio, text=text.strip())

    @property
    def line(self) -> str:
        """Convert the todotxt data back to a line"""
        if self.priority == "":
            return self.text
        else:
            return f"{self.priority} {self.text}"


# parses, converts and reconstructs the CalcurseTodo format
@dataclass
class CalcurseTodo:
    priority: int
    text: str

    def __hash__(self) -> int:
        return hash(self.text)

    def convert(self) -> "TodoTxtTodo":
        """
        >>> CalcurseTodo(priority=0, text="something basic").convert()
        TodoTxtTodo(priority='', text='something basic')
        >>> CalcurseTodo(priority=3, text="important!!").convert()
        TodoTxtTodo(priority='(A)', text='important!!')
        """
        priority = ""
        if self.priority == 0:
            pass
        elif self.priority < 4:
            priority = "(A)"
        elif self.priority < 7:
            priority = "(B)"
        else:
            priority = "(C)"
        return TodoTxtTodo(priority=priority, text=self.text)

    @classmethod
    def parse_line(cls, line: str) -> "CalcurseTodo":
        """
        Parse a calcurse line, parse out the priority

        >>> CalcurseTodo.parse_line('[1] most important todo')
        CalcurseTodo(priority=1, text='most important todo')
        """
        prio, text = re.match(r"^(\[\d+\])(.*)", line.strip()).groups()  # type: ignore[union-attr]
        return cls(priority=int(prio.strip("[]")), text=text.strip())

    @property
    def line(self) -> str:
        return f"[{self.priority}] {self.text}"


class todotxt_ext(Extension):
    def pre_load(self) -> None:
        """
        Replace the calcurse todos with my todo.txt file contents
        """
        # search common locations
        todo_file: Optional[Path] = self.__class__._find_todo_file()
        if todo_file is None:
            warnings.warn("Could not find todo.txt file in expected locations")
            return
        # read in todo.txt items
        todos: List[TodoTxtTodo] = list(self.__class__._read_todotxt_file(todo_file))
        # convert to calcurse format
        calcurse_todos: List[CalcurseTodo] = list(map(lambda t: t.convert(), todos))
        # write to calcurse file
        with open(self.config.calcurse_dir / "todo", "w") as calcurse_todof:
            for cl in calcurse_todos:
                calcurse_todof.write("{}\n".format(cl.line))

    def post_save(self) -> None:
        """
        After calcurse has saved, read the calcurse todo file, and compare that with my todo.txt file
        If there are any items in calcurse that I added that aren't in my todo.txt, add it to my todo.txt file
        """
        # read the calcurse todos
        calcurse_todos: List[CalcurseTodo] = list(
            self.__class__._read_calcurse_file(self.config.calcurse_dir / "todo")
        )
        todo_file: Optional[Path] = self.__class__._find_todo_file()
        if todo_file is None:
            warnings.warn("Could not find todo.txt file in expected locations")
            return
        # read in todo.txt items, save a set of the text descriptions, so we can compare
        # to the newly saved calcurse todos.
        todos: List[TodoTxtTodo] = list(self.__class__._read_todotxt_file(todo_file))
        todo_text: Set[str] = set(map(lambda t: t.text, todos))
        # convert the calcurse todos to todotxt todos, so we can see if any were added
        converted_todos: List[TodoTxtTodo] = list(
            map(lambda t: t.convert(), calcurse_todos)
        )
        new_todos = [c for c in converted_todos if c.text not in todo_text]
        # write back to todo.txt file, if there are any new todos
        if new_todos:
            todos.extend(new_todos)
            with open(todo_file, "w") as todotxt_f:
                for td in todos:
                    todotxt_f.write("{}\n".format(td.line))

    @staticmethod
    @lru_cache(1)
    def _find_todo_file() -> Optional[Path]:
        """
        Resolution order:
            - $TODOTXT_FILE
            - $TODO_DIR/todo.txt
            - $XDG_CONFIG/todo/todo.txt
            - ~/.config/todo/todo.txt
            - ~/.todo/todo.txt
        """
        for path_str in [
            os.environ.get("TODOTXT_FILE"),
            os.path.join(os.environ.get("TODO_DIR", "/NO_TODO_DIR_SET"), "todo.txt"),
            os.path.join(
                os.environ.get(
                    "XDG_CONFIG_HOME", os.path.join(os.environ["HOME"], ".config")
                ),
                "todo",
                "todo.txt",
            ),
            os.path.join(os.environ["HOME"], ".todo", "todo.txt"),
        ]:
            if path_str is not None:
                if os.path.exists(path_str):
                    return Path(path_str)
        return None

    @staticmethod
    def _read_todotxt_file(path: Path) -> Iterator["TodoTxtTodo"]:
        for line in yield_lines(path):
            yield TodoTxtTodo.parse_line(line)

    @staticmethod
    def _read_calcurse_file(path: Path) -> Iterator["CalcurseTodo"]:
        for line in yield_lines(path):
            yield CalcurseTodo.parse_line(line)
