import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import ReactRoundedImage from "react-rounded-image";

import "./Profile.css";

import { collection, doc, getDocs, query, where } from "firebase/firestore"; 
import { dbService } from "myfirebase";

const MyProfile = ()=> {

    const params = useParams();
    const [profileImage, setprofileImage]= useState("");
    const [questionMessage, setQuestionMessage]= useState("");

    const getProfile = async()=> {
        //const docRef = doc(dbService, "users", params.id);
        const q = query(collection(dbService, "users"), where("slug_id", "==", params.id));

        const querySnapshot = await getDocs(q);
        querySnapshot.forEach((doc) => {
            // doc.data() is never undefined for query doc snapshots
            //console.log(doc.id, " => ", doc.data());
            //console.log(doc.data()["message"]);
            //console.log(doc.data()["profile_image"]);
            setprofileImage(doc.data()["profile_image"]);
            setQuestionMessage(doc.data()["message"]);
        });
    }
    useEffect(()=> {
        getProfile();
    }, []);
    


    
    return (
        <div>
            
        
            <div class="imageProfile">
                <ReactRoundedImage
                    image={profileImage}
                    roundedColor="#DDDDDD"
                    imageWidth="100"
                    imageHeight="100"
                    roundedSize="2"/>
            </div>
            <div class="whiteborder">
                <form>
                <h3>@{params.id}</h3>
                <span class="question">{questionMessage}</span>
                <textarea class="inputMessage"
                    placeholder="Send me an anonymous message..."/>
                </form>
            </div>
        </div>
    )
}
export default MyProfile;