import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spell"
export default class extends Controller {
  connect() {
console.log("hello from spell cont")

  }
}






/*   document.addEventListener('DOMContentLoaded', function() {
    const spells = document.querySelectorAll('.spell');

    spells.forEach(card => {
      spell.addEventListener('click', function() {
        // Retirer la classe 'selected' de toutes les cartes
        spells.forEach(c => c.classList.remove('selected'));

        // Ajouter la classe 'selected' à la carte cliquée
        spell.classList.add('selected');
      });
    });
  });
 */
