!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/2/2020 20:45:32'!
test01PortfolioHasNotAccountWhenCreated

	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio isEmpty.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:21'!
test02AccountsCanBeAddedToPortfolio

	| portfolio account |
	
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	
	portfolio register: account.
	
	self deny: portfolio isEmpty.
	
	self assert: 1 equals: portfolio amountOfAccounts.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:22'!
test03AccountCanBeAddedToPortfolioWithMultipleDeposit

	| portfolio account |
	
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account.
	
	portfolio register: account.
	
	self deny: portfolio isEmpty.
	
	self assert: 1 equals: portfolio amountOfAccounts.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:22'!
test04AccountCanBeAddedToPortfolioWithMultipleWithdraw

	| portfolio account |
	
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Withdraw register: 50 on: account.
	Withdraw register: 50 on: account.
	
	portfolio register: account.
	
	self deny: portfolio isEmpty.
	
	self assert: 1 equals: portfolio amountOfAccounts.
	
	self assert: 850 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:21'!
test05AccountCanBeAddedToPortfolioWithMultipleTransactions

	| portfolio account |
	
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	portfolio register: account.
	
	self deny: portfolio isEmpty.
	
	self assert: 1 equals: portfolio amountOfAccounts.
	
	self assert: 150 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:22'!
test06MultipleAccountsCanBeAdedToPortfolio

	| portfolio account1 account2 account3 totalBalance |
	
	portfolio _ Portfolio new.
	account1  _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	account3  _ ReceptiveAccount new.
	Deposit register: 100 on: account3.
	Withdraw register: 50 on: account3.
	
	portfolio register: account1.
	portfolio register: account2.
	portfolio register: account3.
	
	totalBalance _ account1 balance + account2 balance + account3 balance.
	
	self deny: portfolio isEmpty.
	
	self assert: 3 equals: portfolio amountOfAccounts.
	
	self assert: totalBalance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 18:08:21'!
test07EmptyPortfolioCanBeAdedToPortfolio

	| portfolio1 portfolio2 |
	
	portfolio1 _ Portfolio new.
	portfolio2  _ Portfolio new.
	portfolio1 register: portfolio2.
	
	self deny: portfolio1 isEmpty.
	
	self assert: 1 equals: portfolio1 amountOfPortfolios.
	
	self assert: 0 equals: portfolio1 balance .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 19:37:20'!
test08ANotEmptyPortfolioCanBeAdedToPortfolio

	| portfolioRoot portfolio2 account1 account2 account3 |
	
	portfolioRoot _ Portfolio new.
	portfolio2  _ Portfolio new.
	
	account1  _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	account3  _ ReceptiveAccount new.
	Deposit register: 100 on: account3.
	Withdraw register: 50 on: account3.
	
	portfolio2 register: account1.
	portfolio2 register: account2.
	portfolio2 register: account3.
	
	portfolioRoot register: portfolio2.
	
	self deny: portfolioRoot isEmpty.
	
	self assert: 1 equals: portfolioRoot amountOfPortfolios.
	
	self assert: 150 equals: portfolioRoot balance.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 19:42:19'!
test09ManyNotEmptyPortfoliosCaBeAdedToPortfolio

	| portfolioRoot portfolioChild1 portfolioChild2 account1 account2|
	
	portfolioRoot _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
		
	account1  _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	portfolioChild1 register: account1.
	portfolioChild2  register: account2.
	
	portfolioRoot register: portfolioChild1.
	portfolioRoot register: portfolioChild2.
		
	self deny: portfolioRoot isEmpty.
	
	self assert: 2 equals: portfolioRoot amountOfPortfolios.
	
	self assert: 100 equals: portfolioRoot balance.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 19:47:51'!
test10casoPadresDistintos

	| portfolioRoot1 portfolioRoot2 portfolioChild1 portfolioChild2 account1 account2 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
		
	account1  _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	portfolioChild1 register: account1.
	portfolioChild2  register: account2.
	
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot1 register: portfolioChild2.
	
	portfolioRoot2 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild2.
		
	self deny: portfolioRoot1 isEmpty.
	self deny: portfolioRoot2 isEmpty.
		
	self assert: 2 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 2 equals: portfolioRoot2 amountOfPortfolios.
	
	self assert: 100 equals: portfolioRoot1 balance.
	self assert: 100 equals: portfolioRoot2 balance.	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 20:06:58'!
