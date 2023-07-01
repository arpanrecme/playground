import React from "react";

export default function TextForm() {
    return (<>
        <div className="container my-3">
            <label htmlFor="exampleFormControlTextarea1" className="form-label">Example textarea</label>
            <textarea className="form-control" id="exampleFormControlTextarea1" rows="10"></textarea>
        </div>
    </>);
}