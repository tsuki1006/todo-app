import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

  static targets = [ 'backGround', 'rootLink' ]

  connect() {
  }

  モーダルを閉じる
  closeModal() {
    this.backGroundTarget.classList.add('-hidden')
  }

  モーダル外をクリックしたときモーダルを閉じる
  closeBackground(event) {
    if(event.target === this.backGroundTarget) {
      this.backGroundTarget.classList.add('-hidden')
      this.rootLinkTarget.click()
    }
  }
}
