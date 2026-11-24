import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class FormDemoViewModel {
  var firstName: Any = ""
  var lastName: Any = ""
  var email: Any = ""
  var message: Any = ""
  var submitted: Any = false
  var submittedData: Any? = Optional<Any>.none as Any
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
      return (!specIsNil(((((!((firstName) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(firstName)), "")) ? "Required" : Optional<Any>.none as Any)) ? ((((!((firstName) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(firstName)), "")) ? "Required" : Optional<Any>.none as Any) : (((firstName) as? Bool ?? false && (specLt(specLength(specString(firstName)), 2)) as? Bool ?? false) ? "Must be at least 2 characters" : Optional<Any>.none as Any))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((firstName) as? Bool ?? false && (specGt(specLength(specString(firstName)), 50)) as? Bool ?? false)) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return (Optional<Any>.none as Any) as Any? as Any
  }
  var _fld_lastName_error: Any {
    if ((((!((_fld_lastName_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (!specIsNil(((((!((lastName) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(lastName)), "")) ? "Required" : Optional<Any>.none as Any)) ? ((((!((lastName) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(lastName)), "")) ? "Required" : Optional<Any>.none as Any) : (((lastName) as? Bool ?? false && (specLt(specLength(specString(lastName)), 2)) as? Bool ?? false) ? "Must be at least 2 characters" : Optional<Any>.none as Any))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((lastName) as? Bool ?? false && (specGt(specLength(specString(lastName)), 50)) as? Bool ?? false)) ? "Must be 50 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return (Optional<Any>.none as Any) as Any? as Any
  }
  var _fld_email_error: Any {
    if ((((!((_fld_email_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return ((((!((email) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(email)), "")) ? "Required" : Optional<Any>.none as Any)
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((email) as? Bool ?? false && ((!(specRegexTest(specRegex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"), specString(email))))) as? Bool ?? false)) ? "Invalid email address" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return (Optional<Any>.none as Any) as Any? as Any
  }
  var _fld_message_error: Any {
    if ((((!((_fld_message_touched) as? Bool ?? false))) as? Bool ?? false && ((!((_form_submit_attempted) as? Bool ?? false))) as? Bool ?? false)) { return Optional<Any>.none as Any }
    let _v0: Any? = { () -> Any? in
      return (!specIsNil(((((!((message) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(message)), "")) ? "Required" : Optional<Any>.none as Any)) ? ((((!((message) as? Bool ?? false))) as? Bool ?? false || specEq(specTrim(specString(message)), "")) ? "Required" : Optional<Any>.none as Any) : (((message) as? Bool ?? false && (specLt(specLength(specString(message)), 10)) as? Bool ?? false) ? "Must be at least 10 characters" : Optional<Any>.none as Any))
    }()
    if _v0 != nil { return _v0 as Any }
    let _v1: Any? = { () -> Any? in
      return (((message) as? Bool ?? false && (specGt(specLength(specString(message)), 500)) as? Bool ?? false)) ? "Must be 500 characters or fewer" : nil
    }()
    if _v1 != nil { return _v1 as Any }
    return (Optional<Any>.none as Any) as Any? as Any
  }
  var _form_valid: Any { ((((specIsNil(_fld_firstName_error)) as? Bool ?? false && (specIsNil(_fld_lastName_error)) as? Bool ?? false) && (specIsNil(_fld_email_error)) as? Bool ?? false) && (specIsNil(_fld_message_error)) as? Bool ?? false) }
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
    submittedData = Optional<Any>.none as Any
    _resetForm()
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct FormDemoView: View {
  @State private var vm = FormDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = FormDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Form Validation (@form block)"))
        .font(.largeTitle)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("The @form block adds field-level validation, touched tracking, and dirty state with zero boilerplate."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        Button(action: { specClick { vm.setActiveForm("contact") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Contact Form"))
            .foregroundStyle(((vm.isContactForm) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(14))
        .background(((vm.isContactForm) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setActiveForm("how") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("How It Works"))
            .foregroundStyle(((vm.isHowForm) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(14))
        .background(((vm.isHowForm) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }

      if (vm.isContactForm) as? Bool ?? false {
        _specArm0
      }
      if (vm.isHowForm) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.isHowForm) as? Bool ?? false {
          _specArm1
        }
      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
      HStack(alignment: .top, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        VStack(alignment: .leading, spacing: 0) {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
              HStack(alignment: .center, spacing: 0) {
                Text(verbatim: specString("Contact Us"))
                  .font(.title2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Spacer(minLength: 0)
                if (vm._form_dirty) as? Bool ?? false {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("Unsaved changes"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(Color(hex: "#92400e"))
                }
                .padding(specBorderWidth("1px solid #fde68a"))
                .padding(.vertical, CGFloat(3))
                .padding(.horizontal, CGFloat(10))
                .background(Color(hex: "#fef9c3"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
                .specBorderAll("1px solid #fde68a", radius: specPx(ThemeManager.shared.rawToken("radius-sm")))
                }
              }
              .frame(maxWidth: .infinity)

              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("First Name"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  SpecTextField(specString("Jane"), text: Binding(get: { vm.firstName as? String ?? "" }, set: { newValue in vm.firstName = newValue; let v: Any = newValue; vm.setFirstName(v) }), onBlur: { vm._touchField("firstName") })
                    .textFieldStyle(.roundedBorder)
                    .specAccessibilityLabel("First Name")
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(((vm._fld_firstName_touched) as? Bool ?? false && !specIsNil(vm._fld_firstName_error))) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
                  if ((vm._fld_firstName_touched) as? Bool ?? false && !specIsNil(vm._fld_firstName_error)) {
                  VStack(alignment: .leading, spacing: 0) {
                    Text(verbatim: specString(vm._fld_firstName_error))
                      .font(.footnote)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                      .foregroundStyle(Color(hex: "#dc2626"))
                  }

                  }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .specFlexGrow(1)
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("Last Name"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  SpecTextField(specString("Doe"), text: Binding(get: { vm.lastName as? String ?? "" }, set: { newValue in vm.lastName = newValue; let v: Any = newValue; vm.setLastName(v) }), onBlur: { vm._touchField("lastName") })
                    .textFieldStyle(.roundedBorder)
                    .specAccessibilityLabel("Last Name")
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(((vm._fld_lastName_touched) as? Bool ?? false && !specIsNil(vm._fld_lastName_error))) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
                  if ((vm._fld_lastName_touched) as? Bool ?? false && !specIsNil(vm._fld_lastName_error)) {
                  VStack(alignment: .leading, spacing: 0) {
                    Text(verbatim: specString(vm._fld_lastName_error))
                      .font(.footnote)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                      .foregroundStyle(Color(hex: "#dc2626"))
                  }

                  }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .specFlexGrow(1)
              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("Email"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                SpecTextField(specString("jane@example.com"), text: Binding(get: { vm.email as? String ?? "" }, set: { newValue in vm.email = newValue; let v: Any = newValue; vm.setEmail(v) }), onBlur: { vm._touchField("email") })
                  .textFieldStyle(.roundedBorder)
                  .keyboardType(.emailAddress)
                  .textInputAutocapitalization(.never)
                  .autocorrectionDisabled()
                  .specAccessibilityLabel("Email")
                  .overlay(RoundedRectangle(cornerRadius: 6).stroke(specTruthy(((vm._fld_email_touched) as? Bool ?? false && !specIsNil(vm._fld_email_error))) ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
                if ((vm._fld_email_touched) as? Bool ?? false && !specIsNil(vm._fld_email_error)) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString(vm._fld_email_error))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(Color(hex: "#dc2626"))
                }

                }
              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("Message"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                SpecTextEditor(text: Binding(get: { vm.message as? String ?? "" }, set: { newValue in vm.message = newValue; let v: Any = newValue; vm.setMessage(v) }))
                  .frame(minHeight: 88)
                  .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                  .specAccessibilityLabel("Message")
                if ((vm._fld_message_touched) as? Bool ?? false && !specIsNil(vm._fld_message_error)) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString(vm._fld_message_error))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(Color(hex: "#dc2626"))
                }

                }
              }

              if ((vm._form_submit_attempted) as? Bool ?? false && ((!((vm._form_valid) as? Bool ?? false))) as? Bool ?? false) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Text(verbatim: specString("Please fix the errors above before submitting."))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#dc2626"))
              }
              .padding(specBorderWidth("1px solid #fecaca"))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background(Color(hex: "#fef2f2"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll("1px solid #fecaca", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              }
              if (vm.submitted) as? Bool ?? false {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Message sent successfully!"))
                  .font(.title2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#166534"))
                Text(verbatim: specString("We received your form data and will be in touch soon."))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#166534"))
              }
              .padding(specBorderWidth("1px solid #bbf7d0"))
              .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              }
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Spacer(minLength: 0)
                Button(action: { specClick { vm.resetContact() } }) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("Reset"))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(.vertical, CGFloat(8))
                .padding(.horizontal, CGFloat(20))
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                Button(action: { specClick { vm.submitContact() } }) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("Send Message"))
                    .foregroundStyle(Color(hex: "#fff"))
                }
                .padding(.vertical, CGFloat(8))
                .padding(.horizontal, CGFloat(20))
                .background(ThemeManager.shared.color("primary"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .opacity(specPx(((vm._form_valid) as? Bool ?? false ? 1 : 0.6)))
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
              }
              .frame(maxWidth: .infinity)

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-6")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .specFlexGrow(1)
        VStack(alignment: .leading, spacing: 0) {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Form State"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString("Valid"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Spacer(minLength: 0)
                  Text(verbatim: ({ () -> String in
          if (vm._form_valid) as? Bool ?? false { return specString("✓ Yes") }
          return specString("✗ No")
        })())
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(((vm._form_valid) as? Bool ?? false ? Color(hex: "#166534") : Color(hex: "#dc2626")))
                }
                .frame(maxWidth: .infinity)

                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString("Dirty"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Spacer(minLength: 0)
                  Text(verbatim: ({ () -> String in
          if (vm._form_dirty) as? Bool ?? false { return specString("Yes") }
          return specString("No")
        })())
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .frame(maxWidth: .infinity)

                HStack(alignment: .center, spacing: 0) {
                  Text(verbatim: specString("Submit attempted"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Spacer(minLength: 0)
                  Text(verbatim: ({ () -> String in
          if (vm._form_submit_attempted) as? Bool ?? false { return specString("Yes") }
          return specString("No")
        })())
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .frame(maxWidth: .infinity)

              }

              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("Field errors:"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString("firstName: \(specString(specCoalesce(vm._fld_firstName_error, "OK")))"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                Text(verbatim: specString("lastName: \(specString(specCoalesce(vm._fld_lastName_error, "OK")))"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                Text(verbatim: specString("email: \(specString(specCoalesce(vm._fld_email_error, "OK")))"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                Text(verbatim: specString("message: \(specString(specCoalesce(vm._fld_message_error, "OK")))"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(width: CGFloat(240), alignment: .leading)
      }

    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
              Text(verbatim: specString("How @form works"))
                .font(.title2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                Text(verbatim: specString("1. Declare field validators in @form"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("@form {\n  email: required, email\n  password: required, min-length(8)\n}"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                Text(verbatim: specString("2. Keep field values in @state as normal"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("@state { email: \"\"  password: \"\" }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                Text(verbatim: specString("3. Call _touchField on blur, _submitForm on submit"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("TextInput(...) { on blur: _touchField(\"email\") }\nButton(\"Submit\") { on click: _submitForm() }"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                Text(verbatim: specString("4. Use generated signals in the template"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString("error: _fld_email_touched && _fld_email_error != null\nbutton disabled: !_form_valid\ntext(_fld_email_error)  // shows error message"))
                    .font(.body)
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-6")))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    })
  }
}
