// Design tokens — baseline visual system + theme overrides
//
// Canonical design token file. Imported by app.spec via bare import:
//   @import "../visual-system.spec"
//
// Gate #22 enhancements: elevation tokens, dark theme, border tokens

@visual-system {
  spacing: 4px-unit
  type-scale: 1.25-ratio, base 14px
  palette: slate(neutral), indigo(primary), red(danger), emerald(success), amber(warning)
  radius: 6px(sm), 8px(md), 12px(lg), 9999px(full)
  motion: 150ms ease(default), 100ms ease(quick), 300ms ease(slow)

  // Semantic colors — text
  semantic.text-primary: "#202732"
  semantic.text-secondary: "#496183"
  semantic.text-tertiary: "#92a2b9"
  semantic.text-disabled: "#bdc5d1"
  semantic.text-muted: "#5c7aa3"
  semantic.text-strong: "#3b4e68"

  // Semantic colors — surfaces
  semantic.surface: "#f7f7f8"
  semantic.surface-raised: "#ffffff"
  semantic.surface-hover: "#eeeff1"
  semantic.surface-unread: "#f0f9ff"
  semantic.background: "#ffffff"
  semantic.border: "#dce0e5"
  semantic.border-strong: "#92a2b9"

  // Semantic colors — interactive
  semantic.interactive: "#1418eb"
  semantic.interactive-hover: "#1013bc"
  semantic.interactive-active: "#0d0f96"
  semantic.focus-ring: "#a8a9e6"
  semantic.info-bg: "#f6f6f9"

  // Semantic colors — destructive/error
  semantic.destructive: "#db2424"
  semantic.destructive-hover: "#af1d1d"
  semantic.error: "#af1d1d"
  semantic.error-bg: "#f9f6f6"

  // Semantic colors — success
  semantic.success: "#33cc99"
  semantic.success-light: "#f6f8f8"
  semantic.success-muted: "#ecf3f1"
  semantic.success-text: "#1c5e48"
  semantic.success-mid: "#218362"

  // Semantic colors — warning
  semantic.warning: "#fab505"
  semantic.warning-light: "#f9f8f6"
  semantic.warning-muted: "#f6f2ea"
  semantic.warning-text: "#725409"

  // Borders
  borders.default: "1px solid #dce0e5"
  borders.strong: "1px solid #92a2b9"
  borders.accent-error: "3px solid #db2424"
  borders.accent-warning: "3px solid #fab505"
  borders.accent-success: "3px solid #33cc99"
  borders.accent-interactive: "3px solid #1418eb"
  borders.accent-interactive-strong: "4px solid #1418eb"
  borders.accent-none: "3px solid transparent"
  borders.success: "1px solid #d6eae4"
  borders.section-accent: "2px solid #1418eb30"

  // Gradients
  gradient.stat-primary: "linear-gradient(135deg, #f6f6f9, #d2d3ee)"
  gradient.stat-primary-subtle: "linear-gradient(135deg, #f6f6f9, #eaebf5)"
  gradient.stat-success: "linear-gradient(135deg, #f6f8f8, #d6eae4)"
  gradient.stat-success-subtle: "linear-gradient(135deg, #f6f8f8, #ecf3f1)"
  gradient.stat-warning: "linear-gradient(135deg, #f9f8f6, #f1e7d0)"
  gradient.stat-warning-subtle: "linear-gradient(135deg, #f9f8f6, #f6f2ea)"
  gradient.stat-neutral: "linear-gradient(135deg, #f7f7f8, #bdc5d1)"
  gradient.stat-neutral-subtle: "linear-gradient(135deg, #f7f7f8, #dce0e5)"
  gradient.header-accent: "linear-gradient(135deg, #1418eb15, #1418eb05)"

  // Transitions
  transition.card-lift: "transform 200ms ease, box-shadow 200ms ease"
  transition.subtle: "transform 150ms ease"
  transition.scale: "transform 200ms ease"
  transition.interactive: "box-shadow 150ms ease, transform 150ms ease"
  transition.interactive-full: "box-shadow 150ms ease, background-color 150ms ease, transform 150ms ease"
  transition.row-hover: "background-color 150ms ease, box-shadow 150ms ease, border-left 150ms ease, transform 150ms ease"
  transition.shadow: "box-shadow 150ms ease"
  transition.shadow-slow: "box-shadow 200ms ease"
  transition.shadow-slower: "box-shadow 300ms ease"

  // Transforms
  transform.lift-xs: "translateY(-1px)"
  transform.lift-sm: "translateY(-2px)"
  transform.lift-md: "translateY(-3px)"
  transform.lift-lg: "translateY(-4px)"
  transform.nudge-right: "translateX(4px)"
  transform.nudge-right-sm: "translateX(2px)"
  transform.grow-sm: "scale(1.02)"

  // Icon sizes
  icon.xs: "16px"
  icon.sm: "18px"
  icon.md: "20px"
  icon.lg: "24px"
  icon.xl: "32px"
  icon.xxl: "48px"

  // Elevation
  elevation.flat: "none"
  elevation.raised: "0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.06)"
  elevation.layered: "0 4px 6px rgba(0,0,0,0.07), 0 2px 4px rgba(0,0,0,0.06)"
  elevation.floating: "0 10px 25px rgba(0,0,0,0.1), 0 4px 10px rgba(0,0,0,0.05)"
  elevation.overlay: "0 8px 32px rgba(0,0,0,0.12)"
  elevation.inset: "inset 0 2px 4px rgba(0,0,0,0.06)"
}

