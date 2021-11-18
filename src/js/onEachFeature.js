import {clickInicio,clickDestino} from "../js/clicks";

/**
 * Agrega funciones o caracteristicas para cada capa cargada
 * @param feature
 * @param layer
 */
export function onEachParada(feature, layer) {
  if (feature.properties && feature.properties.nombre) {
    layer.bindPopup(feature.properties.nombre);
  }
  layer.on({
    mouseover:((e)=>{e.sourceTarget.openPopup();}),
    mouseout:((e)=>{e.sourceTarget.closePopup()}),
    click: clickInicio,
    contextmenu: clickDestino,
  });
}