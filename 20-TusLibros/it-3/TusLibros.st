!classDefinition: #InvalidBookQuantity category: #TusLibros!
Error subclass: #InvalidBookQuantity
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
	instanceVariableNames: 'debitBehavior testObjectFactory internalApi'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPITest methodsFor: 'create cart' stamp: 'eb 12/2/2020 23:30:31'!
test01CreateCartIsSuccessfullyWithCorrectClientIdAndPassword
	self assertSuccessfullyResponse: (internalApi createCartFor: 'Dan Ingalls' with: 'smalltalk').! !

!InternalAPITest methodsFor: 'create cart' stamp: 'eb 12/2/2020 23:30:31'!
test02CreateCartReturnsDifferentIdsPerCustomer
	| firstCustomerCartId secondCustomerCartId |
	firstCustomerCartId _ (internalApi createCartFor: 'Alan Kay' with: 'objetos') payload .
	secondCustomerCartId _ (internalApi createCartFor: 'Dan Ingalls' with: 'smalltalk') payload.	
	self deny: firstCustomerCartId = secondCustomerCartId
	! !

!InternalAPITest methodsFor: 'create cart' stamp: 'eb 12/2/2020 23:30:31'!
test03CreateCartIsUnsuccessfullyWithUnregisteredClientId
	| response |
	response _ internalApi createCartFor: 'Edsger Dijkstra' with: 'nanoDijkstra'.
	self assertUnsuccesfullyResponse: response.
	self assert: response payload equals: InternalAPI userNotRegisteredErrorDescription. 
		
	
		
	! !

!InternalAPITest methodsFor: 'create cart' stamp: 'eb 12/2/2020 23:30:31'!
test04CreateCartSuccessfullyEffectivlyCreatesCart
	| response |
	response _ internalApi createCartFor: 'Alan Kay' with: 'objetos'.
	self assertSuccessfullyResponse: response.
	self assert: (internalApi hasCartsOf: 'Alan Kay').
	
		
	! !


!InternalAPITest methodsFor: 'add to cart' stamp: 'eb 12/2/2020 20:38:11'!
test05AddToCartIsSuccessfullyWithValidCartId
	| addResponse |	
	addResponse _ self successfullyAddResponseFor: self validCartId. 

	self assertSuccessfullyResponse: addResponse .
	self assert: addResponse payload equals: 'OK'.
	! !

!InternalAPITest methodsFor: 'add to cart' stamp: 'eb 12/2/2020 21:11:01'!
test06AddToCartSuccessfullyEffectivlyAddsToCart
	| cartId |
	
	cartId _ self validCartId.
	
	self successfullyAddResponseFor: cartId. 
	self assertSuccessfullyAddResponseAddsItemsCorrectlyFor: cartId.
! !

!InternalAPITest methodsFor: 'add to cart' stamp: 'eb 12/2/2020 23:30:31'!
test07AddToCartIsUnsuccessfullyWithInvalidCartId

	| addResponse |	
	addResponse _ internalApi 
		add: testObjectFactory itemSellByTheStore 
		toCart: self invalidCartId
		withQuantity: 3 
		on: testObjectFactory today.
	self assertUnsuccesfullyResponse: addResponse .
	self assert: addResponse payload equals: InternalAPI cartNotRegisteredErrorDescription.
	! !

!InternalAPITest methodsFor: 'add to cart' stamp: 'eb 12/2/2020 23:30:31'!
test08AddToCartIsUnsuccessfullyWithIvalidISBN
	| cartId addResponse |		
	cartId _ self validCartId .
	addResponse _ internalApi
		add: self invalidCartId 
		toCart: cartId
		withQuantity: 3
		on: testObjectFactory today.	
	self assertUnsuccesfullyResponse: addResponse .
	
	self assert: addResponse payload = Cart invalidItemErrorMessage.
	
	
	! !


!InternalAPITest methodsFor: 'list cart' stamp: 'eb 12/2/2020 23:30:31'!
test09ListCartWithEmptyCart
	| cartId listCartResponse |
	cartId _ self validCartId .	
	
	listCartResponse _ internalApi listCart: cartId.
	
	self assertSuccessfullyResponse: listCartResponse.
	self assert: listCartResponse payload isEmpty.

	! !

