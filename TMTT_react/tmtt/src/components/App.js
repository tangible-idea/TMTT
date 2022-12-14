import logo from 'logo.svg';
import firebase from "myfirebase"
import Home from 'components/Home';
import AppRouter from 'routes/Router'

console.log(firebase);

function App() {
  return (
    <AppRouter />
  );
}

export default App;
