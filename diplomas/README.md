# Diplomas

Drop the diploma files (PDF or image) for each qualification here.

These files are linked from `diplomas.html` and `diplomas-mobile.html` via `./diplomas/<file>` and open in a new tab. The EDUCATION section of `index.html` and `index-mobile.html` lists the diplomas and links to those pages.

## Naming convention

Use lowercase, hyphen-separated names: `school-diploma-year.pdf`

Examples:

- `epsi-computer-information-systems-specialist-2019.pdf`
- `victor-hugo-sti2d-2014.pdf`

## Adding a diploma

1. Add the file to this folder following the naming convention above.
2. In both `diplomas.html` and `diplomas-mobile.html`, duplicate the `.diploma-item` block inside the group section it belongs to and update:
   - `content-second-title` -> diploma name
   - `content-date-and-location` -> `YEAR | SCHOOL | CITY`
   - the `diploma-link` `href` -> `./diplomas/<your-file>`
3. If the diploma belongs to a new level of education, copy the commented group block at the bottom of those pages instead, give it an `id`, and add a matching `li` to `nav#menu` in `diplomas.html`.

## Linking an existing entry

The three diplomas already listed have their `diploma-link` commented out because no file is present yet. Once you add the file, uncomment that block in both pages and point the `href` at it.

## Optional description

Each entry can show a short paragraph under the date by enabling the commented `about-diploma` block in `diplomas.html`.
