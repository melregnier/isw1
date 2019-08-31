#include "brazoExcavador.h"



void BrazoExcavador::tomarMuestra() {
	Medicion medicion = _sensor.sensarSuelo();
	int tipoDeSuelo = determinarTipoDeSuelo(medicion);
	_pinza.abrir();
	_mecha.girar(sentido(tipoDeSuelo), velocidad(tipoDeSuelo), tiempo(tipoDeSuelo)); // SENTIDO, V, T
	_pinza.cerrar();
	_mecha.girar(sentidoContrario(tipoDeSuelo), velocidad(tipoDeSuelo), tiempo(tipoDeSuelo));

}

int BrazoExcavador::sentido(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return HORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return ANTIHORARIO;
	}
}

int BrazoExcavador::velocidad(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return VELOCIDAD_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return VELOCIDAD_POLVO;
	}
}

int BrazoExcavador::tiempo(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return TIEMPO_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return TIEMPO_POLVO;
	}
}

int BrazoExcavador::sentidoContrario(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return ANTIHORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return HORARIO;
	}
}


int BrazoExcavador::determinarTipoDeSuelo(Medicion medicion) {
	if(medicion.dureza() >= LIMITE_DUREZA and medicion.porosidad() < LIMITE_POROSIDAD) {
		return PIEDRA;
	}
	if(medicion.dureza() < LIMITE_DUREZA and medicion.porosidad() >= LIMITE_POROSIDAD) {
		return POLVO;
	}
	return -1;//error
}
