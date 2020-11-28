import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    console.log('connected')
  }

  pending(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?pending=1';
    console.log(url)
    console.log(this.itemsTarget);
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }

  approved(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?approved=1';
    console.log(url)
    console.log(this.itemsTarget);
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }

  booked(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?booked=1';
    console.log(url)
    console.log(this.itemsTarget);
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }
}
