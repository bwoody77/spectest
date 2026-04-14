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
  var displaySrc: Any { ((errored) as? Bool ?? false ? (specNeq(fallbackSrc, "") ? fallbackSrc : src) : src) }
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
          if specEq(vm.loaded, false) {
          }
        }
        .background(ThemeManager.shared.color("semantic.background"))
        .background(ThemeManager.shared.color("semantic.background"))
        AsyncImage(url: URL(string: "" as? String ?? ""))
      }
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.src, src) { vm.src = src }; if !specEq(vm.alt, alt) { vm.alt = alt }; if !specEq(vm.aspectRatio, aspectRatio) { vm.aspectRatio = aspectRatio }; if !specEq(vm.lazy, lazy) { vm.lazy = lazy }; if !specEq(vm.fallbackSrc, fallbackSrc) { vm.fallbackSrc = fallbackSrc } }
    .task(id: specPropsKey([src, alt, aspectRatio, lazy, fallbackSrc])) { if !specEq(vm.src, src) { vm.src = src }; if !specEq(vm.alt, alt) { vm.alt = alt }; if !specEq(vm.aspectRatio, aspectRatio) { vm.aspectRatio = aspectRatio }; if !specEq(vm.lazy, lazy) { vm.lazy = lazy }; if !specEq(vm.fallbackSrc, fallbackSrc) { vm.fallbackSrc = fallbackSrc } }
  }
}
