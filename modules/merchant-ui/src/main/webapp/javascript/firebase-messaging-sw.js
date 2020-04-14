importScripts('https://www.gstatic.com/firebasejs/7.7.0/firebase-app.js')
importScripts('https://www.gstatic.com/firebasejs/7.7.0/firebase-messaging.js');


var firebaseConfig = {
    apiKey: "AIzaSyD7UuAsTH0xvpbIdom2B8nDZlSCsQ0qboE",
    authDomain: "web-notification-23a37.firebaseapp.com",
    databaseURL: "https://web-notification-23a37.firebaseio.com",
    projectId: "web-notification-23a37",
    storageBucket: "web-notification-23a37.appspot.com",
    messagingSenderId: "728885083705",
    appId: "1:728885083705:web:4e2b3cf68b4c1df5ff97e8",
    measurementId: "G-CK6M61Y27W"
};
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

