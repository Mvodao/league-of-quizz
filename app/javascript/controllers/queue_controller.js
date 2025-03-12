import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="queue"
export default class extends Controller {
  static targets = ["playerwrapper", "playertitle", "playercharacter"]
  connect() {
    console.log("queue controller connected")
  }

  find_opponent() {
    this.playertitleTarget.style.opacity = 1
    this.playertitleTarget.style.transform = "translate3d(0%, -50px, 100px)"

    this.playercharacterTarget.style.opacity = 1
    this.playercharacterTarget.style.transform = "translate3d(0%, -50px, 100px)"

    this.playerwrapperTarget.style.transform = "perspective(900px) translateY(-5%) rotateX(25deg) translateZ(0)"
    this.playerwrapperTarget.style.boxShadow = "2px 35px 32px -8px rgba(0, 0, 0, 0.75)"
    this.playerwrapperTarget.style.webkitBoxShadow = "2px 35px 32px -8px rgba(0, 0, 0, 0.75)"
    this.playerwrapperTarget.style.mozBoxShadow = "2px 35px 32px -8px rgba(0, 0, 0, 0.75)"

    this.playerwrapperTarget.style.backgroundImage = " linear-gradient( to top, transparent 46%,rgba(12, 13, 19, 0.5) 68%,
    rgb(12, 13, 19) 97%
  );"

  }
}
