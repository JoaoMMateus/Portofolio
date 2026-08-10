# Diplomas

Drop the diploma files (PDF or image) for each qualification here.

These files are linked from the EDUCATION section of `index.html` and `index-mobile.html` via `./diplomas/<file>` and open in a new tab.

## Naming convention

Use lowercase, hyphen-separated names: `school-diploma-year.pdf`

Examples:

- `epsi-computer-information-systems-specialist-2019.pdf`
- `victor-hugo-sti2d-2014.pdf`

## Adding a diploma

1. Add the file to this folder following the naming convention above.
2. In both `index.html` and `index-mobile.html`, duplicate a `.diploma-item` block inside `.container-education` and update:
   - `content-second-title` -> diploma name
   - `content-date-and-location` -> `YEAR | SCHOOL | CITY`
   - `diploma-equivalence` -> qualification framework level, e.g. `Level 7 (EQF / RNCP) - former French Level I - Bac+5, Master's degree equivalent`
   - the `diploma-link` `href` -> `./diplomas/<your-file>`

## Current files

- `epsi-computer-information-systems-specialist-2019.pdf`
- `epsi-concepteur-integrateur-devops-2016.pdf`

The High School Diploma STI2D entry has no file, link, or level line yet.

## Optional description

Each entry can show a short paragraph under the date by enabling the commented `about-diploma` block in `index.html`.
