#ifndef SENSOR_H
#define SENSOR_H

#include <bits/stdc++.h>
#include Medicion

using namespace std;

class Sensor{
public:
	Sensor() {
	}

	Medicion sensarSuelo();

private:

	Medicion _ultimaMedicion;

};


#endif  // SENSOR_H





