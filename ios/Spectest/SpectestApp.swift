import SwiftUI

// MARK: - Navigation Model

enum NavDestination: String, CaseIterable, Identifiable {
  case dashboard, analytics
  case detail, create, wizard
  case datagrid, editgrid, categories
  case team
  case activity, notifications
  case perfgrid, perfsignals, reactivityperf
  case themepreview
  case themepicker
  case charts, drag, formdemo, routing, mobiledemo
  case featuretest
  case settings

  var id: String { rawValue }

  var title: String {
    switch self {
    case .dashboard: return "Dashboard"
    case .analytics: return "Analytics"
    case .detail: return "Task Detail"
    case .create: return "Create Task"
    case .wizard: return "Task Wizard"
    case .datagrid: return "Product Catalog"
    case .editgrid: return "Editable Grid"
    case .categories: return "Categories"
    case .team: return "Team"
    case .activity: return "Activity"
    case .notifications: return "Notifications"
    case .perfgrid: return "Grid 10K"
    case .perfsignals: return "Signal Test"
    case .reactivityperf: return "Reactivity Perf"
    case .themepreview: return "Theme Preview"
    case .themepicker: return "Change Theme"
    case .charts: return "Charts"
    case .drag: return "Drag & Drop"
    case .formdemo: return "Form Validation"
    case .routing: return "Routing"
    case .mobiledemo: return "Mobile Demo"
    case .featuretest: return "Feature Test"
    case .settings: return "Settings"
    }
  }

  var icon: String {
    switch self {
    case .dashboard: return "house.fill"
    case .analytics: return "chart.bar.fill"
    case .detail: return "eye.fill"
    case .create: return "plus.circle.fill"
    case .wizard: return "list.bullet.clipboard.fill"
    case .datagrid: return "tablecells.fill"
    case .editgrid: return "pencil.and.list.clipboard"
    case .categories: return "folder.fill"
    case .team: return "person.2.fill"
    case .activity: return "clock.fill"
    case .notifications: return "bell.fill"
    case .perfgrid: return "bolt.fill"
    case .perfsignals: return "waveform.path.ecg"
    case .reactivityperf: return "gauge.with.dots.needle.67percent"
    case .themepreview: return "paintpalette.fill"
    case .themepicker: return "paintbrush.fill"
    case .charts: return "chart.pie.fill"
    case .drag: return "hand.draw.fill"
    case .formdemo: return "doc.text.fill"
    case .routing: return "arrow.triangle.branch"
    case .mobiledemo: return "iphone"
    case .featuretest: return "checkmark.seal.fill"
    case .settings: return "gearshape.fill"
    }
  }

  static var sections: [(heading: String, items: [NavDestination])] {
    [
      ("Overview", [.dashboard, .analytics]),
      ("Tasks", [.detail, .create, .wizard]),
      ("Data", [.datagrid, .editgrid, .categories]),
      ("People", [.team]),
      ("Monitoring", [.activity, .notifications]),
      ("Performance", [.perfgrid, .perfsignals, .reactivityperf]),
      ("Design", [.themepreview, .themepicker]),
      ("Components", [.charts, .drag, .formdemo, .routing, .mobiledemo]),
      ("Testing", [.featuretest]),
      ("System", [.settings]),
    ]
  }
}

// MARK: - Content View

struct ContentDestinationView: View {
  let destination: NavDestination
  @State private var showThemeDrawer = false

  var body: some View {
    ScrollView {
      destinationContent
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
    .navigationTitle(destination.title)
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          showThemeDrawer = true
        } label: {
          Image(systemName: "paintpalette")
        }
      }
    }
    .sheet(isPresented: $showThemeDrawer) {
      NavigationStack {
        ScrollView {
          SpecThemePickerView()
            .padding()
        }
        .navigationTitle("Theme")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button("Done") { showThemeDrawer = false }
          }
        }
      }
      .presentationDetents([.medium, .large])
    }
  }

  @ViewBuilder
  private var destinationContent: some View {
    switch destination {
    case .dashboard:
      VStack(spacing: 20) {
        StatsBarView(done: nil, inProgress: nil, todo: nil, total: nil)
        TaskTableView(selectedTask: nil, view: "dashboard" as Any)
      }
    case .analytics: AnalyticsViewView()
    case .detail: TaskDetailView(task: nil, view: "detail" as Any)
    case .create: TaskFormView()
    case .wizard: TaskWizardView()
    case .datagrid: DataGridDemoView()
    case .editgrid: EditableGridDemoView()
    case .categories: TreeDemoView()
    case .team: TeamDirectoryView()
    case .activity: ActivityFeedView()
    case .notifications: NotificationsPanelView()
    case .perfgrid: PerfGridView()
    case .perfsignals: PerfSignalsView()
    case .reactivityperf: ReactivityPerfView()
    case .themepreview: ThemePreviewView()
    case .themepicker: SpecThemePickerView()
    case .charts: ChartDemoView()
    case .drag: DragDemoView()
    case .formdemo: FormDemoView()
    case .routing: RoutingDemoView()
    case .mobiledemo: MobileDemoView()
    case .featuretest: FeatureTestView()
    case .settings: SettingsPanelView()
    }
  }
}

