import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
import 'bootstrap/dist/js/bootstrap.bundle.min';
import Navbar from "./components/Navbar";
import TextForm from "./components/TextForm";
import About from "./components/About";


function App() {
    return (
        <>  <Navbar title="easyIAC1"/>
            <TextForm/>
            <About/>
        </>
    );
}

export default App;
