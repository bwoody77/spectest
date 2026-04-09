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
    stepperStep = (((stepperStep as? Double ?? 0) < (4 as? Double ?? 0)) ? specAdd(stepperStep, 1) : 1)
  }
  func prevStep() {
    stepperStep = (((stepperStep as? Double ?? 0) > (1 as? Double ?? 0)) ? ((stepperStep as? Double ?? 0) - (1 as? Double ?? 0)) : 1)
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
    stepper2Step = (((stepper2Step as? Double ?? 0) < (3 as? Double ?? 0)) ? specAdd(stepper2Step, 1) : 0)
  }
  func prevStepper2() {
    stepper2Step = (((stepper2Step as? Double ?? 0) > (0 as? Double ?? 0)) ? ((stepper2Step as? Double ?? 0) - (1 as? Double ?? 0)) : 0)
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
    treeExpandMode = ((specString(treeExpandMode) == specString("icon")) ? "row" : "icon")
  }
  func setTreeSelected(_ id: Any) {
    treeSelectedName = id
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ThemePreviewView: View {
  @State private var vm = ThemePreviewViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(specString("Component Showcase"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(specString("Switch themes above to compare how each one styles these components."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      Text(specString("Component Comparison"))
        .font(.title3.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(specString("Spec-compiled components. List and EditableGrid still show side-by-side TS comparison."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("List"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          HStack(alignment: .center, spacing: CGFloat(20)) {
            VStack(spacing: CGFloat(8)) {
              Text(specString("Spec"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
              ListView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
            VStack(spacing: CGFloat(8)) {
              Text(specString("TS"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.warning"))
              ListTSView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Tree"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          HStack(alignment: .center, spacing: CGFloat(12)) {
            Button(action: { Task { @MainActor in await vm.toggleTreeExpandMode() } }) {
              Text(specString(specAdd("Mode: ", vm.treeExpandMode)))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(specString("outline") == "primary" ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(specString("outline") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
            }
            HStack(alignment: .center, spacing: CGFloat(4)) {
              if (specString(vm.treeSelectedName) != specString("")) {
                Text(specString("Selected:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Toast"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          VStack() {
            if vm.cmpToastSpecVisible as? Bool ?? false {
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
            if (specString(vm.cmpToastSpecVisible) == specString(false)) {
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack() {
        VStack(spacing: CGFloat(16)) {
          Text(specString("EditableGrid"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(specString("Click a cell then press Enter to edit. Arrow keys to navigate."))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
          HStack(alignment: .center, spacing: CGFloat(20)) {
            VStack(spacing: CGFloat(8)) {
              Text(specString("Spec"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
              EditableGridSpecView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
            VStack(spacing: CGFloat(8)) {
              Text(specString("TS"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.warning"))
              EditableGridTSView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }

        }
        .padding(CGFloat(20))
      }
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack(spacing: CGFloat(20)) {
        VStack(spacing: CGFloat(20)) {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Buttons"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(12)) {
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

                HStack(alignment: .center, spacing: CGFloat(12)) {
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Badges"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, spacing: CGFloat(8)) {
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Table"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              TableView(columns: [["key": "name" as Any, "header": "Name" as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], rows: [["name": "Alice" as Any, "role": "Engineer" as Any, "status": "Active" as Any] as [String: Any], ["name": "Bob" as Any, "role": "Designer" as Any, "status": "Away" as Any] as [String: Any], ["name": "Carol" as Any, "role": "Manager" as Any, "status": "Active" as Any] as [String: Any]] as [Any], striped: true)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              HStack(alignment: .center, ) {
                Text(specString("Accordion (Spec Component)"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Spacer(minLength: 0)
                Toggle(specString("Allow multiple"), isOn: Binding(get: { vm.accordionMultiple as? Bool ?? false }, set: { vm.accordionMultiple = $0 }))
              }
              .frame(maxWidth: .infinity)

              DisclosureGroup(specString("")) {
              }
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Breadcrumb"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, spacing: CGFloat(8)) {
                Text(specString("maxVisible:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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

              VStack(spacing: CGFloat(8)) {
                Text(specString("Short path (4 items)"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
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

              VStack(spacing: CGFloat(8)) {
                Text(specString("Long path (6 items)"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Tabs"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: 0) {
                Picker("", selection: Binding(get: { specString(vm.activeTab) }, set: { vm.activeTab = $0 })) {
                  ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, tab in
                    Text(specString((tab as? [String: Any])?["label"] ?? tab)).tag(specString((tab as? [String: Any])?["value"] ?? tab))
                  }
                }
                .pickerStyle(.segmented)
              }
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(12)) {
              Text(specString("Typography"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Display Large"))
                .font(.largeTitle.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Heading Large"))
                .font(.title2.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Heading Medium"))
                .font(.title3.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Heading Small"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Body text — The quick brown fox jumps over the lazy dog. This is regular paragraph text that demonstrates the body font at its default size and weight."))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              Text(specString("Label Medium"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(specString("Caption — supplementary information"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Skeleton"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemGroupedBackground))
                .frame(height: CGFloat(48))
                .overlay(ProgressView())
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Empty State"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              ContentUnavailableView(specString("No items found"), systemImage: "tray", description: Text(specString("Try adjusting your filters or create a new item.")))
                .frame(height: 200)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Card Container"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(8)) {
                  Text(specString("Card Title"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(specString("This is a Card component used as a container."))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                }
                .padding(CGFloat(16))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        VStack(spacing: CGFloat(20)) {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Progress"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(12)) {
                  Text(specString("65%"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  VStack() {
                    ProgressView(value: (vm.progressValue as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(minHeight: CGFloat(0))
                  .frame(minWidth: CGFloat(0))
                  .frame(maxWidth: .infinity)
                }

                HStack(alignment: .center, spacing: CGFloat(12)) {
                  Text(specString("40%"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  VStack() {
                    ProgressView(value: (vm.progressHalf as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(minHeight: CGFloat(0))
                  .frame(minWidth: CGFloat(0))
                  .frame(maxWidth: .infinity)
                }

              }

            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(12)) {
              Text(specString("Alerts"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Timeline"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Form Controls"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Text Input")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Type something..."), text: Binding(get: { vm.inputValue as? String ?? "" }, set: { vm.inputValue = $0 }))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Password")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Enter password..."), text: Binding(get: { vm.passwordValue as? String ?? "" }, set: { vm.passwordValue = $0 }))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("you@example.com"), text: Binding(get: { vm.emailValue as? String ?? "" }, set: { vm.emailValue = $0 }))
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
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Message")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Write here..."), text: Binding(get: { vm.textareaValue as? String ?? "" }, set: { vm.textareaValue = $0 }))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Amount")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Amount"), text: Binding(get: { vm.prefixValue as? String ?? "" }, set: { vm.prefixValue = $0 }))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Username")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Username"), text: .constant(""))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Disabled")).font(.subheadline).foregroundStyle(.secondary)
                  TextField(specString("Disabled"), text: .constant(""))
                }
                VStack(alignment: .leading, spacing: 4) {
                  if !specString("Pick a Date").isEmpty {
                    Text(specString("Pick a Date")).font(.subheadline).foregroundStyle(.secondary)
                  }
                  DatePicker("", selection: .constant(Date()), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                }
                Picker(specString("Dropdown"), selection: Binding(get: { specString(vm.selectValue) }, set: { vm.selectValue = $0 })) {
                  ForEach(Array(([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                    Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
                  }
                }
                .pickerStyle(.menu)
                VStack(spacing: CGFloat(8)) {
                  Text(specString("MultiSelect options"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  HStack(alignment: .center, spacing: CGFloat(12)) {
                    Text(specString("display:"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                    Spacer(minLength: 0)
                    Picker("", selection: Binding(get: { specString(vm.msDisplay) }, set: { vm.msDisplay = $0 })) {
                      Text("chips").tag("chips")
                      Text("text").tag("text")
                    }
                    .pickerStyle(.segmented)
                  }
                  .frame(maxWidth: .infinity)

                  HStack(alignment: .center, spacing: CGFloat(12)) {
                    Text(specString("mode:"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                    Spacer(minLength: 0)
                    Picker("", selection: Binding(get: { specString(vm.msMode) }, set: { vm.msMode = $0 })) {
                      Text("dropdown").tag("dropdown")
                      Text("list").tag("list")
                    }
                    .pickerStyle(.segmented)
                  }
                  .frame(maxWidth: .infinity)

                  HStack(alignment: .center, spacing: CGFloat(12)) {
                    Toggle(specString("searchable"), isOn: Binding(get: { vm.msSearchable as? Bool ?? false }, set: { vm.msSearchable = $0 }))
                    Toggle(specString("showCheckbox"), isOn: Binding(get: { vm.msShowCheckbox as? Bool ?? false }, set: { vm.msShowCheckbox = $0 }))
                  }

                }
                .padding(CGFloat(12))
                .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                MultiSelectView(display: vm.msDisplay, label: "Tags", mode: vm.msMode, options: [["value": "bug" as Any, "label": "Bug" as Any] as [String: Any], ["value": "feature" as Any, "label": "Feature" as Any] as [String: Any], ["value": "docs" as Any, "label": "Docs" as Any] as [String: Any], ["value": "refactor" as Any, "label": "Refactor" as Any] as [String: Any]] as [Any], placeholder: "Select tags...", searchable: vm.msSearchable, showCheckbox: vm.msShowCheckbox, values: vm.cmpMsSpec)
                Text(specString("Checkboxes"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Toggle(specString("Accept terms"), isOn: Binding(get: { vm.checkboxChecked as? Bool ?? false }, set: { vm.checkboxChecked = $0 }))
                  .toggleStyle(.automatic)
                Toggle(specString("Subscribe to newsletter"), isOn: Binding(get: { vm.checkboxNewsletter as? Bool ?? false }, set: { vm.checkboxNewsletter = $0 }))
                  .toggleStyle(.automatic)
                Toggle(specString("Disabled option"), isOn: .constant(false))
                  .toggleStyle(.automatic)
                Text(specString("Toggles"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Toggle(specString("Dark mode"), isOn: Binding(get: { vm.toggleChecked as? Bool ?? false }, set: { vm.toggleChecked = $0 }))
                Toggle(specString("Notifications"), isOn: Binding(get: { vm.toggleNotifications as? Bool ?? false }, set: { vm.toggleNotifications = $0 }))
                Toggle(specString("Disabled toggle"), isOn: .constant(false))
                Text(specString("Radio Buttons"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Stat"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                VStack(spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("star")))
                    .font(.system(size: specPx("24px")))
                    .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("$12,345")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Revenue")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(CGFloat(16))
                .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.info-bg"), ThemeManager.shared.color("semantic.focus-ring")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
                VStack(spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("user")))
                    .font(.system(size: specPx("24px")))
                    .foregroundStyle(Color(hex: "#52c41a" as? String ?? "#000"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("1,234")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Users")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(CGFloat(16))
                .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.success-light"), ThemeManager.shared.color("semantic.success-muted")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
                VStack(spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("loader")))
                    .font(.system(size: specPx("24px")))
                    .foregroundStyle(Color(hex: "#faad14" as? String ?? "#000"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("5,678")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("Sessions")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(CGFloat(16))
                .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.warning-light"), ThemeManager.shared.color("semantic.warning-muted")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
              }

            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Image"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(16)) {
                VStack(spacing: CGFloat(8)) {
                  Text(specString("Normal"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  AsyncImage(url: URL(string: specString("https://picsum.photos/300/200"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Photo"))
                }

                VStack(spacing: CGFloat(8)) {
                  Text(specString("Fallback"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  AsyncImage(url: URL(string: specString("https://invalid.example.com/x.jpg"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Fallback"))
                }

                VStack(spacing: CGFloat(8)) {
                  Text(specString("Lazy"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  AsyncImage(url: URL(string: specString("https://picsum.photos/300/200?r=3"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Lazy"))
                }

              }

            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(12)) {
              Text(specString("Toast (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                if vm.toastsVisible as? Bool ?? false {
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
                if !(vm.toastsVisible as? Bool ?? false) {
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Modal (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, spacing: CGFloat(12)) {
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
                  VStack(spacing: CGFloat(12)) {
                    Text(specString("This is a modal dialog built entirely in Spec."))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                    Text(specString("It supports focus trapping, scroll locking, and backdrop click to close."))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  }

                  .navigationTitle(specString("Example Modal"))
                  .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { vm.modalOpen = false } } }
                }
              }
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Drawer (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, spacing: CGFloat(12)) {
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
                  VStack(spacing: CGFloat(8)) {
                    Text(specString("Dashboard"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    Text(specString("Settings"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    Text(specString("Profile"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    Text(specString("Help"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  }

                }
                .presentationDetents([.medium, .large])
              }
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Confirm Dialog (Spec Component)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, spacing: CGFloat(12)) {
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
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
      }

      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Text"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          VStack(spacing: CGFloat(12)) {
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Stack"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Pagination"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("TimePicker"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          TimePickerView(format: "12", label: "Meeting Time")
        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Stepper"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          StepperView(activeStep: vm.stepper2Step, steps: [["label": "Account" as Any] as [String: Any], ["label": "Profile" as Any] as [String: Any], ["label": "Review" as Any] as [String: Any], ["label": "Complete" as Any] as [String: Any]] as [Any])
          HStack(alignment: .center, spacing: CGFloat(12)) {
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Slider"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Slider(value: Binding(get: { vm.sliderValue as? Double ?? 0 }, set: { vm.sliderValue = $0 }), in: (0 as? Double ?? 0)...(100 as? Double ?? 100))
        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack() {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Select"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Picker(specString("Framework"), selection: Binding(get: { specString(vm.select2Value) }, set: { vm.select2Value = $0 })) {
            ForEach(Array(([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
              Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
            }
          }
          .pickerStyle(.menu)
        }
        .padding(CGFloat(20))
      }
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack() {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Tooltip"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          HStack(alignment: .center, spacing: CGFloat(16)) {
            Text(specString("Top tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Bottom tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Left tooltip")).font(.caption).foregroundStyle(.tertiary)
            Text(specString("Right tooltip")).font(.caption).foregroundStyle(.tertiary)
          }

        }
        .padding(CGFloat(20))
      }
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack() {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Popover"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          HStack(alignment: .center, spacing: CGFloat(16)) {
            EmptyView().popover(isPresented: .constant(false)) {
            }
            EmptyView().popover(isPresented: .constant(false)) {
            }
          }

        }
        .padding(CGFloat(20))
      }
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Command Palette"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Sidebar"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          VStack() {
            SidebarView(activeItem: vm.sidebarItem, collapsed: vm.sidebarCollapsed, sections: [["title": "Main" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "star" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["title": "Account" as Any, "items": [["id": "profile" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any], ["id": "logout" as Any, "label": "Logout" as Any, "icon": "arrowRight" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any])
          }
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .frame(height: CGFloat(300))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
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
