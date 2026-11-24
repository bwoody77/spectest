import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TimePickerViewModel {
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  var hours: Any = 12
  var minutes: Any = 0
  var ampm: Any = "AM"
  var displayHours: Any { (specEq(format, "12") ? (specEq(hours, 0) ? 12 : ((specGt(hours, 12)) as? Bool ?? false ? (specDouble(hours) - specDouble(12)) : hours)) : hours) }
  var formattedH: Any { ((specLt(displayHours, 10)) as? Bool ?? false ? "0\(specString(displayHours))" : "\(specString(displayHours))") }
  var formattedM: Any { ((specLt(minutes, 10)) as? Bool ?? false ? "0\(specString(minutes))" : "\(specString(minutes))") }
  var timeString: Any { (specEq(format, "12") ? "\(specString(formattedH)):\(specString(formattedM)) \(specString(ampm))" : "\(specString(formattedH)):\(specString(formattedM))") }
  func incHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(12))))
    dispatch("change", [timeString] as [Any])
  }
  func decHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 23)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 11)) .truncatingRemainder(dividingBy: specDouble(12))))
    dispatch("change", [timeString] as [Any])
  }
  func incMinute() {
    minutes = (specDouble(specAdd(minutes, minuteStep)) .truncatingRemainder(dividingBy: specDouble(60)))
    dispatch("change", [timeString] as [Any])
  }
  func decMinute() {
    minutes = (specDouble(specAdd((specDouble(minutes) - specDouble(minuteStep)), 60)) .truncatingRemainder(dividingBy: specDouble(60)))
    dispatch("change", [timeString] as [Any])
  }
  func toggleAmPm() {
    ampm = (specEq(ampm, "AM") ? "PM" : "AM")
    dispatch("change", [timeString] as [Any])
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TimePickerView: View {
  @State private var vm = TimePickerViewModel()
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(disabled: Any = false, format: Any = "24", label: Any = "", minuteStep: Any = 1, value: Any = "12:00", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TimePickerViewModel(); _m.disabled = disabled; _m.format = format; _m.label = label; _m.minuteStep = minuteStep; _m.value = value; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.disabled = disabled; self.format = format; self.label = label; self.minuteStep = minuteStep; self.value = value; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(disabled) + "\u{1}" + specChangeKey(format) + "\u{1}" + specChangeKey(label) + "\u{1}" + specChangeKey(minuteStep) + "\u{1}" + specChangeKey(value) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        if specNeq(vm.label, "") {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString(vm.label))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-strong-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }

        }
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Hr"))
              .font(.caption2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Button(action: { specClick { if specEq(vm.disabled, false) {
  vm.decHour()
} } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("▼"))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-1")))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              HStack(alignment: .center, spacing: 0) {
                Text(verbatim: specString(vm.formattedH))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
              .frame(minWidth: CGFloat(40), alignment: .center)
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              Button(action: { specClick { if specEq(vm.disabled, false) {
  vm.incHour()
} } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("▲"))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-1")))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }

          }

          Text(verbatim: specString(":"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("Min"))
              .font(.caption2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Button(action: { specClick { if specEq(vm.disabled, false) {
  vm.decMinute()
} } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("▼"))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-1")))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              HStack(alignment: .center, spacing: 0) {
                Text(verbatim: specString(vm.formattedM))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
              .frame(minWidth: CGFloat(40), alignment: .center)
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              Button(action: { specClick { if specEq(vm.disabled, false) {
  vm.incMinute()
} } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("▲"))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-1")))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }

          }

          if specEq(vm.format, "12") {
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString(" "))
              .font(.caption2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
              .foregroundStyle(Color.clear)
            Button(action: { specClick { if specEq(vm.disabled, false) {
  vm.toggleAmPm()
} } }) {
            HStack(alignment: .center, spacing: 0) {
              Spacer(minLength: 0)
              Text(verbatim: ({ () -> String in
          let _h0: String = specString(vm.ampm)
          let _h1: String = specString("AM")
          if _h0 == _h1 { return specString("AM") }
          return specString("PM")
        })())
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .frame(minWidth: CGFloat(48), alignment: .center)
            .frame(minHeight: CGFloat(36), alignment: .center)
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
            .hoverEffect(.highlight)
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
          }

          }
        }

      }
      .accessibilityElement(children: .contain)
      .accessibilityLabel(specString("Time picker"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.disabled = disabled
      vm.format = format
      vm.label = label
      vm.minuteStep = minuteStep
      vm.value = value
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.value, value) { vm.value = value }; if !specSame(vm.format, format) { vm.format = format }; if !specSame(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specSame(vm.label, label) { vm.label = label }; if !specSame(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([value, format, minuteStep, label, disabled])) { if !specSame(vm.value, value) { vm.value = value }; if !specSame(vm.format, format) { vm.format = format }; if !specSame(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specSame(vm.label, label) { vm.label = label }; if !specSame(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
