#!/usr/bin/env python3

import json
import os
import sys
from Color import Color, Color_str
import CssColorDictionary
import IconColorizer

'''
keys = ["accent_bg_color",
        "accent_fg_color",
        "destructive_color",
        "destructive_bg_color",
        "destructive_fg_color",
        "success_color",
        "success_bg_color",
        "success_fg_color",
        "warning_color",
        "warning_bg_color",
        "warning_fg_color",
        "error_color",
        "error_bg_color",
        "error_fg_color",
        "window_bg_color",
        "window_fg_color",
        "view_bg_color",
        "view_fg_color",
        "headerbar_bg_color",
        "headerbar_fg_color", "headerbar_border_color",
        # "headerbar_backdrop_color",
        "headerbar_shade_color", "card_bg_color", "card_fg_color", "card_shade_color",
        "dialog_bg_color", "dialog_fg_color", "popover_bg_color", "popover_fg_color", "shade_color",
        "scrollbar_outline_color"]
'''
keys = ["accent_bg_color", "window_bg_color"]
available_icons = ['Breeze', 'Fluent', 'Papirus', 'Tela', 'Qogir']


def main():
    print('Colorize icons? [y/N]')
    answ = input()
    colors = CssColorDictionary.CssConfigDictionary(os.path.expanduser('~') + '/.config/gtk-4.0/gtk.css')
    bg_col = colors['window_bg_color']
    acc_col = colors['accent_bg_color']
    hb_bg_col = colors['window_fg_color']
    hl_fg_col = colors['accent_fg_color']
    tt_bg_col = colors['popover_bg_color']
    tt_fg_col = colors['popover_fg_color']
    write_to_file(bg_col.get_hex_view(), bg_col.increase(10).get_hex_view(), acc_col.get_hex_view(),
                  hb_bg_col.get_hex_view(), hl_fg_col.get_hex_view(), tt_bg_col.get_hex_view(),
                  tt_fg_col.get_hex_view())
    write_to_kde_globals(bg_col.get_rgb_view(), bg_col.increase(10).get_rgb_view(), acc_col.get_rgb_view(),
                         hb_bg_col.get_rgb_view(), hl_fg_col.get_rgb_view(), tt_bg_col.get_rgb_view(),
                         tt_fg_col.get_rgb_view())
    # Colorize_icons(acc_col)
    parse_icon_colorizing(answ, acc_col)


def parse_icon_colorizing(answ, acc_col):
    if answ in ['', 'n']:
        return
    if answ != 'y':
        return
    print('Note that icon packs should be in ~/.icons!')
    print('Available Icons')
    for i in range(len(available_icons)):
        print(f'{i+1}. {available_icons[i]}')
    print()
    print("Enter number(example 1,2,3):")
    numbers = input()
    if len(numbers) == 0:
        print("You do not choose any number, skipping icon colorizing")
        return
    Colorize_icons(acc_col, Prepare_input(numbers))


def Prepare_input(input):
    input = input.split(',')
    result = []
    for i in input:
        result.append(int(i))
    return result


def Colorize_icons(acc_col, input):
    if 1 in input:
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(20), 'last_breeze_icon_color',
                                    ['breeze', 'breeze-dark'], False, ['96', '64', '48', '32'], True).colorize()
    if 2 in input:
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(20), 'last_fluent_icon_color',
                                    ['Fluent', 'Fluent-dark'], False,
                                    ['scalable', 'scalable@2x', 'scalable@3x']).colorize()
    if 3 in input:
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(20),
                                    'last_papirus_icon_color',
                                    ['Papirus', 'Papirus-Dark']).colorize()
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col, 'last_papirus_icon_back_color',
                                    ['Papirus', 'Papirus-Dark']).colorize()
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(-10),
                                    'last_papirus_icon_accent_color',
                                    ['Papirus', 'Papirus-Dark']).colorize()
    if 4 in input:
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(20),
                                    'last_tela_icon_color',
                                    ['Tela', 'Tela-dark']).colorize()
    if 5 in input:
        IconColorizer.IconColorizer(os.path.expanduser('~') + '/.icons', acc_col.increase(20),
                                    'last_qogir_icon_color',
                                    ['Qogir', 'Qogir-dark']).colorize()


def convert_rgb(rgb):
    if rgb[3] == 'a':
        rgb = rgb[5:-1]
    else:
        rgb = rgb[4:-1]
    rgb = rgb.split(',')
    rgb_int = []
    for i in rgb:
        rgb_int.append(float(i))
    color = Color(int(rgb_int[0]), int(rgb_int[1]), int(rgb_int[2]))
    return color


def parse_rgb(rgb):
    if rgb[3] == 'a':
        rgb = rgb[5:-1]
    else:
        rgb = rgb[4:-1]
    rgb = rgb.split(',')
    rgb_int = []
    for i in rgb:
        rgb_int.append(float(i))
    result = ''
    for i in range(3):
        result += str(int(rgb_int[i])) + ','
    return result[:-1]


