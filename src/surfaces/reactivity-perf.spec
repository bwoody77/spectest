surface ReactivityPerf() {
  @state {
    input: ""
  }

  @computed {
    upper: input.toUpperCase()
    lower: input.toLowerCase()
    len: input.length + ""
    reversed: input.split('').reverse().join('')
    trimmed: input.trim()
    first5: input.slice(0, 5)
    last5: input.slice(-5)
    words: input.split(' ').length + " words"
    chars: input.length + " chars"
  }

  block {
    layout: vertical, gap: spacing.4
    padding: spacing.5

    text('Reactivity Performance Test') {
      style: type.heading-lg
      color: semantic.text-primary
    }
    text('Type below — all outputs are bound to the same state signal.') {
      style: type.body-sm
      color: semantic.text-secondary
    }

    // Primary input
    block {
      padding: spacing.3
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default
      layout: vertical, gap: spacing.2

      text('Input') { style: type.label-md, color: semantic.text-secondary }
      textInput(input) {
        placeholder: 'Type here to test reactivity...'
        border: borders.default
        border-radius: radius.sm
        padding: spacing.2
      }
    }

    // Stats bar
    block {
      layout: horizontal, gap: spacing.3
      block {
        padding: spacing.2
        background: semantic.surface-raised
        border-radius: radius.sm
        border: borders.default
        text(chars) { style: type.label-sm, color: semantic.interactive }
      }
      block {
        padding: spacing.2
        background: semantic.surface-raised
        border-radius: radius.sm
        border: borders.default
        text(words) { style: type.label-sm, color: semantic.interactive }
      }
    }

    // Computed derivations
    block {
      layout: vertical, gap: spacing.2
      padding: spacing.3
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default

      text('Computed Derivations') { style: type.heading-sm, color: semantic.text-primary }

      block { layout: horizontal, gap: spacing.2, align: baseline
        text('UPPER:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(upper) { style: type.body-sm, color: semantic.text-primary }
      }
      block { layout: horizontal, gap: spacing.2, align: baseline
        text('lower:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(lower) { style: type.body-sm, color: semantic.text-primary }
      }
      block { layout: horizontal, gap: spacing.2, align: baseline
        text('Reversed:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(reversed) { style: type.body-sm, color: semantic.text-primary }
      }
      block { layout: horizontal, gap: spacing.2, align: baseline
        text('Trimmed:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(trimmed) { style: type.body-sm, color: semantic.text-primary }
      }
      block { layout: horizontal, gap: spacing.2, align: baseline
        text('First 5:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(first5) { style: type.body-sm, color: semantic.text-primary }
      }
      block { layout: horizontal, gap: spacing.2, align: baseline
        text('Last 5:') { style: type.label-sm, color: semantic.text-secondary, width: 80px }
        text(last5) { style: type.body-sm, color: semantic.text-primary }
      }
    }

    // 50 text outputs bound to `input`
    block {
      layout: vertical, gap: spacing.2
      padding: spacing.3
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default

      text('50 Direct Bindings') { style: type.heading-sm, color: semantic.text-primary }

      block { layout: grid, columns: "1fr 1fr 1fr 1fr 1fr", gap: spacing.1

        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }

        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }

        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }

        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }

        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
        text(input) { style: type.body-sm, color: semantic.text-primary }
      }
    }

    // 50 computed bindings (template strings with input)
    block {
      layout: vertical, gap: spacing.2
      padding: spacing.3
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default

      text('50 Computed Bindings (template strings)') { style: type.heading-sm, color: semantic.text-primary }

      block { layout: grid, columns: "1fr 1fr 1fr 1fr 1fr", gap: spacing.1

        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }

        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }

        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }

        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }

        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
        text(">{input}<") { style: type.body-sm, color: semantic.text-secondary }
      }
    }

    // 20 text mirrors in styled cells
    block {
      layout: vertical, gap: spacing.2
      padding: spacing.3
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default

      text('20 Styled Text Mirrors') { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: "1fr 1fr 1fr 1fr", gap: spacing.1

        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
        block { padding: spacing.1
          border: borders.subtle
          border-radius: radius.sm
          text(input) { style: type.body-sm }
        }
      }
    }
  }
}
