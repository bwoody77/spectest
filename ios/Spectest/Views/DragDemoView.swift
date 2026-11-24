import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct DragDemoView: View {
  @State private var vm = DragDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = DragDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Drag & Drop"))
        .font(.largeTitle)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Sortable lists and Kanban boards with HTML5 drag-and-drop. Zero external dependencies."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        Button(action: { specClick { vm.setActiveDemo("sortable") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Sortable List"))
            .foregroundStyle(((vm.isSortable) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(14))
        .background(((vm.isSortable) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setActiveDemo("kanban") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Kanban Board"))
            .foregroundStyle(((vm.isKanban) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(14))
        .background(((vm.isKanban) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }

      if specEq(vm.activeDemo, "sortable") {
        _specArm0
      }
      if specEq(vm.activeDemo, "kanban") {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        HStack(alignment: .center, spacing: 0) {
          Text(verbatim: specString("Project Board"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Spacer(minLength: 0)
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(verbatim: specString("Drag cards between columns. The In Progress column has a WIP limit of 3."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            if specNeq(vm.lastMove, "") {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString(vm.lastMove))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(Color(hex: "#166534"))
            }
            .padding(specBorderWidth("1px solid #bbf7d0"))
            .padding(.vertical, CGFloat(4))
            .padding(.horizontal, CGFloat(12))
            .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
            }
          }

        }
        .frame(maxWidth: .infinity)

        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: 0) {
          KanbanBoardView(columns: vm.kanbanColumns, columnWidth: "220px", showCount: true)
        }
        }

      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        HStack(alignment: .top, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString("Task Priority Queue"))
                    .font(.title2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Spacer(minLength: 0)
                  Text(verbatim: specString("Drag to reorder"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }
                .frame(maxWidth: .infinity)

                SortableView(badgeColors: ["Critical": "#fef2f2" as Any, "High": "#fef9c3" as Any, "Medium": "#ede9fe" as Any, "Low": "#f0fdf4" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: vm.sortableItems, labelKey: "name")
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .specFlexGrow(1)
          VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Text(verbatim: specString("How it works"))
                  .font(.title2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Drag any row by its handle icon to change the order. The onReorder callback fires with the updated array."))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                if specNeq(vm.lastReorder, "") {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString(vm.lastReorder))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(Color(hex: "#166534"))
                }
                .padding(specBorderWidth("1px solid #bbf7d0"))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                }
                Text(verbatim: specString("Items: \(specString(specLength(vm.sortableItems)))"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }
          .frame(width: CGFloat(220), alignment: .leading)
        }

      }

    })
  }
}
