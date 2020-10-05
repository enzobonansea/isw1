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


!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 18:40:23'!
isEmpty

	^self size = 1! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 18:24:00'!
pop

	| tope | 
	tope := elements last.
	^tope popElement.
	! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 18:34:41'!
push: anElement

	elements add: (Element new initializeWith: anElement).
	"elements  add: anElement."
	! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 18:39:53'!
size

	^((elements size) -1)! !

!OOStack methodsFor: 'operations' stamp: 'ja 10/5/2020 18:34:52'!
top

	| tope | 
	tope := elements last.
	^tope topElement.
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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ja 10/5/2020 18:14:15'!
find: aPrefixToFind in: aStack
	
	| otherStack lastSentenceThatMatchWithPrefix currentSentence |
	
	(aStack isEmpty) ifTrue: [^'El stack esta vacio'].
	(aPrefixToFind isEmpty) ifTrue: [^'No se admiten prefijos vacios'].
	(aPrefixToFind findString: ' ').
	
	
	otherStack := aStack .
	
	[otherStack isEmpty] whileFalse: [
		currentSentence := otherStack pop.
		 (currentSentence findString: aPrefixToFind startingAt: 1 = 1) ifTrue: [
				lastSentenceThatMatchWithPrefix := currentSentence		.	
			].
		].
	^ lastSentenceThatMatchWithPrefix .
	
	
	"while (!!aStack isEmpty){
		if coincide(aStack.top , aPrefixToFind){
			lastSentence... = aStack.pop
		} else {
			aStack.pop
		}
	}
	"! !
