#ifndef BRAZO_EXCAVADOR_H
#define BRAZO_EXCAVADOR_H

#include <bits/stdc++.h>

using namespace std;

class BrazoExcavador{
public:
	BrazoExcavador() : _mecha(), _pinza(), _sensor() {
	}

	tomarMuestra();

private:

	Mecha _mecha;
	Pinza _pinza;
	Sensor _sensor;

};


#endif  // BRAZO_EXCAVADOR_H





