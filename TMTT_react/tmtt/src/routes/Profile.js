import React from "react";
import { useParams } from "react-router-dom";
//import { collection, doc, getDoc } from "firebase/firestore"; 
//import "myfirebase";
//import { dbService } from "myfirebase";
//import firebase from "firebase";

const MyProfile = () => {

    const params = useParams();
    //const docRef = doc(dbService, "users", params.id);
    //const docSnap = await getDoc(docRef);

    return (
        <div>
            <span>{params.id}</span>
        </div>
    )
}
export default MyProfile;