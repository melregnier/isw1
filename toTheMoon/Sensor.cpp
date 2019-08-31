#include "brazoExcavador.cpp"

Medicion Sensor::sensarSuelo() {
	//return medicion con dispositivo
	Medicion res(5,5); // esta harcodeado para que ande en C si hubiera un dispositivo aca se comunicaria
	_ultimaMedicion = res;
	return res;
}