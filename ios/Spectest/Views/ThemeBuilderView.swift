import SwiftUI
import SpecRuntime

@Observable
final class ThemeBuilderViewModel {
  var primaryHex: Any = "#1677ff"
  var bgHex: Any = "#ffffff"
  var surfaceHex: Any = "#f7f7f8"
  var surfaceRaisedHex: Any = "#ffffff"
  var borderHex: Any = "#dce0e5"
  var textPrimaryHex: Any = "#202732"
  var textSecondaryHex: Any = "#496183"
  var radiusPreset: Any = "default"
  var fontPreset: Any = "system"
  var motionPreset: Any = "normal"
  var shadowPreset: Any = "default"
  var activeSection: Any = "primary"
  var motionToggle: Any = false
  var surfaceTint: Any = 10
  func applyPrimary() {
    applyPrimaryColor(primaryHex)
  }
  func applyBg() {
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
  }
  func applySurface() {
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
  }
  func applySurfaceRaised() {
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
  }
  func applyBorder() {
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
  }
  func applyTextPrimary() {
    applyTextColors(textPrimaryHex, textSecondaryHex)
  }
  func applyTextSecondary() {
    applyTextColors(textPrimaryHex, textSecondaryHex)
  }
  func setRadius(_ p: Any) {
    radiusPreset = p
    applyRadiusPreset(p)
  }
  func setFont(_ p: Any) {
    fontPreset = p
    applyFontFamily(p)
  }
  func setMotion(_ p: Any) {
    motionPreset = p
    applyMotionPreset(p)
  }
  func setShadow(_ p: Any) {
    shadowPreset = p
    applyElevationPreset(p)
  }
  func syncSurfaces() {
    bgHex = getSurfaceTint(primaryHex, 10, "bg")
    surfaceHex = getSurfaceTint(primaryHex, 10, "surface")
    surfaceRaisedHex = getSurfaceTint(primaryHex, 10, "surfaceRaised")
    borderHex = getSurfaceTint(primaryHex, 10, "border")
    textPrimaryHex = getTextSuggestion(bgHex, "primary")
    textSecondaryHex = getTextSuggestion(bgHex, "secondary")
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
    applyTextColors(textPrimaryHex, textSecondaryHex)
    surfaceTint = 10
  }
  func setSurfaceTint(_ v: Any) {
    surfaceTint = v
    bgHex = getSurfaceTint(primaryHex, v, "bg")
    surfaceHex = getSurfaceTint(primaryHex, v, "surface")
    surfaceRaisedHex = getSurfaceTint(primaryHex, v, "surfaceRaised")
    borderHex = getSurfaceTint(primaryHex, v, "border")
    applySurfaceColors(bgHex, surfaceHex, surfaceRaisedHex, borderHex)
  }
  func toggleMotionDemo() {
    motionToggle = (!((motionToggle) as? Bool ?? false))
  }
  func setSection(_ s: Any) {
    activeSection = s
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ThemeBuilderView: View {
  @State private var vm = ThemeBuilderViewModel()
  var body: some View {
    VStack() {
      ScrollView(.horizontal, showsIndicators: true) {
      HStack(alignment: .center, spacing: CGFloat(4)) {
        ForEach(Array(specArr([["id": "primary" as Any, "label": "Color" as Any] as [String: Any], ["id": "colors" as Any, "label": "Surfaces" as Any] as [String: Any], ["id": "text" as Any, "label": "Text" as Any] as [String: Any], ["id": "shape" as Any, "label": "Shape" as Any] as [String: Any], ["id": "type" as Any, "label": "Font" as Any] as [String: Any], ["id": "shadow" as Any, "label": "Shadow" as Any] as [String: Any], ["id": "motion" as Any, "label": "Motion" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, sec in
          Button(action: { vm.setSection(specGet(sec, "id")) }) {
          VStack() {
            Text(verbatim: specString(specGet(sec, "label")))
              .font(.body.bold())
              .foregroundStyle(Color(hex: (specEq(vm.activeSection, specGet(sec, "id")) ? "#ffffff" : "#496183") as? String ?? "transparent"))
          }
          .padding(.leading, CGFloat(12))
          .padding(.trailing, CGFloat(12))
          .padding(.top, CGFloat(6))
          .padding(.bottom, CGFloat(6))
          .background(Color(hex: (specEq(vm.activeSection, specGet(sec, "id")) ? "#1677ff" : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
          }
          .buttonStyle(.plain)
        }
      }
      }
      .padding(CGFloat(12))
      ScrollView(.horizontal, showsIndicators: true) {
      VStack(spacing: CGFloat(20)) {
        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "primary") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Primary / Accent Color"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Generates the full interactive color family — buttons, links, focus rings, badges."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          VStack(spacing: CGFloat(12)) {
            HStack(alignment: .center, ) {
              Text(verbatim: specString("Aa"))
                .font(.title3.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.background"))
            }
            .specFrameHeight(CGFloat(80))
            .background(Color(hex: vm.primaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            HStack(alignment: .center, spacing: CGFloat(8)) {
              Text(verbatim: specString("Color"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              VStack() {
                TextField("", text: Binding(get: { vm.primaryHex as? String ?? "" }, set: { vm.primaryHex = $0 }))
                  .textFieldStyle(.roundedBorder)
              }
              .frame(maxWidth: .infinity)
              VStack() {
                Text(verbatim: specString(vm.primaryHex))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .padding(.leading, CGFloat(8))
              .padding(.trailing, CGFloat(8))
              .padding(.top, CGFloat(4))
              .padding(.bottom, CGFloat(4))
              .background(ThemeManager.shared.color("semantic.surface-hover"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
            }

            VStack(spacing: CGFloat(8)) {
              Text(verbatim: specString("Generated from this color"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              HStack(alignment: .center, spacing: CGFloat(8)) {
                VStack(spacing: CGFloat(4)) {
                  VStack() {
                  }
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  Text(verbatim: specString("Base"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

                VStack(spacing: CGFloat(4)) {
                  VStack() {
                  }
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("semantic.interactive-hover"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  Text(verbatim: specString("Hover"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

                VStack(spacing: CGFloat(4)) {
                  VStack() {
                  }
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("semantic.interactive-active"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  Text(verbatim: specString("Active"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

                VStack(spacing: CGFloat(4)) {
                  VStack() {
                  }
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("semantic.focus-ring"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  Text(verbatim: specString("Ring"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

                VStack(spacing: CGFloat(4)) {
                  VStack() {
                  }
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("semantic.info-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  Text(verbatim: specString("Tint"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

              }

            }

          }
          .padding(CGFloat(16))
          .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "colors") {
            HStack(alignment: .center, ) {
              VStack(spacing: CGFloat(4)) {
                Text(verbatim: specString("Surface Colors"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Background layers, cards, and border colors."))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }

              Spacer(minLength: 0)
              Button(action: { Task { @MainActor in await vm.syncSurfaces() } }) {
                Text(specString("Sync with primary"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .frame(maxWidth: .infinity)

          }
          HStack(alignment: .center, spacing: CGFloat(12)) {
            Text(verbatim: specString("Tint depth"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            VStack() {
              Slider(value: Binding(get: { vm.surfaceTint as? Double ?? 0 }, set: { vm.surfaceTint = $0 }), in: (0 as? Double ?? 0)...(100 as? Double ?? 100), step: 1 as? Double ?? 1)
            }
            .frame(maxWidth: .infinity)
            VStack() {
              Text(verbatim: specString(vm.surfaceTint))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
            .frame(width: CGFloat(32))
          }

          VStack(spacing: CGFloat(12)) {
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.bgHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Page Background"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Outermost app background"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.bgHex as? String ?? "" }, set: { vm.bgHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

            VStack() {
            }
            .background(ThemeManager.shared.color("semantic.border"))
            .specFrameHeight(CGFloat(1))
            .background(ThemeManager.shared.color("semantic.border"))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.surfaceHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Surface"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Main content area fill"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.surfaceHex as? String ?? "" }, set: { vm.surfaceHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

            VStack() {
            }
            .background(ThemeManager.shared.color("semantic.border"))
            .specFrameHeight(CGFloat(1))
            .background(ThemeManager.shared.color("semantic.border"))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.surfaceRaisedHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Card / Panel"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Raised cards, modals, popovers"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.surfaceRaisedHex as? String ?? "" }, set: { vm.surfaceRaisedHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

            VStack() {
            }
            .background(ThemeManager.shared.color("semantic.border"))
            .specFrameHeight(CGFloat(1))
            .background(ThemeManager.shared.color("semantic.border"))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.borderHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Border"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Lines, dividers, input borders"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.borderHex as? String ?? "" }, set: { vm.borderHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "text") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Text Colors"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Primary and secondary text — other levels are auto-derived."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          VStack(spacing: CGFloat(12)) {
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.textPrimaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Primary Text"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Headings, body, labels"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.textPrimaryHex as? String ?? "" }, set: { vm.textPrimaryHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

            VStack() {
            }
            .background(ThemeManager.shared.color("semantic.border"))
            .specFrameHeight(CGFloat(1))
            .background(ThemeManager.shared.color("semantic.border"))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
              }
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.textSecondaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              VStack() {
                Text(verbatim: specString("Secondary Text"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString("Captions, hints, metadata"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .frame(maxWidth: .infinity)
              TextField("", text: Binding(get: { vm.textSecondaryHex as? String ?? "" }, set: { vm.textSecondaryHex = $0 }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Heading text sample"))
                .font(.body.bold())
                .foregroundStyle(Color(hex: vm.textPrimaryHex as? String ?? "transparent"))
              Text(verbatim: specString("Secondary or descriptive text appears like this."))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: vm.textSecondaryHex as? String ?? "transparent"))
            }
            .padding(CGFloat(12))
            .background(Color(hex: vm.bgHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "shape") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Border Radius"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Applies to buttons, inputs, cards, badges, and modals."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: CGFloat(12)) {
            ForEach(Array(specArr([["id": "sharp" as Any, "label": "Sharp" as Any, "desc": "0 px" as Any, "r": "0px" as Any] as [String: Any], ["id": "default" as Any, "label": "Default" as Any, "desc": "8 px" as Any, "r": "8px" as Any] as [String: Any], ["id": "rounded" as Any, "label": "Rounded" as Any, "desc": "14 px" as Any, "r": "14px" as Any] as [String: Any], ["id": "pill" as Any, "label": "Pill" as Any, "desc": "∞" as Any, "r": "9999px" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { vm.setRadius(specGet(p, "id")) }) {
              VStack(spacing: CGFloat(8)) {
                VStack() {
                }
                .frame(width: CGFloat(52))
                .specFrameHeight(CGFloat(36))
                .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
                VStack(spacing: CGFloat(2)) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

              }
              .padding(CGFloat(12))
              .background(Color(hex: (specEq(vm.radiusPreset, specGet(p, "id")) ? "#e6f4ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              }
              .buttonStyle(.plain)
            }
          }

        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "type") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Font Family"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Applies to body and heading text across the app."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          ScrollView(.horizontal, showsIndicators: true) {
          VStack(spacing: CGFloat(8)) {
            ForEach(Array(specArr([["id": "system" as Any, "label": "System" as Any, "sample": "System UI · native" as Any] as [String: Any], ["id": "inter" as Any, "label": "Inter" as Any, "sample": "Inter · modern sans" as Any] as [String: Any], ["id": "dm-sans" as Any, "label": "DM Sans" as Any, "sample": "DM Sans · clean" as Any] as [String: Any], ["id": "poppins" as Any, "label": "Poppins" as Any, "sample": "Poppins · geometric" as Any] as [String: Any], ["id": "jakarta" as Any, "label": "Plus Jakarta" as Any, "sample": "Jakarta · fresh" as Any] as [String: Any], ["id": "manrope" as Any, "label": "Manrope" as Any, "sample": "Manrope · modern" as Any] as [String: Any], ["id": "lato" as Any, "label": "Lato" as Any, "sample": "Lato · humanist" as Any] as [String: Any], ["id": "open-sans" as Any, "label": "Open Sans" as Any, "sample": "Open Sans · readable" as Any] as [String: Any], ["id": "rubik" as Any, "label": "Rubik" as Any, "sample": "Rubik · rounded" as Any] as [String: Any], ["id": "outfit" as Any, "label": "Outfit" as Any, "sample": "Outfit · geometric" as Any] as [String: Any], ["id": "raleway" as Any, "label": "Raleway" as Any, "sample": "Raleway · elegant" as Any] as [String: Any], ["id": "ibm-plex" as Any, "label": "IBM Plex" as Any, "sample": "IBM Plex · technical" as Any] as [String: Any], ["id": "rounded" as Any, "label": "Nunito" as Any, "sample": "Nunito · friendly" as Any] as [String: Any], ["id": "serif" as Any, "label": "Serif" as Any, "sample": "Georgia · editorial" as Any] as [String: Any], ["id": "mono" as Any, "label": "Mono" as Any, "sample": "Fira Code · code" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, f in
              Button(action: { vm.setFont(specGet(f, "id")) }) {
              HStack(alignment: .center, spacing: CGFloat(12)) {
                VStack() {
                }
                .frame(width: CGFloat(8))
                .specFrameHeight(CGFloat(8))
                .background(Color(hex: (specEq(vm.fontPreset, specGet(f, "id")) ? "#1677ff" : "#dce0e5") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                HStack(alignment: .center, ) {
                  Text(verbatim: specString(specGet(f, "label")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(verbatim: specString(specGet(f, "sample")))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                }
                .frame(maxWidth: .infinity)
              }
              .padding(CGFloat(12))
              .background(Color(hex: (specEq(vm.fontPreset, specGet(f, "id")) ? "#e6f4ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              }
              .buttonStyle(.plain)
            }
          }
          }

        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "shadow") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Elevation & Shadow"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Controls depth for cards, modals, and interactive elements."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: CGFloat(12)) {
            ForEach(Array(specArr([["id": "flat" as Any, "label": "Flat" as Any, "desc": "No shadows" as Any] as [String: Any], ["id": "subtle" as Any, "label": "Subtle" as Any, "desc": "Minimal depth" as Any] as [String: Any], ["id": "default" as Any, "label": "Default" as Any, "desc": "Balanced" as Any] as [String: Any], ["id": "bold" as Any, "label": "Bold" as Any, "desc": "Strong depth" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { vm.setShadow(specGet(p, "id")) }) {
              VStack(spacing: CGFloat(8)) {
                VStack() {
                }
                .frame(width: CGFloat(52))
                .specFrameHeight(CGFloat(36))
                .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                VStack(spacing: CGFloat(2)) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }

              }
              .padding(CGFloat(12))
              .background(Color(hex: (specEq(vm.shadowPreset, specGet(p, "id")) ? "#e6f4ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              }
              .buttonStyle(.plain)
            }
          }

        }

        VStack(spacing: CGFloat(16)) {
          if specEq(vm.activeSection, "motion") {
            VStack(spacing: CGFloat(4)) {
              Text(verbatim: specString("Animation Speed"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              Text(verbatim: specString("Scales all transition durations across interactive elements."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }

          }
          VStack(spacing: CGFloat(8)) {
            ForEach(Array(specArr([["id": "instant" as Any, "label": "Instant" as Any, "desc": "No transitions — 0 ms" as Any] as [String: Any], ["id": "fast" as Any, "label": "Fast" as Any, "desc": "Snappy — 75 ms base" as Any] as [String: Any], ["id": "normal" as Any, "label": "Normal" as Any, "desc": "Balanced — 150 ms base" as Any] as [String: Any], ["id": "slow" as Any, "label": "Slow" as Any, "desc": "Relaxed — 300 ms base" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { vm.setMotion(specGet(p, "id")) }) {
              HStack(alignment: .center, spacing: CGFloat(12)) {
                VStack() {
                }
                .frame(width: CGFloat(8))
                .specFrameHeight(CGFloat(8))
                .background(Color(hex: (specEq(vm.motionPreset, specGet(p, "id")) ? "#1677ff" : "#dce0e5") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                HStack(alignment: .center, ) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                }
                .frame(maxWidth: .infinity)
              }
              .padding(CGFloat(12))
              .background(Color(hex: (specEq(vm.motionPreset, specGet(p, "id")) ? "#e6f4ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              }
              .buttonStyle(.plain)
            }
          }

          VStack(spacing: CGFloat(12)) {
            Text(verbatim: specString("Live preview — hover and click to feel the speed"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            HStack(alignment: .center, spacing: CGFloat(8)) {
              Button(action: {  }) {
                Text(specString("Primary"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Secondary"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Ghost"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
              }
              Button(action: {  }) {
                Text(specString("Danger"))
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
              }
            }

            VStack() {
            }
            .background(ThemeManager.shared.color("semantic.border"))
            .specFrameHeight(CGFloat(1))
            .background(ThemeManager.shared.color("semantic.border"))
            Toggle(specString("Toggle switch"), isOn: Binding(get: { vm.motionToggle as? Bool ?? false }, set: { vm.motionToggle = $0 }))
          }
          .padding(CGFloat(16))
          .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }

      }
      }
      .padding(CGFloat(16))
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
