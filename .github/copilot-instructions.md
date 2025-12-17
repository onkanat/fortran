# Copilot Instructions for Fortran Learning Project

This repository is a personal knowledge base for learning Modern Fortran. Follow these guidelines to ensure consistency and correctness.

## Project Structure & Architecture
- **Flat Structure:** The project consists of standalone Fortran examples.
- **File Pairing:** Every `.f90` source file MUST have a corresponding `.md` documentation file (e.g., `example.f90` -> `example.md`).
- **Central Index:** `index.md` serves as the table of contents. All new examples must be linked there.
- **Assets:** Static assets (images, etc.) are stored in the `assets/` directory.
- **Language:**
  - **Code:** Modern Fortran (F90+).
  - **Documentation/Comments:** Turkish (Türkçe).

## Development Workflow
When creating a new example or feature:
1.  **Create Source:** Write the `.f90` file using Modern Fortran standards.
2.  **Create Documentation:** Write the `.md` file explaining:
    - Purpose of the code.
    - Compilation command (e.g., `gfortran file.f90 -o file`).
    - Execution command and expected output.
    - Key code explanations.
3.  **Update Index:** Add a link to the new `.md` file in `index.md` under the "Örnekler" section.

## Coding Standards
- **Modern Fortran:** Prioritize Modern Fortran (F90/F2003/F2008) features. Use modules, derived types, and allocatable arrays. Ensure code is compatible with the standard `gfortran` compiler.
- **Safety:** Always start programs and modules with `implicit none`.
- **Precision:** Prefer `real(kind=8)` for floating-point calculations.
- **I/O:** Use `print *` or `write(*,*)` for simple output.
- **Style:**
  - Indent code blocks (2 or 4 spaces).
  - **Naming Convention:** Use `snake_case` for variables, functions, and subroutines (e.g., `calculate_average`, `user_input`). This is the standard for this project.
  - Add comments in Turkish to explain complex logic.

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
