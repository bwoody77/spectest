import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TaskFormViewModel {
  var title: Any = ""
  var assignee: Any = ""
  var priority: Any = "medium"
  var status: Any = "todo"
  var dueDate: Any? = Optional<Any>.none as Any
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
      await __specFetch("http://localhost:4500/api/tasks", ["method": "POST" as Any, "body": JSON.stringify(["title": title as Any, "assignee": assignee as Any, "priority": priority as Any, "status": status as Any] as [String: Any]) as Any] as [String: Any])
      submitted = true
      submitting = false
      error = ""
    }
  }
  func dismissSuccess() {
    submitted = false
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TaskFormView: View {
  @State private var vm = TaskFormViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TaskFormViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("plus")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Create New Task"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        SpecPopoverHost(trigger: {
          Image(systemName: specIconName(specString("info")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }, content: {
          Text(verbatim: specString("Fill in the required fields (Title and Assignee) then click Create Task."))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        })
      }

      Text(verbatim: specString(vm.formSummary))
        .font(.footnote)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      if (vm.successVisible) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.successVisible) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("success")))
              .foregroundStyle(specAlertColor(specString("success")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Task created!")).font(.subheadline.weight(.semibold))
              Text(specString("Your new task has been added to the backlog.")).font(.subheadline)
            }
            Spacer(minLength: 0)
            Button(action: { vm.dismissSuccess() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.accessibilityLabel("Dismiss")
          }
          .padding(12)
          .background(specAlertColor(specString("success")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      }
      if (vm.hasError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
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

      }
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Title")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
              SpecTextField(specString("Enter task title"), text: Binding(get: { vm.title as? String ?? "" }, set: { newValue in vm.title = newValue; let v: Any = newValue; vm.title = v }))
              .textFieldStyle(.roundedBorder)
              .specAccessibilityLabel(specFieldName("", "Title"))
              .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(vm.hasTitleError) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
            }
            if (vm.hasTitleError) as? Bool ?? false {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString(vm.titleError))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(Color(hex: "#db2424"))
            }

            }
          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Notes")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
            SpecTextEditor(text: Binding(get: { vm.notes as? String ?? "" }, set: { newValue in vm.notes = newValue; let v: Any = newValue; vm.notes = v }))
            .frame(minHeight: 88)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            .specAccessibilityLabel(specFieldName("", "Notes"))
          }
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
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
                    Text(verbatim: specSelectLabel([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any], specString(vm.assignee), "Select assignee").text).foregroundStyle(specSelectLabel([["value": "alice" as Any, "label": "Alice" as Any] as [String: Any], ["value": "bob" as Any, "label": "Bob" as Any] as [String: Any], ["value": "carol" as Any, "label": "Carol" as Any] as [String: Any]] as [Any], specString(vm.assignee), "Select assignee").isPlaceholder ? .secondary : .primary)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                  }
                  .padding(.horizontal, 12).padding(.vertical, 8)
                  .background(Color(.systemBackground))
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                  .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                }
              }
              if (vm.hasAssigneeError) as? Bool ?? false {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString(vm.assigneeError))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#db2424"))
              }

              }
            }

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
          }

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Status")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                if specArr([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                  ForEach(Array(specArr([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    let optValue = specString(specGet(opt, "value"))
                    let optSub = specString(specGet(opt, "sub"))
                    Toggle(isOn: Binding(get: { specString(vm.status) == optValue }, set: { on in if on { Binding(get: { specString(vm.status) }, set: { newValue in vm.status = newValue; let v: Any = newValue; vm.status = v }).wrappedValue = optValue } })) {
                      Text(specString(specGet(opt, "label")))
                      if !optSub.isEmpty { Text(optSub) }
                    }
                  }
                } else {
                Picker(specString("Status"), selection: Binding(get: { specString(vm.status) }, set: { newValue in vm.status = newValue; let v: Any = newValue; vm.status = v })) {
                  ForEach(Array(specArr([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
                }
              } label: {
                HStack {
                  Text(verbatim: specSelectLabel([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any], specString(vm.status), "").text).foregroundStyle(specSelectLabel([["value": "todo" as Any, "label": "Todo" as Any] as [String: Any], ["value": "in-progress" as Any, "label": "In Progress" as Any] as [String: Any], ["value": "done" as Any, "label": "Done" as Any] as [String: Any]] as [Any], specString(vm.status), "").isPlaceholder ? .secondary : .primary)
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
              SpecOptionalDatePicker(text: Binding(get: { specString(vm.dueDate) }, set: { newValue in vm.dueDate = newValue; let v: Any = newValue; vm.dueDate = v }), format: "YYYY-MM-DD", placeholder: "Pick a date", label: "Due Date", ariaLabel: "", disabled: false, error: false, errorMessage: "")
            }
          }

          Toggle(specString("Mark as urgent"), isOn: Binding(get: { specTruthy(vm.urgent) }, set: { newValue in let v: Any = newValue; vm.urgent = v }))
            .toggleStyle(SpecCheckToggleStyle(tint: nil))
          if (vm.isSubmitting) as? Bool ?? false {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            if (vm.isSubmitting) as? Bool ?? false {
              ProgressView(value: (75 as? Double ?? 0) / 100.0)
                .tint(.accentColor)
            }
          }
          .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-interactive")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .center)
          .background(ThemeManager.shared.color("info-bg"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-interactive"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          }
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Button(action: { specClick { Task { @MainActor in await vm.submitForm() } } }) {
              Text(specString("Create Task"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: {  }) {
              Text(specString("Reset"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .hoverEffect(.highlight)
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