test11muchosPadresPuedenTenerMuchosHijos

	| portfolioRoot1 portfolioRoot2 portfolioRoot3 
	 portfolioChild1 portfolioChild2  portfolioChild3 
	 account1 account2 account3 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
			
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 150 on: account2.
	Withdraw register: 50 on: account2.
	
	account3  _ ReceptiveAccount new.
	Deposit register: 100 on: account3.
	Withdraw register: 50 on: account3.
	
	portfolioChild1 register: account1.
	portfolioChild1  register: portfolioChild3. 
	portfolioChild2  register: account2.
	portfolioChild3 register: account3.
	
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot1 register: portfolioChild2.
	
	portfolioRoot2 register: portfolioChild2.
	
	portfolioRoot3 register: portfolioChild3 .
		
	self deny: portfolioRoot1 isEmpty.
	self deny: portfolioRoot2 isEmpty.
	self deny: portfolioRoot3 isEmpty.
			
	self assert: 2 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot2 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot3 amountOfPortfolios.
		
	self assert: 300 equals: portfolioRoot1 balance.
	self assert: 100 equals: portfolioRoot2 balance.	
	self assert: 50 equals: portfolioRoot3 balance.		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 01:27:43'!
test12NoTePodesAgregarAVosMismo

	| portfolioRoot |
	
	portfolioRoot _ Portfolio new.
	
	self should: [ portfolioRoot register: portfolioRoot . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .
		
	self assert: 0 equals: portfolioRoot amountOfAccounts.
			
	self assert: 0 equals: portfolioRoot balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 22:35:02'!
test13NoSePuedeAgregarDosVecesElMismoElem

	| portfolioRoot1 portfolioChild1 account1 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
			
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	portfolioRoot1 register: account1.
	portfolioRoot1 register: portfolioChild1.
	
	self should: [ portfolioRoot1 register: portfolioChild1 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription.
		
	self deny: portfolioRoot1 isEmpty.
	
	self assert: 1 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot1 amountOfAccounts.
			
	self assert: 150 equals: portfolioRoot1 balance.
	self assert: 0 equals: portfolioChild1 balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 00:25:24'!
test14DetectandoCiclosSimpleEntreDosPortfolios

	| portfolioRoot1 portfolioChild1 account1 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
			
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	portfolioRoot1 register: account1.
	portfolioRoot1 register: portfolioChild1.
	
	self should: [ portfolioChild1 register: portfolioRoot1 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .
		
	self deny: portfolioRoot1 isEmpty.
	
	self assert: 1 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot1 amountOfAccounts.
			
	self assert: 150 equals: portfolioRoot1 balance.
	self assert: 0 equals: portfolioChild1 balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 00:35:15'!
test15DetectandoCiclosSimpleEntrePortfolioYAccount

	| portfolioRoot1 portfolioChild1 account1 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
			
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	portfolioRoot1 register: account1.
	portfolioRoot1 register: portfolioChild1.
	
	self should: [ portfolioChild1 register: account1 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .
		
	self deny: portfolioRoot1 isEmpty.
	
	self assert: 1 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot1 amountOfAccounts.
			
	self assert: 150 equals: portfolioRoot1 balance.
	self assert: 0 equals: portfolioChild1 balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 00:35:05'!
test16DetectandoCiclosDificiles

	| portfolioRoot1 portfolioRoot2 portfolioRoot3 
	 portfolioChild1 portfolioChild2  portfolioChild3 
	 account1 account2 account3 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
			
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	account2  _ ReceptiveAccount new.
	Deposit register: 150 on: account2.
	Withdraw register: 50 on: account2.
	
	account3  _ ReceptiveAccount new.
	Deposit register: 100 on: account3.
	Withdraw register: 50 on: account3.
	
	portfolioChild1 register: account1.
	portfolioChild1  register: portfolioChild3. 
	portfolioChild2  register: account2.
	portfolioChild3 register: account3.
	
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot1 register: portfolioChild2.
	
	portfolioRoot2 register: portfolioChild2.
	
	portfolioRoot3 register: portfolioChild3.
	
	self should: [ portfolioChild3 register: portfolioRoot1 . self fail]  
		raise: Error
		withMessageText: Portfolio cicloNoSePuedeErrorDescription.
		
	self deny: portfolioRoot1 isEmpty.
	self deny: portfolioRoot2 isEmpty.
	self deny: portfolioRoot3 isEmpty.
			
	self assert: 2 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot2 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot3 amountOfPortfolios.
		
	self assert: 300 equals: portfolioRoot1 balance.
	self assert: 100 equals: portfolioRoot2 balance.	
	self assert: 50 equals: portfolioRoot3 balance.		! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ja 11/2/2020 20:38:53'!
addToBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ja 11/2/2020 20:39:20'!
addToBalance

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ja 11/2/2020 20:39:49'!
addToBalance

	^ value * (-1)! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 20:30:07'!
accounts

	^ accounts ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/2/2020 19:53:17'!
amountOfAccounts
	
	^ accounts size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/2/2020 19:52:31'!
amountOfPortfolios
	
	^ portfolios size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 17:49:49'!
balance
	
	| balanceAccounts balancePortfolio |
	
	balanceAccounts _ accounts sum: [ :anAccount | anAccount balance] ifEmpty: [0] .
	
	balancePortfolio _ portfolios sum: [:x | x balance ] ifEmpty: [0].
	
	^ balancePortfolio + balanceAccounts .
		
		! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 01:27:04'!
deepSearch: aPortfolioEntry 

	| isInPortfolio isInHierarchy |
	
	(aPortfolioEntry isKindOf: ReceptiveAccount) ifTrue: [	 
				(self accounts includes: aPortfolioEntry) ifTrue: [^true ]
				 ifFalse: [ ^ ((self parentRoot) searchAccountInHierarchy: aPortfolioEntry) ] ].
	
	isInPortfolio _ self portfolios includes: aPortfolioEntry.
	isInHierarchy _ self isInHierarchy: aPortfolioEntry.
	
	^ ( isInPortfolio or: isInHierarchy )! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 22:15:02'!
initialize

	accounts _ OrderedCollection new.
	
	portfolios _ OrderedCollection new.
	
	parent _ self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/2/2020 20:22:02'!
isEmpty
	
	^ (accounts size = 0) and: [ portfolios size = 0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 23:01:11'!
isInHierarchy: aPortofolioEntry 
	
	| parentRootSelf  parentRootOther |
	
	parentRootSelf _ self parentRoot.
	
	parentRootOther _ aPortofolioEntry parentRoot.
	
	^ parentRootSelf matchElementsOf: parentRootOther .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 00:20:40'!
matchElementsOf: aPortfolioRootToAdd
	
	| portfolioSelf otherPortfolio |
	
	
	portfolioSelf _ portfolios copy.
	portfolioSelf add: self.
	
	otherPortfolio _ aPortfolioRootToAdd portfolios copy.
	otherPortfolio add: aPortfolioRootToAdd.
	
	portfolioSelf addAllLast: accounts.
	otherPortfolio addAllLast: aPortfolioRootToAdd accounts.
	
	^ (portfolioSelf intersection: otherPortfolio) size > 0 .
	
	
		
	
		 ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 22:18:49'!
parentIs: aPortfolio 
	
	parent _ aPortfolio .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 01:13:25'!
parentRoot

	(self = parent) ifTrue: [ ^ self ].
	
	^ parent parentRoot.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 20:29:57'!
portfolios

	^ portfolios! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 00:30:26'!
register: aPortfolioEntry 
	
	(self deepSearch: aPortfolioEntry) ifTrue: [ self error: self class noSePuedeAgregarDosVecesElMismoElemErrorDescription ].
	
	(aPortfolioEntry isKindOf: ReceptiveAccount) ifTrue:[ accounts add: aPortfolioEntry ].
	
	(aPortfolioEntry isKindOf: Portfolio ) ifTrue:[ 	
		(self = aPortfolioEntry) ifTrue: [ self error: self class noTePodesAgregarAVosMismoErrorDescription ].
		aPortfolioEntry parentIs: self. 
		portfolios add: aPortfolioEntry ].

	
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 01:24:26'!
searchAccountInHierarchy: aReceptiveAccount
	
	
	
	(accounts includes: aReceptiveAccount) ifTrue: [^ true ] 
		ifFalse: [		(self portfolios isEmpty) ifTrue: [^false].
			 self portfolios do: [:x | x searchAccountInHierarchy: aReceptiveAccount ]].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 20:43:56'!
cicloNoSePuedeErrorDescription
	
	^ 'No se admiten ciclos rey'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 22:35:48'!
noSePuedeAgregarDosVecesElMismoElemErrorDescription
	
	^ 'No se puede agregar dos veces el mismo elem' ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ja 11/6/2020 22:32:06'!
noTePodesAgregarAVosMismoErrorDescription
	
	^ 'No te podes agregar a vos mismo'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'ja 11/6/2020 17:14:05'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ja 11/2/2020 20:42:20'!
balance

	| balance |
	
	balance _ 0.
	
	transactions do:[ :aTransactions | balance _ balance + aTransactions addToBalance].
	
	^ balance
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
