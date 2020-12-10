import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "category", "form" ];

  serve(event) {
    const category = event.target.dataset.item
    console.log(category)
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
