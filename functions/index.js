const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();

exports.resetConsQueue = functions.pubsub.schedule("0 4 * 2 *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("cons_queue").get()
          .then((querySnapshot) => {
            querySnapshot.forEach((docSnapshot) =>{
              promises.push(docSnapshot.ref.delete());
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetMAQueue = functions.pubsub.schedule("0 4 * 2 *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("ma_queue").get()
          .then((querySnapshot) => {
            querySnapshot.forEach((docSnapshot) =>{
              promises.push(docSnapshot.ref.delete());
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetMARequest = functions.pubsub.schedule("0 4 * 2 *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("ma_request").get()
          .then((querySnapshot) => {
            querySnapshot.forEach((docSnapshot) =>{
              promises.push(docSnapshot.ref.delete());
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetConsRequest = functions.pubsub.schedule("0 4 * 2 *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("cons_request").get()
          .then((querySnapshot)=> {
            querySnapshot.forEach((doc) =>{
              promises.push(doc.ref.delete());
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetConsStatus = functions.pubsub.schedule("0 4 * * *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("cons_status").get()
          .then((querySnapshot) =>{
            querySnapshot.forEach((document) =>{
              promises.push(document.ref.update({"consSlot": parseInt(0),
                "consRqstd": parseInt(0), "qLastNum": parseInt(0)}));
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetDocAsOffline = functions.pubsub.schedule("0 4 * * *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("doctors").get()
          .then((querySnapshot) =>{
            querySnapshot.forEach((document)=> {
              promises.push(database.doc("doctors/"+document.data().userID+
                "/status/value").update({"dStatus": false}));
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetPatientConsStatus = functions.pubsub.schedule("0 4 * * *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("patients").get()
          .then((querySnapshot) =>{
            querySnapshot.forEach((document)=> {
              promises.push(database.doc("patients/"+document.data().userID+
                  "/status/value")
                  .update({"hasActiveQueueCons": false}));
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetPatientMAStatus = functions.pubsub.schedule("0 4 * 2 *")
    .timeZone("Asia/Singapore")
    .onRun(()=>{
      const promises = [];
      return database.collection("patients")
          .get().then((querySnapshot) =>{
            querySnapshot.forEach((document)=> {
              promises.push(database.doc("patients/"+
                  document.data().userID+"/status/value")
                  .update({"hasActiveQueueMA": false}));
            });
            return Promise.all(promises);
          })
          .catch((error) => {
            console.log(error);
            return false;
          });
    });

exports.resetPSWDMAStatus = functions.pubsub.schedule("0 4 * * *")
    .timeZone("Asia/Singapore")
    .onRun((context)=>{
      database.doc("pswd_status/status").update({"isCutOff": true,
        "maRequested": parseInt(0), "qLastNum": parseInt(0)});
      return console.log("TEST IF NAG RUN BAG 4AM Reset Done Running");
    });

