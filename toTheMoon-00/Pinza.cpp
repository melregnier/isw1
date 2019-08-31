#include "Pinza.h"

void Pinza::abrir() {
	if(_estado == CERRADO) {
		//abrir la pinza
		_estado = ABIERTO;
	}
}

void Pinza::cerrar() {
	if(_estado == ABIERTO) {
		//cerrar la pinza
		_estado = CERRADO;
	}

}


