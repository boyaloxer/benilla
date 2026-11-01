# GM account for local testing

**GM rank lives on the server**, not in benilla. The client only sends chat lines like `.tele Stormwind`; vmangos checks your account's **gmlevel** before running them.

## Quick setup (Windows, no Docker)

1. Install a **1.12.1 (5875)** vmangos bundle, e.g. [vMangos-Repack](https://github.com/cbunting99/vMangos-Repack) (MySQL + `realmd.exe` + `mangosd.exe`). Follow its README: start MySQL, then `realmd`, then `mangosd` (wait for the ready beep).
2. In the **`mangosd` console** (not in-game), create an admin:

   ```text
   account create test test
   account set gmlevel test 6
   ```

   - **Level 3** = standard GM (`.tele`, `.additem`, `.npc spawn`, …).
   - **Level 6** = administrator (everything benilla's dev probes expect).

3. **Benilla Realmlist:** default is already `localhost` (port 3724). On the login screen use **Realmlist** if you need `127.0.0.1` or a custom port (`127.0.0.1:3724`).
4. Log in with `test` / `test`, create a character, enter the world.
5. In chat, prefix GM commands with a **dot**: `.help`, `.tele Orgrimmar`, `.gm fly on`, `.modify speed 3`.

Reference: [vmangos GM commands](https://vmangos.github.io/wiki/GM-Commands/).

## If you already have an account

From **mangosd console** (level 7 / console only for `account set gmlevel`):

```text
account set gmlevel YourAccountName 6
```

Or in-game as an existing admin: `.account set gmlevel YourAccountName 6`

## Benilla-only notes

- `WOW_HOST=127.0.0.1:3724` overrides Realmlist for one session (not saved).
- Automated tests use `WOW_USER` / `WOW_PASS` / `WOW_CHAR` and expect GM level **6** on that account (`docs/CONTRIBUTING.md`).
- At GM level 3+, vmangos may enable **cheat god** behavior; for normal combat testing set `GM.CheatGod = 0` in `mangosd.conf` or use `.cheat god off` in game.

## Without a server

Benilla will reach the login UI but cannot enter the world. Survivors-style offline mode is a different binary (`warcraft-survivors` in the AS repo), not stock benilla.
