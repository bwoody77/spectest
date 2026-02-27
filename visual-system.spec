// Design tokens — baseline visual system + theme overrides
//
// Canonical design token file. Imported by app.spec via bare import:
//   @import "../visual-system.spec"

@visual-system {
  spacing: 4px-unit
  type-scale: 1.25-ratio, base 14px
  palette: slate(neutral), indigo(primary), red(danger), emerald(success), amber(warning)
  radius: 6px(sm), 8px(md), 12px(lg), 9999px(full)
  motion: 150ms ease(default), 300ms ease(slow)
}

@theme enterprise {
  palette.primary: blue
  semantic.surface: "#f1f5f9"
  semantic.border: "#94a3b8"
  semantic.text-primary: "#1e293b"
  semantic.text-secondary: "#475569"
}

@theme social {
  palette.primary: violet
  semantic.surface: "#f5f3ff"
  semantic.border: "#a78bfa"
  semantic.text-primary: "#581c87"
  semantic.text-secondary: "#7c3aed"
}

@theme minimal {
  palette.primary: slate
  semantic.surface: "#ffffff"
  semantic.border: "#d4d4d4"
  semantic.text-primary: "#0f172a"
  semantic.text-secondary: "#6b7280"
}

@theme playful {
  palette.primary: orange
  semantic.surface: "#fff7ed"
  semantic.border: "#fb923c"
  semantic.text-primary: "#7c2d12"
  semantic.text-secondary: "#ea580c"
}