// ---------------------------------------------------------------------------
// Midnight — immersive dark theme with electric cyan accents
// Inspired by developer tools (VS Code, Figma dark). High contrast neon-on-dark.
// ---------------------------------------------------------------------------
@theme midnight {
  palette.primary: cyan
  palette.neutral: slate
  semantic.surface: "#0b1120"
  semantic.surface-raised: "#141e33"
  semantic.surface-hover: "#1c2b45"
  semantic.surface-unread: "#0c2a3e"
  semantic.background: "#060b16"
  semantic.border: "#1e3148"
  semantic.border-strong: "#2d5a7b"
  semantic.text-primary: "#e8edf5"
  semantic.text-secondary: "#8ba2be"
  semantic.text-tertiary: "#5a7a9b"
  semantic.text-disabled: "#3a5068"
  semantic.text-muted: "#6b8db5"
  semantic.text-strong: "#f1f7ff"
  semantic.interactive: "#22d3ee"
  semantic.interactive-hover: "#06b6d4"
  semantic.interactive-active: "#0891b2"
  semantic.focus-ring: "#155e75"
  semantic.info-bg: "#083344"
  semantic.destructive: "#fb7185"
  semantic.destructive-hover: "#f43f5e"
  semantic.error: "#f43f5e"
  semantic.error-bg: "#4c0519"
  semantic.success: "#34d399"
  semantic.success-light: "#064e3b"
  semantic.success-muted: "#065f46"
  semantic.success-text: "#a7f3d0"
  semantic.success-mid: "#6ee7b7"
  semantic.warning: "#fbbf24"
  semantic.warning-light: "#78350f"
  semantic.warning-muted: "#92400e"
  semantic.warning-text: "#fde68a"

  // Tight corners
  radius.sm: "4px"
  radius.md: "6px"
  radius.lg: "10px"
  radius.full: "9999px"

  // Cyan-tinted glows
  elevation.flat: "none"
  elevation.raised: "0 0 8px rgba(34,211,238,0.15), 0 1px 2px rgba(0,0,0,0.3)"
  elevation.layered: "0 0 16px rgba(34,211,238,0.1), 0 4px 6px rgba(0,0,0,0.3)"
  elevation.floating: "0 0 30px rgba(34,211,238,0.15), 0 10px 25px rgba(0,0,0,0.4)"
  elevation.overlay: "0 0 40px rgba(34,211,238,0.1), 0 8px 32px rgba(0,0,0,0.5)"
  elevation.inset: "inset 0 2px 4px rgba(0,0,0,0.3)"
}

