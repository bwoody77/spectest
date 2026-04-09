import SwiftUI
import SpecRuntime

@Observable
final class WizardStep1ViewModel {
  var title: Any = ""
  var assignee: Any = ""
  var titleTouched: Any = false
  var titleFilled: Any { (specString(title) != specString("")) }
  var showTitleError: Any { (titleTouched as? Bool ?? false && (specString(title) == specString(""))) }
  func setTitle(_ v: Any) {
    title = v
  }
  func setAssignee(_ v: Any) {
    assignee = v
  }
}

struct WizardStep1View: View {
  @State private var vm = WizardStep1ViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(specString("Step 1: Basic Info"))
        .font(.title3.bold())
      Text(specString("Provide the core details for this task."))
        .font(.callout.bold())
        .foregroundStyle(.secondary)
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(4)) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Title")).font(.subheadline).foregroundStyle(.secondary)
              TextField(specString("Task title"), text: Binding(get: { vm.title as? String ?? "" }, set: { vm.title = $0 }))
            }
            VStack() {
              if vm.showTitleError as? Bool ?? false {
                Text(specString("Title is required"))
                  .font(.callout.bold())
                  .foregroundStyle(Color.red)
              }
            }

          }

          Picker(specString("Assignee"), selection: Binding(get: { specString(vm.assignee) }, set: { vm.assignee = $0 })) {
            ForEach(Array(([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
              Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
            }
          }
          .pickerStyle(.menu)
        }
        .padding(CGFloat(16))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Button(action: { /* unsupported: dispatch */ Optional<Any>.none as Any }) {
          Text(specString("Next"))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
        }
        .disabled(!(vm.titleFilled as? Bool ?? false) as? Bool ?? false)
      }

    }
    .foregroundStyle(.primary)
  }
}
