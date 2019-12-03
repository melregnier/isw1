Para que el cliente funcione se debe levantar el servidor en SmallTalk en el puerto 8086.

| server |
TusLibrosServerController allInstances  do: [:anInstance| anInstance stopListening.
																	anInstance destroy].
server := (TusLibrosServerController listeningOn: 8086).
server startListening . 

Luego se debe abrir el archivo index.html

Usuarios válidos:
	user: admin, password: admin
	user: Melissa, password: incorrecta
	user: Dago, password: dagoescool

Única tarjeta válida: 1111 2222 3333 4444
El resto figuran como robadas.

FeedBack del ejercicio: 
Realizar este ejercicio nos resultó muy complejo y largo, considerando que las últimas 2 semanas (o más) llevamos dedicándole al menos 4hs diarias. La complejidad accidental de no sólo entender cómo funciona el cliente web, sino además entender un lenguaje completamente nuevo que no es para nada simple nos resultó excesivo. Por otra parte, las clases de contenido al respecto no resultaron para nada completas.
Al no entender para nada el lenguaje, el hecho de quitar código repetido se nos hizo casi imposible al no saber cómo crear apropiadamente abstracciones que nos permitiesen modularizar nuestro código. Es por esto que nuestra entrega posee código repetido que no hemos quitado.

