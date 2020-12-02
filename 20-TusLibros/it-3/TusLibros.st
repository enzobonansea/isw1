!classDefinition: #InvalidBookQuantity category: #TusLibros!
Error subclass: #InvalidBookQuantity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #InvalidISBN category: #TusLibros!
Error subclass: #InvalidISBN
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #KeyNotFound category: #TusLibros!
Error subclass: #KeyNotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ja 12/1/2020 19:13:53'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ja 12/1/2020 19:14:32'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ja 12/1/2020 19:13:58'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalAPITest category: #TusLibros!
TestCase subclass: #InternalAPITest
	instanceVariableNames: 'debitBehavior testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPITest methodsFor: 'create test' stamp: 'ja 12/2/2020 19:21:49'!
test01CreateCartSuccessfulWithCorrectClientIdAndPassword

	| response internalApi |
	
	internalApi _ testObjectFactory internalApi.
	response _ internalApi createCartFor: 'Dan Ingalls' with: 'smalltalk'.
		
	self assert: response code = 0.
		
	! !

!InternalAPITest methodsFor: 'create test' stamp: 'ja 12/2/2020 19:21:54'!
test02CreateCartReturnsDifferentIdPerCustomer

	| internalApi response1 response2|
	
	internalApi _ testObjectFactory internalApi.
 	
	response1 _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	response2 _ internalApi createCartFor: 'Dan Ingalls' with: 'smalltalk'.	
	
	self deny: response1 payload = response2 payload.
		
	! !

!InternalAPITest methodsFor: 'create test' stamp: 'ja 12/2/2020 19:21:58'!
test03CreateCartReturnsOneWithUnregisteredClientId

	| internalApi response |
	
	internalApi _ testObjectFactory internalApi.
 	
	response _ internalApi createCartFor: 'Edsger Dijkstra' with: 'nanoDijkstra'.
	
	self assert: response code = 1.
	
	self assert: response payload equals: InternalAPI userNotRegisteredErrorDescription. 
		
	
		
	! !

!InternalAPITest methodsFor: 'create test' stamp: 'ja 12/2/2020 19:22:01'!
test04CreateCartSuccessfulEffectivlyCreatesCart

	| internalApi response |
	
	internalApi _ testObjectFactory internalApi.
 	
	response _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	self assert: response code = 0.
	
	self assert: (internalApi hasCartsOf: 'Alan Kay').
	
		
	! !


!InternalAPITest methodsFor: 'suport' stamp: 'ja 12/2/2020 16:54:01'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!InternalAPITest methodsFor: 'suport' stamp: 'ja 12/2/2020 17:30:08'!
invalidCreditCard

	^ 'Invalid credit card'! !

!InternalAPITest methodsFor: 'suport' stamp: 'ja 12/1/2020 18:56:06'!
invalidISBN

	^ 'Invalid ISBN'! !

!InternalAPITest methodsFor: 'suport' stamp: 'ja 12/1/2020 18:37:14'!
invalidIdCart

	^ 'Invalid id cart'! !


!InternalAPITest methodsFor: 'list cart' stamp: 'ja 12/2/2020 19:22:39'!
test10ListCartWithEmptyCart

	| internalApi responseCreate responseList |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	responseList _ internalApi listCart: responseCreate payload.
	
	self assert: responseList payload isEmpty.

	! !

!InternalAPITest methodsFor: 'list cart' stamp: 'ja 12/2/2020 19:22:43'!
test11ListCartWithOnlyItemIntoCart

	| internalApi responseCreate responseList ISBN idCart listItems |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	ISBN _ 'book'.
	
	internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: (DateAndTime now). 
	
	responseList _ internalApi listCart: idCart.
	
	listItems _ Bag new.
	
	listItems add: ISBN withOccurrences: 3.
	
	self assert: responseList payload = listItems.

	! !

