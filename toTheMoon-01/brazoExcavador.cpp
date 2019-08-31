#include "brazoExcavador.h"

void BrazoExcavador::tomarMuestra() {
	Medicion medicion = _sensor.sensarSuelo();
	int tipoDeSuelo = determinarTipoDeSuelo(medicion);
	_pinza.abrir();
	_mecha.girar(sentido(tipoDeSuelo), velocidad(tipoDeSuelo), tiempo(tipoDeSuelo)); // SENTIDO, V, T
	_pinza.cerrar();
	_mecha.girar(sentidoContrario(tipoDeSuelo), velocidadContraria(tipoDeSuelo), tiempoContrario(tipoDeSuelo));

}

int BrazoExcavador::sentido(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return HORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return ANTIHORARIO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return HORARIO;
	}
}

int BrazoExcavador::velocidad(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return VELOCIDAD_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return VELOCIDAD_POLVO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return VELOCIDAD_INTERMEDIO;
	}
}

int BrazoExcavador::velocidadContraria(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return VELOCIDAD_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return VELOCIDAD_POLVO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return VELOCIDAD_CONTRARIA_INTERMEDIO;
	}
}

int BrazoExcavador::tiempo(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return TIEMPO_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return TIEMPO_POLVO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return TIEMPO_INTERMEDIO;
	}
}

int BrazoExcavador::tiempoContrario(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return TIEMPO_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return TIEMPO_POLVO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return TIEMPO_CONTRARIO_INTERMEDIO;
	}
}

int BrazoExcavador::sentidoContrario(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return ANTIHORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return HORARIO;
	}
	if(tipoDeSuelo == INTERMEDIO) {
		return ANTIHORARIO;
	}
}


int BrazoExcavador::determinarTipoDeSuelo(Medicion medicion) {
	if(medicion.dureza() >= LIMITE_DURO and medicion.porosidad() < LIMITE_COMPACTO) {
		return PIEDRA;
	}
	if(medicion.dureza() < LIMITE_BLANDO and medicion.porosidad() >= LIMITE_POROSO) {
		return POLVO;
	}
	if(medicion.dureza() >= LIMITE_BLANDO and medicion.dureza() < LIMITE_DURO
	   and medicion.porosidad() < LIMITE_POROSO and medicion.porosidad() >= LIMITE_BLANDO) {	
		return INTERMEDIO;
	}
	return -1;//error
}
