import SwiftUI
import SpecRuntime

@Observable
final class CommandPaletteViewModel {
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  var query: Any = ""
  var highlightIndex: Any = 0
  var filtered: Any { (specNeq(query, "") ? specFilter(commands, { (c: Any) -> Bool in return specIncludes((specGet(c, "label") as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }) : commands) }
  var results: Any { ((specDouble(specLength(filtered)) > specDouble(maxResults)) ? specSlice(filtered, 0, maxResults) : filtered) }
  var hasResults: Any { (specDouble(specLength(results)) > specDouble(0)) }
  func setQuery(_ v: Any) {
    query = v
    highlightIndex = 0
  }
  func selectItem(_ id: Any) {
    /* event callback */
    query = ""
    highlightIndex = 0
  }
  func dismiss() {
    /* event callback */
    query = ""
    highlightIndex = 0
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct CommandPaletteView: View {
  @State private var vm = CommandPaletteViewModel()
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  init(commands: Any = [] as [Any], maxResults: Any = 50, open: Any = false, placeholder: Any = "Type a command...") { self._vm = State(initialValue: CommandPaletteViewModel()); self.commands = commands; self.maxResults = maxResults; self.open = open; self.placeholder = placeholder }
  var body: some View {
    VStack() {
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.open) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.dismiss()
                }
              VStack() {
                VStack() {
                  TextField(specString(vm.placeholder), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                }
                .padding(CGFloat(12))
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  VStack() {
                    if (vm.hasResults) as? Bool ?? false {
                      ForEach(Array(specArr(vm.results).enumerated()), id: \.offset) { idx, cmd in
                        Button(action: { vm.selectItem(specGet(cmd, "id")) }) {
                        HStack(alignment: .center, ) {
                          VStack(spacing: CGFloat(4)) {
                            Text(verbatim: specString(specGet(cmd, "label")))
                              .font(.body.bold())
                              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                            VStack() {
                              if specGet(cmd, "description") != nil {
                                Text(verbatim: specString(specGet(cmd, "description")))
                                  .font(.body.bold())
                                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                              }
                            }

                          }

                          VStack() {
                            if specGet(cmd, "shortcut") != nil {
                              Text(verbatim: specString(specGet(cmd, "shortcut")))
                                .font(.body.bold())
                                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                            }
                          }
                          .padding(CGFloat(4))
                          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                        }
                        .padding(CGFloat(12))
                        .background(Color(hex: (specEq(idx, vm.highlightIndex) ? "#ffffff" : "transparent") as? String ?? "transparent"))
                        .background(Color(hex: (specEq(idx, vm.highlightIndex) ? "#ffffff" : "transparent") as? String ?? "transparent"))
                        }
                        .buttonStyle(.plain)
                      }
                    }
                  }

                  HStack(alignment: .center, ) {
                    if (specEq(vm.hasResults, false) && specNeq(vm.query, "")) {
                      Text(verbatim: specString("No matching commands"))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                    }
                  }
                  .padding(CGFloat(16))
                }
                }
                .frame(maxHeight: CGFloat(360))
              }
              .frame(width: CGFloat(560))
              .frame(maxWidth: CGFloat(0))
              .frame(maxHeight: CGFloat(480))
              .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.commands, commands) { vm.commands = commands }; if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
    .task(id: specPropsKey([commands, open, placeholder, maxResults])) { if !specEq(vm.commands, commands) { vm.commands = commands }; if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
  }
}
