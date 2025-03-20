import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modalbtn",
                    "modaldiv",
                    "sub1",
                    "sub2",
                    "sub3",
                    "sub4",
                    "playerscore",
                    "submitBtn1",
                    "submitBtn2",
                    "submitBtn3",
                    "submitBtn4",
                    "nextbtn"]

  static values = {
    iscorrect: String,
    quickplay: String,
    answered: String
  }

  connect(){
    let currentPath = window. location. pathname;
    const questionIdx = currentPath.split("/")[currentPath.split("/").indexOf("questions")+1]
    console.log(this.quickplayValue)
    console.log(this.answeredValue)
    if (this.quickplayValue === "true") {
      if ( this.answeredValue === "true") {
          this.modaldivTarget.classList.remove("success-modal")
          this.modaldivTarget.classList.add("lose-modal")
          this.modaldivTarget.innerText = "Your opponent was faster than you!"
          this.modalbtnTarget.click()
          setTimeout(() => {
            this.nextbtnTarget.click()
          }, 3000);
      }
    }
  }

  fire1(event){
    event.preventDefault()
    // console.log(event.currentTarget.classList.contains("answer_true"))
    if (event.currentTarget.classList.contains("answer_true")) {
      if (this.quickplayValue === "false") {
        this.modaldivTarget.innerText = "GOOD JOB DAVID"
      }
      this.modalbtnTarget.click()
      setTimeout(() => {
        this.sub1Target.submit()
      }, 3000);
    } else {
      this.submitBtn1Target.classList.add("error");
      this.playerscoreTarget.innerText = parseInt(this.playerscoreTarget.innerText)-1
      this.sub1Target.submit()
      setTimeout(() => {
        this.submitBtn1Target.classList.remove("error");
      }, 600); // Temps total de l'animation
    }
  }

  fire2(event){
    event.preventDefault()
    // console.log(event.currentTarget.classList.contains("answer_true"))
    if (event.currentTarget.classList.contains("answer_true")) {
      if (this.quickplayValue === "false"){
        this.modaldivTarget.innerText = "GOOD JOB DAVID"
      }

      this.modalbtnTarget.click()
      setTimeout(() => {
        this.sub2Target.submit()
      }, 3000);
    } else {
      this.submitBtn2Target.classList.add("error");
      this.playerscoreTarget.innerText = parseInt(this.playerscoreTarget.innerText)-1
      this.sub2Target.submit()
      setTimeout(() => {
        this.submitBtn2Target.classList.remove("error");
      }, 600); // Temps total de l'animation
    }
  }
  fire3(event){
    event.preventDefault()
    // console.log(event.currentTarget.classList.contains("answer_true"))
    if (event.currentTarget.classList.contains("answer_true")) {
      if (this.quickplayValue === "false"){
        this.modaldivTarget.innerText = "GOOD JOB DAVID"
      }
      this.modalbtnTarget.click()
      setTimeout(() => {
        this.sub3Target.submit()
      }, 3000);
    } else {
      this.submitBtn3Target.classList.add("error");
      this.playerscoreTarget.innerText = parseInt(this.playerscoreTarget.innerText)-1
      this.sub3Target.submit()
      setTimeout(() => {
        this.submitBtn3Target.classList.remove("error");
      }, 600); // Temps total de l'animation
    }
  }
  fire4(event){
    event.preventDefault()
    // console.log(event.currentTarget.classList.contains("answer_true"))
    if (event.currentTarget.classList.contains("answer_true")) {
      if (this.quickplayValue === "false"){
        this.modaldivTarget.innerText = "GOOD JOB DAVID"
      }
      this.modalbtnTarget.click()
      setTimeout(() => {
        this.sub4Target.submit()
      }, 3000);

    } else {
      this.submitBtn4Target.classList.add("error");
      this.playerscoreTarget.innerText = parseInt(this.playerscoreTarget.innerText)-1
      this.sub4Target.submit()
      setTimeout(() => {
        this.submitBtn4Target.classList.remove("error");
      }, 600); // Temps total de l'animation
    }
  }
}
