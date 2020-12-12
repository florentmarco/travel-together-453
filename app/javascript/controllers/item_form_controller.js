import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "category", "form" ];

  connect() {
    this.loadForm('Flight');
  }

  serve(event) {
    const category = event.target.dataset.item
   this.loadForm(category);
  }

  loadForm(category) {
    const url = this.data.get("url") + "?category=" + category
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.formTarget.innerHTML = data ;
        flatpickr(".datepicker", {
            minDate: "today",
            enableTime: true,
        });
      }
    )
  }
}
