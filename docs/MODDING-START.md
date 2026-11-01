# Modding on vanilla benilla (your fork)

This repo **is** the game: stock 1.12.1 client, stock UI, server login. Treat it as the base; add modes and rules on top instead of shipping a separate “survivors” shell unless you want that later.

## Run locally (Windows)

1. **Game data:** point `WOW_DATA` at a build **5875** `Data` folder (MPQs only; benilla never writes into it). Reuse data from another clone if you already extracted it, e.g. `..\azeroth-survivors-re\wow-data\Data`.
2. **Server:** run a 1.12.1 core locally ([vmangos](https://github.com/vmangos/core) is the usual dev target). Warden must be **off**. Set Realmlist to your realm. **GM accounts:** [GM-ACCOUNT.md](./GM-ACCOUNT.md).
3. **Client:**

```powershell
.\scripts\dev-windows.ps1
```

Or: `WOW_DATA=C:\path\to\Data cargo run --release -p benilla`

Config, addons, and screenshots live under **`benilla-config/`** next to the binary (created on first run).

## How to add features (without forking the whole engine)

| Approach | When to use |
|----------|-------------|
| **1.12 addons** | UI, combat helpers, timers — drop into `benilla-config/AddOns` (same as classic client). Fastest iteration. |
| **`benilla_app::run_with`** | New Bevy plugins: alternate game modes, dungeon timers, custom spawns. See `crates/benilla-app/examples/extended_launcher.rs`. |
| **Separate launcher crate** | Large projects (your own `Cargo.toml`, depend on `benilla-app` via git/path). Keeps upstream merges clean. |
| **Server + DB (vmangos)** | New items, quests, instances, scaling — classic private-server workflow; client stays stock. |

Upstream expects **gameplay that 1.12 never had** to live in a crate on top, not scattered through core crates — see `docs/CONTRIBUTING.md`.

## Reference material elsewhere

- **Reverse engineering:** [benilla-re](https://github.com/samwhosung/benilla-re)
- **Roguelike / auto-combat ideas:** community `azeroth-survivors-re` → `crates/benilla-app/src/survivors/` (not required for vanilla modding)
- **Architecture map:** `docs/MAP.md`, deviations: `docs/DEVIATIONS.md`

## Staying current

```bash
git fetch upstream
git merge upstream/main   # or rebase your feature branches
```

Your **`origin`** is this fork; **`upstream`** is [samwhosung/benilla](https://github.com/samwhosung/benilla).
