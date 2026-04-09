import SwiftUI
import SpecRuntime

@Observable
final class ImageViewModel {
  var alt: Any? = nil
  var aspectRatio: Any = ""
  var fallbackSrc: Any = ""
  var lazy: Any = false
  var src: Any? = nil
  var loaded: Any = false
  var errored: Any = false
  var displaySrc: Any { ((errored) as? Bool ?? false ? ((specString(fallbackSrc) != specString("")) ? fallbackSrc : src) : src) }
  var loadingAttr: Any { ((lazy) as? Bool ?? false ? "lazy" : "eager") }
  func handleLoad() {
    loaded = true
  }
  func handleError() {
    errored = true
    loaded = true
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ImageView: View {
  @State private var vm = ImageViewModel()
  var alt: Any? = nil
  var aspectRatio: Any = ""
  var fallbackSrc: Any = ""
  var lazy: Any = false
  var src: Any? = nil
  init(alt: Any? = nil, aspectRatio: Any = "", fallbackSrc: Any = "", lazy: Any = false, src: Any? = nil) { self._vm = State(initialValue: ImageViewModel()); self.alt = alt; self.aspectRatio = aspectRatio; self.fallbackSrc = fallbackSrc; self.lazy = lazy; self.src = src }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          if (specString(vm.loaded) == specString(false)) {
          }
        }
        .background(ThemeManager.shared.color("semantic.on-destructive"))
        .background(ThemeManager.shared.color("semantic.on-destructive"))
        AsyncImage(url: URL(string: "" as? String ?? ""))
      }
      .frame(width: CGFloat(0))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.src = src; vm.alt = alt; vm.aspectRatio = aspectRatio; vm.lazy = lazy; vm.fallbackSrc = fallbackSrc }
  }
}