!InternalAPITest methodsFor: 'list cart' stamp: 'ja 12/2/2020 19:22:47'!
test12ListCartWithManyItemsIntoCart

	| internalApi responseCreate responseList ISBN1 ISBN2 idCart listItems |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	ISBN1 _ 'book1'.
	
	ISBN2 _ 'book2'.
	
	internalApi addToCart: idCart withISBN: ISBN1 withQuantity: 3 on: (DateAndTime now). 
	
	internalApi addToCart: idCart withISBN: ISBN2 withQuantity: 5 on: (DateAndTime now).
	
	responseList _ internalApi listCart: idCart.
	
	listItems _ Bag new.
	
	listItems add: ISBN1 withOccurrences: 3.
	listItems add: ISBN2 withOccurrences: 5.
	
	self assert: responseList payload = listItems.

	! !


!InternalAPITest methodsFor: 'addToCart' stamp: 'ja 12/2/2020 19:22:08'!
test05AddToCartSuccessfulWithCartId

	| internalApi responseCreate responseAdd |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	responseAdd _ internalApi addToCart: responseCreate payload withISBN: 'book' withQuantity: 3 on: (DateAndTime now). 

	self assert: responseAdd code = 0.
	
	self assert: responseAdd payload equals: 'OK'.
	! !

!InternalAPITest methodsFor: 'addToCart' stamp: 'ja 12/2/2020 19:22:12'!
test06AddToCartSuccessfulEffectivlyAddedToCart

	| internalApi responseCreate responseAdd idCart ISBN|
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	ISBN _ 'book'.
	
	responseAdd _ internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: (DateAndTime now). 

	self assert: (internalApi cart: idCart has: ISBN times: 3).
	
	self assert: responseAdd code = 0.
	
	self assert: responseAdd payload equals: 'OK'.
	! !

!InternalAPITest methodsFor: 'addToCart' stamp: 'ja 12/2/2020 19:22:17'!
test07AddToCartUnsuccessfulWithCartInvalid

	| internalApi responseAdd idCart ISBN|
	
	internalApi _ testObjectFactory internalApi.
 	
	internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ self invalidIdCart.
	
	ISBN _ 'book'.
	
	responseAdd _ internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: (DateAndTime now). 
	
	self assert: responseAdd code = 1.
	
	self assert: responseAdd payload equals: InternalAPI cartNotRegisteredErrorDescription.
	! !

!InternalAPITest methodsFor: 'addToCart' stamp: 'ja 12/2/2020 19:22:21'!
test08AddToCartUnsuccessfulWithIvalidISBN

	| responseCreate internalApi idCart ISBN|
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload .
	
	ISBN _ self invalidISBN.
	
	self should: [ internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: (DateAndTime now). self fail]  
		raise: Error  
		withMessageText: Cart invalidItemErrorMessage.
	
	
	! !

!InternalAPITest methodsFor: 'addToCart' stamp: 'ja 12/2/2020 19:22:32'!
test09AddToCartUnsuccessfulWithIvalidISBN

	| responseCreate internalApi responseAdd idCart ISBN|
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload .
	
	ISBN _ 'book'.
	
	responseAdd _ internalApi addToCart: idCart withISBN: ISBN withQuantity: 0 on: (DateAndTime now). 
	
	self assert: responseAdd code = 1.
	
	self assert: responseAdd payload equals: Cart invalidQuantityErrorMessage.
	! !


!InternalAPITest methodsFor: 'checkOut' stamp: 'ja 12/2/2020 19:22:55'!
test13CheckOutSuccessfulWithNotEmptyCart

	| internalApi responseCreate responseCheckOut ISBN1 ISBN2 idCart creditCard date |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	ISBN1 _ 'book1'.
	
	ISBN2 _ 'book2'.
	
	internalApi addToCart: idCart withISBN: ISBN1 withQuantity: 3 on: (DateAndTime now). 
	
	internalApi addToCart: idCart withISBN: ISBN2 withQuantity: 5 on: (DateAndTime now).
	
	date _ DateAndTime now month.
	creditCard _ CreditCard expiringOn: date.
	
	responseCheckOut _ internalApi checkOutCart: idCart withCreditCart: creditCard thatExpiresOn: date ofOwner: 'Alan Kay'.
	
	self assert: responseCheckOut payload = 1.
	
	self assert: responseCheckOut code = 0.! !

