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
#define INTERMEDIO 2
#define	VELOCIDAD_PIEDRA 150
#define VELOCIDAD_POLVO 100
#define VELOCIDAD_INTERMEDIO 150
#define VELOCIDAD_CONTRARIA_INTERMEDIO 100
#define	TIEMPO_PIEDRA 10
#define	TIEMPO_POLVO 5
#define	TIEMPO_INTERMEDIO 5
#define	TIEMPO_CONTRARIO_INTERMEDIO 10
#define LIMITE_DURO 100    //completar con valores cientificos conocidos
#define LIMITE_BLANDO 0
#define LIMITE_POROSO 100   //completar con valores cientificos conocidos
#define LIMITE_COMPACTO 0

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

	int sentido(int tipoDeSuelo);
	int velocidad(int tipoDeSuelo);
	int tiempo(int tipoDeSuelo);

	int sentidoContrario(int tipoDeSuelo);
	int velocidadContraria(int tipoDeSuelo);
	int tiempoContrario(int tipoDeSuelo);

	int determinarTipoDeSuelo(Medicion medicion);

};


#endif  // BRAZO_EXCAVADOR_H





