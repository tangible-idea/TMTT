import logo from '../logo.svg';
import firebase from "../firebase"
//import Router from '../routes/Router';
import Home from './Home';
import AppRouter from '../routes/Router'

console.log(firebase);

function App() {
  return (
    <AppRouter />
  );
}

export default App;