!InternalAPITest methodsFor: 'list cart' stamp: 'eb 12/2/2020 23:30:31'!
test10ListCartWithNotEmptyCart
	| cartId listCartResponse targetElements |
	cartId _ self validCartId .	
	
	self successfullyAddResponseFor: cartId.
		
	targetElements _ Bag new.
	
	targetElements  add: testObjectFactory itemSellByTheStore withOccurrences: 3. 
	
	listCartResponse _ internalApi listCart: cartId.
	
	self assertSuccessfullyResponse: listCartResponse .
	self assert: targetElements equals: listCartResponse payload .
	! !

!InternalAPITest methodsFor: 'list cart' stamp: 'eb 12/2/2020 23:30:31'!
test11ListCartWithInvalidCart
	| cartId listCartResponse |
	cartId _ self invalidCartId .	
	
	listCartResponse _ internalApi listCart: cartId.
	self assertUnsuccesfullyResponse: listCartResponse.

	self assert: internalApi class cartNotRegisteredErrorDescription equals: listCartResponse payload .
	! !


!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test12CheckOutIsSuccessfullyWithValidNotEmptyCartAndNotExpiredCreditCardAndValidUser
	| cartId checkoutResponse | 		
	cartId _ self validCartId .
	
	self successfullyAddResponseFor: cartId.
		
	checkoutResponse _ internalApi 
		checkOutCart: cartId  
		withCreditCard: testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
		
	self assertSuccessfullyResponse: checkoutResponse.
	
	self assert: 1 equals: checkoutResponse payload .
! !

!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test13CheckOutIsUnsuccessfullyWithEmptyCart
	| cartId checkoutResponse |
 		
	cartId _ self validCartId .
			
	checkoutResponse _ internalApi 
		checkOutCart: cartId  
		withCreditCard: testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
		
	self assertUnsuccesfullyResponse: checkoutResponse.
	
	self assert: Cashier cartCanNotBeEmptyErrorMessage equals: checkoutResponse payload .! !

!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test14CheckOutIsUnsuccessfullyWithInvalidCart
	| cartId checkoutResponse |
 		
	cartId _ self invalidCartId .
			
	checkoutResponse _ internalApi 
		checkOutCart: cartId  
		withCreditCard: testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
		
	self assertUnsuccesfullyResponse: checkoutResponse.
	
	self assert: InternalAPI cartNotRegisteredErrorDescription equals: checkoutResponse payload .! !

!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test15CheckOutIsUnsuccessfullyWithExpiredCreditCard
	| cartId checkoutResponse |
 		
	cartId _ self validCartId .
	
	self successfullyAddResponseFor: cartId .
			
	checkoutResponse _ internalApi 
		checkOutCart: cartId  
		withCreditCard: testObjectFactory expiredCreditCard
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
		
	self assertUnsuccesfullyResponse: checkoutResponse.
	
	self assert: Cashier canNotChargeAnExpiredCreditCardErrorMessage  equals: checkoutResponse payload .! !

!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test16CheckOutIsUnsuccessfullyWithInvalidUser
	| cartId checkoutResponse |
 		
	cartId _ self validCartId .
	
	self successfullyAddResponseFor: cartId.
			
	checkoutResponse _ internalApi 
		checkOutCart: cartId  
		withCreditCard: testObjectFactory notExpiredCreditCard 
		ofOwner:  'Steve Jobs'
		on: testObjectFactory today.
		
	self assertUnsuccesfullyResponse: checkoutResponse.
	
	self assert: InternalAPI userHasNotCartsErrorDescription equals: checkoutResponse payload .! !

!InternalAPITest methodsFor: 'checkout cart' stamp: 'eb 12/2/2020 23:30:31'!
test17CheckOutIsUnsuccessfullyWithAlienCart
	| alanKayCartId  danIngallsCartId checkoutResponse |
 		
	alanKayCartId _ self validCartId .
	
	danIngallsCartId  _ internalApi createCartFor: 'Dan Ingalls' with: 'smalltalk'.
	
	self successfullyAddResponseFor: alanKayCartId.
			
	self successfullyAddResponseFor: danIngallsCartId.

	checkoutResponse _ internalApi 
		checkOutCart: alanKayCartId  
		withCreditCard: testObjectFactory notExpiredCreditCard 
		ofOwner:  'Dan Ingalls'
		on: testObjectFactory today.
		
	self assertUnsuccesfullyResponse: checkoutResponse.
	
	self assert: InternalAPI cartDoesNotBelongToUserErrorDescription equals: checkoutResponse payload .! !


