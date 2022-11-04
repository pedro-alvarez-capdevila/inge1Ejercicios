!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:45:57'!
invalidBook

	^ 'some-invalid-code'! !

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:44:13'!
validBook1

	^ 'valid-ISBN'! !

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:47:40'!
validBook2

	^ 'book2'! !

!CartTest methodsFor: 'book' stamp: 'pedro 11/1/2022 21:33:38'!
validBookWithPrice100

	^ (self validBook1)->100! !


!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:47:00'!
cartWithCatalogWithValidBook1

	^ Cart withCatalog: self catalogWithValidBook1! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:49:44'!
cartWithCatalogWithValidBook1And2

	^ Cart withCatalog: (self catalogWithValidBook1And2)! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:43:08'!
newCart

	^ Cart new! !


!CartTest methodsFor: 'catalog' stamp: 'pedro 11/1/2022 21:33:38'!
catalogWithValidBook1

	^ Dictionary with: self validBookWithPrice100.! !

!CartTest methodsFor: 'catalog' stamp: 'pedro 11/1/2022 21:33:38'!
catalogWithValidBook1And2

	^ Dictionary with: self validBookWithPrice100 with: (self validBook2)->100.! !


!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:43:08'!
test01CartIsEmptyWhenIsCreated

	self assert: self newCart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:45:25'!
test02CartIsNotEmptyAfterAddingAValidBook

	| cart validBook |
	validBook := self validBook1.
	cart := Cart withCatalog: (self catalogWithValidBook1).
	cart addBook: validBook amount: 1.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:45:57'!
test03CannotAddABookThatIsNotFromThePublisher

	| cart |
	
	cart := self newCart.
	self 
		should: [cart addBook: self invalidBook amount: 1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart bookNotFoundOnCatalogErrorDescription.
			self assert: cart isEmpty.
			].! !

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:47:01'!
test04CanAddManyValidBooksAtTheSameTimetoTheCart

	| cart book |
	
	book := self validBook1.
	cart := self cartWithCatalogWithValidBook1.
	cart addBook: book amount: 4.
	
	self assert: (cart hasBook: book amount: 4).! !

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:47:00'!
test05CannotAddLessThanOneBookToTheCart

	| cart book |
	
	book := self validBook1.
	cart := self cartWithCatalogWithValidBook1.
	
	self 
		should: [cart addBook: book amount: 0.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart cannotAddLessThanOneBookErrorDescription.
			self assert: cart isEmpty.
			].! !

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:43:08'!
test06ListOfProductsOfNewCartIsEmpty

	| cart |
	cart := self newCart.
	
	self assert: cart list isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'pedro 11/1/2022 21:04:32'!
test07ListOfProductsOfCartHasTheBooksOfTheCart

	| cart book1 book2 |
	
	book1 := self validBook1.
	book2 := self validBook2.
	cart := self cartWithCatalogWithValidBook1And2.
	cart addBook: book1 amount: 2. 
	cart addBook: book2 amount: 1.
	
	self assert: cart list equals: (Bag with: book1 with: book1 with: book2).! !

!CartTest methodsFor: 'test' stamp: 'pedro 11/1/2022 20:59:33'!
test08CannotAdANonIntegerAmountOfBooks

	| cart book |
	
	book := self validBook1.
	cart := self cartWithCatalogWithValidBook1.
	
	self 
		should: [cart addBook: book amount: 1.3]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart cannotAdANonIntegerAmountErrorDescription.
			self assert: cart isEmpty.
			].! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 19:20:11'!
monthNotExpired

	^ Date today month monthIndex! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 19:45:28'!
notExpiredCreditCard

	^ CreditCard of: self validCardName number: self validCardNumber expirationMonth: self monthNotExpired expirationYear: self yearNotExpired! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 16:58:03'!
validCardName

	^ 'pedro'! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/1/2022 23:06:53'!
