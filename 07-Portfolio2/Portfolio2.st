!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:01:47'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	Deposit register: 100 on: account.
	portfolio := Portfolio named: 'Marina portfolio' with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:05:39'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount named: 'luigi'.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'Marian' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'luigi'.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio named: 'pedro' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:02:24'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount named: 'luigi'.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio named: 'marian' with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:05:31'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount named: 'luigi'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'marian' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'luigi'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'pedro' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:05:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount named: 'luigi'.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount named: 'luigi'.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio named: 'marian' with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:05:12'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount named: 'luigi'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'marian' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'luigi'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'pedro' with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:13'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	portfolio := Portfolio  named: 'marian' with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:17'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	simplePortfolio := Portfolio named: 'marian' with: account.
	composedPortfolio := Portfolio named: 'marian' with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:21'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	simplePortfolio := Portfolio named: 'marian' with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:04:58'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	simplePortfolio := Portfolio named: 'luigi'.
	composedPortfolio := Portfolio named: 'marian' with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:27'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount named: 'luigi'.
	portfolio := Portfolio named: 'pedro'.
	leftParentPortfolio := Portfolio named: 'pedro' with: portfolio .
	leftRootParentPortfolio := Portfolio named: 'pedro' with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio named: 'marian' with: portfolio .
	rightRootParentPortfolio := Portfolio named: 'marian' with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:04:45'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount named: 'luigi'.
	portfolioToModify := Portfolio named: 'pedro'.
	rootPortfolio := Portfolio named: 'pedro' with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio named: 'marian' with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:42'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount named: 'luigi'.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:47'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  named: 'luigi'.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:50'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount named: 'luigi'.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:56'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount named: 'luigi'.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:03:59'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'luigi'.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:04:02'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'luigi'.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:04:05'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount named: 'luigi'.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'account' stamp: 'pedro 10/23/2022 23:04:09'!
newAccount

	^ ReceptiveAccount named: 'luigi'.! !

!ReportsTest methodsFor: 'account' stamp: 'pedro 10/23/2022 23:21:57'!
newAccountNamed: aName

	^ ReceptiveAccount named: aName.! !


!ReportsTest methodsFor: 'transfer' stamp: 'pedro 10/23/2022 18:33:40'!
transfer100From: account1 to: account2

	^ Transfer from: account1 to: account2  amount: 100! !

!ReportsTest methodsFor: 'transfer' stamp: 'pedro 10/23/2022 18:34:15'!
transfer200From: account1 to: account2

	^ Transfer from: account1 to: account2  amount: 200! !

!ReportsTest methodsFor: 'transfer' stamp: 'pedro 10/23/2022 18:13:37'!
transfer400From: simplePortfolioAccount to: composedPortfolioAccount

	^ Transfer from: composedPortfolioAccount to: simplePortfolioAccount amount: 400! !

!ReportsTest methodsFor: 'transfer' stamp: 'pedro 10/23/2022 18:34:15'!
twoTransfersOf100And200From: account2 to: account1

	self transfer100From: account1 to: account2.
	self transfer200From: account1 to: account2! !


!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 19:59:18'!
accountSummaryReporter: account

	^ AccountSummaryReporter with: account! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 19:59:18'!
test01AccountSummaryOfEmptyAccountReturnsOnlyTheBalance

	| account accountSummaryReporter |
	account := self newAccount.
	accountSummaryReporter := self accountSummaryReporter: account.
	
	self assert: (accountSummaryReporter generate) equals: (OrderedCollection with: 'Balance = 0')! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 19:59:18'!
test02AccountSummaryOfAccountWithDepositsReturnsTheDepositsAndTheBalance

	| account accountSummaryReporter |
	account := self newAccount.
	self deposit100: account.
	self deposit200: account.
	
	accountSummaryReporter := self accountSummaryReporter: account.
	
	self 
		assert: (accountSummaryReporter generate) 
		equals: (OrderedCollection with: 'Depósito por 100' with: 'Depósito por 200' with: 'Balance = 300')! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 19:59:35'!
test03AccountSummaryOfAccountWithWithdrawsReturnsTheWithdrawsAndTheBalance

	| account accountSummaryReporter |
	account := self newAccount.
	self withdraw100: account.
	self withdraw200: account.
	
	accountSummaryReporter := self accountSummaryReporter: account.
	
	self 
		assert: (accountSummaryReporter generate) 
		equals: (OrderedCollection with: 'Extracción por 100' with: 'Extracción por 200' with: 'Balance = -300')! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:00:04'!
