import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
admin.initializeApp();

//const db = admin.firestore();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('positive/{positiveId}')
  .onCreate(async snapshot => {
    const positive = snapshot.data();
  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: 'New Positive Case',
      body: `${positive.name} is positive with covid-19`,
      
      click_action: 'FLUTTER_NOTIFICATION_CLICK'
    }
  };
  return fcm.sendToTopic('positive', payload);
});