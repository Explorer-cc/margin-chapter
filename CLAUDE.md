# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A LaTeX styling project for Chinese documents, building custom chapter/section heading formats with TikZ graphics, margin indicators, two-column layouts, and breakable tcolorbox containers. The project targets the `ctexbook` document class with XeLaTeX.

## Build Commands

Compile any `.tex` file (requires two passes for cross-references):

```bash
xelatex <file>.tex
xelatex <file>.tex
```

For files using `ltproperty` (margin indicators in `main.tex` and `tests/03-margin-box/`), a **third pass** is needed to resolve the recorded property data.

To compile a specific test:
```bash
cd tests/05-ctex-format && xelatex mwe.tex
```

## Architecture

### Test-Driven Development Model

Each feature lives in its own test directory under `tests/` as a self-contained Minimal Working Example (`mwe.tex`). Features are developed and verified in isolation, then composed together. The `tests/05-ctex-format/mwe.tex` is the most comprehensive test, integrating multiple features.

Test directories by feature:
- `01-box_enumitem` - Breakable tcolorbox with custom tcbskin, squared enumerate labels
- `02-chapter_twocolumn` - Two-column layout via multicol, with chapter triggering new pages
- `03-margin-box` - Page-margin chapter indicator using TikZ matrix + `ltproperty` for dynamic chapter count
- `04-fancyhdr-setting` - Header/footer styling with fancyhdr
- `05-ctex-format` - Full ctex heading design: chapter (nuclear atom motif), section (rounded badge), subsection, SectionPart
- `nuclear-logo` - Standalone TikZ atom/orbit pic definition
- `double-path` - Standalone TikZ double-line path technique

### Key Technologies

- **LaTeX3 ExplSyntax** (`\ExplSyntaxOn`) for programmatic logic (property recording, dynamic iteration)
- **TikZ** with libraries: `matrix`, `shapes.geometric`, `shadows`, `positioning`, `backgrounds`
- **ctex** `\ctexset` with custom `titleformat` commands for heading styling
- **ltproperty** (`\property_new:nnnn`, `\property_record:nn`) for cross-pass data persistence (chapter count)
- **tcolorbox** with `tcbskin` for breakable boxes with custom frame code
- **fancyhdr** for page headers

### Composition Pattern

The `tests/05-ctex-format/mwe.tex` demonstrates the intended composition: it defines `\chaptertitleformat`, `\sectiontitleformat`, `\subsectiontitleformat`, and `\SectionPart` as TikZ-based commands, then wires them into ctex via `\ctexset{ chapter/titleformat=\chaptertitleformat, ... }`.

## Conventions

- Test files are always named `mwe.tex` (Minimal Working Example)
- All code comments and the To-Do list are in Chinese
- TikZ styles use `pic` definitions for reusable graphic elements (e.g., `orbit`, `atom`, `nuclear`)
- The project references specific tex.stackexchange.com answers inline in comments
- Fontset is `fandol` for portability across systems
