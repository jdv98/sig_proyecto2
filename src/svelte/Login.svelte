<script>
  let datos = ["192.168.100.3", "5432", "postgres", "postgres", "pr2gis"];

  let failed = false;

  $: {
    if (datos.filter((len) => len.length == 0).length > 0) {
      failed = true;
    } else {
      failed = false;
    }
  }

  function onSubmit(event) {
    let temp_conexion = {};
    for (var kv of new FormData(event.target).entries()) {
      temp_conexion[kv[0]] = kv[1];
    }

    fetch("/conexion", {
      method: "POST",
      mode: "same-origin",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ conexion: temp_conexion }),
    })
      .then((response) => {
        return response.json();
      })
      .then((response) => {
        if (response.url != "") window.location.href = response.url;
      })
      .catch((error) => {
        console.log(error);
        alert("Hubo un fallo al conectar");
      });
  }
</script>

<main>
  <form action="/conexion" method="dialog" on:submit={onSubmit}>
    <div>
      <label for="host">Anfitrión</label>
      <input id="host" name="host" bind:value={datos[0]} />
    </div>
    <div>
      <label for="port">Puerto</label>
      <input id="port" name="port" bind:value={datos[1]} />
    </div>
    <div>
      <label for="user">Usuario</label>
      <input id="user" name="user" bind:value={datos[2]} />
    </div>
    <div>
      <label for="password">Contraseña</label>
      <input
        id="password"
        name="password"
        type="password"
        bind:value={datos[3]}
      />
    </div>
    <div>
      <label for="database">Base de datos</label>
      <input id="database" name="database" bind:value={datos[4]} />
    </div>
    <div>
      <input contenteditable="true" class={"centerI"} type="submit" name="submit" value="{!failed?'Ingresar':''}" disabled={failed} />
    </div>
  </form>
</main>

<style>
  main,
  form,
  div{
    margin: auto;
    width: 60%;
    padding: 10px;
    display: flex;
    flex-direction: column;
  }
  .centerI{
    height: auto;
    border-color: white;
    background-color: #f5f5f5;
    transition: background-color 1s linear 0.2s;
  }
  .centerI:disabled{
    background-color: rgb(221, 218, 218);
    transition: background-color 1s linear 0.2s;
  }
  input,label{
    font-family: monospace;
    border-radius: 5px;
  }
  main {
    margin-top: 10%;
  }
  label{
  text-shadow: 0px 0px 10px rgb(132, 164, 252);
  }
</style>
