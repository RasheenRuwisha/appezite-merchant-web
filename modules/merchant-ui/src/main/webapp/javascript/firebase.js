var firebaseConfig = {
    apiKey: "AIzaSyCjtrgCKde_sTEN-I_7z9Rp8oUhKRNT-cc",
    authDomain: "notifications-13351.firebaseapp.com",
    databaseURL: "https://notifications-13351.firebaseio.com",
    projectId: "notifications-13351",
    storageBucket: "notifications-13351.appspot.com",
    messagingSenderId: "581287295658",
    appId: "1:581287295658:web:7c5fd724f5e10e006a6ed3",
    measurementId: "G-11CEV0GFYZ"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging()
navigator.serviceWorker.register('/merchant/resources/javascript/firebase-messaging-sw.js')
    .then((registration) => {
        messaging.useServiceWorker(registration);
        messaging
            .requestPermission()
            .then(function () {
                console.log(messaging.getToken());
                return messaging.getToken();
            })
            .then(function (token) {
                console.log(token);
            })
            .catch(function (err) {
                console.log("no permission");
                1
            });

        messaging.onTokenRefresh(() => {
            messaging
                .getToken()
                .then((refreshedToken) => {
                    console.log('Token refreshed.');
                })
                .catch((err) => {
                    console.log('Unable to retrieve refreshed token ', err);
                    showToken('Unable to retrieve refreshed token ', err);
                });
        });
    });

