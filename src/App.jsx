import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min";
import Navbar from "./components/Navbar";
import TextForm from "./components/TextForm";
import About from "./components/About";
import {useState} from "react";

export default function App() {
    const [lightDarkMode, setLightDarkMode] = useState("light");
    const toggleLightDarkMode = () => {
        if (lightDarkMode === "light") {
            document.body.style.backgroundColor = "grey";
            setLightDarkMode("dark");
        } else {
            document.body.style.backgroundColor = "white";
            setLightDarkMode("light");
        }
    };
    return (
        <>
            <Navbar
                title="easyIAC1"
                lightDarkMode={lightDarkMode}
                toggleLightDarkMode={toggleLightDarkMode}
            />
            <TextForm/>
            <About/>
        </>
    );
}
