import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ThemeBuilderView: View {
  @State private var vm = ThemeBuilderViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ThemeBuilderViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      ScrollView(.horizontal, showsIndicators: true) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
        ForEach(Array(specArr([["id": "primary" as Any, "label": "Color" as Any] as [String: Any], ["id": "colors" as Any, "label": "Surfaces" as Any] as [String: Any], ["id": "text" as Any, "label": "Text" as Any] as [String: Any], ["id": "shape" as Any, "label": "Shape" as Any] as [String: Any], ["id": "type" as Any, "label": "Font" as Any] as [String: Any], ["id": "shadow" as Any, "label": "Shadow" as Any] as [String: Any], ["id": "motion" as Any, "label": "Motion" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, sec in
          Button(action: { specClick { vm.setSection(specGet(sec, "id")) } }) {
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString(specGet(sec, "label")))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
              .foregroundStyle((specEq(vm.activeSection, specGet(sec, "id")) ? ThemeManager.shared.color("on-interactive") : ThemeManager.shared.color("text-secondary")))
          }
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .padding(.top, CGFloat(6))
          .padding(.bottom, CGFloat(6))
          .background((specEq(vm.activeSection, specGet(sec, "id")) ? ThemeManager.shared.color("interactive") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
      }
      }
      .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
      ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        if specEq(vm.activeSection, "primary") {
          _specArm0
        }
        if specEq(vm.activeSection, "colors") {
          _specArm1
        }
        if specEq(vm.activeSection, "text") {
          _specArm2
        }
        if specEq(vm.activeSection, "shape") {
          _specArm3
        }
        if specEq(vm.activeSection, "type") {
          _specArm4
        }
        if specEq(vm.activeSection, "shadow") {
          _specArm5
        }
        if specEq(vm.activeSection, "motion") {
          _specArm6
        }
      }
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .frame(maxHeight: .infinity, alignment: .leading)
      .specFlexGrow(1)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Primary / Accent Color"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Generates the full interactive color family — buttons, links, focus rings, badges."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            HStack(alignment: .center, spacing: 0) {
              Spacer(minLength: 0)
              Text(verbatim: specString("Aa"))
                .font(.title)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("on-interactive"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .specFrameHeight(CGFloat(80), alignment: .center)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color(hex: vm.primaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("Color"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              VStack(alignment: .leading, spacing: 0) {
                SpecTextField("", text: Binding(get: { vm.primaryHex as? String ?? "" }, set: { newValue in vm.primaryHex = newValue; vm.applyPrimary() }))
                  .textFieldStyle(.roundedBorder)
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString(vm.primaryHex))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-sm-fontWeight")))
                  .monospacedDigit()
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .padding(.top, CGFloat(4))
              .padding(.bottom, CGFloat(4))
              .background(ThemeManager.shared.color("surface-hover"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            }

            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("Generated from this color"))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-xs-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  VStack(alignment: .leading, spacing: 0) {
                  }
                  .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                  Text(verbatim: specString("Base"))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  VStack(alignment: .leading, spacing: 0) {
                  }
                  .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("interactive-hover"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                  Text(verbatim: specString("Hover"))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  VStack(alignment: .leading, spacing: 0) {
                  }
                  .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("interactive-active"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                  Text(verbatim: specString("Active"))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  VStack(alignment: .leading, spacing: 0) {
                  }
                  .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("focus-ring"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                  Text(verbatim: specString("Ring"))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

                VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  VStack(alignment: .leading, spacing: 0) {
                  }
                  .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .frame(width: CGFloat(28))
                  .specFrameHeight(CGFloat(28))
                  .background(ThemeManager.shared.color("info-bg"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                  .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                  Text(verbatim: specString("Tint"))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

              }

            }

          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Text(verbatim: specString("Surface Colors"))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Background layers, cards, and border colors."))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            Spacer(minLength: 0)
            Button(action: { specClick { Task { @MainActor in await vm.syncSurfaces() } } }) {
              Text(specString("Sync with primary"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
          }
          .frame(maxWidth: .infinity)

          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(verbatim: specString("Tint depth"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            VStack(alignment: .leading, spacing: 0) {
              VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                  Spacer(minLength: 8)
                  Text(verbatim: specString(specDouble(vm.surfaceTint))).font(.subheadline).monospacedDigit()
                }
                .accessibilityHidden(true)
                Slider(value: Binding(get: { specDouble(vm.surfaceTint) }, set: { newValue in let v: Any = newValue; vm.setSurfaceTint(v) }), in: specSliderRange(0, 100), step: specDouble(1))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString(vm.surfaceTint))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-sm-fontWeight")))
                .monospacedDigit()
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
            .frame(width: CGFloat(32), alignment: .leading)
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.bgHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Page Background"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Outermost app background"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.bgHex as? String ?? "" }, set: { newValue in vm.bgHex = newValue; vm.applyBg() }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("border"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.surfaceHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Surface"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Main content area fill"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.surfaceHex as? String ?? "" }, set: { newValue in vm.surfaceHex = newValue; vm.applySurface() }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("border"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.surfaceRaisedHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Card / Panel"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Raised cards, modals, popovers"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.surfaceRaisedHex as? String ?? "" }, set: { newValue in vm.surfaceRaisedHex = newValue; vm.applySurfaceRaised() }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("border"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.borderHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Border"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Lines, dividers, input borders"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.borderHex as? String ?? "" }, set: { newValue in vm.borderHex = newValue; vm.applyBorder() }))
                .textFieldStyle(.roundedBorder)
            }

          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

    })
  }

  private var _specArm2: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Text Colors"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Primary and secondary text — other levels are auto-derived."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.textPrimaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Primary Text"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Headings, body, labels"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.textPrimaryHex as? String ?? "" }, set: { newValue in vm.textPrimaryHex = newValue; vm.applyTextPrimary() }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("border"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 0) {
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .frame(width: CGFloat(32))
              .specFrameHeight(CGFloat(32))
              .background(Color(hex: vm.textSecondaryHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Secondary Text"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString("Captions, hints, metadata"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
              SpecTextField("", text: Binding(get: { vm.textSecondaryHex as? String ?? "" }, set: { newValue in vm.textSecondaryHex = newValue; vm.applyTextSecondary() }))
                .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Text(verbatim: specString("Heading text sample"))
                .font(.title3)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-xs-fontWeight")))
                .foregroundStyle(Color(hex: vm.textPrimaryHex as? String ?? "transparent"))
              Text(verbatim: specString("Secondary or descriptive text appears like this."))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(Color(hex: vm.textSecondaryHex as? String ?? "transparent"))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: vm.bgHex as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

    })
  }

  private var _specArm3: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Border Radius"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Applies to buttons, inputs, cards, badges, and modals."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            ForEach(Array(specArr([["id": "sharp" as Any, "label": "Sharp" as Any, "desc": "0 px" as Any, "r": "0px" as Any] as [String: Any], ["id": "default" as Any, "label": "Default" as Any, "desc": "8 px" as Any, "r": "8px" as Any] as [String: Any], ["id": "rounded" as Any, "label": "Rounded" as Any, "desc": "14 px" as Any, "r": "14px" as Any] as [String: Any], ["id": "pill" as Any, "label": "Pill" as Any, "desc": "∞" as Any, "r": "9999px" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { specClick { vm.setRadius(specGet(p, "id")) } }) {
              VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                VStack(alignment: .leading, spacing: 0) {
                }
                .frame(width: CGFloat(52))
                .specFrameHeight(CGFloat(36))
                .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
                .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: CGFloat(0))
                VStack(alignment: .center, spacing: CGFloat(2)) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

              }
              .padding(specBorderWidth((specEq(vm.radiusPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default"))))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background((specEq(vm.radiusPreset, specGet(p, "id")) ? ThemeManager.shared.color("info-bg") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll((specEq(vm.radiusPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
          }

        }

    })
  }

  private var _specArm4: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Font Family"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Applies to body and heading text across the app."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          ScrollView(.vertical, showsIndicators: true) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            ForEach(Array(specArr([["id": "system" as Any, "label": "System" as Any, "sample": "System UI · native" as Any] as [String: Any], ["id": "inter" as Any, "label": "Inter" as Any, "sample": "Inter · modern sans" as Any] as [String: Any], ["id": "dm-sans" as Any, "label": "DM Sans" as Any, "sample": "DM Sans · clean" as Any] as [String: Any], ["id": "poppins" as Any, "label": "Poppins" as Any, "sample": "Poppins · geometric" as Any] as [String: Any], ["id": "jakarta" as Any, "label": "Plus Jakarta" as Any, "sample": "Jakarta · fresh" as Any] as [String: Any], ["id": "manrope" as Any, "label": "Manrope" as Any, "sample": "Manrope · modern" as Any] as [String: Any], ["id": "lato" as Any, "label": "Lato" as Any, "sample": "Lato · humanist" as Any] as [String: Any], ["id": "open-sans" as Any, "label": "Open Sans" as Any, "sample": "Open Sans · readable" as Any] as [String: Any], ["id": "rubik" as Any, "label": "Rubik" as Any, "sample": "Rubik · rounded" as Any] as [String: Any], ["id": "outfit" as Any, "label": "Outfit" as Any, "sample": "Outfit · geometric" as Any] as [String: Any], ["id": "raleway" as Any, "label": "Raleway" as Any, "sample": "Raleway · elegant" as Any] as [String: Any], ["id": "ibm-plex" as Any, "label": "IBM Plex" as Any, "sample": "IBM Plex · technical" as Any] as [String: Any], ["id": "rounded" as Any, "label": "Nunito" as Any, "sample": "Nunito · friendly" as Any] as [String: Any], ["id": "serif" as Any, "label": "Serif" as Any, "sample": "Georgia · editorial" as Any] as [String: Any], ["id": "mono" as Any, "label": "Mono" as Any, "sample": "Fira Code · code" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, f in
              Button(action: { specClick { vm.setFont(specGet(f, "id")) } }) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                VStack(alignment: .leading, spacing: 0) {
                }
                .frame(width: CGFloat(8))
                .specFrameHeight(CGFloat(8))
                .background((specEq(vm.fontPreset, specGet(f, "id")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("border")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString(specGet(f, "label")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Spacer(minLength: 0)
                  Text(verbatim: specString(specGet(f, "sample")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .specFlexGrow(1)
              }
              .padding(specBorderWidth((specEq(vm.fontPreset, specGet(f, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default"))))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background((specEq(vm.fontPreset, specGet(f, "id")) ? ThemeManager.shared.color("info-bg") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll((specEq(vm.fontPreset, specGet(f, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
          }
          }

        }

    })
  }

  private var _specArm5: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Elevation & Shadow"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Controls depth for cards, modals, and interactive elements."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            ForEach(Array(specArr([["id": "flat" as Any, "label": "Flat" as Any, "desc": "No shadows" as Any] as [String: Any], ["id": "subtle" as Any, "label": "Subtle" as Any, "desc": "Minimal depth" as Any] as [String: Any], ["id": "default" as Any, "label": "Default" as Any, "desc": "Balanced" as Any] as [String: Any], ["id": "bold" as Any, "label": "Bold" as Any, "desc": "Strong depth" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { specClick { vm.setShadow(specGet(p, "id")) } }) {
              VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                VStack(alignment: .leading, spacing: 0) {
                }
                .frame(width: CGFloat(52))
                .specFrameHeight(CGFloat(36))
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBoxShadow(({ () -> Any in switch specString(specGet(p, "id")) {
case specString("flat"): return ThemeManager.shared.rawToken("elevation-flat")
case specString("subtle"): return ThemeManager.shared.rawToken("elevation-raised")
case specString("default"): return ThemeManager.shared.rawToken("elevation-layered")
case specString("bold"): return ThemeManager.shared.rawToken("elevation-floating")
default: return ThemeManager.shared.rawToken("elevation-raised")
} })(), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                VStack(alignment: .center, spacing: CGFloat(2)) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.caption2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }

              }
              .padding(specBorderWidth((specEq(vm.shadowPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default"))))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background((specEq(vm.shadowPreset, specGet(p, "id")) ? ThemeManager.shared.color("info-bg") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll((specEq(vm.shadowPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
          }

        }

    })
  }

  private var _specArm6: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Animation Speed"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Scales all transition durations across interactive elements."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            ForEach(Array(specArr([["id": "instant" as Any, "label": "Instant" as Any, "desc": "No transitions — 0 ms" as Any] as [String: Any], ["id": "fast" as Any, "label": "Fast" as Any, "desc": "Snappy — 75 ms base" as Any] as [String: Any], ["id": "normal" as Any, "label": "Normal" as Any, "desc": "Balanced — 150 ms base" as Any] as [String: Any], ["id": "slow" as Any, "label": "Slow" as Any, "desc": "Relaxed — 300 ms base" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, p in
              Button(action: { specClick { vm.setMotion(specGet(p, "id")) } }) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                VStack(alignment: .leading, spacing: 0) {
                }
                .frame(width: CGFloat(8))
                .specFrameHeight(CGFloat(8))
                .background((specEq(vm.motionPreset, specGet(p, "id")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("border")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString(specGet(p, "label")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Spacer(minLength: 0)
                  Text(verbatim: specString(specGet(p, "desc")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .specFlexGrow(1)
              }
              .padding(specBorderWidth((specEq(vm.motionPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default"))))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background((specEq(vm.motionPreset, specGet(p, "id")) ? ThemeManager.shared.color("info-bg") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll((specEq(vm.motionPreset, specGet(p, "id")) ? ThemeManager.shared.rawToken("borders-accent-interactive") : ThemeManager.shared.rawToken("borders-default")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(verbatim: specString("Live preview — hover and click to feel the speed"))
              .font(.caption2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-xs-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Button(action: {  }) {
                Text(specString("Primary"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Secondary"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Ghost"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
              }
              Button(action: {  }) {
                Text(specString("Danger"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("destructive"), in: RoundedRectangle(cornerRadius: 8))
              }
            }

            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("border"))
            Toggle(specString("Toggle switch"), isOn: Binding(get: { specTruthy(vm.motionToggle) }, set: { newValue in let v: Any = newValue; vm.toggleMotionDemo() }))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

    })
  }
}
