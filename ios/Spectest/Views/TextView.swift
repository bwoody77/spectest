import SwiftUI
import SpecRuntime

@Observable
final class TextViewModel {
  var content: Any? = nil
  var selectable: Any = true
  var variant: Any = "body-md"
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TextView: View {
  @State private var vm = TextViewModel()
  var content: Any? = nil
  var selectable: Any = true
  var variant: Any = "body-md"
  init(content: Any? = nil, selectable: Any = true, variant: Any = "body-md") { self._vm = State(initialValue: TextViewModel()); self.content = content; self.selectable = selectable; self.variant = variant }
  var body: some View {
    VStack() {
      VStack() {
        if specEq(vm.variant, "heading-xl") {
          Text(verbatim: specString(vm.content))
            .font(.title.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "heading-lg") {
          Text(verbatim: specString(vm.content))
            .font(.title2.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "heading-md") {
          Text(verbatim: specString(vm.content))
            .font(.title3.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "heading-sm") {
          Text(verbatim: specString(vm.content))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "body-lg") {
          Text(verbatim: specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "body-md") {
          Text(verbatim: specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "body-sm") {
          Text(verbatim: specString(vm.content))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "label-sm") {
          Text(verbatim: specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if specEq(vm.variant, "caption") {
          Text(verbatim: specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.content = content; vm.variant = variant; vm.selectable = selectable }
  }
}
