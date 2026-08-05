# Portofolio

Personal portfolio website for João Martins Mateus. A static single-page site (About, Education, Experience, Skills, Extracurricular Activities, Projects) served by a small Node.js HTTP server, with a separate mobile layout.

## Tech stack

- **Node.js** – minimal HTTP server (`app-start.js`) using the built-in `http`, `url`, and `fs` modules
- **HTML / CSS / JavaScript** – static front-end
- **Bootstrap** + **jQuery** – layout and interactions (bundled locally under `css/` and `js/`)
- **Font Awesome** – icons
- **device-detector-js** – dependency intended for desktop/mobile detection (currently commented out)
- **JSON data files** – editable content under `data/`, fetched by the pages at load time

## How it works

`app-start.js` starts an HTTP server on `http://localhost:8080` and routes by path:

- `/` → `index.html` (desktop layout)
- `/m` → `index-mobile.html` (mobile layout)
- any other path → the matching file on disk, or `404 Not Found`

Device-based auto-routing (serving the mobile page to phones/tablets) is scaffolded with `device-detector-js` but currently commented out, so the mobile page is reached manually via `/m`.

Parts of the page content live outside the HTML, in the `data/` folder. These files are plain JSON served like any other asset and read by the front-end at load time, so updating them takes effect on the next page refresh without editing the markup or restarting the server. Today this covers the footer contact details (`data/contact.json`, documented under [Contact details](#contact-details)).

## Project structure

```
Portofolio/
├── app-start.js          # Node HTTP server + routing
├── index.html            # Desktop portfolio page (main content)
├── index-mobile.html     # Mobile layout (work in progress / placeholder text)
├── certifications.html   # Desktop sub-page listing every certification by group
├── certifications-mobile.html # Mobile version of the certifications sub-page
├── certificates/         # Certificate files linked from the certifications pages
├── diplomas/             # Diploma files linked from the EDUCATION section of the index pages
├── package.json          # npm metadata and dependencies
├── css/                  # Bootstrap, Font Awesome, and custom styles
│   ├── custom-body.css
│   ├── mobile-custom-body.css
│   ├── custom-footer.css
│   └── bootstrap*, font-awesome*
├── data/                 # Content edited without touching the HTML
│   └── contact.json      # Footer contact details (see "Contact details" below)
├── js/                   # jQuery, Bootstrap, and page scripts
│   ├── jquery-3.4.1.min.js
│   ├── bootstrap*.js
│   ├── image-lightbox.js
│   └── footer-contact.js # Renders the footer from data/contact.json
├── images/               # Logos, flags, project and experience images
└── tests/                # Bash HTTP test suite (see "Tests" below)
    ├── run.sh            # Runner: starts the server and runs every case
    ├── lib.sh            # Shared helpers + server lifecycle
    └── cases/            # One script per test (runnable individually)
```

## Run locally

```bash
npm install
node app-start.js
```

Then open `http://localhost:8080/` (desktop) or `http://localhost:8080/m` (mobile).

## Contact details

The footer links are not hard-coded in the pages. `js/footer-contact.js` fetches `data/contact.json` at page load and builds the list for both layouts, so changing an address or a profile means editing that one file and reloading — no HTML change, no restart.

```json
{
  "email": "you@example.com",
  "phone": "+33600000000",
  "phoneDisplay": "06 00 00 00 00",
  "links": [
    { "icon": "fa-github-square", "label": "GitHub", "href": "https://github.com/you", "newTab": true },
    { "icon": "fa-phone-square", "label": "{phoneDisplay}", "href": "tel:{phone}", "showLabel": "always" }
  ]
}
```

- Top-level string fields are reusable placeholders: `{email}`, `{phone}`, `{phoneDisplay}` are substituted into any `href` or `label`.
- Each entry in `links` accepts `icon` (Font Awesome class), `label`, `href`, plus optional `class`, `newTab`, `target`, and `showLabel`.
- Only `http:`, `https:`, `mailto:`, `tel:`, and `sms:` links are rendered; anything else is skipped.
- The desktop footer shows every label; the mobile footer shows icons only (the label becomes the `aria-label`) except for entries with `"showLabel": "always"`. This is driven by the `data-contacts-labels` attribute on the footer `<ul>`.

Because the data is fetched over HTTP, the pages must be opened through the server rather than as `file://`.

## Tests

The `tests/` folder holds a dependency-free Bash + `curl` suite that exercises the server over HTTP. It covers baseline behaviour, the security fixes in `app-start.js` (path traversal, MIME types), and a set of hardening checks. It requires only `node` and `curl`.

### Layout

```
tests/
├── run.sh            # Main runner: starts app-start.js once, runs every case,
│                     #   restarts the server if a case crashes it, prints a summary
├── lib.sh            # Shared helpers (assertions, HTTP/header utilities,
│                     #   server start/stop) sourced by the runner and every case
└── cases/            # One self-contained script per test
    ├── 01_routing.sh          # /, /m, /index.html resolve correctly
    ├── 02_path_traversal.sh   # classic + encoded ../ blocked, /etc/passwd not leaked
    ├── 03_content_types.sh    # correct Content-Type per extension + nosniff header
    ├── 04_file_disclosure.sh  # files outside the web root are never served
    ├── 05_directory_errors.sh # directory / missing-file requests return 404
    ├── 06_symlink_escape.sh   # symlink inside root pointing outside must be blocked
    ├── 07_double_encoding.sh  # %252e.. double-encoding does not become traversal
    ├── 08_null_byte.sh        # %00 must not crash the server (DoS)
    ├── 09_alt_traversal.sh    # ..%2f, ..%5c, ....//, //etc/passwd stay confined
    ├── 10_http_methods.sh     # HEAD has no body; POST/PUT/DELETE/OPTIONS → 405
    ├── 11_xss_reflection.sh   # error pages never reflect the request path
    ├── 12_hardening_headers.sh# CSP / X-Frame-Options / Referrer / Permissions present
    └── 13_info_leak.sh        # no X-Powered-By / revealing Server header
```

### Running

```bash
./tests/run.sh                 # run the whole suite
./tests/cases/02_path_traversal.sh   # run a single test on its own
```

`run.sh` starts the server itself, so you do **not** need it already running. Each case script is also independently runnable: if no server is answering it starts one and tears it down on exit. The runner exits non-zero if any assertion fails, so it works in CI.

### Interpreting results

Each check prints `PASS`/`FAIL` and the runner ends with an aggregate count. Tests assert the *desired secure behaviour*, so a `FAIL` is an actionable finding rather than a broken test. Cases `01`–`05`, `07`, `09`, `11`, and `13` pass against the current server. The remaining cases document known gaps: `06_symlink_escape` and `08_null_byte` are real vulnerabilities (symlink escape via the lexical path guard, and a null-byte crash), while `10_http_methods` and `12_hardening_headers` are defense-in-depth TODOs.

> Note: the scripts must use LF line endings (a CRLF shebang breaks under Bash/WSL).
