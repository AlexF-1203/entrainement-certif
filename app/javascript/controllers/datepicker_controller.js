// app/javascript/controllers/datepicker_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = {
    bookedDates: Array
  }

  connect() {
    this.setMinDate()
    this.setupDateInput()
  }

  setMinDate() {
    // Empêcher la sélection de dates passées
    const today = new Date().toISOString().split('T')[0]
    this.inputTarget.min = today
  }

  setupDateInput() {
    const input = this.inputTarget
    const bookedDates = this.bookedDatesValue

    // Désactiver les dates réservées
    input.addEventListener('input', (e) => {
      const selectedDate = e.target.value
      if (bookedDates.includes(selectedDate)) {
        e.target.value = ''
        alert('Cette date est déjà réservée')
      }
    })

    // Style pour les dates désactivées
    const style = document.createElement('style')
    style.textContent = `
      .booked-date {
        background-color: #f5f5f5 !important;
        color: #ccc !important;
        cursor: not-allowed !important;
        pointer-events: none !important;
      }
    `
    document.head.appendChild(style)

    // Gérer l'affichage du calendrier
    input.addEventListener('click', () => {
      setTimeout(() => {
        // Trouver tous les jours dans le calendrier
        const dateElements = document.querySelectorAll('[role="gridcell"]')
        dateElements.forEach(dateElement => {
          const date = dateElement.getAttribute('data-date')
          if (date && bookedDates.includes(date)) {
            dateElement.classList.add('booked-date')
          }
        })
      }, 50)
    })
  }
}
