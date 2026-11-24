import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class ActivityFeedViewModel {
  var typeFilter: Any = "all"
  var allActivity: Any { (!specIsNil(activityItems) ? activityItems : [] as [Any]) }
  var filteredActivity: Any { (specEq(typeFilter, "all") ? allActivity : specFilter(allActivity, { (a: Any) -> Bool in return specEq(specGet(a, "type"), typeFilter) })) }
  var activityCount: Any { "\(specString(specLength(filteredActivity))) events" }
  var hasNoActivity: Any { specEq(specLength(filteredActivity), 0) }
  var timelineItems: Any { specMap(filteredActivity, { (a: Any) -> Any in return ["id": specGet(a, "id") as Any, "title": specGet(a, "user") as Any, "description": specGet(a, "detail") as Any, "date": specGet(a, "timestamp") as Any, "status": ({ () -> Any in switch specString(specGet(a, "type")) {
case specString("task_completed"): return "completed"
case specString("deploy"): return "completed"
default: return "active"
} })() as Any] as [String: Any] }) }
  let activityItemsSource = DataSource(endpoint: "http://localhost:4500/api/activity", method: "GET")
  var activityItems: Any? { activityItemsSource.data }
  var activityItemsLoading: Bool { activityItemsSource.loading }
  var activityItemsError: String? { activityItemsSource.error }
  var activityItemsErrorBody: Any? { activityItemsSource.errorBody }
  func setTypeFilter(_ v: Any) {
    typeFilter = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await activityItemsSource.fetch()
  }
}

struct ActivityFeedView: View {
  @State private var vm = ActivityFeedViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ActivityFeedViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("clock")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Activity Feed"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
      }

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
          Text(specString(vm.activityCount))
            .font(.caption.weight(.medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(specBadgeForeground(specString("neutral")))
            .background(specBadgeBackground(specString("neutral")), in: Capsule())
          Picker("", selection: Binding(get: { specString(vm.typeFilter) }, set: { vm.typeFilter = $0 })) {
            Text("All").tag("all")
            Text("Tasks").tag("task_created")
            Text("Comments").tag("comment")
            Text("Deploys").tag("deploy")
          }
          .pickerStyle(.segmented)
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
        .accessibilityElement(children: .contain)
        .accessibilityLabel(specString("Activity filters"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      if (vm.activityItemsLoading) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        if (vm.activityItemsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
        }
      }

      }
      if (vm.activityItemsError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.activityItemsError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load activity")).font(.subheadline.weight(.semibold))
              Text(specString("Could not retrieve the activity feed.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      }
      if (vm.hasNoActivity) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.hasNoActivity) as? Bool ?? false {
          ContentUnavailableView(specString("No Activity"), systemImage: "tray", description: Text(specString("No activity events match your current filter.")))
            .frame(height: 200)
        }
      }

      }
      if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(Array((vm.timelineItems as? [Any] ?? []).enumerated()), id: \.offset) { idx, item in
              HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 0) {
                  Circle().fill(Color.blue).frame(width: 10, height: 10)
                  if idx < (vm.timelineItems as? [Any] ?? []).count - 1 {
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
      }

      }
      if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        ForEach(Array(specArr(vm.filteredActivity).enumerated()), id: \.offset) { idx, item in
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            ActivityIconView(activityType: specGet(item, "type"))
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString(specGet(item, "user")))
                  .font(.body.weight(.semibold))
                Text(specString(specGet(item, "type")))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("neutral")))
                  .background(specBadgeBackground(specString("neutral")), in: Capsule())
              }

              Text(verbatim: specString(specGet(item, "detail")))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              Text(verbatim: specString(specGet(item, "timestamp")))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-sm-fontWeight")))
                .monospacedDigit()
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .center)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .hoverEffect(.highlight)
        }
      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
  }
}
