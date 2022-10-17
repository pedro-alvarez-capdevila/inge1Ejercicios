!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'account1 account2 portfolioWithOneAccount portfolioWithTwoAccounts portfolioWithOnePortfolioAndAccounts account3 anotherPortfolioWithOneAccount portfolioWithManyPortfoliosAndAccounts transactionOnAccount1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp' stamp: 'ms 10/16/2022 23:29:26'!
setUp

	account1 := ReceptiveAccount new.
	transactionOnAccount1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 80 on: account2.
	
	account3 := ReceptiveAccount new.
	Deposit register: 50 on: account3.
	
	portfolioWithOneAccount := Portfolio new.
	portfolioWithOneAccount addAsset: account1.
	
	anotherPortfolioWithOneAccount := Portfolio new.
	anotherPortfolioWithOneAccount addAsset: account2.
	
	portfolioWithTwoAccounts := Portfolio new.
	portfolioWithTwoAccounts addAsset: account1.
	portfolioWithTwoAccounts addAsset: account2.
	
	portfolioWithOnePortfolioAndAccounts := Portfolio new.
	portfolioWithOnePortfolioAndAccounts addAsset: portfolioWithOneAccount.
	portfolioWithOnePortfolioAndAccounts addAsset: account2.
	
	portfolioWithManyPortfoliosAndAccounts := Portfolio new.
	portfolioWithManyPortfoliosAndAccounts addAsset: portfolioWithOneAccount.
	portfolioWithManyPortfoliosAndAccounts addAsset: anotherPortfolioWithOneAccount.
	portfolioWithManyPortfoliosAndAccounts addAsset: account3.
! !


!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/6/2022 21:39:21'!
test01PortfolioHasZeroBalanceWhenCreated
	
	|portfolio|
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:17:21'!
test02PortfolioWithOneAccountHasSameBalanceAsTheAccount
	
	self assert: portfolioWithOneAccount balance equals: account1 balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:17:44'!
test03BalanceOfPortfolioWithMoreThanOneAccountEqualsTheSumOfAccountsBalance

	self assert: portfolioWithTwoAccounts balance equals: (account1 balance + account2 balance)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:20:44'!
test04BalanceOfPortfolioHavingAPortfolioAndAccountsEqualsTheSumOfAccountsAndPortfolioBalance

	self assert: portfolioWithOnePortfolioAndAccounts balance equals: (portfolioWithOneAccount balance + account2 balance)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:33:06'!
test05BalanceOfPortfolioHavingManyPortfoliosAndAccountsEqualsTheSumOfAccountsAndPortfoliosBalance
	
	|expectedBalance|
	
	expectedBalance := portfolioWithOneAccount balance + anotherPortfolioWithOneAccount balance + account3 balance.

	self assert: portfolioWithManyPortfoliosAndAccounts balance equals: expectedBalance! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:34:21'!
test06TransactionsOfPortfolioWithOneAccountReturnsTheAccountTransactions

	self assert: portfolioWithOneAccount transactions equals: account1 transactions! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:34:44'!
test07TransactionsOfPortfolioWithMoreThanOneAccountReturnsTheAccountsTransactions

	self assert: portfolioWithTwoAccounts transactions equals: account1 transactions, account2 transactions ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:36:19'!
test08TransactionsOfPortfolioWithOnePortfolioAndAccountsReturnsThePortfolioAndAccountsTransactions

	|expectedTransactions|
	
	expectedTransactions := portfolioWithOneAccount transactions, account2 transactions.

	self assert: portfolioWithOnePortfolioAndAccounts transactions equals: expectedTransactions ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:41:17'!
test09TransactionsOfPortfolioWithManyPortfoliosAndAccountsReturnsThePortfolioAndAccountsTransactions

	|expectedTransactions|
	
	expectedTransactions := portfolioWithOneAccount transactions, anotherPortfolioWithOneAccount transactions, account3 transactions.

	self assert: portfolioWithManyPortfoliosAndAccounts transactions equals: expectedTransactions ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:48:49'!
test10HasRegisteredReturnsTrueWhenTheTransactionIsInThePortfolioTransactions

	self assert: (portfolioWithManyPortfoliosAndAccounts hasRegistered: transactionOnAccount1)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 18:51:18'!
