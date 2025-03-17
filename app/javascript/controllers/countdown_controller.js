import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets =["time", "startGame"]

  connect() {
    console.log(this.timeTarget.innerText)
    const duration = 5
    for (let step=0; step < 6; step++) {
        setTimeout(() => {
          this.timeTarget.innerText = duration-step
      }, step*1000);
      }
    setTimeout(() => {
      this.startGameTarget.click()
    }, 5000);
    }
}
