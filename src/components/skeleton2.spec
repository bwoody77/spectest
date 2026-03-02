// Skeleton2 — loading placeholder (static)
// Limitation: no animation support, no dynamic width/height from params
component Skeleton2(variant: string = "rectangle") {
  block {
    height: 120px
    background: token.skeleton-bg
    border-radius: radius.md
    opacity: 0.7
  }
}
