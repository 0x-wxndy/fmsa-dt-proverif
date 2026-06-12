# ProVerif models (`formal/proverif/`)

This directory contains the applied-pi ProVerif models cited in the FMSA-DT paper.

**Start here:** see the [repository root README](../../README.md) for install instructions and reproduction commands.

Quick run from repository root:

```bash
bash scripts/run_proverif.sh
make -C formal/proverif verify
```

Models:

| File | Role |
|------|------|
| `examples/minimal_secrecy.pv` | Sanity: `not attacker(s)` is `true`. |
| `sdt_abstract.pv` | Abstract P1–P3 shell on one payload bitstring. |
| `sdt_signed_pipeline.pv` | Signed tuple + phase-1 key leak (intentional P1 failure). |

All `.pv` files must use **LF** line endings (`*.pv text eol=lf` in `.gitattributes`).
