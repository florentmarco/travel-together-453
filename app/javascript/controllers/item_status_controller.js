import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    console.log('connected')
  }

  filter(e) {
    e.preventDefault();
    const url = this.data.get('url') + '?pending=1';
    console.log(url)
    console.log(this.itemsTarget);
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.itemsTarget.innerHTML = data;
      });
  }
}