!InternalAPITest methodsFor: 'checkOut' stamp: 'ja 12/2/2020 19:22:59'!
test14CheckOutUnsuccessfulWithEmptyCart

	| internalApi responseCreate responseCheckOut idCart creditCard date |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	date _ DateAndTime now month.
	
	creditCard _ CreditCard expiringOn: date.
	
	responseCheckOut _ internalApi checkOutCart: idCart withCreditCart: creditCard thatExpiresOn: date ofOwner: 'Alan Kay'.
	
	self assert: responseCheckOut payload equals: Cashier cartCanNotBeEmptyErrorMessage.
	
	self assert: responseCheckOut code = 1.! !

!InternalAPITest methodsFor: 'checkOut' stamp: 'ja 12/2/2020 19:23:04'!
test15CheckOutUnsuccessfulWithInvalidCart

	| internalApi responseCheckOut creditCard date |
	
	internalApi _ testObjectFactory internalApi.
 	
	internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	date _ DateAndTime now month.
	
	creditCard _ CreditCard expiringOn: date.
	
	responseCheckOut _ internalApi checkOutCart: self invalidIdCart withCreditCart: creditCard thatExpiresOn: date ofOwner: 'Alan Kay'.
	
	self assert: responseCheckOut payload equals: InternalAPI cartNotRegisteredErrorDescription .
	
	self assert: responseCheckOut code = 1.! !

!InternalAPITest methodsFor: 'checkOut' stamp: 'ja 12/2/2020 19:23:08'!
test16CheckOutUnsuccessfulWithExpiredCreditCard

	| internalApi responseCreate responseCheckOut idCart creditCard ISBN |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	creditCard _ testObjectFactory expiredCreditCard.
	
	idCart _ responseCreate payload.
	
	ISBN _ 'book'.
	
	internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: testObjectFactory today . 
	
	responseCheckOut _ internalApi checkOutCart: idCart withCreditCard: creditCard ofOwner: 'Alan Kay' on: testObjectFactory today.
	
	self assert: responseCheckOut payload equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
	
	self assert: responseCheckOut code = 1.! !

!InternalAPITest methodsFor: 'checkOut' stamp: 'ja 12/2/2020 19:23:12'!
test17CheckOutUnsuccessfulWithInvalidUser

	| internalApi responseCreate responseCheckOut idCart creditCard ISBN |
	
	internalApi _ testObjectFactory internalApi.
 	
	responseCreate _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	
	idCart _ responseCreate payload.
	
	creditCard _ testObjectFactory expiredCreditCard.
	
	idCart _ responseCreate payload.
	
	ISBN _ 'book'.
	
	internalApi addToCart: idCart withISBN: ISBN withQuantity: 3 on: testObjectFactory today . 
	
	responseCheckOut _ internalApi checkOutCart: idCart withCreditCard: creditCard ofOwner: 'Edsger Dijkstra' on: testObjectFactory today.
	
	self assert: responseCheckOut payload equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
	
	self assert: responseCheckOut code = 1.! !


!InternalAPITest methodsFor: 'setUp' stamp: 'ja 12/2/2020 18:41:35'!
setUp 

	debitBehavior _ [ :anAmount :aCreditCard | ].
	
	testObjectFactory _ StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cart methodsFor: 'assertions' stamp: 'ja 12/1/2020 19:12:30'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'ja 12/1/2020 20:02:00'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ InvalidBookQuantity signal: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'accesing' stamp: 'ja 12/1/2020 19:36:45'!
items

	^items copy! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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

!Cart class methodsFor: 'instance creation' stamp: 'ja 12/1/2020 19:12:41'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'instance creation' stamp: 'ja 12/1/2020 19:12:52'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InternalAPI category: #TusLibros!
Object subclass: #InternalAPI
	instanceVariableNames: 'users nextId carts date modifications cartsPerUser catalog merchantProcesor nextTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPI methodsFor: 'initialization' stamp: 'ja 12/2/2020 17:01:08'!
initializeWith: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor
	
	users _ aUsersCollection.
	
	date _ aDate.
	
	carts _ Dictionary new.
	
	catalog _ aCatalog.
	
	cartsPerUser _ Dictionary new.
	
	modifications _ Dictionary new.
	
	nextId _ 0.
	
	nextTransaction _ 0.
	
	merchantProcesor _ aMerchantProccesor.! !


