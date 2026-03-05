/**
 * Theme Builder — extern module
 *
 * Bridges the theme builder UI (Spec) with the runtime theme registry.
 * Uses registerThemes() to apply live token changes without recompiling.
 */

import { registerThemes, applyTheme, getThemeRegistry } from '@spec/runtime';

let _prevTheme = 'default';
let _builderTokens = {};

// ---------------------------------------------------------------------------
// Color math
// ---------------------------------------------------------------------------

function hexToHsl(hex) {
  const r = parseInt(hex.slice(1, 3), 16) / 255;
  const g = parseInt(hex.slice(3, 5), 16) / 255;
  const b = parseInt(hex.slice(5, 7), 16) / 255;
  const max = Math.max(r, g, b), min = Math.min(r, g, b);
  let h = 0, s = 0, l = (max + min) / 2;
  if (max !== min) {
    const d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    switch (max) {
      case r: h = ((g - b) / d + (g < b ? 6 : 0)) / 6; break;
      case g: h = ((b - r) / d + 2) / 6; break;
      case b: h = ((r - g) / d + 4) / 6; break;
    }
  }
  return [h * 360, s * 100, l * 100];
}

function hslToHex(h, s, l) {
  s /= 100; l /= 100;
  const k = n => (n + h / 30) % 12;
  const a = s * Math.min(l, 1 - l);
  const f = n => l - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));
  return '#' + [0, 8, 4].map(n => Math.round(f(n) * 255).toString(16).padStart(2, '0')).join('');
}