!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:35:37'!
test18CannotQueryListPurchasesOfEmptyCart

	| listPurchasesResponse |
	
	self validCartId .
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	self assertUnsuccesfullyResponse: listPurchasesResponse .
	
	self assert: InternalAPI canNotQueryListPurchsesOfEmptyCartErrorDescription equals: listPurchasesResponse payload .
	! !

!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:10:54'!
test19SuccesfullyListPurchasesOfCartWithOnlyOneItem

	| cartId listPurchasesResponse expectedDetail expectedResponsePayload |
	
	cartId _ self validCartId .
	
	internalApi
		add: testObjectFactory itemSellByTheStore 
		toCart: cartId
		withQuantity: 1
		on: testObjectFactory today.
		
	internalApi
		checkOutCart: cartId
		withCreditCard:  testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	expectedDetail _ Dictionary new.
	
	expectedDetail add: testObjectFactory itemSellByTheStore -> testObjectFactory itemSellByTheStorePrice.
	
	expectedResponsePayload _ DetailedSale of: testObjectFactory itemSellByTheStorePrice  with: expectedDetail.
	
	self assertSuccessfullyResponse: listPurchasesResponse .
	
	self  assert: expectedResponsePayload equals: listPurchasesResponse payload .
	! !

!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:15:50'!
test20SuccesfullyListPurchasesOfCartWithManyItemsOfSameType

	| cartId listPurchasesResponse expectedDetail expectedResponsePayload |
	
	cartId _ self validCartId .
	
	self successfullyAddResponseFor: cartId.
		
	internalApi
		checkOutCart: cartId
		withCreditCard:  testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	expectedDetail _ Dictionary new.
	
	expectedDetail add: testObjectFactory itemSellByTheStore -> (testObjectFactory itemSellByTheStorePrice * 3).
	
	expectedResponsePayload _ DetailedSale of: (testObjectFactory itemSellByTheStorePrice * 3) with: expectedDetail.
	
	self assertSuccessfullyResponse: listPurchasesResponse .
	
	self  assert: expectedResponsePayload equals: listPurchasesResponse payload .
	! !

!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:27:30'!
test21SuccesfullyListPurchasesOfCartWithManyItemsOfManyTypes

	| cartId listPurchasesResponse expectedDetail expectedResponsePayload |
	
	cartId _ self validCartId .
	
	self successfullyAddResponseFor: cartId.
	
	internalApi 
		add: testObjectFactory anotherItemSellByTheStore 
		toCart:  cartId 
		withQuantity: 4
		on: testObjectFactory today.
		
	internalApi
		checkOutCart: cartId
		withCreditCard:  testObjectFactory notExpiredCreditCard 
		ofOwner:  'Alan Kay'
		on: testObjectFactory today.
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	expectedDetail _ Dictionary new.
	
	expectedDetail add: testObjectFactory itemSellByTheStore -> (testObjectFactory itemSellByTheStorePrice * 3).
	
	expectedDetail add: testObjectFactory anotherItemSellByTheStore -> (testObjectFactory anotherItemSellByTheStorePrice * 4).
	
	expectedResponsePayload _ DetailedSale 
		of: (testObjectFactory itemSellByTheStorePrice * 3) + (testObjectFactory anotherItemSellByTheStorePrice * 4) 
		with: expectedDetail.
	
	self assertSuccessfullyResponse: listPurchasesResponse .
	
	self  assert: expectedResponsePayload equals: listPurchasesResponse payload .
	! !

!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:31:47'!
test22CannotQueryListPurchasesOfInvalidCart

	| listPurchasesResponse |
	
	self validCartId .
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	self assertSuccessfullyResponse: listPurchasesResponse .
	
	self assert: (DetailedSale of: 0 with: Bag new) equals: listPurchasesResponse payload .
	! !

!InternalAPITest methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:31:53'!
test23CannotQueryListPurchasesOfAlienCart

	| listPurchasesResponse |
	
	self validCartId .
	
	listPurchasesResponse _ internalApi listPurchasesOf: 'Alan Kay' with: 'objetos'.
	
	self assertSuccessfullyResponse: listPurchasesResponse .
	
	self assert: (DetailedSale of: 0 with: Bag new) equals: listPurchasesResponse payload .
	! !



!InternalAPITest methodsFor: 'assertions' stamp: 'eb 12/2/2020 23:30:31'!
assertSuccessfullyAddResponseAddsItemsCorrectlyFor: aCartId

	self assert: (internalApi 
		cart: aCartId
		has: testObjectFactory itemSellByTheStore 
		withQuantity: 3).! !

