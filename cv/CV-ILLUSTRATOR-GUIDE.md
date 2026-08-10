# CV rebuild in Adobe Illustrator

How to rebuild `CV-JOAO-MATEUS.pdf` in Illustrator using the portfolio's own font
and layout.

**The text itself lives in [`CV-COPY.md`](./CV-COPY.md)** — paste-ready blocks for
every frame. This file is the technical setup only.

If you have InDesign, read [`CV-INDESIGN-GUIDE.md`](./CV-INDESIGN-GUIDE.md)
first: for a document that is almost entirely text in two columns, it is the
better-suited tool, mainly because Illustrator cannot produce clickable
hyperlinks. Sections 1 and 2 below apply to both and are repeated there.

Reference sources:

- `index.html` + `css/custom-body.css` — the layout and type hierarchy being matched
- `fonts/lane-narrow.ttf` — the font used on the site
- `CV-JOAO-MATEUS.pdf` (the 2019-era CV) — the source of the page geometry below

---

## 1. What the old PDF measures

The existing CV is A4, 595.276 x 841.89 pt, produced in Adobe InDesign 15 on
macOS, set in **Avenir Next Condensed** (UltraLight, Regular, DemiBold, DemiBold
Italic) at 24 / 14 / 12 / 10 pt.

Its structure is already the one to keep: a narrow right-aligned left column for
ABOUT ME and CONTACT, and a wide main column on the right for EDUCATION, SKILLS,
LANGUAGE, EXPERIENCE and EXTRACURRICULAR. That matches the two-column split in
`index.html`, so this is a re-typesetting rather than a redesign.

Geometry, converted to millimetres and to Illustrator's top-down Y axis:

| Element | Position |
| --- | --- |
| Page | 210 x 297 mm (A4) |
| Left / right margins | 14 mm |
| Left column | x = 14 mm to 76 mm (62 mm wide, text right-aligned) |
| Gutter | 76 mm to 93.5 mm (17.5 mm) |
| Main column | x = 93.5 mm to 196 mm (102.5 mm wide) |
| Sub-column inside main column | x = 141 mm (LANGUAGE sat beside the skills list) |
| First baseline | 17.6 mm from top |
| Last baseline | 277 mm from top |

The left column's right edge of 76 mm is derived from the line-start positions of
the right-aligned text, so it is accurate to about a millimetre. Everything else
is read directly from the file.

Illustrator measures Y **downward from the top-left** of the artboard; PDF
coordinates run **upward from the bottom-left**. The values above are already
converted. If measuring the old PDF again: `Y_illustrator = 297mm - Y_pdf`.

## 2. Installing Lane Narrow on Windows

The font lives at `C:\Users\joaomart\Repos\Portofolio\fonts\lane-narrow.ttf`.

1. Right-click it and choose **Install for all users** (needs an admin prompt).
   The plain "Install" option writes to the per-user profile, which Adobe apps
   have a long history of not enumerating reliably.
2. Alternative that leaves the Windows font list untouched: copy the TTF into
   `C:\Program Files\Common Files\Adobe\Fonts`. Adobe apps read that folder and
   nothing else does.
3. Quit and relaunch Illustrator. It builds its font menu at startup and will
   not notice a font installed while it is running.
4. In the Character panel the family appears as **Lane - Narrow** (that is the
   internal family name, not the filename).

**Licensing is clear.** The `OS/2` table has `fsType = 0`, Installable Embedding
with no restriction, so embedding it in an exported PDF is permitted. Author is
Graham Meade.

**Glyph coverage is fine.** 221 glyphs covering 258 codepoints, including every
accent needed (`Ã Õ É Î ã ç é`), plus `• · – — ’ | & @ °`. Nothing in the copy
deck will fall back to a substitute font.

## 3. The single-weight problem

Lane Narrow is **one weight only** — `usWeightClass` 400, italic angle 0. No
bold, no italic. Illustrator, unlike Word, does **not** synthesize fake bold or
italic; the style dropdown will offer "Regular" and nothing else.

