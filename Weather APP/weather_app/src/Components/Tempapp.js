import React, { useState, useEffect } from "react";
import "./Style.css";
const Tempapp = () => {
  const [city, setCity] = useState(null);
  const [search, setSearch] = useState("Bhopal");
  const [mainn, setmainn] = useState({});
  const [speed, setspeed] = useState();
  useEffect(() => {
    const fetchApi = async () => {
      const url = `http://api.openweathermap.org/data/2.5/weather?q=${search}&units=metric&appid=a4b30a99aa79c7bcbab7fe865acddb79`;
      const response = await fetch(url);
      const resjson = await response.json();
      setCity(resjson.name);

      if (resjson.main !== undefined) setmainn(resjson.main);
      if (resjson.wind !== undefined) setspeed(resjson.wind.speed);
      console.log("resjson", resjson);
    };
    fetchApi();
  }, [search]);
  return (
    <>
      <div className="box">
        <div className="inputData">
          <input
            type="search"
            value={search}
            className="inputFeild"
            onChange={(event) => {
              setSearch(event.target.value);
            }}
          ></input>
        </div>
        {!city ? (
          <p>No City Found</p>
        ) : (
          <div>
            <div className="info">
              {/* remove location class for street font */}
              <h6 className="location">
                <i className="fas fa-street-view"></i>
                {search}
              </h6>
              <h1 className="temp"> {mainn.temp}°Cel</h1>
              <h3 className="tempmin_max">
                Min: {mainn.temp_min}°Cel |Max: {mainn.temp_max}°Cel
              </h3>
              <h3 style={{}}>Wind Speed : {speed}Kmph</h3>
            </div>

            <div className="wave"></div>
            <div className="wave -two"></div>
            <div className="wave -three"></div>
          </div>
        )}
      </div>
    </>
  );
};

export default Tempapp;
