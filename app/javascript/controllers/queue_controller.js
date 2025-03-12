import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="queue"
export default class extends Controller {
  static targets = ["playerwrapper",
                    "playertitle",
                    "playercharacter",
                    "find",
                    "cancel",
                    "challengerimage",
                    "challengerwrapper",
                    "challengertitle",
                    "challengercharacter",]
  connect() {
    console.log("queue controller connected")
  }

  find_opponent(event) {
    this.playertitleTarget.classList.add("toggle")
    this.playercharacterTarget.classList.add("toggle")
    this.playerwrapperTarget.classList.add("rotating-wrapper")
    this.findTarget.innerText = "Searching..."
    this.findTarget.classList.add("btn-hover")
    this.cancelTarget.innerText = "X"
    this.cancelTarget.classList.remove("d-none")

    setTimeout(() => {
      this.findTarget.innerText = "Opponent Found!"
      this.cancelTarget.classList.add("d-none")
      this.challengerimageTarget.classList.remove("empty-cover-image")
      this.challengerimageTarget.classList.add("cover-image")
      this.challengerimageTarget.style.transform = "rotateY(3.142rad)"
      this.challengertitleTarget.classList.add("toggle")
      this.challengercharacterTarget.classList.add("toggle")
      this.challengerwrapperTarget.classList.add("rotating-wrapper-challenger")
      this.challengertitleTarget.classList.add("opponent-title")
      this.challengertitleTarget.classList.remove("challenger-waiting-title")
      this.challengertitleTarget.innerText = "Wise Mage"
      window.location.href = "/games/1/edit"
    }, 1000);
  }

  cancel(event) {
    this.playertitleTarget.classList.remove("toggle")
    this.playercharacterTarget.classList.remove("toggle")
    this.playerwrapperTarget.classList.remove("rotating-wrapper")
    this.findTarget.innerText = "Finding an opponent"
    this.findTarget.classList.remove("btn-hover")
    this.cancelTarget.innerText = ""
    this.cancelTarget.classList.add("d-none")
  }
}
