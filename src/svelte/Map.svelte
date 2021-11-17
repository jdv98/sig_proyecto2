<script>
  import { onMount } from "svelte";
  import { paradas } from "../paradas.js";

  onMount(async () => {
    var popup = L.popup();
    var mymap = L.map("mapid").setView([10.332921, -84.434963], 13);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(mymap);

    function onMapClick(e) {
      popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(mymap);
    }

    mymap.on("click", onMapClick);

    //---------------------------------------------------------------------
    var MarkerIcon = L.Icon.extend({
      options: {
        iconSize: [38, 38],
      },
    });
    var iconoNeutro = new MarkerIcon({iconUrl:"img/neutro.png"});
    var iconoInicio = new MarkerIcon({ iconUrl: "img/inicio.png" });
    var iconoDestino = new MarkerIcon({ iconUrl: "img/destino.png" });
    //---------------------------------------------------------------------
    function whenClicked(e) {
      e.target.setIcon(iconoInicio);
      console.log(e.target.feature.id);
    }
    function onEachFeatures(feature, layer) {
      if (feature.properties && feature.properties.nombre) {
        layer.bindPopup(feature.properties.nombre);
      }

      layer.on({
        click: whenClicked,
      });
    }

    //Paradas
    (async () => {
      var response = await paradas();

      L.geoJSON(response, {
        pointToLayer: function (feature, latlng) {
          return L.marker(latlng, {
            icon: iconoNeutro,
          });
        },
        onEachFeature: onEachFeatures,
      }).addTo(mymap);
    })();
  });
</script>

<div>
  <div id="mapid" />
</div>
