//Guarda el inicio y destino
var inicio;
var destino;

export var iconoNeutro;
export var iconoInicio;
export var iconoDestino;


export function asignarIconos(neutro,inicio,destino){
    iconoNeutro=neutro;
    iconoInicio=inicio;
    iconoDestino=destino;
}

/**
 * Al dar click pone o elimina el marcador de inicio
 * @param {*} e 
 */
export function clickInicio(e) {
  if(inicio==null){
    e.sourceTarget.setIcon(iconoInicio);
    inicio = e.sourceTarget;
  }
  else if(inicio==e.sourceTarget){
    inicio.setIcon(iconoNeutro);
    inicio=null;
  }
  else if (inicio) {
    inicio.setIcon(iconoNeutro);
    e.sourceTarget.setIcon(iconoInicio);
    inicio = e.sourceTarget;
  }
}

/**
 * Al dar click pone o elimina el marcador de destino
 * @param {*} e 
 */
export function clickDestino(e) {
  if(destino==null){
    e.sourceTarget.setIcon(iconoDestino);
    destino = e.sourceTarget;
  }
  else if(destino==e.sourceTarget){
    destino.setIcon(iconoNeutro);
    destino=null;
  }
  else if (destino) {
    destino.setIcon(iconoNeutro);
    e.sourceTarget.setIcon(iconoDestino);
    destino = e.sourceTarget;
  }
}

export function getIniDes(){
  if(destino!=null && inicio!=null){
      var ini=inicio.feature.id;
      var des=destino.feature.id;
      return {ini,des};
  }
  else{
    return null;
  }
}