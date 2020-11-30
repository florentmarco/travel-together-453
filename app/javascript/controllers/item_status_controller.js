import { Controller } from "stimulus"

let statusArr = ["Pending", "Approved", "Booked"]
let categoryArr = ["Flight", "Acommodation", "Activity"]

const trigger = (filterParams) => {
  if (statusArr.includes(filterParams)){
      const index = statusArr.indexOf(filterParams)
      statusArr.splice(index, 1);
    } else {
      statusArr.push(filterParams);
    }
}

const fetchCategoryResults = (action) => {
  // url = trip_items_path(@trip)
  const url = action.data.get('url') + "?category=" + categoryArr.join(" ")
  fetch(url)
    .then(res => res.text())
    .then(data => {
      action.itemsTarget.innerHTML = data;
    });
}

const fetchStatusResults = (action) => {
  // url = trip_items_path(@trip)
  const url = action.data.get('url') + "?status=" + statusArr.join(" ") + "&category=" + categoryArr.join(" ")
  fetch(url)
    .then(res => res.text())
    .then(data => {
      action.itemsTarget.innerHTML = data;
    });
}

export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    console.log('connected')
  }

  pending(event) {
    event.preventDefault();
    trigger("Pending")
    fetchStatusResults(this)
  }

  approved(event) {
    event.preventDefault();
    trigger("Approved")
    fetchStatusResults(this)
  }

  booked(event) {
    event.preventDefault();
    trigger("Booked")
    fetchStatusResults(this)
  }

  flight(event) {
    event.preventDefault();
    categoryArr = ["Flight"]
    fetchCategoryResults(this)
  }

  accommodation(event) {
    event.preventDefault();
    categoryArr = ["Accommodation"]
    fetchCategoryResults(this)
  }

  activity(event) {
    event.preventDefault();
    categoryArr = ["Activity"]
    fetchCategoryResults(this)
  }
}
