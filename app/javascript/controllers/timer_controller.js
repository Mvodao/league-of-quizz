import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { duration: Number }
  static targets = ["timer"]

  connect() {
    this.startTime = this.durationValue; // Temps initial en secondes
    this.updateTimer();
    this.interval = setInterval(() => {
      this.tick();
    }, 1000);
  }

  tick() {
    if (this.startTime > 0) {
      this.startTime -= 1;
      this.updateTimer();
    } else {
      clearInterval(this.interval);
      this.timeUp(); // Action lorsque le temps est écoulé
    }
  }

  updateTimer() {
    this.timerTarget.textContent = `${this.startTime} secondes restantes`;
  }

  timeUp() {
    alert("Temps écoulé !");
    // Rediriger ou désactiver les réponses ici
    // window.location.href = "/path_to_redirect";
  }

  disconnect() {
    clearInterval(this.interval);
  }
}