// ---------------------------------------------------------------------------
// Ember — warm terracotta and amber tones on cream surfaces
// Inspired by earthy design systems. Warm, inviting, organic feel.
// ---------------------------------------------------------------------------
@theme ember {
  palette.primary: orange
  palette.neutral: stone
  semantic.surface: "#faf5ef"
  semantic.surface-raised: "#fffbf5"
  semantic.surface-hover: "#f0e6d6"
  semantic.surface-unread: "#fff7ed"
  semantic.background: "#fefcf8"
  semantic.border: "#d9c4a8"
  semantic.border-strong: "#b8956a"
  semantic.text-primary: "#3c1a04"
  semantic.text-secondary: "#78350f"
  semantic.text-tertiary: "#a16207"
  semantic.text-disabled: "#d4b896"
  semantic.text-muted: "#92400e"
  semantic.text-strong: "#2c1003"
  semantic.interactive: "#ea580c"
  semantic.interactive-hover: "#c2410c"
  semantic.interactive-active: "#9a3412"
  semantic.focus-ring: "#fdba74"
  semantic.info-bg: "#fff7ed"
  semantic.destructive: "#dc2626"
  semantic.destructive-hover: "#b91c1c"
  semantic.error: "#b91c1c"
  semantic.error-bg: "#fef2f2"
  semantic.success: "#16a34a"
  semantic.success-light: "#f0fdf4"
  semantic.success-muted: "#dcfce7"
  semantic.success-text: "#14532d"
  semantic.success-mid: "#15803d"
  semantic.warning: "#d97706"
  semantic.warning-light: "#fffbeb"
  semantic.warning-muted: "#fef3c7"
  semantic.warning-text: "#78350f"

  // Generous spacing (5px unit)
  spacing.1: "5px"
  spacing.2: "10px"
  spacing.3: "15px"
  spacing.4: "20px"
  spacing.5: "25px"
  spacing.6: "30px"
  spacing.8: "40px"
  spacing.10: "50px"
  spacing.12: "60px"
  spacing.16: "80px"

  // Soft, rounded corners
  radius.sm: "10px"
  radius.md: "14px"
  radius.lg: "20px"
  radius.full: "9999px"

  // Warm, diffuse elevation
  elevation.flat: "none"
  elevation.raised: "0 2px 8px rgba(120,53,15,0.08), 0 1px 3px rgba(120,53,15,0.06)"
  elevation.layered: "0 6px 16px rgba(120,53,15,0.07), 0 3px 6px rgba(120,53,15,0.05)"
  elevation.floating: "0 12px 32px rgba(120,53,15,0.1), 0 6px 12px rgba(120,53,15,0.06)"
  elevation.overlay: "0 10px 40px rgba(120,53,15,0.12)"
  elevation.inset: "inset 0 2px 4px rgba(120,53,15,0.06)"
}

// ---------------------------------------------------------------------------
// Forest — sage and emerald on natural warm surfaces
// Inspired by nature/sustainability apps. Calming, trustworthy, organic.
// ---------------------------------------------------------------------------
@theme forest {
  palette.primary: emerald
  palette.neutral: stone
  semantic.surface: "#eef3ee"
  semantic.surface-raised: "#f6faf6"
  semantic.surface-hover: "#dce8dc"
  semantic.surface-unread: "#ecfdf5"
  semantic.background: "#f5f9f5"
  semantic.border: "#a8c4a8"
  semantic.border-strong: "#6b9a6b"
  semantic.text-primary: "#14291e"
  semantic.text-secondary: "#2d5a3e"
  semantic.text-tertiary: "#5a8a6e"
  semantic.text-disabled: "#a3c4b0"
  semantic.text-muted: "#3d7052"
  semantic.text-strong: "#0a1f14"
  semantic.interactive: "#059669"
  semantic.interactive-hover: "#047857"
  semantic.interactive-active: "#065f46"
  semantic.focus-ring: "#6ee7b7"
  semantic.info-bg: "#ecfdf5"
  semantic.destructive: "#dc2626"
  semantic.destructive-hover: "#b91c1c"
  semantic.error: "#b91c1c"
  semantic.error-bg: "#fef2f2"
  semantic.success: "#059669"
  semantic.success-light: "#ecfdf5"
  semantic.success-muted: "#d1fae5"
  semantic.success-text: "#065f46"
  semantic.success-mid: "#047857"
  semantic.warning: "#d97706"
  semantic.warning-light: "#fffbeb"
  semantic.warning-muted: "#fef3c7"
  semantic.warning-text: "#92400e"

  // Subtle, organic corners
  radius.sm: "3px"
  radius.md: "5px"
  radius.lg: "8px"
  radius.full: "9999px"

  // Near-flat elevation
  elevation.flat: "none"
  elevation.raised: "0 1px 2px rgba(0,0,0,0.04)"
  elevation.layered: "0 2px 4px rgba(0,0,0,0.05)"
  elevation.floating: "0 4px 8px rgba(0,0,0,0.06)"
  elevation.overlay: "0 4px 12px rgba(0,0,0,0.06)"
  elevation.inset: "inset 0 1px 2px rgba(0,0,0,0.04)"
}

