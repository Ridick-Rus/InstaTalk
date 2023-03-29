import consumer from "channels/consumer"

if (document.readyState === "complete") {
    connectToOnlineChannel();
} else {
    window.addEventListener("load", connectToOnlineChannel);
}

function connectToOnlineChannel() {
    consumer.subscriptions.create("OnlineChannel", {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            let usersBox = document.querySelector("#users");
            if (!usersBox) return false;

            if (data.user.is_online) {
                this.addUser(usersBox, data.user);
            } else {
                this.removeUser(usersBox, data.user.id);
            }
        },

        addUser(usersBox, user) {
            if (usersBox.querySelector(`#user_id_${id}`)) return;

            let element = `<span id="user_id_${user.id}">[ <span class="user">${user.nickname}</span> ]</span>`
            usersBox.insertAdjacentHTML("beforeend", element);
        },

        removeUser(usersBox, id) {
            let user = usersBox.querySelector(`#user_id_${id}`);
            usersBox.removeChild(user);
        }
    });
}
