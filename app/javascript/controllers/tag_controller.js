import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "booked", "confirmButton"]

  connect() {
    console.log('tag connected')
  }

  change_to_booked(event) {
    event.preventDefault();
    const csrf_token = document.querySelector('meta[name="csrf-token"]').content;
    const url = event.target.dataset.item;
    console.log(url)
    fetch(url, {
      headers: {
        accept: 'application/json',
        "X-CSRF-Token": csrf_token
      },
      method: "PATCH"
    })
    this.bookedTarget.className = "booked-tag";
    this.bookedTarget.innerText = "Booked";
    this.confirmButtonTarget.classList.add("disabled");
  }
}
