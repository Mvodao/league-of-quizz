import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["overlay"];

  connect() {
    console.log("overlay connected")
    // this.overlayTarget.classList.add("hiddenanim");

    // // Sélectionne tous les liens et boutons qui ne possèdent pas déjà un data-action lié au clic
    // document.querySelectorAll("a, button").forEach((element) => {
    //   if (!element.dataset.action || !element.dataset.action.includes("click->")) {
    //     element.dataset.action = "click->transition#transitionOut";
    //   }
    // });
  }

  transitionOut(event) {
    console.log("transitionOut")
    event.preventDefault();
    const url = event.currentTarget.href;

    this.overlayTarget.classList.remove("hiddenanim");
    this.overlayTarget.classList.add("closing-vortex");

    setTimeout(() => {
      window.location.href = url;
    }, 2000); // Durée de l'animation
  }

  transitionIn() {
    console.log("transitionIn")
    this.overlayTarget.classList.remove("hiddenanim");
    this.overlayTarget.classList.add("opening-vortex");

    setTimeout(() => {
      this.overlayTarget.classList.add("hiddenanim");
      this.overlayTarget.classList.remove("opening-vortex");
    }, 2000);
  }
}
