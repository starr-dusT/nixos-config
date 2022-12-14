from os.path import expanduser
from yaml import safe_load

# Get color config from pywal
wal_loc = expanduser("~/.config/qtile/themes/dracula.yml")
wal = safe_load(open(wal_loc))

#wal = {"wallpaper": "",
#       "special": {"background": "#282A36",
#                   "foreground": "#F8F8F2",
#                   "cursor": "#44475A"},
#       "colors": {"color0": "#282A36",
#                 "color1": "#44475A",
#                 "color2": "#F8F8F2",
#                 "color3": "#6272A4",
#                 "color4": "#8BE9FD",
#                 "color5": "#50FA7B",
#                 "color6": "#FFB86C",
#                 "color7": "#FF79C6",
#                 "color8": "#BD93F9",
#                 "color9": "#FF5555",
#                 "color10": "#F1FA8C"}}
