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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:14:58'!
test01PrefixShouldntBeEmpty
	
	| aStack finder aPrefix |
	
	aStack := OOStack new.
	
	aStack push: 'abc'.
	
	aPrefix := ''.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText  = SentenceFinderByPrefix prefixIsEmptyErrorMessage ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:15:04'!
test02PrefixShouldntContainEmptySpaces
	
	| aStack finder aPrefix |
	aStack := OOStack new.
	aStack push: 'abc'.
	aPrefix := 'a a'.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText = SentenceFinderByPrefix prefixContainsEmptySpacesErrorMessage ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:15:25'!
test03StackShouldntBeEmpty
	
	| aStack finder aPrefix |
	aStack := OOStack new.
	aPrefix := 'ab'.
	
	finder := 	SentenceFinderByPrefix new.
	
	[ finder find: aPrefix in: aStack . self fail] 
		on: Error 
		do: [ :anError | self assert: anError messageText = SentenceFinderByPrefix stackIsEmptyErrorMessage ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:16:08'!
test04FinderReturnsEmptyCollectionIfPrefixIsntInStack
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:17:43'!
test05FinderReturnsAllPrefixOccurrencesInStack
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:18:17'!
test06FinderBehavesCaseSensitive
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'eb 10/8/2020 16:19:20'!
test07FinderDoesntModifyStack
	| aStack finder aPrefix firstSentence secondSentence thirdSentence sizeOriginalStack|
	firstSentence := 'abc'.
	secondSentence := 'abcd'.
	thirdSentence := 'abcde'.	
	aPrefix := 'ab'.
	
	aStack := OOStack new.
	aStack push: firstSentence.
	aStack push: secondSentence.
	aStack push: thirdSentence. 
	sizeOriginalStack := aStack size.
	
	finder := 	SentenceFinderByPrefix new.
	finder find: aPrefix in: aStack.
	
	self assert: aStack size = sizeOriginalStack.
	self assert: aStack pop = thirdSentence.
	self assert: aStack pop = secondSentence .
	self assert: aStack pop = firstSentence.
	self assert: aStack size = 0.! !


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

!OOStack methodsFor: 'operations' stamp: 'eb 10/8/2020 16:25:56'!
pop

	^elements removeLast elementValue .
	
	! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/8/2020 16:26:47'!
push: value

	elements add: (Element new initializeWith: value).
	
	! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 19:31:44'!
size

	^elements size - 1! !

!OOStack methodsFor: 'operations' stamp: 'eb 10/8/2020 16:26:28'!
top

	^elements last elementValue .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!OOStack class methodsFor: 'initialization' stamp: 'ja 10/4/2020 23:10:55'!
new
	^super new initialize! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'operations' stamp: 'eb 10/8/2020 16:25:12'!
elementValue

	self subclassResponsibility .! !


!classDefinition: #Element category: #'Stack-Exercise'!
OOStackElement subclass: #Element
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'operations' stamp: 'eb 10/8/2020 16:25:23'!
elementValue
	
	^value ! !


!Element methodsFor: 'initialization' stamp: 'ja 10/5/2020 18:23:00'!
initializeWith: anElement
	
	value := anElement.! !


!classDefinition: #NoElement category: #'Stack-Exercise'!
OOStackElement subclass: #NoElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NoElement methodsFor: 'operations' stamp: 'eb 10/8/2020 16:25:39'!
elementValue
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private - assertions' stamp: 'eb 10/8/2020 16:13:17'!
assertThatPrefixIsntEmptyAndHasntEmptySpaces: aPrefixToFind

	(aPrefixToFind isEmpty) ifTrue: [self error: self class prefixIsEmptyErrorMessage].
	((aPrefixToFind findString: ' ') ~= 0) ifTrue: [self error: self class prefixContainsEmptySpacesErrorMessage ]! !

!SentenceFinderByPrefix methodsFor: 'private - assertions' stamp: 'eb 10/8/2020 16:13:24'!
assertThatStackIsNotEmpty: aStack

	(aStack isEmpty) ifTrue: [self error: self class stackIsEmptyErrorMessage]! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'eb 10/8/2020 16:08:37'!
find: aPrefixToFind inElementCollection: elements

	^ elements select: [:each | (each findString: aPrefixToFind startingAt: 1) = 1].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'eb 10/8/2020 15:52:58'!
popElementsFrom: aStack andStoreTheyIn: elementsPoppedFromStack

	^ [aStack isEmpty] whileFalse: [ elementsPoppedFromStack add: aStack pop ]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'eb 10/8/2020 15:58:18'!
restore: aStack from: elementsPoppedFromStack

	^ elementsPoppedFromStack reverse do: [:element | aStack push: element]! !


!SentenceFinderByPrefix methodsFor: 'public' stamp: 'eb 10/8/2020 16:16:42'!
find: aPrefixToFind in: aStack
	
	| elementsPoppedFromStack sentencesThatMatchesWithPrefix |
	
	self assertThatStackIsNotEmpty: aStack.
	
	self assertThatPrefixIsntEmptyAndHasntEmptySpaces: aPrefixToFind.
	
	elementsPoppedFromStack := OrderedCollection new.
	
	sentencesThatMatchesWithPrefix := Bag new.
	
	self popElementsFrom: aStack andStoreTheyIn: elementsPoppedFromStack.
	
	sentencesThatMatchesWithPrefix := self find: aPrefixToFind inElementCollection: elementsPoppedFromStack asBag.
	
	self restore: aStack from: elementsPoppedFromStack.
	
	^sentencesThatMatchesWithPrefix.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'eb 10/8/2020 16:12:50'!
prefixContainsEmptySpacesErrorMessage

	^ 'El prefijo no puede contener espacios vacios'.! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'eb 10/8/2020 16:12:57'!
prefixIsEmptyErrorMessage

	^ 'No se admiten prefijos vacios'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'eb 10/8/2020 16:13:00'!
stackIsEmptyErrorMessage

	^ 'El stack esta vacio' .! !
