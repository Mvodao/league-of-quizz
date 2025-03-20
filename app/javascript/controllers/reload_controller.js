import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reload"
export default class extends Controller {
  static values = {
    userwhoanswered: String
  }
  connect() {
    const currentUserValue = document.querySelector("#currentUser").dataset["currentuser"]
    console.log(currentUserValue)
    console.log(this.userwhoansweredValue)
    if (currentUserValue !== this.userwhoansweredValue){
      window.location.reload()
    }
  }
}