The old CV builds its entire hierarchy out of weight contrast (UltraLight body,
DemiBold headings, DemiBold Italic dates). None of that is available. Three ways
forward, best first:

1. **Pair it.** Lane Narrow for the name, section titles and company names; a
   condensed family with real weights for body copy and date lines. **Acumin Pro
   Condensed** or **Acumin Pro SemiCondensed** come free with Creative Cloud via
   Adobe Fonts and are a close match for Avenir Next Condensed. Free
   alternatives: Barlow Semi Condensed, Archivo Narrow, Roboto Condensed.
2. **Hierarchy without weight** — all caps plus generous tracking for headings,
   size steps for everything else. Workable, but the page reads flatter.
3. **Fake weight with a stroke** — select the type and add a 0.25 pt black stroke
   in the Appearance panel. Works and prints, but muddies letterforms below about
   14 pt. Only use it on the name.

This also affects the date lines, which are `font-style: oblique` on the site.
Illustrator cannot oblique Lane Narrow either — shear manually via
Object > Transform > Shear at 12 degrees, or use the paired font's real italic.

## 4. Document setup

**New document:** Print tab, A4 preset, 1 artboard, units Millimeters, bleed 0
(nothing runs off the edge). Colour mode RGB if the PDF will only be emailed and
read on screen; CMYK only if a print shop is involved. Raster Effects 300 ppi.
**Uncheck "Align New Objects to Pixel Grid"** — it is a web setting and it will
nudge hairline rules off their coordinates.

**Preferences:** Edit > Preferences > Units, General = Millimeters, Type =
Points. Position frames in mm, size type in pt. Ctrl+R shows rulers.

**Guides:** with the Line Segment tool draw verticals at x = 14, 76, 93.5, 141
and 196 mm, and horizontals at y = 15 and 277 mm. Set each position numerically
in the Transform panel rather than dragging by eye — for a vertical, W = 0,
H = 262 mm, X = the value, Y = 15 mm. Select all of them, Ctrl+5 to convert to
guides, Ctrl+Alt+; to lock.

**Layers:** `guides` (locked), `divider`, `left column`, `right column`. Stops
the rule getting dragged while editing text.

## 5. Using the old PDF as a reference, not as a starting point

Do **not** open the old PDF and edit it into the new one. InDesign exported each
line as a separate placed run — 77 individual text placements for roughly 70
lines — so it arrives in Illustrator as dozens of disconnected one-line frames
with no reflow. Editing one sentence means repositioning every line after it. On
top of that, Avenir Next Condensed is not installed locally and the PDF carries
only subsets of it, so Illustrator will substitute and the line breaks will
scramble regardless.

Use it as a tracing layer instead: File > Place, uncheck Link so it embeds, put
it on a layer named `reference`, set the layer to 30% opacity, lock it. Draw the
guides over it, confirm they land where expected, then hide or delete the layer
before export.

To read exact numbers off the original, File > Open it as a **separate**
document, click a text frame, and read X/Y/W/H from the Transform panel.

## 6. Text frames

Use the Type tool and **drag a rectangle** for each frame. Clicking creates point
type, which never wraps; dragging creates area type, which wraps and can be
resized.

- Left column frame: x = 14 mm to 76 mm
- Main column frame: x = 93.5 mm to 196 mm

Set the left column to **Align Right**, matching both the old PDF and the
right-aligned left column in `index.html`. It reads acceptably at 62 mm — the old
CV proves it — but if the ragged left edge looks wrong once the longer About Me
text is in, Align Left is the more readable choice.

## 7. Type styles

Build these as paragraph styles (Window > Type > Paragraph Styles) so sizes stay
consistent through editing. Names mirror the CSS classes in
`css/custom-body.css` so the two stay in sync.

