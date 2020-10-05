!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'eb 10/4/2020 20:56:51'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements topElement topIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'eb 10/4/2020 20:42:01'!
initialize
	elements := OrderedCollection new .
	topElement := EmptyStackTop new .
	topIndex  := OOStackIndex new initializeWith: 1.! !


!OOStack methodsFor: 'operations' stamp: 'eb 10/4/2020 20:42:07'!
isEmpty
	^ topIndex indexValue = 1 .! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/4/2020 21:00:14'!
pop
	| topValue |
	
	topValue := topElement topValue .
	
	topIndex dec.
	
	self removeElementsAfterIndex .
	
	self resetTopElement .
		
	^ topValue .
	
	! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/4/2020 21:12:49'!
push: anElement 
	elements  add: anElement.	topElement := NotEmptyStackTop new initializeWith: anElement .
	topIndex  inc .
	! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/4/2020 20:42:29'!
size
	^ topIndex indexValue - 1.! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/4/2020 20:33:40'!
top
	^ topElement topValue .! !


!OOStack methodsFor: 'private' stamp: 'eb 10/4/2020 21:08:28'!
removeElementsAfterIndex
	
	elements := elements select: [ :each | (elements indexOf: each) <= topIndex indexValue ].! !

!OOStack methodsFor: 'private' stamp: 'eb 10/4/2020 21:16:08'!
resetTopElement
	(topIndex indexValue = 1) 
		ifTrue: [topElement := EmptyStackTop new.] 
		ifFalse: [topElement := NotEmptyStackTop new initializeWith: elements last]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'eb 10/4/2020 20:27:55'!
new
	^super new initialize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackIndex category: #'Stack-Exercise'!
Object subclass: #OOStackIndex
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackIndex methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:51:30'!
dec
	
	value := value - 1! !

!OOStackIndex methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:37:15'!
inc
	
	value := value + 1.! !

!OOStackIndex methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:29:59'!
indexValue
	
	^ value .! !

!OOStackIndex methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:27:01'!
initializeWith: aValue
	
	value := aValue .! !


!classDefinition: #OOStackTop category: #'Stack-Exercise'!
Object subclass: #OOStackTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTop methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:25:15'!
topValue

	^ self subclassResponsibility .! !


!classDefinition: #EmptyStackTop category: #'Stack-Exercise'!
OOStackTop subclass: #EmptyStackTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackTop methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:43:26'!
topValue
	
	^ self error: OOStack stackEmptyErrorDescription .! !


!classDefinition: #NotEmptyStackTop category: #'Stack-Exercise'!
OOStackTop subclass: #NotEmptyStackTop
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackTop methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:24:23'!
initializeWith: aValue
	
	value := aValue .! !

!NotEmptyStackTop methodsFor: 'as yet unclassified' stamp: 'eb 10/4/2020 20:26:03'!
topValue
	
	^ value .! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
