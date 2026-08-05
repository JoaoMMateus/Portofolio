# CV rebuild in Adobe InDesign

How to rebuild `CV-JOAO-MATEUS.pdf` in InDesign using the portfolio's own font
and layout.

**The text itself lives in [`CV-COPY.md`](./CV-COPY.md)** — paste-ready blocks for
every frame. This file is the technical setup only.

The Illustrator equivalent is [`CV-ILLUSTRATOR-GUIDE.md`](./CV-ILLUSTRATOR-GUIDE.md).
For this document InDesign is the better tool, for four reasons that all show up
below: clickable hyperlinks (section 10), paragraph rules that travel with the
heading style (section 8), a real baseline grid (section 6), and control over
text extraction order (section 12). Illustrator has none of them. Its advantages
are all on the drawing side, and this CV is two straight lines and some text.

Sections 1 to 3 are shared with the Illustrator guide.

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

Geometry, in millimetres, measured from the top-left of the page (which is how
InDesign counts):

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

Note the column widths are **unequal** — 62 mm and 102.5 mm. InDesign's document
column grid only produces equal columns, so leave Columns at 1 in the New
Document dialog and place the two frames manually (section 7).

## 2. Installing Lane Narrow on Windows

The font lives at `C:\Users\joaomart\Repos\Portofolio\fonts\lane-narrow.ttf`.

The best option here is InDesign-specific and avoids installing anything:
**create a folder named exactly `Document Fonts` next to the `.indd` file and put
the TTF inside it.** InDesign activates fonts from that folder automatically
whenever the document is open, and deactivates them when it closes. The font
travels with the project and never touches the Windows font list. This is also
the structure that File > Package produces (section 11).

If you would rather install it system-wide:

1. Right-click the TTF and choose **Install for all users** (needs an admin
   prompt). The plain "Install" option writes to the per-user profile, which
   Adobe apps have a long history of not enumerating reliably.
2. Or copy it into `C:\Program Files\Common Files\Adobe\Fonts`, which Adobe apps
   read and nothing else does.
3. Either way, quit and relaunch InDesign — it builds its font menu at startup.

In the Character panel the family appears as **Lane - Narrow** (the internal
family name, not the filename).

**Licensing is clear.** The `OS/2` table has `fsType = 0`, Installable Embedding
with no restriction, so embedding it in an exported PDF is permitted. Author is
Graham Meade.

**Glyph coverage is fine.** 221 glyphs covering 258 codepoints, including every
accent needed (`Ã Õ É Î ã ç é`), plus `• · – — ’ | & @ °`. Nothing in the copy
deck will fall back to a substitute font.

## 3. The single-weight problem

Lane Narrow is **one weight only** — `usWeightClass` 400, italic angle 0. No
bold, no italic. InDesign does **not** synthesize fake bold or italic; the style
dropdown will offer "Regular" and nothing else. (It will, at least, flag a style
you ask for and cannot supply — missing styles show highlighted in pink.)

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
3. **Fake weight with a stroke** — select the type and give it a 0.25 pt black
   stroke in the Stroke panel. Works and prints, but muddies letterforms below
   about 14 pt. Only use it on the name.

Option 1 also solves the date lines, which are `font-style: oblique` on the site
and need a real italic. If you stay single-font, InDesign has **Skew (false
italic)** in the Character panel — set it to 12 degrees. That is a genuine
InDesign feature, unlike faux bold, and it can be baked into a character style.

## 4. Document setup

**File > New > Document**, Print intent.

| Setting | Value |
| --- | --- |
| Width / Height | 210 mm / 297 mm |
| Orientation | Portrait |
| Pages | 1 |
| Facing Pages | **unchecked** |
| Primary Text Frame | **unchecked** |
| Columns | 1 |
| Margins | Top 15, Bottom 20, Left 14, Right 14 mm |
| Bleed / Slug | 0 |