| Style | Setting | CSS equivalent |
| --- | --- | --- |
| `name` | Lane - Narrow, 24 pt / 26 pt leading, tracking +20 | `#PrenomTitre`, `#NomTitre` |
| `role` | 11 pt, tracking +80, all caps | (new — the site has no job-title line) |
| `section-title` | 14 pt, tracking +40, all caps | `.content-title` |
| `company` | 14 pt | `.content-under-title` |
| `date-location` | 10 pt, sheared 12 degrees or real italic | `.content-date-and-location` |
| `body` | 10.5 pt / 13.5 pt leading | `.content-text` |
| `bullet` | 10.5 pt / 13.5 pt, hanging indent 3 mm | — |

The old PDF sets 12 pt body on roughly 10 pt leading — negative leading, tighter
than the type size. It works because the font is condensed, but it is cramped.
10.5 pt on 13.5 pt gives the page air and makes room for the richer content from
`index.html`. Illustrator defaults leading to Auto (120%); set explicit numbers.

Illustrator has no baseline grid, but it can be faked: Preferences > Guides &
Grid, gridline every 13.5 pt with 1 subdivision, then View > Show Grid and
Snap to Grid (Shift+Ctrl+"). Keeps both columns' baselines aligned across the
gutter.

Bullets are not automatic in Illustrator — the `•` characters are typed literally
in the copy deck, so paste those blocks as they are.

## 8. Rules and the divider

**Section underlines** (`.under-line` on the site): Line Segment tool,
Shift-drag for horizontal, 1.5–2 pt black stroke, butt cap, left edge flush with
the column. Do not translate the CSS `width: 5%` literally — 5% of a 102 mm
column is 5 mm, which reads as a stray tick on paper. Use **10 mm**. Make one and
copy it, or save it as a Graphic Style so the stroke weight cannot drift.

These are separate objects, not part of the heading style, so they have to be
repositioned by hand whenever the text above them reflows. With nine section
headings that adds up — it is one of the reasons InDesign suits this document
better (see the InDesign guide, section 8).

**Vertical divider** (the black rule from `index.html`, the one element the old
PDF lacks): Transform panel with W = 0, H = 267 mm, X = 85 mm, Y = 15 mm, stroke
2 pt black. It sits mid-gutter and is what makes the printed CV read as the same
design as the site.

## 9. Export

File > Save As, format Adobe PDF, preset **[High Quality Print]**.

- **Uncheck "Preserve Illustrator Editing Capabilities."** Roughly halves the
  file size and stops the PDF carrying a full copy of the working file.
- Compatibility Acrobat 5 (PDF 1.4) or newer.
- Marks and Bleeds: nothing checked, bleed 0.
- Fonts: set "Subset fonts when percent of characters used is less than" to
  **100%**.
- **Never run Type > Create Outlines first.** Outlined text becomes vector
  shapes — the email address cannot be copied and no parser can read a word.
  This is the most common way a designed CV gets ruined.

Verify afterwards: open the PDF, Ctrl+F for a word from the body. If it is found,
the text is live. File > Properties > Fonts should list
"Lane - Narrow (Embedded Subset)".

## 10. Two limitations to plan around

**Illustrator cannot create clickable hyperlinks.** The email, LinkedIn and
GitHub entries will be plain text. Options: accept it; add links afterwards in
Acrobat Pro (Tools > Edit PDF > Link > Add/Edit Web or Document Link); or do the
final assembly in InDesign, which supports hyperlinks natively and is what the
old CV was built in.

**A4 is correct for Portugal and France.** For US applications, duplicate the
artboard as Letter (216 x 279 mm) rather than scaling the A4 one — scaling
changes the type sizes.

## 11. ATS caveat

Two-column layouts are routinely garbled by applicant tracking systems, which
parse PDFs linearly and interleave the columns. Illustrator gives you no control
over the extraction order at all. Keep this designed PDF for humans and direct
emails, and maintain a plain single-column Word version for company portals.

InDesign can mitigate this with the Articles panel and a tagged PDF export — see
the InDesign guide, section 12.
