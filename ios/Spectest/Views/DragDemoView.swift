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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct DragDemoView: View {
  @State private var vm = DragDemoViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(verbatim: specString("Drag & Drop"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(verbatim: specString("Sortable lists and Kanban boards with HTML5 drag-and-drop. Zero external dependencies."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      HStack(alignment: .center, spacing: CGFloat(8)) {
        VStack() {
          Text(verbatim: specString("Sortable List"))
            .foregroundStyle(Color(hex: ((vm.isSortable) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isSortable) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setActiveDemo("sortable") }
        VStack() {
          Text(verbatim: specString("Kanban Board"))
            .foregroundStyle(Color(hex: ((vm.isKanban) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isKanban) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setActiveDemo("kanban") }
      }

      VStack(spacing: CGFloat(16)) {
        if specEq(vm.activeDemo, "sortable") {
          HStack(alignment: .center, spacing: CGFloat(16)) {
            VStack() {
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(16)) {
                  HStack(alignment: .center, ) {
                    Text(verbatim: specString("Task Priority Queue"))
                      .font(.headline.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    Text(verbatim: specString("Drag to reorder"))
                      .font(.callout.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  }

                  SortableView(badgeColors: ["Critical": "#fef2f2" as Any, "High": "#fef9c3" as Any, "Medium": "#ede9fe" as Any, "Low": "#f0fdf4" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: vm.sortableItems, labelKey: "name")
                }
                .padding(CGFloat(20))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
            VStack() {
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(12)) {
                  Text(verbatim: specString("How it works"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(verbatim: specString("Drag any row by its handle icon to change the order. The onReorder callback fires with the updated array."))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  VStack() {
                    if specNeq(vm.lastReorder, "") {
                      Text(verbatim: specString(vm.lastReorder))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#166534"))
                    }
                  }
                  .padding(CGFloat(12))
                  .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                  Text(verbatim: specString("Items: \(specString(specLength(vm.sortableItems)))"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }
                .padding(CGFloat(20))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .frame(width: CGFloat(220))
          }

        }
      }

      VStack(spacing: CGFloat(16)) {
        if specEq(vm.activeDemo, "kanban") {
          HStack(alignment: .center, ) {
            Text(verbatim: specString("Project Board"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              Text(verbatim: specString("Drag cards between columns. The In Progress column has a WIP limit of 3."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              VStack() {
                if specNeq(vm.lastMove, "") {
                  Text(verbatim: specString(vm.lastMove))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#166534"))
                }
              }
              .padding(CGFloat(0))
              .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            }

          }

        }
        VStack() {
          KanbanBoardView(columns: vm.kanbanColumns, columnWidth: "220px", showCount: true)
        }
        .scrollIndicators(.visible)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