validCardNumber

	^ '1111222233334444'! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 17:46:17'!
validExpirationMonth

	^ 10! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 17:46:53'!
validExpirationYear

	^ 2020! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 19:19:56'!
yearNotExpired

	^ Date today yearNumber + 10! !


!CashierTest methodsFor: 'cashier' stamp: 'pedro 11/2/2022 17:03:19'!
createSalesBook

	^ OrderedCollection new! !


!CashierTest methodsFor: 'test' stamp: 'pedro 11/1/2022 21:14:30'!
test01CashierCannotHaveEmptyCart

	self
		should: [Cashier for: (Cart new)]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotInitializeWithEmptyCartErrorDescription ]! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 19:12:31'!
test02CheckoutOfCartWithProductsRegistersTheSale

	| cart cashier salesBook |
	
	salesBook := self createSalesBook.
	cart := self cartWithValidBook.
	cashier := Cashier for: cart.
	
	cashier checkoutRegisterOn: salesBook.
	
	self assert: salesBook includes: cart listPrice.
	
	
	

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 19:12:12'!
test03CashierCannotCheckoutTwice

	| cart cashier salesBook |
	
	salesBook := self createSalesBook.
	cart := self cartWithValidBook.
	cashier := Cashier for: cart.
	
	cashier checkoutRegisterOn: salesBook.

	self
		should: [cashier checkoutRegisterOn: salesBook.]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier cannotCheckoutTwiceErrorDescription.
			self assert: salesBook equals: (OrderedCollection with: cart listPrice)
			 ]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 17:46:53'!
