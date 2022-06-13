const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);




exports.topicTrigger = functions.firestore.document('positive/{positiveId}').onCreate(async(snapshot,context)=>{
    if (snapshot.empty){
        console.log('No Devices');
        return; 
    }
    var newData = snapshot.data;
    var payload = {
        notification : {
            title: 'new positive covid case',
            body:`${newData.Name} has covid`,
            sound: 'default'

        },
        data: {click_action: 'FLUTTER_NOTIFICATION_CLICK', message:`${newData.Name} has covid`}
    };
    try {
        const response = await admin.messaging().sendToTopic('positive', payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
    
    
    
    
});

exports.deviceTrigger = functions.firestore.document('positive/{positiveId}').onCreate(async(snapshot,context)=>{
    if (snapshot.empty){
        console.log('No Devices');
        return; 
    }
    var newDatap = snapshot.data;

    const deviceIdTokens = await admin
        .firestore()
        .collection('DeviceIDTokens')
        .get();
 
    var tokens = [fHDlkWob2jUAPA91bHXg_3irZMYHeOzn7nHOLKDcRyMA67EXbm6_inivRa6PKg9As];
    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().device_token);
    }
    var payload = {
        notification: {
            title: 'Push Title',
            body: 'Push Body',
            sound: 'default',
        },
        data: {
            push_key: 'Push Key Value',
            key1: newDatap.data,
        },
    };
 
    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
});



// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