Facing Pages matters: leave it on and you get left/right master spreads with
Inside/Outside margins instead of Left/Right, which is wrong for a single-sided
CV. Primary Text Frame is off because the two columns are separate frames of
different widths, not an automatic flow.

**Preferences > Units & Increments:** Ruler Units Horizontal and Vertical both
Millimeters, Text Size Points, Stroke Points.

**Edit > Transparency Blend Space:** Document RGB for a PDF that will only be
emailed and read on screen; Document CMYK if a print shop is involved.

## 5. Master page: guides and the divider

Put the guides and the vertical divider on the master so they cannot be
selected or nudged while you edit text. Double-click **A-Master** in the Pages
panel first.

**Guides.** The margins already give you 14 mm and 196 mm. Add three more by
dragging a guide off the ruler and then typing the exact value in the Control
bar's X field while it is still selected:

- x = 76 mm (left column right edge)
- x = 93.5 mm (main column left edge)
- x = 141 mm (optional, the old sub-column position)

Layout > Create Guides only makes evenly spaced sets, so it is no help with
unequal columns.

**Vertical divider** — the black rule from `index.html`, and the one element the
old PDF lacks. Line tool, Shift-drag a rough vertical, then set it numerically in
the Control bar with the reference point at top-left: X = 85 mm, Y = 15 mm,
length 267 mm, angle 90 degrees. Stroke 2 pt, Black, butt cap.

Back on the document page the divider is locked away as a master item. If you
ever need to edit it there, Ctrl+Shift-click to override.

## 6. Baseline grid

This is the thing Illustrator cannot do, and it is what keeps the two columns'
baselines aligned across the gutter.

**Edit > Preferences > Grids:**

- Start: **17.6 mm**
- Relative To: **Top of Page**
- Increment Every: **13.5 pt**
- View Threshold: 75%

The increment must equal the body leading (13.5 pt, section 8) or text will skip
grid lines. Show it with View > Grids & Guides > Show Baseline Grid
(Ctrl+Alt+apostrophe).

Then in the `body` and `bullet` paragraph styles, set Indents and Spacing >
**Align to Grid: All Lines**.

Leave headings on **Align to Grid: None**. Snapping a 14 pt heading to a 13.5 pt
grid forces it down a whole line and opens ugly gaps. Instead give headings Space
Before and Space After in multiples of 13.5 pt (for example 13.5 pt before,
6.75 pt after) so the body text underneath lands back on the grid.

## 7. Text frames

Two frames, one per column. Type tool, drag, then set the exact geometry in the
Control bar with the top-left reference point:

| Frame | X | Y | W | H |
| --- | --- | --- | --- | --- |
| Left column | 14 mm | 15 mm | 62 mm | 262 mm |
| Main column | 93.5 mm | 15 mm | 102.5 mm | 262 mm |

For each, Object > Text Frame Options (Ctrl+B): Columns 1, Inset Spacing 0 on all
sides, Vertical Justification Top, First Baseline Offset **Leading**.

Unlike Illustrator, you do not need a frame per section. Paste all of the
left-column copy into the first frame and all of the main-column copy into the
second, and let the paragraph styles' Space Before and Space After do the
spacing. Everything reflows automatically when you edit.

Set the left frame's paragraphs to **Align Right**, matching both the old PDF and
the right-aligned left column in `index.html`. It reads acceptably at 62 mm — the
old CV proves it — but if the ragged left edge looks wrong once the longer About
Me text is in, Align Left is the more readable choice.

If the main column overflows, the out port at the bottom right shows a red `+`.
Either cut copy (the copy deck has a shorter About Me and a collapsed-internships
variant for exactly this) or click the port and draw a second frame on a new page
to thread into.

## 8. Paragraph styles

Build these in Window > Styles > Paragraph Styles. Names mirror the CSS classes
in `css/custom-body.css` so the two stay in sync.

