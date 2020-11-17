!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:31:28'!
test00
	
	| cart |
	
	cart _ Cart new.
	
	cart add: 'loquesea' .
	
	self deny: (cart has: 'loquesea').! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 18:55:33'!
test01CartIsEmptyAtTheBeginning
	
	| cart |
	
	cart _ Cart new .
	
	self assert: cart isEmpty .! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:17:23'!
test02CanAddToCartABookInCatalogue
	
	| cart catalogue |
	
	cart _ Cart new .
	
	catalogue _ Catalogue with: 'book1' with: 'book2'.
	
	cart add: 'book1' from: catalogue .
	
	self deny: cart isEmpty .
	
	self assert: (cart has: 'book1').! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:25:14'!
test03CanNotAddToCartABookThatIsNotPresentInCatalogue
	
	| cart catalogue |
	
	cart _ Cart new .
	
	catalogue _ Catalogue with: 'book1' with: 'book2'.
	
	self should: [ cart add: 'book3' from: catalogue . self fail.]
		raise: Error
		withMessageText: Catalogue bookIsNotInCatalogueErrorDescription.
	
	self assert: cart isEmpty .
	
	self deny: (cart has: 'book3').! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:32:41'!
test04MultipleBooksInCatalogueCanBeAddedToCart

	| cart catalogue |
	
	cart _ Cart new .
	
	catalogue _ Catalogue with: 'book1' with: 'book2'.
	
	cart add: 'book1' from: catalogue .
	
	cart add: 'book2' from: catalogue .
	
	self deny: cart isEmpty .
	
	self assert: (cart has: 'book1').
	
	self assert: (cart has: 'book2').
	! !


!classDefinition: #TusLibrosAPITest category: #TusLibros!
TestCase subclass: #TusLibrosAPITest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosAPITest methodsFor: 'create cart endpoint' stamp: 'eb 11/16/2020 17:53:40'!
test01Gets400OnCreateCartAttempWithInvalidRequestSyntax

	| api |
	
	api _ TusLibrosAPI new.
	
	self should: [ api post: 'createCart' with: '']
		raise: Error
		withMessageText: api class badRequest.
	! !

!TusLibrosAPITest methodsFor: 'create cart endpoint' stamp: 'eb 11/16/2020 17:49:10'!
test02Gets200OnCreateCartAttempWithValidRequestSyntax
	! !

!TusLibrosAPITest methodsFor: 'create cart endpoint' stamp: 'eb 11/16/2020 17:49:25'!
test03CreatesCartOnCreateCartAttempWithValidRequestSyntax
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'eb 11/16/2020 19:15:32'!
has: aBook
	
	^ books includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'eb 11/16/2020 19:14:54'!
isEmpty

	^ books isEmpty .! !


!Cart methodsFor: 'adding' stamp: 'eb 11/16/2020 19:34:14'!
add: aBook
	
	self halt.
	
	(thisContext sender isKindOf: Catalogue) ifTrue: [books add: aBook .].
	
	! !

!Cart methodsFor: 'adding' stamp: 'eb 11/16/2020 19:18:31'!
add: aBook from: aCatalogue
	
	aCatalogue add: aBook to: self. ! !


!Cart methodsFor: 'initialization' stamp: 'eb 11/16/2020 19:12:36'!
initialize
	
	books _ OrderedCollection new.! !


!classDefinition: #Catalogue category: #TusLibros!
Object subclass: #Catalogue
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'adding' stamp: 'eb 11/16/2020 19:13:25'!
add: aBook
	
	books add: aBook .! !

!Catalogue methodsFor: 'adding' stamp: 'eb 11/16/2020 19:24:08'!
add: aBook to: aCart
	
	(books includes: aBook) ifFalse: [self error: self class bookIsNotInCatalogueErrorDescription ].
	
	aCart add: aBook.! !


!Catalogue methodsFor: 'initialization' stamp: 'eb 11/16/2020 19:13:10'!
initialize

	books  _ OrderedCollection new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: #TusLibros!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:13:59'!
with: aBook
	
	^ self new add: aBook yourself .! !

!Catalogue class methodsFor: 'as yet unclassified' stamp: 'eb 11/16/2020 19:14:21'!
with: aBook with: anotherBook
	
	| catalogue |
	
	catalogue _ self with: aBook.
	
	^ catalogue add: anotherBook yourself .! !


!Catalogue class methodsFor: 'error descriptions' stamp: 'eb 11/16/2020 19:21:56'!
bookIsNotInCatalogueErrorDescription
	
	^ 'Book is not in catalogue'.! !


!classDefinition: #TusLibrosAPI category: #TusLibros!
Object subclass: #TusLibrosAPI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