test11HasRegisteredReturnsFalseWhenTheTransactionIsNotInThePortfolioTransactions

	|newAccount transactionOnNewAccount|
	
	newAccount  := ReceptiveAccount new.
	transactionOnNewAccount := Deposit register: 230 on: newAccount.
	
	self deny: (portfolioWithManyPortfoliosAndAccounts hasRegistered: transactionOnNewAccount)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 23:46:47'!
test12CannotAddAnAssetTwiceToAPortfolioWithJustOneAsset

	self assertCannotAdd: account1 to: portfolioWithOneAccount! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/16/2022 23:47:03'!
test13CannotAddAnAssetToAPortfolioThatHasThatAssetInsideOneOfItsPortfolios

	self assertCannotAdd: portfolioWithOneAccount to: portfolioWithManyPortfoliosAndAccounts! !


!PortfolioTest methodsFor: 'testing' stamp: 'ms 10/16/2022 23:46:22'!
assertCannotAdd: anAsset to: aPortfolio

	self 
		should: [aPortfolio addAsset: anAsset ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio accountAlreadyAddedErrorDescription ].! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
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


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ms 10/6/2022 21:16:55'!
balanceAfterTransaction: anInitialBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'ms 10/6/2022 21:02:59'!
impactOnBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ms 10/6/2022 21:17:22'!
balanceAfterTransaction: anInitialBalance 

	^ anInitialBalance + value! !

!Deposit methodsFor: 'value' stamp: 'ms 10/6/2022 21:03:09'!
impactOnBalance

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ms 10/6/2022 21:17:34'!
balanceAfterTransaction: anInitialBalance 

	^ anInitialBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'ms 10/6/2022 21:03:19'!
impactOnBalance

	^ value negated! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'actions - private' stamp: 'ms 10/16/2022 23:27:06'!
contains: anAsset

	self subclassResponsibility ! !


!Asset methodsFor: 'transactions' stamp: 'ms 10/16/2022 22:40:11'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Asset methodsFor: 'transactions' stamp: 'ms 10/16/2022 22:40:25'!
transactions

	self subclassResponsibility ! !


!Asset methodsFor: 'balance' stamp: 'ms 10/16/2022 22:39:45'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ms 10/16/2022 23:28:56'!
balance
	
	^ assets sum: [:asset | asset balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'actions - private' stamp: 'ms 10/16/2022 23:49:48'!
assertPortfolioDoesNotContain: anAsset

	(self contains: anAsset) ifTrue: [self error: Portfolio accountAlreadyAddedErrorDescription].! !

!Portfolio methodsFor: 'actions - private' stamp: 'ms 10/16/2022 23:51:06'!
assetsTransactions

	^ assets collect: [:asset | asset transactions]! !

!Portfolio methodsFor: 'actions - private' stamp: 'ms 10/16/2022 23:28:32'!
contains: anAsset
	
	^ (self = anAsset) or: [ assets anySatisfy: [:asset | asset contains: anAsset]]! !


!Portfolio methodsFor: 'adding' stamp: 'ms 10/16/2022 23:49:27'!
addAsset: anAsset
	
	self assertPortfolioDoesNotContain: anAsset.
		
	assets add: anAsset! !


!Portfolio methodsFor: 'initialization' stamp: 'ms 10/16/2022 23:28:32'!
initialize 
	
	assets := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'ms 10/16/2022 18:52:49'!
hasRegistered: aTransaction
	
	^ self transactions includes: aTransaction! !

!Portfolio methodsFor: 'transactions' stamp: 'ms 10/16/2022 23:51:06'!
transactions
	
	^ (self assetsTransactions) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'ms 10/16/2022 23:01:20'!
accountAlreadyAddedErrorDescription

	^ 'The account was already added!!!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ms 10/6/2022 21:15:08'!
balance

	|balance|
	
	balance := 0.
	transactions do: [
		:aTransaction |
		balance := aTransaction balanceAfterTransaction: balance
	].

	^ balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'actions - private' stamp: 'ms 10/16/2022 23:26:03'!
contains: aXXX

	^ self = aXXX! !
