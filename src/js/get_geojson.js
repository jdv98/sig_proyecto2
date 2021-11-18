import {getIniDes} from "../js/clicks";
import {agregarFilaTabla} from "../js/tabla_map";

var layerRuta;
var mymap;
var myStyle = {
  "color": "#ff7800",
  "weight": 5,
  "opacity": 0.65
};

export function getMap(map){
  mymap=map;
}

/**
 * Retorna las paradas
 * @returns geojson
 */
export function paradas() {
  return fetch("/get-paradas", {
    method: "GET",
    mode: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      return response.json();
    })
    .catch((error) => {
      console.log(error);
    });
}

/**
 * 
 * @returns geojson
 */
export function getDijkstra() {
  (async()=>{
    if(layerRuta!=null){
      mymap.removeLayer(layerRuta);
    }
    var response = await dijkstraFetch();
    layerRuta=L.geoJSON(response, {
      style: myStyle
  }).addTo(mymap);
  })();
  
}

function dijkstraFetch(){
    return fetch("/dijkstra", {
      method: "POST",
      mode: "same-origin",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(getIniDes()),
    })
      .then((response) => {
        return response.json();
      })
      .then((response)=>{
        $("#table tr").remove(); 
        agregarFilaTabla('seq',
        'path_seq',
        'node',
        'edge',
        'cost',
        'agg_cost');
        response.dijkstra.forEach(element => {
          agregarFilaTabla(
            element.seq,
            element.path_seq,
            element.node,
            element.edge,
            element.cost,
            element.agg_cost)
        });
        return response.ruta;
      })
      .catch((error) => {
        console.log(error);
      });
}