test04CardNameShouldNotBeEmpty

	| emptyName validCardNumber validExpirationMonth validExpirationYear |
	
	emptyName := '    '.
	validCardNumber := self validCardNumber.
	validExpirationMonth := self validExpirationMonth.
	validExpirationYear := self validExpirationYear.

	self
		should: [CreditCard of: emptyName number: validCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard invalidNameErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 17:49:38'!
test05CardSizeNameShouldBeSmallerThan31Characters

	| nameOf31Characters validCardNumber validExpirationMonth validExpirationYear |
	
	nameOf31Characters := '0123456789012345678901234567890'.
	validCardNumber := self validCardNumber.
	validExpirationYear := self validExpirationYear.
	validExpirationMonth := self validExpirationMonth. 

	self
		should: [CreditCard of: nameOf31Characters number: validCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard nameWithMoreThan30CharactersErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 17:51:21'!
test06CardNumberSizeShouldBeEqualsTo16

	| validName invalidCardNumber validExpirationMonth validExpirationYear |
	
	validName := self validCardName.
	invalidCardNumber := '11'.
	validExpirationYear := self validExpirationYear.
	validExpirationMonth := self validExpirationMonth.

	self
		should: [CreditCard of: validName number: invalidCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard numberSizeShouldBe16ErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 17:42:15'!
test07CardExpirationMonthDateShouldHaveTwoDigits

	| validCardNumber expirationMonth expirationYear |
	
	validCardNumber := self validCardNumber.
	expirationMonth := 100.
	expirationYear := self validExpirationYear.

	self
		should: [CreditCard of: self validCardName number: validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CreditCard invalidExpirationMonthErrorDescription
			]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 17:53:28'!
test08CardExpirationYearDateShouldHaveFourDigits

	| validCardNumber expirationMonth expirationYear |
	
	validCardNumber := self validCardNumber.
	expirationMonth := self validExpirationMonth .
	expirationYear := 100.

	self
		should: [CreditCard of: self validCardName number: validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CreditCard invalidExpirationYearErrorDescription
			]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 20:27:43'!
test09CreditCardKnowsIfIsExpired

	
	| expiredCreditCard  expirationYear expirationMonth yearAfterTheExpiration monthAfterTheExpiration |
	
	expirationYear := 2020.
	expirationMonth := 10.
	monthAfterTheExpiration := 10.
	yearAfterTheExpiration := 2021.
		
	expiredCreditCard := CreditCard of: self validCardName number: self validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear.

	self assert: (expiredCreditCard isExpiredOn: (GregorianMonthOfYear yearNumber: yearAfterTheExpiration monthNumber: monthAfterTheExpiration) ).
	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 20:14:27'!
test10CannotCheckoutWithExpiredCreditCard

	| cashier salesBook expirationYear expirationMonth expiredCreditCard merchantWasNotCalled  |
	
	salesBook := self createSalesBook.
	merchantWasNotCalled := true.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: [merchantWasNotCalled := false]).
	
	expirationYear := Date today yearNumber - 2.
	expirationMonth := Date today month monthIndex.
		
	expiredCreditCard := CreditCard of: self validCardName number: self validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear.
	
	self 
		should: [cashier checkoutWith: expiredCreditCard registeringOn: salesBook.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier cannotCheckoutWithExpiredCreditCardErrorDescription.
			self assert: salesBook isEmpty.
			self assert: merchantWasNotCalled
			]
	
	
	

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 19:56:39'!
test11CannotCheckoutWithCreditCardWithoutbalance

	self assertMerchantProcessorRaisesError: 'the card has not enough balance'.
	
	
	

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 19:57:00'!
test12CannotCheckoutWithStolenCreditCard

	self assertMerchantProcessorRaisesError: 'the card is stolen!!!! call the police!!!!'.
	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/2/2022 20:11:31'!
test13CanCheckoutWithCardThatHasBalance

	| cashier salesBook creditCard |
	
	salesBook := self createSalesBook.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: []).
	
	creditCard := self notExpiredCreditCard.
	
	cashier checkoutWith: creditCard registeringOn: salesBook.
	
	self assert: salesBook includes: self cartWithValidBook listPrice.
	
	
	

	! !


!CashierTest methodsFor: 'assertions' stamp: 'pedro 11/2/2022 19:56:12'!
assertMerchantProcessorRaisesError: merchantProcessorError

	| cashier salesBook creditCard|
	
	salesBook := self createSalesBook.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: [self error: merchantProcessorError]).
	
	creditCard := self notExpiredCreditCard.
	
	self 
		should: [cashier checkoutWith: creditCard registeringOn: salesBook.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: merchantProcessorError.
			self assert: salesBook isEmpty.
			]
	
	
	

	! !


!CashierTest methodsFor: 'cart' stamp: 'pedro 11/2/2022 19:10:01'!
cartWithValidBook
	|cart|
	cart := Cart withCatalog: (Dictionary with: self validBook->100).
	cart addBook: self validBook amount: 2.
	^ cart ! !

!CashierTest methodsFor: 'cart' stamp: 'pedro 11/2/2022 17:03:42'!
validBook

	^ 'valid book'! !


