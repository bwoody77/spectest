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
  var isContactForm: Any { (specString(activeForm) == specString("contact")) }
  var isHowForm: Any { (specString(activeForm) == specString("how")) }
  var _fld_firstName_error: Any {
    if ((!(_fld_firstName_touched as? Bool ?? false) && !(_form_submit_attempted as? Bool ?? false)) as? Bool ?? false) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((!(firstName as? Bool ?? false) || (specString((specString(firstName) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) != nil ? ((!(firstName as? Bool ?? false) || (specString((specString(firstName) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) : ((firstName as? Bool ?? false && (specDouble(specLength(specString(firstName))) < specDouble(2))) ? "Must be at least 2 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return ((firstName as? Bool ?? false && (specDouble(specLength(specString(firstName))) > specDouble(50)))) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_lastName_error: Any {
    if ((!(_fld_lastName_touched as? Bool ?? false) && !(_form_submit_attempted as? Bool ?? false)) as? Bool ?? false) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((!(lastName as? Bool ?? false) || (specString((specString(lastName) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) != nil ? ((!(lastName as? Bool ?? false) || (specString((specString(lastName) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) : ((lastName as? Bool ?? false && (specDouble(specLength(specString(lastName))) < specDouble(2))) ? "Must be at least 2 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return ((lastName as? Bool ?? false && (specDouble(specLength(specString(lastName))) > specDouble(50)))) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_email_error: Any {
    if ((!(_fld_email_touched as? Bool ?? false) && !(_form_submit_attempted as? Bool ?? false)) as? Bool ?? false) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return ((!(email as? Bool ?? false) || (specString((specString(email) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil)
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return ((email as? Bool ?? false && !(specRegexTest(specRegex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"), specString(email)) as? Bool ?? false)) as? Bool ?? false) ? "Invalid email address" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _fld_message_error: Any {
    if ((!(_fld_message_touched as? Bool ?? false) && !(_form_submit_attempted as? Bool ?? false)) as? Bool ?? false) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (((!(message as? Bool ?? false) || (specString((specString(message) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) != nil ? ((!(message as? Bool ?? false) || (specString((specString(message) as? String ?? "").trimmingCharacters(in: .whitespaces)) == specString(""))) ? "Required" : nil) : ((message as? Bool ?? false && (specDouble(specLength(specString(message))) < specDouble(10))) ? "Must be at least 10 characters" : nil))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return ((message as? Bool ?? false && (specDouble(specLength(specString(message))) > specDouble(500)))) ? "Must be 500 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return Optional<Any>.none as Any
  }
  var _form_valid: Any { (((_fld_firstName_error == nil && _fld_lastName_error == nil) && _fld_email_error == nil) && _fld_message_error == nil) }
  var _form_dirty: Any { ((((specString(firstName) != specString("")) || (specString(lastName) != specString(""))) || (specString(email) != specString(""))) || (specString(message) != specString(""))) }
  func _touchField(_ name: Any) {
    if (specString(name) == specString("firstName")) as? Bool ?? false {
      _fld_firstName_touched = true
    }
    if (specString(name) == specString("lastName")) as? Bool ?? false {
      _fld_lastName_touched = true
    }
    if (specString(name) == specString("email")) as? Bool ?? false {
      _fld_email_touched = true
    }
    if (specString(name) == specString("message")) as? Bool ?? false {
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
    if _form_valid as? Bool ?? false {
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
      Text(specString("Form Validation (@form block)"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
      Text(specString("The @form block adds field-level validation, touched tracking, and dirty state with zero boilerplate."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      HStack(alignment: .center, spacing: CGFloat(8)) {
        VStack() {
          Text(specString("Contact Form"))
            .foregroundStyle(Color(hex: ((vm.isContactForm) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isContactForm) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setActiveForm("contact") }
        VStack() {
          Text(specString("How It Works"))
            .foregroundStyle(Color(hex: ((vm.isHowForm) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isHowForm) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.setActiveForm("how") }
      }

      HStack(alignment: .center, spacing: CGFloat(20)) {
        if vm.isContactForm as? Bool ?? false {
          VStack() {
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(20)) {
                HStack(alignment: .center, ) {
                  Text(specString("Contact Us"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  VStack() {
                    if vm._form_dirty as? Bool ?? false {
                      Text(specString("Unsaved changes"))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#92400e"))
                    }
                  }
                  .padding(CGFloat(0))
                  .background(Color(hex: "#fef9c3"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                }

                HStack(alignment: .center, spacing: CGFloat(16)) {
                  VStack(spacing: CGFloat(4)) {
                    Text(specString("First Name"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    TextField(specString("Jane"), text: Binding(get: { vm.firstName as? String ?? "" }, set: { vm.firstName = $0 }))
                    VStack() {
                      if (vm._fld_firstName_touched as? Bool ?? false && vm._fld_firstName_error != nil) {
                        Text(specString(vm._fld_firstName_error))
                          .font(.callout.bold())
                          .foregroundStyle(Color(hex: "#dc2626"))
                      }
                    }

                  }
                  .frame(minHeight: CGFloat(0))
                  .frame(minWidth: CGFloat(0))
                  .frame(maxWidth: .infinity)
                  VStack(spacing: CGFloat(4)) {
                    Text(specString("Last Name"))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                    TextField(specString("Doe"), text: Binding(get: { vm.lastName as? String ?? "" }, set: { vm.lastName = $0 }))
                    VStack() {
                      if (vm._fld_lastName_touched as? Bool ?? false && vm._fld_lastName_error != nil) {
                        Text(specString(vm._fld_lastName_error))
                          .font(.callout.bold())
                          .foregroundStyle(Color(hex: "#dc2626"))
                      }
                    }

                  }
                  .frame(minHeight: CGFloat(0))
                  .frame(minWidth: CGFloat(0))
                  .frame(maxWidth: .infinity)
                }

                VStack(spacing: CGFloat(4)) {
                  Text(specString("Email"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  TextField(specString("jane@example.com"), text: Binding(get: { vm.email as? String ?? "" }, set: { vm.email = $0 }))
                  VStack() {
                    if (vm._fld_email_touched as? Bool ?? false && vm._fld_email_error != nil) {
                      Text(specString(vm._fld_email_error))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#dc2626"))
                    }
                  }

                }

                VStack(spacing: CGFloat(4)) {
                  Text(specString("Message"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                  TextField(specString("Tell us how we can help..."), text: Binding(get: { vm.message as? String ?? "" }, set: { vm.message = $0 }))
                  VStack() {
                    if (vm._fld_message_touched as? Bool ?? false && vm._fld_message_error != nil) {
                      Text(specString(vm._fld_message_error))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: "#dc2626"))
                    }
                  }

                }

                HStack(alignment: .center, spacing: CGFloat(12)) {
                  if (vm._form_submit_attempted as? Bool ?? false && !(vm._form_valid as? Bool ?? false)) as? Bool ?? false {
                    Text(specString("Please fix the errors above before submitting."))
                      .font(.callout.bold())
                      .foregroundStyle(Color(hex: "#dc2626"))
                  }
                }
                .padding(CGFloat(16))
                .background(Color(hex: "#fef2f2"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                VStack(spacing: CGFloat(8)) {
                  if vm.submitted as? Bool ?? false {
                    Text(specString("Message sent successfully!"))
                      .font(.headline.bold())
                      .foregroundStyle(Color(hex: "#166534"))
                  }
                  Text(specString("We received your form data and will be in touch soon."))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#166534"))
                }
                .padding(CGFloat(16))
                .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                HStack(alignment: .center, spacing: CGFloat(12)) {
                  VStack() {
                    Text(specString("Reset"))
                      .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  }
                  .padding(CGFloat(0))
                  .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                  .onTapGesture { vm.resetContact() }
                  VStack() {
                    Text(specString("Send Message"))
                      .foregroundStyle(Color(hex: "#fff"))
                  }
                  .padding(CGFloat(0))
                  .opacity(specPx(((vm._form_valid) as? Bool ?? false ? 1 : 0.6)))
                  .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                  .onTapGesture { vm.submitContact() }
                }

              }
              .padding(CGFloat(24))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
        }
        VStack() {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(12)) {
              Text(specString("Form State"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, ) {
                  Text(specString("Valid"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(specString(((vm._form_valid) as? Bool ?? false ? "✓ Yes" : "✗ No")))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: ((vm._form_valid) as? Bool ?? false ? "#166534" : "#dc2626") as? String ?? "#000"))
                }

                HStack(alignment: .center, ) {
                  Text(specString("Dirty"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(specString(((vm._form_dirty) as? Bool ?? false ? "Yes" : "No")))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }

                HStack(alignment: .center, ) {
                  Text(specString("Submit attempted"))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(specString(((vm._form_submit_attempted) as? Bool ?? false ? "Yes" : "No")))
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }

              }

              VStack(spacing: CGFloat(4)) {
                Text(specString("Field errors:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(specString("firstName: \(specString((vm._fld_firstName_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(specString("lastName: \(specString((vm._fld_lastName_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(specString("email: \(specString((vm._fld_email_error ?? "OK")))"))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                Text(specString("message: \(specString((vm._fld_message_error ?? "OK")))"))
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
        if vm.isHowForm as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(20)) {
              Text(specString("How @form works"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack(spacing: CGFloat(12)) {
                Text(specString("1. Declare field validators in @form"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(specString("@form {n  email: required, emailn  password: required, min-length(8)n}"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(specString("2. Keep field values in @state as normal"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(specString("@state { email: \"\"  password: \"\" }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(specString("3. Call _touchField on blur, _submitForm on submit"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(specString("TextInput(...) { on blur: _touchField(\"email\") }nButton(\"Submit\") { on click: _submitForm() }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                Text(specString("4. Use generated signals in the template"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                VStack() {
                  Text(specString("error: _fld_email_touched && _fld_email_error != nullnbutton disabled: !_form_validntext(_fld_email_error)  // shows error message"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(16))
                .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
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
