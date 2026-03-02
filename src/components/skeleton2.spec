// Skeleton2 — loading placeholder (static)
// Limitation: no animation support (pulse/wave need CSS keyframes)
component Skeleton2() {
  block {
    layout: vertical, gap: spacing.3

    // Rectangle placeholder
    block {
      height: 80px
      background: token.skeleton-bg
      border-radius: radius.md
      opacity: 0.7
    }

    // Circle + text lines row
    block {
      layout: horizontal, gap: spacing.3, align: center

      // Circle
      block {
        width: 48px
        height: 48px
        border-radius: 9999px
        background: token.skeleton-bg
        opacity: 0.7
      }

      // Text lines
      block {
        grow: true
        layout: vertical, gap: spacing.2

        block {
          height: 14px
          background: token.skeleton-bg
          border-radius: radius.sm
          opacity: 0.7
        }
        block {
          height: 14px
          width: 70%
          background: token.skeleton-bg
          border-radius: radius.sm
          opacity: 0.7
        }
      }
    }
  }
}
