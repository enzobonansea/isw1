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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 16:48:17'!
test10SameChildrenDifferentParents

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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 16:51:20'!
test12PortofolioCantAddItself

	| portfolioRoot |
	
	portfolioRoot _ Portfolio new.
	
	self should: [ portfolioRoot register: portfolioRoot . self fail]  
		raise: Error
		withMessageText: Portfolio noTePodesAgregarAVosMismoErrorDescription .
		
	self assert: 0 equals: portfolioRoot amountOfAccounts.
			
	self assert: 0 equals: portfolioRoot balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 16:54:38'!
test13PortfolioCantBeAddedTwiceToSameParent

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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 16:59:48'!
test14CyclesWithParentOnSingleParentNodeAreForbidden

	| portfolioRoot1 portfolioChild1 portfolioChild2 account1 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	
	account1  _ ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	
	portfolioRoot1 register: account1 .
	portfolioRoot1 register: portfolioChild1.
	portfolioChild1 register: portfolioChild2.
	
	self should: [ portfolioChild2 register: portfolioRoot1. self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .
		
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:01:03'!
test15CyclesWithOtherNodeOnSingleParentNodeAreForbidden

	| portfolioRoot1 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	
	portfolioRoot1 register: portfolioChild1.
	
	portfolioChild1 register: portfolioChild2.
	
	portfolioChild1 register: portfolioChild3.
	
	portfolioChild3 register: portfolioChild4.
	
	self should: [ portfolioChild4 register: portfolioChild2 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:03:02'!
test16CyclesWithParentOnMultipleParentNodeAreForbidden

	| portfolioRoot1 portfolioRoot2 portfolioRoot3 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild4.
	portfolioRoot3 register: portfolioChild4.

	portfolioChild1 register: portfolioChild2.
	portfolioChild1 register: portfolioChild3.
	
	portfolioChild3 register: portfolioChild4.
	
	self should: [ portfolioChild4 register: portfolioRoot1 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:02:50'!
test17CyclesWithOtherNodeOnMultipleParentNodeAreForbidden

	| portfolioRoot1 portfolioRoot2 portfolioRoot3 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild4.
	portfolioRoot3 register: portfolioChild4.

	portfolioChild1 register: portfolioChild2.
	portfolioChild1 register: portfolioChild3.
	
	portfolioChild3 register: portfolioChild4.
	
	self should: [ portfolioChild4 register: portfolioChild2 . self fail]  
		raise: Error
		withMessageText: Portfolio noSePuedeAgregarDosVecesElMismoElemErrorDescription .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:04:40'!
test19

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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:04:51'!
test20

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


!classDefinition: #FinancialInvestment category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialInvestment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialInvestment methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:11:17'!
balance
	
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:12:15'!
hasRegistered: aFinancialInvestment
	
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:34:10'!
register: aFinancialObjectToRegister
	
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:17:21'!
registerInPortfolio: aPortfolio

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialInvestment subclass: #Portfolio
	instanceVariableNames: 'accounts childrenPortfolios parentsPortfolios state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'ja 11/6/2020 20:30:07'!
accounts

	^ accounts ! !

!Portfolio methodsFor: 'private' stamp: 'ja 11/8/2020 15:06:39'!
parents

	^ parentsPortfolios ! !

!Portfolio methodsFor: 'private' stamp: 'ja 11/8/2020 13:20:01'!
portfolios

	^ childrenPortfolios! !


!Portfolio methodsFor: 'zzz' stamp: 'ja 11/2/2020 19:53:17'!
amountOfAccounts
	
	^ accounts size.! !

!Portfolio methodsFor: 'zzz' stamp: 'ja 11/8/2020 13:20:01'!
amountOfPortfolios
	
	^ childrenPortfolios size.! !

!Portfolio methodsFor: 'zzz' stamp: 'ja 11/8/2020 13:20:01'!
isEmpty
	
	^ (accounts size = 0) and: [ childrenPortfolios size = 0].! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 10:35:59'!
accountIsInHierarchy: aReceptiveAccount
	
	| down up |
	"esta en la jerarquia de abajo"	
	down _ self accountIsInHierarchyDown: aReceptiveAccount .
		
	"esta en la jerarquia de arriba"
	up _ self accountIsInHierarchyUp: aReceptiveAccount. 
	
	^ down or: up.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 10:10:28'!
accountIsInHierarchyDown: aReceptiveAccount
	
	(accounts includes: aReceptiveAccount) ifTrue: [^ true ] 
		ifFalse: [ (self portfolios isEmpty) ifTrue:[ ^ false ] 
			ifFalse:[ self portfolios do: [:x | x accountIsInHierarchyDown: aReceptiveAccount ]]].
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 13:20:16'!
addParent: aPortfolio 
	
	parentsPortfolios add: aPortfolio .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 13:20:01'!
balance
	
	| balanceAccounts balancePortfolio |
	
	balanceAccounts _ accounts sum: [ :anAccount | anAccount balance] ifEmpty: [0] .
	
	balancePortfolio _ childrenPortfolios sum: [:x | x balance ] ifEmpty: [0].
	
	^ balancePortfolio + balanceAccounts .
		
		! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 15:07:13'!
getParentsRootAt: aCollection

	parentsPortfolios do: [ :elemParent | (elemParent parents isEmpty) 
							ifTrue:[ ^ aCollection add: elemParent ]                                                                                 
							ifFalse: [ elemParent getParentsRootAt: aCollection ]  ]   

! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:10:08'!
initialize

	accounts _ OrderedCollection new.
	
	childrenPortfolios _ OrderedCollection new.
	
	parentsPortfolios _ OrderedCollection new.
	 
	state _ RootPortfolio new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:44:10'!
isInAboveHierarchy: aPortfolio

	^ parentsPortfolios detect:[ :portfolio | portfolio isInHierarchy: aPortfolio ] ifNone:[^ false ] .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:32:26'!
isInHierarchy: aPortfolio

	^ (self = aPortfolio) or: [ childrenPortfolios detect:[ :children | children isInHierarchy: aPortfolio ] ifNone:[^ false] ].
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 16:15:01'!
isInHierarchy: aPortfolio put: answer

	
   ((childrenPortfolios includes: aPortfolio) or: [ self = aPortfolio ] ) ifTrue: [^ answer add: aPortfolio ] 
								ifFalse: [ (childrenPortfolios isEmpty) 
									ifTrue:[ ^ answer ] 
									ifFalse:[ childrenPortfolios do: [:portfolioChild | portfolioChild isInHierarchy: aPortfolio put: answer ]]].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:20:24'!
itsHierarchyHas: aPortfolio

	^ state lookFor: aPortfolio intoHierarchyOf: self.
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:56:46'!
register: aFinancialInvestment 
	
	
	aFinancialInvestment registerInPortfolio: self.

! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/7/2020 20:35:58'!
registerAccount: aReceptiveAccount
	
	accounts add: aReceptiveAccount ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:14:30'!
registerInPortfolio: aParentPortfolio
	
	(self = aParentPortfolio ) ifTrue: [ self error: self class noTePodesAgregarAVosMismoErrorDescription ].
	
	(aParentPortfolio itsHierarchyHas: self) ifTrue:[self error: self class noSePuedeAgregarDosVecesElMismoElemErrorDescription ].
		
	aParentPortfolio registerPortfolio: self. 
	
	state _ NotRootPortfolio new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 14:51:54'!
registerPortfolio: aPortfolio

	aPortfolio addParent: self.
		
	childrenPortfolios add: aPortfolio . ! !

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
FinancialInvestment subclass: #ReceptiveAccount
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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ja 11/7/2020 20:35:20'!
registerInPortfolio: aPortfolio

	aPortfolio registerAccount: self.! !

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


!classDefinition: #PortfolioState category: #'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioState methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:22:19'!
lookFor: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio

	self subclassResponsibility ! !


!classDefinition: #NotRootPortfolio category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #NotRootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NotRootPortfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:42:18'!
lookFor: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio

	^ aPotentialParentPortfolio isInAboveHierarchy: aPotentialChildPortfolio .! !


!classDefinition: #RootPortfolio category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #RootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'as yet unclassified' stamp: 'ja 11/8/2020 17:31:42'!
lookFor: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio

	aPotentialParentPortfolio isInHierarchy: aPotentialChildPortfolio .! !
