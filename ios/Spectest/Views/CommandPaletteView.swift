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
  var filtered: Any { ((specString(query) != specString("")) ? (commands as? [Any] ?? []).filter { { c in specIncludes(((c as? [String: Any])?["label"] as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }($0) as? Bool ?? false } : commands) }
  var results: Any { (((specLength(filtered) as? Double ?? 0) > (maxResults as? Double ?? 0)) ? specSlice(filtered, 0, maxResults) : filtered) }
  var hasResults: Any { ((specLength(results) as? Double ?? 0) > (0 as? Double ?? 0)) }
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
      HStack(alignment: .center, ) {
        if (specString(vm.open) == specString(true)) {
          VStack() {
            VStack() {
              TextField(specString(vm.placeholder), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
            }
            .padding(CGFloat(12))
            VStack() {
              VStack() {
                if vm.hasResults as? Bool ?? false {
                  LazyVStack(spacing: CGFloat(8)) {
                    ForEach(Array((vm.results as? [Any] ?? []).enumerated()), id: \.offset) { idx, cmd in
                      HStack(alignment: .center, ) {
                        VStack(spacing: CGFloat(4)) {
                          Text(specString((cmd as? [String: Any])?["label"]))
                            .font(.body.bold())
                            .foregroundStyle(.primary)
                          VStack() {
                            if (cmd as? [String: Any])?["description"] != nil {
                              Text(specString((cmd as? [String: Any])?["description"]))
                                .font(.body.bold())
                                .foregroundStyle(.tertiary)
                            }
                          }

                        }

                        VStack() {
                          if (cmd as? [String: Any])?["shortcut"] != nil {
                            Text(specString((cmd as? [String: Any])?["shortcut"]))
                              .font(.body.bold())
                              .foregroundStyle(.secondary)
                          }
                        }
                        .padding(CGFloat(4))
                        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(6)))
                      }
                      .padding(CGFloat(12))
                      .background(Color(hex: ((specString(idx) == specString(vm.highlightIndex)) ? "#ffffff" : "transparent") as? String ?? "#000"))
                      .background(Color(hex: ((specString(idx) == specString(vm.highlightIndex)) ? "#ffffff" : "transparent") as? String ?? "#000"))
                      .onTapGesture { vm.selectItem((cmd as? [String: Any])?["id"]) }
                    }
                  }
                }
              }

              HStack(alignment: .center, ) {
                if ((specString(vm.hasResults) == specString(false)) && (specString(vm.query) != specString(""))) {
                  Text(specString("No matching commands"))
                    .font(.body.bold())
                    .foregroundStyle(.tertiary)
                }
              }
              .padding(CGFloat(16))
            }
            .frame(maxHeight: CGFloat(360))
            .scrollIndicators(.visible)
          }
          .frame(width: CGFloat(560))
          .frame(maxWidth: CGFloat(0))
          .frame(maxHeight: CGFloat(480))
          .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
          .onTapGesture {  }
        }
      }
      .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.5))
      .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.5))
      .onTapGesture { vm.dismiss() }
    }
    .foregroundStyle(.primary)
    .onAppear { vm.commands = commands; vm.open = open; vm.placeholder = placeholder; vm.maxResults = maxResults }
  }
}
