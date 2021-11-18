<script>
  (()=>{
    if(document.cookie==''){
      window.location.href='/';
    }
  })();

  import NavBar from "./NavBar.svelte";
  import Map from "./Map.svelte";
</script>

<main>
  <NavBar />

  <Map />
</main>