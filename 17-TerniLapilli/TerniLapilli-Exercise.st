!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 19:16:38'!
test01AtTheBeginningBoardIsEmptyAndXShouldPlay
	
	| game |
	
	game _ TerniLapilli new .
	
	self assert: game boardIsEmpty.
	
	self assert: game isPlayingX .
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 19:20:17'!
test02OCannotInitGame
	
	| game |
	
	game _ TerniLapilli new.
	
	self should: [ game putOAt: 0@0. self fail. ]
		raise: Error
		withMessageText: game class playerXShouldPlayErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:45:17'!
test03OPutsAfterX
	
	| game |
	
	game _ TerniLapilli new.
	
	game putXAt: 0@0 .
	
	self assert: game isPlayingO .
	
	self deny: game isPlayingX .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:45:26'!
test04XPutsAfterO
	
	| game |
	
	game _ TerniLapilli new.
	
	game putXAt: 0@0 .
	
	game putOAt: 0@1 .
	
	self assert: game isPlayingX .
	
	self deny: game isPlayingO .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:45:39'!
test05XTokensShouldBePlacedIntoBoardInAValidPosition

	| game |
	
	game _ TerniLapilli new .
	
	self should: [ game putXAt: -1@0. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0@-1. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 3@0. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0@3. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0.5@1. self fail.]
		raise: Error
		withMessageText: game class positionIsInvalidErrorDescription.
	
	self should: [ game putXAt: 1@0.5. self fail.]
		raise: Error
		withMessageText: game class positionIsInvalidErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:45:39'!
test06OTokensShouldBePlacedIntoBoardnAValidPosition

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0.
	
	self should: [ game putOAt: -1@0. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0@-1. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 3@0. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0@3. self fail.]
		raise: Error
		withMessageText: game class positionIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0.5@1. self fail.]
		raise: Error
		withMessageText: game class positionIsInvalidErrorDescription.
	
	self should: [ game putOAt: 1@0.5. self fail.]
		raise: Error
		withMessageText: game class positionIsInvalidErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:03:49'!
test07XTokensShouldBePlacedIntoAvailablePositions
	
	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 1@0.
	
	self should: [ game putXAt: 0@0. self fail. ]
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription.
		
	self should: [ game putXAt: 1@0. self fail. ]
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:03:58'!
test08OTokensShouldBePlacedIntoAvailablePositions
	
	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 1@0.
	
	game putXAt: 1@1 .
	
	self should: [ game putOAt: 0@0. self fail. ]
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription.
		
	self should: [ game putOAt: 1@0. self fail. ]
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:08:08'!
test09XTokensShouldNotBeMoreThanThree

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@1 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 1@2 .
	
	game putOAt: 2@1 .
	
	self should: [ game putXAt: 2@2. self fail.]
		raise: Error
		withMessageText: game class cannotPutMoreThanThreeXTokensErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:20:53'!
test10XTokensCanBeMovedOnlyWhenThereAreThreeXTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	self should: [ game moveXTokenFrom: 0@0 to: 0@1. self fail. ] 
		raise: Error
		withMessageText: game class movementsCanOnlyBeDoneWithThreeTokens .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:17:27'!
test11OTokensCanBeMovedOnlyWhenThereAreThreeOTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	self should: [ game moveOTokenFrom: 0@2 to: 1@2. self fail. ] 
		raise: Error
		withMessageText: game class movementsCanOnlyBeDoneWithThreeTokens .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:20:48'!
test12XTokensCannotBeMovedToPositionsWithOTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	self should: [ game moveXTokenFrom: 1@0 to: 1@1. self fail. ] 
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:28:55'!
test13XTokensCannotBeMovedToPositionsWithXTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	self should: [ game moveXTokenFrom: 1@0 to: 0@0. self fail. ] 
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:32:22'!
test14OTokensCannotBeMovedToPositionsWithOTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	game moveXTokenFrom: 1@0 to: 2@0.
	
	self should: [ game moveOTokenFrom: 1@1 to: 1@2. self fail. ] 
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:59:06'!
test15OTokensCannotBeMovedToPositionsWithXTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	game moveXTokenFrom: 1@0 to: 2@0.
	
	self should: [ game moveOTokenFrom: 1@1 to: 2@0. self fail. ] 
		raise: Error
		withMessageText: game class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:46:57'!
test16XCannotMoveTwice

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	game moveXTokenFrom: 1@0 to: 2@0.
	
	self should: [ game moveXTokenFrom: 2@0 to: 2@1. self fail. ] 
		raise: Error
		withMessageText: game class cannotMoveTwiceErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 14:54:23'!