def write_to_file(background_color, window_background_color, highlight_color, window_fg_color, hl_fg_color, tooltip_bg,
                  tooltip_fg):
    text = f"[ColorScheme]\n\
    active_colors =  {window_fg_color}, #ff373737, #ff515151, #ff444444, #ff1e1e1e, #ff2a2a2a, {window_fg_color}, {window_fg_color}, {window_fg_color}, {window_background_color}, {background_color}, #19000000, {highlight_color}, {hl_fg_color}, #ff3584e4, #ff1b6acb, {background_color}, {window_background_color}, {tooltip_bg}, {tooltip_fg}, #80eeeeec\n\
    disabled_colors =  {window_fg_color}, #ff373737, #ff515151, #ff444444, #ff1e1e1e, #ff2a2a2a, {window_fg_color}, {window_fg_color}, {window_fg_color}, {window_background_color}, {background_color}, #19000000, {highlight_color}, {hl_fg_color}, #ff3584e4, #ff1b6acb, {background_color}, {window_background_color}, {tooltip_bg}, {tooltip_fg}, #80eeeeec\n\
    inactive_colors =  {window_fg_color}, #ff373737, #ff515151, #ff444444, #ff1e1e1e, #ff2a2a2a, {window_fg_color}, {window_fg_color}, {window_fg_color}, {window_background_color}, {background_color}, #19000000, {highlight_color}, {hl_fg_color}, #ff3584e4, #ff1b6acb, {background_color}, {window_background_color}, {tooltip_bg}, {tooltip_fg}, #80eeeeec"
    file = os.path.expanduser('~') + '/.config/qt5ct/colors/Gradience.conf'
    dir = os.path.expanduser('~') + '/.config/qt5ct/colors'

    try:
        os.remove(file)
    except:
        pass
    if not os.path.exists(dir):
        os.makedirs(dir)
    with open(file, 'w') as config:
        config.write(text)
    os.path.expanduser('~') + '/.config/kdeglobals'


def write_to_kde_globals(background_color, inter_color, highlight_color, window_fg_color, hl_fg_color, tooltip_bg,
                         tooltip_fg):
    text = f'[ColorEffects:Disabled]\n\
Color=56,56,56\n\
ColorAmount=0\n\
ColorEffect=0\n\
ContrastAmount=0.65\n\
ContrastEffect=1\n\
IntensityAmount=0.1\n\
IntensityEffect=2\n\
\n\
[ColorEffects:Inactive]\n\
ChangeSelectionColor=false\n\
Color=112,111,110\n\
ColorAmount=0.025n\n\
ColorEffect=2\n\
ContrastAmount=0.1\n\
ContrastEffect=2\n\
Enable=false\n\
IntensityAmount=0\n\
IntensityEffect=0\n\
\n\
[Colors:Button]\n\
BackgroundAlternate={background_color}\n\
BackgroundNormal={background_color}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive=112,125,138\n\
ForegroundLink=41,128,185\n\
ForegroundNegative=218,68,83\n\
ForegroundNeutral=246,116,0\n\
ForegroundNormal={window_fg_color}\n\
ForegroundPositive=39,174,96\n\
ForegroundVisited=155,89,182\n\
\n\
[Colors:Complementary]\n\
BackgroundAlternate={highlight_color}\n\
BackgroundNormal={background_color}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive=161,169,177\n\
ForegroundLink=29,153,243\n\
ForegroundNegative=218,68,83\n\
ForegroundNeutral=246,116,0\n\
ForegroundNormal={window_fg_color}\n\
ForegroundPositive=39,174,96\n\
ForegroundVisited=155,89,182\n\
\n\
[Colors:Selection]\n\
BackgroundAlternate={highlight_color}\n\
BackgroundNormal={highlight_color}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive={highlight_color}\n\
ForegroundLink=41,128,185\n\
ForegroundNegative={highlight_color}\n\
ForegroundNeutral={highlight_color}\n\
ForegroundNormal={hl_fg_color}\n\
ForegroundPositive={highlight_color}\n\
ForegroundVisited=155,89,182\n\
\n\
[Colors:Tooltip]\n\
BackgroundAlternate={tooltip_bg}\n\
BackgroundNormal={tooltip_bg}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive={tooltip_fg}\n\
ForegroundLink=41,128,185\n\
ForegroundNegative=218,68,83\n\
ForegroundNeutral=246,116,0\n\
ForegroundNormal={tooltip_fg}\n\
ForegroundPositive=39,174,96\n\
ForegroundVisited=155,89,182\n\
\n\
[Colors:View]\n\
BackgroundAlternate={inter_color}\n\
BackgroundNormal={inter_color}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive=112,125,138\n\
ForegroundLink=41,128,185\n\
ForegroundNegative=218,68,83\n\
ForegroundNeutral=246,116,0\n\
ForegroundNormal=255,255,255\n\
ForegroundPositive=39,174,96\n\
ForegroundVisited=155,89,182\n\
\n\
[Colors:Window]\n\
BackgroundAlternate={background_color}\n\
BackgroundNormal={background_color}\n\
DecorationFocus={highlight_color}\n\
DecorationHover={highlight_color}\n\
ForegroundActive={highlight_color}\n\
ForegroundInactive=112,125,138\n\
ForegroundLink=41,128,185\n\
ForegroundNegative=218,68,83\n\
ForegroundNeutral=246,116,0\n\
ForegroundNormal={window_fg_color}\n\
ForegroundPositive=39,174,96\n\
ForegroundVisited=155,89,182'
    file = os.path.expanduser('~') + '/.config/kdeglobals'
    try:
        os.remove(file)
    except:
        pass
    with open(file, 'w') as config:
        config.write(text)


def convert_to_hex(int):
    return hex(int)


if __name__ == '__main__':
    main()