!InternalAPITest methodsFor: 'assertions' stamp: 'eb 12/2/2020 20:43:49'!
assertSuccessfullyResponse: aResponse

	^ self assert: aResponse code = 0! !

!InternalAPITest methodsFor: 'assertions' stamp: 'eb 12/2/2020 20:43:55'!
assertUnsuccesfullyResponse: aResponse

	^ self assert: aResponse code = 1! !


!InternalAPITest methodsFor: 'carts' stamp: 'eb 12/2/2020 20:55:38'!
invalidCartId

	^ 'Invalid cart id'.! !

!InternalAPITest methodsFor: 'carts' stamp: 'eb 12/2/2020 23:30:31'!
validCartId

	^ (internalApi createCartFor: 'Alan Kay' with: 'objetos') payload! !


!InternalAPITest methodsFor: 'merchant processor simulation' stamp: 'ja 12/2/2020 16:54:01'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!InternalAPITest methodsFor: 'responses' stamp: 'eb 12/2/2020 23:30:31'!
successfullyAddResponseFor: aCartId

	^ internalApi 
		add: testObjectFactory itemSellByTheStore
		toCart: aCartId 
		withQuantity: 3 
		on: testObjectFactory today! !


!InternalAPITest methodsFor: 'setUp' stamp: 'eb 12/2/2020 23:30:31'!
setUp 
	debitBehavior _ [ :anAmount :aCreditCard | ].
	testObjectFactory _ StoreTestObjectsFactory new.
	
	internalApi _ testObjectFactory internalApiUsingMerchantProccessor: self.! !


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
	instanceVariableNames: 'users nextCartId carts date modifications cartsPerUser catalog merchantProcesor nextCheckOutId purchases detailedSalePerUser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPI methodsFor: 'initialization' stamp: 'eb 12/2/2020 23:57:42'!
initializeWith: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor
	users _ aUsersCollection.
	date _ aDate.
	catalog _ aCatalog.
	merchantProcesor _ aMerchantProccesor.
	carts _ Dictionary new.
	cartsPerUser _ Dictionary new.
	modifications _ Dictionary new.
	detailedSalePerUser _ Dictionary new .
	nextCartId _ 0.
	nextCheckOutId _ 0.! !


!InternalAPI methodsFor: 'login' stamp: 'eb 12/2/2020 22:01:48'!
ensureUser: anUser isRegisteredWith: aPassword 
	| registeredPassword |
	registeredPassword _ users at: anUser ifAbsent:[ self error: self class userNotRegisteredErrorDescription ].
	^ registeredPassword = aPassword.! !


!InternalAPI methodsFor: 'testing' stamp: 'eb 12/2/2020 21:09:51'!
cart: aCartId has: anItem withQuantity: aQuantity 
	| cart |
	cart _ carts at: aCartId .
	^ (cart includes: anItem) and: [ (cart occurrencesOf: anItem) = aQuantity ].! !

!InternalAPI methodsFor: 'testing' stamp: 'eb 12/2/2020 22:04:57'!
hasCartsOf: anUser
	^ cartsPerUser includesKey: anUser.! !


!InternalAPI methodsFor: 'add to cart' stamp: 'eb 12/2/2020 21:07:16'!
add: anItem toCart: aCartId withQuantity: aQuantity
	| cart |
	[ cart _ carts at: aCartId ] 
		on: Error 
		do: [ ^ UnsuccessfulResponse with: self class cartNotRegisteredErrorDescription ].
	[cart add: aQuantity of: anItem] 
		on: InvalidBookQuantity 
		do: [ :error | ^ UnsuccessfulResponse with: error messageText ].
	^ SuccessfulResponse with: 'OK'.! !

!InternalAPI methodsFor: 'add to cart' stamp: 'eb 12/2/2020 21:12:41'!
add: anItem toCart: aCartId withQuantity: aQuantity on: aDate
	[ ^ self 
		ensureExecutionOf: [ self add: anItem toCart: aCartId withQuantity: aQuantity ] 
		withCart: aCartId 
		isValidOn: aDate. ] on: Error do: [ :error | ^ UnsuccessfulResponse with: error messageText ].
	
	! !


