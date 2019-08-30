#include "brazoExcavador.cpp"

#define HORARIO 0
#define ANTIHORARIO 1
#define PIEDRA 0
#define POLVO 1
#define	VELOCIDAD_PIEDRA 150
#define VELOCIDAD_POLVO 100
#define	TIEMPO_PIEDRA 10
#define	TIEMPO_POLVO 5


void BrazoExcavador::tomarMuestra() {
	Medicion medicion = _sensor.sensarSuelo();
	int tipoDeSuelo = determinarTipoDeSuelo(medicion);
	_mecha.girar(sentido(tipoDeSuelo), velocidad(tipoDeSuelo), tiempo(tipoDeSuelo)); // SENTIDO, V, T
	_pinza.cerrar();
	_mecha.girar(sentidoContrario(tipoDeSuelo), velocidad(tipoDeSuelo), tiempo(tipoDeSuelo));

}

int sentido(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return HORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return ANTIHORARIO;
	}
}

int velocidad(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return VELOCIDAD_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return VELOCIDAD_POLVO;
	}
}

int tiempo(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return TIEMPO_PIEDRA;
	}
	if(tipoDeSuelo == POLVO) {
		return TIEMPO_POLVO;
	}
}

int sentidoContrario(int tipoDeSuelo) {
	if(tipoDeSuelo == PIEDRA) {
		return ANTIHORARIO;
	}
	if(tipoDeSuelo == POLVO) {
		return HORARIO;
	}
}


int determinarTipoDeSuelo(Medicion medicion) {
	
}
