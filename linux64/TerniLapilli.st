!classDefinition: #TerniLapilliGameTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:35:45'!
test01PlayerXStarts

	| game |
	
	game := TerniLapilliGame new.
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:35:24'!
test02PlayerODoesNotStart

	| game |
	
	game := TerniLapilliGame new.
	self deny: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:34:40'!
test03PlayerXPlacesChipInRangeAndTheCellIsNowOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self assert: (game isXCell: 1@1).
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 20:16:29'!
test04PlayerXPlacesChipInRangeAndAnotherCellIsEmpty

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self deny: (game isXCell: 0@0).
	
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:35:24'!
test05PlayerOPlaysAfterPlayerX

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self assert: (game isPlayingO).
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:34:40'!
test06PlayerOPlacesChipInRangeAndTheCellIsNowOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@0. 
	
	self assert: (game isOCell: 0@0).
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 20:16:55'!
test07PlayerOPlacesChipInRangeAndGameRemembersOtherCellsOcuppied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@0.
	
	self deny: (game isOCell: 0@2).! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'mr 10/10/2019 18:41:17'!
test08PlayerXPlaysAfterPlayerO

	| game |
	
	game := TerniLapilliGame new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	
	
	self assert: (game isPlayingX).
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:11:15'!
test09PlayerXCannotPlaceChipOutOfRange

	| game |
	
	game := TerniLapilliGame new.
	self should: [ game putXAt: -1@3. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellNotValidError.
	
	self assertIsPlayerXTurnAndDoesNotOwn: -1@3 in: game
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:11:32'!
test10PlayerOCannotPlaceChipOutOfRange

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: -1@3. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellNotValidError.
	
	self assertIsPlayerOTurnAndDoesNotOwn: -1@3 in: game
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:11:51'!
test11PlayerXCannotPlaceChipsInAnOccupiedCell

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt:  0@0.
		
	self should: [ game putXAt: 0@0. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellOccupiedError.
	
	self assertIsPlayerXTurnAndDoesNotOwn: 0@0 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:12:12'!
test12PlayerOCannotPlaceChipsInAnOccupiedCell

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
		
	self should: [ game putOAt: 1@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame cellOccupiedError.
	
	self assertIsPlayerOTurnAndDoesNotOwn: 0@0 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 17:13:02'!
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

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 17:13:14'!
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

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:13:22'!
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
	
	self assertIsPlayerXTurnAndDoesNotOwn: 1@2 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:13:41'!
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
	
	self assertIsPlayerOTurnAndDoesNotOwn: 1@1 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 16:10:11'!
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

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 16:32:13'!
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

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:14:37'!
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
		withMessageText: TerniLapilliGame cellNotValidError.
	
	self assertIsPlayerXTurnAndDoesNotOwn: 2@0 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:14:53'!
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
		withMessageText: TerniLapilliGame cellNotValidError .
	
	self assertIsPlayerOTurnAndDoesNotOwn: 2@1 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:15:59'!
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
		withMessageText: TerniLapilliGame cellNotValidError .
	
	self assertIsPlayerXTurnAndDoesOwn: 1@1 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:17:49'!
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
		withMessageText: TerniLapilliGame cellNotValidError .
	
	self assertIsPlayerOTurnAndDoesOwn: 1@0 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:18:19'!
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
	
	self assert: (game isOCell: 1@0).
	self assertIsPlayerXTurnAndDoesNotOwn: 2@0 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:18:48'!
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
	
	self assertIsPlayerOTurnAndDoesNotOwn: 2@1 in: game.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:19:16'!
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
		withMessageText: TerniLapilliGame cellOccupiedError .
	
	self assert: (game isOCell: 1@0).
	self assertIsPlayerXTurnAndDoesOwn: 1@1 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:19:43'!
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
		withMessageText: TerniLapilliGame cellOccupiedError .
	
	self assert: (game isXCell: 1@1).
	self assertIsPlayerOTurnAndDoesOwn: 1@0 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/16/2019 16:24:52'!
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
		withMessageText: TerniLapilliGame playerCannotPlayTwoTimesInARowError .
	
	self assert: (game isXCell: 1@1).
	self deny: (game isXCell: 1@2).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/16/2019 16:25:01'!
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
		withMessageText: TerniLapilliGame playerCannotPlayTwoTimesInARowError .
	
	self assert: (game isOCell: 1@0).
	self deny: (game isOCell: 2@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:20:37'!
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
	
	self deny: (game isXCell: 2@0).
	self assertIsPlayerXTurnAndDoesOwn: 2@2 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:21:01'!
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
	
	self deny: (game isOCell: 1@2).
	self assertIsPlayerOTurnAndDoesOwn: 1@0 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:21:19'!
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
	
	self deny: (game isXCell: 1@2).
	self assertIsPlayerXTurnAndDoesOwn: 0@1 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:21:39'!
test32PlayerOCannotSlideNotFollowingThePredefinedLines

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.
	
	self should: [ game slideOFrom: 1@0 to: 2@1. ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotSlideToAPositionNotFollowingPredefinedLinesError.
	
	self deny: (game isOCell: 2@1).
	self assertIsPlayerOTurnAndDoesOwn: 1@0 in: game.! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 18:55:59'!
test33PlayerXSlideUpdatesTheChipPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	
	game slideXFrom: 2@2 to: 1@2.
	
	self assert: (game isXCell: 1@2).
	self deny: (game isXCell: 2@2).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 19:00:42'!
test34PlayerOSlideUpdatesTheChipPosition

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game slideXFrom: 2@2 to: 1@2.
	
	game slideOFrom: 1@0 to: 2@0.
	
	self assert: (game isOCell: 2@0).
	self deny: (game isOCell: 1@0).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:06:13'!
test35GameIsOverWithHorizontalLine

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 1@0.
	game putXAt: 0@1.
	game putOAt: 0@0.
	game putXAt: 2@1.
	
	self assertGameOverNotTiedAndNeitherPlayerTurnIn: game.	! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:06:19'!
test36GameIsOverWithVerticalLine

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@1.
	game putXAt: 1@2.
	game putOAt: 0@2.
	game putXAt: 1@0.
	
	self assertGameOverNotTiedAndNeitherPlayerTurnIn: game.
	! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/17/2019 16:06:27'!
test37GameIsOverWithDiagonalLine

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@1.
	game putXAt: 0@0.
	game putOAt: 0@2.
	game putXAt: 2@2.
	
	self assertGameOverNotTiedAndNeitherPlayerTurnIn: game.
	! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 19:34:42'!
test38PlayerOCannotPlaceWhenGameIsOver

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@1.
	game putXAt: 0@0.
	game putOAt: 0@2.
	game putXAt: 2@2.
		
	self should: [ game putOAt: 1@0 ]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlayWhenGameIsOverError.
	
	self deny: (game isOCell: 1@0).! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 19:52:44'!
test39PlayerXCannotSlideWhenGameIsOver

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@1.
	game putXAt: 2@0.
	game putOAt: 0@2.
	game putXAt: 1@2.
	game putOAt: 0@0.
	
	self should: [game slideXFrom: 1@2 to:  2@2]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlayWhenGameIsOverError.
	
	self deny: (game isXCell: 2@2).
	self assert: (game isXCell: 1@2).! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/15/2019 19:52:23'!
test40PlayerOCannotSlideWhenGameIsOver

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 0@2.
	game putOAt: 0@1.
	game putXAt: 1@2.
	game putOAt: 1@1.
	game putXAt: 2@1.
	game putOAt: 0@0.
	game slideXFrom: 2@1 to: 2@2.
	
	self should: [game slideOFrom: 1@1 to:  2@0]
		raise: Error -MessageNotUnderstood 
		withMessageText: TerniLapilliGame playerCannotPlayWhenGameIsOverError.
	
	self deny: (game isOCell: 2@0).
	self assert: (game isOCell: 1@1).! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/16/2019 15:13:54'!
test41PlayerXHasWon

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@1.
	game putOAt: 0@1.
	game putXAt: 2@2.
	game putOAt: 0@2.
	game putXAt: 0@0.
	
	self assert: game hasWonX.
	self deny: game hasWonO.
	
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/16/2019 15:14:13'!
test42PlayerOHasWon

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@0.
	game putOAt: 1@1.
	game putXAt: 2@0.
	game putOAt: 2@2.
	game putXAt: 0@1.
	game putOAt: 0@0.
	
	self assert: game hasWonO.
	self deny: game hasWonX.
	
! !

!TerniLapilliGameTest methodsFor: 'test' stamp: 'D 10/16/2019 15:13:20'!
test43GameIsTied

	| game |
	
	game := TerniLapilliGame new.
	game putXAt: 1@0.
	game putOAt: 1@1.
	game putXAt: 2@0.
	game putOAt: 2@2.

	
	self assert: game isTied.
	
! !


!TerniLapilliGameTest methodsFor: 'private assertions' stamp: 'D 10/17/2019 16:05:48'!
assertGameOverNotTiedAndNeitherPlayerTurnIn: game
	
	self assert: game isOver.
	self deny: game isTied.
	self deny: game isPlayingX.
	self deny: game isPlayingO.	! !

!TerniLapilliGameTest methodsFor: 'private assertions' stamp: 'D 10/17/2019 16:10:12'!
assertIsPlayerOTurnAndDoesNotOwn: aCell in: game
	
	self deny: (game isOCell: aCell).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'private assertions' stamp: 'D 10/17/2019 16:16:45'!
assertIsPlayerOTurnAndDoesOwn: aCell in: game
	
	self assert: (game isOCell: aCell).
	self assert: game isPlayingO.
! !

!TerniLapilliGameTest methodsFor: 'private assertions' stamp: 'D 10/17/2019 16:11:00'!
assertIsPlayerXTurnAndDoesNotOwn: aCell in: game
	
	self deny: (game isXCell: aCell).
	self assert: game isPlayingX.
! !

!TerniLapilliGameTest methodsFor: 'private assertions' stamp: 'D 10/17/2019 16:16:31'!
assertIsPlayerXTurnAndDoesOwn: aCell in: game
	
	self assert: (game isXCell: aCell).
	self assert: game isPlayingX.
! !


!classDefinition: #TerniLapilliGame category: #TerniLapilli!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'xChips oChips gameState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 18:49:03'!
allowedMoveByLinesFrom: originCell to: destinyCell

	| restrictedMoves |

	restrictedMoves := Dictionary new.
	restrictedMoves add: (Association key: 0@1 value: (OrderedCollection with: 1@2 with: 1@0)).
	restrictedMoves add: (Association key: 1@2 value: (OrderedCollection with: 0@1 with: 2@1)).
	restrictedMoves add: (Association key: 2@1 value: (OrderedCollection with: 1@2 with: 1@0)).
	restrictedMoves add: (Association key: 1@0 value: (OrderedCollection with: 0@1 with: 2@1)).
	
	^ ((restrictedMoves associationAt: originCell ifAbsent: [ ^ true ])  value includes: destinyCell) not. ! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/16/2019 17:35:25'!
areNeighbouringCells: aCell with: anotherCell
	
	^ (aCell dist: anotherCell) floor = 1! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:38:34'!
canWinWithPositions: positions

	^ (positions size = 3) and: ((self verticalLineIn: positions) or: ((self horizontalLineIn: positions) or: (self diagonalLineIn: positions))).! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/16/2019 17:36:07'!
connectedByLineFrom: originCell to: destinyCell
	
	^ (self areNeighbouringCells: originCell with: destinyCell) and: (self allowedMoveByLinesFrom: originCell to: destinyCell).! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:30:22'!
diagonalAscendingLineIn: positions

	^ (positions includes: 0@0) and: ((positions includes: 1@1) and: (positions includes: 2@2)).! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:31:01'!
diagonalDescendingLineIn: positions

	^ (positions includes: 0@2) and: ((positions includes: 1@1) and: (positions includes: 2@0)).! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:29:12'!
diagonalLineIn: positions

	^ (self diagonalAscendingLineIn: positions) or: (self diagonalDescendingLineIn: positions).! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:17:42'!
horizontalLineIn: positions

	^ positions allSatisfy: [:position | position y = positions first y]! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/17/2019 16:02:28'!
isGameOver
	^ self isXWinner or: self isOWinner.! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/17/2019 15:54:01'!
isOWinner
	^ self canWinWithPositions: oChips.! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/17/2019 15:53:47'!
isXWinner
	^ self canWinWithPositions: xChips.! !

!TerniLapilliGame methodsFor: 'private testing' stamp: 'D 10/15/2019 19:16:50'!
verticalLineIn: positions
	
	^ positions allSatisfy: [:position | position x = positions first x]! !


!TerniLapilliGame methodsFor: 'initialization' stamp: 'D 10/17/2019 15:49:53'!
initialize

	gameState := XPlacingChipsTerniLapilliGameState new.
	xChips := OrderedCollection new.
	oChips := OrderedCollection new.! !


!TerniLapilliGame methodsFor: 'private validations' stamp: 'D 10/16/2019 17:23:46'!
checkIfIsAnInRangeEmptyCell: aCell
	
	self checkValidationOfCell: aCell withError: self class cellNotValidError.

	(self isEmptyCell: aCell) ifFalse: [ self error: self class cellOccupiedError. ].
! !

!TerniLapilliGame methodsFor: 'private validations' stamp: 'D 10/16/2019 17:31:11'!
checkIfIsAnInRangeOccupiedByOCell: aCell
	
	self checkValidationOfCell: aCell withError: self class cellNotValidError .
	(oChips includes: aCell) ifFalse: [self error: self class playerCannotSlideChipFromAPositionNotOwnedError. ].
! !

!TerniLapilliGame methodsFor: 'private validations' stamp: 'D 10/16/2019 17:30:45'!
checkIfIsAnInRangeOccupiedByXCell: aCell
	
	self checkValidationOfCell: aCell withError: self class cellNotValidError .
	(xChips includes: aCell) ifFalse: [self error: self class playerCannotSlideChipFromAPositionNotOwnedError. ].
! !

!TerniLapilliGame methodsFor: 'private validations' stamp: 'D 10/15/2019 16:44:43'!
checkValidationOfCell: aCell withError: anErrorMessage.
	
	(aCell between: 0@0 and: 2@2) ifFalse: [self error: anErrorMessage]! !


!TerniLapilliGame methodsFor: 'placing' stamp: 'D 10/17/2019 15:33:45'!
putOAt: aCell

	self checkIfIsAnInRangeEmptyCell: aCell.

	gameState := gameState putOAt: aCell atGame: self.
 ! !

!TerniLapilliGame methodsFor: 'placing' stamp: 'D 10/17/2019 15:34:31'!
putXAt: aCell
	
	self checkIfIsAnInRangeEmptyCell: aCell.

	gameState := gameState putXAt: aCell atGame: self.! !


!TerniLapilliGame methodsFor: 'sliding' stamp: 'D 10/17/2019 15:50:16'!
slideOFrom: originCell to: destinyCell 

	self checkIfIsAnInRangeOccupiedByOCell: originCell.
	self checkIfIsAnInRangeEmptyCell: destinyCell .
	(self connectedByLineFrom: originCell to: destinyCell) ifFalse: [ self error: self class playerCannotSlideToAPositionNotFollowingPredefinedLinesError ].
		
	gameState := gameState slideOFrom: originCell to: destinyCell atGame: self.
! !

!TerniLapilliGame methodsFor: 'sliding' stamp: 'D 10/17/2019 15:50:30'!
slideXFrom: originCell to: destinyCell 
	
	self checkIfIsAnInRangeOccupiedByXCell: originCell.
	self checkIfIsAnInRangeEmptyCell: destinyCell.
	(self connectedByLineFrom: originCell to: destinyCell) ifFalse: [ self error: self class playerCannotSlideToAPositionNotFollowingPredefinedLinesError ].

	gameState := gameState slideXFrom: originCell to: destinyCell atGame: self.
! !


!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/17/2019 15:58:05'!
hasWonO
	^ gameState hasWonOAtGame: self.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/17/2019 15:58:13'!
hasWonX
	^ gameState hasWonXAtGame: self.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/15/2019 17:04:14'!
isEmptyCell: aCell

	^ (xChips includes: aCell) not and: (oChips includes: aCell) not.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'mr 10/10/2019 18:33:32'!
isOCell: aCell 

	^ oChips includes: aCell! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/17/2019 15:42:23'!
isOver
	^ gameState isOver.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/17/2019 15:40:51'!
isPlayingO

	^ gameState isPlayingO.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/17/2019 15:36:42'!
isPlayingX
	
	^ gameState isPlayingX.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'D 10/16/2019 15:14:56'!
isTied
	^ self isOver not.! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'mr 10/10/2019 18:33:57'!
isXCell: aCell 

	^ xChips includes: aCell! !


!TerniLapilliGame methodsFor: 'private accessing' stamp: 'D 10/16/2019 16:38:18'!
amountOfOChips

	^ oChips size.! !

!TerniLapilliGame methodsFor: 'private accessing' stamp: 'D 10/16/2019 16:38:10'!
amountOfXChips

	^ xChips size.! !


!TerniLapilliGame methodsFor: 'private placing' stamp: 'D 10/16/2019 16:35:53'!
placeOChipAt: aCell

	oChips add: aCell.! !

!TerniLapilliGame methodsFor: 'private placing' stamp: 'D 10/16/2019 16:35:45'!
placeXChipAt: aCell

	xChips add: aCell.! !


!TerniLapilliGame methodsFor: 'private sliding' stamp: 'D 10/16/2019 16:56:39'!
slideOChipFrom: originCell to: destinyCell

	oChips remove: originCell.
	oChips add: destinyCell.! !

!TerniLapilliGame methodsFor: 'private sliding' stamp: 'D 10/16/2019 16:56:24'!
slideXChipFrom: originCell to: destinyCell

	xChips remove: originCell.
	xChips add: destinyCell.! !

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

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 19:35:34'!
playerCannotPlayWhenGameIsOverError
	^ 'You cannot play when game is over' ! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 16:11:00'!
playerCannotSlideBeforePlacingThreeChipsError
	^ 'Place all your chips before sliding them'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/17/2019 15:33:04'!
playerCannotSlideChipFromAPositionNotOwnedError
	^ 'You cannot slide a chip from a position you do not own'! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 17:40:37'!
playerCannotSlideToANotNeighbourPositionError
	self shouldBeImplemented.! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'D 10/15/2019 17:43:19'!
playerCannotSlideToAPositionNotFollowingPredefinedLinesError
	
	^ 'You cannot slide to that position. You can only slide to neighbouring positions set by the lines of the board.'! !


!classDefinition: #TerniLapilliGameState category: #TerniLapilli!
Object subclass: #TerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/16/2019 16:51:34'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !

!TerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/16/2019 16:51:28'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !


!TerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/16/2019 16:36:11'!
putOAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility.! !

!TerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/16/2019 16:30:26'!
putXAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility.! !


!TerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:57:34'!
hasWonOAtGame: aTerniLapilliGame

	^ false.! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:57:45'!
hasWonXAtGame: aTerniLapilliGame

	^ false.! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:56:12'!
isOver

	^ false.! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 16:24:55'!
isPlayingO
	
	self subclassResponsibility .! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 16:24:52'!
isPlayingX
	
	self subclassResponsibility .! !


!classDefinition: #GameOverTerniLapilliGameState category: #TerniLapilli!
TerniLapilliGameState subclass: #GameOverTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/16/2019 16:58:30'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayWhenGameIsOverError.! !

!GameOverTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/16/2019 16:58:35'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayWhenGameIsOverError.! !


!GameOverTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/16/2019 16:39:27'!
putOAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayWhenGameIsOverError .! !

!GameOverTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/16/2019 16:39:33'!
putXAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayWhenGameIsOverError .! !


!GameOverTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:57:16'!
hasWonOAtGame: aTerniLapilliGame

	^ aTerniLapilliGame isOWinner.

	! !

!GameOverTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:57:06'!
hasWonXAtGame: aTerniLapilliGame

	^ aTerniLapilliGame isXWinner.

	! !

!GameOverTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:51:56'!
isOver

	^ true.! !

!GameOverTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:37:22'!
isPlayingO

	^ false.! !

!GameOverTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:37:19'!
isPlayingX

	^ false.! !


!classDefinition: #PlacingChipsTerniLapilliGameState category: #TerniLapilli!
TerniLapilliGameState subclass: #PlacingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:46:14'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !

!PlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:46:04'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !


!PlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:45:14'!
putOAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility ! !

!PlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:45:19'!
putXAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility ! !


!PlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:38:19'!
isPlayingO
	
	self subclassResponsibility ! !

!PlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:38:22'!
isPlayingX
	
	self subclassResponsibility ! !


!classDefinition: #OPlacingChipsTerniLapilliGameState category: #TerniLapilli!
PlacingChipsTerniLapilliGameState subclass: #OPlacingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OPlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:45:34'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotSlideBeforePlacingThreeChipsError.! !

!OPlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:31:38'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !


!OPlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:51:18'!
putOAt: aCell atGame: aTerniLapilliGame

	aTerniLapilliGame placeOChipAt: aCell.
	
	aTerniLapilliGame isGameOver ifTrue: [ ^ GameOverTerniLapilliGameState new. ].
	
	aTerniLapilliGame amountOfXChips = 3 ifTrue: [ ^ XSlidingChipsTerniLapilliGameState new ].
	
	^ XPlacingChipsTerniLapilliGameState new.! !

!OPlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:27:25'!
putXAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError.! !


!OPlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:39:16'!
isPlayingO

	^ true.! !

!OPlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:39:03'!
isPlayingX

	^ false.! !


!classDefinition: #XPlacingChipsTerniLapilliGameState category: #TerniLapilli!
PlacingChipsTerniLapilliGameState subclass: #XPlacingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XPlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:31:22'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError.! !

!XPlacingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:45:48'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotSlideBeforePlacingThreeChipsError.! !


!XPlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:30:29'!
putOAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !

!XPlacingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:43:16'!
putXAt: aCell atGame: aTerniLapilliGame

	aTerniLapilliGame placeXChipAt: aCell.
	
	aTerniLapilliGame isGameOver ifTrue: [ ^ GameOverTerniLapilliGameState new. ].
		
	^ OPlacingChipsTerniLapilliGameState new.! !


!XPlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:39:37'!
isPlayingO

	^ false.! !

!XPlacingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:39:34'!
isPlayingX

	^ true.! !


!classDefinition: #SlidingChipsTerniLapilliGameState category: #TerniLapilli!
TerniLapilliGameState subclass: #SlidingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:48:17'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !

!SlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:48:11'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !


!SlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:46:43'!
putOAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility .! !

!SlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:46:56'!
putXAt: aCell atGame: aTerniLapilliGame

	self subclassResponsibility .
	! !


!SlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:38:28'!
isPlayingO
	
	self subclassResponsibility ! !

!SlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:38:36'!
isPlayingX
	
	self subclassResponsibility ! !


!classDefinition: #OSlidingChipsTerniLapilliGameState category: #TerniLapilli!
SlidingChipsTerniLapilliGameState subclass: #OSlidingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OSlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:43:41'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	aTerniLapilliGame slideOChipFrom: originCell to: destinyCell.
	
	aTerniLapilliGame isGameOver ifTrue: [ ^ GameOverTerniLapilliGameState new ].
	
	^ XSlidingChipsTerniLapilliGameState new.! !

!OSlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:24:43'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !


!OSlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:47:30'!
putOAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlaceMoreThanThreeChips .! !

!OSlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:22:20'!
putXAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !


!OSlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:40:02'!
isPlayingO

	^ true.! !

!OSlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:39:51'!
isPlayingX

	^ false.! !


!classDefinition: #XSlidingChipsTerniLapilliGameState category: #TerniLapilli!
SlidingChipsTerniLapilliGameState subclass: #XSlidingChipsTerniLapilliGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XSlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:25:58'!
slideOFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !

!XSlidingChipsTerniLapilliGameState methodsFor: 'sliding' stamp: 'D 10/17/2019 15:43:48'!
slideXFrom: originCell to: destinyCell atGame: aTerniLapilliGame

	aTerniLapilliGame slideXChipFrom: originCell to: destinyCell.
	
	aTerniLapilliGame isGameOver ifTrue: [ ^ GameOverTerniLapilliGameState new ].
	
	^ OSlidingChipsTerniLapilliGameState new.! !


!XSlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:22:35'!
putOAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlayTwoTimesInARowError .! !

!XSlidingChipsTerniLapilliGameState methodsFor: 'placing' stamp: 'D 10/17/2019 15:47:44'!
putXAt: aCell atGame: aTerniLapilliGame

	self error: TerniLapilliGame playerCannotPlaceMoreThanThreeChips .! !


!XSlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:40:08'!
isPlayingO

	^ false.! !

!XSlidingChipsTerniLapilliGameState methodsFor: 'testing' stamp: 'D 10/17/2019 15:40:14'!
isPlayingX

	^ true.! !
