import SwiftUI
import SpecRuntime

@Observable
final class FeatureTestViewModel {
  var activeTab: Any = "p1"
  var matchValue: Any = "A"
  var counter: Any = 0
  var isP1: Any { (specString(activeTab) == specString("p1")) }
  var isP2: Any { (specString(activeTab) == specString("p2")) }
  var isP3: Any { (specString(activeTab) == specString("p3")) }
  var isP4: Any { (specString(activeTab) == specString("p4")) }
  var isP6: Any { (specString(activeTab) == specString("p6")) }
  var isP7: Any { (specString(activeTab) == specString("p7")) }
  var isP8: Any { (specString(activeTab) == specString("p8")) }
  var matchResult: Any { ({ () -> Any in switch specString(matchValue) {
case specString("A"): return "Arm 'A' matched — the match expression chose this literal arm."
case specString("B"): return "Arm 'B' matched — second arm works."
case specString("C"): return "Arm 'C' matched — third arm works."
default: return "Wildcard arm matched — no literal arm for this value."
} })() }
  var counterLabel: Any { ({ () -> Any in switch specString(counter) {
case specString(0): return "zero"
case specString(1): return "one"
case specString(2): return "two"
case specString(3): return "three"
default: return "many"
} })() }
  func setTab(_ t: Any) {
    activeTab = t
  }
  func setMatch(_ v: Any) {
    matchValue = v
  }
  func increment() {
    counter = specAdd(counter, 1)
  }
  func resetCounter() {
    counter = 0
  }
  func noOp(_ items: Any) {
  }
}

