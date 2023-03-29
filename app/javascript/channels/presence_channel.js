import consumer from "channels/consumer"

if (document.readyState === "complete") {
    connectToPresenceChannel();
} else {
    window.addEventListener("load", connectToPresenceChannel);
}

function connectToPresenceChannel() {
    consumer.subscriptions.create("PresenceChannel");
}
