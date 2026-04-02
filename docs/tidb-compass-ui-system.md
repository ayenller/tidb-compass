# TiDB Compass UI System

## Goal

TiDB Compass is not a generic product microsite. It is a sales and partner storytelling app for iPhone and iPad. The UI system should optimize for three things:

1. Fast comprehension in customer-facing conversations
2. Visual consistency across multilingual content
3. Smooth extension from HTML preview into native iOS shells

## Design Principles

### 1. Design System First

Build tokens and reusable components before refining individual screens. Avoid one-off visual decisions that create design debt.

### 2. Scalability First Storytelling

The primary narrative of the product is scalability. The UI should consistently privilege growth, concurrency, schema agility, and architecture simplification over generic database messaging.

### 3. Hierarchy Over Density

Not every card should have the same visual weight. The UI must clearly separate:

- Hero narrative
- Key metrics
- Story support
- Utility and reference information

### 4. Responsive by Presentation Mode

Portrait and landscape are not just different widths. They are different presentation modes.

- Portrait: handheld storytelling
- Landscape: projection / meeting-room storytelling

## Design Tokens

### Color

```css
:root {
  --bg: #fcf8fb;
  --surface: #fcf8fb;
  --surface-low: #f6f3f5;
  --surface-card: #ffffff;
  --surface-high: #eae7ea;

  --ink: #1b1b1d;
  --muted: #5e5e60;

  --primary: #bc000a;
  --primary-strong: #e2241f;
  --primary-soft: rgba(188, 0, 10, 0.08);

  --tertiary: #00647f;
  --tertiary-soft: rgba(0, 100, 127, 0.12);
}
```

### Spacing

```css
:root {
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 20px;
  --space-6: 24px;
  --space-7: 32px;
}
```

### Radius

```css
:root {
  --radius-sm: 12px;
  --radius-md: 18px;
  --radius-lg: 24px;
  --radius-xl: 28px;
}
```

### Elevation

```css
:root {
  --shadow: 0 8px 32px rgba(27, 27, 29, 0.06);
  --shadow-soft: 0 6px 24px rgba(27, 27, 29, 0.04);
}
```

## Component Hierarchy

### Hero Card

Use once per screen. Carries the main business story. Requires:

- Eyebrow
- Large title
- One concise support paragraph
- One primary action and one secondary action maximum

### Metric Card

Use for high-signal numbers only. Good examples:

- `100K+`
- `10K+`
- `Seconds`
- `∞`

Rules:

- Large numeric value
- Very short label
- Optional supporting note

### Story Card

Use for scenario mapping, capability explanation, and comparison framing.

Rules:

- One idea per card
- Heading should stay within two lines
- Supporting copy should stay short enough for live presentation

### Utility Card

Use for ranking lists, FAQs, references, and follow-up guidance.

Rules:

- Lower contrast than hero and metric cards
- Support scanning rather than persuasion

## Layout Rules

### Portrait

- Single-column first
- Metrics near the top of the screen
- Bottom tab stays compact
- Copy should read like presenter cue cards

### Landscape

- Hide HTML bottom tab bar when possible
- Promote side-by-side comparison and metric grouping
- Reduce explanatory copy
- Favor stage-ready layouts

## Multilingual Rules

- Keep headings within two lines in all locales
- Reserve more width for English, Spanish, and Portuguese labels
- Avoid relying on long CTA text
- Keep section order identical across locales

## Accessibility Rules

- Minimum target: WCAG AA
- Never rely on red alone to communicate meaning
- Maintain focus-visible states on buttons and tabs
- Keep small labels readable on iPhone portrait
- Do not make tab text smaller than necessary for hand-held reading

## Implementation Priorities

1. Unify tokens and shared component classes
2. Strengthen hero / metric / utility hierarchy on Intro, Scenarios, and Compare
3. Add explicit landscape presentation behavior
4. Keep HTML and iOS bundled HTML visually aligned
