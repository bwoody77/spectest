// FormDemo — demonstrates the @form block for declarative form validation.
//
// @form registers field names with built-in validators. The compiler
// automatically generates:
//   _fld_{name}_touched  — signal: true after blur or first submit attempt
//   _fld_{name}_error    — computed: validation error string or null
//   _form_valid          — computed: true when all fields pass
//   _form_dirty          — computed: true when any field differs from its initial value
//   _touchField(name)    — action: mark field as touched (call on blur)
//   _submitForm()        — action: mark all fields touched + set submit-attempted flag
//   _resetForm()         — action: clear all touched flags
//   _formData()          — action: returns { fieldName: value, ... } object
//
// Built-in validators:
//   required, email, min-length(n), max-length(n), min(n), max(n), pattern("regex")
//
// Validation only shows after a field is touched (blurred) or _submitForm() is called.
// This prevents error messages from appearing on an untouched form.

surface FormDemo() {
  @state {
    // Contact form fields
    firstName: ""
    lastName: ""
    email: ""
    message: ""
    submitted: false
    submittedData: null

    // Registration form fields
    username: ""
    password: ""
    confirmPassword: ""
    age: ""
    regSubmitted: false

    activeForm: "contact"
  }

  @form {
    firstName: required, min-length(2), max-length(50)
    lastName: required, min-length(2), max-length(50)
    email: required, email
    message: required, min-length(10), max-length(500)
  }

  @computed {
    isContactForm: activeForm == "contact"
    isHowForm: activeForm == "how"
  }

  @actions {
    setFirstName(v) { firstName = v }
    setLastName(v) { lastName = v }
    setEmail(v) { email = v }
    setMessage(v) { message = v }
    setActiveForm(f) { activeForm = f }

    submitContact() {
      _submitForm()
      if (_form_valid) {
        submittedData = _formData()
        submitted = true
        _resetForm()
      }
    }

    resetContact() {
      firstName = ""
      lastName = ""
      email = ""
      message = ""
      submitted = false
      submittedData = null
      _resetForm()
    }
  }

  layout: vertical, gap: spacing.5

  text("Form Validation (@form block)") { style: type.heading-lg, color: semantic.text-primary }
  text("The @form block adds field-level validation, touched tracking, and dirty state with zero boilerplate.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // Form selector
  block {
    layout: horizontal, gap: spacing.2

    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isContactForm ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setActiveForm("contact")
      text("Contact Form") { color: isContactForm ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isHowForm ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setActiveForm("how")
      text("How It Works") { color: isHowForm ? "#fff" : semantic.text-primary }
    }
  }

  // ── Contact form ──────────────────────────────────────────────────────────
  block {
    visibility: isContactForm
    layout: horizontal, gap: spacing.5, align: "flex-start"

    // The form
    block {
      grow: true
      Card() {
        block {
          padding: spacing.6
          layout: vertical, gap: spacing.5

          block {
            layout: horizontal, justify: "space-between", align: "center"
            text("Contact Us") { style: type.heading-sm, color: semantic.text-primary }

            // Dirty indicator
            block {
              visibility: _form_dirty
              padding: "3px 10px"
              background: "#fef9c3"
              border-radius: radius.sm
              border: "1px solid #fde68a"
              text("Unsaved changes") { style: type.body-sm, color: "#92400e" }
            }
          }

          // First + Last name row
          block {
            layout: horizontal, gap: spacing.4

            // First Name
            block {
              grow: true
              layout: vertical, gap: spacing.1

              text("First Name") { style: type.label-sm, color: semantic.text-primary }
              Input(
                type: "text",
                value: firstName,
                placeholder: "Jane",
                error: _fld_firstName_touched && _fld_firstName_error != null
              ) {
                on change(v): setFirstName(v)
                on blur: _touchField("firstName")
              }
              block {
                visibility: _fld_firstName_touched && _fld_firstName_error != null
                text(_fld_firstName_error) { style: type.body-sm, color: "#dc2626" }
              }
            }

            // Last Name
            block {
              grow: true
              layout: vertical, gap: spacing.1

              text("Last Name") { style: type.label-sm, color: semantic.text-primary }
              Input(
                type: "text",
                value: lastName,
                placeholder: "Doe",
                error: _fld_lastName_touched && _fld_lastName_error != null
              ) {
                on change(v): setLastName(v)
                on blur: _touchField("lastName")
              }
              block {
                visibility: _fld_lastName_touched && _fld_lastName_error != null
                text(_fld_lastName_error) { style: type.body-sm, color: "#dc2626" }
              }
            }
          }

          // Email
          block {
            layout: vertical, gap: spacing.1

            text("Email") { style: type.label-sm, color: semantic.text-primary }
            Input(
              type: "email",
              value: email,
              placeholder: "jane@example.com",
              error: _fld_email_touched && _fld_email_error != null
            ) {
              on change(v): setEmail(v)
              on blur: _touchField("email")
            }
            block {
              visibility: _fld_email_touched && _fld_email_error != null
              text(_fld_email_error) { style: type.body-sm, color: "#dc2626" }
            }
          }

          // Message
          block {
            layout: vertical, gap: spacing.1

            text("Message") { style: type.label-sm, color: semantic.text-primary }
            Input(
              type: "textarea",
              value: message,
              placeholder: "Tell us how we can help...",
              error: _fld_message_touched && _fld_message_error != null
            ) {
              on change(v): setMessage(v)
              on blur: _touchField("message")
            }
            block {
              visibility: _fld_message_touched && _fld_message_error != null
              text(_fld_message_error) { style: type.body-sm, color: "#dc2626" }
            }
          }

          // Form validity summary
          block {
            visibility: _form_submit_attempted && !_form_valid
            padding: spacing.4
            background: "#fef2f2"
            border-radius: radius.md
            border: "1px solid #fecaca"
            layout: horizontal, gap: spacing.3, align: "center"
            text("Please fix the errors above before submitting.") {
              style: type.body-sm
              color: "#dc2626"
            }
          }

          // Success message
          block {
            visibility: submitted
            padding: spacing.4
            background: "#f0fdf4"
            border-radius: radius.md
            border: "1px solid #bbf7d0"
            layout: vertical, gap: spacing.2
            text("Message sent successfully!") { style: type.heading-sm, color: "#166534" }
            text("We received your form data and will be in touch soon.") {
              style: type.body-sm
              color: "#166534"
            }
          }

          // Actions
          block {
            layout: horizontal, gap: spacing.3, justify: "flex-end"

            block {
              padding: "8px 20px"
              border-radius: radius.md
              cursor: "pointer"
              border: borders.default
              background: semantic.surface-raised
              on click: resetContact()
              text("Reset") { color: semantic.text-secondary }
            }

            block {
              padding: "8px 20px"
              border-radius: radius.md
              cursor: "pointer"
              background: semantic.primary
              opacity: _form_valid ? 1 : 0.6
              on click: submitContact()
              text("Send Message") { color: "#fff" }
            }
          }
        }
      }
    }

    // Status panel
    block {
      width: 240px
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.3

          text("Form State") { style: type.heading-sm, color: semantic.text-primary }

          block {
            layout: vertical, gap: spacing.2

            block {
              layout: horizontal, justify: "space-between"
              text("Valid") { style: type.body-sm, color: semantic.text-secondary }
              text(_form_valid ? "✓ Yes" : "✗ No") {
                style: type.body-sm
                color: _form_valid ? "#166534" : "#dc2626"
              }
            }
            block {
              layout: horizontal, justify: "space-between"
              text("Dirty") { style: type.body-sm, color: semantic.text-secondary }
              text(_form_dirty ? "Yes" : "No") { style: type.body-sm, color: semantic.text-primary }
            }
            block {
              layout: horizontal, justify: "space-between"
              text("Submit attempted") { style: type.body-sm, color: semantic.text-secondary }
              text(_form_submit_attempted ? "Yes" : "No") { style: type.body-sm, color: semantic.text-primary }
            }
          }

          block {
            layout: vertical, gap: spacing.1
            text("Field errors:") { style: type.label-sm, color: semantic.text-secondary }
            text("firstName: {_fld_firstName_error ?? 'OK'}") { style: type.body-sm, color: semantic.text-tertiary }
            text("lastName: {_fld_lastName_error ?? 'OK'}") { style: type.body-sm, color: semantic.text-tertiary }
            text("email: {_fld_email_error ?? 'OK'}") { style: type.body-sm, color: semantic.text-tertiary }
            text("message: {_fld_message_error ?? 'OK'}") { style: type.body-sm, color: semantic.text-tertiary }
          }
        }
      }
    }
  }

  // ── How it works ──────────────────────────────────────────────────────────
  block {
    visibility: isHowForm
    Card() {
      block {
        padding: spacing.6
        layout: vertical, gap: spacing.5

        text("How @form works") { style: type.heading-sm, color: semantic.text-primary }

        block {
          layout: vertical, gap: spacing.3

          text("1. Declare field validators in @form") { style: type.label-sm, color: semantic.text-primary }
          block {
            padding: spacing.4
            background: semantic.surface-raised
            border-radius: radius.md
            border: borders.default
            text("@form \{\n  email: required, email\n  password: required, min-length(8)\n\}") {
              style: type.code
              color: semantic.text-primary
            }
          }

          text("2. Keep field values in @state as normal") { style: type.label-sm, color: semantic.text-primary }
          block {
            padding: spacing.4
            background: semantic.surface-raised
            border-radius: radius.md
            border: borders.default
            text("@state \{ email: \"\"  password: \"\" \}") {
              style: type.code
              color: semantic.text-primary
            }
          }

          text("3. Call _touchField on blur, _submitForm on submit") { style: type.label-sm, color: semantic.text-primary }
          block {
            padding: spacing.4
            background: semantic.surface-raised
            border-radius: radius.md
            border: borders.default
            text("Input(...) \{ on blur: _touchField(\"email\") \}\nButton(\"Submit\") \{ on click: _submitForm() \}") {
              style: type.code
              color: semantic.text-primary
            }
          }

          text("4. Use generated signals in the template") { style: type.label-sm, color: semantic.text-primary }
          block {
            padding: spacing.4
            background: semantic.surface-raised
            border-radius: radius.md
            border: borders.default
            text("error: _fld_email_touched && _fld_email_error != null\nbutton disabled: !_form_valid\ntext(_fld_email_error)  // shows error message") {
              style: type.code
              color: semantic.text-primary
            }
          }
        }
      }
    }
  }
}
