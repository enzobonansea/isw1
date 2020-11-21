!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'ja 11/21/2020 17:59:08'!
setUp

	merchantProcessor _ MerchantProcessorSimulator new.! !


!CashierTest methodsFor: 'empty cashier' stamp: 'ja 11/21/2020 18:35:55'!
test01CashierCanNotCheckoutWithEmptyCart

	| cashier cart aCatalog creditCard |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: FixedGregorianDate today.
	cart _ Cart acceptingItemsOf: aCatalog.
	
	self should: [ cashier checkout: cart with: creditCard using: merchantProcessor . self fail] 
		raise: Error
		withMessageText: Cashier canNotCheckoutForEmptyCartErrorDescription.
! !


!CashierTest methodsFor: 'not empty cashier' stamp: 'ja 11/21/2020 18:36:21'!
test02CashierCheckoutWithCartWithAnElement

	| cashier cart aCatalog creditCard transactionId |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: FixedGregorianDate today.
	cart _ Cart acceptingItemsOf: aCatalog.
	cart add: 'book1' .
	
	transactionId _ cashier checkout: cart with: creditCard using: merchantProcessor.
	self assert: merchantProcessor lastTransactionId equals: transactionId.! !

!CashierTest methodsFor: 'not empty cashier' stamp: 'ja 11/21/2020 18:36:31'!
test03CashierCheckoutWithCartWithManyElements

	| cashier cart aCatalog creditCard transactionId |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2; add: 'book2' -> 3; add: 'book3' -> 4.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: FixedGregorianDate today.
	cart _ Cart acceptingItemsOf: aCatalog.
	
	cart add: 'book1'.
	cart add: 2 of: 'book2'. 
	
	transactionId _ cashier checkout: cart with: creditCard using: merchantProcessor.
	self assert: merchantProcessor lastTransactionId equals: transactionId.! !

!CashierTest methodsFor: 'not empty cashier' stamp: 'ja 11/21/2020 18:33:30'!
test04CanNotBuyOnMerchantProcessorError

	| cashier cart aCatalog creditCard |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2; add: 'book2' -> 3; add: 'book3' -> 4.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: FixedGregorianDate today.
	cart _ Cart acceptingItemsOf: aCatalog.
	
	cart add: 'book1'.
	
	merchantProcessor invalidate.
	
	self should: [cashier checkout: cart with: creditCard using: merchantProcessor. self fail]
		raise: Error  
		withMessageText: Cashier errorInMerchantProcessorErrorDescription.
! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:21:34'!
test01CreditCardOwnerNameCanNotEmpty

	self should:[ CreditCard of: '' withNumber: 1234567891011121 andExpiration: FixedGregorianDate today. self fail]
		raise: Error
		withMessageText: CreditCard ownerNameCanNotEmptyErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:08:03'!
test02CreditCardNumberMustHaveSixteenDigits

	self should:[ CreditCard of: 'Alan Key' withNumber: 0 andExpiration: FixedGregorianDate today. self fail]
		raise: Error
		withMessageText: CreditCard numberMustHaveSixteenDigitsErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:21:04'!
test03CreditCardDateCanNotLessThanToday

	self should:[ CreditCard of: 'Alan Key' withNumber: 1234567891011121 andExpiration: FixedGregorianDate yesterday. self fail]
		raise: Error
		withMessageText: CreditCard dateCanNotLessThanTodayErrorDescription.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'ja 11/21/2020 18:04:41'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'ja 11/21/2020 18:17:16'!
price

	^ items sum:[ :item| catalog at: item ] ifEmpty: [0].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:35:13'!
checkout: aCart with: aCreditCard using: aMerchantProcessor

	| price |
	
	price _ self priceOf: aCart.
	
	(price = 0) ifTrue: [ self error: self class canNotCheckoutForEmptyCartErrorDescription ].
	
	^ [ aMerchantProcessor pay: price with: aCreditCard ] on:Error do:[ self error: self class errorInMerchantProcessorErrorDescription ].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:14:11'!
priceOf: aCart

	 ^ aCart price.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:33:32'!
canNotCheckoutForEmptyCartErrorDescription
	
	^ 'Can not checkout for empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:33:07'!
errorInMerchantProcessorErrorDescription
	
	^ 'Error in merchant processor'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:04:35'!
of: anOwner withNumber: aNumber andExpiration: anExpiration 

	number _ aNumber .
	owner _ anOwner .
	expiration _ anExpiration .	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:19:26'!
dateCanNotLessThanTodayErrorDescription
	
	^ 'Date can not less than today'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:08:56'!
numberMustHaveSixteenDigitsErrorDescription
	
	^ ' Number must have sixteen digits '! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:20:33'!
of: anOwner withNumber: aNumber andExpiration: anExpiration

	( anOwner isEmpty ) ifTrue: [ self error: self ownerNameCanNotEmptyErrorDescription ].
	(aNumber asString size ~= 16) ifTrue: [ self error: self numberMustHaveSixteenDigitsErrorDescription ].
	(anExpiration < FixedGregorianDate today) ifTrue: [ self error: self dateCanNotLessThanTodayErrorDescription ].

	^ self new of: anOwner withNumber: aNumber andExpiration: anExpiration .! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:09:30'!
ownerNameCanNotEmptyErrorDescription
	
	^ 'Owner name can not empty'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'lastTransactionId valid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:29:02'!
initialize

	lastTransactionId _ 0.
	
	valid _ true.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:29:13'!
invalidate

	valid _ false.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:59:45'!
lastTransactionId

	^ lastTransactionId! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:30:11'!
pay: aPrice with: aCreditCard 
	
	valid ifFalse: [self error: self class errorDoingTransactionErrorDescription].
	
	lastTransactionId _ lastTransactionId + 1.
	
	^ lastTransactionId .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 18:30:50'!
errorDoingTransactionErrorDescription

	^ 'Error doing transaction error description'! !
