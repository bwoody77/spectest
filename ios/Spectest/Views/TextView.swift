import SwiftUI
import SpecRuntime

@Observable
final class TextViewModel {
  var content: Any? = nil
  var selectable: Any = true
  var variant: Any = "body-md"
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
        if (specString(vm.variant) == specString("heading-xl")) {
          Text(specString(vm.content))
            .font(.title.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("heading-lg")) {
          Text(specString(vm.content))
            .font(.title2.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("heading-md")) {
          Text(specString(vm.content))
            .font(.title3.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("heading-sm")) {
          Text(specString(vm.content))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("body-lg")) {
          Text(specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("body-md")) {
          Text(specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("body-sm")) {
          Text(specString(vm.content))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("label-sm")) {
          Text(specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
      }

      VStack() {
        if (specString(vm.variant) == specString("caption")) {
          Text(specString(vm.content))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.content = content; vm.variant = variant; vm.selectable = selectable }
  }
}
