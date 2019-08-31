#ifndef MEDICION_H
#define MEDICION_H

#include <bits/stdc++.h>

using namespace std;

class Medicion{
public:
	Medicion(int dureza, int porosidad) : _dureza(dureza), _porosidad(porosidad) {}

	int dureza() { return _dureza; }
	int porosidad() { return _porosidad; }



private:
	int _dureza;
	int _porosidad;

};


#endif  // MEDICION_H





