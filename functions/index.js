const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

 exports.onCreateNotification = functions.firestore.document('/notifications/{notificationDoc}').onCreate(async (notifSnapshot, context) => {
    var tokens = notifSnapshot.data()['tokens'];
    var guestInfo = notifSnapshot.data()['info'];
    var title = 'Ding Dong!'
    var body = 'You have a visitor!';
    if(guestInfo != '') {
        body = `${guestInfo} is at the door!`;

    }

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