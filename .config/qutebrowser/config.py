# pyright: reportUndefinedVariable=false
config.load_autoconfig(False)

# Keybindings
config.bind('<Ctrl-r>', 'reload')


config.bind('<Space>pp', 'spawn --userscript qute-bitwarden')
config.bind('<Space>pu', 'spawn --userscript qute-bitwarden --username-only')
config.bind('<Space>pw', 'spawn --userscript qute-bitwarden --password-only')
