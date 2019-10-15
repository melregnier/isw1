!classDefinition: #TerniLapilliGameTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:35:45'!
test01PlayerXStarts

	| game |
	
	game := TerniLapilliGame new.
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:35:24'!
test02PlayerODoesNotStart

	| game |
	
	game := TerniLapilliGame new.
	self deny: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:34:40'!
test03PlayerXPlacesChipInRangeAndTheCellIsNowOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self assert: (game isXCell: 1@1).
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 20:16:29'!
test04PlayerXPlacesChipInRangeAndAnotherCellIsEmpty

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self deny: (game isXCell: 0@0).
	
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:35:24'!
test05PlayerOPlaysAfterPlayerX

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self assert: (game isPlayingO).
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:34:40'!
test06PlayerOPlacesChipInRangeAndTheCellIsNowOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@0. 
	
	self assert: (game isOCell: 0@0).
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 20:16:55'!
test07PlayerOPlacesChipInRangeAndGameRemembersOtherCellsOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@0.
	
	self deny: (game isOCell: 0@2).! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:41:17'!
test08PlayerXPlaysAfterPlayerO

	| game |
	
	game := TerniLapilliGame new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	
	
	self assert: (game isPlayingX).
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 20:39:14'!
test09PlayerXCannotPlaceChipOutOfRange

	| game |
	
	game := TerniLapilliGame new.
	self should: [ game putXAt: -1@3. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellNotValidError.
	self deny: (game isXCell: -1@3).
	self assert: game isPlayingX .
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 20:38:43'!
test10PlayerOCannotPlaceChipOutOfRange

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: -1@3. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellNotValidError.
	
	self deny: (game isOCell: -1@3).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 15:44:55'!
test11PlayerXCannotPlaceChipsInAnOccupiedCell

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt:  0@0.
		
	self should: [ game putXAt: 0@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellOccupiedError.
	
	self deny: (game isXCell: 0@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 15:45:51'!
test12PlayerOCannotPlaceChipsInAnOccupiedCell

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
		
	self should: [ game putOAt: 1@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellOccupiedError.
	
	self deny: (game isOCell: 0@0).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:13:02'!
test13PlayerXCannotPlaceChipsTwoTimesInARow

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
		
	self should: [ game putXAt: 1@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlayTwoTimesInARowError.
	
	self deny: (game isXCell: 1@0).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:13:14'!
test14PlayerOCannotPlaceChipsTwoTimesInARow

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.	
	self should: [ game putOAt: 1@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlayTwoTimesInARowError.
	
	self deny: (game isOCell: 1@2).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:36:50'!
test15PlayerXCannotPlaceMoreThanThreeChips

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
		
	self should: [ game putXAt: 1@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlaceMoreThanThreeChips.
	
	self deny: (game isXCell: 1@2).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:35:27'!
test16PlayerOCannotPlaceMoreThanThreeChips

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 1@1 to: 1@2.
		
	self should: [ game putOAt: 1@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlaceMoreThanThreeChips.
	
	self deny: (game isOCell: 1@1).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:10:11'!
test17PlayerXCannotSlideBeforePlacingThreeChips

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	
	self should: [ game slideXFrom: 1@1 to: 0@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideBeforePlacingThreeChipsError.
	
	self deny: (game isXCell: 0@2).
	self assert: (game isXCell: 1@1).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:32:13'!
test18PlayerOCannotSlideBeforePlacingThreeChips

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	
	self should: [ game slideOFrom: 1@0 to: 2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideBeforePlacingThreeChipsError.
	
	self deny: (game isOCell: 2@0).
	self assert: (game isOCell: 1@0).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:40:16'!
test19PlayerXCannotSlideFromAnInvalidPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: -1@0 to: 2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipFromAnInvalidPositionError.
	
	self deny: (game isXCell: 2@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:47:00'!
test20PlayerOCannotSlideFromAnInvalidPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.

	self should: [ game slideOFrom: -2@0 to: 2@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipFromAnInvalidPositionError .
	
	self deny: (game isOCell: 2@1).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:51:13'!
test21PlayerXCannotSlideToAnInvalidPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: 1@1 to: -2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipToAnInvalidPositionError.
	
	self assert: (game isXCell: 1@1).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:51:06'!
test22PlayerOCannotSlideToAnInvalidPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.

	self should: [ game slideOFrom: 1@0 to: -2@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipToAnInvalidPositionError .
	
	self assert: (game isOCell: 1@0).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:48:59'!
test23PlayerXCannotSlideFromAPositionNotOwned

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: 1@0 to: 2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipFromAPositionNotOwnedError.
	
	self deny: (game isXCell: 2@0).
	self assert: (game isOCell: 1@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:49:11'!
test24PlayerOCannotSlideFromAPositionNotOwned

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.

	self should: [ game slideOFrom: 2@0 to: 2@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipFromAPositionNotOwnedError.
	
	self deny: (game isOCell: 2@1).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:55:02'!
test25PlayerXCannotSlideToAnOccupiedPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: 1@1 to: 1@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipToAnOccupiedPositionError.
	
	self assert: (game isXCell: 1@1).
	self assert: (game isOCell: 1@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:11:20'!
test26PlayerOCannotSlideToAnOccupiedPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.

	self should: [ game slideOFrom: 1@0 to: 1@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideChipToAnOccupiedPositionError.
	
	self assert: (game isOCell: 1@0).
	self assert: (game isXCell: 1@1).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:16:38'!
test27PlayerXCannotSlideInTheTurnOfTheOtherPlayer

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.

	self should: [ game slideXFrom: 1@1 to: 1@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideWhenIsNotTheirTurnError.
	
	self assert: (game isXCell: 1@1).
	self deny: (game isXCell: 1@2).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:21:35'!
test28PlayerOCannotSlideInTheTurnOfTheOtherPlayer

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideOFrom: 1@0 to: 2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideWhenIsNotTheirTurnError .
	
	self assert: (game isOCell: 1@0).
	self deny: (game isOCell: 2@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:43:37'!
test29PlayerXCannotSlideToANotNeighbourPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: 2@2 to: 2@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideToAPositionNotFollowingPredefinedLinesError.
	
	self assert: (game isXCell: 2@2).
	self deny: (game isXCell: 2@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:51:20'!
test30PlayerOCannotSlideToANotNeighbourPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 1@1 to: 2@1.
	
	self should: [ game slideOFrom: 1@0 to: 1@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideToAPositionNotFollowingPredefinedLinesError.
	
	self assert: (game isOCell: 1@0).
	self deny: (game isOCell: 1@2).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 18:09:50'!
test31PlayerXCannotSlideNotFollowingThePredefinedLines

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.

	self should: [ game slideXFrom: 0@1 to: 1@2. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideToAPositionNotFollowingPredefinedLinesError.
	
	self assert: (game isXCell: 0@1).
	self deny: (game isXCell: 1@2).
	self assert: game isPlayingX.
! !


!classDefinition: #TerniLapilliGame category: #TerniLapilli!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'turn xChips oChips'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 16:44:43'!
checkValidationOfCell: aCell withError: anErrorMessage.
	
	(aCell between: 0@0 and: 2@2) ifFalse: [self error: anErrorMessage]! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 18:14:40'!
connectedByLineFrom: originCell to: destinyCell
	
	^ (originCell dist: destinyCell) floor = 1 and ! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:26:58'!
initialize

	turn := #X.
	xChips := OrderedCollection new.
	oChips := OrderedCollection new.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:04:14'!
isEmptyCell: aCell

	^ (xChips includes: aCell) not and: (oChips includes: aCell) not.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:33:32'!
isOCell: aCell 

	^ oChips includes: aCell! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:35:45'!
isPlayingO

	^ self isPlayingX not.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:35:45'!
isPlayingX
	
	^ turn = #X.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'mr 10/10/2019 18:33:57'!
isXCell: aCell 

	^ xChips includes: aCell! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:18:38'!
putOAt: aCell

	self isPlayingX ifTrue: [ self error: self class playerCannotPlayTwoTimesInARowError. ].
	self checkValidationOfCell: aCell withError: self class cellNotValidError .
	oChips size = 3 ifTrue: [self error: self class playerCannotPlaceMoreThanThreeChips. ].
	(self isEmptyCell: aCell) ifFalse: [ self error: self class cellOccupiedError. ].
	
	turn := #X.
	oChips add: aCell.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:29:38'!
putXAt: aCell
	
	self isPlayingO ifTrue: [ self error: self class playerCannotPlayTwoTimesInARowError. ].
	self checkValidationOfCell: aCell withError: self class cellNotValidError.
	xChips size = 3 ifTrue: [self error: self class playerCannotPlaceMoreThanThreeChips. ].
	(self isEmptyCell: aCell) ifFalse: [ self error: self class cellOccupiedError. ].
	
	xChips add: aCell .
	turn := #O.
! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:51:44'!
slideOFrom: originCell to: destinyCell 

	self checkValidationOfCell: originCell withError: self class playerCannotSlideChipFromAnInvalidPositionError .
	self checkValidationOfCell: destinyCell withError: self class playerCannotSlideChipToAnInvalidPositionError .
	(self connectedByLineFrom: originCell to: destinyCell) ifFalse: [ self error: self class playerCannotSlideToAPositionNotFollowingPredefinedLinesError ].

	self isPlayingX ifTrue: [ self error: self class playerCannotSlideWhenIsNotTheirTurnError ].

	oChips size < 3 ifTrue: [ self error: self class playerCannotSlideBeforePlacingThreeChipsError. ]. 
	(oChips includes: originCell) ifFalse: [self error: self class playerCannotSlideChipFromAPositionNotOwnedError. ].

	(self isEmptyCell: destinyCell) ifFalse: [self error: self class playerCannotSlideChipToAnOccupiedPositionError . ].

	turn := #X.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'D 10/15/2019 17:48:48'!
slideXFrom: originCell to: destinyCell 
	
	self checkValidationOfCell: originCell withError: self class playerCannotSlideChipFromAnInvalidPositionError .
	self checkValidationOfCell: destinyCell withError: self class playerCannotSlideChipToAnInvalidPositionError .
	(self connectedByLineFrom: originCell to: destinyCell) ifFalse: [ self error: self class playerCannotSlideToAPositionNotFollowingPredefinedLinesError ].
	
	self isPlayingO ifTrue: [ self error: self class playerCannotSlideWhenIsNotTheirTurnError ].
	
	xChips size < 3 ifTrue: [ self error: self class playerCannotSlideBeforePlacingThreeChipsError. ]. 
	(xChips includes: originCell) ifFalse: [self error: self class playerCannotSlideChipFromAPositionNotOwnedError. ].
	
	(self isEmptyCell: destinyCell) ifFalse: [self error: self class playerCannotSlideChipToAnOccupiedPositionError . ].

	turn := #O.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: #TerniLapilli!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'mr 10/10/2019 20:14:38'!
cellNotValidError

	^ 'Cell not valid'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 15:51:55'!
cellOccupiedError
	^ 'You cannot play in an occupied cell'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 15:58:12'!
playerCannotPlaceMoreThanThreeChips
	^ 'You have no more chips'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 15:52:26'!
playerCannotPlayTwoTimesInARowError
	^ 'It is not your turn'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:11:00'!
playerCannotSlideBeforePlacingThreeChipsError
	^ 'Place all your chips before sliding them'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:19:56'!
playerCannotSlideChipFromAPositionNotOwnedError
	^ 'You cannot slide a chip from a position you don not own'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:42:24'!
playerCannotSlideChipFromAnInvalidPositionError
	
	^ 'You cannot slide from an invalid cell'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:48:23'!
playerCannotSlideChipToAnInvalidPositionError
	
	^ 'You cannot slide into an invalid cell'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:55:51'!
playerCannotSlideChipToAnOccupiedPositionError
	
	^ 'You cannot slide your chip to an occupied cell'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 17:40:37'!
playerCannotSlideToANotNeighbourPositionError
	self shouldBeImplemented.! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 17:43:19'!
playerCannotSlideToAPositionNotFollowingPredefinedLinesError
	
	^ 'You cannot slide to that position. You can only slide to neighbouring positions set by the lines of the board.'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 17:17:22'!
playerCannotSlideWhenIsNotTheirTurnError
	
	^ 'You cannot slide when is not your turn'! !
