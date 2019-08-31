!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'Errores' stamp: 'mr 8/31/2019 17:46:00'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'! !

!I class methodsFor: 'Errores' stamp: 'mr 8/31/2019 17:50:11'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Los números negativos no están soportados'! !


!I class methodsFor: 'Operaciones' stamp: 'Dago 8/26/2019 20:51:56'!
* unNumeroPeano
	^unNumeroPeano ! !

!I class methodsFor: 'Operaciones' stamp: 'MB 8/26/2019 18:50:45'!
+ unNumeroDePeano
	
	^ unNumeroDePeano next ! !

!I class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:03:36'!
- unNumeroDePeano
	
	^ unNumeroDePeano restaInversa: self! !

!I class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 17:45:12'!
/ unNumeroPeano
	unNumeroPeano  = self ifTrue: [ ^self ].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	! !

!I class methodsFor: 'Operaciones' stamp: 'MB 8/26/2019 18:27:52'!
next

		^II! !

!I class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 17:48:57'!
previous
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !


!I class methodsFor: 'Privado' stamp: 'Dago 8/27/2019 17:28:22'!
< unNumeroPeano
	^ (self = unNumeroPeano) not
	 ! !

!I class methodsFor: 'Privado' stamp: 'Dago 8/27/2019 17:52:48'!
restaInversa: unNumeroPeano
	^unNumeroPeano  previous! !


!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Errores' stamp: 'mr 8/31/2019 17:47:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'! !


!II class methodsFor: 'Operaciones' stamp: 'Dago 8/26/2019 20:51:37'!
* unNumeroPeano

	^self previous * unNumeroPeano + unNumeroPeano ! !

!II class methodsFor: 'Operaciones' stamp: 'MB 8/26/2019 18:54:26'!
+ unNumeroDePeano
	
	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'Operaciones' stamp: 'Dago 8/27/2019 17:54:54'!
- unNumeroDePeano
	^unNumeroDePeano restaInversa: self.
	
	"unNumeroDePeano = I ifTrue: [ ^self previous ] ifFalse: [ ^self previous - unNumeroDePeano previous ]"! !

!II class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 17:48:28'!
/ unNumeroPeano
	self < unNumeroPeano ifTrue: [ ^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = unNumeroPeano ifTrue: [ ^I ].
	self - unNumeroPeano  < unNumeroPeano ifTrue: [ ^I ].
	^ self - unNumeroPeano / unNumeroPeano  + I ! !

!II class methodsFor: 'Operaciones' stamp: 'MB 8/26/2019 18:55:57'!
next

	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'Operaciones' stamp: 'MB 8/26/2019 18:58:23'!
previous
	
	^previous! !


!II class methodsFor: 'Privado' stamp: 'Dago 8/27/2019 17:26:49'!
< unNumeroPeano
	unNumeroPeano = I ifTrue: [ ^false ].
	^self previous < unNumeroPeano previous! !

!II class methodsFor: 'Privado' stamp: 'MB 8/26/2019 19:05:01'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!II class methodsFor: 'Privado' stamp: 'MB 8/26/2019 18:38:13'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'Privado' stamp: 'Dago 8/27/2019 17:54:09'!
restaInversa: unNumeroPeano
	^self previous restaInversa: unNumeroPeano  previous! !


!II class methodsFor: 'as yet unclassified' stamp: 'mr 8/31/2019 18:05:00'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'Errores' stamp: 'mr 8/31/2019 18:04:20'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'! !


!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
* unNumeroPeano

	^self previous * unNumeroPeano + unNumeroPeano ! !

!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
+ unNumeroDePeano
	
	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
- unNumeroDePeano
	^unNumeroDePeano restaInversa: self.
	
	"unNumeroDePeano = I ifTrue: [ ^self previous ] ifFalse: [ ^self previous - unNumeroDePeano previous ]"! !

!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
/ unNumeroPeano
	self < unNumeroPeano ifTrue: [ ^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = unNumeroPeano ifTrue: [ ^I ].
	self - unNumeroPeano  < unNumeroPeano ifTrue: [ ^I ].
	^ self - unNumeroPeano / unNumeroPeano  + I ! !

!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
next

	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!III class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:20'!
previous
	
	^previous! !


!III class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:20'!
< unNumeroPeano
	unNumeroPeano = I ifTrue: [ ^false ].
	^self previous < unNumeroPeano previous! !

!III class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:20'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!III class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:20'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:20'!
restaInversa: unNumeroPeano
	^self previous restaInversa: unNumeroPeano  previous! !


!III class methodsFor: 'as yet unclassified' stamp: 'mr 8/31/2019 18:05:00'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'Errores' stamp: 'mr 8/31/2019 18:04:21'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'! !


!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
* unNumeroPeano

	^self previous * unNumeroPeano + unNumeroPeano ! !

!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
+ unNumeroDePeano
	
	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
- unNumeroDePeano
	^unNumeroDePeano restaInversa: self.
	
	"unNumeroDePeano = I ifTrue: [ ^self previous ] ifFalse: [ ^self previous - unNumeroDePeano previous ]"! !

!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
/ unNumeroPeano
	self < unNumeroPeano ifTrue: [ ^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = unNumeroPeano ifTrue: [ ^I ].
	self - unNumeroPeano  < unNumeroPeano ifTrue: [ ^I ].
	^ self - unNumeroPeano / unNumeroPeano  + I ! !

!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
next

	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!IIII class methodsFor: 'Operaciones' stamp: 'mr 8/31/2019 18:04:21'!
previous
	
	^previous! !


!IIII class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:21'!
< unNumeroPeano
	unNumeroPeano = I ifTrue: [ ^false ].
	^self previous < unNumeroPeano previous! !

!IIII class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:21'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!IIII class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:21'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'Privado' stamp: 'mr 8/31/2019 18:04:21'!
restaInversa: unNumeroPeano
	^self previous restaInversa: unNumeroPeano  previous! !


!IIII class methodsFor: 'as yet unclassified' stamp: 'mr 8/31/2019 18:05:00'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!