test17OCannotMoveTwice

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	game moveXTokenFrom: 1@0 to: 2@0.
	
	game moveOTokenFrom: 1@1 to: 2@1.
	
	self should: [ game moveOTokenFrom: 2@1 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: game class cannotMoveTwiceErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:12:47'!
test18XMovementsLengthShouldBeOne

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
		
	self should: [ game moveXTokenFrom: 1@0 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: game class movementsLengthShouldBeOneErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:27:47'!
test19OMovementsLengthShouldBeOne

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
	
	game moveXTokenFrom: 1@0 to: 2@0 .
		
	self should: [ game moveOTokenFrom: 0@2 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: game class movementsLengthShouldBeOneErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:33:11'!
test20XTokensMovementsSourcesAreAlreadyInBoard

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
		
	self should: [ game moveXTokenFrom: 2@2 to: 2@1 . self fail. ] 
		raise: Error
		withMessageText: game class movementSourceHasNotTokenErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/31/2020 15:40:10'!
test21OTokensMovementsSourcesAreAlreadyInBoard

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 0@1.
	
	game putOAt: 1@2.
		
	game moveXTokenFrom: 1@0 to: 2@0.
	
	self should: [ game moveOTokenFrom: 2@2 to: 2@1. self fail. ] 
		raise: Error
		withMessageText: game class movementSourceHasNotTokenErrorDescription .! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'XTokens OTokens isPlayingX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'accessing' stamp: 'eb 10/29/2020 20:34:03'!
board
	
	^ 0@0 corner: 3@3 .! !


!TerniLapilli methodsFor: 'initialization' stamp: 'eb 10/29/2020 19:28:15'!
initialize

	XTokens _ OrderedCollection new .
	
	OTokens _ OrderedCollection new .
		
	isPlayingX _ true .! !


!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/31/2020 15:25:37'!
assertThat: aSourcePoint isWithinOneUnitDistanceTo: aTargetPoint
	
	| dX dY verticalDistanceIsOne horizontalDistanceIsOne diagonalDistanceIsOne |
	
	dX _ (aSourcePoint x - aTargetPoint x) abs.
	
	dY _ (aSourcePoint y - aTargetPoint y) abs.
	
	verticalDistanceIsOne _ (dX = 0 and: [dY = 1]) .
	
	horizontalDistanceIsOne _ (dX = 1 and: [dY = 0]).
	
	diagonalDistanceIsOne _ (dX = 1 and: [dY = 1]).
	
	(verticalDistanceIsOne or: horizontalDistanceIsOne or: diagonalDistanceIsOne) ifFalse: 
		[ self error: self class movementsLengthShouldBeOneErrorDescription .]! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 19:18:33'!
boardIsEmpty
	
	^ XTokens isEmpty and: [ OTokens  isEmpty ] .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 19:28:36'!
isPlayingO
	
	^ isPlayingX not .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 17:52:57'!
isPlayingX

	^ isPlayingX.! !


!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/31/2020 15:41:51'!
moveOTokenFrom: aSourcePoint to: aTargetPoint
	
	(OTokens size < 3) ifTrue: [ self error: self class movementsCanOnlyBeDoneWithThreeTokens. ].
	
	((XTokens includes: aTargetPoint ) or: [ OTokens includes: aTargetPoint ]) 
		ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
		
	isPlayingX ifTrue: [ self error: self class cannotMoveTwiceErrorDescription ].
		
	self assertThat: aSourcePoint isWithinOneUnitDistanceTo: aTargetPoint.
	
	((XTokens includes: aSourcePoint ) or: [ OTokens includes: aSourcePoint ]) 
		ifFalse: [self error: self class movementSourceHasNotTokenErrorDescription ].
	
	OTokens remove: aSourcePoint .
	
	OTokens add: aTargetPoint .
	
	isPlayingX _ true .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/31/2020 15:38:03'!
moveXTokenFrom: aSourcePoint to: aTargetPoint

	(XTokens size < 3) ifTrue: [ self error: self class movementsCanOnlyBeDoneWithThreeTokens. ].
	
	((XTokens includes: aTargetPoint ) or: [ OTokens includes: aTargetPoint ]) 
		ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
		
	isPlayingX ifFalse: [ self error: self class cannotMoveTwiceErrorDescription ].
	
	self assertThat: aSourcePoint isWithinOneUnitDistanceTo: aTargetPoint.
	
	((XTokens includes: aSourcePoint ) or: [ OTokens includes: aSourcePoint ]) 
		ifFalse: [ self error: self class movementSourceHasNotTokenErrorDescription ].
		
	XTokens remove: aSourcePoint .
	
	XTokens add: aTargetPoint .
	
	isPlayingX _ false .
	
! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/31/2020 15:45:39'!
putOAt: aPoint 

	(self board containsPoint: aPoint) ifFalse: [ self error: self class positionIsOutsideBoardErrorDescription ].
	
	(aPoint isIntegerPoint) ifFalse: [self error: self class positionIsInvalidErrorDescription ].
	
	(XTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(OTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
		
	isPlayingX ifTrue: [ self error: self class playerXShouldPlayErrorDescription ].
	
	OTokens add: aPoint .
		
	isPlayingX _ true .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/31/2020 15:45:39'!
putXAt: aPoint 
	
	(self board containsPoint: aPoint) ifFalse: [ self error: self class positionIsOutsideBoardErrorDescription ].
	
	(aPoint isIntegerPoint) ifFalse: [self error: self class positionIsInvalidErrorDescription ].
	
	(XTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(OTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(XTokens size = 3) ifTrue: [self error: self class cannotPutMoreThanThreeXTokensErrorDescription ].
	
	XTokens add: aPoint .
	
	isPlayingX _ false .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 14:48:02'!
cannotMoveTwiceErrorDescription

	^ 'Player cannot move twice'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 21:08:44'!
cannotPutMoreThanThreeXTokensErrorDescription
	
	^ 'Cannot put more than three X tokens into board' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:33:58'!
movementSourceHasNotTokenErrorDescription

	^ 'Movement source has not token'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 21:20:13'!
movementsCanOnlyBeDoneWithThreeTokens
	
	^ 'Movements can only be done with three tokens'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:17:55'!
movementsLengthShouldBeOneErrorDescription

	^ 'Movements length should be one'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 19:38:22'!
playerXShouldPlayErrorDescription

	^ 'Player X should play' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:44:58'!
positionIsInvalidErrorDescription

	^ 'Position is invalid'.
! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 20:50:12'!
positionIsNotAvailableErrorDescription
	
	^ 'Position is not available'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:45:39'!
positionIsOutsideBoardErrorDescription
	
	^ 'Position is outside board'.! !