!classDefinition: #TusLibrosRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosRestInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 19:58:57'!
invalidCredentialsErrorDescription

	^ 'invalid credentials'! !

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:07:42'!
test01CannotCreateWithCredentials

	| userId userPassword tlRestInterface loginAuthorizer |
	
	userId := '10'.
	userPassword := 'password'.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | self error: self invalidCredentialsErrorDescription].
	tlRestInterface := TLRestInterface withAuthorizer: loginAuthorizer.
	
	self
		should: [tlRestInterface createCartFor: userId withPassword: userPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: self invalidCredentialsErrorDescription.
			]! !

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:37:03'!
test02CanCreateCartWithValidCredentials

	| userId userPassword tlRestInterface loginAuthorizer isAuthorized cartID |
	
	userId := '10'.
	userPassword := 'password'.
	isAuthorized := false.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
	tlRestInterface := TLRestInterface withAuthorizer: loginAuthorizer.
	cartID := tlRestInterface createCartFor: userId withPassword: userPassword.
	
	self assert: isAuthorized.
	self assert: (tlRestInterface hasCartWithId: cartID).! !

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:51:42'!
test03CanCreateMultipleCarts

	| userId userPassword tlRestInterface loginAuthorizer isAuthorized cartID1 cartID2 |
	
	userId := '10'.
	userPassword := 'password'.
	isAuthorized := false.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
	tlRestInterface := TLRestInterface withAuthorizer: loginAuthorizer.
	cartID1 := tlRestInterface createCartFor: userId withPassword: userPassword.
	cartID2 := tlRestInterface createCartFor: userId withPassword: userPassword.
	
	self assert: isAuthorized.
	self assert: (tlRestInterface hasCartWithId: cartID1).
	self assert: (tlRestInterface hasCartWithId: cartID2).
	self assert: (cartID1 ~= cartID2).! !

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:15:39'!
test04CannotListCartWithInvalidId

	| userId userPassword isAuthorized tlRestInterface loginAuthorizer cartID1 |
	
	userId := '10'.
	userPassword := 'password'.
	isAuthorized := false.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
	tlRestInterface := TLRestInterface withAuthorizer: loginAuthorizer.
	cartID1 := tlRestInterface createCartFor: userId withPassword: userPassword.
	
	self 
		should: [tlRestInterface listCartWithId: (cartID1 + 10)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: TLRestInterface invalidCartIdErrorDescription]
	
	! !

!TusLibrosRestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:37:12'!
test05ListCartReturnTheBooksOfTheCart

	| userId userPassword isAuthorized tlRestInterface loginAuthorizer cartID listCart book catalog booksAmount |
	
	userId := '10'.
	userPassword := 'password'.
	isAuthorized := false.
	book := 'valid book'.
	catalog := Dictionary with: book->100.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
	tlRestInterface := TLRestInterface withAuthorizer: loginAuthorizer andCatalog: catalog.
	cartID := tlRestInterface createCartFor: userId withPassword: userPassword.
	booksAmount := 5.
	tlRestInterface addToCart: cartID book: book amount: booksAmount.

	listCart := tlRestInterface listCartWithId: cartID.
	
	self assert: listCart size equals: booksAmount.
	self assert: (listCart occurrencesOf: book) equals: booksAmount.
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing - private' stamp: 'pedro 11/1/2022 21:01:47'!
assertIsValidAmount: amountToAdd

	(amountToAdd < 1) ifTrue: [self error: Cart cannotAddLessThanOneBookErrorDescription].
	amountToAdd isInteger ifFalse:  [self error: Cart cannotAdANonIntegerAmountErrorDescription]! !

!Cart methodsFor: 'testing - private' stamp: 'pedro 11/1/2022 21:29:20'!
assertIsValidBook: aBook

	^ (catalog includesKey: aBook) ifFalse: [self error: Cart bookNotFoundOnCatalogErrorDescription]! !


!Cart methodsFor: 'testing' stamp: 'pedro 10/27/2022 21:33:14'!
hasBook: aBook amount: amountOfBooks 
	^ (books occurrencesOf: aBook) = amountOfBooks.! !

!Cart methodsFor: 'testing' stamp: 'pedro 10/27/2022 20:54:19'!
isEmpty
	^ books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'pedro 11/1/2022 21:34:11'!
initialize

	books := Bag new.
	catalog := Dictionary new.! !

!Cart methodsFor: 'initialization' stamp: 'pedro 11/1/2022 21:02:08'!
initializeWithCatalog: aCatalog 
	
	catalog := aCatalog.
	books := Bag new.! !


!Cart methodsFor: 'accessing' stamp: 'pedro 10/30/2022 20:42:10'!
list
	^ books.! !

!Cart methodsFor: 'accessing' stamp: 'pedro 11/1/2022 21:31:15'!
listPrice
	^ books inject: 0 into: [:total :book | total + (catalog at: book) ]! !