test04AccountSummaryOfAccountWithTransferDepositsReturnsThemAndTheBalance

	| account1 account2 accountSummaryReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	self twoTransfersOf100And200From: account2 to: account1.
	
	accountSummaryReporter := self accountSummaryReporter: account2.
	
	self 
		assert: (accountSummaryReporter generate) 
		equals: (OrderedCollection with: 'Entrada por transferencia de 100' with: 'Entrada por transferencia de 200' with: 'Balance = 300')! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:00:22'!
test05AccountSummaryOfAccountWithTransferWithdrawsReturnsThemAndTheBalance

	| account1 account2 accountSummaryReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	self twoTransfersOf100And200From: account2 to: account1.
	
	accountSummaryReporter := self accountSummaryReporter: account1.
	
	self 
		assert: (accountSummaryReporter generate) 
		equals: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Salida por transferencia de 200' with: 'Balance = -300')! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:00:44'!
test06AccountSummaryOfEmptyPortfolioIsEmpty

	| emptyPortfolio accountSummaryReporter |
	emptyPortfolio := self newPortfolio.
	
	accountSummaryReporter := self accountSummaryReporter: emptyPortfolio.
	
	self assert: (accountSummaryReporter generate) equals: (OrderedCollection new)! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 22:58:04'!
test07AccountSummaryOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio expectedAccountSummary accountSummaryReporter  accountSummaryReporter1 accountSummaryReporter2|
	
	simplePortfolioAccount := self newAccount.
	self deposit100: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'marian' with: simplePortfolioAccount.
	
	composedPortfolioAccount := self newAccount.
	self withdraw100: composedPortfolioAccount.
	self transfer400From: simplePortfolioAccount to: composedPortfolioAccount.
	composedPortofolio := Portfolio named: 'pedro' with: simplePortfolio with: composedPortfolioAccount.
	
	accountSummaryReporter := self accountSummaryReporter: composedPortofolio.
	accountSummaryReporter1 := self accountSummaryReporter: simplePortfolioAccount.
	accountSummaryReporter2 := self accountSummaryReporter: composedPortfolioAccount.

	expectedAccountSummary := (OrderedCollection new addAll: (accountSummaryReporter1 generate)).
	expectedAccountSummary addAll: accountSummaryReporter2 generate.
	
	self 
		assert: (accountSummaryReporter generate) 
		equals: expectedAccountSummary.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:54:23'!
test08TransferNetOfEmptyAccountIsZero

	| account transferNetReporter |
	account := self newAccount.
	
	transferNetReporter := TransferNetReporter with: account.
	
	self assert: (transferNetReporter generate) equals: 0.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:55:27'!
test09TransferNetSumsTheTransferDepositsOfTheAccount

	| account1 account2 transferNetReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	
	self transfer100From: account1 to: account2.
	self transfer200From: account1 to: account2.
	
	transferNetReporter := TransferNetReporter with: account2.
	
	self assert: (transferNetReporter generate) equals: 300.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:55:40'!
test10TransferNetSubstractsTheTransferWithdrawsOfTheAccount

	| account1 account2 transferNetReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	
	self transfer100From: account1 to: account2.
	self transfer200From: account1 to: account2.
	
	transferNetReporter := TransferNetReporter with: account1.
	
	self assert: (transferNetReporter generate) equals: -300.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:55:56'!
test11TransferNetDoesNotTakeIntoAccountTheWithdrawsOfTheAccount

	| account1 account2 transferNetReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	
	self transfer100From: account1 to: account2.
	self transfer200From: account1 to: account2.
	self withdraw100: account1.
	
	transferNetReporter := TransferNetReporter with: account1.
	
	self assert: (transferNetReporter generate) equals: -300.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:56:15'!
test12TransferNetDoesNotTakeIntoAccountTheDepositsOfTheAccount

	| account1 account2 transferNetReporter |
	account1 := self newAccount.
	account2 := self newAccount.
	
	self transfer100From: account1 to: account2.
	self transfer200From: account1 to: account2.
	self deposit100: account1.
	
	transferNetReporter := TransferNetReporter with: account1.
	
	self assert: (transferNetReporter generate) equals: -300.! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 20:56:35'!
test13TransferNetOfEmptyPortfolioIsZero

	| emptyPortfolio transferNetReporter|
	emptyPortfolio := Portfolio new.
	
	transferNetReporter := TransferNetReporter with: emptyPortfolio.
	
	self assert: (transferNetReporter generate) equals: 0! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 22:58:08'!
