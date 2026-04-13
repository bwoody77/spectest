import SwiftUI
import SpecRuntime

@Observable
final class FeatureTestViewModel {
  var activeTab: Any = "p1"
  var matchValue: Any = "A"
  var counter: Any = 0
  var isP1: Any { specEq(activeTab, "p1") }
  var isP2: Any { specEq(activeTab, "p2") }
  var isP3: Any { specEq(activeTab, "p3") }
  var isP4: Any { specEq(activeTab, "p4") }
  var isP6: Any { specEq(activeTab, "p6") }
  var isP7: Any { specEq(activeTab, "p7") }
  var isP8: Any { specEq(activeTab, "p8") }
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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct FeatureTestView: View {
  @State private var vm = FeatureTestViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(verbatim: specString("Feature Test — P1 through P8"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(verbatim: specString("Verify each completed priority. Use the tabs to navigate between features. P5 (SSR) was deferred."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      HStack(alignment: .center, spacing: CGFloat(8)) {
        VStack() {
          Text(verbatim: specString("P1 · Slots"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP1) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP1) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p1") }
        VStack() {
          Text(verbatim: specString("P2 · Router"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP2) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP2) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p2") }
        VStack() {
          Text(verbatim: specString("P3 · Icons"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP3) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP3) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p3") }
        VStack() {
          Text(verbatim: specString("P4 · Charts"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP4) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP4) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p4") }
        VStack() {
          Text(verbatim: specString("P6 · @form"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP6) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP6) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p6") }
        VStack() {
          Text(verbatim: specString("P7 · Drag"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP7) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP7) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p7") }
        VStack() {
          Text(verbatim: specString("P8 · match"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((vm.isP8) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isP8) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setTab("p8") }
      }

      VStack(spacing: CGFloat(20)) {
        if (vm.isP1) as? Bool ?? false {
          Text(verbatim: specString("P1 — Component Declarations"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("@children — default slot"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          InfoBoxView(title: "Custom Title (prop)")
          InfoBoxView()
        }

        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("@slot(\"name\") — named slots"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          SplitRowView()
        }

        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("@watch — prop change watcher"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("CountDisplay watches its 'value' prop and tracks how many times it changed."))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          HStack(alignment: .center, spacing: CGFloat(16)) {
            CountDisplayView(value: vm.counter)
            HStack(alignment: .center, spacing: CGFloat(8)) {
              VStack() {
                Text(verbatim: specString("Increment (\(specString(vm.counter)))"))
                  .foregroundStyle(Color(hex: "#fff"))
              }
              .padding(CGFloat(0))
              .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.increment() }
              VStack() {
                Text(verbatim: specString("Reset"))
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(0))
              .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.resetCounter() }
            }

            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

        }

      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP2) as? Bool ?? false {
          Text(verbatim: specString("P2 — Client-Side Routing (@router)"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
        Text(verbatim: specString("The @router block generates _routePath, _routeParams, and navigate() for path-based routing without a page reload."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        VStack(spacing: CGFloat(8)) {
          Text(verbatim: specString("Generated by @router:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(verbatim: specString("_routePath — current URL pathname (string signal)"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("_routeParams — object with :param values extracted from the URL"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("navigate(path) — action: calls history.pushState + updates signals"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("Back/forward handled via popstate listener (auto-generated)"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
        .padding(CGFloat(16))
        .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        VStack() {
          Text(verbatim: specString("Navigate to Components > Routing in the sidebar for the full interactive demo with sidebar navigation, user detail routes, and 404 fallback."))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(CGFloat(16))
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP3) as? Bool ?? false {
          Text(verbatim: specString("P3 — Icon System"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
        Text(verbatim: specString("The Icon component renders SVG icons by name. The @icons declaration enables namespaced external icon providers."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("Icon component — name, size, color props:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          HStack(alignment: .center, spacing: CGFloat(20)) {
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("home")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
              Text(verbatim: specString("home"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("settings")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b" as? String ?? "#000"))
              Text(verbatim: specString("settings"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#10b981" as? String ?? "#000"))
              Text(verbatim: specString("user"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("bell")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#ef4444" as? String ?? "#000"))
              Text(verbatim: specString("bell"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("star")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#6366f1" as? String ?? "#000"))
              Text(verbatim: specString("star"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("zap")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b" as? String ?? "#000"))
              Text(verbatim: specString("zap"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }

          Text(verbatim: specString("Size variants (16 / 24 / 32 / 48 px):"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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

          Text(verbatim: specString("@icons declaration (namespaced providers):"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          VStack(spacing: CGFloat(4)) {
            Text(verbatim: specString("@icons { lucide: '@spec/icons-lucide' (default) }"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("// Usage: Icon(name: \"lucide:arrow-right\")"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP4) as? Bool ?? false {
          Text(verbatim: specString("P4 — Data Visualization (Chart)"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(verbatim: specString("Built-in SVG charts — line, bar, area, pie, donut. Zero external dependencies. Responsive via ResizeObserver."))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          SpecChartView(
            type: specString("bar"), data: [["label": "P1" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P2" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P3" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P4" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P5" as Any, "done": 0 as Any, "skipped": 1 as Any] as [String: Any], ["label": "P6" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P7" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P8" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any]] as [Any],
            xKey: specString("label"), yKey: specString("y"),
            labelKey: specString("label"), valueKey: specString("value"),
            series: [["key": "done" as Any, "label": "Done" as Any, "color": "#10b981" as Any] as [String: Any], ["key": "skipped" as Any, "label": "Deferred" as Any, "color": "#f59e0b" as Any] as [String: Any]] as [Any], color: specString(""), colors: [] as [Any],
            title: specString(""), height: specPx("200px"),
            showGrid: true as? Bool ?? true,
            showValues: true as? Bool ?? false,
            showLegend: true as? Bool ?? true,
            yMin: nil, yMax: nil,
            connectNulls: false as? Bool ?? false,
            colorKey: specString(""),
            formatX: specString(""), formatY: specString("")
          )
          Text(verbatim: specString("Supported types: line · bar · area · pie · donut"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          VStack() {
            Text(verbatim: specString("Navigate to Components > Charts in the sidebar for the full interactive demo with all five chart types."))
              .font(.callout.bold())
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP6) as? Bool ?? false {
          Text(verbatim: specString("P6 — Form Validation (@form)"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
        Text(verbatim: specString("The @form block generates field-level validation signals and actions with zero boilerplate."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        HStack(alignment: .center, spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Per-field signals (e.g. for field 'email'):"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("_fld_email_touched — bool, true after blur or submit attempt"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            Text(verbatim: specString("_fld_email_error — null | error string (first failing validator)"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .frame(maxWidth: .infinity)
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Surface-wide signals and actions:"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("_form_valid — true when all fields pass"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            Text(verbatim: specString("_form_dirty — true when any field changed from initial"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            Text(verbatim: specString("_form_submit_attempted — set by _submitForm()"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            Text(verbatim: specString("_touchField(name), _submitForm(), _resetForm(), _formData()"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .frame(maxWidth: .infinity)
        }

        VStack(spacing: CGFloat(4)) {
          Text(verbatim: specString("Built-in validators:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(verbatim: specString("required · email · min-length(n) · max-length(n) · min(n) · max(n) · pattern(\"regex\")"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
        .padding(CGFloat(16))
        .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        VStack() {
          Text(verbatim: specString("Navigate to Components > Form Validation for the full interactive demo with live error display and form state inspector."))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(CGFloat(16))
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP7) as? Bool ?? false {
          Text(verbatim: specString("P7 — Drag & Drop (Sortable, KanbanBoard)"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(verbatim: specString("HTML5 Drag and Drop — reorderable lists and multi-column kanban boards. Zero external dependencies."))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("Drag these rows to reorder:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          SortableView(badgeColors: ["Done": "#dcfce7" as Any, "Deferred": "#fef9c3" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: [["id": "1" as Any, "name": "P1 — Component Declarations" as Any, "priority": "Done" as Any] as [String: Any], ["id": "2" as Any, "name": "P2 — Client-Side Routing" as Any, "priority": "Done" as Any] as [String: Any], ["id": "3" as Any, "name": "P3 — Icon System" as Any, "priority": "Done" as Any] as [String: Any], ["id": "4" as Any, "name": "P4 — Chart Component" as Any, "priority": "Done" as Any] as [String: Any], ["id": "5" as Any, "name": "P5 — Server-Side Rendering" as Any, "priority": "Deferred" as Any] as [String: Any], ["id": "6" as Any, "name": "P6 — Form Validation (@form)" as Any, "priority": "Done" as Any] as [String: Any], ["id": "7" as Any, "name": "P7 — Drag & Drop" as Any, "priority": "Done" as Any] as [String: Any], ["id": "8" as Any, "name": "P8 — match statement" as Any, "priority": "Done" as Any] as [String: Any]] as [Any], labelKey: "name")
          VStack() {
            Text(verbatim: specString("Navigate to Components > Drag & Drop for the full demo including KanbanBoard with WIP limits and cross-column drag."))
              .font(.callout.bold())
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
      }

      VStack(spacing: CGFloat(16)) {
        if (vm.isP8) as? Bool ?? false {
          Text(verbatim: specString("P8 — match Statement"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }
        Text(verbatim: specString("match works both as an expression (returns a value) and as a surface-level construct (lazily mounts one component arm)."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("match as expression — select an option:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          HStack(alignment: .center, spacing: CGFloat(8)) {
            VStack() {
              Text(verbatim: specString("A"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: (specEq(vm.matchValue, "A") ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: (specEq(vm.matchValue, "A") ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.setMatch("A") }
            VStack() {
              Text(verbatim: specString("B"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: (specEq(vm.matchValue, "B") ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: (specEq(vm.matchValue, "B") ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.setMatch("B") }
            VStack() {
              Text(verbatim: specString("C"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: (specEq(vm.matchValue, "C") ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: (specEq(vm.matchValue, "C") ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.setMatch("C") }
            VStack() {
              Text(verbatim: specString("D"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: (specEq(vm.matchValue, "D") ? "#fff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: (specEq(vm.matchValue, "D") ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.setMatch("D") }
          }

          VStack() {
            Text(verbatim: specString(vm.matchResult))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#5b21b6"))
          }
          .padding(CGFloat(16))
          .background(Color(hex: "#ede9fe"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

        VStack(spacing: CGFloat(12)) {
          Text(verbatim: specString("match with number arms and wildcard:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("counter matched to a label: \(specString(vm.counterLabel)) (counter = \(specString(vm.counter)))"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          HStack(alignment: .center, spacing: CGFloat(8)) {
            VStack() {
              Text(verbatim: specString("Count up"))
                .foregroundStyle(Color(hex: "#fff"))
            }
            .padding(CGFloat(0))
            .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.increment() }
            VStack() {
              Text(verbatim: specString("Reset to 0"))
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            }
            .padding(CGFloat(0))
            .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.resetCounter() }
          }

        }

        VStack(spacing: CGFloat(8)) {
          Text(verbatim: specString("match as surface-level construct:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Text(verbatim: specString("Used throughout app.spec — viewTitle and breadcrumbSection are both match expressions over 'view'."))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          VStack(spacing: CGFloat(4)) {
            Text(verbatim: specString("viewTitle: match view {"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("  \"dashboard\" -> \"Dashboard\","))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("  \"charts\"    -> \"Charts\","))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("  _ -> \"Admin\""))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("}"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
