import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modalbtn", "sub"]
  static values = {
    iscorrect: String
  }
  connect(){
    console.log("test")
  }

  fire(event){
    event.preventDefault()
    this.modalbtnTarget.click()
    console.log(this.iscorrectValue)
    // setTimeout(() => {
    //   this.subTarget.submit()
    // }, 2000);
  }
}
