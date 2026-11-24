import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  var pickedDate: Any? = Optional<Any>.none as Any
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
    stepperStep = ((specLt(stepperStep, 4)) as? Bool ?? false ? specAdd(stepperStep, 1) : 1)
  }
  func prevStep() {
    stepperStep = ((specGt(stepperStep, 1)) as? Bool ?? false ? (specDouble(stepperStep) - specDouble(1)) : 1)
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
    stepper2Step = ((specLt(stepper2Step, 3)) as? Bool ?? false ? specAdd(stepper2Step, 1) : 0)
  }
  func prevStepper2() {
    stepper2Step = ((specGt(stepper2Step, 0)) as? Bool ?? false ? (specDouble(stepper2Step) - specDouble(1)) : 0)
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ThemePreviewView: View {
  @State private var vm = ThemePreviewViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ThemePreviewViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Group {
      Text(verbatim: specString("Component Showcase"))
        .font(.largeTitle)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Switch themes above to compare how each one styles these components."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      Text(verbatim: specString("Component Comparison"))
        .font(.title)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Spec-compiled components. List and EditableGrid still show side-by-side TS comparison."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("List"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("Spec"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              ListView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("TS"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("warning"))
              ListTSView(items: [["id": "1" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "2" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "3" as Any, "label": "Settings" as Any] as [String: Any], ["id": "4" as Any, "label": "Profile" as Any] as [String: Any], ["id": "5" as Any, "label": "Logout" as Any] as [String: Any]] as [Any], searchable: true, selection: "single")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Tree"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Button(action: { specClick { Task { @MainActor in await vm.toggleTreeExpandMode() } } }) {
              Text(specString(specAdd("Mode: ", vm.treeExpandMode)))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(specString("outline") == "primary" ? AnyShapeStyle(.white) : AnyShapeStyle(ThemeManager.shared.color("interactive")))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(specString("outline") == "primary" ? AnyShapeStyle(ThemeManager.shared.color("interactive")) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
            }
            if specNeq(vm.treeSelectedName, "") {
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              if specNeq(vm.treeSelectedName, "") {
                Text(verbatim: specString("Selected:"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(specString(vm.treeSelectedName))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("default")))
                  .background(specBadgeBackground(specString("default")), in: Capsule())
              }
            }

            }
          }

          TreeView(expanded: ["src"] as [Any], expandMode: vm.treeExpandMode, nodes: [["id": "src" as Any, "label": "src" as Any, "icon": "folder" as Any, "children": [["id": "app" as Any, "label": "app.spec" as Any, "icon": "code" as Any] as [String: Any], ["id": "components" as Any, "label": "components" as Any, "icon": "layers" as Any, "children": [["id": "btn" as Any, "label": "button.spec" as Any, "icon": "code" as Any] as [String: Any], ["id": "card" as Any, "label": "card.spec" as Any, "icon": "code" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "utils" as Any, "label": "utils.js" as Any, "icon": "terminal" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "pkg" as Any, "label": "package.json" as Any, "icon": "package" as Any] as [String: Any], ["id": "cfg" as Any, "label": "spec.config.json" as Any, "icon": "settings" as Any] as [String: Any]] as [Any], selection: "single", onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "select":
              let specArgs = specArr(specPayload)
              let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.setTreeSelected(id)
            default: break
            }
          })
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Toast"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          if (vm.cmpToastSpecVisible) as? Bool ?? false {
          VStack(alignment: .leading, spacing: 0) {
            if (vm.cmpToastSpecVisible) as? Bool ?? false {
              HStack(spacing: 8) {
                Image(systemName: specAlertIcon(specString("success")))
                  .foregroundStyle(specAlertColor(specString("success")))
                Text(specString("Operation completed!")).font(.subheadline)
                Spacer(minLength: 0)
                Button(action: { vm.dismissCmpToastSpec() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.buttonStyle(.borderless).accessibilityLabel("Dismiss notification")
              }
              .padding(12)
              .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
              .shadow(radius: 4)
              .specAutoDismiss(after: 5000) { vm.dismissCmpToastSpec() }
            }
          }

          }
          if specEq(vm.cmpToastSpecVisible, false) {
          VStack(alignment: .leading, spacing: 0) {
            if specEq(vm.cmpToastSpecVisible, false) {
              Button(action: { specClick { Task { @MainActor in await vm.showCmpToasts() } } }) {
                Text(specString("Reset Toast"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .frame(maxWidth: .infinity)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
          }

          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("EditableGrid"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("Click a cell then press Enter to edit. Arrow keys to navigate."))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("Spec"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              EditableGridView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("TS"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("warning"))
              EditableGridTSView(activation: "click", columns: [["key": "name" as Any, "header": "Name" as Any, "sortable": true as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any, "sortable": true as Any, "type": "select" as Any, "options": [["value": "Engineer" as Any, "label": "Engineer" as Any] as [String: Any], ["value": "Designer" as Any, "label": "Designer" as Any] as [String: Any], ["value": "PM" as Any, "label": "PM" as Any] as [String: Any], ["value": "Manager" as Any, "label": "Manager" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], height: "220px", rows: vm.cmpGridRows)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }
      Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Buttons"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                  Button(action: {  }) {
                    Text(specString("Primary"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                  }
                  Button(action: {  }) {
                    Text(specString("Secondary"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(ThemeManager.shared.color("interactive"))
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                  Button(action: {  }) {
                    Text(specString("Ghost"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(ThemeManager.shared.color("interactive"))
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                  }
                  Button(action: {  }) {
                    Text(specString("Destructive"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(ThemeManager.shared.color("destructive"), in: RoundedRectangle(cornerRadius: 8))
                  }
                }

                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                  Button(action: {  }) {
                    Text(specString("Disabled"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                  }
                  .disabled(true as? Bool ?? false)
                  .opacity(0.5)
                  Button(action: {  }) {
                    HStack(spacing: 4) {
                      if true {
                        ProgressView().controlSize(.small).tint(.white)
                      }
                      Text(specString("Loading"))
                    }
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                  }
                  .disabled(true)
                  .opacity(0.7)
                }

              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Badges"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
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
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Table"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              TableView(columns: [["key": "name" as Any, "header": "Name" as Any] as [String: Any], ["key": "role" as Any, "header": "Role" as Any] as [String: Any], ["key": "status" as Any, "header": "Status" as Any] as [String: Any]] as [Any], rows: [["name": "Alice" as Any, "role": "Engineer" as Any, "status": "Active" as Any] as [String: Any], ["name": "Bob" as Any, "role": "Designer" as Any, "status": "Away" as Any] as [String: Any], ["name": "Carol" as Any, "role": "Manager" as Any, "status": "Active" as Any] as [String: Any]] as [Any], striped: true)
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              HStack(alignment: .center, spacing: 0) {
                Text(verbatim: specString("Accordion (Spec Component)"))
                  .font(.title2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Spacer(minLength: 0)
                Toggle(specString("Allow multiple"), isOn: Binding(get: { specTruthy(vm.accordionMultiple) }, set: { newValue in let v: Any = newValue; vm.setAccordionMultiple(v) }))
              }
              .frame(maxWidth: .infinity)

              DisclosureGroup(specString("")) {
              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Breadcrumb"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("maxVisible:"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Button(action: { specClick { Task { @MainActor in await vm.setBreadcrumbMax(0) } } }) {
                  Text(specString("0 (off)"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { specClick { Task { @MainActor in await vm.setBreadcrumbMax(2) } } }) {
                  Text(specString("2"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { specClick { Task { @MainActor in await vm.setBreadcrumbMax(3) } } }) {
                  Text(specString("3"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { specClick { Task { @MainActor in await vm.setBreadcrumbMax(4) } } }) {
                  Text(specString("4"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { specClick { Task { @MainActor in await vm.setBreadcrumbMax(5) } } }) {
                  Text(specString("5"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Short path (4 items)"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
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

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Long path (6 items)"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
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
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Tabs"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(spacing: 0) {
                Picker(specString("Tabs"), selection: Binding(get: { specString(vm.activeTab) }, set: { newValue in let id: Any = newValue; vm.setTab(id) })) {
                  ForEach(Array(([["id": "overview" as Any, "label": "Overview" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any] as [String: Any], ["id": "disabled" as Any, "label": "Disabled" as Any, "disabled": true as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, tab in
                    Text(specString((tab as? [String: Any])?["label"] ?? tab)).tag(specString((tab as? [String: Any])?["id"] ?? (tab as? [String: Any])?["value"] ?? tab))
                  }
                }
                .pickerStyle(.segmented)
              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Typography"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Display Large"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-display-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Large"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Medium"))
                .font(.title)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Heading Small"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Body text — The quick brown fox jumps over the lazy dog. This is regular paragraph text that demonstrates the body font at its default size and weight."))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Label Medium"))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Caption — supplementary information"))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Skeleton"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemGroupedBackground))
                .frame(height: CGFloat(48))
                .overlay(ProgressView())
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Empty State"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              ContentUnavailableView(specString("No items found"), systemImage: "tray", description: Text(specString("Try adjusting your filters or create a new item.")))
                .frame(height: 200)
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Card Container"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Card Title"))
                    .font(.title2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Text(verbatim: specString("This is a Card component used as a container."))
                    .font(.body)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxHeight: .infinity, alignment: .leading)
        .specFlexGrow(1)
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Progress"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                  Text(verbatim: specString("65%"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack(alignment: .leading, spacing: 0) {
                    ProgressView(value: (vm.progressValue as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .specFlexGrow(1)
                }

                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                  Text(verbatim: specString("40%"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack(alignment: .leading, spacing: 0) {
                    ProgressView(value: (vm.progressHalf as? Double ?? 0) / 100.0)
                      .tint(.accentColor)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .specFlexGrow(1)
                }

              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Alerts"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
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
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Timeline"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
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
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Form Controls"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Group {
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Text Input")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("Type something..."), text: Binding(get: { vm.inputValue as? String ?? "" }, set: { newValue in vm.inputValue = newValue; let v: Any = newValue; vm.setInput(v) }))
                  .textFieldStyle(.roundedBorder)
                  .specAccessibilityLabel(specFieldName("", "Text Input"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Password")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SecureField(specString("Enter password..."), text: Binding(get: { vm.passwordValue as? String ?? "" }, set: { newValue in vm.passwordValue = newValue; let v: Any = newValue; vm.setPassword(v) }))
                  .textFieldStyle(.roundedBorder)
                  .specAccessibilityLabel(specFieldName("", "Password"))
                  .textInputAutocapitalization(.never)
                  .autocorrectionDisabled()
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("you@example.com"), text: Binding(get: { vm.emailValue as? String ?? "" }, set: { newValue in vm.emailValue = newValue; let v: Any = newValue; vm.setEmail(v) }))
                  .textFieldStyle(.roundedBorder)
                  .keyboardType(.emailAddress)
                  .textInputAutocapitalization(.never)
                  .autocorrectionDisabled()
                  .specAccessibilityLabel(specFieldName("", "Email"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Search")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("Search..."), text: Binding(get: { vm.searchValue as? String ?? "" }, set: { newValue in vm.searchValue = newValue; let v: Any = newValue; vm.setSearch(v) }))
                  .textFieldStyle(.roundedBorder)
                  .textContentType(.none)
                  .autocorrectionDisabled()
                  .specAccessibilityLabel(specFieldName("", "Search"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Number")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("0"), text: Binding(get: { vm.numberValue as? String ?? "" }, set: { newValue in vm.numberValue = newValue; let v: Any = newValue; vm.setNumber(v) }))
                  .textFieldStyle(.roundedBorder)
                  .keyboardType(.decimalPad)
                  .specAccessibilityLabel(specFieldName("", "Number"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Message")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextEditor(text: Binding(get: { vm.textareaValue as? String ?? "" }, set: { newValue in vm.textareaValue = newValue; let v: Any = newValue; vm.setTextarea(v) }))
                  .frame(minHeight: 88)
                  .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                  .specAccessibilityLabel(specFieldName("", "Message"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Amount")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("Amount"), text: Binding(get: { vm.prefixValue as? String ?? "" }, set: { newValue in vm.prefixValue = newValue; let v: Any = newValue; vm.setPrefix(v) }))
                  .textFieldStyle(.roundedBorder)
                  .specAccessibilityLabel(specFieldName("", "Amount"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Username")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  VStack(alignment: .leading, spacing: 4) {
                  SpecTextField(specString("Username"), text: .constant(specString("taken")))
                  .textFieldStyle(.roundedBorder)
                  .specAccessibilityLabel(specFieldName("", "Username"))
                  .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(true) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
                  if specTruthy(true) && specString("Already taken") != "" {
                    Text(specString("Already taken")).font(.footnote).foregroundStyle(ThemeManager.shared.color("destructive")).fixedSize(horizontal: false, vertical: true)
                  }
                }
                }
                }
                Group {
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Disabled")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  SpecTextField(specString("Disabled"), text: .constant(specString("Read only")))
                  .textFieldStyle(.roundedBorder)
                  .specAccessibilityLabel(specFieldName("", "Disabled"))
                }
                VStack(alignment: .leading, spacing: 4) {
                  if !specString("Pick a Date").isEmpty {
                    Text(specString("Pick a Date")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                  }
                  SpecOptionalDatePicker(text: Binding(get: { "" }, set: { newValue in let d: Any = newValue; vm.setDate(d) }), format: "YYYY-MM-DD", placeholder: "Choose date...", label: "Pick a Date", ariaLabel: "", disabled: false, error: false, errorMessage: "")
                }
                VStack(alignment: .leading, spacing: 4) {
                  Text(specString("Dropdown")).font(.subheadline).foregroundStyle(.secondary)
                  Menu {
                    if specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                      ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                        let optValue = specString(specGet(opt, "value"))
                        let optSub = specString(specGet(opt, "sub"))
                        Toggle(isOn: Binding(get: { specString(vm.selectValue) == optValue }, set: { on in if on { Binding(get: { specString(vm.selectValue) }, set: { newValue in vm.selectValue = newValue; let v: Any = newValue; vm.setSelect(v) }).wrappedValue = optValue } })) {
                          Text(specString(specGet(opt, "label")))
                          if !optSub.isEmpty { Text(optSub) }
                        }
                      }
                    } else {
                    Picker(specString("Dropdown"), selection: Binding(get: { specString(vm.selectValue) }, set: { newValue in vm.selectValue = newValue; let v: Any = newValue; vm.setSelect(v) })) {
                      ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                        Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                      }
                    }
                    }
                  } label: {
                    HStack {
                      Text(verbatim: specSelectLabel([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any], specString(vm.selectValue), "Choose framework...").text).foregroundStyle(specSelectLabel([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any], specString(vm.selectValue), "Choose framework...").isPlaceholder ? .secondary : .primary)
                      Spacer()
                      Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                    }
                    .padding(.horizontal, 12).padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                  }
                }
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("MultiSelect options"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                    Text(verbatim: specString("display:"))
                      .font(.footnote)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    Picker("", selection: Binding(get: { specString(vm.msDisplay) }, set: { vm.msDisplay = $0 })) {
                      Text("chips").tag("chips")
                      Text("text").tag("text")
                    }
                    .pickerStyle(.segmented)
                  }

                  HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                    Text(verbatim: specString("mode:"))
                      .font(.footnote)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    Picker("", selection: Binding(get: { specString(vm.msMode) }, set: { vm.msMode = $0 })) {
                      Text("dropdown").tag("dropdown")
                      Text("list").tag("list")
                    }
                    .pickerStyle(.segmented)
                  }

                  HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                    Toggle(specString("searchable"), isOn: Binding(get: { specTruthy(vm.msSearchable) }, set: { newValue in let v: Any = newValue; vm.setMsSearchable(v) }))
                    Toggle(specString("showCheckbox"), isOn: Binding(get: { specTruthy(vm.msShowCheckbox) }, set: { newValue in let v: Any = newValue; vm.setMsShowCheckbox(v) }))
                  }

                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                MultiSelectView(display: vm.msDisplay, label: "Tags", mode: vm.msMode, options: [["value": "bug" as Any, "label": "Bug" as Any] as [String: Any], ["value": "feature" as Any, "label": "Feature" as Any] as [String: Any], ["value": "docs" as Any, "label": "Docs" as Any] as [String: Any], ["value": "refactor" as Any, "label": "Refactor" as Any] as [String: Any]] as [Any], placeholder: "Select tags...", searchable: vm.msSearchable, showCheckbox: vm.msShowCheckbox, values: vm.cmpMsSpec, onDispatch: { specEvent, specPayload in
                  _ = specPayload
                  switch specString(specEvent) {
                  case "change":
                    let specArgs = specArr(specPayload)
                    let v: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
                    vm.setCmpMsSpec(v)
                  default: break
                  }
                })
                Text(verbatim: specString("Checkboxes"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Toggle(specString("Accept terms"), isOn: Binding(get: { specTruthy(vm.checkboxChecked) }, set: { newValue in let v: Any = newValue; vm.setCheckbox(v) }))
                  .toggleStyle(SpecCheckToggleStyle(tint: nil))
                Toggle(specString("Subscribe to newsletter"), isOn: Binding(get: { specTruthy(vm.checkboxNewsletter) }, set: { newValue in let v: Any = newValue; vm.setCheckboxNewsletter(v) }))
                  .toggleStyle(SpecCheckToggleStyle(tint: nil))
                }
                Group {
                Toggle(specString("Disabled option"), isOn: .constant(false))
                  .toggleStyle(SpecCheckToggleStyle(tint: nil))
                  .disabled(specTruthy(true))
                Text(verbatim: specString("Toggles"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Toggle(specString("Dark mode"), isOn: Binding(get: { specTruthy(vm.toggleChecked) }, set: { newValue in let v: Any = newValue; vm.setToggle(v) }))
                Toggle(specString("Notifications"), isOn: Binding(get: { specTruthy(vm.toggleNotifications) }, set: { newValue in let v: Any = newValue; vm.setToggleNotifications(v) }))
                Toggle(specString("Disabled toggle"), isOn: .constant(false))
                  .disabled(specTruthy(true))
                Text(verbatim: specString("Radio Buttons"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Button(action: { let v: Any = specString("option1"); vm.setRadio(v) }) {
                  HStack(alignment: .center, spacing: 10) {
                    Image(systemName: specTruthy(specEq(vm.radioValue, "option1")) ? "largecircle.fill.circle" : "circle")
                      .font(.system(size: 22, weight: .regular))
                      .foregroundStyle(specTruthy(specEq(vm.radioValue, "option1")) ? Color.accentColor : Color.secondary)
                      .accessibilityHidden(true)
                    Text(verbatim: specString("Option 1"))
                  }
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(specTruthy(specEq(vm.radioValue, "option1")) ? .isSelected : [])
                Button(action: { let v: Any = specString("option2"); vm.setRadio(v) }) {
                  HStack(alignment: .center, spacing: 10) {
                    Image(systemName: specTruthy(specEq(vm.radioValue, "option2")) ? "largecircle.fill.circle" : "circle")
                      .font(.system(size: 22, weight: .regular))
                      .foregroundStyle(specTruthy(specEq(vm.radioValue, "option2")) ? Color.accentColor : Color.secondary)
                      .accessibilityHidden(true)
                    Text(verbatim: specString("Option 2"))
                  }
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(specTruthy(specEq(vm.radioValue, "option2")) ? .isSelected : [])
                }
                Group {
                Button(action: { let v: Any = specString("option3"); vm.setRadio(v) }) {
                  HStack(alignment: .center, spacing: 10) {
                    Image(systemName: specTruthy(specEq(vm.radioValue, "option3")) ? "largecircle.fill.circle" : "circle")
                      .font(.system(size: 22, weight: .regular))
                      .foregroundStyle(specTruthy(specEq(vm.radioValue, "option3")) ? Color.accentColor : Color.secondary)
                      .accessibilityHidden(true)
                    Text(verbatim: specString("Option 3"))
                  }
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(specTruthy(specEq(vm.radioValue, "option3")) ? .isSelected : [])
                Button(action: {  }) {
                  HStack(alignment: .center, spacing: 10) {
                    Image(systemName: false ? "largecircle.fill.circle" : "circle")
                      .font(.system(size: 22, weight: .regular))
                      .foregroundStyle(false ? Color.accentColor : Color.secondary)
                      .accessibilityHidden(true)
                    Text(verbatim: specString("Disabled"))
                  }
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(false ? .isSelected : [])
                .opacity(specTruthy(true) ? 0.5 : 1)
                  .disabled(specTruthy(true))
                }
              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Stat"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("star")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                  VStack(alignment: .center, spacing: 2) {
                    Text(specString("Revenue")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                    Text(specString("$12,345")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                    if specString("up") != "" {
                      let _tc: Color = specString("up") == "up" ? Color(hex: "#22c55e") : (specString("up") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                      HStack(spacing: 4) {
                        Text(specString("up") == "up" ? "↑" : (specString("up") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                        if specString("+12%") != "" { Text(specString("+12%")).font(.footnote).foregroundStyle(_tc) }
                      }
                    }
                    if specString("") != "" {
                      Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
                    }
                  }
                  .frame(maxWidth: .infinity)
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .center)
                .background(ThemeManager.shared.color("gradient-stat-primary"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .hoverEffect(.highlight)
                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("user")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("success"))
                  VStack(alignment: .center, spacing: 2) {
                    Text(specString("Users")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                    Text(specString("1,234")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                    if specString("down") != "" {
                      let _tc: Color = specString("down") == "up" ? Color(hex: "#22c55e") : (specString("down") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                      HStack(spacing: 4) {
                        Text(specString("down") == "up" ? "↑" : (specString("down") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                        if specString("-3%") != "" { Text(specString("-3%")).font(.footnote).foregroundStyle(_tc) }
                      }
                    }
                    if specString("") != "" {
                      Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
                    }
                  }
                  .frame(maxWidth: .infinity)
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .center)
                .background(ThemeManager.shared.color("gradient-stat-success"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .hoverEffect(.highlight)
                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("loader")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                    .foregroundStyle(ThemeManager.shared.color("warning"))
                  VStack(alignment: .center, spacing: 2) {
                    Text(specString("Sessions")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                    Text(specString("5,678")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                    if specString("neutral") != "" {
                      let _tc: Color = specString("neutral") == "up" ? Color(hex: "#22c55e") : (specString("neutral") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                      HStack(spacing: 4) {
                        Text(specString("neutral") == "up" ? "↑" : (specString("neutral") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                        if specString("No change") != "" { Text(specString("No change")).font(.footnote).foregroundStyle(_tc) }
                      }
                    }
                    if specString("") != "" {
                      Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
                    }
                  }
                  .frame(maxWidth: .infinity)
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .center)
                .background(ThemeManager.shared.color("gradient-stat-warning"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .hoverEffect(.highlight)
              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Image"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Normal"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  AsyncImage(url: URL(string: specString("https://picsum.photos/300/200"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Photo"))
                }

                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Fallback"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  AsyncImage(url: URL(string: specString("https://invalid.example.com/x.jpg"))) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                  } placeholder: {
                    ProgressView()
                  }
                  .accessibilityLabel(specString("Fallback"))
                }

                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Lazy"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
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
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Toast (Spec Component)"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              if (vm.toastsVisible) as? Bool ?? false {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                if (vm.toastsVisible) as? Bool ?? false {
                  _specArm0
                }
              }

              }
              if ((!((vm.toastsVisible) as? Bool ?? false))) as? Bool ?? false {
              VStack(alignment: .leading, spacing: 0) {
                if ((!((vm.toastsVisible) as? Bool ?? false))) as? Bool ?? false {
                  Button(action: { specClick { Task { @MainActor in await vm.showToasts() } } }) {
                    Text(specString("Show Toasts"))
                      .lineLimit(1)
                      .fixedSize(horizontal: true, vertical: false)
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(ThemeManager.shared.color("interactive"))
                      .frame(maxWidth: .infinity)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                }
              }

              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Modal (Spec Component)"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Button(action: { specClick { Task { @MainActor in await vm.openModal() } } }) {
                  Text(specString("Open Modal"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { vm.modalOpen as? Bool ?? false }, set: { shown in vm.modalOpen = shown; if !shown { vm.closeModal() } })) {
                NavigationStack {
                  VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                    Text(verbatim: specString("This is a modal dialog built entirely in Spec."))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    Text(verbatim: specString("It supports focus trapping, scroll locking, and backdrop click to close."))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  }

                  .navigationTitle(specString("Example Modal"))
                  .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { vm.modalOpen = false; vm.closeModal() } } }
                }
              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Drawer (Spec Component)"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Button(action: { specClick { Task { @MainActor in await vm.openDrawer() } } }) {
                  Text(specString("Open Drawer"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { vm.drawerOpen as? Bool ?? false }, set: { shown in vm.drawerOpen = shown; if !shown { vm.closeDrawer() } })) {
                VStack {
                  VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                    Text(verbatim: specString("Dashboard"))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Settings"))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Profile"))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Help"))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  }

                }
                .presentationDetents([.medium, .large])
              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Confirm Dialog (Spec Component)"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Button(action: { specClick { Task { @MainActor in await vm.openConfirm() } } }) {
                  Text(specString("Confirm Action"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { specClick { Task { @MainActor in await vm.openConfirmDestructive() } } }) {
                  Text(specString("Delete Item"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(ThemeManager.shared.color("destructive"), in: RoundedRectangle(cornerRadius: 8))
                }
              }

              EmptyView().confirmationDialog(specString("Save Changes?"), isPresented: Binding(get: { vm.confirmOpen as? Bool ?? false }, set: { vm.confirmOpen = $0 }), titleVisibility: .visible) {
                Button(specString("Save"), role: nil) { vm.closeConfirm() }
                Button(specString("Discard"), role: .cancel) { vm.closeConfirm() }
              } message: {
                Text(specString("Would you like to save your changes before leaving?"))
              }
              EmptyView().confirmationDialog(specString("Delete Item"), isPresented: Binding(get: { vm.confirmDestructiveOpen as? Bool ?? false }, set: { vm.confirmDestructiveOpen = $0 }), titleVisibility: .visible) {
                Button(specString("Delete"), role: .destructive) { vm.closeConfirmDestructive() }
                Button(specString("Keep"), role: .cancel) { vm.closeConfirmDestructive() }
              } message: {
                Text(specString("This action cannot be undone. Are you sure you want to delete this item?"))
              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxHeight: .infinity, alignment: .leading)
        .specFlexGrow(1)
      }

      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Text"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
            Text(specString(""))
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Stack"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
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
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Pagination"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(spacing: 8) {
            Button(action: { let specCur = specPageClamp(vm.paginationPage, specPageCount(100, 10)); if specCur > 1 { let specNewPage = specCur - 1; let p: Any = specNewPage; vm.setPaginationPage(p) } }) {
              Image(systemName: "chevron.left")
            }
            .disabled(specPageClamp(vm.paginationPage, specPageCount(100, 10)) <= 1)
            Text("\(specPageClamp(vm.paginationPage, specPageCount(100, 10))) / \(specPageCount(100, 10))")
              .font(.subheadline).monospacedDigit()
            Button(action: { let specCur = specPageClamp(vm.paginationPage, specPageCount(100, 10)); if specCur < specPageCount(100, 10) { let specNewPage = specCur + 1; let p: Any = specNewPage; vm.setPaginationPage(p) } }) {
              Image(systemName: "chevron.right")
            }
            .disabled(specPageClamp(vm.paginationPage, specPageCount(100, 10)) >= specPageCount(100, 10))
          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("TimePicker"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          TimePickerView(format: "12", label: "Meeting Time")
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Stepper"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          StepperView(activeStep: vm.stepper2Step, steps: [["label": "Account" as Any] as [String: Any], ["label": "Profile" as Any] as [String: Any], ["label": "Review" as Any] as [String: Any], ["label": "Complete" as Any] as [String: Any]] as [Any])
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Button(action: { specClick { Task { @MainActor in await vm.prevStepper2() } } }) {
              Text(specString("Previous"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: { specClick { Task { @MainActor in await vm.nextStepper2() } } }) {
              Text(specString("Next Step"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
            }
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Slider"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
              if !specString("Volume").isEmpty {
                Text(verbatim: specString("Volume")).font(.subheadline).foregroundStyle(.secondary)
              }
              Spacer(minLength: 8)
              Text(verbatim: specString(specDouble(vm.sliderValue))).font(.subheadline).monospacedDigit()
            }
            .accessibilityHidden(true)
            Slider(value: Binding(get: { specDouble(vm.sliderValue) }, set: { newValue in let v: Any = newValue; vm.setSliderValue(v) }), in: specSliderRange(0, 100))
              .specAccessibilityLabel("Volume")
          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Select"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Framework")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              if specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  let optValue = specString(specGet(opt, "value"))
                  let optSub = specString(specGet(opt, "sub"))
                  Toggle(isOn: Binding(get: { specString(vm.select2Value) == optValue }, set: { on in if on { Binding(get: { specString(vm.select2Value) }, set: { newValue in vm.select2Value = newValue; let v: Any = newValue; vm.setSelect2(v) }).wrappedValue = optValue } })) {
                    Text(specString(specGet(opt, "label")))
                    if !optSub.isEmpty { Text(optSub) }
                  }
                }
              } else {
              Picker(specString("Framework"), selection: Binding(get: { specString(vm.select2Value) }, set: { newValue in vm.select2Value = newValue; let v: Any = newValue; vm.setSelect2(v) })) {
                ForEach(Array(specArr([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
              }
            } label: {
              HStack {
                Text(verbatim: specSelectLabel([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any], specString(vm.select2Value), "Choose...").text).foregroundStyle(specSelectLabel([["value": "react" as Any, "label": "React" as Any] as [String: Any], ["value": "vue" as Any, "label": "Vue" as Any] as [String: Any], ["value": "angular" as Any, "label": "Angular" as Any] as [String: Any], ["value": "svelte" as Any, "label": "Svelte" as Any] as [String: Any]] as [Any], specString(vm.select2Value), "Choose...").isPlaceholder ? .secondary : .primary)
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
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }
      Group {
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Tooltip"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            HStack(spacing: 0) {
              Button(action: {  }) {
                Text(specString("Top"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .help(specString("Top tooltip"))
            .accessibilityHint(specString("Top tooltip"))
            HStack(spacing: 0) {
              Button(action: {  }) {
                Text(specString("Bottom"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .help(specString("Bottom tooltip"))
            .accessibilityHint(specString("Bottom tooltip"))
            HStack(spacing: 0) {
              Button(action: {  }) {
                Text(specString("Left"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .help(specString("Left tooltip"))
            .accessibilityHint(specString("Left tooltip"))
            HStack(spacing: 0) {
              Button(action: {  }) {
                Text(specString("Right"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .help(specString("Right tooltip"))
            .accessibilityHint(specString("Right tooltip"))
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Popover"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            SpecPopoverHost(trigger: {
              Button(action: {  }) {
                Text(specString("Bottom (default)"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }, content: {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Popover Content"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Click the trigger to open. Click outside to close."))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

            })
            SpecPopoverHost(trigger: {
              Button(action: {  }) {
                Text(specString("Right"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }, content: {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Right Popover"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Positioned to the right of the trigger."))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

            })
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Command Palette"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Button(action: { specClick { Task { @MainActor in await vm.openCmdPalette() } } }) {
            Text(specString("Open Command Palette"))
              .lineLimit(1)
              .fixedSize(horizontal: true, vertical: false)
              .font(.subheadline.weight(.medium))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
              .frame(maxWidth: .infinity)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
              .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
          }
          CommandPaletteView(commands: [["id": "new" as Any, "label": "New File" as Any, "shortcut": "Ctrl+N" as Any] as [String: Any], ["id": "open" as Any, "label": "Open File" as Any, "shortcut": "Ctrl+O" as Any] as [String: Any], ["id": "save" as Any, "label": "Save" as Any, "shortcut": "Ctrl+S" as Any] as [String: Any], ["id": "settings" as Any, "label": "Open Settings" as Any, "description": "Configure preferences" as Any] as [String: Any], ["id": "theme" as Any, "label": "Change Theme" as Any, "description": "Switch color theme" as Any] as [String: Any]] as [Any], open: vm.cmdPaletteOpen, onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "select":
              let specArgs = specArr(specPayload)
              let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.selectCmd(id)
            case "close":
              vm.closeCmdPalette()
            default: break
            }
          })
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Sidebar"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: 0) {
            SidebarView(activeItem: vm.sidebarItem, collapsed: vm.sidebarCollapsed, sections: [["title": "Main" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "star" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["title": "Account" as Any, "items": [["id": "profile" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any], ["id": "logout" as Any, "label": "Logout" as Any, "icon": "arrowRight" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any], onDispatch: { specEvent, specPayload in
              _ = specPayload
              switch specString(specEvent) {
              case "select":
                let specArgs = specArr(specPayload)
                let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
                vm.setSidebarItem(id)
              case "collapse":
                let specArgs = specArr(specPayload)
                let v: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
                vm.setSidebarCollapsed(v)
              default: break
              }
            })
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .specFrameHeight(CGFloat(300), alignment: .top)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("success")))
                      .foregroundStyle(specAlertColor(specString("success")))
                    Text(specString("Operation completed successfully!")).font(.subheadline)
                    Spacer(minLength: 0)
                    Button(action: { vm.dismissToasts() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.buttonStyle(.borderless).accessibilityLabel("Dismiss notification")
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  .specAutoDismiss(after: 5000) { vm.dismissToasts() }
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("error")))
                      .foregroundStyle(specAlertColor(specString("error")))
                    Text(specString("Something went wrong. Please try again.")).font(.subheadline)
                    Spacer(minLength: 0)
                    Button(action: { vm.dismissToasts() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.buttonStyle(.borderless).accessibilityLabel("Dismiss notification")
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  .specAutoDismiss(after: 5000) { vm.dismissToasts() }
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("warning")))
                      .foregroundStyle(specAlertColor(specString("warning")))
                    Text(specString("This action cannot be undone.")).font(.subheadline)
                    Spacer(minLength: 0)
                    Button(action: { vm.dismissToasts() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.buttonStyle(.borderless).accessibilityLabel("Dismiss notification")
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  .specAutoDismiss(after: 5000) { vm.dismissToasts() }
                  HStack(spacing: 8) {
                    Image(systemName: specAlertIcon(specString("info")))
                      .foregroundStyle(specAlertColor(specString("info")))
                    Text(specString("New features are available.")).font(.subheadline)
                    Spacer(minLength: 0)
                    Button(action: { vm.dismissToasts() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.buttonStyle(.borderless).accessibilityLabel("Dismiss notification")
                  }
                  .padding(12)
                  .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                  .shadow(radius: 4)
                  .specAutoDismiss(after: 5000) { vm.dismissToasts() }
    })
  }
}
