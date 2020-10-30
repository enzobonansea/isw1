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

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 19:27:02'!
test03OPlaysAfterX
	
	| game |
	
	game _ TerniLapilli new.
	
	game putXAt: 0@0 .
	
	self assert: game isPlayingO .
	
	self deny: game isPlayingX .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 19:26:05'!
test04XPlaysAfterO
	
	| game |
	
	game _ TerniLapilli new.
	
	game putXAt: 0@0 .
	
	game putOAt: 0@1 .
	
	self assert: game isPlayingX .
	
	self deny: game isPlayingO .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:03:30'!
test05XTokensShouldBePlacedIntoBoardInAValidPosition

	| game |
	
	game _ TerniLapilli new .
	
	self should: [ game putXAt: -1@0. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0@-1. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 3@0. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0@3. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putXAt: 0.5@1. self fail.]
		raise: Error
		withMessageText: game class playerPositionIsInvalidErrorDescription.
	
	self should: [ game putXAt: 1@0.5. self fail.]
		raise: Error
		withMessageText: game class playerPositionIsInvalidErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:03:42'!
test06OTokensShouldBePlacedIntoBoardnAValidPosition

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0.
	
	self should: [ game putOAt: -1@0. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0@-1. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 3@0. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0@3. self fail.]
		raise: Error
		withMessageText: game class playerIsOutsideBoardErrorDescription.
		
	self should: [ game putOAt: 0.5@1. self fail.]
		raise: Error
		withMessageText: game class playerPositionIsInvalidErrorDescription.
	
	self should: [ game putOAt: 1@0.5. self fail.]
		raise: Error
		withMessageText: game class playerPositionIsInvalidErrorDescription.! !

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

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 10/29/2020 21:24:08'!
test11OTokensCanBeMovedOnlyWhenThereAreThreeOTokens

	| game |
	
	game _ TerniLapilli new .
	
	game putXAt: 0@0 .
	
	game putOAt: 0@2 .
	
	game putXAt: 1@0.
	
	game putOAt: 1@1 .
	
	game putXAt: 2@0.
	
	self should: [ game moveOTokenFrom: 0@2 to: 0@1. self fail. ] 
		raise: Error
		withMessageText: game class movementsCanOnlyBeDoneWithThreeTokens .! !


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


!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 19:18:33'!
boardIsEmpty
	
	^ XTokens isEmpty and: [ OTokens  isEmpty ] .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 19:28:36'!
isPlayingO
	
	^ isPlayingX not .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 17:52:57'!
isPlayingX

	^ isPlayingX.! !


!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/29/2020 21:24:25'!
moveOTokenFrom: aSourcePoint to: aTargetPoint
	
	self error: self class movementsCanOnlyBeDoneWithThreeTokens.! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/29/2020 21:23:05'!
moveXTokenFrom: aSourcePoint to: aTargetPoint
	
	self error: self class movementsCanOnlyBeDoneWithThreeTokens.! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/29/2020 20:56:13'!
putOAt: aPoint 

	(self board containsPoint: aPoint) ifFalse: [ self error: self class playerIsOutsideBoardErrorDescription ].
	
	(aPoint isIntegerPoint) ifFalse: [self error: self class playerPositionIsInvalidErrorDescription ].
	
	(XTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(OTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
		
	isPlayingX ifTrue: [ self error: self class playerXShouldPlayErrorDescription ].
	
	OTokens add: aPoint .
		
	isPlayingX _ true .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 10/29/2020 21:10:39'!
putXAt: aPoint 
	
	(self board containsPoint: aPoint) ifFalse: [ self error: self class playerIsOutsideBoardErrorDescription ].
	
	(aPoint isIntegerPoint) ifFalse: [self error: self class playerPositionIsInvalidErrorDescription ].
	
	(XTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(OTokens includes: aPoint) ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].
	
	(XTokens size = 3) ifTrue: [self error: self class cannotPutMoreThanThreeXTokensErrorDescription ].
	
	XTokens add: aPoint .
	
	isPlayingX _ false .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 21:08:44'!
cannotPutMoreThanThreeXTokensErrorDescription
	
	^ 'Cannot put more than three X tokens into board' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 21:20:13'!
movementsCanOnlyBeDoneWithThreeTokens
	
	^ 'Movements can only be done with three tokens'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 19:33:28'!
playerIsOutsideBoardErrorDescription
	
	^ 'Player is outside board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 20:42:06'!
playerPositionIsInvalidErrorDescription

	^ 'Player position is invalid'.
! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 19:38:22'!
playerXShouldPlayErrorDescription

	^ 'Player X should play' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 20:50:12'!
positionIsNotAvailableErrorDescription
	
	^ 'Position is not available'.! !
