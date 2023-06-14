"""Convert todo.txt formatted files to Emacs Org mode format

Arguments:
    list of .txt files

Returns:
    None
"""

import re
import os
import argparse
import copy
from datetime import datetime
from collections import defaultdict


def parse_date(date_text):
    """ Parse datetime object from string, return None on failure """
    try:
        return datetime.strptime(date_text, '%Y-%m-%d')
    except ValueError:
        return None


def date_to_string(date):
    """ Convert input to date string, return empty string on failure """
    try:
        return datetime.strftime(date, "%Y-%m-%d")
    except (TypeError, ValueError):
        return ""


def parse_project(text, project_regex):
    """ Parse @project_name string from text, return empty string on failure """
    try:
        return project_regex.search(text).group(1)
    except AttributeError:
        return ""


def parse_key_values(text, key_value_regex):
    """ Parse dict of key:values from text, return empty dict on failure """
    key_values = {}
    for match in key_value_regex.findall(text):
        if len(match.split(':')) == 2:
            key_values[match.split(':')[0]] = match.split(':')[1]
    return key_values


def remove_tags(text, project_regex, context_regex, key_value_regex):
    """ Remove any @project_names, +contexts, key:values from input string """
    text = re.sub(project_regex, '', text)
    text = re.sub(context_regex, '', text)
    text = re.sub(key_value_regex, '', text)
    return text


def process_notes(key_values, completion_date, creation_date):
    """ Convert completion, creation and deadline dates to Org mode format """
    components = []
    properties = []
    if completion_date:
        components.append(f'CLOSED: [{date_to_string(completion_date)}]')
    if creation_date:
        components.append(f'[{date_to_string(creation_date)}]')
    for key, value in key_values.items():
        if key == 'due':
            value = value.split(None, 1)[0]
            components.append(f'DEADLINE: <{date_to_string(parse_date(value))}>')
        else:
            properties.append(f':{key.upper()}: {value}')
    if len(properties) > 0:
        components.extend([':PROPERTIES:']+properties+[':END:'])
    return '\n'.join(list(filter(None, components)))


def convert_to_org(lines):
    """ Convert list of strings in todo.txt format to Emacs Org mode formatted string """
    projects = defaultdict(list)
    priority_regex = re.compile(r'\(([A-Z])\)')
    project_regex = re.compile(r'(?:^|\s)\+([^\s]+)/g')
    context_regex = re.compile(r'(?:^|\s)@([^\s]+)')
    key_value_regex = re.compile(r'(?:^|\s)([^\s:]+:[^\s]+)')

    for line in lines:
        completed = False
        priority = ""
        completion_date = None
        creation_date = None

        components = line.split()

        try:
            # completion
            if components[0] == 'x':
                completed = True
                components.pop(0)

            # priority
            if priority_regex.match(components[0]):
                priority = priority_regex.match(components[0]).group(1)
                components.pop(0)

            # dates
            date1 = parse_date(components[0])
            date2 = parse_date(components[1])
            if date1 and date2:
                completion_date = date1
                creation_date = date2
                components.pop(0)
                components.pop(0)
            elif date1:
                if completed:
                    completion_date = date1
                else:
                    creation_date = date1
                components.pop(0)
        except IndexError:
            pass

        line = ' '.join(components)
        project = parse_project(line, project_regex)
        if not project:
            project = 'Tasks'
        contexts = context_regex.findall(line)
        key_values = parse_key_values(line, key_value_regex)
        cleaned_line = remove_tags(line, project_regex, context_regex, key_value_regex)

        org_status = 'DONE' if completed else 'TODO'
        org_priority = f'[#{priority}]' if priority else ''
        org_tags = f':{":".join(contexts)}:' if contexts else ''
        org_heading = ' '.join(list(filter(None, [org_status, org_priority, cleaned_line, org_tags])))
        org_notes = process_notes(key_values, completion_date, creation_date)

        node = '\n'.join(list(filter(None, [f'** {org_heading}', org_notes])))
        projects[project].append(node)

    output_lines = []
    for key, value in projects.items():
        joined_values = '\n'.join(value)
        output_lines.append(f'* {key}\n{joined_values}')

    return '\n'.join(output_lines)


