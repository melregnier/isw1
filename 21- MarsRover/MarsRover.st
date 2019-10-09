!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test - private' stamp: 'mr 10/6/2019 12:30:53'!
obtainPositionOfMarsRoverStartedAt: aPoint inOrientation: anOrientation andMoved: aSequenceOfMovements 
	
	| marsRover |

	marsRover := MarsRover at: aPoint orientedAt: anOrientation .

  	^ marsRover move: aSequenceOfMovements .! !


!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/7/2019 15:27:46'!
test01EmptyInstructionDoesNotMove

	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: '') equals: 1@1.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/7/2019 15:32:50'!
test02MarsRoverMovesForward

	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'f') equals: 1@2.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/7/2019 15:32:44'!
test03MarsRoverMovesBackward

	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'b') equals: 1@0.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/7/2019 15:32:57'!
test04MarsRoverMovesForwardTwice

	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'ff') equals: 1@3.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/7/2019 15:33:03'!
test05MarsRoverMovesBackwardTwice
	
	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'bb') equals: 1@-1.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:09:11'!
test06MarsRoverMovesForwardOnceAndBackwardOnce
	
	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'fb') equals: 1@1.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:09:55'!
test07MarsRoverMovesForwardOnceAndThenForwardAgain
	
	| marsRover newPosition |

	marsRover := MarsRover at: 1@1 orientedAt: North new.

	newPosition := marsRover move: 'f'.
	
	newPosition := marsRover move: 'f'.

	self assert: newPosition equals: 1@3.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:10:20'!
test08MarsRoverRotatesLeftAndMovesForward
	
	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'lf') equals: 0@1.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:10:45'!
test09MarsRoverRotatesRightAndMovesForward
	
	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'rf') equals: 2@1.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:16:42'!
test10MarsRoverDoesAllPossibleInstructions
	
	self assert: (self obtainPositionOfMarsRoverStartedAt: 1@1 inOrientation: North new andMoved: 'rflb') equals: 2@0.! !

!MarsRoverTest methodsFor: 'test' stamp: 'mr 10/9/2019 15:16:55'!
test11MarsRoverRotatesLeftTwiceAndRemembersOrientationAndPositionAfterFirstRotation

	| marsRover newPosition |

	marsRover := MarsRover at: 1@1 orientedAt: East new.

	newPosition := marsRover move: 'lf'.
	
	newPosition := marsRover move: 'lf'.

	self assert: newPosition equals: 0@2.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'dr 10/3/2019 20:21:04'!
initializeAt: aPoint orientedAt: anOrientation
	
	position := aPoint.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'movement' stamp: 'mr 10/7/2019 16:10:56'!
move: anInstructionString

	anInstructionString  do: [:elem |
		elem = $f ifTrue: [ self moveForward ].
		elem = $b ifTrue: [ self moveBackward ].
		elem = $r ifTrue: [ self rotateRight ].
		elem = $l ifTrue: [ self rotateLeft ].
		].
	
	^ position.! !

!MarsRover methodsFor: 'movement' stamp: 'mr 10/7/2019 15:58:27'!
moveBackward

	position := position + orientation oppositeCharacteristicVersor.! !

!MarsRover methodsFor: 'movement' stamp: 'mr 10/7/2019 15:58:09'!
moveForward
	
	position := position + orientation characteristicVersor. ! !


!MarsRover methodsFor: 'rotation' stamp: 'mr 10/7/2019 16:10:27'!
rotateLeft

	^ orientation := orientation cardinalPointToTheLeft! !

!MarsRover methodsFor: 'rotation' stamp: 'mr 10/7/2019 16:10:56'!
rotateRight

	^ orientation := orientation cardinalPointToTheRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance initialization' stamp: 'dr 10/3/2019 20:19:30'!
at: aPoint orientedAt: anOrientation 
	
	^ self new initializeAt: aPoint orientedAt: anOrientation.! !


!classDefinition: #MarsRoverCardinalPoint category: #MarsRover!
Object subclass: #MarsRoverCardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCardinalPoint methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:48:52'!
characteristicVersor

	^ self subclassResponsibility .! !

!MarsRoverCardinalPoint methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:49:02'!
oppositeCharacteristicVersor

	^ self subclassResponsibility .! !


!MarsRoverCardinalPoint methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:26:43'!
cardinalPointToTheLeft

	^ self subclassResponsibility.! !

!MarsRoverCardinalPoint methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:26:48'!
cardinalPointToTheRight

	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalPoint class' category: #MarsRover!
MarsRoverCardinalPoint class
	instanceVariableNames: ''!

!MarsRoverCardinalPoint class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:18:33'!
new

	^self subclassResponsibility.! !


!classDefinition: #East category: #MarsRover!
MarsRoverCardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:49:52'!
characteristicVersor

	^ 1@0.! !

!East methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:50:08'!
oppositeCharacteristicVersor

	^ -1@0.! !


!East methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:24:47'!
cardinalPointToTheLeft

	^ North new.! !

!East methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:24:57'!
cardinalPointToTheRight

	^ South new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:28:44'!
initialize
	^ uniqueInstance  := self basicNew.! !

!East class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:31:02'!
new

	^ uniqueInstance.! !


!classDefinition: #North category: #MarsRover!
MarsRoverCardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:50:51'!
characteristicVersor

	^ 0@1.! !

!North methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:51:02'!
oppositeCharacteristicVersor

	^ 0@-1.! !


!North methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:25:09'!
cardinalPointToTheLeft

	^ West new.! !

!North methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:25:19'!
cardinalPointToTheRight

	^ East new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:29:00'!
initialize
	^ uniqueInstance  := self basicNew.
! !

!North class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:31:07'!
new

	^ uniqueInstance.! !


!classDefinition: #South category: #MarsRover!
MarsRoverCardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:55:50'!
characteristicVersor

	^ 0@-1.! !

!South methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:55:43'!
oppositeCharacteristicVersor

	^ 0@1.! !


!South methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:25:36'!
cardinalPointToTheLeft

	^ East new.! !

!South methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:25:50'!
cardinalPointToTheRight

	^ West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:29:16'!
initialize
	^ uniqueInstance  := self basicNew.! !

!South class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:31:13'!
new

	^ uniqueInstance.! !


!classDefinition: #West category: #MarsRover!
MarsRoverCardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:56:14'!
characteristicVersor

	^ -1@0.! !

!West methodsFor: 'characteristic versors' stamp: 'mr 10/7/2019 15:56:09'!
oppositeCharacteristicVersor

	^ 1@0.! !


!West methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:26:09'!
cardinalPointToTheLeft

	^ South new.! !

!West methodsFor: 'cardinal relationships' stamp: 'mr 10/7/2019 15:26:20'!
cardinalPointToTheRight

	^ North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:29:24'!
initialize
	^ uniqueInstance  := self basicNew.! !

!West class methodsFor: 'as yet unclassified' stamp: 'mr 10/7/2019 15:31:32'!
new

	^ uniqueInstance.! !

East initialize!
North initialize!
South initialize!
West initialize!