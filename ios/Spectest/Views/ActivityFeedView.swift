import SwiftUI
import SpecRuntime

@Observable
final class ActivityFeedViewModel {
  var typeFilter: Any = "all"
  var allActivity: Any { (activityItems != nil ? activityItems : [] as [Any]) }
  var filteredActivity: Any { (specEq(typeFilter, "all") ? allActivity : specFilter(allActivity, { (a: Any) -> Bool in return specEq(specGet(a, "type"), typeFilter) })) }
  var activityCount: Any { "\(specString(specLength(filteredActivity))) events" }
  var hasNoActivity: Any { specEq(specLength(filteredActivity), 0) }
  var timelineItems: Any { specMap(filteredActivity, { (a: Any) -> Any in return ["id": specGet(a, "id") as Any, "title": specGet(a, "user") as Any, "description": specGet(a, "detail") as Any, "date": specGet(a, "timestamp") as Any, "status": ({ () -> Any in switch specString(specGet(a, "type")) {
case specString("task_completed"): return "completed"
case specString("deploy"): return "completed"
default: return "active"
} })() as Any] as [String: Any] }) }
  let activityItemsSource = DataSource(endpoint: "http://localhost:4000/api/activity", method: "GET")
  var activityItems: Any? { activityItemsSource.data }
  var activityItemsLoading: Bool { activityItemsSource.loading }
  var activityItemsError: String? { activityItemsSource.error }
  func setTypeFilter(_ v: Any) {
    typeFilter = v
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
  func loadSources() async {
    await activityItemsSource.fetch()
  }
}

struct ActivityFeedView: View {
  @State private var vm = ActivityFeedViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("clock")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
        Text(verbatim: specString("Activity Feed"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: CGFloat(8)) {
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
        .padding(CGFloat(12))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(spacing: CGFloat(12)) {
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

      VStack() {
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

      VStack() {
        if (vm.hasNoActivity) as? Bool ?? false {
          ContentUnavailableView(specString("No Activity"), systemImage: "tray", description: Text(specString("No activity events match your current filter.")))
            .frame(height: 200)
        }
      }

      VStack() {
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

      VStack(spacing: CGFloat(12)) {
        if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
          ForEach(Array(specArr(vm.filteredActivity).enumerated()), id: \.offset) { idx, item in
            HStack(alignment: .center, spacing: CGFloat(12)) {
              ActivityIconView(activityType: specGet(item, "type"))
              VStack(spacing: CGFloat(4)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(verbatim: specString(specGet(item, "user")))
                    .font(.body.bold())
                  Spacer(minLength: 0)
                  Text(specString(specGet(item, "type")))
                    .font(.caption.weight(.medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundStyle(specBadgeForeground(specString("neutral")))
                    .background(specBadgeBackground(specString("neutral")), in: Capsule())
                }
                .frame(maxWidth: .infinity)

                Text(verbatim: specString(specGet(item, "detail")))
                  .font(.callout.bold())
                Text(verbatim: specString(specGet(item, "timestamp")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }

              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(CGFloat(12))
            .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .hoverEffect(.highlight)
          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
