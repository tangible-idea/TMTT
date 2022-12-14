import React, { useEffect } from "react";
import { useParams } from "react-router-dom";
import { collection, doc, getDocs, query, where } from "firebase/firestore"; 
import "myfirebase";
import { dbService } from "myfirebase";

const MyProfile = ()=> {

    const params = useParams();

    const getProfile = async()=> {
        //const docRef = doc(dbService, "users", params.id);
        const q = query(collection(dbService, "users"), where("slug_id", "==", params.id));

        const querySnapshot = await getDocs(q);
        querySnapshot.forEach((doc) => {
            // doc.data() is never undefined for query doc snapshots
            //console.log(doc.id, " => ", doc.data());
            console.log(doc.data()["message"]);
            console.log(doc.data()["profile_image"]);
        });
    }
    useEffect(()=> {
        getProfile();
    }, []);
    


    
    return (
        <div>
            <span>ID: {params.id}</span>
        </div>
    )
}
export default MyProfile;