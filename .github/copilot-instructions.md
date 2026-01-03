# Copilot Instructions for Fortran Learning Project

This repository is a personal knowledge base for learning Modern Fortran. Follow these guidelines to ensure consistency and correctness. All code and docs are in Turkish.

## Project Structure & Architecture
- **Flat Structure:** The project consists of standalone Modern Fortran examples.
- **File Pairing:** Every `.f90` source file MUST have a corresponding `.md` documentation file (e.g., `example.f90` -> `example.md`).
- **Central Index:** `index.md` is the TOC. Add new links under the relevant section (e.g., Diziler, Dosya G/Ç, P1/P2, Metin işleme, Fonksiyonlar).
- **Assets:** Static assets (images, etc.) live in `assets/`.
- **Runs:** Optional outputs/logs may live under `runs/` when needed.
- **Language:**
  - **Code:** Modern Fortran (F90+).
  - **Documentation/Comments:** Turkish (Türkçe).

## Development Workflow
When creating a new example or feature:
1.  **Create Source:** Write the `.f90` file using Modern Fortran standards. Start with `implicit none`, prefer `real(kind=8)`, and use `snake_case` identifiers. For file I/O, prefer `newunit=` + `iostat/iomsg` patterns.
2.  **Create Documentation:** Write the `.md` file (Turkish) explaining:
  - Purpose of the code.
  - Compilation command (e.g., `gfortran file.f90 -o file`).
  - Execution command and expected output.
  - Key code explanations.
3.  **Update Index:** Add the `.md` link under the relevant heading in `index.md` (e.g., Diziler, Dosya G/Ç, Metin işleme, P1/P2). Include the `.f90` link in parentheses when applicable plus a short description.

## Coding Standards
- **Modern Fortran:** Prioritize F90/F2003/F2008 features. Use modules, derived types, allocatable arrays; keep compatibility with stock `gfortran`.
- **Safety:** Always start programs and modules with `implicit none`.
- **Precision:** Prefer `real(kind=8)` for floating-point calculations.
- **I/O:** Use `print *` or `write(*,*)` for simple output; for files prefer `open(newunit=..., iostat=..., iomsg=...)` and check status.
- **Style:**
  - Indent code blocks (2 or 4 spaces).
  - **Naming Convention:** Use `snake_case` for variables, functions, and subroutines (e.g., `calculate_average`, `user_input`).
  - Comments must be in Turkish, especially for non-trivial logic.

## Build & Run
- **Compiler:** `gfortran` (GCC).
- **Standard Build Command:**
  ```bash
  gfortran <filename>.f90 -o <filename_without_extension>
  ```
- **Run Command:**
  ```bash
  ./<filename_without_extension>
  ```

## Example Pattern
**Source (`demo.f90`):**
```fortran
program demo
  implicit none
  real(kind=8) :: value
  ! ... logic ...
end program demo
```

**Documentation (`demo.md`):**
```markdown
# Demo Programı
Bu program ... gösterir.

## Derleme ve Çalıştırma
```sh
gfortran demo.f90 -o demo
./demo
```
```
