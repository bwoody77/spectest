import SwiftUI
import SpecRuntime

@Observable
final class DragDemoViewModel {
  var activeDemo: Any = "sortable"
  var sortableItems: Any = [["id": "1" as Any, "name": "Design system tokens" as Any, "priority": "High" as Any] as [String: Any], ["id": "2" as Any, "name": "Implement auth flow" as Any, "priority": "Critical" as Any] as [String: Any], ["id": "3" as Any, "name": "Write API tests" as Any, "priority": "Medium" as Any] as [String: Any], ["id": "4" as Any, "name": "Update documentation" as Any, "priority": "Low" as Any] as [String: Any], ["id": "5" as Any, "name": "Performance audit" as Any, "priority": "Medium" as Any] as [String: Any], ["id": "6" as Any, "name": "Accessibility review" as Any, "priority": "High" as Any] as [String: Any]] as [Any]
  var lastReorder: Any = ""
  var kanbanColumns: Any = [["id": "backlog" as Any, "title": "Backlog" as Any, "color": "#f3f4f6" as Any, "items": [["id": "k1" as Any, "title": "Research competitors" as Any, "tag": "Research" as Any] as [String: Any], ["id": "k2" as Any, "title": "Define MVP scope" as Any, "tag": "Planning" as Any] as [String: Any], ["id": "k3" as Any, "title": "Set up CI/CD" as Any, "tag": "Infra" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "todo" as Any, "title": "To Do" as Any, "color": "#ede9fe" as Any, "items": [["id": "k4" as Any, "title": "Design login page" as Any, "tag": "Design" as Any] as [String: Any], ["id": "k5" as Any, "title": "Create data models" as Any, "tag": "Backend" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "progress" as Any, "title": "In Progress" as Any, "color": "#dbeafe" as Any, "limit": 3 as Any, "items": [["id": "k6" as Any, "title": "Build dashboard" as Any, "tag": "Frontend" as Any] as [String: Any], ["id": "k7" as Any, "title": "API integration" as Any, "tag": "Backend" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "review" as Any, "title": "Review" as Any, "color": "#fef9c3" as Any, "items": [["id": "k8" as Any, "title": "User onboarding UX" as Any, "tag": "Design" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["id": "done" as Any, "title": "Done" as Any, "color": "#dcfce7" as Any, "items": [["id": "k9" as Any, "title": "Project kickoff" as Any, "tag": "Planning" as Any] as [String: Any], ["id": "k10" as Any, "title": "Tech stack decision" as Any, "tag": "Infra" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any]
  var lastMove: Any = ""
  var isSortable: Any { specEq(activeDemo, "sortable") }
  var isKanban: Any { specEq(activeDemo, "kanban") }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setActiveDemo(_ d: Any) {
    activeDemo = d
  }
  func reorderItems(_ items: Any) {
    sortableItems = items
    lastReorder = specAdd(specAdd(specAdd("Reordered to: ", specGet((items as? [Any])?[0], "name")), " → "), specGet(specGet(items, (specDouble(specLength(items)) - specDouble(1))), "name"))
  }
  func moveCard(_ cardId: Any, _ fromCol: Any, _ toCol: Any, _ idx: Any) {
    lastMove = specAdd(specAdd(specAdd("Moved card to ", toCol), " at position "), idx)
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct DragDemoView: View {
  @State private var vm = DragDemoViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      Text(verbatim: specString("Drag & Drop"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Sortable lists and Kanban boards with HTML5 drag-and-drop. Zero external dependencies."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
        Button(action: { vm.setActiveDemo("sortable") }) {
        VStack() {
          Text(verbatim: specString("Sortable List"))
            .foregroundStyle(((vm.isSortable) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isSortable) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setActiveDemo("kanban") }) {
        VStack() {
          Text(verbatim: specString("Kanban Board"))
            .foregroundStyle(((vm.isKanban) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isKanban) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
      }

      VStack(spacing: ThemeManager.shared.size("spacing-4")) {
        if specEq(vm.activeDemo, "sortable") {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
            VStack() {
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-4")) {
                  HStack(alignment: .center) {
                    Text(verbatim: specString("Task Priority Queue"))
                      .font(.headline.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString("Drag to reorder"))
                      .font(.callout.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  }

                  SortableView(badgeColors: ["Critical": "#fef2f2" as Any, "High": "#fef9c3" as Any, "Medium": "#ede9fe" as Any, "Low": "#f0fdf4" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: vm.sortableItems, labelKey: "name")
                }
                .padding(ThemeManager.shared.size("spacing-5"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .frame(maxWidth: .infinity)
            VStack() {
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                  Text(verbatim: specString("How it works"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Text(verbatim: specString("Drag any row by its handle icon to change the order. The onReorder callback fires with the updated array."))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack() {
                    if specNeq(vm.lastReorder, "") {
                      Text(verbatim: specString(vm.lastReorder))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#166534"))
                    }
                  }
                  .padding(ThemeManager.shared.size("spacing-3"))
                  .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
                  Text(verbatim: specString("Items: \(specString(specLength(vm.sortableItems)))"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }
                .padding(ThemeManager.shared.size("spacing-5"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .frame(width: CGFloat(220))
          }

        }
      }

      VStack(spacing: ThemeManager.shared.size("spacing-4")) {
        if specEq(vm.activeDemo, "kanban") {
          HStack(alignment: .center) {
            Text(verbatim: specString("Project Board"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
              Text(verbatim: specString("Drag cards between columns. The In Progress column has a WIP limit of 3."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              VStack() {
                if specNeq(vm.lastMove, "") {
                  Text(verbatim: specString(vm.lastMove))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#166534"))
                }
              }
              .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            }

          }

        }
        ScrollView(.horizontal, showsIndicators: true) {
        VStack() {
          KanbanBoardView(columns: vm.kanbanColumns, columnWidth: "220px", showCount: true)
        }
        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
