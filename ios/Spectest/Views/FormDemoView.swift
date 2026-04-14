import SwiftUI
import SpecRuntime

@Observable
final class FormDemoViewModel {
  var firstName: Any = ""
  var lastName: Any = ""
  var email: Any = ""
  var message: Any = ""
  var submitted: Any = false
  var submittedData: Any? = nil
  var username: Any = ""
  var password: Any = ""
  var confirmPassword: Any = ""
  var age: Any = ""
  var regSubmitted: Any = false
  var activeForm: Any = "contact"
  var _fld_firstName_touched: Any = false
  var _fld_lastName_touched: Any = false
  var _fld_email_touched: Any = false
  var _fld_message_touched: Any = false
  var _form_submit_attempted: Any = false
  var isContactForm: Any { specEq(activeForm, "contact") }
  var isHowForm: Any { specEq(activeForm, "how") }
  var _fld_firstName_error: Any {
    if ((((!((_fld_firstName_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((((!((firstName) as? Bool ?? false))) as? Bool ?? false || specEq((specString(firstName) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) != nil ? ((((!((firstName) as? Bool ?? false))) as? Bool ?? false || specEq((specString(firstName) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) : (((firstName) as? Bool ?? false && (specDouble(specLength(specString(firstName))) < specDouble(2))) ? "Must be at least 2 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((firstName) as? Bool ?? false && (specDouble(specLength(specString(firstName))) > specDouble(50)))) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_lastName_error: Any {
    if ((((!((_fld_lastName_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((((!((lastName) as? Bool ?? false))) as? Bool ?? false || specEq((specString(lastName) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) != nil ? ((((!((lastName) as? Bool ?? false))) as? Bool ?? false || specEq((specString(lastName) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) : (((lastName) as? Bool ?? false && (specDouble(specLength(specString(lastName))) < specDouble(2))) ? "Must be at least 2 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((lastName) as? Bool ?? false && (specDouble(specLength(specString(lastName))) > specDouble(50)))) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_email_error: Any {
    if ((((!((_fld_email_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return ((((!((email) as? Bool ?? false))) as? Bool ?? false || specEq((specString(email) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil)
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((email) as? Bool ?? false && ((!(specRegexTest(specRegex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"), specString(email))))) as? Bool ?? false)) ? "Invalid email address" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_message_error: Any {
    if ((((!((_fld_message_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((((!((message) as? Bool ?? false))) as? Bool ?? false || specEq((specString(message) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) != nil ? ((((!((message) as? Bool ?? false))) as? Bool ?? false || specEq((specString(message) as? String ?? "").trimmingCharacters(in: .whitespaces), "")) ? "Required" : nil) : (((message) as? Bool ?? false && (specDouble(specLength(specString(message))) < specDouble(10))) ? "Must be at least 10 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((message) as? Bool ?? false && (specDouble(specLength(specString(message))) > specDouble(500)))) ? "Must be 500 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _form_valid: Any { (((_fld_firstName_error == nil && _fld_lastName_error == nil) && _fld_email_error == nil) && _fld_message_error == nil) }
  var _form_dirty: Any { (((specNeq(firstName, "") || specNeq(lastName, "")) || specNeq(email, "")) || specNeq(message, "")) }
  func _touchField(_ name: Any) {
    if specEq(name, "firstName") {
      _fld_firstName_touched = true
    }
    if specEq(name, "lastName") {
      _fld_lastName_touched = true
    }
    if specEq(name, "email") {
      _fld_email_touched = true
    }
    if specEq(name, "message") {
      _fld_message_touched = true
    }
  }
  func _submitForm() {
    _form_submit_attempted = true
    _fld_firstName_touched = true
    _fld_lastName_touched = true
    _fld_email_touched = true
    _fld_message_touched = true
  }
  func _resetForm() {
    _form_submit_attempted = false
    _fld_firstName_touched = false
    _fld_lastName_touched = false
    _fld_email_touched = false
    _fld_message_touched = false
  }
  func _formData() -> Any {
    return ["firstName": firstName as Any, "lastName": lastName as Any, "email": email as Any, "message": message as Any] as [String: Any]
  }
  func setFirstName(_ v: Any) {
    firstName = v
  }
  func setLastName(_ v: Any) {
    lastName = v
  }
  func setEmail(_ v: Any) {
    email = v
  }
  func setMessage(_ v: Any) {
    message = v
  }
  func setActiveForm(_ f: Any) {
    activeForm = f
  }
  func submitContact() {
    _submitForm()
    if (_form_valid) as? Bool ?? false {
      submittedData = _formData()
      submitted = true
      _resetForm()
    }
  }
  func resetContact() {
    firstName = ""
    lastName = ""
    email = ""
    message = ""
    submitted = false
    submittedData = nil
    _resetForm()
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct FormDemoView: View {
  @State private var vm = FormDemoViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(verbatim: specString("Form Validation (@form block)"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(verbatim: specString("The @form block adds field-level validation, touched tracking, and dirty state with zero boilerplate."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      HStack(alignment: .center, spacing: CGFloat(8)) {
        Button(action: { vm.setActiveForm("contact") }) {
        VStack() {
          Text(verbatim: specString("Contact Form"))
            .foregroundStyle(Color(hex: ((vm.isContactForm) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "transparent"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isContactForm) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setActiveForm("how") }) {
        VStack() {
          Text(verbatim: specString("How It Works"))
            .foregroundStyle(Color(hex: ((vm.isHowForm) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "transparent"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isHowForm) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
      }

      HStack(alignment: .center, spacing: CGFloat(20)) {
        if (vm.isContactForm) as? Bool ?? false {
          VStack() {
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(20)) {
                HStack(alignment: .center, ) {
                  Text(verbatim: specString("Contact Us"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  VStack() {
                    if (vm._form_dirty) as? Bool ?? false {
                      Text(verbatim: specString("Unsaved changes"))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#92400e"))
                    }
                  }
                  .padding(CGFloat(0))
                  .background(Color(hex: "#fef9c3"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                }

                HStack(alignment: .center, spacing: CGFloat(16)) {
                  VStack(spacing: CGFloat(4)) {
                    Text(verbatim: specString("First Name"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    TextField(specString("Jane"), text: Binding(get: { vm.firstName as? String ?? "" }, set: { vm.firstName = $0 }))
                    VStack() {
                      if ((vm._fld_firstName_touched) as? Bool ?? false && vm._fld_firstName_error != nil) {
                        Text(verbatim: specString(vm._fld_firstName_error))
                          .font(.callout.bold())
                          .foregroundStyle(Color(hex: "#dc2626"))
                      }
                    }

                  }
                  .frame(maxWidth: .infinity)
                  VStack(spacing: CGFloat(4)) {
                    Text(verbatim: specString("Last Name"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    TextField(specString("Doe"), text: Binding(get: { vm.lastName as? String ?? "" }, set: { vm.lastName = $0 }))
                    VStack() {
                      if ((vm._fld_lastName_touched) as? Bool ?? false && vm._fld_lastName_error != nil) {
                        Text(verbatim: specString(vm._fld_lastName_error))
                          .font(.callout.bold())
                          .foregroundStyle(Color(hex: "#dc2626"))
                      }
                    }

                  }
                  .frame(maxWidth: .infinity)
                }

                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Email"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  TextField(specString("jane@example.com"), text: Binding(get: { vm.email as? String ?? "" }, set: { vm.email = $0 }))
                  VStack() {
                    if ((vm._fld_email_touched) as? Bool ?? false && vm._fld_email_error != nil) {
                      Text(verbatim: specString(vm._fld_email_error))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#dc2626"))
                    }
                  }

                }

                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Message"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  TextField(specString("Tell us how we can help..."), text: Binding(get: { vm.message as? String ?? "" }, set: { vm.message = $0 }))
                  VStack() {
                    if ((vm._fld_message_touched) as? Bool ?? false && vm._fld_message_error != nil) {
                      Text(verbatim: specString(vm._fld_message_error))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#dc2626"))
                    }
                  }

                }

                HStack(alignment: .center, spacing: CGFloat(12)) {
                  if ((vm._form_submit_attempted) as? Bool ?? false && ((!((vm._form_valid) as? Bool ?? false))) as? Bool ?? false) {
                    Text(verbatim: specString("Please fix the errors above before submitting."))
                      .font(.callout.bold())
                      .foregroundStyle(Color(hex: "#dc2626"))
                  }
                }
                .padding(CGFloat(16))
                .background(Color(hex: "#fef2f2"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                VStack(spacing: CGFloat(8)) {
                  if (vm.submitted) as? Bool ?? false {
                    Text(verbatim: specString("Message sent successfully!"))
                      .font(.headline.bold())
                      .foregroundStyle(Color(hex: "#166534"))
                  }
                  Text(verbatim: specString("We received your form data and will be in touch soon."))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#166534"))
                }
                .padding(CGFloat(16))
                .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                HStack(alignment: .center, spacing: CGFloat(12)) {
                  Button(action: { vm.resetContact() }) {
                  VStack() {
                    Text(verbatim: specString("Reset"))
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  }
                  .padding(CGFloat(0))
                  .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                  }
                  .buttonStyle(.plain)
                  Button(action: { vm.submitContact() }) {
                  VStack() {
                    Text(verbatim: specString("Send Message"))
                      .foregroundStyle(Color(hex: "#fff"))
                  }
                  .padding(CGFloat(0))
                  .opacity(specPx(((vm._form_valid) as? Bool ?? false ? 1 : 0.6)))
                  .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                  }
                  .buttonStyle(.plain)
                }

              }
              .padding(CGFloat(24))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }
          .frame(maxWidth: .infinity)
        }
        VStack() {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(12)) {
              Text(verbatim: specString("Form State"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, ) {
                  Text(verbatim: specString("Valid"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: ({ () -> String in
          if (vm._form_valid) as? Bool ?? false { return specString("✓ Yes") }
          return specString("✗ No")
        })())
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: ((vm._form_valid) as? Bool ?? false ? "#166534" : "#dc2626") as? String ?? "transparent"))
                }

                HStack(alignment: .center, ) {
                  Text(verbatim: specString("Dirty"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: ({ () -> String in
          if (vm._form_dirty) as? Bool ?? false { return specString("Yes") }
          return specString("No")
        })())
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }

                HStack(alignment: .center, ) {
                  Text(verbatim: specString("Submit attempted"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: ({ () -> String in
          if (vm._form_submit_attempted) as? Bool ?? false { return specString("Yes") }
          return specString("No")
        })())
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }

              }

              VStack(spacing: CGFloat(4)) {
                Text(verbatim: specString("Field errors:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(verbatim: specString("firstName: \(specString((vm._fld_firstName_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(verbatim: specString("lastName: \(specString((vm._fld_lastName_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(verbatim: specString("email: \(specString((vm._fld_email_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(verbatim: specString("message: \(specString((vm._fld_message_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }

            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(width: CGFloat(240))
      }

      VStack() {
        if (vm.isHowForm) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(20)) {
              Text(verbatim: specString("How @form works"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                Text(verbatim: specString("1. Declare field validators in @form"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(verbatim: specString("@form {n  email: required, emailn  password: required, min-length(8)n}"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(verbatim: specString("2. Keep field values in @state as normal"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(verbatim: specString("@state { email: \"\"  password: \"\" }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(verbatim: specString("3. Call _touchField on blur, _submitForm on submit"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(verbatim: specString("TextInput(...) { on blur: _touchField(\"email\") }nButton(\"Submit\") { on click: _submitForm() }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(verbatim: specString("4. Use generated signals in the template"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(verbatim: specString("error: _fld_email_touched && _fld_email_error != nullnbutton disabled: !_form_validntext(_fld_email_error)  // shows error message"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              }

            }
            .padding(CGFloat(24))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
