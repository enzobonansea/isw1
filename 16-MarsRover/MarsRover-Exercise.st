!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverInOriginPoitingToNorth marsRoverInOriginPoitingToSouth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'private' stamp: 'ja 10/25/2020 13:58:30'!
assertThat: aMarsRover isInPosition: aPosition poitingTo: aCardinalPoint
	
	self assert: (aMarsRover isInPosition: aPosition).
	
	self assert: (aMarsRover isPointingTo: aCardinalPoint).
	! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'ja 10/25/2020 13:54:40'!
setUp 
	
	marsRoverInOriginPoitingToNorth _ MarsRover inPosition: (0@0) andCardinalPoint: $N.
	
	marsRoverInOriginPoitingToSouth _ MarsRover inPosition: (0@0) andCardinalPoint: $S.! !


!MarsRoverTest methodsFor: 'testing-composed movements' stamp: 'ja 10/25/2020 14:13:37'!
test07MakesComposedMovementCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'frr'.
	
	marsRoverInOriginPoitingToSouth move: 'frr'.
		
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@1)  poitingTo: $S.

	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@-1)  poitingTo: $N.
	

	! !

!MarsRoverTest methodsFor: 'testing-composed movements' stamp: 'ja 10/25/2020 14:42:52'!
test08ComposedMovementIsExecutedUntilInvalidCommandFound
	
	| marsRoverThatWillReceiveInvalidCommand marsRoverThatWillNotReceiveInvalidCommand |
	
	marsRoverThatWillReceiveInvalidCommand _ MarsRover inPosition: (0@0) andCardinalPoint: $N.
	marsRoverThatWillNotReceiveInvalidCommand _ MarsRover inPosition: (0@0) andCardinalPoint: $N.
	
	marsRoverThatWillReceiveInvalidCommand move: 'frrjb'.
	marsRoverThatWillNotReceiveInvalidCommand move: 'frr'.
	
	self  assert: marsRoverThatWillReceiveInvalidCommand = marsRoverThatWillNotReceiveInvalidCommand .! !


!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:03:03'!
test02MovesForwardCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'f'.
	
	marsRoverInOriginPoitingToSouth move: 'f'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@1)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@-1) poitingTo: $S.
	
	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:04:57'!
test03MovesRigthCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'r'.
	
	marsRoverInOriginPoitingToSouth move: 'r'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $E.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0) poitingTo: $W.

	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:06:05'!
test04MovesLeftCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'l'.
	
	marsRoverInOriginPoitingToSouth move: 'l'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $W.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0) poitingTo: $E.

	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:07:27'!
test05MovesBackwardCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'b'.
	
	marsRoverInOriginPoitingToSouth move: 'b'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@-1)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@1) poitingTo: $S.
	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:09:56'!
test06DoNothingOnInvalidCommand
	
	marsRoverInOriginPoitingToNorth move: 'k'.
	
	marsRoverInOriginPoitingToSouth move: 'k'.
		
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0) poitingTo: 	$N.

	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0) poitingTo: 	$S.
	
	
	
	! !


!MarsRoverTest methodsFor: 'testing-initialization' stamp: 'ja 10/25/2020 14:01:22'!
test01AtTheBeginningHasPositionAndCardinalPoint
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0)  poitingTo: $S.
	! !


!MarsRoverTest methodsFor: 'testing-input validation' stamp: 'ja 10/25/2020 14:54:10'!
test09PositionShouldBeAPoint

	| invalidMarsRover |
	
	self should: [invalidMarsRover _ MarsRover inPosition: 'something' andCardinalPoint: $N. self fail]
	      raise: Error 
	      withMessageText: MarsRover invalidPositionProvidedErrorDescription.
	! !

!MarsRoverTest methodsFor: 'testing-input validation' stamp: 'ja 10/25/2020 14:59:26'!
test10CardinalPointShouldBeValid

	| invalidMarsRover |
	
	self should: [invalidMarsRover _ MarsRover inPosition: (0@0) andCardinalPoint: $K. self fail]
	      raise: Error 
	      withMessageText: MarsRover invalidCardinalPointProvidedErrorDescription.
	! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position marsRoverCardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'ja 10/25/2020 14:39:02'!
initializeInPosition: aPosition andCardinalPoint: aMarsRoverCardinalPoint 
	
	position := aPosition.
	
	marsRoverCardinalPoint := aMarsRoverCardinalPoint .! !


!MarsRover methodsFor: 'testing' stamp: 'ja 10/25/2020 14:39:35'!
isInPosition: aPosition 
	
	^ position = aPosition .! !

!MarsRover methodsFor: 'testing' stamp: 'ja 10/25/2020 12:22:57'!
isPointingTo: aCardinalPoint 
	
	^ marsRoverCardinalPoint is: aCardinalPoint  .! !


!MarsRover methodsFor: 'accessing' stamp: 'ja 10/25/2020 14:39:46'!
marsRoverCardinalPoint
	
	^ marsRoverCardinalPoint! !

!MarsRover methodsFor: 'accessing' stamp: 'ja 10/25/2020 13:31:37'!
position
	
	^position! !


!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 12:46:08'!
pointToEast

	marsRoverCardinalPoint _ East new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 12:46:20'!
pointToNorth

	marsRoverCardinalPoint _ North new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 12:46:34'!
pointToSouth

	marsRoverCardinalPoint _ South new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 12:46:43'!
pointToWest

	marsRoverCardinalPoint _ West new.! !


!MarsRover methodsFor: 'movement' stamp: 'ja 10/25/2020 14:40:18'!
move: commands
											
	commands do: [ :command | [ marsRoverCardinalPoint move: self following: command ] on: Error do: [ ^ self ]]! !


