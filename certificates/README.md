# Certificates

Drop the "certificate of completion" files (PDF or image) for each certification here.

These files are linked from `certifications.html` and `certifications-mobile.html` via `./certificates/<file>` and open in a new tab. The CERTIFICATIONS section of `index.html` and `index-mobile.html` shows a short selection and links to those pages.

## Naming convention

Use lowercase, hyphen-separated names: `issuer-certification-year.pdf`

Examples:

- `microsoft-azure-fundamentals-2024.pdf`
- `coursera-machine-learning-2023.pdf`

## Adding a certification

1. Add the certificate file to this folder following the naming convention above.
2. In both `certifications.html` and `certifications-mobile.html`, duplicate the `.certification-item` block inside the group section it belongs to and update:
   - `content-second-title` -> certification name
   - `content-date-and-location` -> `YEAR | ISSUER`
   - the `certificate-link` `href` -> `./certificates/<your-file>`
3. If the certification belongs to a new technology, copy the commented group block at the bottom of those pages instead, give it an `id`, and add a matching `li` to `nav#menu` in `certifications.html`.

## Language tests

Language certifications live in the LANGUAGES group of the certifications pages. The score report is also linked from the matching flag tile in SKILLS > LANGUAGES on `index.html` and `index-mobile.html`, so both places need updating when a new one is added or retaken.
