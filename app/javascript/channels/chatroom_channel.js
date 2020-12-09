import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  console.log("file imported?");
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        // console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('afterbegin', data);
      },
    });
  }
}

export { initChatroomCable };
