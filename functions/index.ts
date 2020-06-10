import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

//const db = admin.firestore();
const fcm = admin.messaging();
export const sendToTopic = functions.firestore
  .document('clouddata/{docId}')
  .onCreate(async snapshot => {
    const doc = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'New Assignment Uploaded',
        body: `${doc.title}`,
        click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
      }
    };

    return fcm.sendToTopic('clouddata', payload);
  });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
