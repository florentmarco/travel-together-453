import { Controller } from "stimulus"

let statusArr = ["Pending", "Approved", "Booked"]
let categoryArr = ["Itinerary", "Flight", "Accommodation", "Activity"]

const statusArrUpdate = (filterParams) => {
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
  static targets = [ "items"]

  connect() {
    console.log('connected')
  }

  pending(event) {
    event.preventDefault();
    statusArrUpdate("PENDING")
    fetchStatusResults(this)
  }

  approved(event) {
    event.preventDefault();
    statusArrUpdate("APPROVED")
    fetchStatusResults(this)
  }

  booked(event) {
    event.preventDefault();
    statusArrUpdate("BOOKED")
    fetchStatusResults(this)
  }

  clearActive() {
    document.querySelectorAll('.tab-underlined').forEach(tab => {
      tab.classList.remove('active');
    })
  }

  itinerary(event) {
    event.preventDefault();
    this.clearActive();
    event.target.classList.add('active');
    categoryArr = ["Flight", "Accommodation", "Activity"];
    statusArr = ["Booked"];
    fetchStatusResults(this)
  }

  flight(event) {
    event.preventDefault();
    this.clearActive();
    event.target.classList.add('active');
    categoryArr = ["Flight"]
    statusArr = ["Pending", "Approved", "Booked"]
    fetchCategoryResults(this)
  }

  accommodation(event) {
    event.preventDefault();
    this.clearActive();
    event.target.classList.add('active');
    categoryArr = ["Accommodation"];
    statusArr = ["Pending", "Approved", "Booked"];
    fetchCategoryResults(this)
  }

  activity(event) {
    event.preventDefault();
    this.clearActive();
    event.target.classList.add('active');
    categoryArr = ["Activity"];
    statusArr = ["Pending", "Approved", "Booked"];
    fetchCategoryResults(this)
  }
}
