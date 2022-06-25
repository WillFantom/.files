#!/usr/bin/env python3.7

import iterm2

DARK_THEME = "nord"
DARK_BLUR = True
DARK_BLUR_RADIUS = 30
DARK_TRANSPARENCY = 0.25

LIGHT_THEME = "nord-light"
LIGHT_BLUR = True
LIGHT_BLUR_RADIUS = 40
LIGHT_TRANSPARENCY = 0.15


async def main(connection):
    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            theme = await mon.async_get()

            preset = await iterm2.ColorPreset.async_get(connection, DARK_THEME if "dark" in theme.split(" ") else LIGHT_THEME)
            blur = DARK_BLUR if "dark" in theme.split(" ") else LIGHT_BLUR
            blur_radius = DARK_BLUR_RADIUS if "dark" in theme.split(" ") else LIGHT_BLUR_RADIUS
            transparency = DARK_TRANSPARENCY if "dark" in theme.split(" ") else LIGHT_TRANSPARENCY

            profiles = await iterm2.PartialProfile.async_query(connection)
            for partial in profiles:
                # Fetch the full profile and then set the color preset in it.
                profile = await partial.async_get_full_profile()
                await profile.async_set_color_preset(preset)
                await profile.async_set_blur(blur)
                await profile.async_set_blur_radius(blur_radius)
                await profile.async_set_transparency(transparency)

iterm2.run_forever(main)
