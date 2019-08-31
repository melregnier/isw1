#ifndef SENSOR_H
#define SENSOR_H

#include <bits/stdc++.h>
#include "Medicion.h"

using namespace std;

class Sensor{
public:
	Sensor(): _ultimaMedicion(-1,-1) {
	}

	Medicion sensarSuelo();
	

private:

	Medicion _ultimaMedicion;

};


#endif  // SENSOR_H





