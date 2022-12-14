 import React, {useState, Fragment} from "react";
 import { BrowserRouter, HashRouter as Router, Route, Routes} from "react-router-dom";
 import Home from "components/Home";
 import MyProfile from "./Profile";

 const AppRouter= () => {
    //const [isLoggedIn, setIsLoggedIn]= useState(false);
    return (
        
        <BrowserRouter>
            <Fragment>
            <Routes>
                <Route exact path='/' element={<Home/>}/>
                <Route path=":id" element={<MyProfile/>} />
            </Routes>
            </Fragment>
        </BrowserRouter>
        
        );
 }
 export default AppRouter;