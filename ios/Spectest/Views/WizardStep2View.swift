import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class WizardStep2ViewModel {
  var priority: Any = "medium"
  var dueDate: Any? = Optional<Any>.none as Any
  var autoAssign: Any = false
  func setPriority(_ v: Any) {
    priority = v
  }
  func setDueDate(_ v: Any) {
    dueDate = v
  }
  func setAutoAssign(_ v: Any) {
    autoAssign = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct WizardStep2View: View {
  @State private var vm = WizardStep2ViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = WizardStep2ViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Step 2: Options"))
        .font(.title)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
      Text(verbatim: specString("Configure priority, deadline, and assignment options."))
        .font(.footnote)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Priority")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              if specArr([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                ForEach(Array(specArr([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  let optValue = specString(specGet(opt, "value"))
                  let optSub = specString(specGet(opt, "sub"))
                  Toggle(isOn: Binding(get: { specString(vm.priority) == optValue }, set: { on in if on { Binding(get: { specString(vm.priority) }, set: { newValue in vm.priority = newValue; let v: Any = newValue; vm.priority = v }).wrappedValue = optValue } })) {
                    Text(specString(specGet(opt, "label")))
                    if !optSub.isEmpty { Text(optSub) }
                  }
                }
              } else {
              Picker(specString("Priority"), selection: Binding(get: { specString(vm.priority) }, set: { newValue in vm.priority = newValue; let v: Any = newValue; vm.priority = v })) {
                ForEach(Array(specArr([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
              }
            } label: {
              HStack {
                Text(verbatim: specSelectLabel([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any], specString(vm.priority), "").text).foregroundStyle(specSelectLabel([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any], specString(vm.priority), "").isPlaceholder ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
              }
              .padding(.horizontal, 12).padding(.vertical, 8)
              .background(Color(.systemBackground))
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            }
          }
          VStack(alignment: .leading, spacing: 4) {
            if !specString("Due Date").isEmpty {
              Text(specString("Due Date")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
            }
            SpecOptionalDatePicker(text: Binding(get: { specString(vm.dueDate) }, set: { newValue in vm.dueDate = newValue; let v: Any = newValue; vm.dueDate = v }), format: "YYYY-MM-DD", placeholder: "Select deadline", label: "Due Date", ariaLabel: "", disabled: false, error: false, errorMessage: "")
          }
          Toggle(specString("Auto-assign reviewer"), isOn: Binding(get: { specTruthy(vm.autoAssign) }, set: { newValue in let v: Any = newValue; vm.autoAssign = v }))
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Spacer(minLength: 0)
        Button(action: { specClick { Task { @MainActor in await vm.dispatch("back", nil) } } }) {
          Text(specString("Back"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.medium))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
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
      }
      .frame(maxWidth: .infinity)

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
