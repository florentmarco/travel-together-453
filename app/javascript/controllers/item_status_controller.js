import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    console.log('connected')
  }

  flight(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?flight=1';
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }

  accommodation(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?accommodation=1';
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }

  activity(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?activity=1';
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }

  pending(event) {
    event.preventDefault();
    // trip_items_path(@trip)
    const url = this.data.get('url') + '?pending=1';
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
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }
}
