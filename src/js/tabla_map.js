export function agregarFilaTabla(){
    var table=document.getElementById("table");
    var row=table.insertRow(-1);
    for (let index = 0; index < arguments.length; index++) {
        var cell=row.insertCell(index);
        cell.innerHTML = arguments[index];  
    }
}