!Cart methodsFor: 'addBook' stamp: 'pedro 11/1/2022 21:01:47'!
addBook: aBook amount: amountToAdd 
	
	self assertIsValidBook: aBook.
	self assertIsValidAmount: amountToAdd.
	books add: aBook withOccurrences: amountToAdd.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error' stamp: 'pedro 10/27/2022 21:15:34'!
bookNotFoundOnCatalogErrorDescription
	^ 'Cannot add a book that is not in the catalog!!!!'! !

!Cart class methodsFor: 'error' stamp: 'pedro 11/1/2022 21:00:09'!
cannotAdANonIntegerAmountErrorDescription
	^ 'amount to add should be an integer'.! !

!Cart class methodsFor: 'error' stamp: 'pedro 10/27/2022 21:51:11'!
cannotAddLessThanOneBookErrorDescription
	^ 'the amount of books to add should be greater than 0'.! !


!Cart class methodsFor: 'instance creation' stamp: 'pedro 10/27/2022 21:17:25'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart alreadyCheckouted merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'pedro 11/1/2022 21:42:58'!
initializeFor: aCart 
	
	cart := aCart.
	alreadyCheckouted := false.! !

!Cashier methodsFor: 'initialization' stamp: 'pedro 11/2/2022 19:43:01'!
initializeFor: aCart withMerchantProcessor: aMerchantProcessor 

	cart := aCart.
	merchantProcessor := aMerchantProcessor.
	alreadyCheckouted := false.! !


!Cashier methodsFor: 'checkout' stamp: 'pedro 11/2/2022 20:24:12'!
assertCreditCardIsNotExpired: aCreditCard

	(aCreditCard isExpiredOn: GregorianMonthOfYear current) ifTrue: [self error: Cashier cannotCheckoutWithExpiredCreditCardErrorDescription].! !

!Cashier methodsFor: 'checkout' stamp: 'pedro 11/2/2022 19:41:54'!
assertWasNotCheckouted

	alreadyCheckouted ifTrue: [self error: Cashier cannotCheckoutTwiceErrorDescription]! !

!Cashier methodsFor: 'checkout' stamp: 'pedro 11/2/2022 20:22:27'!
checkoutRegisterOn: aSalesBook
	self assertWasNotCheckouted.
	
	aSalesBook add: cart listPrice.
	alreadyCheckouted := true.! !

!Cashier methodsFor: 'checkout' stamp: 'pedro 11/2/2022 20:22:40'!
checkoutWith: aCreditCard registeringOn: aSalesBook 
	self assertCreditCardIsNotExpired: aCreditCard.
	self assertWasNotCheckouted.
	
	merchantProcessor debitAmount: cart listPrice with: aCreditCard.
	aSalesBook add: cart listPrice.
	alreadyCheckouted := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'pedro 11/1/2022 21:43:41'!
cannotCheckoutTwiceErrorDescription
	^ 'cannot checkout twice!!!!'! !

!Cashier class methodsFor: 'error' stamp: 'pedro 11/2/2022 19:06:56'!
cannotCheckoutWithExpiredCreditCardErrorDescription
	^ 'cannot checkout with expired credit card!!!!'! !

!Cashier class methodsFor: 'error' stamp: 'pedro 11/1/2022 21:12:52'!
cannotInitializeWithEmptyCartErrorDescription
	^ 'cart cannot be empty!!'! !


!Cashier class methodsFor: 'instance creation' stamp: 'pedro 11/1/2022 21:14:24'!
for: aCart 
	(aCart isEmpty) ifTrue: [self error: self cannotInitializeWithEmptyCartErrorDescription].
	^self new initializeFor: aCart ! !

!Cashier class methodsFor: 'instance creation' stamp: 'pedro 11/2/2022 19:35:07'!
for: aCart withMerchantProcessor: aMerchantProcessorDouble 
	(aCart isEmpty) ifTrue: [self error: self cannotInitializeWithEmptyCartErrorDescription].
	^self new initializeFor: aCart withMerchantProcessor: aMerchantProcessorDouble ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'pedro 11/1/2022 22:05:16'!
