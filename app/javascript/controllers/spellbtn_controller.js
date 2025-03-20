import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spellbtn"
export default class extends Controller {
  connect() {
  }

  fire (event){
    event.preventDefault(); // Annule toute action par défaut (utile si c'est un lien)
    event.stopPropagation(); // Empêche l'événement de remonter aux parents
    event.stopImmediatePropagation(); // Empêche tout autre gestionnaire de cet événement de s’exécuter


    const modalId = `modal_${this.element.id.split("_")[1]}`;
    const modalElement = document.getElementById(modalId);

    if (modalElement) {
      const modal = new bootstrap.Modal(modalElement);
      modal.show();
    }
  }
}