| Style | Setting | CSS equivalent |
| --- | --- | --- |
| `name` | Lane - Narrow, 24 pt / 26 pt, tracking 20, align right | `#PrenomTitre`, `#NomTitre` |
| `role` | 11 pt / 13.5 pt, tracking 80, Case: All Caps | (new — the site has no job-title line) |
| `section-title` | 14 pt, tracking 40, All Caps, rule below | `.content-title` |
| `company` | 14 pt, Space Before 4 mm, Keep with Next 2 lines | `.content-under-title` |
| `date-location` | 10 pt, skew 12 degrees or real italic | `.content-date-and-location` |
| `body` | 10.5 pt / 13.5 pt, Align to Grid: All Lines | `.content-text` |
| `bullet` | 10.5 pt / 13.5 pt, auto bullet, hanging indent 3 mm | — |

The old PDF sets 12 pt body on roughly 10 pt leading — negative leading, tighter
than the type size. It works because the font is condensed, but it is cramped.
10.5 pt on 13.5 pt gives the page air and makes room for the richer content from
`index.html`.

### 8.1 Section underlines as paragraph rules

The `.under-line` rules on the site become a property of the heading style rather
than separate drawn objects, so they move with the text automatically. In the
`section-title` style, open **Paragraph Rules**:

- Rule Below: on
- Weight: 1.5 pt, Colour: Black
- Width: **Column**
- Offset: 1.5 mm

Then shorten the rule to about 10 mm with an indent. Do not translate the CSS
`width: 5%` literally — 5% of a 102 mm column is 5 mm, which reads as a stray
tick on paper.

- **Main column** (102.5 mm wide, rule flush left): Right Indent = **92.5 mm**
- **Left column** (62 mm wide, rule flush right): Left Indent = **52 mm**

That needs two styles. Make `section-title` for the main column, then create
`section-title-right` with **Based On: section-title**, overriding only the
alignment and the rule indent. Change the parent later and both update.

### 8.2 Automatic bullets

In the `bullet` style, Bullets and Numbering: List Type **Bullets**, bullet
character `•`, Text After `^t`, then Indents and Spacing with Left Indent 3 mm
and First Line Indent -3 mm. Also set Keep Options > Keep Lines Together > All
Lines in Paragraph so a bullet never splits across a column break.

Because the bullets are now automatic, **strip the literal `• ` from the copy
deck when pasting**. Fastest way: paste everything, then Edit > Find/Change >
GREP tab, Find `^• `, Change to empty, Search: Document.

### 8.3 Next Style

Set `company` → Next Style `date-location` → Next Style `bullet` → Next Style
`bullet`.

Then select a whole pasted job entry, right-click `company` in the Paragraph
Styles panel and choose **"Apply 'company' then Next Style"**. The company name,
date line and every bullet get styled in one action. With five roles in the copy
deck this saves a lot of clicking, and it is InDesign-only.

## 9. Tabs with leaders for the languages block

The copy deck writes the languages as `PORTUGUESE | Native`. InDesign can do
better: replace the pipe with a tab and get a dot leader.

Type > Tabs (Ctrl+Shift+T), set a **right-aligned tab at 62 mm** and type `.` in
the Leader field (or `. ` with a trailing space for airier dots). Put those tab
settings into the paragraph style's Tabs pane so they apply automatically.

Result: `PORTUGUESE ...................... Native`, flush to both edges of the
column. Use the same trick for the certifications lines if you keep them.

## 10. Hyperlinks

The main practical reason to use InDesign for this document.

Window > Interactive > **Hyperlinks**. Select the text, then panel menu > New
Hyperlink:

| Text | Link To | Destination |
| --- | --- | --- |
| `joao.martinsmateus@outlook.com` | Email | `joao.martinsmateus@outlook.com` |
| `linkedin.com/in/joao-martins-mateus` | URL | `https://www.linkedin.com/in/joao-martins-mateus/` |
| `github.com/JoaoMMateus` | URL | `https://github.com/JoaoMMateus` |
| `PT +351 912 773 755` | URL | `tel:+351912773755` |

