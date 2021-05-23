const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

 exports.onCreateNotification = functions.firestore.document('/notifications/{notificationDoc}').onCreate(async (notifSnapshot, context) => {
    var tokens = notifSnapshot.data()['tokens'];
    var title = notifSnapshot.data()['info'];
    console.log(title);

    var body = title + 'is at the door!';

    tokens.forEach(async eachToken =>{
        const message = {
            notification: {title: title, body: body},
            token: eachToken,
            data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'},
        }

        admin.messaging().send(message).then(response => {
            return console.log('successful notif');
        }).catch(error =>{
            return console.log('error:' + error);
        });
    });

 });