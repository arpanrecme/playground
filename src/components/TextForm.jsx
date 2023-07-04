import {useState} from "react";

export default function TextForm() {
    const handleUpClick = () => {
        let newText = text.toUpperCase();
        setText(newText);
    }

    const handleLowClick = () => {
        let newText = text.toLowerCase();
        setText(newText);
    }

    const handleClearClick = () => {
        setText("");
    }

    const onChange = (event) => {
        setText(event.target.value)
    }

    const [text, setText] = useState("Enter text here");
    return (<>
        <div className="container my-3">
            <label htmlFor="exampleFormControlTextarea1" className="form-label">Example text area</label>
            <textarea className="form-control" id="exampleFormControlTextarea1" value={text} onChange={onChange} rows="10"></textarea>
            <button type="button" className="btn btn-primary my-3 mx-2" onClick={handleUpClick}>Convert to Uppercase</button>
            <button type="button" className="btn btn-primary my-3 mx-2" onClick={handleLowClick}>Convert to Lowercase</button>
            <button type="button" className="btn btn-primary my-3 mx-2" onClick={handleClearClick}>Clear text</button>
        </div>
        <div className="container">
            <h2>Your text summary</h2>
            <p>{text.split(" ").length} words and {text.length} characters</p>
            <p>{0.008 * text.split(" ").length} Minutes read</p>
            <h2>Preview</h2>
            <p>{text}</p>
        </div>
    </>);
}