Two settings to change in the New Hyperlink dialog, both of which default badly:

- **Character Style: [None].** It defaults to a style called `Hyperlink` that
  makes the text blue and underlined. That looks wrong on a CV.
- **Type: Invisible Rectangle**, Highlight: None. Otherwise a visible box can
  print around the link.

**The export gotcha:** in Export Adobe PDF (Print), General tab, Include section,
you must tick **Hyperlinks**. It is off by default in the print presets, and if
you miss it the links are silently discarded.

## 11. Preflight and packaging

**Preflight** is live — the dot in the bottom-left status bar, or Window > Output
> Preflight. The default `[Basic]` profile catches missing fonts, missing links
and, most usefully, **overset text**. InDesign tells you outright when the copy
does not fit; Illustrator's equivalent is a small red plus that is easy to miss.

**File > Package** collects the `.indd`, a `Document Fonts` folder, any links and
a report into a single folder. Worth doing once the CV is final: Lane Narrow is a
free download that may not still be online in a few years, and this guarantees
the document stays reproducible. Note that packaging copies the font file itself
— fine for your own archive, but check the licence before sending a package to
anyone else. The `fsType = 0` flag covers embedding in a PDF, which is a
different question from redistributing the TTF.

## 12. Reading order for ATS

Two-column layouts are routinely garbled by applicant tracking systems, which
parse PDFs linearly and interleave the columns. InDesign can improve the odds;
Illustrator offers nothing at all here.

Window > **Articles**. Drag the two text frames into an article in the order you
want them read — left column first (name, about, contact, languages), then the
main column (experience, education, skills). Turn on **Use for Reading Order in
Tagged PDF** in the panel menu, and tick **Create Tagged PDF** on export.

Text extraction then follows the article order instead of a geometric guess.

Be realistic about the limits: plenty of ATS strip tags and re-extract naively,
so this improves the odds rather than guaranteeing anything. Still keep a plain
single-column Word version for company portals, and use this designed PDF for
humans and direct emails.

## 13. Export

File > Export (Ctrl+E), format **Adobe PDF (Print)**, preset
**[High Quality Print]**.

**General tab**

- Pages: All, **Export As: Pages** (not Spreads)
- Include: **Hyperlinks** ✓, **Create Tagged PDF** ✓
- Include: Bookmarks ✗, Non-Printing Objects ✗, Visible Guides and Baseline Grids ✗
- Interactive Elements: Do Not Include

**Marks and Bleeds:** nothing ticked, bleed 0.

**Output:** No Colour Conversion for an RGB email PDF; Convert to Destination if
you set the document up for CMYK print.

**Advanced:** Subset fonts when percent of characters used is less than **100%**.

**Never convert the text to outlines** (Type > Create Outlines). Outlined text
becomes vector shapes — the email address cannot be copied and no parser can read
a word. It is the most common way a designed CV gets ruined.

Verify afterwards:

- Ctrl+F in the exported PDF for a word from the body. Found means the text is
  live.
- File > Properties > Fonts should list "Lane - Narrow (Embedded Subset)".
- Click the email and LinkedIn entries to confirm the links survived.

## 14. A Letter-size version

A4 is correct for Portugal and France. For US applications, use **Layout > Create
Alternate Layout**, set the page size to Letter (216 x 279 mm) and pick a Liquid
Page Rule. Both layouts live in one file, and the text can be linked so edits to
the A4 version propagate.

Do not simply scale the A4 page — that changes every type size.

## 15. If you can find the original .indd

The old CV was made in InDesign 15 (CC 2020) on a Mac. If that source file still
exists anywhere, it beats rebuilding: open it, use **Type > Find/Replace Font**
to swap Avenir Next Condensed for Lane Narrow across the whole document, then
replace the copy from the copy deck. You inherit the frame positions, the styles
and the paragraph rules for free.

A newer InDesign opens an older file without trouble. The reverse is not true, so
if you save it in a current version, keep a copy of the original.
