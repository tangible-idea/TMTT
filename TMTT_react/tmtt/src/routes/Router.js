 import React, {useState, Fragment} from "react";
 import { HashRouter as Router, Route, Routes} from "react-router-dom";
 import Home from "../components/Home";
 import MyProfile from "./Profile";

 const AppRouter= () => {
    //const [isLoggedIn, setIsLoggedIn]= useState(false);
    return (
        
        <Router>
            <Fragment>
            <Routes>
                <Route exact path='/' element={<Home/>}/>
            </Routes>
            </Fragment>
        </Router>
        // <Router>
        //     <Routes>
        //         <Route path="/" element={<Home/>}/>
        //     </Routes>
        // </Router>
        );
 }
 export default AppRouter;