import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class WizardStep1ViewModel {
  var title: Any = ""
  var assignee: Any = ""
  var titleTouched: Any = false
  var titleFilled: Any { specNeq(title, "") }
  var showTitleError: Any { ((titleTouched) as? Bool ?? false && specEq(title, "")) }
  func setTitle(_ v: Any) {
    title = v
  }
  func setAssignee(_ v: Any) {
    assignee = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct WizardStep1View: View {
  @State private var vm = WizardStep1ViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = WizardStep1ViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Step 1: Basic Info"))
        .font(.title)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
      Text(verbatim: specString("Provide the core details for this task."))
        .font(.footnote)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Title")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
              SpecTextField(specString("Task title"), text: Binding(get: { vm.title as? String ?? "" }, set: { newValue in vm.title = newValue; let v: Any = newValue; vm.title = v; vm.titleTouched = true }))
              .textFieldStyle(.roundedBorder)
              .specAccessibilityLabel(specFieldName("", "Title"))
              .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(vm.showTitleError) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
            }
            if (vm.showTitleError) as? Bool ?? false {
            if specLiveHasWords([specString("Title is required")]) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("Title is required"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(Color(hex: "#db2424"))
            }
            .specLiveRegion([specString("Title is required")], assertive: false, collapses: true)
            }
            }
          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Assignee")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              if specArr([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                ForEach(Array(specArr([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  let optValue = specString(specGet(opt, "value"))
                  let optSub = specString(specGet(opt, "sub"))
                  Toggle(isOn: Binding(get: { specString(vm.assignee) == optValue }, set: { on in if on { Binding(get: { specString(vm.assignee) }, set: { newValue in vm.assignee = newValue; let v: Any = newValue; vm.assignee = v }).wrappedValue = optValue } })) {
                    Text(specString(specGet(opt, "label")))
                    if !optSub.isEmpty { Text(optSub) }
                  }
                }
              } else {
              Picker(specString("Assignee"), selection: Binding(get: { specString(vm.assignee) }, set: { newValue in vm.assignee = newValue; let v: Any = newValue; vm.assignee = v })) {
                ForEach(Array(specArr([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
              }
            } label: {
              HStack {
                Text(verbatim: specSelectLabel([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any], specString(vm.assignee), "Choose assignee").text).foregroundStyle(specSelectLabel([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any], specString(vm.assignee), "Choose assignee").isPlaceholder ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
              }
              .padding(.horizontal, 12).padding(.vertical, 8)
              .background(Color(.systemBackground))
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            }
          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Spacer(minLength: 0)
        Button(action: { specClick { Task { @MainActor in await vm.dispatch("next", nil) } } }) {
          Text(specString("Next"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
        }
        .disabled((!((vm.titleFilled) as? Bool ?? false)) as? Bool ?? false)
        .opacity(((!((vm.titleFilled) as? Bool ?? false)) as? Bool ?? false) ? 0.5 : 1)
      }
      .frame(maxWidth: .infinity)

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
