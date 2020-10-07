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

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 16:57:55'!
test01
	
	| aStack finder aPrefix |
	aStack := OOStack new.
	aStack push: 'abc'.
	aPrefix := ''.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText = 'No se admiten prefijos vacios' ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 16:58:47'!
test02
	
	| aStack finder aPrefix |
	aStack := OOStack new.
	aStack push: 'abc'.
	aPrefix := 'a a'.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText = 'El prefijo no puede contener espacios vacios' ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 16:59:41'!
test03
	
	| aStack finder aPrefix |
	aStack := OOStack new.
	aPrefix := 'ab'.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText = 'El stack esta vacio']! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 17:02:50'!
test04
	| sentencesThathMatchWithAPrefix  aStack finder aPrefix emptyCollection |
	aStack := OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcd'.	
	aStack push: 'dabc'.	
	aStack push: 'fabc'.
	aPrefix := 'zz'.
	
	finder := 	SentenceFinderByPrefix new.
	
	sentencesThathMatchWithAPrefix := finder find: aPrefix in: aStack.
	
	emptyCollection := Bag new.
	
	self assert: emptyCollection = sentencesThathMatchWithAPrefix.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 17:07:46'!
test05
	| sentencesThathMatchWithAPrefix  aStack finder aPrefix expectedCollection |
	aStack := OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcd'.	
	aStack push: 'dabc'.	
	aStack push: 'fabc'.
	aStack push: 'abc'.
	aStack push: 'abcdefg'.
	aPrefix := 'ab'.
	
	finder := 	SentenceFinderByPrefix new.
	
	sentencesThathMatchWithAPrefix := finder find: aPrefix in: aStack.
	
	expectedCollection := Bag with: 'abcd' with: 'abc' with: 'abcdefg' with: 'abc'.
	
	self assert: expectedCollection = sentencesThathMatchWithAPrefix.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 17:10:58'!
test06CaseSensitive
	| sentencesThathMatchWithAPrefix  aStack finder aPrefix expectedCollection |
	aStack := OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcd'.	
	aStack push: 'dabc'.	
	aStack push: 'fabc'.
	aStack push: 'abc'.
	aStack push: 'abcdefg'.
	aPrefix := 'AB'.
	
	finder := 	SentenceFinderByPrefix new.
	
	sentencesThathMatchWithAPrefix := finder find: aPrefix in: aStack.
	
	expectedCollection := Bag new.
	
	self assert: expectedCollection = sentencesThathMatchWithAPrefix.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 17:33:04'!
test07
	| aStack finder aPrefix expectedStack |
	aStack := OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcd'.	
	aStack push: 'abcde'.	
	expectedStack := aStack copy .
	aPrefix := 'ab'.
	
	finder := 	SentenceFinderByPrefix new.
	
	finder find: aPrefix in: aStack.
	expectedStack pop.
	
	self assert: expectedStack = aStack .! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'ja 10/5/2020 18:33:02'!
initialize
	elements := OrderedCollection new.
	elements add: NoElement new. ! !


!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 20:41:20'!
isEmpty

	^self size = 0! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 20:41:47'!
pop

	^elements removeLast popElement .
	
	! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 20:42:05'!
push: anElement

	elements add: (Element new initializeWith: anElement).
	
	! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 19:31:44'!
size

	^elements size - 1! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 20:42:29'!
top

	^elements last topElement.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'ja 10/4/2020 23:10:55'!
new
	^super new initialize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Element category: #'Stack-Exercise'!
OOStackElement subclass: #Element
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'as yet unclassified' stamp: 'ja 10/5/2020 18:23:00'!
initializeWith: anElement
	
	value := anElement.! !

!Element methodsFor: 'as yet unclassified' stamp: 'ja 10/5/2020 18:24:51'!
popElement
	
	^value ! !

!Element methodsFor: 'as yet unclassified' stamp: 'ja 10/5/2020 18:24:58'!
topElement
	
	^value .! !


!classDefinition: #NoElement category: #'Stack-Exercise'!
OOStackElement subclass: #NoElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NoElement methodsFor: 'as yet unclassified' stamp: 'ja 10/4/2020 23:25:44'!
popElement
	self error: OOStack stackEmptyErrorDescription! !

!NoElement methodsFor: 'as yet unclassified' stamp: 'ja 10/4/2020 23:26:04'!
topElement
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ja 10/7/2020 16:57:30'!
find: aPrefixToFind in: aStack
	
	| stackElemets sentencesThatMatchWithPrefix  |
	
	(aStack isEmpty) ifTrue: [self error: 'El stack esta vacio'].
	(aPrefixToFind isEmpty) ifTrue: [self error: 'No se admiten prefijos vacios'].
	((aPrefixToFind findString: ' ') ~= 0) ifTrue: [self error: 'El prefijo no puede contener espacios vacios'].
	
	
	stackElemets := OrderedCollection new.
	sentencesThatMatchWithPrefix  := Bag new.
	[aStack isEmpty] whileFalse: [ stackElemets add: aStack pop ].
	
	sentencesThatMatchWithPrefix := stackElemets select:[:each| (each findString: aPrefixToFind startingAt: 1) = 1].
	
	stackElemets reverse do: [:element| aStack push: element].
	
	^sentencesThatMatchWithPrefix asBag .
	
	
	
	! !
