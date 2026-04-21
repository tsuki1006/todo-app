import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {

  // 完了チェックが切り替わったらフォームをsubmit
  completionSubmit() {
    this.element.requestSubmit()
  }
}
