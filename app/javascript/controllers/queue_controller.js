import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";

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
                    "challengercharacter",
                    "form"]


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

    this.timeOut = setTimeout(() => {
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
      this.challengertitleTarget.innerText = "Terminator"

      setTimeout(() => {
        this.formTarget.submit()
      }, 4000);

    }, 5000);
  }

  cancel(event) {
    this.playertitleTarget.classList.remove("toggle")
    this.playercharacterTarget.classList.remove("toggle")
    this.playerwrapperTarget.classList.remove("rotating-wrapper")
    this.findTarget.innerText = "Finding an opponent"
    this.findTarget.classList.remove("btn-hover")
    this.cancelTarget.innerText = ""
    this.cancelTarget.classList.add("d-none")

    this.challengerimageTarget.classList.add("empty-cover-image")
    this.challengerimageTarget.classList.remove("cover-image")
    // this.challengerimageTarget.style.transform = "rotateY(3.142rad)"
    this.challengertitleTarget.classList.remove("toggle")
    this.challengercharacterTarget.classList.remove("toggle")
    this.challengerwrapperTarget.classList.remove("rotating-wrapper-challenger")
    this.challengertitleTarget.classList.remove("opponent-title")
    this.challengertitleTarget.classList.add("challenger-waiting-title")
    this.challengertitleTarget.innerText = "No worthy opponent yet."
    clearTimeout(this.timeOut);
  }
}
