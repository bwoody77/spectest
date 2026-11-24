import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class AnalyticsViewViewModel {
  var total: Any { (!specIsNil(stats) ? specGet(stats, "total") : 0) }
  var done: Any { (!specIsNil(stats) ? specGet(stats, "done") : 0) }
  var inProgress: Any { (!specIsNil(stats) ? specGet(stats, "inProgress") : 0) }
  var todo: Any { (!specIsNil(stats) ? specGet(stats, "todo") : 0) }
  var donePercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(done) * specDouble(100))) / specDouble(total)) : 0) }
  var inProgressPercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(inProgress) * specDouble(100))) / specDouble(total)) : 0) }
  var todoPercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(todo) * specDouble(100))) / specDouble(total)) : 0) }
  var taskList: Any { (!specIsNil(tasks) ? tasks : [] as [Any]) }
  var highCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "high") })) }
  var mediumCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "medium") })) }
  var lowCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "low") })) }
  var aliceCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Alice") })) }
  var bobCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Bob") })) }
  var carolCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Carol") })) }
  let statsSource = DataSource(endpoint: "http://localhost:4500/api/stats", method: "GET")
  var stats: Any? { statsSource.data }
  var statsLoading: Bool { statsSource.loading }
  var statsError: String? { statsSource.error }
  var statsErrorBody: Any? { statsSource.errorBody }
  let tasksSource = DataSource(endpoint: "http://localhost:4500/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  var tasksErrorBody: Any? { tasksSource.errorBody }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await statsSource.fetch()
    await tasksSource.fetch()
  }
}

struct AnalyticsViewView: View {
  @State private var vm = AnalyticsViewViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = AnalyticsViewViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-6"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("bar-chart")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Analytics"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
      }

      if (vm.statsLoading) as? Bool ?? false {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        if (vm.statsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
        }
      }

      }
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          VStack(alignment: .center, spacing: 2) {
            Text(specString("Total Tasks")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
            Text(specString("\(specString(vm.total))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
            if specString("") != "" {
              let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
              HStack(spacing: 4) {
                Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
              }
            }
            if specString("") != "" {
              Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("gradient-stat-primary"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .hoverEffect(.highlight)
        VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          VStack(alignment: .center, spacing: 2) {
            Text(specString("Completed")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
            Text(specString("\(specString(vm.done))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
            if specString("") != "" {
              let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
              HStack(spacing: 4) {
                Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
              }
            }
            if specString("") != "" {
              Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("gradient-stat-success"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .hoverEffect(.highlight)
        VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("warning"))
          VStack(alignment: .center, spacing: 2) {
            Text(specString("In Progress")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
            Text(specString("\(specString(vm.inProgress))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
            if specString("") != "" {
              let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
              HStack(spacing: 4) {
                Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
              }
            }
            if specString("") != "" {
              Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("gradient-stat-warning"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .hoverEffect(.highlight)
        VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("text-muted"))
          VStack(alignment: .center, spacing: 2) {
            Text(specString("Todo")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
            Text(specString("\(specString(vm.todo))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
            if specString("") != "" {
              let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
              HStack(spacing: 4) {
                Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
              }
            }
            if specString("") != "" {
              Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("gradient-stat-neutral"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
        .hoverEffect(.highlight)
      }

      LazyVGrid(columns: [GridItem(.flexible())], spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        VStack(alignment: .leading) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            Text(verbatim: specString("Status Breakdown"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Completed"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("success-text"))
                    .textCase(.uppercase)
                  Spacer(minLength: 0)
                  Text(verbatim: specString("\(specString(vm.done))"))
                    .font(.body.weight(.bold))
                    .foregroundStyle(ThemeManager.shared.color("success"))
                }
                .frame(maxWidth: .infinity)

                ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("In Progress"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("warning-text"))
                    .textCase(.uppercase)
                  Spacer(minLength: 0)
                  Text(verbatim: specString("\(specString(vm.inProgress))"))
                    .font(.body.weight(.bold))
                    .foregroundStyle(ThemeManager.shared.color("warning"))
                }
                .frame(maxWidth: .infinity)

                ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Text(verbatim: specString("Todo"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-strong"))
                    .textCase(.uppercase)
                  Spacer(minLength: 0)
                  Text(verbatim: specString("\(specString(vm.todo))"))
                    .font(.body.weight(.bold))
                    .foregroundStyle(ThemeManager.shared.color("text-muted"))
                }
                .frame(maxWidth: .infinity)

                ProgressView(value: (vm.todoPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

            }

          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        VStack(alignment: .leading) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            Text(verbatim: specString("Priority Breakdown"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("alert-triangle")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("destructive"))
                  Text(verbatim: specString("High Priority"))
                    .font(.body.weight(.medium))
                }

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.highCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("error")))
                  .background(specBadgeBackground(specString("error")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-error")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background(ThemeManager.shared.color("error-bg"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-error"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .hoverEffect(.highlight)
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("info")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("warning"))
                  Text(verbatim: specString("Medium Priority"))
                    .font(.body.weight(.medium))
                }

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.mediumCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("warning")))
                  .background(specBadgeBackground(specString("warning")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-warning")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background(ThemeManager.shared.color("warning-light"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-warning"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .hoverEffect(.highlight)
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Image(systemName: specIconName(specString("check")))
                    .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("success"))
                  Text(verbatim: specString("Low Priority"))
                    .font(.body.weight(.medium))
                }

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.lowCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("success")))
                  .background(specBadgeBackground(specString("success")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-success")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background(ThemeManager.shared.color("success-light"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-success"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .hoverEffect(.highlight)
            }

          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      }

      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          Text(verbatim: specString("Workload Distribution"))
            .font(.title)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              VStack(alignment: .center, spacing: 2) {
                Text(specString("Alice's tasks")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                Text(specString("\(specString(vm.aliceCount))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                if specString("") != "" {
                  let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                  HStack(spacing: 4) {
                    Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                    if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
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
            .background(ThemeManager.shared.color("gradient-stat-primary-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .hoverEffect(.highlight)
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("success"))
              VStack(alignment: .center, spacing: 2) {
                Text(specString("Bob's tasks")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                Text(specString("\(specString(vm.bobCount))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                if specString("") != "" {
                  let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                  HStack(spacing: 4) {
                    Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                    if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
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
            .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .hoverEffect(.highlight)
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("warning"))
              VStack(alignment: .center, spacing: 2) {
                Text(specString("Carol's tasks")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                Text(specString("\(specString(vm.carolCount))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                if specString("") != "" {
                  let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                  HStack(spacing: 4) {
                    Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                    if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
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
            .background(ThemeManager.shared.color("gradient-stat-warning-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .hoverEffect(.highlight)
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
  }
}