// ---------------------------------------------------------------------------
// Mono — pure black-and-white editorial design, zero chrome color
// Inspired by iA Writer, Medium, Apple HIG. Typography-first, distraction-free.
// ---------------------------------------------------------------------------
@theme mono {
  palette.primary: zinc
  palette.neutral: zinc
  semantic.surface: "#fafafa"
  semantic.surface-raised: "#ffffff"
  semantic.surface-hover: "#f4f4f5"
  semantic.surface-unread: "#f4f4f5"
  semantic.background: "#ffffff"
  semantic.border: "#d4d4d8"
  semantic.border-strong: "#a1a1aa"
  semantic.text-primary: "#09090b"
  semantic.text-secondary: "#3f3f46"
  semantic.text-tertiary: "#71717a"
  semantic.text-disabled: "#d4d4d8"
  semantic.text-muted: "#52525b"
  semantic.text-strong: "#09090b"
  semantic.interactive: "#18181b"
  semantic.interactive-hover: "#27272a"
  semantic.interactive-active: "#09090b"
  semantic.focus-ring: "#a1a1aa"
  semantic.info-bg: "#f4f4f5"
  semantic.destructive: "#dc2626"
  semantic.destructive-hover: "#b91c1c"
  semantic.error: "#b91c1c"
  semantic.error-bg: "#fef2f2"
  semantic.success: "#16a34a"
  semantic.success-light: "#f0fdf4"
  semantic.success-muted: "#dcfce7"
  semantic.success-text: "#14532d"
  semantic.success-mid: "#15803d"
  semantic.warning: "#ca8a04"
  semantic.warning-light: "#fefce8"
  semantic.warning-muted: "#fef9c3"
  semantic.warning-text: "#713f12"

  // Sharp, editorial corners
  radius.sm: "0px"
  radius.md: "0px"
  radius.lg: "2px"
  radius.full: "2px"

  // Flat elevation (no shadows)
  elevation.flat: "none"
  elevation.raised: "none"
  elevation.layered: "none"
  elevation.floating: "none"
  elevation.overlay: "none"
  elevation.inset: "none"
}