def convert_to_todo(lines):
    """ Convert list of todo Org mode lines to todo.txt formatted string"""

    header_regex = re.compile(r'^(\*+)\s(.*?)\s*$')
    todo_status_regex = re.compile(r'\s*(TODO|DONE)\s(.*?)\s*$')
    priority_regex = re.compile(r'^\[#([A-Z])\]\s(.*?)\s*$')
    tags_regex = re.compile(r'(.*?)\s*:(.*?):(.*?)$')
    creation_date_regex = re.compile(r'CREATED:\s+[<\[]([0-9]+-[0-9]+-[0-9]+)')
    completion_date_regex = re.compile(r'CLOSED:\s+[<\[]([0-9]+-[0-9]+-[0-9]+)')
    deadline_date_regex = re.compile(r'DEADLINE:\s+[<\[]([0-9]+-[0-9]+-[0-9]+)')
    date_regex = re.compile(r'^\s*[<\[]([0-9]+-[0-9]+-[0-9]+)')
    key_value_regex = re.compile(r'^\s*:(.*?):\s*(.*?)\s*$')

    def cut_priority(regex, heading):
        priority = ''
        priority_match = re.search(regex, heading)
        if priority_match:
            priority = priority_match.group(1)
            heading = priority_match.group(2)
        return priority, heading

    def parse_date_with_regex(regex, line):
        date = ''
        match = re.search(regex, line)
        if match:
            date = date_to_string(parse_date(match.group(1)))
        return date

    def cut_tags(tags_regex, heading):
        tag_list = []
        tags_match = re.search(tags_regex, heading)

        if tags_match:
            heading = tags_match.group(1)
            first_tag = tags_match.group(2)
            tag_list.append(first_tag)
            rest_of_tags = tags_match.group(3)
            if rest_of_tags:
                for tag in rest_of_tags.split(':'):
                    if tag != '':
                        tag_list.append(tag)
        return tag_list, heading

    def parse_key_value(key_value_regex, line):
        property_match = re.search(key_value_regex, line)
        if property_match:
            return property_match.group(1), property_match.group(2)
        else:
            return '', ''

    def todo_to_string(todo):
        completed = 'x' if todo['todo_status'] == 'DONE' else ''
        priority = f'({todo["priority"]})' if todo["priority"] else ''
        projects = ' '.join([f'+{project}' for project in list(filter(lambda x: x not in ['', 'Tasks'], todo['projects']))])
        contexts = ''
        for _list in todo['tags']:
            contexts += ''.join(list(filter(None, [f'@{item} ' for item in _list])))
        key_values = ' '.join([f'{key}:{value}' for key, value in todo['key_values'].items()])
        return ' '.join(list(filter(None, [completed, priority, todo['completion_date'], todo['creation_date'],
                                           todo['body_text'], projects.strip(), contexts.strip(), key_values])))

    todos = list()
    todo = {'todo_status': '',
            'priority': '',
            'completion_date': '',
            'creation_date': '',
            'body_text': '',
            'projects': [],
            'tags': [],
            'key_values': {}}
    projects = []
    tags = []
    level = 1

    for line in lines:
        line_is_header = re.search(header_regex, line)

        if line_is_header:
            level = len(line_is_header.group(1))  # number of stars
            heading = line_is_header.group(2)  # header text
            todo_match = re.match(todo_status_regex, heading)

            if todo_match:
                heading = todo_match.group(2)

                if heading:  # heading or todo line
                    if todo['body_text']:
                        # save previous todo string
                        todos.append(copy.deepcopy(todo))
                        todo['projects'] = copy.deepcopy(projects)
                        todo['tags'] = copy.deepcopy(tags)
                        todo['completion_date'] = ''
                        todo['creation_date'] = ''
                        todo['key_values'] = dict()

                    todo['todo_status'] = todo_match.group(1)
                    todo['priority'], heading = cut_priority(priority_regex, heading)
                    new_tags, heading = cut_tags(tags_regex, heading)
                    if new_tags:
                        todo['tags'].append(new_tags)
                    todo['body_text'] = heading

            else:
                new_tags, heading = cut_tags(tags_regex, heading)
                tags = tags[:level-1]
                tags.append(new_tags)
                projects = projects[:level-1]
                projects.append(heading)
                if not todos:
                    todo['projects'] = copy.deepcopy(projects)
                    todo['tags'] = copy.deepcopy(tags)

        else:  # non-heading line
            if ':PROPERTIES:' in line or ':END:' in line:
                continue
            date = parse_date_with_regex(creation_date_regex, line)
            if date:
                todo['creation_date'] = date
            date = parse_date_with_regex(completion_date_regex, line)
            if date:
                todo['completion_date'] = date
            deadline_date = parse_date_with_regex(deadline_date_regex, line)
            if deadline_date:
                todo['key_values']['due'] = deadline_date
            date = parse_date_with_regex(date_regex, line)
            if date:
                todo['creation_date'] = date
            key, value = parse_key_value(key_value_regex, line)
            if key:
                todo['key_values'][key] = value

    todos.append(copy.deepcopy(todo))
    output_lines = []
    for todo in todos:
        output_lines.append(todo_to_string(todo))
    return '\n'.join(output_lines)


def main():
    parser = argparse.ArgumentParser(
        description='Todo.txt to Org mode converter',
        usage="todo2org.py [-r] file1 file2 ..")
    parser.add_argument('input_files', type=argparse.FileType('r', encoding='utf-8'),
                        nargs='+', help='list of input files')
    parser.add_argument('-r', '--reverse', dest='reverse', default=False, action='store_true',
                        help='convert to todo.txt instead')
    options = parser.parse_args()

    if options.reverse:
        new_extension = '_.txt'
        convert = convert_to_todo
    else:
        new_extension = '.org'
        convert = convert_to_org

    for input_file in options.input_files:
        file_name, extension = os.path.splitext(input_file.name)
        with input_file, open(file_name+new_extension, 'w', newline='\n', encoding='utf-8') as output_file:
            converted_lines = convert(input_file.readlines())
            output_file.writelines(converted_lines)


if __name__ == "__main__":
    main()
