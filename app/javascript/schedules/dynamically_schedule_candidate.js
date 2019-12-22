class DynamicallyScheduleCandidateForm {
  constructor() {
    // document.queryselector で使う定義
    this.dynamicallyFormId    = '#schedule__dynamically_form'
    this.addNewButtonId       = '#schedule__schedule_candidate__add-new-form'
    this.targetFormFieldClass = '.schedule__schedule_candidate'
  }

  registerEvents() {
    let targetElement = document.querySelector(this.addNewButtonId)

    if (!targetElement) { return }

    targetElement.addEventListener('click', (event) => {
      event.preventDefault()
      this.cloneNewField()
    })
  }

  cloneNewField() {

    var cloningFormField =
      document.querySelectorAll(this.targetFormFieldClass)[0]
              .cloneNode(true)
    var appendRoot = document.querySelector(this.dynamicallyFormId)

    appendRoot.appendChild(cloningFormField)
  }
}

document.addEventListener('load', (event) => {
  var dynamicallyScheduleCandidateForm = new DynamicallyScheduleCandidateForm
  dynamicallyScheduleCandidateForm.registerEvents()
})

document.addEventListener('turbolinks:load', (event) => {
  var dynamicallyScheduleCandidateForm = new DynamicallyScheduleCandidateForm
  dynamicallyScheduleCandidateForm.registerEvents()
})
