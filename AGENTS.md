# OpenCS

> OpenCS is an open-source Counter-Strike inspired game for the Luanti engine.

- HUD and menus are implemented client-side using a client side mod, which is required for the game to run. The server mod is responsible for the game logic and networking.
- There is a focus on moving as much as possible of the non-gameplay logic to the client side, to reduce the server load.

Sources:

- [Game Design Document](./GDD.md)
- [Server Lua API reference](https://raw.githubusercontent.com/luanti-org/luanti/refs/tags/5.18.0/doc/lua_api.md)
- [Client Lua API reference](https://raw.githubusercontent.com/luanti-org/luanti/refs/tags/5.18.0/doc/client_lua_api.md)

## Conventions

### Lua code

- The main Luanti API namespace is `core.*`, don't use `minetest.*`.
- Mods in the `mods/DEFAULT` folder are imported from [`minetest_game`](https://github.com/luanti-org/minetest_game), these should usually not be modified.
