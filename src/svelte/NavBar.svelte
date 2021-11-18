<script>
  import {getDijkstra} from "../js/get_geojson";
  function logout() {
    document.cookie = "conexion=;max-age=0;";
  }

</script>

<div class={"nav"}>
  <!-- svelte-ignore a11y-invalid-attribute -->
  <a href="#" on:click={getDijkstra}>Ruta más corta</a>
  <div class={"nav-right"}>
    <a href="/" on:click={logout}>Salir</a>
  </div>
</div>

<style>
  .nav {
    background: black;
  }

  .nav a {
    color: white;
    background-color: black;
    text-align: center;
    padding: 25px 25px;
    text-decoration: none;
    font-size: 25px;

    transition: background-color 0.8s ease,
    color 0.2s linear;
  }

  .nav a:hover {
    background-color: white;
    color: black;
    
    transition: background-color 0.8s ease,
    color 0.8s linear;
  }

  .nav-right {
    float: right;
  }
</style>
