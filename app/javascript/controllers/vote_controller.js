import { Controller } from "stimulus"

const voteStatusUpdate = (controller, event) => {
  if (controller.heartTarget.className == "voted"){
      controller.heartTarget.classList.remove("voted")
      controller.heartTarget.classList.add("unvoted")
      fetchResult(event)
    } else {
      controller.heartTarget.classList.remove("unvoted")
      controller.heartTarget.classList.add("voted")
      fetchResult(event)
    }
}

const fetchResult = (event) => {
  const url = event.target.dataset.item
  fetch(url, { headers: { accept: 'application/json' } })
  .then(response => response.json())
  .then(data => {
    // console.log(data);
    this.countTarget.innerText = data.votecount.length;
  });
}

export default class extends Controller {
  static targets = [ "heart", "count" ]

  connect() {
    console.log('connected')
  }

  voting(event) {
    event.preventDefault();
    voteStatusUpdate(this, event)
  }
}