function getLuminance(hex) {
  const [r, g, b] = [hex.slice(1, 3), hex.slice(3, 5), hex.slice(5, 7)]
    .map(c => {
      const v = parseInt(c, 16) / 255;
      return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
    });
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

function blendHex(a, b, t) {
  const ar = parseInt(a.slice(1, 3), 16), ag = parseInt(a.slice(3, 5), 16), ab = parseInt(a.slice(5, 7), 16);
  const br = parseInt(b.slice(1, 3), 16), bg = parseInt(b.slice(3, 5), 16), bb = parseInt(b.slice(5, 7), 16);
  return '#' +
    Math.round(ar + (br - ar) * t).toString(16).padStart(2, '0') +
    Math.round(ag + (bg - ag) * t).toString(16).padStart(2, '0') +
    Math.round(ab + (bb - ab) * t).toString(16).padStart(2, '0');
}

// ---------------------------------------------------------------------------
// Core API
// ---------------------------------------------------------------------------

/**
 * Copy the current theme into the __builder__ slot and switch to it.
 * Called by App's openThemeBuilder() action.
 */
export function startBuilderPreview(themeName) {
  _prevTheme = themeName || 'default';
  const registry = getThemeRegistry();
  _builderTokens = { ...(registry[_prevTheme] || {}) };
  registerThemes({ '__builder__': { ..._builderTokens } });
  applyTheme('__builder__');
}

/**
 * Revert to the theme that was active before the builder opened.
 */
export function cancelBuilderPreview() {
  applyTheme(_prevTheme);
}

/**
 * Persist the current builder tokens under a new theme name and stay on it.
 */
export function saveBuilderAsTheme(name) {
  if (!name || !name.trim()) return;
  const saved = { ..._builderTokens };
  registerThemes({ [name]: saved });
  _prevTheme = name;
  // Switch the active theme to the named one
  applyTheme(name);
}

/**
 * Apply a partial token map onto the current builder state and re-register.
 */
export function updateBuilderTokens(updates) {
  Object.assign(_builderTokens, updates);
  registerThemes({ '__builder__': { ..._builderTokens } });
}

// ---------------------------------------------------------------------------
// Color presets
// ---------------------------------------------------------------------------

export function applyPrimaryColor(hex) {
  // Guard: only process valid hex strings. Protects against [object Event] or
  // other non-string values that could arrive if the caller passes the wrong thing.
  if (typeof hex !== 'string' || !/^#[0-9a-fA-F]{6}$/.test(hex)) return;
  const [h, s, l] = hexToHsl(hex);
  const onColor = getLuminance(hex) > 0.35 ? '#000000' : '#ffffff';
  const hover   = hslToHex(h, s, Math.max(l - 12, 8));
  const active  = hslToHex(h, s, Math.max(l - 22, 4));
  const ring    = hslToHex(h, Math.min(s, 70), Math.min(l + 28, 90));
  const infoBg  = hslToHex(h, Math.min(s * 0.4, 30), Math.min(l + 38, 96));
  const shadow  = hex + '40';
  updateBuilderTokens({
    'interactive':                    hex,
    'interactive-hover':              hover,
    'interactive-active':             active,
    'focus-ring':                     ring,
    'info-bg':                        infoBg,
    'on-interactive':                 onColor,
    'focus-ring-shadow':              shadow,
    'btn-primary-bg':                 hex,
    'btn-primary-hover':              hover,
    'btn-primary-color':              onColor,
    'progress-fillBg':                hex,
    'checkbox-checkedBg':             hex,
    'toggle-trackBgOn':               hex,
    'tab-activeColor':                hex,
    'input-focusBorder':              hex,
    'input-focusRing':                shadow,
    'border-accent-interactive':      '3px solid ' + hex,
    'border-accent-interactive-strong': '4px solid ' + hex,
    'border-section-accent':          '2px solid ' + hex + '30',
    'select-optionSelected':          infoBg,
    'badge-info-bg':                  infoBg,
    'badge-info-color':               hex,
    'badge-info-border':              ring,
    'alert-info-bg':                  infoBg,
    'alert-info-border':              hex,
    'alert-info-text':                hex,
    'alert-info-border-css':          '1px solid ' + hex,
  });
}

export function applySurfaceColors(bg, surface, surfaceRaised, borderColor) {
  const hover = blendHex(surfaceRaised, '#000000', 0.06);
  updateBuilderTokens({
    'background':          bg,
    'surface':             surface,
    'surface-raised':      surfaceRaised,
    'surface-hover':       hover,
    'border':              borderColor,
    'border-default':      '1px solid ' + borderColor,
    'border-strong':       '1px solid ' + blendHex(borderColor, '#000000', 0.35),
    'input-bg':            surfaceRaised,
    'input-border':        borderColor,
    'btn-secondary-bg':    surfaceRaised,
    'btn-secondary-border': borderColor,
    'grid-headerBg':       surface,
    'grid-filterBg':       surfaceRaised,
    'grid-filterBorder':   borderColor,
    'grid-borderColor':    borderColor,
    'grid-rowBorder':      surface,
    'modal-bg':            surfaceRaised,
    'select-bg':           surfaceRaised,
    'select-border':       borderColor,
    'tab-borderColor':     borderColor,
    'toggle-trackBg':      blendHex(borderColor, '#000000', 0.2),
    'skeleton-bg':         hover,
  });
}

export function applyTextColors(primary, secondary) {
  updateBuilderTokens({
    'text-primary':        primary,
    'text-secondary':      secondary,
    'text-tertiary':       blendHex(secondary, '#ffffff', 0.3),
    'text-disabled':       blendHex(secondary, '#ffffff', 0.5),
    'text-muted':          secondary,
    'text-strong':         blendHex(primary, '#000000', 0.15),
    'input-color':         primary,
    'btn-secondary-color': primary,
    'btn-ghost-color':     secondary,
  });
}

// ---------------------------------------------------------------------------
// Presets
// ---------------------------------------------------------------------------

export function applyRadiusPreset(preset) {
  const map = {
    sharp:   { sm: '0px',    md: '0px',    lg: '0px',    full: '0px',    btn: '0px',    input: '0px',    modal: '0px',    badge: '0px',    checkbox: '2px'   },
    default: { sm: '6px',    md: '8px',    lg: '12px',   full: '9999px', btn: '8px',    input: '8px',    modal: '14px',   badge: '9999px', checkbox: '5px'   },
    rounded: { sm: '10px',   md: '14px',   lg: '20px',   full: '9999px', btn: '12px',   input: '12px',   modal: '20px',   badge: '9999px', checkbox: '6px'   },
    pill:    { sm: '9999px', md: '9999px', lg: '9999px', full: '9999px', btn: '9999px', input: '9999px', modal: '24px',   badge: '9999px', checkbox: '9999px'},
  };
  const r = map[preset] || map.default;
  updateBuilderTokens({
    'radius-sm': r.sm, 'radius-md': r.md, 'radius-lg': r.lg, 'radius-full': r.full,
    'btn-radius': r.btn, 'input-radius': r.input, 'modal-radius': r.modal,
    'badge-radius': r.badge, 'checkbox-radius': r.checkbox,
    'alert-radius': r.modal, 'select-radius': r.input, 'toggle-radius': r.full,
  });
}

export function applyFontFamily(preset) {
  const map = {
    system:  "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
    inter:   "'Inter', 'Segoe UI', Helvetica, sans-serif",
    rounded: "'Nunito', 'Quicksand', 'Varela Round', sans-serif",
    serif:   "'Georgia', 'Cambria', 'Times New Roman', serif",
    mono:    "'JetBrains Mono', 'Fira Code', 'Consolas', monospace",
  };
  const f = map[preset] || map.system;
  updateBuilderTokens({ 'font-body': f, 'font-heading': f });
}

export function applyMotionPreset(preset) {
  const scale = { instant: 0, fast: 0.5, normal: 1, slow: 2 }[preset] ?? 1;
  const t = (ms, ease) => scale === 0 ? 'none' : `${Math.round(ms * scale)}ms ${ease}`;
  updateBuilderTokens({
    'transition-card-lift':       `transform ${t(200, 'ease')}, box-shadow ${t(200, 'ease')}`,
    'transition-subtle':          `transform ${t(150, 'ease')}`,
    'transition-scale':           `transform ${t(200, 'ease')}`,
    'transition-interactive':     `box-shadow ${t(150, 'ease')}, transform ${t(150, 'ease')}`,
    'transition-interactive-full':`box-shadow ${t(150, 'ease')}, background-color ${t(150, 'ease')}, transform ${t(150, 'ease')}`,
    'transition-row-hover':       `background-color ${t(150, 'ease')}, box-shadow ${t(150, 'ease')}, border-left ${t(150, 'ease')}, transform ${t(150, 'ease')}`,
    'transition-shadow':          `box-shadow ${t(150, 'ease')}`,
    'transition-shadow-slow':     `box-shadow ${t(200, 'ease')}`,
    'transition-shadow-slower':   `box-shadow ${t(300, 'ease')}`,
  });
}

export function applyElevationPreset(preset) {
  const map = {
    flat:    { raised: 'none', layered: 'none', floating: 'none', overlay: 'none', inset: 'none' },
    subtle:  {
      raised:   '0 1px 2px rgba(0,0,0,0.05)',
      layered:  '0 2px 4px rgba(0,0,0,0.06)',
      floating: '0 4px 12px rgba(0,0,0,0.08)',
      overlay:  '0 4px 16px rgba(0,0,0,0.10)',
      inset:    'inset 0 1px 2px rgba(0,0,0,0.04)',
    },
    default: {
      raised:   '0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.06)',
      layered:  '0 4px 6px rgba(0,0,0,0.07), 0 2px 4px rgba(0,0,0,0.06)',
      floating: '0 10px 25px rgba(0,0,0,0.1), 0 4px 10px rgba(0,0,0,0.05)',
      overlay:  '0 8px 32px rgba(0,0,0,0.12)',
      inset:    'inset 0 2px 4px rgba(0,0,0,0.06)',
    },
    bold:    {
      raised:   '0 2px 8px rgba(0,0,0,0.14), 0 1px 3px rgba(0,0,0,0.10)',
      layered:  '0 6px 16px rgba(0,0,0,0.14), 0 3px 6px rgba(0,0,0,0.10)',
      floating: '0 16px 40px rgba(0,0,0,0.18), 0 6px 16px rgba(0,0,0,0.10)',
      overlay:  '0 12px 48px rgba(0,0,0,0.22)',
      inset:    'inset 0 2px 6px rgba(0,0,0,0.12)',
    },
  };
  const e = map[preset] || map.default;
  updateBuilderTokens({
    'elevation-raised':   e.raised,
    'elevation-layered':  e.layered,
    'elevation-floating': e.floating,
    'elevation-overlay':  e.overlay,
    'elevation-inset':    e.inset,
    'modal-shadow':       e.overlay,
  });
}