initializeOf: aName number: aNumber andExpirationDate: anExpirationDate 
	
	name := aName.
	number := aNumber.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'expiration' stamp: 'pedro 11/2/2022 20:26:24'!
isExpiredOn: dateToCompare
	
	^ dateToCompare >  expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error' stamp: 'pedro 11/2/2022 17:43:17'!
invalidExpirationMonthErrorDescription
	^ 'expiration month should have 2 digits'.! !

!CreditCard class methodsFor: 'error' stamp: 'pedro 11/2/2022 17:55:12'!
invalidExpirationYearErrorDescription
	^ 'expiration year should have 4 digits!!'! !

!CreditCard class methodsFor: 'error' stamp: 'pedro 11/1/2022 22:04:03'!
invalidNameErrorDescription
	^ 'the name is invalid!!!!'! !

!CreditCard class methodsFor: 'error' stamp: 'pedro 11/1/2022 22:54:38'!
nameWithMoreThan30CharactersErrorDescription
	^ 'name size should be smaller or equal than 30'.! !

!CreditCard class methodsFor: 'error' stamp: 'pedro 11/1/2022 23:00:07'!
numberSizeShouldBe16ErrorDescription
	^ 'card number size should be 16'.! !


!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/2/2022 17:47:44'!
assertExpirationMonthIsValid: expirationMonth

	^ (expirationMonth decimalDigitLength = 2) ifFalse: [self error: self invalidExpirationMonthErrorDescription]! !

!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/2/2022 17:56:14'!
assertExpirationYearIsValid: expirationYear

	^ (expirationYear decimalDigitLength = 4) ifFalse: [self error: self invalidExpirationYearErrorDescription]! !

!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/1/2022 22:46:25'!
assertNameIsNotEmpty: aName

	^ (aName isEmpty or: [aName allSatisfy: [:char | char isSeparator]]) ifTrue: [self error: self invalidNameErrorDescription]! !

!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/1/2022 22:58:30'!
assertNameIsSmallerThan31: aName

	^ (aName size > 30) ifTrue: [self error: self nameWithMoreThan30CharactersErrorDescription]! !

!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/1/2022 22:58:40'!
assertNameIsValid: aName

	self assertNameIsNotEmpty: aName.
	self assertNameIsSmallerThan31: aName! !

!CreditCard class methodsFor: 'signal' stamp: 'pedro 11/2/2022 16:52:26'!
assertNumberIsValid: aNumber

	^ (aNumber size ~= 16) ifTrue: [self error: self numberSizeShouldBe16ErrorDescription]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'pedro 11/2/2022 17:56:14'!
of: aName number: aNumber expirationMonth: expirationMonth expirationYear: expirationYear 
	
	| expirationDate |
	self assertExpirationMonthIsValid: expirationMonth.
	self assertExpirationYearIsValid: expirationYear.
	self assertNameIsValid: aName.
	self assertNumberIsValid: aNumber.
	expirationDate := GregorianMonthOfYear yearNumber: expirationYear monthNumber: expirationMonth.
	
	^self new initializeOf: aName number: aNumber andExpirationDate: expirationDate.! !


!classDefinition: #LoginAuthorizerDouble category: 'TusLibros'!
Object subclass: #LoginAuthorizerDouble
	instanceVariableNames: 'doOnLogin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!LoginAuthorizerDouble methodsFor: 'initialization' stamp: 'pedro 11/3/2022 19:57:50'!
initializeOnLoginDo: aBlockClosure 
	
	doOnLogin := aBlockClosure.! !


!LoginAuthorizerDouble methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:00:47'!
login: id withPassword: password 
	doOnLogin value: id value: password.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginAuthorizerDouble class' category: 'TusLibros'!
