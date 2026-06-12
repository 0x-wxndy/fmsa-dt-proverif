# FMSA-DT ProVerif models

Symbolic ProVerif models and reproduction scripts for **FMSA-DT** (*Formal Modeling and Security Analysis of DT-enabled smart environments*).

This repository archives the ProVerif encoding used to discharge properties **P1–P3** in the paper: measurement secrecy, injective device-to-fog agreement, and actuation guarded by commit / permit / ML-gate events.

## Contents

| Path | Description |
|------|-------------|
| `formal/proverif/examples/minimal_secrecy.pv` | Toolchain sanity check (symmetric encryption hides a secret). |
| `formal/proverif/sdt_abstract.pv` | Abstract operational shell (`publish` / `accept` / `commit` / `permit` / `actuate`). |
| `formal/proverif/sdt_signed_pipeline.pv` | Signed pipeline on `(c, σ, d, t)` with post-compromise phase-1 key leak. |
| `formal/proverif/out/*.log` | Reference verification transcripts shipped with the release. |
| `scripts/run_proverif.sh` | Bash driver (Linux / macOS / WSL). |
| `scripts/run_proverif.ps1` | PowerShell driver (Windows). |

## Requirements

- [ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/) **2.05** (or compatible 2.05.x) on `PATH`
- Bash or PowerShell, and optionally GNU Make

Install on Ubuntu/WSL:

```bash
sudo apt update
sudo apt install -y opam m4 pkg-config libgmp-dev
opam init -y --disable-sandboxing
eval "$(opam env)"
opam install -y proverif.2.05   # or: opam install proverif
proverif --help
```

## Reproduce the paper results

From the **repository root**:

```bash
bash scripts/run_proverif.sh
```

Windows (PowerShell):

```powershell
.\scripts\run_proverif.ps1
```

Or with Make:

```bash
make -C formal/proverif verify
```

Fresh logs are written to `formal/proverif/out/`. Compare against the bundled reference logs if you want a quick diff.

### Expected outcomes

| Model | Key queries | Expected |
|-------|-------------|----------|
| `minimal_secrecy.pv` | `not attacker(s)` | `true` |
| `sdt_abstract.pv` | P1–P3 correspondence queries | `true` |
| `sdt_signed_pipeline.pv` | P1 phase 0, P2, P3 | `true` |
| `sdt_signed_pipeline.pv` | P1 phase 1 (post key leak) | `false` (by design) |

The phase-1 `false` on `sdt_signed_pipeline.pv` models intentional post-compromise exposure of past ciphertexts under a long-lived symmetric key; it is documented in the paper's ProVerif table.

## Citation

If you use these models, please cite the Zenodo record (once published) or this repository:

```bibtex
@misc{fmsa-dt-proverif,
  author       = {0x-wxndy},
  title        = {{FMSA-DT}: {ProVerif} Models and Reproducibility Scripts},
  year         = {2026},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.XXXXXXX},
  url          = {https://doi.org/10.5281/zenodo.XXXXXXX},
  note         = {Software archive, also at \url{https://github.com/0x-wxndy/fmsa-dt-proverif}}
}
```

Replace `10.5281/zenodo.XXXXXXX` with the DOI assigned after the first GitHub release is archived on Zenodo.

See also [`CITATION.cff`](CITATION.cff) for GitHub/Zenodo metadata integration.

## License

MIT License — see [`LICENSE`](LICENSE).

## Zenodo archive (maintainers)

1. Push this repository to GitHub.
2. Log in at [zenodo.org](https://zenodo.org) with your GitHub account.
3. **Account → GitHub → Enable** integration for `0x-wxndy/fmsa-dt-proverif`.
4. Create a GitHub **Release** tagged `v1.0.0` (see [`ZENODO.md`](ZENODO.md)).
5. Zenodo mints a DOI; add it to `CITATION.cff`, this README, and the paper's `ref.bib` entry `REPO`.
