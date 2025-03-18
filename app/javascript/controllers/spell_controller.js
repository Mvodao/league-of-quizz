import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spell"
export default class extends Controller {
  static targets = ["form",
    "spellid",
    "spellModalBtn",
    "spellDescriptionModal",
    "spellDescription",
    "spellName",
    "spellNameModal"]

  connect() {
    const cards = document.querySelectorAll('.spell-card');
    cards.forEach(card => {
      card.addEventListener("click",(event) => {
        if (card.classList.contains("card-selected")) {
          card.classList.remove("card-selected")
          this.spellidTarget.value = ""
        } else {
          card.classList.add("card-selected");
          this.spellidTarget.value = card.id
          // this.spellModalBtnTarget.click()
          // this.spellDescriptionModalTarget.innerText = this.spellDescriptionTarget.innerText
          // this.spellNameModalTarget.innerText = this.spellNameTarget.innerText
        }
        cards.forEach(element => {
          if (element !== card) {
            element.classList.remove("card-selected");
          }
        });
      })
      })
    }

    fire(event){
      event.preventDefault()
      if (this.spellidTarget.value ==="") {
        console.log("value empty")
        this.formTarget.classList.add("giggle")
        setTimeout(() => {
          this.formTarget.classList.remove("giggle");
        }, 1000);

      } else {
        this.formTarget.submit()
      }
    }
  }