LoginAuthorizerDouble class
	instanceVariableNames: ''!

!LoginAuthorizerDouble class methodsFor: 'instance creation' stamp: 'pedro 11/3/2022 19:57:28'!
onLoginDo: aBlockClosure 
	
	^self new initializeOnLoginDo: aBlockClosure ! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'onDebitClosure_CHANGE_ME doOnDebit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'initialization' stamp: 'pedro 11/2/2022 19:34:21'!
initializeOnDebitDo: onDebitClosure 
	doOnDebit := onDebitClosure.! !


!MerchantProcessorDouble methodsFor: 'debit' stamp: 'pedro 11/2/2022 19:44:53'!
debitAmount: amountToDebit with: aCreditCard 
	^ doOnDebit value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDouble class' category: 'TusLibros'!
MerchantProcessorDouble class
	instanceVariableNames: ''!

!MerchantProcessorDouble class methodsFor: 'instance creation' stamp: 'pedro 11/2/2022 19:33:09'!
onDebitDo: onDebitClosure 
	
	^self new initializeOnDebitDo: onDebitClosure ! !


!classDefinition: #TLRestInterface category: 'TusLibros'!
Object subclass: #TLRestInterface
	instanceVariableNames: 'loginAuthorizer carts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:40:04'!
addToCart: cartID book: book amount: anAmount 
	| cart |
	cart := carts at: cartID.
	
	cart addBook: book amount: anAmount.! !

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:42:46'!
authorize: id withPassword: password

	^ loginAuthorizer login: id withPassword: password! !

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:01:19'!
createCartFor: id withPassword: password 

	| cartId newCart |
	self authorize: id withPassword: password.
	
	newCart := Cart withCatalog: catalog.
	cartId := (self lastCartId) + 1.
	
	carts at: cartId put: newCart. 
	
	^ cartId.
	! !

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 20:48:37'!
hasCartWithId: cartID 
	^ carts includesKey: cartID.! !

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:01:19'!
lastCartId

	^ carts keys inject: 0 into: [:max :key |  (max>key) ifTrue: [max] ifFalse: [key]]! !

!TLRestInterface methodsFor: 'as yet unclassified' stamp: 'pedro 11/3/2022 21:42:23'!
listCartWithId: cartID 

	^ (carts at: cartID ifAbsent: [self error: TLRestInterface invalidCartIdErrorDescription.]) list.! !


!TLRestInterface methodsFor: 'initialization' stamp: 'pedro 11/3/2022 20:39:14'!
initializeWithAuthorizer: aLoginAuthorizerDouble 
	
	loginAuthorizer := aLoginAuthorizerDouble.
	carts := Dictionary new.! !

!TLRestInterface methodsFor: 'initialization' stamp: 'pedro 11/3/2022 21:38:20'!
initializeWithAuthorizer: aLoginAuthorizer andCatalog: aCatalog 
	
	loginAuthorizer := aLoginAuthorizer.
	catalog := aCatalog.
	carts := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLRestInterface class' category: 'TusLibros'!
TLRestInterface class
	instanceVariableNames: ''!

!TLRestInterface class methodsFor: 'instance creation' stamp: 'pedro 11/3/2022 19:58:05'!
withAuthorizer: aLoginAuthorizerDouble 
	
	^self new initializeWithAuthorizer: aLoginAuthorizerDouble ! !

!TLRestInterface class methodsFor: 'instance creation' stamp: 'pedro 11/3/2022 21:37:43'!
withAuthorizer: aLoginAuthorizer andCatalog: aCatalog 
	
	^self new initializeWithAuthorizer: aLoginAuthorizer andCatalog: aCatalog ! !


!TLRestInterface class methodsFor: 'error' stamp: 'pedro 11/3/2022 21:17:18'!
invalidCartIdErrorDescription
	^ 'invalid cart id!!!!'.! !
