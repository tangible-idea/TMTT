import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
//import { user } from 'firebase-functions/v1/auth';
// import * as firebase from 'firebase';
// import firebase from 'firebase/app'
// import 'firebase/firestore'
// import * as moment from 'moment';
// const { getAuth } = require("firebase-admin/auth");
// const {PubSub} = require("@google-cloud/pubsub");
//import * as dateutils from './dateUtils';
//import * as email from './email';


admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties:true});
const db = admin.firestore();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
// a simple sample
export const helloWorld1= functions.https.onRequest((request, response) => {
    console.log("received data: "+ request.query.name);
    response.send("{'result':'Hello "+ request.query.name +" from Firebase!'}" );
});

// for sending email
//const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});


// function sendPushMultiFromAdmin(
//     listUsers : String[],
//     title: String,
//     message: String) {
//         if(!(message && title)) {
//             console.log(`there is no content of title or message, ${title}, ${message}`);
//             return"{'result':'there is no content of title or message.'}"
//         }
//     return"{}";
// }

function sendPushNonEx(
    senderUid:any,
    targetUid:any,
    title   : any,
    message   : any) {
        console.log("sendPush v1.18.2");

        if(!(message && title)) {
            console.log(`there is no content of title or message, ${title}, ${message}`);
            return"{'result':'there is no content of title or message.'}"
        }

        // console.log(`received uid: ${uuid}`);
        // console.log("received message: "+ req.query.message);

        db.collection('users').doc(`${targetUid}`).get()
        .then((queryA) => {
            var userData= queryA.data()
            if(userData == undefined) {
                console.log('no corresponding uid data of : ' + targetUid);
                return"{'result':'no corresponding uid data'}";
            }
            console.log(`sendPush::send to userID: ${userData.document_id}, push_token: ${userData.push_token}`);

            // See documentation on defining a message payload.
            const mymessage = {
              notification: { title: `${title}`, body: `${message}` },
              token: userData.push_token,
            };

            //var saved_token= `${userData.push_token}`;
            //console.log("his token: " + saved_token);

            admin.messaging().send(mymessage).then((response) => {
            //admin.messaging().sendToDevice(saved_token, payload).then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return"{'result':'successful'}";
              })
              .catch((error) => {
                console.log('Error sending message:', error);
                return"{'result':'error'}";
              });
            return "";
        })
        .catch((error) => {
            console.log("Error getting documents: ", error);
            return "{'result':'Error getting documents'}";
        });
        
        return "";
    }


/**
 * 서버에서 개인 push 전송.
 * @param {uid} : 
 * @param {message} : 
 */
export const sendPush= functions.https.onRequest((req, res) => {
    cors(req, res, () => {
        
        const targetUid = req.query.targetUid;
        const senderUid = req.query.senderUid;
        const title = req.query.title;
        const message = req.query.message;
        
        const resultToSend= sendPushNonEx(senderUid, targetUid, title, message);
        res.send(resultToSend);
    });
});

// 인증이메일 전송 후 인증과정
export const authEmail = functions.https.onRequest((req, res) => {
    // getting dest email by query string
    const user = req.query.user;
    const code = req.query.code;

    console.log("requested user: ", user);
    console.log("requested code: ", code);
    
    // Retrieve my account..
    db.collection("users").where("email", "==", user)
        .get()
        .then((queryAccount) => { 
            queryAccount.forEach((docAccount) => {
                console.log("current workemail: ", docAccount.data().workemail);
                console.log("current workemail verified?: ", docAccount.data().workemail_verified);

                // if the verification codes are matched:
                if(code == docAccount.data().workemail_verification_code) {
                    // update workemail to verified.
                    docAccount.ref.update({ workemail_verified: true, workemail_verification_code:'' });
                    return res.send('Your email has successfully been verified!');
                } else {
                    return res.send('Failed to verify your email. please try it again later.');
                }

            });
        })
        .catch((error) => {
            console.log("Error getting documents: ", error);
        });
});