import SwiftUI
import SpecRuntime

@Observable
final class WizardStep2ViewModel {
  var priority: Any = "medium"
  var dueDate: Any? = nil
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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct WizardStep2View: View {
  @State private var vm = WizardStep2ViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      Text(verbatim: specString("Step 2: Options"))
        .font(.title3.bold())
      Text(verbatim: specString("Configure priority, deadline, and assignment options."))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Priority")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              Picker(specString("Priority"), selection: Binding(get: { specString(vm.priority) }, set: { vm.priority = $0 })) {
                ForEach(Array(specArr([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
            } label: {
              HStack {
                Text(verbatim: specString(vm.priority)).foregroundStyle(.primary)
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
              Text(specString("Due Date")).font(.subheadline).foregroundStyle(.secondary)
            }
            DatePicker("", selection: Binding(get: { (vm.dueDate as? Date) ?? Date() }, set: { vm.dueDate = $0 }), displayedComponents: .date)
              .datePickerStyle(.compact)
              .labelsHidden()
          }
          Toggle(specString("Auto-assign reviewer"), isOn: Binding(get: { vm.autoAssign as? Bool ?? false }, set: { vm.autoAssign = $0 }))
        }
        .padding(ThemeManager.shared.size("spacing-4"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Button(action: { Task { @MainActor in await vm.dispatch("back", nil) } }) {
          Text(specString("Back"))
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.blue)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        Button(action: { Task { @MainActor in await vm.dispatch("next", nil) } }) {
          Text(specString("Next"))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
