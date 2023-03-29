import consumer from "channels/consumer"

document.addEventListener("turbo:load", findMessagesObject);

function findMessagesObject() {
    const m = document.querySelectorAll("#messages");
    if (m.length > 0) {
        createRoomChannel(m[0].dataset["roomId"], m[0]);
    }
}

function createRoomChannel(roomId, messages_holder) {
    const channelRoom = consumer.subscriptions.create({channel: "RoomChannel", room: roomId}, {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            messages_holder.insertAdjacentHTML("beforeend", data["message"]);
            messages_holder.scrollTop = messages_holder.scrollHeight;
        }
    });

    messages_holder.scrollTop = messages_holder.scrollHeight;

    const textarea = document.querySelector("#message_body");

    textarea.addEventListener("keypress", (event) => {
        if (event.keyCode != 13) return false;

        event.preventDefault();
        let message = event.target.value.replace("\n","").trim();

        if (message == "") return false;

        channelRoom.send({message: message});
        event.target.value = "";
        OnInput(event);
    });

    textarea.setAttribute("style", "height:" + (textarea.scrollHeight) + "px;overflow-y:hidden;");
    textarea.addEventListener("input", OnInput, false);
}

function OnInput(event) {
    event.target.style.height = 0;
    event.target.style.height = (event.target.scrollHeight) + "px";
}