!MarsRover methodsFor: 'comparation' stamp: 'ja 10/25/2020 13:27:45'!
= anOtherMarsRover

	^ position = anOtherMarsRover position and: (marsRoverCardinalPoint = anOtherMarsRover 	marsRoverCardinalPoint).! !


!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:16'!
decrementPositionX

	position _ position - (1@0).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:35'!
decrementPositionY

	position _ position - (0@1).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:43'!
incrementPositionX

	position _ position + (1@0).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:55'!
incrementPositionY

	position _ position + (0@1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error handling' stamp: 'ja 10/25/2020 15:00:02'!
invalidCardinalPointProvidedErrorDescription

	^ 'El punto cardinal es invalido'! !

!MarsRover class methodsFor: 'error handling' stamp: 'ja 10/25/2020 15:02:54'!
invalidCardinalPointProvidedErrorSignal
	
	self error: self invalidCardinalPointProvidedErrorDescription .! !

!MarsRover class methodsFor: 'error handling' stamp: 'ja 10/25/2020 13:04:27'!
invalidComandErrorDescription
	
	^ 'Comando invalido'! !

!MarsRover class methodsFor: 'error handling' stamp: 'ja 10/25/2020 13:11:36'!
invalidComandErrorSignal
	
	self error: self invalidComandErrorDescription ! !

!MarsRover class methodsFor: 'error handling' stamp: 'ja 10/25/2020 14:55:06'!
invalidPositionProvidedErrorDescription

	^ 'La posición debe ser un punto'! !


!MarsRover class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 15:00:32'!
inPosition: aPosition andCardinalPoint: aCardinalPoint
	
	| marsRoverCardinalPoint |
	
	(aPosition isKindOf: Point) ifFalse: [self error: self invalidPositionProvidedErrorDescription ].
	
	marsRoverCardinalPoint _ MarsRoverCardinalPoint from: aCardinalPoint .
	
	^ self new initializeInPosition: aPosition andCardinalPoint: marsRoverCardinalPoint .! !


!classDefinition: #MarsRoverCardinalPoint category: #'MarsRover-Exercise'!
Object subclass: #MarsRoverCardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCardinalPoint methodsFor: 'movement' stamp: 'ja 10/25/2020 14:20:56'!
move: aMarsRover following: aCommand

	self subclassResponsibility ! !


!MarsRoverCardinalPoint methodsFor: 'testing' stamp: 'ja 10/25/2020 12:24:51'!
is: aCardinalPoint 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalPoint class' category: #'MarsRover-Exercise'!
MarsRoverCardinalPoint class
	instanceVariableNames: 'uniqueInstance'!

!MarsRoverCardinalPoint class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 15:03:22'!
from: aCardinalPoint

	aCardinalPoint = $N ifTrue: [ ^ North new].
	aCardinalPoint = $S ifTrue: [ ^ South new].
	aCardinalPoint = $E ifTrue: [ ^ East new].
	aCardinalPoint = $W ifTrue: [ ^ West new].
	
	MarsRover invalidCardinalPointProvidedErrorSignal .
	! !

!MarsRoverCardinalPoint class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 13:36:00'!
new

	uniqueInstance ifNil: [ uniqueInstance _  self basicNew ].
	^ uniqueInstance  ! !


!classDefinition: #East category: #'MarsRover-Exercise'!
MarsRoverCardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'movement' stamp: 'ja 10/25/2020 14:21:13'!
move: aMarsRover following: aCommand

	aCommand = $f ifTrue: [^ aMarsRover incrementPositionX ].
	aCommand = $b ifTrue: [^ aMarsRover decrementPositionX ].
	aCommand = $r ifTrue: [^ aMarsRover pointToSouth ].
	aCommand = $l ifTrue: [^ aMarsRover pointToNorth ].
	
	aMarsRover class invalidComandErrorSignal.! !


!East methodsFor: 'testing' stamp: 'ja 10/25/2020 12:25:37'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $E! !


!classDefinition: #North category: #'MarsRover-Exercise'!
MarsRoverCardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:06'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $N! !


!North methodsFor: 'movement' stamp: 'ja 10/25/2020 14:21:27'!
move: aMarsRover following: aCommand

	aCommand = $f ifTrue: [^ aMarsRover incrementPositionY ].
	aCommand = $b ifTrue: [^ aMarsRover decrementPositionY ].
	aCommand = $r ifTrue: [^ aMarsRover pointToEast ].
	aCommand = $l ifTrue: [^ aMarsRover pointToWest ].
	
	aMarsRover class invalidComandErrorSignal.
	! !


!classDefinition: #South category: #'MarsRover-Exercise'!
MarsRoverCardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:12'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $S! !


!South methodsFor: 'movement' stamp: 'ja 10/25/2020 14:21:38'!
move: aMarsRover following: aCommand

	aCommand = $f ifTrue: [^ aMarsRover decrementPositionY ].
	aCommand = $b ifTrue: [^ aMarsRover incrementPositionY ].
	aCommand = $r ifTrue: [^ aMarsRover pointToWest ].
	aCommand = $l ifTrue: [^ aMarsRover pointToEast ].
	
	aMarsRover class invalidComandErrorSignal.! !


!classDefinition: #West category: #'MarsRover-Exercise'!
MarsRoverCardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:17'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $W! !


!West methodsFor: 'movement' stamp: 'ja 10/25/2020 14:21:49'!
move: aMarsRover following: aCommand

	aCommand = $f ifTrue: [^ aMarsRover decrementPositionX ].
	aCommand = $b ifTrue: [^ aMarsRover incrementPositionX ].
	aCommand = $r ifTrue: [^ aMarsRover pointToNorth ].
	aCommand = $l ifTrue: [^ aMarsRover pointToSouth ].
	
	aMarsRover class invalidComandErrorSignal.! !
