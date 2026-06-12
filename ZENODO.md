# Zenodo release checklist

Follow these steps once after the first public push to GitHub.

## 1. Verify the repository locally

```bash
cd fmsa-dt-proverif
bash scripts/run_proverif.sh
# or: make -C formal/proverif verify
```

All three models should run; `sdt_signed_pipeline.pv` should report one intentional `false` on the phase-1 secrecy query.

## 2. Initial Git push

```bash
git init
git add .
git commit -m "Initial release: FMSA-DT ProVerif models (P1-P3)"
git branch -M main
git remote add origin https://github.com/0x-wxndy/fmsa-dt-proverif.git
git push -u origin main
```

## 3. Enable Zenodo ↔ GitHub

1. Go to https://zenodo.org/account/settings/github/
2. Toggle **on** for `0x-wxndy/fmsa-dt-proverif`
3. Zenodo will archive **GitHub Releases** only (not every commit)

## 4. Create release v1.0.0 on GitHub

On https://github.com/0x-wxndy/fmsa-dt-proverif/releases/new:

- **Tag:** `v1.0.0`
- **Title:** `v1.0.0 — FMSA-DT ProVerif models (paper artefact)`
- **Description:** short note that this release matches the SoSyM/FMSA-DT submission ProVerif section

Within a few minutes Zenodo creates a record and assigns a DOI like `10.5281/zenodo.1234567`.

## 5. Update metadata after DOI is minted

Edit these files with the real DOI:

| File | What to change |
|------|----------------|
| `CITATION.cff` | `doi:` and `identifiers:` block |
| `README.md` | BibTeX example + optional Zenodo badge |
| Paper `papers/paper/ref.bib` `@misc{REPO}` | Add `doi` and `url` fields |

Example `ref.bib` entry:

```bibtex
@misc{REPO,
  author       = {Your, Names and Here},
  title        = {{FMSA-DT}: {ProVerif} Models and Reproducibility Scripts},
  year         = {2026},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.1234567},
  url          = {https://doi.org/10.5281/zenodo.1234567},
  note         = {Software archive, also at \url{https://github.com/0x-wxndy/fmsa-dt-proverif}}
}
```

## 6. Optional: Zenodo badge in README

After the record exists, add near the top of `README.md`:

```markdown
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1234567.svg)](https://doi.org/10.5281/zenodo.1234567)
```

(Replace with your DOI.)

## Double-blind review note

If the journal is still anonymous:

- Keep author names as placeholders in `CITATION.cff` until acceptance, **or**
- Upload a zip to Zenodo manually as an anonymous deposit and cite that DOI during review

After acceptance, create the public GitHub release so GitHub ↔ Zenodo stays in sync for future versions.
