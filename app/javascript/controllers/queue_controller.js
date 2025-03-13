import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="queue"
export default class extends Controller {
  static targets = [
    "playerwrapper",
    "playertitle",
    "playercharacter",
    "find",
    "cancel",
    "challengerimage",
    "challengerwrapper",
    "challengertitle",
    "challengercharacter",
    "foundButton" // Nouveau bouton cible
  ];

  connect() {
    console.log("queue controller connected");
  }

  find_opponent(event) {
    // Ajoute les animations initiales
    this.playertitleTarget.classList.add("toggle");
    this.playercharacterTarget.classList.add("toggle");
    this.playerwrapperTarget.classList.add("rotating-wrapper");
    this.findTarget.innerText = "Searching...";
    this.findTarget.classList.add("btn-hover");
    this.cancelTarget.innerText = "X";
    this.cancelTarget.classList.remove("d-none");

    // Simule la recherche d'un adversaire avec un délai
    this.timeOut = setTimeout(() => {
      // Mise à jour de l'animation pour signaler qu'un adversaire est trouvé
      this.findTarget.innerText = "Opponent Found!";
      this.findTarget.classList.add("d-none"); // Masque le bouton "Searching..."
      this.cancelTarget.classList.add("d-none"); // Masque le bouton "Cancel"
      this.challengerimageTarget.classList.remove("empty-cover-image");
      this.challengerimageTarget.classList.add("cover-image");
      this.challengerimageTarget.style.transform = "rotateY(3.142rad)";
      this.challengertitleTarget.classList.add("toggle");
      this.challengercharacterTarget.classList.add("toggle");
      this.challengerwrapperTarget.classList.add("rotating-wrapper-challenger");
      this.challengertitleTarget.classList.add("opponent-title");
      this.challengertitleTarget.classList.remove("challenger-waiting-title");
      this.challengertitleTarget.innerText = "Wise Mage";

      // Affiche le bouton "Opponent Found!" une fois l'animation terminée
      this.foundButtonTarget.classList.remove("d-none");
    }, 2000); // Délai de 2 secondes
  }

  cancel(event) {
    // Réinitialise toutes les animations si l'utilisateur annule
    this.playertitleTarget.classList.remove("toggle");
    this.playercharacterTarget.classList.remove("toggle");
    this.playerwrapperTarget.classList.remove("rotating-wrapper");
    this.findTarget.innerText = "Finding an opponent";
    this.findTarget.classList.remove("btn-hover");
    this.cancelTarget.innerText = "";
    this.cancelTarget.classList.add("d-none");

    // Réinitialise l'état visuel des éléments de l'adversaire
    this.challengerimageTarget.classList.add("empty-cover-image");
    this.challengerimageTarget.classList.remove("cover-image");
    this.challengertitleTarget.classList.remove("toggle");
    this.challengercharacterTarget.classList.remove("toggle");
    this.challengerwrapperTarget.classList.remove("rotating-wrapper-challenger");
    this.challengertitleTarget.classList.remove("opponent-title");
    this.challengertitleTarget.classList.add("challenger-waiting-title");
    this.challengertitleTarget.innerText = "No worthy opponent yet.";

    // Masque le bouton "Opponent Found!"
    this.foundButtonTarget.classList.add("d-none");

    clearTimeout(this.timeOut); // Annule tout délai en cours
  }
}