struct FeatureTestView: View {
  @State private var vm = FeatureTestViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(specString("Feature Test — P1 through P8"))
        .font(.title2.bold())
        .foregroundStyle(.primary)
      Text(specString("Verify each completed priority. Use the tabs to navigate between features. P5 (SSR) was deferred."))
        .font(.body.bold())
        .foregroundStyle(.secondary)
      HStack(alignment: .center, spacing: CGFloat(8)) {
        VStack() {
          Text(specString("P1 · Slots"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP1) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP1) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p1") }
        VStack() {
          Text(specString("P2 · Router"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP2) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP2) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p2") }
        VStack() {
          Text(specString("P3 · Icons"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP3) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP3) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p3") }
        VStack() {
          Text(specString("P4 · Charts"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP4) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP4) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p4") }
        VStack() {
          Text(specString("P6 · @form"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP6) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP6) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p6") }
        VStack() {
          Text(specString("P7 · Drag"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP7) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP7) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p7") }
        VStack() {
          Text(specString("P8 · match"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP8) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP8) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setTab("p8") }
      }

      VStack(spacing: CGFloat(20)) {
        if vm.isP1 as? Bool ?? false {
          Text(specString("P1 — Component Declarations"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
        }
        VStack(spacing: CGFloat(12)) {
          Text(specString("@children — default slot"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          InfoBoxView(title: "Custom Title (prop)")
          InfoBoxView()
        }

        VStack(spacing: CGFloat(12)) {
          Text(specString("@slot(\"name\") — named slots"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          SplitRowView()
        }

        VStack(spacing: CGFloat(12)) {
          Text(specString("@watch — prop change watcher"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          Text(specString("CountDisplay watches its 'value' prop and tracks how many times it changed."))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          HStack(alignment: .center, spacing: CGFloat(16)) {
            CountDisplayView(value: vm.counter)
            HStack(alignment: .center, spacing: CGFloat(8)) {
              VStack() {
                Text(specString("Increment (\(specString(vm.counter)))"))
                  .foregroundStyle(Color(.secondarySystemGroupedBackground))
              }
              .padding(CGFloat(0))
              .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(8)))
              .onTapGesture { vm.increment() }
              VStack() {
                Text(specString("Reset"))
                  .foregroundStyle(.primary)
              }
              .padding(CGFloat(0))
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
              .onTapGesture { vm.resetCounter() }
            }

            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

        }

      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP2 as? Bool ?? false {
          Text(specString("P2 — Client-Side Routing (@router)"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
        }
        Text(specString("The @router block generates _routePath, _routeParams, and navigate() for path-based routing without a page reload."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        VStack(spacing: CGFloat(8)) {
          Text(specString("Generated by @router:"))
            .font(.body.bold())
            .foregroundStyle(.primary)
          Text(specString("_routePath — current URL pathname (string signal)"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          Text(specString("_routeParams — object with :param values extracted from the URL"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          Text(specString("navigate(path) — action: calls history.pushState + updates signals"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          Text(specString("Back/forward handled via popstate listener (auto-generated)"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
        }
        .padding(CGFloat(16))
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        VStack() {
          Text(specString("Navigate to Components > Routing in the sidebar for the full interactive demo with sidebar navigation, user detail routes, and 404 fallback."))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(CGFloat(16))
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP3 as? Bool ?? false {
          Text(specString("P3 — Icon System"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
        }
        Text(specString("The Icon component renders SVG icons by name. The @icons declaration enables namespaced external icon providers."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        VStack(spacing: CGFloat(12)) {
          Text(specString("Icon component — name, size, color props:"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          HStack(alignment: .center, spacing: CGFloat(20)) {
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("home")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
              Text(specString("home"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("settings")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b" as? String ?? "#000"))
              Text(specString("settings"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
              Text(specString("user"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("bell")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#ef4444" as? String ?? "#000"))
              Text(specString("bell"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("star")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#6366f1" as? String ?? "#000"))
              Text(specString("star"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("zap")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b" as? String ?? "#000"))
              Text(specString("zap"))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }

          }

          Text(specString("Size variants (16 / 24 / 32 / 48 px):"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          HStack(alignment: .center, spacing: CGFloat(16)) {
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(16)))
              .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(24)))
              .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(32)))
              .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(48)))
              .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
          }

          Text(specString("@icons declaration (namespaced providers):"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          VStack(spacing: CGFloat(4)) {
            Text(specString("@icons { lucide: '@spec/icons-lucide' (default) }"))
              .font(.body)
              .foregroundStyle(.primary)
            Text(specString("// Usage: Icon(name: \"lucide:arrow-right\")"))
              .font(.body)
              .foregroundStyle(.secondary)
          }
          .padding(CGFloat(12))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }

      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP4 as? Bool ?? false {
          Text(specString("P4 — Data Visualization (Chart)"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
          Text(specString("Built-in SVG charts — line, bar, area, pie, donut. Zero external dependencies. Responsive via ResizeObserver."))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          ChartView(data: [["label": "P1" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P2" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P3" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P4" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P5" as Any, "done": 0 as Any, "skipped": 1 as Any] as [String: Any], ["label": "P6" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P7" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P8" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any]] as [Any], height: "200px", series: [["key": "done" as Any, "label": "Done" as Any, "color": "#10b981" as Any] as [String: Any], ["key": "skipped" as Any, "label": "Deferred" as Any, "color": "#f59e0b" as Any] as [String: Any]] as [Any], showGrid: true, showLegend: true, showValues: true, type: "bar", xKey: "label")
          Text(specString("Supported types: line · bar · area · pie · donut"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          VStack() {
            Text(specString("Navigate to Components > Charts in the sidebar for the full interactive demo with all five chart types."))
              .font(.callout.bold())
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }
      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP6 as? Bool ?? false {
          Text(specString("P6 — Form Validation (@form)"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
        }
        Text(specString("The @form block generates field-level validation signals and actions with zero boilerplate."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        HStack(alignment: .center, spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(8)) {
            Text(specString("Per-field signals (e.g. for field 'email'):"))
              .font(.body.bold())
              .foregroundStyle(.primary)
            Text(specString("_fld_email_touched — bool, true after blur or submit attempt"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
            Text(specString("_fld_email_error — null | error string (first failing validator)"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
          }
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .frame(maxWidth: .infinity)
          VStack(spacing: CGFloat(8)) {
            Text(specString("Surface-wide signals and actions:"))
              .font(.body.bold())
              .foregroundStyle(.primary)
            Text(specString("_form_valid — true when all fields pass"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
            Text(specString("_form_dirty — true when any field changed from initial"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
            Text(specString("_form_submit_attempted — set by _submitForm()"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
            Text(specString("_touchField(name), _submitForm(), _resetForm(), _formData()"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
          }
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .frame(maxWidth: .infinity)
        }

        VStack(spacing: CGFloat(4)) {
          Text(specString("Built-in validators:"))
            .font(.body.bold())
            .foregroundStyle(.primary)
          Text(specString("required · email · min-length(n) · max-length(n) · min(n) · max(n) · pattern(\"regex\")"))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
        }
        .padding(CGFloat(16))
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        VStack() {
          Text(specString("Navigate to Components > Form Validation for the full interactive demo with live error display and form state inspector."))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(CGFloat(16))
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP7 as? Bool ?? false {
          Text(specString("P7 — Drag & Drop (Sortable, KanbanBoard)"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
          Text(specString("HTML5 Drag and Drop — reorderable lists and multi-column kanban boards. Zero external dependencies."))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          Text(specString("Drag these rows to reorder:"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          SortableView(badgeColors: ["Done": "#dcfce7" as Any, "Deferred": "#fef9c3" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: [["id": "1" as Any, "name": "P1 — Component Declarations" as Any, "priority": "Done" as Any] as [String: Any], ["id": "2" as Any, "name": "P2 — Client-Side Routing" as Any, "priority": "Done" as Any] as [String: Any], ["id": "3" as Any, "name": "P3 — Icon System" as Any, "priority": "Done" as Any] as [String: Any], ["id": "4" as Any, "name": "P4 — Chart Component" as Any, "priority": "Done" as Any] as [String: Any], ["id": "5" as Any, "name": "P5 — Server-Side Rendering" as Any, "priority": "Deferred" as Any] as [String: Any], ["id": "6" as Any, "name": "P6 — Form Validation (@form)" as Any, "priority": "Done" as Any] as [String: Any], ["id": "7" as Any, "name": "P7 — Drag & Drop" as Any, "priority": "Done" as Any] as [String: Any], ["id": "8" as Any, "name": "P8 — match statement" as Any, "priority": "Done" as Any] as [String: Any]] as [Any], labelKey: "name")
          VStack() {
            Text(specString("Navigate to Components > Drag & Drop for the full demo including KanbanBoard with WIP limits and cross-column drag."))
              .font(.callout.bold())
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }
      }

      VStack(spacing: CGFloat(16)) {
        if vm.isP8 as? Bool ?? false {
          Text(specString("P8 — match Statement"))
            .font(.headline.bold())
            .foregroundStyle(.primary)
        }
        Text(specString("match works both as an expression (returns a value) and as a surface-level construct (lazily mounts one component arm)."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        VStack(spacing: CGFloat(12)) {
          Text(specString("match as expression — select an option:"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          HStack(alignment: .center, spacing: CGFloat(8)) {
            VStack() {
              Text(specString("A"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: ((specString(vm.matchValue) == specString("A")) ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: ((specString(vm.matchValue) == specString("A")) ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.setMatch("A") }
            VStack() {
              Text(specString("B"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: ((specString(vm.matchValue) == specString("B")) ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: ((specString(vm.matchValue) == specString("B")) ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.setMatch("B") }
            VStack() {
              Text(specString("C"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: ((specString(vm.matchValue) == specString("C")) ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: ((specString(vm.matchValue) == specString("C")) ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.setMatch("C") }
            VStack() {
              Text(specString("D"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: ((specString(vm.matchValue) == specString("D")) ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: ((specString(vm.matchValue) == specString("D")) ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.setMatch("D") }
          }

          VStack() {
            Text(specString(vm.matchResult))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#5b21b6"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#ede9fe"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }

        VStack(spacing: CGFloat(12)) {
          Text(specString("match with number arms and wildcard:"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          Text(specString("counter matched to a label: \(specString(vm.counterLabel)) (counter = \(specString(vm.counter)))"))
            .font(.body.bold())
            .foregroundStyle(.primary)
          HStack(alignment: .center, spacing: CGFloat(8)) {
            VStack() {
              Text(specString("Count up"))
                .foregroundStyle(Color(.secondarySystemGroupedBackground))
            }
            .padding(CGFloat(0))
            .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.increment() }
            VStack() {
              Text(specString("Reset to 0"))
                .foregroundStyle(.primary)
            }
            .padding(CGFloat(0))
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { vm.resetCounter() }
          }

        }

        VStack(spacing: CGFloat(8)) {
          Text(specString("match as surface-level construct:"))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          Text(specString("Used throughout app.spec — viewTitle and breadcrumbSection are both match expressions over 'view'."))
            .font(.callout.bold())
            .foregroundStyle(.secondary)
          VStack(spacing: CGFloat(4)) {
            Text(specString("viewTitle: match view {"))
              .font(.body)
              .foregroundStyle(.primary)
            Text(specString("  \"dashboard\" -> \"Dashboard\","))
              .font(.body)
              .foregroundStyle(.primary)
            Text(specString("  \"charts\"    -> \"Charts\","))
              .font(.body)
              .foregroundStyle(.primary)
            Text(specString("  _ -> \"Admin\""))
              .font(.body)
              .foregroundStyle(.primary)
            Text(specString("}"))
              .font(.body)
              .foregroundStyle(.primary)
          }
          .padding(CGFloat(12))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }

      }

    }
    .foregroundStyle(.primary)
  }
}
