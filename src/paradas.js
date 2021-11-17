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
      alert("Hubo un fallo al conectar");
    });
}