// MARK: - Sidebar

struct SidebarListView: View {
  @Binding var selection: NavDestination?

  var body: some View {
    List(selection: $selection) {
      ForEach(NavDestination.sections, id: \.heading) { section in
        Section(section.heading) {
          ForEach(section.items) { item in
            Label(item.title, systemImage: item.icon).tag(item)
          }
        }
      }
    }
    .navigationTitle("Spec Admin")
  }
}

// MARK: - Tab items

enum TabItem: String, CaseIterable {
  case dashboard, team, activity, notifications, settings, more

  var destination: NavDestination? {
    switch self {
    case .dashboard: return .dashboard
    case .team: return .team
    case .activity: return .activity
    case .notifications: return .notifications
    case .settings: return .settings
    case .more: return nil
    }
  }

  var title: String {
    switch self {
    case .dashboard: return "Dashboard"
    case .team: return "Team"
    case .activity: return "Activity"
    case .notifications: return "Notifications"
    case .settings: return "Settings"
    case .more: return "More"
    }
  }

  var icon: String {
    switch self {
    case .dashboard: return "house.fill"
    case .team: return "person.2.fill"
    case .activity: return "clock.fill"
    case .notifications: return "bell.fill"
    case .settings: return "gearshape.fill"
    case .more: return "ellipsis.circle.fill"
    }
  }
}

// MARK: - More List

struct MoreListView: View {
  @Binding var selectedDestination: NavDestination?
  private let tabDestinations: Set<NavDestination> = [.dashboard, .team, .activity, .notifications, .settings]

  var body: some View {
    List {
      ForEach(NavDestination.sections, id: \.heading) { section in
        let filtered = section.items.filter { !tabDestinations.contains($0) }
        if !filtered.isEmpty {
          Section(section.heading) {
            ForEach(filtered) { item in
              Button {
                selectedDestination = item
              } label: {
                Label(item.title, systemImage: item.icon)
              }
            }
          }
        }
      }
    }
    .navigationTitle("More")
  }
}

// MARK: - Adaptive Root

struct AdaptiveRootView: View {
  @Environment(\.horizontalSizeClass) private var sizeClass
  @State private var sidebarSelection: NavDestination? = .dashboard
  @State private var selectedTab: TabItem = .dashboard
  @State private var moreDestination: NavDestination?

  var body: some View {
    if sizeClass == .regular {
      NavigationSplitView {
        SidebarListView(selection: $sidebarSelection)
      } detail: {
        if let dest = sidebarSelection {
          ContentDestinationView(destination: dest)
        } else {
          ContentUnavailableView("Select a page", systemImage: "sidebar.left", description: Text("Choose from the sidebar"))
        }
      }
    } else {
      TabView(selection: $selectedTab) {
        ForEach(TabItem.allCases, id: \.self) { tab in
          Group {
            if tab == .more {
              NavigationStack {
                MoreListView(selectedDestination: $moreDestination)
                  .navigationDestination(item: $moreDestination) { dest in
                    ContentDestinationView(destination: dest)
                  }
              }
            } else if let dest = tab.destination {
              NavigationStack {
                ContentDestinationView(destination: dest)
              }
            }
          }
          .tabItem {
            Label(tab.title, systemImage: tab.icon)
          }
          .tag(tab)
        }
      }
    }
  }
}

// MARK: - App Entry Point

@main
struct SpectestApp: App {
  init() {
    SpecThemeRegistry.registerAll()
    SpecThemeRegistry.loadSavedTheme()
  }

  var body: some Scene {
    WindowGroup {
      AdaptiveRootView()
    }
  }
}