!InternalAPI methodsFor: 'create cart' stamp: 'eb 12/2/2020 22:06:08'!
createCartFor: anUser with: aPassword 
	| cartId cart |
	[ self ensureUser: anUser isRegisteredWith: aPassword ] 
		on: Error 
		do: [:error | ^UnsuccessfulResponse with: error messageText ].
	cart _ Cart acceptingItemsOf: catalog.
	cartId _ self nextCartId.
	cartsPerUser add: anUser -> cart.
	carts add: cartId -> cart.
	modifications add: cartId -> date.
	^ SuccessfulResponse with: cartId.! !


!InternalAPI methodsFor: 'list cart' stamp: 'eb 12/2/2020 21:45:49'!
listCart: aCartId
	| cart listItems |
	[ cart _ carts at: aCartId. ]
		on: Error
		do: [ ^ UnsuccessfulResponse with: self class cartNotRegisteredErrorDescription ].
	listItems _ cart items.
	^ SuccessfulResponse with: listItems asBag. 
	
	! !


!InternalAPI methodsFor: 'checkout cart' stamp: 'eb 12/3/2020 00:29:13'!
addDetailedSaleTo: anUser of: anItemsCollection withCost: aCost
	
	| itemsWithPrice |
		
	itemsWithPrice _ Dictionary new .
	
	anItemsCollection do: [ :item | (itemsWithPrice includesKey: item) ifFalse:
		 [ itemsWithPrice at: item put: ((self priceOf: item) * (anItemsCollection occurrencesOf: item)) ]
	].
	
	detailedSalePerUser at: anUser put: (DetailedSale of: aCost with: itemsWithPrice)
	
	! !

!InternalAPI methodsFor: 'checkout cart' stamp: 'eb 12/3/2020 00:00:48'!
checkOutCart: aCartId withCreditCard: aCreditCard ofOwner: anUser on: aDate
	| cart cashier checkoutId |	
	[ cart _ carts at: aCartId ] 
		on: Error 
		do:[^ UnsuccessfulResponse with: self class cartNotRegisteredErrorDescription ].
		
	(self hasCartsOf: anUser) ifFalse: [ ^ UnsuccessfulResponse with: self class userHasNotCartsErrorDescription ].
	
	((cartsPerUser at: anUser) = cart) ifFalse: [ ^ UnsuccessfulResponse with: self class cartDoesNotBelongToUserErrorDescription ].
	[ cashier _ Cashier  toCheckout: cart  charging: aCreditCard  throught: merchantProcesor  on: aDate  registeringOn: OrderedCollection new ] 
		on: Error 
		do: [:error| ^ UnsuccessfulResponse with: error messageText].
		
	checkoutId _ self nextCheckOutId.
	
	self addDetailedSaleTo: anUser of: cart items withCost: cashier checkOut.
		
	^ SuccessfulResponse with: checkoutId.
	! !


!InternalAPI methodsFor: 'id generation' stamp: 'eb 12/2/2020 21:59:08'!
nextCartId
	nextCartId _ nextCartId + 1.
	^ nextCartId ! !

!InternalAPI methodsFor: 'id generation' stamp: 'eb 12/2/2020 21:59:42'!
nextCheckOutId
	nextCheckOutId _ nextCheckOutId + 1.
	^ nextCheckOutId
	! !


!InternalAPI methodsFor: 'expiration' stamp: 'eb 12/2/2020 22:00:46'!
ensureDateOf: aCartId isValidOn: aDate
	| halfHourAgo |
	halfHourAgo _ aDate - 30 minutes.
	((modifications includesKey: aCartId) and: [(modifications at: aCartId)  < halfHourAgo ]) 
		ifTrue: [ self error: self class cartIsExpiredErrorDescription ].! !

!InternalAPI methodsFor: 'expiration' stamp: 'eb 12/2/2020 22:03:08'!
ensureExecutionOf: aBlock withCart: aCartId isValidOn: aDate
	| returnValue |
	self ensureDateOf: aCartId isValidOn: aDate.
	returnValue _ aBlock value.
	self updateModificationDateOf: aCartId to: aDate.
	^ returnValue .
	
	! !

!InternalAPI methodsFor: 'expiration' stamp: 'eb 12/2/2020 22:03:07'!
updateModificationDateOf: aCartId to: aDate
	modifications at: aCartId put: aDate .! !


!InternalAPI methodsFor: 'list purchases' stamp: 'eb 12/3/2020 00:36:26'!
listPurchasesOf: anUser with: aPassword

	| detailedSale |
	
	detailedSale  _ detailedSalePerUser at: anUser ifAbsent: 
		[ ^ UnsuccessfulResponse with: self class canNotQueryListPurchsesOfEmptyCartErrorDescription ].
 
	^ SuccessfulResponse with: detailedSale.! !


