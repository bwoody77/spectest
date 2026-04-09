import SwiftUI
import SpecRuntime

@Observable
final class TaskFormViewModel {
  var title: Any = ""
  var assignee: Any = ""
  var priority: Any = "medium"
  var status: Any = "todo"
  var dueDate: Any? = nil
  var notes: Any = ""
  var urgent: Any = false
  var submitted: Any = false
  var submitting: Any = false
  var error: Any = ""
  var touched: Any = false
  var titleError: Any { ((specString(title) == specString("")) ? "Title is required" : "") }
  var assigneeError: Any { ((specString(assignee) == specString("")) ? "Assignee is required" : "") }
  var hasTitleError: Any { (touched as? Bool ?? false && (specString(titleError) != specString(""))) }
  var hasAssigneeError: Any { (touched as? Bool ?? false && (specString(assigneeError) != specString(""))) }
  var isValid: Any { ((specString(titleError) == specString("")) && (specString(assigneeError) == specString(""))) }
  var hasError: Any { (specString(error) != specString("")) }
  var isSubmitting: Any { submitting }
  var formSummary: Any { ((specString(title) != specString("")) ? "Creating: \(specString(title))" : "Fill in the form below") }
  var successVisible: Any { submitted }
  func setTitle(_ v: Any) {
    title = v
    touched = true
  }
  func setAssignee(_ v: Any) {
    assignee = v
    touched = true
  }
  func setPriority(_ v: Any) {
    priority = v
  }
  func setStatus(_ v: Any) {
    status = v
  }
  func setDueDate(_ v: Any) {
    dueDate = v
  }
  func setNotes(_ v: Any) {
    notes = v
  }
  func setUrgent(_ v: Any) {
    urgent = v
  }
  func submitForm() async {
    touched = true
    if isValid as? Bool ?? false {
      submitting = true
      /* await not yet supported */  _ = Optional<Any>.none
      submitted = true
      submitting = false
      error = ""
    }
  }
  func dismissSuccess() {
    submitted = false
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TaskFormView: View {
  @State private var vm = TaskFormViewModel()
  var body: some View {
    VStack(spacing: CGFloat(12)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("plus")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
        Text(specString("Create New Task"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Spacer(minLength: 0)
        EmptyView().popover(isPresented: .constant(false)) {
        }
      }
      .frame(maxWidth: .infinity)

      Text(specString(vm.formSummary))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      VStack() {
        if vm.successVisible as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("success")))
              .foregroundStyle(specAlertColor(specString("success")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Task created!")).font(.subheadline.weight(.semibold))
              Text(specString("Your new task has been added to the backlog.")).font(.subheadline)
            }
            Spacer(minLength: 0)
            Button(action: {}) { Image(systemName: "xmark").foregroundStyle(.secondary) }
          }
          .padding(12)
          .background(specAlertColor(specString("success")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack() {
        if vm.hasError as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Submission failed")).font(.subheadline.weight(.semibold))
              Text(specString(vm.error)).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(4)) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Title")).font(.subheadline).foregroundStyle(.secondary)
              TextField(specString("Enter task title"), text: Binding(get: { vm.title as? String ?? "" }, set: { vm.title = $0 }))
            }
            VStack() {
              if vm.hasTitleError as? Bool ?? false {
                Text(specString(vm.titleError))
                  .font(.callout.bold())
                  .foregroundStyle(Color(hex: "#db2424"))
              }
            }

          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Notes")).font(.subheadline).foregroundStyle(.secondary)
            TextField(specString("Optional notes..."), text: Binding(get: { vm.notes as? String ?? "" }, set: { vm.notes = $0 }))
          }
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
            VStack(spacing: CGFloat(4)) {
              Picker(specString("Assignee"), selection: Binding(get: { specString(vm.assignee) }, set: { vm.assignee = $0 })) {
                ForEach(Array(([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                  Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                }
              }
              .pickerStyle(.menu)
              VStack() {
                if vm.hasAssigneeError as? Bool ?? false {
                  Text(specString(vm.assigneeError))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#db2424"))
                }
              }

            }

            Picker(specString("Priority"), selection: Binding(get: { specString(vm.priority) }, set: { vm.priority = $0 })) {
              ForEach(Array(([["value": "low" as Any, "label": "Low" as Any] as [String: Any], ["value": "medium" as Any, "label": "Medium" as Any] as [String: Any], ["value": "high" as Any, "label": "High" as Any] as [String: Any], ["value": "critical" as Any, "label": "Critical" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
              }
            }
            .pickerStyle(.menu)
          }

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
            Picker(specString("Status"), selection: Binding(get: { specString(vm.status) }, set: { vm.status = $0 })) {
              ForEach(Array(([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
              }
            }
            .pickerStyle(.menu)
            DatePickerView(label: "Due Date", placeholder: "Pick a date", value: vm.dueDate)
          }

          Toggle(specString("Mark as urgent"), isOn: Binding(get: { vm.urgent as? Bool ?? false }, set: { vm.urgent = $0 }))
            .toggleStyle(.automatic)
          HStack(alignment: .center, spacing: CGFloat(12)) {
            if vm.isSubmitting as? Bool ?? false {
              ProgressView(value: (75 as? Double ?? 0) / 100.0)
                .tint(.accentColor)
            }
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.info-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          HStack(alignment: .center, spacing: CGFloat(12)) {
            Button(action: { Task { @MainActor in await vm.submitForm() } }) {
              Text(specString("Create Task"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.blue, in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: {  }) {
              Text(specString("Reset"))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