test14TransferNetOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio transferNetReporter  transferNetReporter1 transferNetReporter2 |
	
	simplePortfolioAccount := self newAccount.
	self deposit100: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'marian' with: simplePortfolioAccount.
	
	composedPortfolioAccount := self newAccount.
	self withdraw100: composedPortfolioAccount.
	self transfer400From: simplePortfolioAccount to: composedPortfolioAccount.
	self transfer200From: composedPortfolioAccount to: self newAccount.
	composedPortofolio := Portfolio named: 'pedro' with: simplePortfolio with: composedPortfolioAccount.
	
	transferNetReporter := TransferNetReporter with: composedPortofolio.
	transferNetReporter1 := TransferNetReporter with: simplePortfolioAccount.
	transferNetReporter2 := TransferNetReporter with: composedPortfolioAccount.
		
	self 
		assert: transferNetReporter generate
		equals: (transferNetReporter2 generate + transferNetReporter1 generate)! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:14:25'!
test15PortfolioStructureReportOfEmptyPortfolioReturnsItsName

	| emptyPortfolio portfolioStructureReporter portfolioName |
	
	portfolioName := 'Portfolio de marian'.
	emptyPortfolio := Portfolio named: portfolioName.
	
	portfolioStructureReporter := PortfolioStructureReporter with: emptyPortfolio.
	
	self assert: (portfolioStructureReporter generate) equals: (OrderedCollection with: portfolioName).! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:46:13'!
test16PortfolioStructureReportOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio portfolioStructureReporter |
	
	simplePortfolioAccount := self newAccountNamed: 'Cuenta de pedro'.
	simplePortfolio := Portfolio named: 'Portfolio de pedro' with: simplePortfolioAccount.
	
	composedPortfolioAccount := self newAccountNamed: 'Cuenta de luigi'.
	composedPortofolio := Portfolio named: 'Portfolio de marian' with: composedPortfolioAccount with: simplePortfolio.

	portfolioStructureReporter := PortfolioStructureReporter with: composedPortofolio.
		
	self 
		assert: (portfolioStructureReporter generate)
		equals: (OrderedCollection 
				with: 'Portfolio de marian'
				with: '  Cuenta de luigi'
				with: '  Portfolio de pedro'
				with: '    Cuenta de pedro'
		)! !

!ReportsTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 23:53:17'!
test17PortfolioStructureReportRaisesAnErrorForAccount

	self 
		should: [ PortfolioStructureReporter with: self newAccount. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PortfolioStructureReporter cannotGenerateReportForAccount equals: anError messageText
			]! !


!ReportsTest methodsFor: 'portfolio' stamp: 'pedro 10/23/2022 18:11:03'!
newPortfolio

	^ Portfolio new! !


!ReportsTest methodsFor: 'transaction' stamp: 'pedro 10/23/2022 18:09:58'!
deposit100: simplePortfolioAccount

	^ Deposit register: 100 on: simplePortfolioAccount! !

!ReportsTest methodsFor: 'transaction' stamp: 'pedro 10/23/2022 18:10:29'!
deposit200: account

	^ Deposit register: 200 on: account! !

!ReportsTest methodsFor: 'transaction' stamp: 'pedro 10/23/2022 18:10:42'!
withdraw100: account

	^ Withdraw register: 100 on: account! !

!ReportsTest methodsFor: 'transaction' stamp: 'pedro 10/23/2022 18:10:49'!
withdraw200: account

	^ Withdraw register: 200 on: account! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 17:22:31'!
test01MakeATransferChangeTheAccountsBalance

	| account1 account2 |
	
	account1 := self newAccount.
	account2 := self newAccount.
	self deposit250: account1.
	
	self transfer50From: account1 to: account2.
	
	self assert: (account1 balance) equals: 200.
	self assert: (account2 balance) equals: 50.! !

!TransferTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 17:22:31'!
test02MakeATransferRegistersTheTransactionInTheAccounts

	| account1 account2 transfer |
	
	account1 := self newAccount.
	account2 := self newAccount.	
	self deposit250: account1. 
	
	transfer := self transfer50From: account1 to: account2.	
	
	self assert: (account1 hasRegistered: transfer relatedWithdraw).
	self assert: (account2 hasRegistered: transfer relatedDeposit).! !

!TransferTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 17:34:09'!
test03FromADepositCanNavigateToTheRelatedTransfer

	| transfer |
	
	transfer := self transfer50From: self newAccount to: self newAccount.	
	
	self assert: (transfer relatedDeposit relatedTransfer) equals: transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'pedro 10/23/2022 17:34:31'!
test04FromAWithdrawCanNavigateToTheRelatedTransfer

	| transfer |
	
	transfer := self transfer50From: self newAccount to: self newAccount.	
	
	self assert: (transfer relatedWithdraw relatedTransfer) equals: transfer.! !


!TransferTest methodsFor: 'transfer' stamp: 'pedro 10/23/2022 17:22:30'!
transfer50From: account1 to: account2

	^ Transfer from: account1 to: account2 amount: 50! !


!TransferTest methodsFor: 'account' stamp: 'pedro 10/23/2022 23:04:13'!
newAccount

	^ ReceptiveAccount named: 'luigi'.! !


!TransferTest methodsFor: 'deposit' stamp: 'pedro 10/23/2022 17:21:57'!
deposit250: account1

	^ Deposit register: 250 on: account1! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'pedro 10/23/2022 21:47:42'!
report: reporter
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'pedro 10/23/2022 22:54:05'!
initializeWith: aName 
	
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'pedro 10/23/2022 21:42:43'!
report: reporter 
	^ reporter generateForPortfolio: self.
! !


!Portfolio methodsFor: 'report - private' stamp: 'pedro 10/23/2022 21:07:00'!
executeOverAccounts: aBlockClosure 
	^ aBlockClosure value: accounts.! !

!Portfolio methodsFor: 'report - private' stamp: 'pedro 10/23/2022 23:16:07'!
name
	^ name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'pedro 10/23/2022 22:51:58'!
named: aName

	^self new initializeWith: aName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'pedro 10/23/2022 22:52:37'!