!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 18:33:26'!
cart: aCartId has: aISBN times: anAmount 
	
	| cart |
	
	cart _ carts at: aCartId .
	
	^ (cart includes: aISBN) and: [(cart occurrencesOf: aISBN) = anAmount ].! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 17:56:48'!
ensureDateOf: aCartId isValidOn: aDate

	| halfHourAgo |
	
	halfHourAgo _ aDate - 30 minutes.
	
	((modifications includesKey: aCartId) and:[ (modifications at: aCartId)  < halfHourAgo ]) ifTrue:[self error: self class cartIsExpiredErrorDescription].! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 11/30/2020 19:19:27'!
ensureExecutionOf: aBlock withCart: aCartId validOn: aDate

	| returnValue |

	self ensureDateOf: aCartId isValidOn: aDate.
	
	returnValue _ aBlock value.
	
	self updateDateOf: aCartId to: aDate.
	
	^ returnValue .
	
	! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 11/29/2020 19:14:22'!
ensureIsRegisteredUser: anUser with: aPassword 
	
	| aPasswordRegistered |
	
	aPasswordRegistered _ users at: anUser ifAbsent:[ self error: self class userNotRegisteredErrorDescription ].
	
	^ aPasswordRegistered = aPassword.! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 12/2/2020 17:09:47'!
hasCartsOf: anUser
	
	^ cartsPerUser includesKey: anUser.! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 11/29/2020 17:24:25'!
nextIdFree

	nextId _ nextId + 1.
	
	^ nextId ! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 12/2/2020 16:46:31'!
nextTransaction

	nextTransaction _ nextTransaction + 1.
	
	^ nextTransaction
	! !

!InternalAPI methodsFor: 'as yet unclassified' stamp: 'ja 11/30/2020 19:34:11'!
updateDateOf: aCartId to: aDate

	modifications at: aCartId put: aDate .! !


!InternalAPI methodsFor: 'API' stamp: 'ja 12/2/2020 17:26:18'!
addToCart: aCartId withISBN: aISBN withQuantity: aQuantity
	
	| cart |
	
	[ cart _ carts at: aCartId ] on: Error do: [^ UnsuccessfulResponse with: (self class cartNotRegisteredErrorDescription) ].
	
	[cart add: aQuantity of: aISBN] on: InvalidBookQuantity do: [:error | ^ UnsuccessfulResponse with: error messageText ].
	
	^ SuccessfulResponse with: 'OK'.! !

!InternalAPI methodsFor: 'API' stamp: 'ja 12/2/2020 17:10:27'!
addToCart: aCartId withISBN: aISBN withQuantity: aQuantity on: aDate
	
	^ self ensureExecutionOf: [ self addToCart: aCartId withISBN: aISBN withQuantity: aQuantity ] withCart: aCartId validOn: aDate.
	
	! !

!InternalAPI methodsFor: 'API' stamp: 'ja 12/2/2020 19:18:57'!
checkOutCart: aCartId withCreditCard: aCreditCard ofOwner: anUser on: aDate
	
	| cart cashier|
	
	[cart _ carts at: aCartId ] on: Error do:[^ UnsuccessfulResponse with: (self class cartNotRegisteredErrorDescription) ].
	
	[cashier _ Cashier toCheckout: cart charging: aCreditCard throught: merchantProcesor on: aDate registeringOn: OrderedCollection new] on: Error do: [:error| ^ UnsuccessfulResponse with: error messageText].
	
	cashier checkOut.
	
	^ SuccessfulResponse with: self nextTransaction.
	! !

!InternalAPI methodsFor: 'API' stamp: 'ja 12/1/2020 18:32:20'!
createCartFor: anUser with: aPassword 
	
	| idCart cart|
	
	[ self ensureIsRegisteredUser: anUser with: aPassword ] on: Error do: [:error | ^UnsuccessfulResponse with: error messageText ].
	
	cart _ Cart acceptingItemsOf: catalog.
	
	idCart _ self nextIdFree.
	
	cartsPerUser add: anUser -> cart.
	
	carts add: idCart -> cart.
	
	modifications add: idCart -> date.
	
	^ SuccessfulResponse with: idCart.! !