!InternalAPI methodsFor: 'price' stamp: 'eb 12/3/2020 00:03:36'!
priceOf: anItem
	
	^ catalog at: anItem .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalAPI class' category: #TusLibros!
InternalAPI class
	instanceVariableNames: ''!

!InternalAPI class methodsFor: 'instance creation' stamp: 'ja 12/2/2020 16:37:19'!
with: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor
	
	^self new initializeWith: aUsersCollection on: aDate usingCatalog: aCatalog usingMerchantProccesor: aMerchantProccesor.! !


!InternalAPI class methodsFor: 'error descriptions' stamp: 'ja 12/1/2020 18:57:34'!
ISBNNotRegisteredErrorDescription

	^ 'ISBN is not registered'! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'eb 12/3/2020 00:35:14'!
canNotQueryListPurchsesOfEmptyCartErrorDescription
	
	^ 'Can not query list purchases of empty cart'.! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'eb 12/2/2020 22:53:25'!
cartDoesNotBelongToUserErrorDescription
	
	^ 'Cart does not belong to user'.! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'ja 11/30/2020 19:34:39'!
cartIsExpiredErrorDescription

	^ 'Cart is expired'! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'ja 12/1/2020 18:42:33'!
cartNotRegisteredErrorDescription

	^ 'Cart is not registered'! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'ja 12/1/2020 19:03:55'!
invalidQuantityErrorDescription

	^'Invalid quantity'! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'eb 12/2/2020 22:43:30'!
userHasNotCartsErrorDescription
	
	^ 'User has not carts'.! !

!InternalAPI class methodsFor: 'error descriptions' stamp: 'ja 11/29/2020 13:47:40'!
userNotRegisteredErrorDescription

	^ 'User not registered'! !


!classDefinition: #InternalAPIResponse category: #TusLibros!
Object subclass: #InternalAPIResponse
	instanceVariableNames: 'payload'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalAPIResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 18:18:53'!
code

	self subclassResponsibility ! !

!InternalAPIResponse methodsFor: 'accesing' stamp: 'eb 12/2/2020 19:42:21'!
payload

	^ payload copy.! !


!InternalAPIResponse methodsFor: 'initialization' stamp: 'ja 11/29/2020 18:56:21'!
initializeWith: aPayload

	payload _ aPayload! !

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


!classDefinition: #UnsuccessfulResponse category: #TusLibros!
InternalAPIResponse subclass: #UnsuccessfulResponse
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UnsuccessfulResponse methodsFor: 'accesing' stamp: 'ja 11/29/2020 19:00:07'!
code 

	^ 1! !


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


!classDefinition: #DetailedSale category: #TusLibros!
Sale subclass: #DetailedSale
	instanceVariableNames: 'detail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DetailedSale methodsFor: 'accessing' stamp: 'eb 12/2/2020 23:23:19'!
detail

	^ detail copy.! !


!DetailedSale methodsFor: 'initialization' stamp: 'eb 12/2/2020 23:26:33'!
initializeOf: aTotal with: anItemCollection
	
	total _ aTotal .
	detail _ anItemCollection .
	
	^ self .! !


!DetailedSale methodsFor: 'equality' stamp: 'eb 12/2/2020 23:41:33'!
= aDetailedSale

	^ total = aDetailedSale total and: (detail = aDetailedSale detail).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DetailedSale class' category: #TusLibros!
DetailedSale class
	instanceVariableNames: ''!

!DetailedSale class methodsFor: 'instance creation' stamp: 'eb 12/2/2020 23:25:29'!
of: aTotal with: anItemCollection

	^ self new initializeOf: aTotal with: anItemCollection .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'eb 12/3/2020 00:17:12'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'eb 12/3/2020 00:17:23'!
anotherItemSellByTheStorePrice
	
	^20! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'eb 12/3/2020 00:26:15'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
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

!StoreTestObjectsFactory methodsFor: 'internal API' stamp: 'eb 12/2/2020 19:39:04'!
internalApiUsingMerchantProccessor: aMerchantProccessor
	
	^ InternalAPI with: self authenticatedUsers 
				on: today 
				usingCatalog: self defaultCatalog 
				usingMerchantProccesor: aMerchantProccessor.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ja 12/2/2020 18:39:00'!
nextYear
	
	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ja 12/2/2020 18:38:11'!
pastYear
	
	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
