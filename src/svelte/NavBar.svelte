<script>
  function onclick(){
    console.log('temp')
  }
</script>

<nav>
  <ul>
    <!-- svelte-ignore a11y-invalid-attribute -->
    <li><a href="#" on:click={onclick}>Home</a></li>
    <li>Page 1</li>
    <li>Page 2</li>
    <li>Page 3</li>
  </ul>
</nav>

<style>
  ul{
    list-style-type: none;
  }
  li{
    width: 10%;
  }
  ul {
    display: flex;
    flex-direction: row;
  }
</style>
