import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "heart", "count" ]

  connect() {
    console.log('connected')
  }

  voting(event) {
    event.preventDefault();
    this.voteStatusUpdate(event)
  }

  voteStatusUpdate(event) {
    if (this.heartTarget.className == "voted"){
      this.heartTarget.classList.remove("voted")
      this.heartTarget.classList.add("unvoted")
      this.fetchRemoveVoteResult(event)
    } else {
      this.heartTarget.classList.remove("unvoted")
      this.heartTarget.classList.add("voted")
      this.fetchAddVoteResult(event)
    }
  }

  fetchAddVoteResult (event) {
    const csrf_token = document.querySelector('meta[name="csrf-token"]').content;
    const str = event.target.dataset.item.split(",")
    const url = "/trips/" + str[0] + "/items/" + str[1] + "/votes"
    fetch(url, {
      headers: {
        accept: 'application/json',
        "X-CSRF-Token": csrf_token
      },
      method: "POST"
    })
    .then(response => response.json())
    .then(data => {
      this.countTarget.innerText = data.votecount.length;
    });
  }

  // data-item="/trips/<%= item.trip.id %>/items/<%= item.id %>/votes"
  // "[<%= item.trip.id %>,<%= item.id %>]"

  fetchRemoveVoteResult = (event) => {
    const csrf_token = document.querySelector('meta[name="csrf-token"]').content;
    const str = event.target.dataset.item.split(",")
    const url = "/votes/" + str[1]
    fetch(url, {
      headers: {
        accept: 'application/json',
        "X-CSRF-Token": csrf_token
      },
      method: "DELETE"
    })
    .then(response => response.json())
    .then(data => {
      this.countTarget.innerText = data.votecount.length;
    });
  }
}

// data-item="/votes/<%= item.id %> "
