<script>
  import { onMount } from "svelte";
  import { paradas,getMap} from "../js/get_geojson.js";
  import { onEachParada } from "../js/onEachFeature";
  import { iconoNeutro, asignarIconos} from "../js/clicks";

  var mymap;

  onMount(async () => {
    mymap = L.map("mapid").setView([9.932138391079107, -84.08881770887126], 13);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(mymap);

    //---------------------------------------------------------------------
    var MarkerIcon = L.Icon.extend({
      options: {
        iconSize: [38, 38],
      },
    });

    asignarIconos(
      new MarkerIcon({ iconUrl: "img/neutro.png" }),
      new MarkerIcon({ iconUrl: "img/inicio.png" }),
      new MarkerIcon({ iconUrl: "img/destino.png" })
    );

    //---------------------------------------------------------------------
    //Paradas
    (async () => {
      var response = await paradas();


        L.geoJSON(response, {
          pointToLayer: function (feature, latlng) {
            return L.marker(latlng, {
              icon: iconoNeutro,
            });
          },
          onEachFeature: onEachParada,
        }).addTo(mymap)
    })();

    getMap(mymap);
    agregarFilaTabla('seq',
        'path_seq',
        'node',
        'edge',
        'cost',
        'agg_cost');
  });
</script>

<div>
  <div id="mapid" />

  <div class="center">
    <div><h1>Rutas</h1></div>
    <div>
      <table id="table">
      </table>
    </div>
  </div>

</div>

<style>
  :global(table, th, td) {
    border: 1px solid black;
    border-collapse: collapse;
  }

  :global(th, td) {
    padding: 5px;
  }

  .center{
    flex-direction: column;
    display: flex;
    justify-content: center;
    padding-bottom: 50px;
  }

  .center div{
    margin: 0 auto;
  }
</style>
