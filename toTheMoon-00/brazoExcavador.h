#ifndef BRAZO_EXCAVADOR_H
#define BRAZO_EXCAVADOR_H

#include <bits/stdc++.h>
#include "Mecha.h"
#include "Pinza.h"
#include "Medicion.h"
#include "Sensor.h"


#define HORARIO 0
#define ANTIHORARIO 1
#define PIEDRA 0
#define POLVO 1
#define	VELOCIDAD_PIEDRA 150
#define VELOCIDAD_POLVO 100
#define	TIEMPO_PIEDRA 10
#define	TIEMPO_POLVO 5
#define LIMITE_DUREZA 0    //completar con valores cientificos conocidos
#define LIMITE_POROSIDAD 0   //completar con valores cientificos conocidos

using namespace std;

class BrazoExcavador{
public:
	BrazoExcavador() : _mecha(), _pinza(), _sensor() {
	}

	void tomarMuestra();

private:

	Pinza _pinza;
	Mecha _mecha;
	Sensor _sensor;
	int tiempo(int tipoDeSuelo);
	int velocidad(int tipoDeSuelo);
	int sentidoContrario(int tipoDeSuelo);
	int determinarTipoDeSuelo(Medicion medicion);
	int sentido(int tipoDeSuelo);

};


#endif  // BRAZO_EXCAVADOR_H





