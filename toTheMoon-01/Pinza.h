#ifndef PINZA_H
#define PINZA_H

#define CERRADO true
#define ABIERTO false


#include <bits/stdc++.h>

using namespace std;

class Pinza{
public:
	Pinza() {
		_estado = ABIERTO;
	}

	void cerrar();
	void abrir();

private:
	bool _estado;

};


#endif  // PINZA_H





