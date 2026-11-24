import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class CommandPaletteViewModel {
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  var query: Any = ""
  var highlightIndex: Any = 0
  var filtered: Any { (specNeq(query, "") ? specFilter(commands, { (c: Any) -> Bool in return specIncludes(specToLowerCase(specGet(c, "label")), specToLowerCase(query)) }) : commands) }
  var results: Any { ((specGt(specLength(filtered), maxResults)) as? Bool ?? false ? specSlice(filtered, 0, maxResults) : filtered) }
  var hasResults: Any { specGt(specLength(results), 0) }
  func setQuery(_ v: Any) {
    query = v
    highlightIndex = 0
  }
  func selectItem(_ id: Any) {
    dispatch("select", [id] as [Any])
    query = ""
    highlightIndex = 0
  }
  func dismiss() {
    dispatch("close")
    query = ""
    highlightIndex = 0
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct CommandPaletteView: View {
  @State private var vm = CommandPaletteViewModel()
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(commands: Any = [] as [Any], maxResults: Any = 50, open: Any = false, placeholder: Any = "Type a command...", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = CommandPaletteViewModel(); _m.commands = commands; _m.maxResults = maxResults; _m.open = open; _m.placeholder = placeholder; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.commands = commands; self.maxResults = maxResults; self.open = open; self.placeholder = placeholder; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(commands) + "\u{1}" + specChangeKey(maxResults) + "\u{1}" + specChangeKey(open) + "\u{1}" + specChangeKey(placeholder) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { (vm.open) as? Bool ?? false }, set: { shown in if !shown { vm.open = false; specSheetDismiss { vm.dismiss() } } })) {
        ScrollView(.vertical, showsIndicators: true) {
          VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
              VStack(alignment: .leading, spacing: 0) {
                SpecTextField(specString(vm.placeholder), text: Binding(get: { vm.query as? String ?? "" }, set: { newValue in vm.query = newValue; let v: Any = newValue; vm.setQuery(v) }))
                  .textFieldStyle(.roundedBorder)
              }
              .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .leading)
              .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
              SpecHugScroll(maxHeight: CGFloat(360)) {
              VStack(alignment: .leading, spacing: 0) {
                if (vm.hasResults) as? Bool ?? false {
                  _specArm0
                }
                if (specEq(vm.hasResults, false) && specNeq(vm.query, "")) {
                HStack(alignment: .center, spacing: 0) {
                  Spacer(minLength: 0)
                  Text(verbatim: specString("No matching commands"))
                    .font(.body)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                }
              }
              }

            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .frame(width: CGFloat(560), alignment: .leading)
            .frame(maxWidth: CGFloat(UIScreen.main.bounds.width * 0.9), alignment: .leading)
            .frame(maxHeight: CGFloat(480), alignment: .top)
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: ThemeManager.shared.radius("lg"))
            .specBoxShadow(ThemeManager.shared.rawToken("elevation-floating"), radius: ThemeManager.shared.radius("lg"))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(ThemeManager.shared.color("background").ignoresSafeArea())
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.commands = commands
      vm.maxResults = maxResults
      vm.open = open
      vm.placeholder = placeholder
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.commands, commands) { vm.commands = commands }; if !specSame(vm.open, open) { vm.open = open }; if !specSame(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specSame(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
    .task(id: specPropsKey([commands, open, placeholder, maxResults])) { if !specSame(vm.commands, commands) { vm.commands = commands }; if !specSame(vm.open, open) { vm.open = open }; if !specSame(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specSame(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
                VStack(alignment: .leading, spacing: 0) {
                  ForEach(Array(specArr(vm.results).enumerated()), id: \.offset) { idx, cmd in
                    Button(action: { specClick { vm.selectItem(specGet(cmd, "id")) } }) {
                    HStack(alignment: .center, spacing: 0) {
                      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                        Text(verbatim: specString(specGet(cmd, "label")))
                          .font(.body)
                          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                          .foregroundStyle(ThemeManager.shared.color("text-primary"))
                        if !specIsNil(specGet(cmd, "description")) {
                        VStack(alignment: .leading, spacing: 0) {
                          Text(verbatim: specString(specGet(cmd, "description")))
                            .font(.caption2)
                            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                        }

                        }
                      }

                      Spacer(minLength: 0)
                      if !specIsNil(specGet(cmd, "shortcut")) {
                      VStack(alignment: .leading, spacing: 0) {
                        Text(verbatim: specString(specGet(cmd, "shortcut")))
                          .font(.caption2)
                          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                      }
                      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                      .padding(specPx(ThemeManager.shared.rawToken("spacing-1")))
                      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                      }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background((specEq(idx, vm.highlightIndex) ? ThemeManager.shared.color("surface-raised") : Color.clear))
                    .hoverEffect(.highlight)
                      .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                  }
                }

    })
  }
}
