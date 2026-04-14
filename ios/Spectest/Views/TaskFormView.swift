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
  var titleError: Any { (specEq(title, "") ? "Title is required" : "") }
  var assigneeError: Any { (specEq(assignee, "") ? "Assignee is required" : "") }
  var hasTitleError: Any { ((touched) as? Bool ?? false && specNeq(titleError, "")) }
  var hasAssigneeError: Any { ((touched) as? Bool ?? false && specNeq(assigneeError, "")) }
  var isValid: Any { (specEq(titleError, "") && specEq(assigneeError, "")) }
  var hasError: Any { specNeq(error, "") }
  var isSubmitting: Any { submitting }
  var formSummary: Any { (specNeq(title, "") ? "Creating: \(specString(title))" : "Fill in the form below") }
  var successVisible: Any { submitted }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
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
    if (isValid) as? Bool ?? false {
      submitting = true
      await fetch("http://localhost:4000/api/tasks", ["method": "POST" as Any, "body": JSON.stringify(["title": title as Any, "assignee": assignee as Any, "priority": priority as Any, "status": status as Any] as [String: Any]) as Any] as [String: Any])
      submitted = true
      submitting = false
      error = ""
    }
  }
  func dismissSuccess() {
    submitted = false
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TaskFormView: View {
  @State private var vm = TaskFormViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-3")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("plus")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Create New Task"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Spacer(minLength: 0)
        EmptyView().popover(isPresented: .constant(false)) {
        }
      }
      .frame(maxWidth: .infinity)

      Text(verbatim: specString(vm.formSummary))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack() {
        if (vm.successVisible) as? Bool ?? false {
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
        if (vm.hasError) as? Bool ?? false {
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
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Title")).font(.subheadline).foregroundStyle(.secondary)
              TextField(specString("Enter task title"), text: Binding(get: { vm.title as? String ?? "" }, set: { vm.title = $0 }))
              .textFieldStyle(.roundedBorder)
            }
            VStack() {
              if (vm.hasTitleError) as? Bool ?? false {
                Text(verbatim: specString(vm.titleError))
                  .font(.callout.bold())
                  .foregroundStyle(Color(hex: "#db2424"))
              }
            }

          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Notes")).font(.subheadline).foregroundStyle(.secondary)
            TextField(specString("Optional notes..."), text: Binding(get: { vm.notes as? String ?? "" }, set: { vm.notes = $0 }))
            .textFieldStyle(.roundedBorder)
          }
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
            VStack(spacing: ThemeManager.shared.size("spacing-1")) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Assignee")).font(.subheadline).foregroundStyle(.secondary)
                Menu {
                  Picker(specString("Assignee"), selection: Binding(get: { specString(vm.assignee) }, set: { vm.assignee = $0 })) {
                    ForEach(Array(specArr([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                      Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                    }
                  }
                } label: {
                  HStack {
                    Text(verbatim: specString(vm.assignee)).foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                  }
                  .padding(.horizontal, 12).padding(.vertical, 8)
                  .background(Color(.systemBackground))
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                  .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                }
              }
              VStack() {
                if (vm.hasAssigneeError) as? Bool ?? false {
                  Text(verbatim: specString(vm.assigneeError))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#db2424"))
                }
              }

            }

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
          }

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Status")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                Picker(specString("Status"), selection: Binding(get: { specString(vm.status) }, set: { vm.status = $0 })) {
                  ForEach(Array(specArr([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
              } label: {
                HStack {
                  Text(verbatim: specString(vm.status)).foregroundStyle(.primary)
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
          }

          Toggle(specString("Mark as urgent"), isOn: Binding(get: { vm.urgent as? Bool ?? false }, set: { vm.urgent = $0 }))
            .toggleStyle(.automatic)
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            if (vm.isSubmitting) as? Bool ?? false {
              ProgressView(value: (75 as? Double ?? 0) / 100.0)
                .tint(.accentColor)
            }
          }
          .padding(ThemeManager.shared.size("spacing-3"))
          .background(ThemeManager.shared.color("info-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
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
        .padding(ThemeManager.shared.size("spacing-5"))
        .hoverEffect(.highlight)
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
