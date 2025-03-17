import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bonus"
export default class extends Controller {
  static targets = ["forms", "btn", "bonusDisabled"]
  static values = {
    bname: String
  }
  connect() {
    if (this.bnameValue === "None") {
      this.btnTarget.disabled = true
      this.btnTarget.innerHTML = "<strike style='color:red'><span style='color:white;font-weight:200;'>Bonus<span></strike>"
      this.bonusDisabledTarget.value = true
    }

  }

  fiftyfifty(forms){
    console.log("fiftyfifty")
    const formsArray = Array.from(forms)
    const buttons = formsArray.map((form) => ({
      btn: form.querySelector('input[type="submit"]'),
      answerType: form.classList.contains("answer_true")
    }));
    let disableCandidates = buttons.filter(b => !b.answerType);
    const toDisable = disableCandidates.sort(() => 0.5 - Math.random()).slice(0, 2)
    toDisable.forEach(b => b.btn.disabled = true);
    this.btnTarget.disabled = true
    this.btnTarget.innerHTML = "<strike style='color:red'><span style='color:white;font-weight:200;'>Bonus<span></strike>"
    this.bonusDisabledTarget.value = true
  }

  applybonus() {
    const forms = this.formsTarget.querySelectorAll("form")
    if (this.bnameValue !== "None") {
      this.fiftyfifty(forms)
    }
  }
}