named: aName with: anAccount

	^(self named: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'pedro 10/23/2022 22:52:54'!
named: aName with: anAccount with: anotherAccount

	^(self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'pedro 10/23/2022 23:01:26'!
initializeWith: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'pedro 10/23/2022 21:43:24'!
report: reporter
	^ reporter generateForReceptiveAccount: self.
	! !


!ReceptiveAccount methodsFor: 'report - private' stamp: 'pedro 10/23/2022 21:00:32'!
executeOverTransactions: aBlockClosure 
	^ aBlockClosure value: transactions.! !

!ReceptiveAccount methodsFor: 'report - private' stamp: 'pedro 10/23/2022 23:37:52'!
name
	^ name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'pedro 10/23/2022 23:00:55'!
named: aName

	^ self new initializeWith: aName.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'execute' stamp: 'pedro 10/23/2022 22:20:20'!
execute: aTransactionOperation
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'execute' stamp: 'pedro 10/23/2022 22:16:54'!
execute: aTransactionOperation 
	^ aTransactionOperation generateForDeposit.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'initialization' stamp: 'pedro 10/23/2022 17:29:25'!
initializeWithTransfer: aTransfer 
	
	transfer := aTransfer.! !


!TransferDeposit methodsFor: 'accessing' stamp: 'pedro 10/23/2022 17:29:36'!
relatedTransfer
	^ transfer.! !


!TransferDeposit methodsFor: 'value' stamp: 'pedro 10/23/2022 17:32:59'!
value
	^ transfer value.! !


!TransferDeposit methodsFor: 'balance' stamp: 'pedro 10/23/2022 17:32:42'!
affectBalance: balance 
	^ balance + self value.! !


!TransferDeposit methodsFor: 'execute' stamp: 'pedro 10/23/2022 22:17:33'!
execute: aTransactionOperation 
	^ aTransactionOperation generateForTransferDeposit.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 17:28:56'!
withTransfer: aTransfer registerOn: aReceptiveAccount 
	| transferDeposit |
	
	transferDeposit := self new initializeWithTransfer: aTransfer.
	aReceptiveAccount register: transferDeposit.
		
	^ transferDeposit! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'pedro 10/23/2022 17:36:30'!
initializeWithTransfer: aTransfer 
	
	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'value' stamp: 'pedro 10/23/2022 17:39:14'!
value
	^ transfer value.! !


!TransferWithdraw methodsFor: 'accessing' stamp: 'pedro 10/23/2022 17:36:44'!
relatedTransfer
	^ transfer.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'pedro 10/23/2022 17:37:10'!
affectBalance: balance 
	^ balance - self value.! !


!TransferWithdraw methodsFor: 'execute' stamp: 'pedro 10/23/2022 22:17:48'!
execute: aTransactionOperation 
	^ aTransactionOperation generateForTransferWithdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 17:36:19'!
withTransfer: aTransfer registerOn: aReceptiveAccount 
	| transferWithdraw |
	
	transferWithdraw := self new initializeWithTransfer: aTransfer.
	aReceptiveAccount register: transferWithdraw.
		
	^ transferWithdraw! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'execute' stamp: 'pedro 10/23/2022 22:18:05'!
execute: aTransactionOperation 
	^ aTransactionOperation generateForWithdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reporter category: 'Portfolio-Solucion'!
Object subclass: #Reporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:21:48'!
generate
	^ account report: self.! !

!Reporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 21:39:48'!
generateForPortfolio: aPortfolio
	self subclassResponsibility.! !

!Reporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 21:39:58'!
generateForReceptiveAccount: aReceptiveAccount
	self subclassResponsibility.! !


!Reporter methodsFor: 'initialization' stamp: 'pedro 10/23/2022 21:41:01'!
initializeWith: anAccount 
	
	account := anAccount.! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-Solucion'!
Reporter subclass: #AccountSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!AccountSummaryReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 21:44:00'!
generateForPortfolio: aPortfolio
	
	^ aPortfolio executeOverAccounts: [:accounts | (accounts collect: [:anAccount | anAccount report: self])flatten]
! !

!AccountSummaryReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 21:29:46'!
generateForReceptiveAccount: aReceptiveAccount
	| accountSummary |
	accountSummary := aReceptiveAccount executeOverTransactions: [:transactions | 
		transactions collect: [:transaction | 
		|lineForAccountSummary|
		lineForAccountSummary := LineForAccountSummary with: transaction.
		lineForAccountSummary generate.
		].
	].
	accountSummary add: ('Balance = ', aReceptiveAccount balance asString).
	^ accountSummary.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReporter class' category: 'Portfolio-Solucion'!
AccountSummaryReporter class
	instanceVariableNames: ''!

!AccountSummaryReporter class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 19:57:17'!
with: anAccount 

	^self new initializeWith: anAccount ! !


!classDefinition: #PortfolioStructureReporter category: 'Portfolio-Solucion'!
Reporter subclass: #PortfolioStructureReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!PortfolioStructureReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 23:47:15'!
generateForPortfolio: aPortfolio 
	| portfolioStructure |
	portfolioStructure := OrderedCollection with: aPortfolio name.
	portfolioStructure addAll: (aPortfolio executeOverAccounts: [:accounts | 
		| portfolioAccountsStructure |
		portfolioAccountsStructure :=  (accounts collect: [:anAccount | anAccount report: self]) flatten.
		portfolioAccountsStructure collect: [:accountName | '  ', accountName ].
		]).
	^ portfolioStructure.
	! !

!PortfolioStructureReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 23:32:37'!
generateForReceptiveAccount: aReceptiveAccount 
	^ aReceptiveAccount name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructureReporter class' category: 'Portfolio-Solucion'!
PortfolioStructureReporter class
	instanceVariableNames: ''!

!PortfolioStructureReporter class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 23:52:50'!
with: aPortfolio 
	(aPortfolio isKindOf: Portfolio) ifFalse: [self error: self cannotGenerateReportForAccount].
	^self new initializeWith: aPortfolio ! !


!PortfolioStructureReporter class methodsFor: 'error' stamp: 'pedro 10/23/2022 23:53:14'!
cannotGenerateReportForAccount
	^ 'cannot generate this report for accounts!!!!!!'! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Solucion'!
Reporter subclass: #TransferNetReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!TransferNetReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 21:45:01'!
generateForPortfolio: aPortfolio
	^ aPortfolio executeOverAccounts: [:accounts | accounts sum: [:anAccount | anAccount report: self] ifEmpty: [0]].! !

!TransferNetReporter methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:01:15'!
generateForReceptiveAccount: aReceptiveAccount
	^ aReceptiveAccount executeOverTransactions: [:transactions | 
		transactions 
		inject: 0
		into: [ :currentTransferNet :transaction | 
			| affectTransferNet |
			affectTransferNet := AffectTransferNet with: transaction andTransferNet: currentTransferNet.
			affectTransferNet generate.
			]
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReporter class' category: 'Portfolio-Solucion'!
TransferNetReporter class
	instanceVariableNames: ''!

!TransferNetReporter class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 20:54:41'!
with: anAccount 
	
	^self new initializeWith: anAccount ! !


!classDefinition: #TransactionOperation category: 'Portfolio-Solucion'!
Object subclass: #TransactionOperation
	instanceVariableNames: 'transaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionOperation methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:21:23'!
generate
	^ transaction execute: self.! !

!TransactionOperation methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:13:47'!
generateForDeposit
	self subclassResponsibility.! !

!TransactionOperation methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:13:59'!
generateForTransferDeposit
	self subclassResponsibility.! !

!TransactionOperation methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:14:10'!
generateForTransferWithdraw
	self subclassResponsibility.! !

!TransactionOperation methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:14:21'!
generateForWithdraw
	self subclassResponsibility.! !


!classDefinition: #AffectTransferNet category: 'Portfolio-Solucion'!
TransactionOperation subclass: #AffectTransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AffectTransferNet methodsFor: 'initialization' stamp: 'pedro 10/23/2022 22:02:11'!
initializeWith: aTransaction andTransferNet: aTransferNet 
	
	transaction := aTransaction.
	transferNet := aTransferNet.! !


!AffectTransferNet methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:07:16'!
generateForDeposit
	^ transferNet.! !

!AffectTransferNet methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:04:04'!
generateForTransferDeposit
	^ transferNet + transaction value.! !

!AffectTransferNet methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:05:53'!
generateForTransferWithdraw
	^ transferNet - transaction value.! !

!AffectTransferNet methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:06:38'!
generateForWithdraw
	^ transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AffectTransferNet class' category: 'Portfolio-Solucion'!
AffectTransferNet class
	instanceVariableNames: ''!

!AffectTransferNet class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 22:01:38'!
with: aTransferDeposit andTransferNet: aTransferNet 
	
	^self new initializeWith: aTransferDeposit andTransferNet: aTransferNet ! !


!classDefinition: #LineForAccountSummary category: 'Portfolio-Solucion'!
TransactionOperation subclass: #LineForAccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!LineForAccountSummary methodsFor: 'initialization' stamp: 'pedro 10/23/2022 20:32:34'!
initializeWith: aTransaction 
	
	transaction := aTransaction.! !


!LineForAccountSummary methodsFor: 'generate' stamp: 'pedro 10/23/2022 20:38:25'!
generateForDeposit
	^ 'Depósito por ', transaction value asString.! !

!LineForAccountSummary methodsFor: 'generate' stamp: 'pedro 10/23/2022 20:41:38'!
generateForTransferDeposit
	^ 'Entrada por transferencia de ', transaction value asString! !

!LineForAccountSummary methodsFor: 'generate' stamp: 'pedro 10/23/2022 22:08:59'!
generateForTransferWithdraw
	^ 'Salida por transferencia de ', transaction value printString.! !

!LineForAccountSummary methodsFor: 'generate' stamp: 'pedro 10/23/2022 20:40:38'!
generateForWithdraw
	^ 'Extracción por ', transaction value asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineForAccountSummary class' category: 'Portfolio-Solucion'!
LineForAccountSummary class
	instanceVariableNames: ''!

!LineForAccountSummary class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 20:32:22'!
with: aTransaction 
	
	^self new initializeWith: aTransaction ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'relatedWithdraw amountTransfered relatedDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'accessing' stamp: 'pedro 10/23/2022 17:19:38'!
relatedDeposit

	^relatedDeposit! !

!Transfer methodsFor: 'accessing' stamp: 'pedro 10/23/2022 17:14:12'!
relatedWithdraw
	^ relatedWithdraw.! !

!Transfer methodsFor: 'accessing' stamp: 'pedro 10/23/2022 17:31:47'!
value
	^ amountTransfered.! !


!Transfer methodsFor: 'initialization' stamp: 'pedro 10/23/2022 17:35:06'!
initializeFrom: aSenderAccount to: aReceiverAccount amount: amountToTransfer 

	relatedDeposit := TransferDeposit withTransfer: self registerOn: aReceiverAccount.
	relatedWithdraw := TransferWithdraw withTransfer: self registerOn: aSenderAccount.

	amountTransfered := amountToTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'pedro 10/23/2022 17:16:23'!
from: aSenderAccount to: aReceiverAccount amount: amountToTransfer 

	^self new initializeFrom: aSenderAccount to: aReceiverAccount amount: amountToTransfer.! !
