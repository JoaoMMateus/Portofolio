# CV copy deck

The finished text for the CV, paste-ready. Application-independent — used by both
`CV-ILLUSTRATOR-GUIDE.md` and `CV-INDESIGN-GUIDE.md`. Edit here, not in the
guides.

Each fenced block goes into one text frame. Blank lines are paragraph breaks;
keep them or delete them to taste. Style names in backticks refer to the
paragraph styles defined in whichever guide you are following.

Condensed from `index.html`, with the stale content and typos of the 2019
`CV-JOAO-MATEUS.pdf` corrected — see section 10.

---

## 1. Name block — left column, top

```
JOÃO
MARTINS MATEUS
SOFTWARE ENGINEER
```

`JOÃO` and `MARTINS MATEUS` use the `name` style, `SOFTWARE ENGINEER` uses
`role`.

## 2. ABOUT ME — left column

Trimmed from three paragraphs on the site to roughly five lines at 62 mm.

```
ABOUT ME
```

```
Computer science professional with a master’s degree and around six years at Nokia in Lisbon, from internship to software engineer.

My work spans development and production alike: building features, fixing bugs, and supporting Docker and Kubernetes deployments on live systems.

I use AI development tools daily to move faster on routine work and to debug code and CI/CD pipelines, reviewing what they produce before it reaches a codebase.

I adapt quickly to new environments, work well under pressure, and learn fast.
```

Shorter variant if the column runs long:

```
Computer science professional with a master’s degree and around six years at Nokia in Lisbon, from internship to software engineer. My work spans development and production alike: building features, fixing bugs, and supporting Docker and Kubernetes deployments on live systems. I use AI development tools daily to move faster on routine work and to debug code and CI/CD pipelines. I adapt quickly, work well under pressure, and learn fast.
```

The "My qualities: organized, determined, flexible..." line from the site and the
old PDF is deliberately dropped. Adjective lists carry no information for a
reader and cost four lines in the narrowest column on the page.

## 3. CONTACT — left column

```
CONTACT
```

```
Lisbon, Portugal
PT +351 912 773 755
FR +33 6 95 59 16 72
joao.martinsmateus@outlook.com
linkedin.com/in/joao-martins-mateus
github.com/JoaoMMateus
```

The PT number comes from `data/contact.json`. The FR number comes from the old
PDF and needs checking — see section 10. Drop the FR line entirely if it is no
longer live.

Deliberately omitted from `data/contact.json`: the SMS link (meaningless on
paper) and the Microsoft Learn profile (weak signal, costs a line).

## 4. LANGUAGES — left column

The old PDF put this in the main column at x = 141 mm beside the skills. Either
position works; the left column keeps the main column clear for experience.

```
LANGUAGES
```

```
PORTUGUESE | Native
FRENCH | Native
ENGLISH | Working knowledge
SPANISH | Conversational
```

Note the separator is a real pipe `|`, not a capital `I`. The old PDF used a
capital `I` here and in the school lines, which is visible in a condensed font.

In InDesign this block is a good candidate for a right-aligned tab with a dot
leader instead of the pipe — see the InDesign guide, section 9.

## 5. EXPERIENCE — main column

Experience goes above education: with six years at Nokia it is the strongest
card. Reverse only for academic applications.

```
EXPERIENCE
```

```
NOKIA
2020 – August 2026 | LISBON
Software Engineer

• Developed features and fixed bugs in network management products used by telecom operators, joining as an intern and growing into a software engineer role.
• Supported releases and deployments of containerised services with Docker and Kubernetes on Linux.
• Maintained the Jenkins pipelines that built, tested and delivered the product, including on cloud environments.
• Wrote Python tooling and automated tests to remove repetitive steps from the team and catch regressions before release.
• Troubleshot operator escalations, tracing issues through logs across several services and explaining findings to non-technical stakeholders.
```

```
VESTAS
2018 – 2019 | MONTPELLIER
Analysis Software Developer Assistant

• Built a C# Excel add-in using Entity Framework to synchronise spreadsheet data into a SQL database.
• Created a C# background service that checks PDF documents for missing signatures and emails the signatories.
• Supported and maintained an ASP.NET application, including user access management.
```

```
AKANTHA
2016 – 2018 | NÎMES
Web Developer

• Rebuilt the client-file consultation web application in PHP over SOAP, after evaluating Laravel and Phalcon against the existing WSDL infrastructure.
• Deployed it on a repurposed server running XAMPP and documented it for handover.
```

```
TECHNOLOGIAS IMAGINADAS
January – March 2016 | LISBON
Software Developer

• C#/WPF quoting application for a motorcycle dealer, backed by a SQL database and targeting legacy Windows XP clients.
```

```
MATEUS & MARTINS LDA
June – July 2015 | CASTELO BRANCO
Web Developer

• Showcase website and a stock-management tool in PHP/MySQL, hosted on Apache via WampServer.
```

