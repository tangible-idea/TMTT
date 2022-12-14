import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
    apiKey: "AIzaSyBuhgwdGwDKeJb-ThEUK5Vqibn43Qhpm8k",
    authDomain: "ttmt-56b3b.firebaseapp.com",
    projectId: "ttmt-56b3b",
    storageBucket: "ttmt-56b3b.appspot.com",
    messagingSenderId: "982782530678",
    appId: "1:982782530678:web:5f8fac77aa1d671b0a3b57",
    measurementId: "G-8Q21B16TVV"
  };

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
export default app;