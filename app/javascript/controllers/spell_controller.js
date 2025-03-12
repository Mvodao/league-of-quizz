import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spell"
export default class extends Controller {
  connect() {
    const cards = document.querySelectorAll('.spell-card');
    cards.forEach(card => {
      card.addEventListener("click",(event) => {
        if (card.classList.contains("card-selected")) {
          card.classList.remove("card-selected")
        } else {
          card.classList.add("card-selected");
        }
        cards.forEach(element => {

          if (element !== card) {
            element.classList.remove("card-selected");
          }
        });
      })
      })
    }
  }