!InternalAPI methodsFor: 'API' stamp: 'ja 12/1/2020 19:38:17'!
listCart: aCartId
	
	| cart listItems |
	
	cart _ carts at: aCartId.
	
	listItems _ cart items.
		
	^ SuccessfulResponse with: listItems asBag. 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalAPI class' category: #TusLibros!
InternalAPI class
	instanceVariableNames: ''!

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 18:57:34'!
ISBNNotRegisteredErrorDescription

	^ 'ISBN is not registered'! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 11/30/2020 19:34:39'!
cartIsExpiredErrorDescription

	^ 'Cart is expired'! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 18:42:33'!
cartNotRegisteredErrorDescription

	^ 'Cart is not registered'! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 19:03:55'!
invalidQuantityErrorDescription

	^'Invalid quantity'! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 11/29/2020 13:47:40'!
userNotRegisteredErrorDescription

	^ 'User not registered'! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 11/29/2020 18:11:07'!
with: aUsersCollection
	
	^self new initializeWith: aUsersCollection.! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 17:21:47'!
with: aUsersCollection on: aDate
	
	^self new initializeWith: aUsersCollection on: aDate.! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/1/2020 18:30:00'!
with: aUsersCollection on: aDate usingCatalog: aCatalog
	
	^self new initializeWith: aUsersCollection on: aDate usingCatalog: aCatalog .! !

!InternalAPI class methodsFor: 'as yet unclassified' stamp: 'ja 12/2/2020 16:37:19'!
with: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor
	
	^self new initializeWith: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor.! !


!classDefinition: #InternalAPIResponse category: #TusLibros!
Object subclass: #InternalAPIResponse
	instanceVariableNames: 'payload'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPIResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:18:53'!
code

	self subclassResponsibility ! !

!InternalAPIResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:56:21'!
initializeWith: aPayload

	payload _ aPayload! !

!InternalAPIResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:57:44'!
payload

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalAPIResponse class' category: #TusLibros!
InternalAPIResponse class
	instanceVariableNames: 'payload'!

!InternalAPIResponse class methodsFor: 'as yet unclassified' stamp: 'ja 11/29/2020 18:56:01'!
with: aPayload

	^ self new initializeWith: aPayload .! !


!classDefinition: #SuccessfulResponse category: #TusLibros!
InternalAPIResponse subclass: #SuccessfulResponse
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SuccessfulResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 19:00:16'!
code 

	^ 0! !

!SuccessfulResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:58:33'!
payload
	 
	^ payload ! !


!classDefinition: #UnsuccessfulResponse category: #TusLibros!
InternalAPIResponse subclass: #UnsuccessfulResponse
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UnsuccessfulResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 19:00:07'!
code 

	^ 1! !

!UnsuccessfulResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:59:00'!
payload

	^ payload ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 12/2/2020 18:38:37'!
expiredCreditCard
	
	^CreditCard expiringOn: self pastYear.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 12/2/2020 18:39:15'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self nextYear.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'internal API' stamp: 'ja 12/2/2020 19:25:01'!
authenticatedUsers

	| users | 
	
	users _ Dictionary new.
	users add: 'Alan Kay' -> 'objetos';
		  add: 'Dan Ingalls' -> 'smalltalk'.
	
	^ users.! !

!StoreTestObjectsFactory methodsFor: 'internal API' stamp: 'ja 12/2/2020 19:25:36'!
internalApi
	
	^ InternalAPI with: self authenticatedUsers 
				on: today 
				usingCatalog: self defaultCatalog 
				usingMerchantProccesor: self.! !

!StoreTestObjectsFactory methodsFor: 'internal API' stamp: 'ja 12/2/2020 19:28:26'!
internalApiUsingMerchantProccessor: aMerchantProccessor
	
	^ InternalAPI with: self authenticatedUsers 
				on: today 
				usingCatalog: self defaultCatalog 
				usingMerchantProccesor: self.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ja 12/2/2020 18:39:00'!
nextYear
	
	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ja 12/2/2020 18:38:11'!
pastYear
	
	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
