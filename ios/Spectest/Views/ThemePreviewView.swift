import SwiftUI
import SpecRuntime

@Observable
final class ThemePreviewViewModel {
  var inputValue: Any = ""
  var selectValue: Any = ""
  var checkboxChecked: Any = false
  var toggleChecked: Any = false
  var checkboxNewsletter: Any = true
  var toggleNotifications: Any = true
  var radioValue: Any = "option1"
  var accordionMultiple: Any = false
  var activeTab: Any = "overview"
  var stepperStep: Any = 1
  var pickedDate: Any? = nil
  var modalOpen: Any = false
  var drawerOpen: Any = false
  var confirmOpen: Any = false
  var confirmDestructiveOpen: Any = false
  var breadcrumbMax: Any = 0
  var passwordValue: Any = ""
  var emailValue: Any = ""
  var searchValue: Any = ""
  var numberValue: Any = ""
  var textareaValue: Any = ""
  var prefixValue: Any = ""
  var paginationPage: Any = 1
  var sliderValue: Any = 50
  var select2Value: Any = ""
  var cmdPaletteOpen: Any = false
  var sidebarItem: Any = "dashboard"
  var sidebarCollapsed: Any = false
  var stepper2Step: Any = 0
  var toastsVisible: Any = true
  var cmpMsSpec: Any = [] as [Any]
  var msDisplay: Any = "chips"
  var msMode: Any = "dropdown"
  var msSearchable: Any = true
  var msShowCheckbox: Any = true
  var cmpToastSpecVisible: Any = true
  var treeExpandMode: Any = "icon"
  var treeSelectedName: Any = ""
  var cmpGridRows: Any = [["id": "1" as Any, "name": "Alice" as Any, "role": "Engineer" as Any, "status": "Active" as Any] as [String: Any], ["id": "2" as Any, "name": "Bob" as Any, "role": "Designer" as Any, "status": "Active" as Any] as [String: Any], ["id": "3" as Any, "name": "Carol" as Any, "role": "PM" as Any, "status": "On Leave" as Any] as [String: Any], ["id": "4" as Any, "name": "Dave" as Any, "role": "Engineer" as Any, "status": "Active" as Any] as [String: Any]] as [Any]
  var progressValue: Any { 65 }
  var progressHalf: Any { 40 }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setInput(_ v: Any) {
    inputValue = v
  }
  func setSelect(_ v: Any) {
    selectValue = v
  }
  func setCheckbox(_ v: Any) {
    checkboxChecked = v
  }
  func setToggle(_ v: Any) {
    toggleChecked = v
  }
  func setCheckboxNewsletter(_ v: Any) {
    checkboxNewsletter = v
  }
  func setToggleNotifications(_ v: Any) {
    toggleNotifications = v
  }
  func setRadio(_ v: Any) {
    radioValue = v
  }
  func setAccordionMultiple(_ v: Any) {
    accordionMultiple = v
  }
  func setTab(_ id: Any) {
    activeTab = id
  }
  func nextStep() {
    stepperStep = ((specDouble(stepperStep) < specDouble(4)) ? specAdd(stepperStep, 1) : 1)
  }
  func prevStep() {
    stepperStep = ((specDouble(stepperStep) > specDouble(1)) ? (specDouble(stepperStep) - specDouble(1)) : 1)
  }
  func setDate(_ d: Any) {
    pickedDate = d
  }
  func openModal() {
    modalOpen = true
  }
  func closeModal() {
    modalOpen = false
  }
  func openDrawer() {
    drawerOpen = true
  }
  func closeDrawer() {
    drawerOpen = false
  }
  func openConfirm() {
    confirmOpen = true
  }
  func closeConfirm() {
    confirmOpen = false
  }
  func openConfirmDestructive() {
    confirmDestructiveOpen = true
  }
  func closeConfirmDestructive() {
    confirmDestructiveOpen = false
  }
  func setBreadcrumbMax(_ n: Any) {
    breadcrumbMax = n
  }
  func setPassword(_ v: Any) {
    passwordValue = v
  }
  func setEmail(_ v: Any) {
    emailValue = v
  }
  func setSearch(_ v: Any) {
    searchValue = v
  }
  func setNumber(_ v: Any) {
    numberValue = v
  }
  func setTextarea(_ v: Any) {
    textareaValue = v
  }
  func setPrefix(_ v: Any) {
    prefixValue = v
  }
  func setPaginationPage(_ p: Any) {
    paginationPage = p
  }
  func setSliderValue(_ v: Any) {
    sliderValue = v
  }
  func setSelect2(_ v: Any) {
    select2Value = v
  }
  func openCmdPalette() {
    cmdPaletteOpen = true
  }
  func closeCmdPalette() {
    cmdPaletteOpen = false
  }
  func selectCmd(_ id: Any) {
    cmdPaletteOpen = false
  }
  func setSidebarItem(_ id: Any) {
    sidebarItem = id
  }
  func setSidebarCollapsed(_ v: Any) {
    sidebarCollapsed = v
  }
  func setStepper2Step(_ n: Any) {
    stepper2Step = n
  }
  func nextStepper2() {
    stepper2Step = ((specDouble(stepper2Step) < specDouble(3)) ? specAdd(stepper2Step, 1) : 0)
  }
  func prevStepper2() {
    stepper2Step = ((specDouble(stepper2Step) > specDouble(0)) ? (specDouble(stepper2Step) - specDouble(1)) : 0)
  }
  func dismissToasts() {
    toastsVisible = false
  }
  func showToasts() {
    toastsVisible = true
  }
  func setCmpMsSpec(_ v: Any) {
    cmpMsSpec = v
  }
  func setMsDisplay(_ v: Any) {
    msDisplay = v
  }
  func setMsMode(_ v: Any) {
    msMode = v
  }
  func setMsSearchable(_ v: Any) {
    msSearchable = v
  }
  func setMsShowCheckbox(_ v: Any) {
    msShowCheckbox = v
  }
  func dismissCmpToastSpec() {
    cmpToastSpecVisible = false
  }
  func showCmpToasts() {
    cmpToastSpecVisible = true
  }
  func toggleTreeExpandMode() {
    treeExpandMode = (specEq(treeExpandMode, "icon") ? "row" : "icon")
  }
  func setTreeSelected(_ id: Any) {
    treeSelectedName = id
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ThemePreviewView: View {
  @State private var vm = ThemePreviewViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      Text(verbatim: specString("Component Showcase"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Switch themes above to compare how each one styles these components."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      Text(verbatim: specString("Component Comparison"))
        .font(.title3.bold())
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Spec-compiled components. List and EditableGrid still show side-by-side TS comparison."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("List"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-5")) {
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Text(verbatim: specString("Spec"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              ListView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Text(verbatim: specString("TS"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("warning"))
              ListTSView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(maxWidth: .infinity)
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Tree"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            Button(action: { Task { @MainActor in await vm.toggleTreeExpandMode() } }) {
              Text(specString(specAdd("Mode: ", vm.treeExpandMode)))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(specString("outline") == "primary" ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(specString("outline") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
            }
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              if specNeq(vm.treeSelectedName, "") {
                Text(verbatim: specString("Selected:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(specString(vm.treeSelectedName))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("default")))
                  .background(specBadgeBackground(specString("default")), in: Capsule())
              }
            }

            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          TreeView(expanded: ["src"] as [Any], expandMode: vm.treeExpandMode, nodes: [["id": "src" as Any, "label": "src" as Any, "icon": "folder" as Any, "children": [["id": "app" as Any, "label": "app.spec" as Any, "icon": "code" as Any] as [String: Any], ["id": "components" as Any, "label": "components" as Any, "icon": "layers" as Any, "children": [["id": "btn" as Any, "label": "button.spec" as Any, "icon": "code" as Any] as [String: Any], ["id": "card" as Any, "label": "card.spec" as Any, "icon": "code" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "utils" as Any, "label": "utils.js" as Any, "icon": "terminal" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "pkg" as Any, "label": "package.json" as Any, "icon": "package" as Any] as [String: Any], ["id": "cfg" as Any, "label": "spec.config.json" as Any, "icon": "settings" as Any] as [String: Any]] as [Any], selection: "single")
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Toast"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack() {
            if (vm.cmpToastSpecVisible) as? Bool ?? false {
              HStack(spacing: 8) {
                Image(systemName: specAlertIcon(specString("success")))
                  .foregroundStyle(specAlertColor(specString("success")))
                Text(specString("Operation completed!")).font(.subheadline)
                Spacer(minLength: 0)
              }
              .padding(12)
              .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
              .shadow(radius: 4)
            }
          }

          VStack() {
            if specEq(vm.cmpToastSpecVisible, false) {
              Button(action: { Task { @MainActor in await vm.showCmpToasts() } }) {
                Text(specString("Reset Toast"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack() {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("EditableGrid"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("Click a cell then press Enter to edit. Arrow keys to navigate."))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-5")) {
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Text(verbatim: specString("Spec"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              EditableGridSpecView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Text(verbatim: specString("TS"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("warning"))
              EditableGridTSView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(maxWidth: .infinity)
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack(spacing: ThemeManager.shared.size("spacing-5")) {
        VStack(spacing: ThemeManager.shared.size("spacing-5")) {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Buttons"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                  Button(action: {  }) {
                    Text(specString("Primary"))
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                  }
                  Button(action: {  }) {
                    Text(specString("Secondary"))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                  Button(action: {  }) {
                    Text(specString("Ghost"))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                  }
                  Button(action: {  }) {
                    Text(specString("Destructive"))
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
                  }
                }

                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                  Button(action: {  }) {
                    Text(specString("Disabled"))
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                  }
                  .disabled(true as? Bool ?? false)
                  Button(action: {  }) {
                    Text(specString("Loading"))
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                  }
                }

              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Badges"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Text(specString("Info"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("info")))
                  .background(specBadgeBackground(specString("info")), in: Capsule())
                Text(specString("Success"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("success")))
                  .background(specBadgeBackground(specString("success")), in: Capsule())
                Text(specString("Warning"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("warning")))
                  .background(specBadgeBackground(specString("warning")), in: Capsule())
                Text(specString("Error"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("error")))
                  .background(specBadgeBackground(specString("error")), in: Capsule())
                Text(specString("Neutral"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("neutral")))
                  .background(specBadgeBackground(specString("neutral")), in: Capsule())
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Table"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              TableView(columns: [["key": "name" as Any, "header": "Name" as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], rows: [["name": "Alice" as Any, "role": "Engineer" as Any, "status": "Active" as Any] as [String: Any], ["name": "Bob" as Any, "role": "Designer" as Any, "status": "Away" as Any] as [String: Any], ["name": "Carol" as Any, "role": "Manager" as Any, "status": "Active" as Any] as [String: Any]] as [Any], striped: true)
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              HStack(alignment: .center) {
                Text(verbatim: specString("Accordion (Spec Component)"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Spacer(minLength: 0)
                Toggle(specString("Allow multiple"), isOn: Binding(get: { vm.accordionMultiple as? Bool ?? false }, set: { vm.accordionMultiple = $0 }))
              }
              .frame(maxWidth: .infinity)

              DisclosureGroup(specString("")) {
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Breadcrumb"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("maxVisible:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Spacer(minLength: 0)
                Button(action: { Task { @MainActor in await vm.setBreadcrumbMax(0) } }) {
                  Text(specString("0 (off)"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.setBreadcrumbMax(2) } }) {
                  Text(specString("2"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.setBreadcrumbMax(3) } }) {
                  Text(specString("3"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.setBreadcrumbMax(4) } }) {
                  Text(specString("4"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.setBreadcrumbMax(5) } }) {
                  Text(specString("5"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
              }
              .frame(maxWidth: .infinity)

              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Short path (4 items)"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                HStack(spacing: 4) {
                  ForEach(Array(([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": "products" as Any, "label": "Products" as Any] as [String: Any], ["id": "electronics" as Any, "label": "Electronics" as Any] as [String: Any], ["id": "phones" as Any, "label": "Phones" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { idx, crumb in
                    if idx > 0 {
                      Image(systemName: "chevron.right").font(.caption2).foregroundStyle(.tertiary)
                    }
                    Text(specString((crumb as? [String: Any])?["label"] ?? crumb))
                      .font(.subheadline)
                      .foregroundStyle(idx < ([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": "products" as Any, "label": "Products" as Any] as [String: Any], ["id": "electronics" as Any, "label": "Electronics" as Any] as [String: Any], ["id": "phones" as Any, "label": "Phones" as Any] as [String: Any]] as [Any] as? [Any] ?? []).count - 1 ? .secondary : .primary)
                  }
                }
              }

              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Long path (6 items)"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                HStack(spacing: 4) {
                  ForEach(Array(([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": "admin" as Any, "label": "Administrative Dashboard" as Any] as [String: Any], ["id": "region" as Any, "label": "North America" as Any] as [String: Any], ["id": "sales" as Any, "label": "Regional Sales" as Any] as [String: Any], ["id": "q4" as Any, "label": "Q4 2025 Results" as Any] as [String: Any], ["id": "detail" as Any, "label": "Monthly Breakdown" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { idx, crumb in
                    if idx > 0 {
                      Image(systemName: "chevron.right").font(.caption2).foregroundStyle(.tertiary)
                    }
                    Text(specString((crumb as? [String: Any])?["label"] ?? crumb))
                      .font(.subheadline)
                      .foregroundStyle(idx < ([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": "admin" as Any, "label": "Administrative Dashboard" as Any] as [String: Any], ["id": "region" as Any, "label": "North America" as Any] as [String: Any], ["id": "sales" as Any, "label": "Regional Sales" as Any] as [String: Any], ["id": "q4" as Any, "label": "Q4 2025 Results" as Any] as [String: Any], ["id": "detail" as Any, "label": "Monthly Breakdown" as Any] as [String: Any]] as [Any] as? [Any] ?? []).count - 1 ? .secondary : .primary)
                  }
                }
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Tabs"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: 0) {
                Picker("", selection: Binding(get: { specString(vm.activeTab) }, set: { vm.activeTab = $0 })) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, tab in
                    Text(specString((tab as? [String: Any])?["label"] ?? tab)).tag(specString((tab as? [String: Any])?["value"] ?? tab))
                  }
                }
                .pickerStyle(.segmented)
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              Text(verbatim: specString("Typography"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Display Large"))
                .font(.largeTitle.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Large"))
                .font(.title2.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Medium"))
                .font(.title3.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Small"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Body text — The quick brown fox jumps over the lazy dog. This is regular paragraph text that demonstrates the body font at its default size and weight."))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Label Medium"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Caption — supplementary information"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Skeleton"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemGroupedBackground))
                .frame(height: CGFloat(48))
                .overlay(ProgressView())
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Empty State"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              ContentUnavailableView(specString("No items found"), systemImage: "tray", description: Text(specString("Try adjusting your filters or create a new item.")))
                .frame(height: 200)
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Card Container"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Card Title"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Text(verbatim: specString("This is a Card component used as a container."))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
                .padding(ThemeManager.shared.size("spacing-4"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity)
        VStack(spacing: ThemeManager.shared.size("spacing-5")) {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Progress"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                  Text(verbatim: specString("65%"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack() {
                    ProgressView(value: (vm.progressValue as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(maxWidth: .infinity)
                }

                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                  Text(verbatim: specString("40%"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack() {
                    ProgressView(value: (vm.progressHalf as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(maxWidth: .infinity)
                }

              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              Text(verbatim: specString("Alerts"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .top, spacing: 12) {
                Image(systemName: specAlertIcon(specString("success")))
                  .foregroundStyle(specAlertColor(specString("success")))
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Success")).font(.subheadline.weight(.semibold))
                  Text(specString("Operation completed.")).font(.subheadline)
                }
                Spacer(minLength: 0)
              }
              .padding(12)
              .background(specAlertColor(specString("success")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
              HStack(alignment: .top, spacing: 12) {
                Image(systemName: specAlertIcon(specString("error")))
                  .foregroundStyle(specAlertColor(specString("error")))
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Error")).font(.subheadline.weight(.semibold))
                  Text(specString("Something went wrong.")).font(.subheadline)
                }
                Spacer(minLength: 0)
              }
              .padding(12)
              .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
              HStack(alignment: .top, spacing: 12) {
                Image(systemName: specAlertIcon(specString("warning")))
                  .foregroundStyle(specAlertColor(specString("warning")))
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Warning")).font(.subheadline.weight(.semibold))
                  Text(specString("Cannot be undone.")).font(.subheadline)
                }
                Spacer(minLength: 0)
              }
              .padding(12)
              .background(specAlertColor(specString("warning")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
              HStack(alignment: .top, spacing: 12) {
                Image(systemName: specAlertIcon(specString("info")))
                  .foregroundStyle(specAlertColor(specString("info")))
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Info")).font(.subheadline.weight(.semibold))
                  Text(specString("New features available.")).font(.subheadline)
                }
                Spacer(minLength: 0)
              }
              .padding(12)
              .background(specAlertColor(specString("info")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Timeline"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(([["id": "1" as Any, "title": "Order placed" as Any, "description": "Order #1234 confirmed" as Any, "date": "Jan 15" as Any, "status": "completed" as Any] as [String: Any], ["id": "2" as Any, "title": "Processing" as Any, "description": "Payment verified" as Any, "date": "Jan 16" as Any, "status": "completed" as Any] as [String: Any], ["id": "3" as Any, "title": "Shipped" as Any, "description": "In transit via FedEx" as Any, "date": "Jan 17" as Any, "status": "active" as Any] as [String: Any], ["id": "4" as Any, "title": "Delivered" as Any, "description": "Estimated Jan 20" as Any, "date": "" as Any, "status": "pending" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { idx, item in
                  HStack(alignment: .top, spacing: 12) {
                    VStack(spacing: 0) {
                      Circle().fill(Color.blue).frame(width: 10, height: 10)
                      if idx < ([["id": "1" as Any, "title": "Order placed" as Any, "description": "Order #1234 confirmed" as Any, "date": "Jan 15" as Any, "status": "completed" as Any] as [String: Any], ["id": "2" as Any, "title": "Processing" as Any, "description": "Payment verified" as Any, "date": "Jan 16" as Any, "status": "completed" as Any] as [String: Any], ["id": "3" as Any, "title": "Shipped" as Any, "description": "In transit via FedEx" as Any, "date": "Jan 17" as Any, "status": "active" as Any] as [String: Any], ["id": "4" as Any, "title": "Delivered" as Any, "description": "Estimated Jan 20" as Any, "date": "" as Any, "status": "pending" as Any] as [String: Any]] as [Any] as? [Any] ?? []).count - 1 {
                        Rectangle().fill(Color(.separator)).frame(width: 2).frame(maxHeight: .infinity)
                      }
                    }
                    VStack(alignment: .leading, spacing: 2) {
                      Text(specString((item as? [String: Any])?["title"])).font(.subheadline.weight(.medium))
                      Text(specString((item as? [String: Any])?["description"])).font(.caption).foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 16)
                  }
                }
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Form Controls"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Text Input")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Type something..."), text: Binding(get: { vm.inputValue as? String ?? "" }, set: { vm.inputValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Password")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Enter password..."), text: Binding(get: { vm.passwordValue as? String ?? "" }, set: { vm.passwordValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("you@example.com"), text: Binding(get: { vm.emailValue as? String ?? "" }, set: { vm.emailValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Search")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Search..."), text: Binding(get: { vm.searchValue as? String ?? "" }, set: { vm.searchValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                  .textContentType(.none)
                  .autocorrectionDisabled()
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Number")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("0"), text: Binding(get: { vm.numberValue as? String ?? "" }, set: { vm.numberValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Message")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Write here..."), text: Binding(get: { vm.textareaValue as? String ?? "" }, set: { vm.textareaValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Amount")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Amount"), text: Binding(get: { vm.prefixValue as? String ?? "" }, set: { vm.prefixValue = $0 }))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Username")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Username"), text: .constant(""))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Disabled")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Disabled"), text: .constant(""))
                  .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 4) {
                  if !specString("Pick a Date").isEmpty {
                    Text(specString("Pick a Date")).font(.subheadline).foregroundStyle(.secondary)
                  }
                  DatePicker("", selection: .constant(Date()), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Dropdown")).font(.subheadline).foregroundStyle(.secondary)
                  Menu {
                    Picker(specString("Dropdown"), selection: Binding(get: { specString(vm.selectValue) }, set: { vm.selectValue = $0 })) {
                      ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                        Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                      }
                    }
                  } label: {
                    HStack {
                      Text(verbatim: specString(vm.selectValue)).foregroundStyle(.primary)
                      Spacer()
                      Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                    }
                    .padding(.horizontal, 12).padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                  }
                }
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("MultiSelect options"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                    Text(verbatim: specString("display:"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    Spacer(minLength: 0)
                    Picker("", selection: Binding(get: { specString(vm.msDisplay) }, set: { vm.msDisplay = $0 })) {
                      Text("chips").tag("chips")
                      Text("text").tag("text")
                    }
                    .pickerStyle(.segmented)
                  }
                  .frame(maxWidth: .infinity)

                  HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                    Text(verbatim: specString("mode:"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    Spacer(minLength: 0)
                    Picker("", selection: Binding(get: { specString(vm.msMode) }, set: { vm.msMode = $0 })) {
                      Text("dropdown").tag("dropdown")
                      Text("list").tag("list")
                    }
                    .pickerStyle(.segmented)
                  }
                  .frame(maxWidth: .infinity)

                  HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                    Toggle(specString("searchable"), isOn: Binding(get: { vm.msSearchable as? Bool ?? false }, set: { vm.msSearchable = $0 }))
                    Toggle(specString("showCheckbox"), isOn: Binding(get: { vm.msShowCheckbox as? Bool ?? false }, set: { vm.msShowCheckbox = $0 }))
                  }

                }
                .padding(ThemeManager.shared.size("spacing-3"))
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                MultiSelectView(display: vm.msDisplay, label: "Tags", mode: vm.msMode, options: [["value": "bug" as Any, "label": "Bug" as Any] as [String: Any], ["value": "feature" as Any, "label": "Feature" as Any] as [String: Any], ["value": "docs" as Any, "label": "Docs" as Any] as [String: Any], ["value": "refactor" as Any, "label": "Refactor" as Any] as [String: Any]] as [Any], placeholder: "Select tags...", searchable: vm.msSearchable, showCheckbox: vm.msShowCheckbox, values: vm.cmpMsSpec)
                Text(verbatim: specString("Checkboxes"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Toggle(specString("Accept terms"), isOn: Binding(get: { vm.checkboxChecked as? Bool ?? false }, set: { vm.checkboxChecked = $0 }))
                  .toggleStyle(.automatic)
                Toggle(specString("Subscribe to newsletter"), isOn: Binding(get: { vm.checkboxNewsletter as? Bool ?? false }, set: { vm.checkboxNewsletter = $0 }))
                  .toggleStyle(.automatic)
                Toggle(specString("Disabled option"), isOn: .constant(false))
                  .toggleStyle(.automatic)
                Text(verbatim: specString("Toggles"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Toggle(specString("Dark mode"), isOn: Binding(get: { vm.toggleChecked as? Bool ?? false }, set: { vm.toggleChecked = $0 }))
                Toggle(specString("Notifications"), isOn: Binding(get: { vm.toggleNotifications as? Bool ?? false }, set: { vm.toggleNotifications = $0 }))
                Toggle(specString("Disabled toggle"), isOn: .constant(false))
                Text(verbatim: specString("Radio Buttons"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Picker(specString("Option 1"), selection: .constant("")) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                    Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                  }
                }
                .pickerStyle(.segmented)
                Picker(specString("Option 2"), selection: .constant("")) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                    Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                  }
                }
                .pickerStyle(.segmented)
                Picker(specString("Option 3"), selection: .constant("")) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                    Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                  }
                }
                .pickerStyle(.segmented)
                Picker(specString("Disabled"), selection: .constant("")) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                    Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                  }
                }
                .pickerStyle(.segmented)
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Stat"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("star")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("$12,345")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Revenue")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .background(ThemeManager.shared.color("gradient-stat-primary"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
                .hoverEffect(.highlight)
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("user")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("success"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("1,234")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Users")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .background(ThemeManager.shared.color("gradient-stat-success"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
                .hoverEffect(.highlight)
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("loader")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("warning"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("5,678")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Sessions")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .background(ThemeManager.shared.color("gradient-stat-warning"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
                .hoverEffect(.highlight)
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Image"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-4")) {
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Normal"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  AsyncImage(url: URL(string: specString("https://picsum.photos/300/200"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Photo"))
                }

                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Fallback"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  AsyncImage(url: URL(string: specString("https://invalid.example.com/x.jpg"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Fallback"))
                }

                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Lazy"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  AsyncImage(url: URL(string: specString("https://picsum.photos/300/200?r=3"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Lazy"))
                }

              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              Text(verbatim: specString("Toast (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                if (vm.toastsVisible) as? Bool ?? false {
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("success")))
                      .foregroundStyle(specAlertColor(specString("success")))
                    Text(specString("Operation completed successfully!")).font(.subheadline)
                    Spacer(minLength: 0)
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("error")))
                      .foregroundStyle(specAlertColor(specString("error")))
                    Text(specString("Something went wrong. Please try again.")).font(.subheadline)
                    Spacer(minLength: 0)
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("warning")))
                      .foregroundStyle(specAlertColor(specString("warning")))
                    Text(specString("This action cannot be undone.")).font(.subheadline)
                    Spacer(minLength: 0)
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("info")))
                      .foregroundStyle(specAlertColor(specString("info")))
                    Text(specString("New features are available.")).font(.subheadline)
                    Spacer(minLength: 0)
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                }
              }

              VStack() {
                if ((!((vm.toastsVisible) as? Bool ?? false))) as? Bool ?? false {
                  Button(action: { Task { @MainActor in await vm.showToasts() } }) {
                    Text(specString("Show Toasts"))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                }
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Modal (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                Button(action: { Task { @MainActor in await vm.openModal() } }) {
                  Text(specString("Open Modal"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                }
              }

              EmptyView().sheet(isPresented: Binding(get: { vm.modalOpen as? Bool ?? false }, set: { vm.modalOpen = $0 })) {
                NavigationStack {
                  VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                    Text(verbatim: specString("This is a modal dialog built entirely in Spec."))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    Text(verbatim: specString("It supports focus trapping, scroll locking, and backdrop click to close."))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  }

                  .navigationTitle(specString("Example Modal"))
                  .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { vm.modalOpen = false } } }
                }
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Drawer (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                Button(action: { Task { @MainActor in await vm.openDrawer() } }) {
                  Text(specString("Open Drawer"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              EmptyView().sheet(isPresented: Binding(get: { vm.drawerOpen as? Bool ?? false }, set: { vm.drawerOpen = $0 })) {
                VStack {
                  VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                    Text(verbatim: specString("Dashboard"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Settings"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Profile"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Help"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  }

                }
                .presentationDetents([.medium, .large])
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Confirm Dialog (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                Button(action: { Task { @MainActor in await vm.openConfirm() } }) {
                  Text(specString("Confirm Action"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.openConfirmDestructive() } }) {
                  Text(specString("Delete Item"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              EmptyView().confirmationDialog(specString("Save Changes?"), isPresented: Binding(get: { vm.confirmOpen as? Bool ?? false }, set: { vm.confirmOpen = $0 })) {
                Button("Confirm") { Task { @MainActor in await vm.closeConfirm() } }
                Button("Cancel", role: .cancel) {}
              } message: {
                Text(specString("Would you like to save your changes before leaving?"))
              }
              EmptyView().confirmationDialog(specString("Delete Item"), isPresented: Binding(get: { vm.confirmDestructiveOpen as? Bool ?? false }, set: { vm.confirmDestructiveOpen = $0 })) {
                Button("Confirm") { Task { @MainActor in await vm.closeConfirmDestructive() } }
                Button("Cancel", role: .cancel) {}
              } message: {
                Text(specString("This action cannot be undone. Are you sure you want to delete this item?"))
              }
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity)
      }

      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Text"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(spacing: ThemeManager.shared.size("spacing-3")) {
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Stack"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack() {
            Text(specString("A"))
              .font(.caption.weight(.medium))
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .foregroundStyle(specBadgeForeground(specString("info")))
              .background(specBadgeBackground(specString("info")), in: Capsule())
            Text(specString("B"))
              .font(.caption.weight(.medium))
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .foregroundStyle(specBadgeForeground(specString("success")))
              .background(specBadgeBackground(specString("success")), in: Capsule())
            Text(specString("C"))
              .font(.caption.weight(.medium))
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .foregroundStyle(specBadgeForeground(specString("warning")))
              .background(specBadgeBackground(specString("warning")), in: Capsule())
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Pagination"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(spacing: 8) {
            Button(action: { vm.paginationPage = (vm.paginationPage as? Int ?? 1) - 1 }) {
              Image(systemName: "chevron.left")
            }
            .disabled((vm.paginationPage as? Int ?? 1) <= 1)
            Text("\(specString(vm.paginationPage)) / \(specString(100))")
              .font(.subheadline).monospacedDigit()
            Button(action: { vm.paginationPage = (vm.paginationPage as? Int ?? 1) + 1 }) {
              Image(systemName: "chevron.right")
            }
            .disabled((vm.paginationPage as? Int ?? 1) >= (100 as? Int ?? 1))
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("TimePicker"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          TimePickerView(format: "12", label: "Meeting Time")
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Stepper"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          StepperView(activeStep: vm.stepper2Step, steps: [["label": "Account" as Any] as [String: Any], ["label": "Profile" as Any] as [String: Any], ["label": "Review" as Any] as [String: Any], ["label": "Complete" as Any] as [String: Any]] as [Any])
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            Button(action: { Task { @MainActor in await vm.prevStepper2() } }) {
              Text(specString("Previous"))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: { Task { @MainActor in await vm.nextStepper2() } }) {
              Text(specString("Next Step"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.blue, in: RoundedRectangle(cornerRadius: 8))
            }
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Slider"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Slider(value: Binding(get: { vm.sliderValue as? Double ?? 0 }, set: { vm.sliderValue = $0 }), in: (0 as? Double ?? 0)...(100 as? Double ?? 100))
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack() {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Select"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Framework")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              Picker(specString("Framework"), selection: Binding(get: { specString(vm.select2Value) }, set: { vm.select2Value = $0 })) {
                ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
            } label: {
              HStack {
                Text(verbatim: specString(vm.select2Value)).foregroundStyle(.primary)
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
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack() {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Tooltip"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
            Text(specString("Top tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Bottom tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Left tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Right tooltip")).font(.caption).foregroundStyle(.tertiary)
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack() {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Popover"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
            EmptyView().popover(isPresented: .constant(false)) {
            }
            EmptyView().popover(isPresented: .constant(false)) {
            }
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Command Palette"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Button(action: { Task { @MainActor in await vm.openCmdPalette() } }) {
            Text(specString("Open Command Palette"))
              .font(.subheadline.weight(.medium))
              .foregroundStyle(.blue)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
              .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
          }
          CommandPaletteView(commands: [["id": "new" as Any, "label": "New File" as Any, "shortcut": "Ctrl+N" as Any] as [String: Any], ["id": "open" as Any, "label": "Open File" as Any, "shortcut": "Ctrl+O" as Any] as [String: Any], ["id": "save" as Any, "label": "Save" as Any, "shortcut": "Ctrl+S" as Any] as [String: Any], ["id": "settings" as Any, "label": "Open Settings" as Any, "description": "Configure preferences" as Any] as [String: Any], ["id": "theme" as Any, "label": "Change Theme" as Any, "description": "Switch color theme" as Any] as [String: Any]] as [Any], open: vm.cmdPaletteOpen)
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Sidebar"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack() {
            SidebarView(activeItem: vm.sidebarItem, collapsed: vm.sidebarCollapsed, sections: [["title": "Main" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "star" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["title": "Account" as Any, "items": [["id": "profile" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any], ["id": "logout" as Any, "label": "Logout" as Any, "icon": "arrowRight" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any])
          }
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
          .specFrameHeight(CGFloat(300))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
