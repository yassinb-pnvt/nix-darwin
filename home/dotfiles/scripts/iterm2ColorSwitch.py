#!/usr/bin/env python3

import iterm2
import sys


async def change_iterm2_color_preset(connection, preset_name):
    app = await iterm2.async_get_app(connection)
    session = app.current_terminal_window.current_tab.current_session
    profile = await session.async_get_profile()

    preset = await iterm2.ColorPreset.async_get(connection, preset_name)
    await profile.async_set_color_preset(preset)


async def main(connection):
    app = await iterm2.async_get_app(connection)

    # Foreground the app
    await app.async_activate()

    preset_name = sys.argv[1]
    await change_iterm2_color_preset(connection, preset_name)


iterm2.run_until_complete(main)
