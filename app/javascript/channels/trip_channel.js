import consumer from "./consumer";

const initTripCable = () => {
  const messagesContainer = document.getElementById('messages');
  // console.log("file imported?")
  if (messagesContainer) {
    const id = messagesContainer.dataset.tripId;

    consumer.subscriptions.create({ channel: "TripChannel", id: id }, {
      received(data) {
        // console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initTripCable };