// ---------------------------------------------------------------------------
// Luxe — rich violet on subtle purple tints, premium and exclusive
// Inspired by Stripe, Linear, premium SaaS dashboards. Sophisticated, high-end.
// ---------------------------------------------------------------------------
@theme luxe {
  palette.primary: violet
  palette.neutral: slate
  semantic.surface: "#f6f2ff"
  semantic.surface-raised: "#fdfcff"
  semantic.surface-hover: "#ede5ff"
  semantic.surface-unread: "#f5f3ff"
  semantic.background: "#faf8ff"
  semantic.border: "#c4b5fd"
  semantic.border-strong: "#8b5cf6"
  semantic.text-primary: "#1e0a3e"
  semantic.text-secondary: "#4c1d95"
  semantic.text-tertiary: "#7c3aed"
  semantic.text-disabled: "#c4b5fd"
  semantic.text-muted: "#5b21b6"
  semantic.text-strong: "#120627"
  semantic.interactive: "#7c3aed"
  semantic.interactive-hover: "#6d28d9"
  semantic.interactive-active: "#5b21b6"
  semantic.focus-ring: "#a78bfa"
  semantic.info-bg: "#ede9fe"
  semantic.destructive: "#e11d48"
  semantic.destructive-hover: "#be123c"
  semantic.error: "#be123c"
  semantic.error-bg: "#fff1f2"
  semantic.success: "#059669"
  semantic.success-light: "#ecfdf5"
  semantic.success-muted: "#d1fae5"
  semantic.success-text: "#065f46"
  semantic.success-mid: "#047857"
  semantic.warning: "#d97706"
  semantic.warning-light: "#fffbeb"
  semantic.warning-muted: "#fef3c7"
  semantic.warning-text: "#92400e"

  // Smooth, premium corners
  radius.sm: "8px"
  radius.md: "12px"
  radius.lg: "16px"
  radius.full: "9999px"

  // Deep, layered elevation
  elevation.flat: "none"
  elevation.raised: "0 1px 3px rgba(124,58,237,0.06), 0 2px 8px rgba(0,0,0,0.06)"
  elevation.layered: "0 4px 12px rgba(124,58,237,0.06), 0 2px 6px rgba(0,0,0,0.06)"
  elevation.floating: "0 12px 32px rgba(124,58,237,0.08), 0 4px 12px rgba(0,0,0,0.08)"
  elevation.overlay: "0 16px 48px rgba(124,58,237,0.1), 0 8px 24px rgba(0,0,0,0.08)"
  elevation.inset: "inset 0 2px 4px rgba(124,58,237,0.06)"
}

// ---------------------------------------------------------------------------
// Dark — baseline dark mode (special: merges with auto-generated dark semantics)
// ---------------------------------------------------------------------------
@theme dark {
  palette.primary: indigo
  semantic.surface: "#0f172a"
  semantic.surface-raised: "#1e293b"
  semantic.surface-hover: "#334155"
  semantic.background: "#020617"
  semantic.border: "#334155"
  semantic.border-strong: "#475569"
  semantic.text-primary: "#f1f5f9"
  semantic.text-secondary: "#94a3b8"
  semantic.text-tertiary: "#64748b"
  semantic.text-disabled: "#475569"
  semantic.text-muted: "#94a3b8"
  semantic.text-strong: "#e2e8f0"
  semantic.interactive: "#818cf8"
  semantic.interactive-hover: "#6366f1"
  semantic.interactive-active: "#4f46e5"
  semantic.focus-ring: "#4338ca"
  semantic.info-bg: "#312e81"
  semantic.surface-unread: "#1e3a5f"
  semantic.destructive: "#fb7185"
  semantic.destructive-hover: "#f43f5e"
  semantic.error: "#f43f5e"
  semantic.error-bg: "#4c0519"
  semantic.success: "#34d399"
  semantic.success-light: "#064e3b"
  semantic.success-muted: "#065f46"
  semantic.success-text: "#a7f3d0"
  semantic.success-mid: "#6ee7b7"
  semantic.warning: "#fbbf24"
  semantic.warning-light: "#78350f"
  semantic.warning-muted: "#92400e"
  semantic.warning-text: "#fde68a"

  // Dark-adapted corners
  radius.sm: "6px"
  radius.md: "8px"
  radius.lg: "12px"
  radius.full: "9999px"

  // Dark-adapted elevation
  elevation.flat: "none"
  elevation.raised: "0 1px 3px rgba(0,0,0,0.2), 0 1px 2px rgba(0,0,0,0.15)"
  elevation.layered: "0 4px 6px rgba(0,0,0,0.2), 0 2px 4px rgba(0,0,0,0.15)"
  elevation.floating: "0 10px 25px rgba(0,0,0,0.3), 0 4px 10px rgba(0,0,0,0.15)"
  elevation.overlay: "0 8px 32px rgba(0,0,0,0.35)"
  elevation.inset: "inset 0 2px 4px rgba(0,0,0,0.2)"
}