If the page runs over, collapse the last two into a single line:

```
EARLIER INTERNSHIPS
2015 – 2016 | LISBON / CASTELO BRANCO

• C#/WPF quoting application with a SQL backend; showcase website and stock-management tool in PHP/MySQL.
```

**Note on the bullet characters.** The `•` is typed literally in the blocks
above, which is what Illustrator needs. InDesign applies bullets automatically
from the paragraph style, so strip the leading `• ` when pasting there — see the
InDesign guide, section 8.

## 6. EDUCATION — main column

```
EDUCATION
```

```
COMPUTER AND INFORMATION SYSTEMS SPECIALIST
2017 – 2019 | EPSI | MONTPELLIER
RNCP title level 7 (EU), level 1 (FR)

CONCEPTEUR INTÉGRATEUR DEVOPS
2016 | EPSI | MONTPELLIER

HIGH SCHOOL DIPLOMA STI2D
2014 | VICTOR HUGO COLLEGE | LUNEL
```

## 7. SKILLS — main column

The site's logo grid (roughly two dozen tiles) does not survive print: the
thumbnails become unreadable and eat a third of the page. Grouped text lines
carry the same information, print cleanly, and parse correctly if the PDF is run
through a keyword filter.

```
SKILLS
```

```
CODE
Python · Bash · C# · PHP · JavaScript / TypeScript · SQL · YAML

CONTAINERS & CLOUD
Docker · Kubernetes · Helm · Harbor · OpenStack · Red Hat OpenShift · Azure

CI / CD & TOOLING
Jenkins · Git · Gerrit · Artifactory · Jira · Confluence

DATA & OS
SQL Server · MySQL / MariaDB · MongoDB · Linux (Alpine, CentOS, Ubuntu) · Windows Server · WSL

AI TOOLS
Cursor · GitHub Copilot · Ollama
```

Group labels use `company` at a smaller size or a bolder pairing weight; the
lists use `body`.

## 8. CERTIFICATIONS — main column, optional

Include only if space remains at the bottom. One line each.

```
CERTIFICATIONS
```

```
Professional (L3) Kubernetes R23 R&D Engineer — 2024 | NOKIA
Professional (L3) Technical Debt Prevention for Software Development — 2025 | NOKIA
Cursor Training — 2026 | NOKIA
```

## 9. EXTRACURRICULAR — main column, optional

Present in the old PDF. Low value now that there are six years of professional
experience above it; the first thing to cut for space.

```
EXTRACURRICULAR
```

```
BIA | BREVET D’INITIATION AÉRONAUTIQUE
2013 | VICTOR HUGO COLLEGE | LUNEL
Diploma of initiation to scientific and technical knowledge in aeronautics and space.
```

## 10. Fix before sending

Errors found in the old PDF, corrected in the copy above:

| Old PDF | Corrected |
| --- | --- |
| knoweledge | knowledge |
| pontual | punctual |
| motived | motivated |
| aplication (x3) | application |
| lowyer | lawyer |
| I always archived my goals | achieved |
| Diplome of initiation | Diploma |
| VICTOR HUGO COLLEGEI | VICTOR HUGO COLLEGE |
| Brevet initiation Aéronautique | Brevet d’Initiation Aéronautique |
| Portuguese `I` Native | Portuguese `\|` Native (real pipe, U+007C) |

Content that was stale and is updated above:

- Nokia read "2020-present" and "Software Developer, Sysadmin, Tester" with three
  lines about the NAC solution. `index.html` now says 2020 – August 2026,
  "Software engineer", and describes the Docker/Kubernetes, Jenkins and Python
  work. The newer text is used.

Still to verify:

- **FR phone number** `+33 6 95 59 16 72` — only source is the 2019 PDF, and
  `data/contact.json` carries the PT number only. Confirm or drop the line.
- **Portfolio URL** — the old PDF listed
  `martinsmateus-joao.azurewebsites.net`. Nothing in the repository references
  that host any more. Add the current URL as a contact line once confirmed, or
  leave it out.
- **Nokia end date** — `index.html` says August 2026. Adjust if that changes.

## 11. Glyph check

Every character used in the blocks above was checked against
`fonts/lane-narrow.ttf` and is present: the accents `Ã Õ É Î ã ç é`, and the
punctuation `• · – — ’ | & @ / + :`. Nothing will fall back to a substitute font.

If you edit the copy, re-run the check before exporting:

```bash
python3 - <<'PY'
import re
from fontTools.ttLib import TTFont
text = open('cv/CV-COPY.md', encoding='utf-8').read()
cps = set()
for t in TTFont('fonts/lane-narrow.ttf')['cmap'].tables:
    cps |= set(t.cmap.keys())
blocks = re.findall(r'```\n(.*?)```', text, re.S)
missing = {c for b in blocks for c in b if c not in '\n\t' and ord(c) not in cps}
print('missing:', sorted(missing) if missing else 'none')
PY
```
