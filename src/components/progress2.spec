// Progress2 — bar progress indicator (static demo)
// Limitation: width property doesn't support expressions, so the fill bar
// is a fixed visual demonstration. Full conversion needs computed style support.
component Progress2(value: number = 0, label: string = "") {
  block {
    height: 8px
    background: token.progress-trackBg
    border-radius: 4px
    overflow: hidden
    role: "progressbar"

    // Static fill bar — cannot bind width to value param yet
    block {
      height: 8px
      width: 65%
      background: token.progress-fillBg
      border-radius: 4px
    }
  }
}
