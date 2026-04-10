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
  var displayHours: Any { ((specString(format) == specString("12")) ? ((specString(hours) == specString(0)) ? 12 : ((specDouble(hours) > specDouble(12)) ? (specDouble(hours) - specDouble(12)) : hours)) : hours) }
  var formattedH: Any { ((specDouble(displayHours) < specDouble(10)) ? "0\(specString(displayHours))" : "\(specString(displayHours))") }
  var formattedM: Any { ((specDouble(minutes) < specDouble(10)) ? "0\(specString(minutes))" : "\(specString(minutes))") }
  var timeString: Any { ((specString(format) == specString("12")) ? "\(specString(formattedH)):\(specString(formattedM)) \(specString(ampm))" : "\(specString(formattedH)):\(specString(formattedM))") }
  func incHour() {
    hours = ((specString(format) == specString("24")) ? (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(12))))
    /* event callback */
  }
  func decHour() {
    hours = ((specString(format) == specString("24")) ? (specDouble(specAdd(hours, 23)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 11)) .truncatingRemainder(dividingBy: specDouble(12))))
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
    ampm = ((specString(ampm) == specString("AM")) ? "PM" : "AM")
    /* event callback */
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
      VStack(spacing: CGFloat(8)) {
        VStack() {
          if (specString(vm.label) != specString("")) {
            Text(specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: CGFloat(8)) {
          VStack(spacing: CGFloat(4)) {
            Text(specString("Hr"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            HStack(alignment: .center, spacing: CGFloat(4)) {
              VStack() {
                Text(specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .padding(CGFloat(4))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .onTapGesture { if (specString(vm.disabled) == specString(false)) as? Bool ?? false {
  vm.decHour()
} }
              HStack(alignment: .center, ) {
                Text(specString(vm.formattedH))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(8))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              VStack() {
                Text(specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .padding(CGFloat(4))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .onTapGesture { if (specString(vm.disabled) == specString(false)) as? Bool ?? false {
  vm.incHour()
} }
            }

          }

          Text(specString(":"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          VStack(spacing: CGFloat(4)) {
            Text(specString("Min"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            HStack(alignment: .center, spacing: CGFloat(4)) {
              VStack() {
                Text(specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .padding(CGFloat(4))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .onTapGesture { if (specString(vm.disabled) == specString(false)) as? Bool ?? false {
  vm.decMinute()
} }
              HStack(alignment: .center, ) {
                Text(specString(vm.formattedM))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(8))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              VStack() {
                Text(specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
              .padding(CGFloat(4))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
              .onTapGesture { if (specString(vm.disabled) == specString(false)) as? Bool ?? false {
  vm.incMinute()
} }
            }

          }

          VStack(spacing: CGFloat(4)) {
            if (specString(vm.format) == specString("12")) {
              Text(specString(" "))
                .font(.body.bold())
                .foregroundStyle(Color.clear)
            }
            HStack(alignment: .center, ) {
              Text(specString(vm.ampm))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            }
            .padding(CGFloat(8))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
            .frame(minWidth: CGFloat(48))
            .frame(minHeight: CGFloat(36))
            .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { if (specString(vm.disabled) == specString(false)) as? Bool ?? false {
  vm.toggleAmPm()
} }
          }

        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.value = value; vm.format = format; vm.minuteStep = minuteStep; vm.label = label; vm.disabled = disabled }
  }
}
