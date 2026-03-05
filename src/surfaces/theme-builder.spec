// Theme Builder — live design token editor
// Opens as a right-side panel over any page; changes apply to the running app instantly.
// Parent (App) controls open/close and save/cancel via actions — this surface owns
// only the editing state and the per-section UIs.

@extern { applyPrimaryColor, applySurfaceColors, applyTextColors, applyRadiusPreset, applyFontFamily, applyMotionPreset, applyElevationPreset, getSurfaceSuggestion, getSurfaceTint, getTextSuggestion } from "../theme-builder.js"

surface ThemeBuilder {
  @state {
    primaryHex:      '#1677ff'
    bgHex:           '#ffffff'
    surfaceHex:      '#f7f7f8'
    surfaceRaisedHex:'#ffffff'
    borderHex:       '#dce0e5'
    textPrimaryHex:  '#202732'
    textSecondaryHex:'#496183'
    radiusPreset:    'default'
    fontPreset:      'system'
    motionPreset:    'normal'
    shadowPreset:    'default'
    activeSection:   'primary'
    motionToggle:    false
    surfaceTint:     10
  }

  @actions {
    // Color actions — no parameter extraction; two-way binding already updated the
    // state signal via the `input` event before `change` fires.
    applyPrimary() {
      applyPrimaryColor(primaryHex)
    }
    applyBg() {
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    }
    applySurface() {
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    }
    applySurfaceRaised() {
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    }
    applyBorder() {
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    }
    applyTextPrimary() {
      applyTextColors(textPrimaryHex, textSecondaryHex)
    }
    applyTextSecondary() {
      applyTextColors(textPrimaryHex, textSecondaryHex)
    }
    setRadius(p) {
      radiusPreset = p
      applyRadiusPreset(p)
    }
    setFont(p) {
      fontPreset = p
      applyFontFamily(p)
    }
    setMotion(p) {
      motionPreset = p
      applyMotionPreset(p)
    }
    setShadow(p) {
      shadowPreset = p
      applyElevationPreset(p)
    }
    syncSurfaces() {
      bgHex = getSurfaceTint(primaryHex, 10, 'bg')
      surfaceHex = getSurfaceTint(primaryHex, 10, 'surface')
      surfaceRaisedHex = getSurfaceTint(primaryHex, 10, 'surfaceRaised')
      borderHex = getSurfaceTint(primaryHex, 10, 'border')
      textPrimaryHex = getTextSuggestion(bgHex, 'primary')
      textSecondaryHex = getTextSuggestion(bgHex, 'secondary')
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
      applyTextColors(textPrimaryHex, textSecondaryHex)
      surfaceTint = 10
    }
    setSurfaceTint(v) {
      surfaceTint = v
      bgHex = getSurfaceTint(primaryHex, v, 'bg')
      surfaceHex = getSurfaceTint(primaryHex, v, 'surface')
      surfaceRaisedHex = getSurfaceTint(primaryHex, v, 'surfaceRaised')
      borderHex = getSurfaceTint(primaryHex, v, 'border')
      applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    }
    toggleMotionDemo() { motionToggle = !motionToggle }
    setSection(s) { activeSection = s }
  }

  layout: vertical

  // -------------------------------------------------------------------------
  // Section tab bar
  // -------------------------------------------------------------------------
  block {
    padding: spacing.3
    border-bottom: borders.default
    overflow: auto
    layout: horizontal, gap: spacing.1

    each [
      {id: 'primary', label: 'Color'},
      {id: 'colors',  label: 'Surfaces'},
      {id: 'text',    label: 'Text'},
      {id: 'shape',   label: 'Shape'},
      {id: 'type',    label: 'Font'},
      {id: 'shadow',  label: 'Shadow'},
      {id: 'motion',  label: 'Motion'}
    ] as sec {
      block {
        padding-x: spacing.3
        padding-y: 6px
        border-radius: radius.sm
        cursor: pointer
        background: activeSection == sec.id ? semantic.interactive : 'transparent'
        on click: setSection(sec.id)

        text(sec.label) {
          style: type.label-sm
          color: activeSection == sec.id ? semantic.on-interactive : semantic.text-secondary
        }
      }
    }
  }

  // -------------------------------------------------------------------------
  // Section content (scrollable body)
  // -------------------------------------------------------------------------
  block {
    grow: true
    overflow: auto
    padding: spacing.4
    layout: vertical, gap: spacing.5

    // ==========================================================================
    // PRIMARY COLOR
    // ==========================================================================
    block {
      visibility: activeSection == 'primary'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Primary / Accent Color') { style: type.label-md, color: semantic.text-primary }
        text('Generates the full interactive color family — buttons, links, focus rings, badges.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      // Color picker card
      block {
        padding: spacing.4
        border-radius: radius.md
        background: semantic.surface-raised
        border: borders.default
        layout: vertical, gap: spacing.3

        // Large preview swatch
        block {
          height: 80px
          border-radius: radius.md
          background: primaryHex
          layout: horizontal, align: center, justify: center
          shadow: elevation.raised

          text('Aa') {
            style: type.heading-md
            color: semantic.on-interactive
          }
        }

        // Hex input
        block {
          layout: horizontal, gap: spacing.2, align: center

          text('Color') { style: type.label-sm, color: semantic.text-secondary }

          block {
            grow: true
            textInput(primaryHex) {
              type: 'color'
              on change: { applyPrimary() }
            }
          }

          block {
            padding-x: spacing.2
            padding-y: 4px
            border-radius: radius.sm
            background: semantic.surface-hover
            text(primaryHex) { style: type.mono-sm, color: semantic.text-secondary }
          }
        }

        // Generated palette preview
        block {
          layout: vertical, gap: spacing.2

          text('Generated from this color') { style: type.label-xs, color: semantic.text-tertiary }

          block {
            layout: horizontal, gap: spacing.2

            block {
              layout: vertical, gap: spacing.1, align: center
              block {
                width: 28px
                height: 28px
                border-radius: radius.sm
                background: semantic.interactive
                border: borders.default
              }
              text('Base') { style: type.caption, color: semantic.text-tertiary }
            }

            block {
              layout: vertical, gap: spacing.1, align: center
              block {
                width: 28px
                height: 28px
                border-radius: radius.sm
                background: semantic.interactive-hover
                border: borders.default
              }
              text('Hover') { style: type.caption, color: semantic.text-tertiary }
            }

            block {
              layout: vertical, gap: spacing.1, align: center
              block {
                width: 28px
                height: 28px
                border-radius: radius.sm
                background: semantic.interactive-active
                border: borders.default
              }
              text('Active') { style: type.caption, color: semantic.text-tertiary }
            }

            block {
              layout: vertical, gap: spacing.1, align: center
              block {
                width: 28px
                height: 28px
                border-radius: radius.sm
                background: semantic.focus-ring
                border: borders.default
              }
              text('Ring') { style: type.caption, color: semantic.text-tertiary }
            }

            block {
              layout: vertical, gap: spacing.1, align: center
              block {
                width: 28px
                height: 28px
                border-radius: radius.sm
                background: semantic.info-bg
                border: borders.default
              }
              text('Tint') { style: type.caption, color: semantic.text-tertiary }
            }
          }
        }
      }
    }

    // ==========================================================================
    // SURFACES
    // ==========================================================================
    block {
      visibility: activeSection == 'colors'
      layout: vertical, gap: spacing.4

      block {
        layout: horizontal, align: center, justify: between
        block {
          layout: vertical, gap: spacing.1
          text('Surface Colors') { style: type.label-md, color: semantic.text-primary }
          text('Background layers, cards, and border colors.') {
            style: type.body-sm
            color: semantic.text-secondary
          }
        }
        Button(label: 'Sync with primary', variant: 'secondary') {
          on click: { syncSurfaces() }
        }
      }

      // Tint depth slider — only meaningful after a sync
      block {
        layout: horizontal, gap: spacing.3, align: center
        text('Tint depth') { style: type.label-sm, color: semantic.text-secondary }
        block {
          grow: true
          Slider(value: surfaceTint, min: 0, max: 100, step: 1) {
            on change(v): { setSurfaceTint(v) }
          }
        }
        block {
          width: 32px
          text(surfaceTint) { style: type.mono-sm, color: semantic.text-tertiary }
        }
      }

      block {
        padding: spacing.3
        border-radius: radius.md
        background: semantic.surface-raised
        border: borders.default
        layout: vertical, gap: spacing.3

        // Background
        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: bgHex
            border: borders.default
          }
          block {
            grow: true
            text('Page Background') { style: type.label-sm, color: semantic.text-primary }
            text('Outermost app background') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(bgHex) {
            type: 'color'
            on change: { applyBg() }
          }
        }

        block {
          height: 1px
          background: semantic.border
        }

        // Surface
        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: surfaceHex
            border: borders.default
          }
          block {
            grow: true
            text('Surface') { style: type.label-sm, color: semantic.text-primary }
            text('Main content area fill') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(surfaceHex) {
            type: 'color'
            on change: { applySurface() }
          }
        }

        block {
          height: 1px
          background: semantic.border
        }

        // Card / Raised
        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: surfaceRaisedHex
            border: borders.default
          }
          block {
            grow: true
            text('Card / Panel') { style: type.label-sm, color: semantic.text-primary }
            text('Raised cards, modals, popovers') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(surfaceRaisedHex) {
            type: 'color'
            on change: { applySurfaceRaised() }
          }
        }

        block {
          height: 1px
          background: semantic.border
        }

        // Border
        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: borderHex
            border: borders.default
          }
          block {
            grow: true
            text('Border') { style: type.label-sm, color: semantic.text-primary }
            text('Lines, dividers, input borders') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(borderHex) {
            type: 'color'
            on change: { applyBorder() }
          }
        }
      }
    }

    // ==========================================================================
    // TEXT
    // ==========================================================================
    block {
      visibility: activeSection == 'text'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Text Colors') { style: type.label-md, color: semantic.text-primary }
        text('Primary and secondary text — other levels are auto-derived.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      block {
        padding: spacing.3
        border-radius: radius.md
        background: semantic.surface-raised
        border: borders.default
        layout: vertical, gap: spacing.3

        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: textPrimaryHex
            border: borders.default
          }
          block {
            grow: true
            text('Primary Text') { style: type.label-sm, color: semantic.text-primary }
            text('Headings, body, labels') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(textPrimaryHex) {
            type: 'color'
            on change: { applyTextPrimary() }
          }
        }

        block {
          height: 1px
          background: semantic.border
        }

        block {
          layout: horizontal, gap: spacing.3, align: center
          block {
            width: 32px
            height: 32px
            border-radius: radius.sm
            background: textSecondaryHex
            border: borders.default
          }
          block {
            grow: true
            text('Secondary Text') { style: type.label-sm, color: semantic.text-primary }
            text('Captions, hints, metadata') { style: type.body-sm, color: semantic.text-secondary }
          }
          textInput(textSecondaryHex) {
            type: 'color'
            on change: { applyTextSecondary() }
          }
        }

        // Live preview
        block {
          padding: spacing.3
          border-radius: radius.sm
          background: bgHex
          border: borders.default
          layout: vertical, gap: spacing.1

          text('Heading text sample') { style: type.heading-xs, color: textPrimaryHex }
          text('Secondary or descriptive text appears like this.') {
            style: type.body-sm
            color: textSecondaryHex
          }
        }
      }
    }

    // ==========================================================================
    // SHAPE (border radius)
    // ==========================================================================
    block {
      visibility: activeSection == 'shape'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Border Radius') { style: type.label-md, color: semantic.text-primary }
        text('Applies to buttons, inputs, cards, badges, and modals.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      block {
        layout: grid, columns: '1fr 1fr', gap: spacing.3

        each [
          {id: 'sharp',   label: 'Sharp',   desc: '0 px',  r: '0px'},
          {id: 'default', label: 'Default', desc: '8 px',  r: '8px'},
          {id: 'rounded', label: 'Rounded', desc: '14 px', r: '14px'},
          {id: 'pill',    label: 'Pill',    desc: '∞',     r: '9999px'}
        ] as p {
          block {
            padding: spacing.3
            border-radius: radius.md
            background: radiusPreset == p.id ? semantic.info-bg : semantic.surface-raised
            border: radiusPreset == p.id ? borders.accent-interactive : borders.default
            cursor: pointer
            on click: setRadius(p.id)
            layout: vertical, gap: spacing.2, align: center

            block {
              width: 52px
              height: 36px
              background: semantic.interactive
              shadow: elevation.raised
              border-radius: p.r
            }

            block {
              layout: vertical, gap: 2px, align: center
              text(p.label) { style: type.label-sm, color: semantic.text-primary }
              text(p.desc) { style: type.caption, color: semantic.text-tertiary }
            }
          }
        }
      }
    }

    // ==========================================================================
    // FONT FAMILY
    // ==========================================================================
    block {
      visibility: activeSection == 'type'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Font Family') { style: type.label-md, color: semantic.text-primary }
        text('Applies to body and heading text across the app.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      block {
        layout: vertical, gap: spacing.2
        overflow: auto

        each [
          {id: 'system',    label: 'System',         sample: 'System UI · native'},
          {id: 'inter',     label: 'Inter',           sample: 'Inter · modern sans'},
          {id: 'dm-sans',   label: 'DM Sans',         sample: 'DM Sans · clean'},
          {id: 'poppins',   label: 'Poppins',         sample: 'Poppins · geometric'},
          {id: 'jakarta',   label: 'Plus Jakarta',    sample: 'Jakarta · fresh'},
          {id: 'manrope',   label: 'Manrope',         sample: 'Manrope · modern'},
          {id: 'lato',      label: 'Lato',            sample: 'Lato · humanist'},
          {id: 'open-sans', label: 'Open Sans',       sample: 'Open Sans · readable'},
          {id: 'rubik',     label: 'Rubik',           sample: 'Rubik · rounded'},
          {id: 'outfit',    label: 'Outfit',          sample: 'Outfit · geometric'},
          {id: 'raleway',   label: 'Raleway',         sample: 'Raleway · elegant'},
          {id: 'ibm-plex',  label: 'IBM Plex',        sample: 'IBM Plex · technical'},
          {id: 'rounded',   label: 'Nunito',          sample: 'Nunito · friendly'},
          {id: 'serif',     label: 'Serif',           sample: 'Georgia · editorial'},
          {id: 'mono',      label: 'Mono',            sample: 'Fira Code · code'}
        ] as f {
          block {
            padding: spacing.3
            border-radius: radius.md
            background: fontPreset == f.id ? semantic.info-bg : semantic.surface-raised
            border: fontPreset == f.id ? borders.accent-interactive : borders.default
            cursor: pointer
            on click: setFont(f.id)
            layout: horizontal, gap: spacing.3, align: center

            block {
              width: 8px
              height: 8px
              border-radius: radius.full
              background: fontPreset == f.id ? semantic.interactive : semantic.border
            }

            block {
              grow: true
              layout: horizontal, justify: between, align: center
              text(f.label) { style: type.label-sm, color: semantic.text-primary }
              text(f.sample) { style: type.body-sm, color: semantic.text-secondary }
            }
          }
        }
      }
    }

    // ==========================================================================
    // SHADOW / ELEVATION
    // ==========================================================================
    block {
      visibility: activeSection == 'shadow'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Elevation & Shadow') { style: type.label-md, color: semantic.text-primary }
        text('Controls depth for cards, modals, and interactive elements.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      block {
        layout: grid, columns: '1fr 1fr', gap: spacing.3

        each [
          {id: 'flat',    label: 'Flat',    desc: 'No shadows'},
          {id: 'subtle',  label: 'Subtle',  desc: 'Minimal depth'},
          {id: 'default', label: 'Default', desc: 'Balanced'},
          {id: 'bold',    label: 'Bold',    desc: 'Strong depth'}
        ] as p {
          block {
            padding: spacing.3
            border-radius: radius.md
            background: shadowPreset == p.id ? semantic.info-bg : semantic.surface-raised
            border: shadowPreset == p.id ? borders.accent-interactive : borders.default
            cursor: pointer
            on click: setShadow(p.id)
            layout: vertical, gap: spacing.2, align: center

            block {
              width: 52px
              height: 36px
              border-radius: radius.md
              background: semantic.surface-raised
              shadow: match p.id {
                'flat'    -> elevation.flat,
                'subtle'  -> elevation.raised,
                'default' -> elevation.layered,
                'bold'    -> elevation.floating,
                _         -> elevation.raised
              }
            }

            block {
              layout: vertical, gap: 2px, align: center
              text(p.label) { style: type.label-sm, color: semantic.text-primary }
              text(p.desc) { style: type.caption, color: semantic.text-tertiary }
            }
          }
        }
      }
    }

    // ==========================================================================
    // MOTION
    // ==========================================================================
    block {
      visibility: activeSection == 'motion'
      layout: vertical, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        text('Animation Speed') { style: type.label-md, color: semantic.text-primary }
        text('Scales all transition durations across interactive elements.') {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      block {
        layout: vertical, gap: spacing.2

        each [
          {id: 'instant', label: 'Instant', desc: 'No transitions — 0 ms'},
          {id: 'fast',    label: 'Fast',    desc: 'Snappy — 75 ms base'},
          {id: 'normal',  label: 'Normal',  desc: 'Balanced — 150 ms base'},
          {id: 'slow',    label: 'Slow',    desc: 'Relaxed — 300 ms base'}
        ] as p {
          block {
            padding: spacing.3
            border-radius: radius.md
            background: motionPreset == p.id ? semantic.info-bg : semantic.surface-raised
            border: motionPreset == p.id ? borders.accent-interactive : borders.default
            cursor: pointer
            on click: setMotion(p.id)
            layout: horizontal, gap: spacing.3, align: center

            block {
              width: 8px
              height: 8px
              border-radius: radius.full
              background: motionPreset == p.id ? semantic.interactive : semantic.border
            }

            block {
              grow: true
              layout: horizontal, justify: between, align: center
              text(p.label) { style: type.label-sm, color: semantic.text-primary }
              text(p.desc) { style: type.body-sm, color: semantic.text-secondary }
            }
          }
        }
      }

      // Live preview
      block {
        padding: spacing.4
        border-radius: radius.md
        background: semantic.surface-raised
        border: borders.default
        layout: vertical, gap: spacing.3

        text('Live preview — hover and click to feel the speed') {
          style: type.label-xs
          color: semantic.text-tertiary
        }

        block {
          layout: horizontal, gap: spacing.2, align: center

          Button(label: 'Primary') { on click: {} }
          Button(label: 'Secondary', variant: 'secondary') { on click: {} }
          Button(label: 'Ghost', variant: 'ghost') { on click: {} }
          Button(label: 'Danger', variant: 'destructive') { on click: {} }
        }

        block {
          height: 1px
          background: semantic.border
        }

        Toggle(label: 'Toggle switch', checked: motionToggle) {
          on change(v): { toggleMotionDemo() }
        }
      }
    }

  }
}
