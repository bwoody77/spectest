import SwiftUI
import SpecRuntime

@Observable
final class TimePickerViewModel {
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  var hours: Any = 12
  var minutes: Any = 0
  var ampm: Any = "AM"
  var displayHours: Any { (specEq(format, "12") ? (specEq(hours, 0) ? 12 : ((specDouble(hours) > specDouble(12)) ? (specDouble(hours) - specDouble(12)) : hours)) : hours) }
  var formattedH: Any { ((specDouble(displayHours) < specDouble(10)) ? "0\(specString(displayHours))" : "\(specString(displayHours))") }
  var formattedM: Any { ((specDouble(minutes) < specDouble(10)) ? "0\(specString(minutes))" : "\(specString(minutes))") }
  var timeString: Any { (specEq(format, "12") ? "\(specString(formattedH)):\(specString(formattedM)) \(specString(ampm))" : "\(specString(formattedH)):\(specString(formattedM))") }
  func incHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(12))))
    /* event callback */
  }
  func decHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 23)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 11)) .truncatingRemainder(dividingBy: specDouble(12))))
    /* event callback */
  }
  func incMinute() {
    minutes = (specDouble(specAdd(minutes, minuteStep)) .truncatingRemainder(dividingBy: specDouble(60)))
    /* event callback */
  }
  func decMinute() {
    minutes = (specDouble(specAdd((specDouble(minutes) - specDouble(minuteStep)), 60)) .truncatingRemainder(dividingBy: specDouble(60)))
    /* event callback */
  }
  func toggleAmPm() {
    ampm = (specEq(ampm, "AM") ? "PM" : "AM")
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TimePickerView: View {
  @State private var vm = TimePickerViewModel()
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  init(disabled: Any = false, format: Any = "24", label: Any = "", minuteStep: Any = 1, value: Any = "12:00") { self._vm = State(initialValue: TimePickerViewModel()); self.disabled = disabled; self.format = format; self.label = label; self.minuteStep = minuteStep; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString("Hr"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              Button(action: { if specEq(vm.disabled, false) {
  vm.decHour()
} }) {
              VStack() {
                Text(verbatim: specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
              HStack(alignment: .center) {
                Text(verbatim: specString(vm.formattedH))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              Button(action: { if specEq(vm.disabled, false) {
  vm.incHour()
} }) {
              VStack() {
                Text(verbatim: specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
            }

          }

          Text(verbatim: specString(":"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString("Min"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              Button(action: { if specEq(vm.disabled, false) {
  vm.decMinute()
} }) {
              VStack() {
                Text(verbatim: specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
              HStack(alignment: .center) {
                Text(verbatim: specString(vm.formattedM))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              Button(action: { if specEq(vm.disabled, false) {
  vm.incMinute()
} }) {
              VStack() {
                Text(verbatim: specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
            }

          }

          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            if specEq(vm.format, "12") {
              Text(verbatim: specString(" "))
                .font(.body.bold())
                .foregroundStyle(Color.clear)
            }
            Button(action: { if specEq(vm.disabled, false) {
  vm.toggleAmPm()
} }) {
            HStack(alignment: .center) {
              Text(verbatim: specString(vm.ampm))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
            .frame(minWidth: CGFloat(48))
            .frame(minHeight: CGFloat(36))
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }

        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.format, format) { vm.format = format }; if !specEq(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([value, format, minuteStep, label, disabled])) { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.format, format) { vm.format = format }; if !specEq(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
