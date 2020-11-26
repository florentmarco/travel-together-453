import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "type", "form" ];

// need to insert 'action' in function 'serve()'
  serve() {

    if (flight) {
      this.formTarget.textContent =
      `Hello, ${this.typeTarget.value}!`
    } else if (accomodation ) {
      this.formTarget.textContent =
      `Hello, ${this.typeTarget.value}!`
    } else {
      this.formTarget.textContent =
      `Hello, ${this.typeTarget.value}!`
    }
  }
}
