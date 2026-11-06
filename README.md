# Open CS

This game requires Luanti (formerly Minetest) 5.17 or newer.

Its purpose is to provide a good, low-requirement FPS, while proving the power of CSM based graphics, HUD and menus.

It is in an early beta stage.

## Running and developing

Use the [development setup guide](https://github.com/open-csgo/open-cs-dev#readme) for the Docker Compose server, Linux client build, and automatic client login. Clone this repository with `--recurse-submodules`; the `redef` mod is required and its source is pinned as a Git submodule.

Open CS uses the separate [Open CS client mod](https://github.com/open-csgo/open-cs-client) for its HUD and menus. Install it on each client; the development launcher does this automatically. Game source changes become available after restarting the server, without rebuilding its image.

## Credits

"Pixel Anti-Material Rifle" (https://skfb.ly/6Z9Su) by FireWarden is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
