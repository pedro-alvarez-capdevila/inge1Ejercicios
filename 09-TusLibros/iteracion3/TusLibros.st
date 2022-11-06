!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'book' stamp: 'pedro 11/6/2022 14:12:58'!
bookSellByTheStoreWithPrice

	^ (self validBook1)->100! !

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:45:57'!
invalidBook

	^ 'some-invalid-code'! !

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:44:13'!
validBook1

	^ 'valid-ISBN'! !

!CartTest methodsFor: 'book' stamp: 'pedro 10/30/2022 20:47:40'!
validBook2

	^ 'book2'! !


!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:47:00'!
cartWithCatalogWithValidBook1

	^ Cart withCatalog: self catalogWithValidBook1! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:49:44'!
cartWithCatalogWithValidBook1And2

	^ Cart withCatalog: (self catalogWithValidBook1And2)! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:43:08'!
newCart

	^ Cart new! !


!CartTest methodsFor: 'catalog' stamp: 'pedro 11/6/2022 14:12:58'!
catalogWithValidBook1

	^ Dictionary with: self bookSellByTheStoreWithPrice.! !

!CartTest methodsFor: 'catalog' stamp: 'pedro 11/6/2022 14:12:58'!
catalogWithValidBook1And2

	^ Dictionary with: self bookSellByTheStoreWithPrice with: (self validBook2)->100.! !


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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'card' stamp: 'pedro 11/6/2022 14:27:59'!
validCreditCardNumber

	^ '1111222233334444'! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 17:46:17'!
validExpirationMonth

	^ 10! !

!CashierTest methodsFor: 'card' stamp: 'pedro 11/2/2022 17:46:53'!
validExpirationYear

	^ 2020! !


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

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:30:43'!
test04CardNameShouldNotBeEmpty

	| emptyName validCardNumber validExpirationMonth validExpirationYear |
	
	emptyName := '    '.
	validCardNumber := testObjectsFactory validCreditCardNumber.
	validExpirationMonth := self validExpirationMonth.
	validExpirationYear := self validExpirationYear.

	self
		should: [CreditCard of: emptyName number: validCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard invalidNameErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:30:54'!
test05CardSizeNameShouldBeSmallerThan31Characters

	| nameOf31Characters validCardNumber validExpirationMonth validExpirationYear |
	
	nameOf31Characters := '0123456789012345678901234567890'.
	validCardNumber := testObjectsFactory validCreditCardNumber.
	validExpirationYear := self validExpirationYear.
	validExpirationMonth := self validExpirationMonth. 

	self
		should: [CreditCard of: nameOf31Characters number: validCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard nameWithMoreThan30CharactersErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:29:25'!
test06CardNumberSizeShouldBeEqualsTo16

	| validName invalidCardNumber validExpirationMonth validExpirationYear |
	
	validName := testObjectsFactory creditCardName.
	invalidCardNumber := '11'.
	validExpirationYear := self validExpirationYear.
	validExpirationMonth := self validExpirationMonth.

	self
		should: [CreditCard of: validName number: invalidCardNumber expirationMonth: validExpirationMonth expirationYear: validExpirationYear]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard numberSizeShouldBe16ErrorDescription]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:29:54'!
test07CardExpirationMonthDateShouldHaveTwoDigits

	| validCardNumber expirationMonth expirationYear |
	
	validCardNumber := testObjectsFactory validCreditCardNumber.
	expirationMonth := 100.
	expirationYear := self validExpirationYear.

	self
		should: [CreditCard of: testObjectsFactory creditCardName number: validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CreditCard invalidExpirationMonthErrorDescription
			]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:30:07'!
test08CardExpirationYearDateShouldHaveFourDigits

	| validCardNumber expirationMonth expirationYear |
	
	validCardNumber := testObjectsFactory validCreditCardNumber.
	expirationMonth := self validExpirationMonth .
	expirationYear := 100.

	self
		should: [CreditCard of: testObjectsFactory creditCardName number: validCardNumber expirationMonth: expirationMonth expirationYear: expirationYear ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CreditCard invalidExpirationYearErrorDescription
			]

	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:32:34'!
test09CreditCardKnowsIfIsExpired

	
	| expiredCreditCard  expirationYear expirationMonth yearAfterTheExpiration monthAfterTheExpiration |
	
	expirationYear := 2020.
	expirationMonth := 10.
	monthAfterTheExpiration := 10.
	yearAfterTheExpiration := 2021.
		
	expiredCreditCard := CreditCard of: testObjectsFactory creditCardName number: self validCreditCardNumber expirationMonth: expirationMonth expirationYear: expirationYear.

	self assert: (expiredCreditCard isExpiredOn: (GregorianMonthOfYear yearNumber: yearAfterTheExpiration monthNumber: monthAfterTheExpiration) ).
	! !

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:32:39'!
test10CannotCheckoutWithExpiredCreditCard

	| cashier salesBook expirationYear expirationMonth expiredCreditCard merchantWasNotCalled  |
	
	salesBook := self createSalesBook.
	merchantWasNotCalled := true.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: [merchantWasNotCalled := false]).
	
	expirationYear := Date today yearNumber - 2.
	expirationMonth := Date today month monthIndex.
		
	expiredCreditCard := CreditCard of: testObjectsFactory creditCardName number: self validCreditCardNumber expirationMonth: expirationMonth expirationYear: expirationYear.
	
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

!CashierTest methodsFor: 'test' stamp: 'pedro 11/6/2022 14:34:51'!
test13CanCheckoutWithCardThatHasBalance

	| cashier salesBook creditCard |
	
	salesBook := self createSalesBook.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: []).
	
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	cashier checkoutWith: creditCard registeringOn: salesBook.
	
	self assert: salesBook includes: self cartWithValidBook listPrice.
	
	
	

	! !


!CashierTest methodsFor: 'assertions' stamp: 'pedro 11/6/2022 14:34:46'!
assertMerchantProcessorRaisesError: merchantProcessorError

	| cashier salesBook creditCard|
	
	salesBook := self createSalesBook.
	cashier := Cashier for: self cartWithValidBook withMerchantProcessor: (MerchantProcessorDouble onDebitDo: [self error: merchantProcessorError]).
	
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	self 
		should: [cashier checkoutWith: creditCard registeringOn: salesBook.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: merchantProcessorError.
			self assert: salesBook isEmpty.
			]
	
	
	

	! !


!CashierTest methodsFor: 'setup' stamp: 'pedro 11/6/2022 14:21:56'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CashierTest methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:25:59'!
cartWithValidBook
	|cart|
	cart := Cart withCatalog: (Dictionary with: testObjectsFactory bookSellByTheStore->(testObjectsFactory priceOfbookSellByTheStore)).
	cart addBook: (testObjectsFactory bookSellByTheStore) amount: 2.
	^ cart ! !


!classDefinition: #TusLibrosFacadeTest category: 'TusLibros'!
TestCase subclass: #TusLibrosFacadeTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacadeTest methodsFor: 'authentication' stamp: 'pedro 11/5/2022 16:01:51'!
loginAuthorizerForAuthorizedUser

	| isAuthorized |
	
	isAuthorized := false.
	^ LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
! !

!TusLibrosFacadeTest methodsFor: 'authentication' stamp: 'pedro 11/5/2022 16:02:51'!
loginAuthorizerForUserWithInvalidCredentials

	^ LoginAuthorizerDouble onLoginDo: [:id :password | self error: self invalidCredentialsErrorDescription]! !

!TusLibrosFacadeTest methodsFor: 'authentication' stamp: 'pedro 11/5/2022 15:49:08'!
userId

	^ '10'! !

!TusLibrosFacadeTest methodsFor: 'authentication' stamp: 'pedro 11/5/2022 15:49:29'!
userPassword

	^ 'password'! !


!TusLibrosFacadeTest methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:46:14'!
catalogWithBookSellByTheStore

	^ Dictionary with: (testObjectsFactory bookSellByTheStoreWithPrice)! !

!TusLibrosFacadeTest methodsFor: 'cart' stamp: 'pedro 11/6/2022 18:30:32'!
createNewCartWith: tlFacade

	^ tlFacade createCartFor: self userId withPassword: self userPassword! !


!TusLibrosFacadeTest methodsFor: 'error' stamp: 'pedro 11/3/2022 19:58:57'!
invalidCredentialsErrorDescription

	^ 'invalid credentials'! !


!TusLibrosFacadeTest methodsFor: 'clock' stamp: 'pedro 11/6/2022 18:25:27'!
advanceClock25Minutes: clock

	^ clock advanceMinutes: (25*minute)! !

!TusLibrosFacadeTest methodsFor: 'clock' stamp: 'pedro 11/6/2022 18:31:26'!
advanceClock30Minutes: clock

	^ clock advanceMinutes: (30*minute)! !

!TusLibrosFacadeTest methodsFor: 'clock' stamp: 'pedro 11/6/2022 17:49:06'!
createClock

	^ Clock new! !


!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:40:57'!
test01CannotCreateCartWithInvalidCredentials

	| tlFacade loginAuthorizer |
	
	loginAuthorizer := self loginAuthorizerForUserWithInvalidCredentials.
	tlFacade := self tlFacadeWithAuthorizer: loginAuthorizer.
	
	self assertCannotOperateWithInvalidCredentials: [self createNewCartWith: tlFacade].! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test02CanCreateCartWithValidCredentials

	| tlFacade loginAuthorizer isAuthorized cartID |
	
	isAuthorized := false.
	loginAuthorizer := LoginAuthorizerDouble onLoginDo: [:id :password | isAuthorized := true].
	tlFacade := TLFacade withAuthorizer: loginAuthorizer catalog: self catalogWithBookSellByTheStore andClock: self createClock.
	cartID := self createNewCartWith: tlFacade.
	
	self assert: isAuthorized.
	self assertCartWasCreatedWithId: cartID withRestInterface: tlFacade.! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test03CanCreateMultipleCarts

	| tlFacade cartID1 cartID2 |
	
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID1 := self createNewCartWith: tlFacade.
	cartID2 := self createNewCartWith: tlFacade.
	
	self assertCartWasCreatedWithId: cartID1 withRestInterface: tlFacade.
	self assertCartWasCreatedWithId: cartID2 withRestInterface: tlFacade.
	self assert: (cartID1 ~= cartID2).! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test04CannotListCartWithInvalidId

	| tlFacade cartID1 |
	
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID1 := self createNewCartWith: tlFacade.
	
	self assertInvalidCartIdOn: [tlFacade listCartWithId: (cartID1 + 10)].
	! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test05ListCartReturnTheBooksOfTheCart

	| tlFacade cartID listCart book booksAmount |
	
	book := testObjectsFactory bookSellByTheStore.
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID := self createNewCartWith: tlFacade.
	booksAmount := 5.
	tlFacade addToCart: cartID book: book amount: booksAmount.

	listCart := tlFacade listCartWithId: cartID.
	
	self assert: listCart size equals: booksAmount.
	self assert: (listCart occurrencesOf: book) equals: booksAmount.
	! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test06CannotAddABookToACartWithInvalidId

	| tlFacade cartID |
	
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID := self createNewCartWith: tlFacade.
	
	self assertInvalidCartIdOn: [tlFacade addToCart: (cartID + 10) book: testObjectsFactory bookSellByTheStore amount: 10 ].! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test07CannotCheckoutACartWithInvalidId

	| tlFacade cartID |
	
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID := self createNewCartWith: tlFacade.

	self assertInvalidCartIdOn: [ self checkoutWithDefaultCreditCardWithTLFacade: tlFacade andCartId: (cartID+10).].
	! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:40:57'!
test08CannotListPurchasesWithInvalidCredentials

	| tlFacade loginAuthorizer |
	
	loginAuthorizer := self loginAuthorizerForUserWithInvalidCredentials.
	tlFacade := self tlFacadeWithAuthorizer:  loginAuthorizer.
	
	self assertCannotOperateWithInvalidCredentials: [tlFacade listPurchasesOf: self userId withPassword: self userPassword].! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:30:32'!
test09CheckoutACartRegistersThePurchaseOfTheUser

	| tlFacade cartID listPurchases |
	
	tlFacade := self tlFacadeForAuthorizedUserAndCatalogWithValidBook.
	cartID := self createNewCartWith: tlFacade.
	tlFacade addToCart: cartID book: (testObjectsFactory bookSellByTheStore) amount: 3.

	self checkoutWithDefaultCreditCardWithTLFacade: tlFacade andCartId: cartID.
	listPurchases := (tlFacade listPurchasesOf: self userId withPassword: self userPassword).
	
	self assert: listPurchases includes: testObjectsFactory priceOfbookSellByTheStore*3.
	self assert: listPurchases size equals: 1.
	! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:41:33'!
test10CannotAddToCartWhenIsExpired

	| tlFacade cartID book booksAmount clock|
	
	clock := self createClock.
	book := testObjectsFactory bookSellByTheStore.
	tlFacade := self tlFacadeWithClock: clock.
	cartID := self createNewCartWith: tlFacade.
	booksAmount := 5.
	
	self advanceClock30Minutes: clock.
	
	self assertCannotOperateWithCartWhenIsExpired: [tlFacade addToCart: cartID book: book amount: booksAmount.].
! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:41:33'!
test11CannotListCartWhenIsExpired

	| tlFacade cartID clock|
	
	clock := self createClock.
	tlFacade := self tlFacadeWithClock: clock.
	cartID := self createNewCartWith: tlFacade.
	
	self advanceClock30Minutes: clock.
	
	self assertCannotOperateWithCartWhenIsExpired: [tlFacade listCartWithId: cartID].! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:41:33'!
test12CannotCheckoutACartWhenIsExpired

	| tlFacade cartID clock|
	
	clock := self createClock.
	tlFacade := self tlFacadeWithClock: clock.
	cartID := self createNewCartWith: tlFacade.
	
	self advanceClock30Minutes: clock.
	
	self assertCannotOperateWithCartWhenIsExpired: [self checkoutWithDefaultCreditCardWithTLFacade: tlFacade andCartId: cartID]
! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:41:33'!
test13CanDoOperationsWithCartWithin30MinutesAfterAddingABook

	| tlFacade cartID book booksAmount clock listCart |
	
	clock := self createClock.
	book := testObjectsFactory bookSellByTheStore.
	tlFacade := self tlFacadeWithClock: clock.
	cartID := self createNewCartWith: tlFacade.
	booksAmount := 5.
	
	self advanceClock25Minutes: clock.
	tlFacade addToCart: cartID book: book amount: booksAmount.
	self advanceClock25Minutes: clock.
	listCart := tlFacade listCartWithId: cartID.

	self assert: (listCart occurrencesOf: book) equals: booksAmount.! !

!TusLibrosFacadeTest methodsFor: 'test' stamp: 'pedro 11/6/2022 18:41:33'!
test14CanDoOperationsWithCartWithin30MinutesAfterListingACart

	| tlFacade cartID book booksAmount clock listCart |
	
	clock := self createClock.
	book := testObjectsFactory bookSellByTheStore.
	tlFacade := self tlFacadeWithClock: clock.
	cartID := self createNewCartWith: tlFacade.
	booksAmount := 5.
	
	self advanceClock25Minutes: clock.
	tlFacade listCartWithId: cartID.
	self advanceClock25Minutes: clock.
	tlFacade addToCart: cartID book: book amount: booksAmount.
	
	listCart := tlFacade listCartWithId: cartID.

	self assert: (listCart occurrencesOf: book) equals: booksAmount.! !


!TusLibrosFacadeTest methodsFor: 'creditCard' stamp: 'pedro 11/5/2022 19:08:41'!
creditCardName

	^ 'pedro'! !

!TusLibrosFacadeTest methodsFor: 'creditCard' stamp: 'pedro 11/5/2022 17:04:59'!
monthNotExpired

	^ Date today month monthIndex! !

!TusLibrosFacadeTest methodsFor: 'creditCard' stamp: 'pedro 11/5/2022 19:08:41'!
notExpiredCreditCard

	^ CreditCard of: self creditCardName number: self validCreditCardNumber expirationMonth: self monthNotExpired expirationYear: self yearNotExpired! !

!TusLibrosFacadeTest methodsFor: 'creditCard' stamp: 'pedro 11/5/2022 17:12:11'!
validCreditCardNumber

	^ '1234123412341234'! !

!TusLibrosFacadeTest methodsFor: 'creditCard' stamp: 'pedro 11/5/2022 17:04:50'!
yearNotExpired

	^ Date today yearNumber + 10! !


!TusLibrosFacadeTest methodsFor: 'assertions' stamp: 'pedro 11/6/2022 17:57:33'!
assertCannotOperateWithCartWhenIsExpired: aClosure

	self 
		should: aClosure
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: TLFacade cartIsExpiredErrorDescription]
	! !

!TusLibrosFacadeTest methodsFor: 'assertions' stamp: 'pedro 11/6/2022 18:28:43'!
assertCannotOperateWithInvalidCredentials: aClosure

	self
		should: aClosure
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: self invalidCredentialsErrorDescription.
			]! !

!TusLibrosFacadeTest methodsFor: 'assertions' stamp: 'pedro 11/6/2022 15:27:19'!
assertCartWasCreatedWithId: cartID withRestInterface: tlFacade

	^ self assert: (tlFacade listCartWithId: cartID) equals: Bag new! !

!TusLibrosFacadeTest methodsFor: 'assertions' stamp: 'pedro 11/6/2022 17:58:39'!
assertInvalidCartIdOn: aClosure
	self 
		should: aClosure
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: TLFacade invalidCartIdErrorDescription]
	! !


!TusLibrosFacadeTest methodsFor: 'setup' stamp: 'pedro 11/6/2022 14:15:43'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!TusLibrosFacadeTest methodsFor: 'tlFacade' stamp: 'pedro 11/6/2022 17:55:15'!
checkoutWithDefaultCreditCardWithTLFacade: tlFacade andCartId: cartID

	^ tlFacade 
		checkoutCartWithId: (cartID)
		ofUser: self userId 
		cardName: self creditCardName 
		number: self validCreditCardNumber 
		expirationMonth: self monthNotExpired 
		expirationYear: self yearNotExpired
		andMerchantProcessor: (MerchantProcessorDouble onDebitDo: [])! !

!TusLibrosFacadeTest methodsFor: 'tlFacade' stamp: 'pedro 11/6/2022 17:49:07'!
tlFacadeForAuthorizedUserAndCatalogWithValidBook

	^ TLFacade withAuthorizer: self loginAuthorizerForAuthorizedUser catalog: self catalogWithBookSellByTheStore andClock: self createClock.! !

!TusLibrosFacadeTest methodsFor: 'tlFacade' stamp: 'pedro 11/6/2022 18:40:57'!
tlFacadeWithAuthorizer: anAuthorizer

	^ TLFacade withAuthorizer: anAuthorizer catalog: self catalogWithBookSellByTheStore andClock: self createClock .! !

!TusLibrosFacadeTest methodsFor: 'tlFacade' stamp: 'pedro 11/6/2022 18:41:33'!
tlFacadeWithClock: aClock

	^ TLFacade withAuthorizer: self loginAuthorizerForAuthorizedUser catalog: self catalogWithBookSellByTheStore andClock: aClock.! !


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


!classDefinition: #CartRecord category: 'TusLibros'!
Object subclass: #CartRecord
	instanceVariableNames: 'id cart lastUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartRecord methodsFor: 'initialization' stamp: 'pedro 11/6/2022 19:19:06'!
initializeWithId: aCartID card: aCart andLastUsed: aCartSession 
	
	id := aCartID.
	cart := aCart.
	lastUsed := aCartSession.! !


!CartRecord methodsFor: 'as yet unclassified' stamp: 'pedro 11/6/2022 19:08:29'!
cart
	
	^cart! !

!CartRecord methodsFor: 'as yet unclassified' stamp: 'pedro 11/6/2022 19:15:48'!
id
	^ id.! !

!CartRecord methodsFor: 'as yet unclassified' stamp: 'pedro 11/6/2022 19:19:39'!
lastUsed
	^ lastUsed.! !

!CartRecord methodsFor: 'as yet unclassified' stamp: 'pedro 11/6/2022 19:19:26'!
updateLastUsedAt: aCartSession 
	lastUsed := aCartSession.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartRecord class' category: 'TusLibros'!
CartRecord class
	instanceVariableNames: ''!

!CartRecord class methodsFor: 'instance creation' stamp: 'pedro 11/6/2022 18:54:40'!
withId: aCartID card: aCart andLastUsed: aCartSession 
	
	^self new initializeWithId: aCartID card: aCart andLastUsed: aCartSession ! !


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


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'minutesToAdd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initilization' stamp: 'pedro 11/6/2022 17:37:51'!
initialize

	minutesToAdd := 0*minute.! !


!Clock methodsFor: 'advanceMinutes' stamp: 'pedro 11/6/2022 18:17:43'!
advanceMinutes: anAmountOfMinutes 
	minutesToAdd := minutesToAdd + anAmountOfMinutes.! !


!Clock methodsFor: 'now' stamp: 'pedro 11/6/2022 17:36:33'!
now
	^ GregorianDateTime now next: minutesToAdd.! !


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
	instanceVariableNames: 'doOnDebit'
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


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:13:45'!
bookSellByTheStore

	^ 'valid book'! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:13:52'!
bookSellByTheStoreWithPrice

	^ self bookSellByTheStore->self priceOfbookSellByTheStore! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:13:59'!
catalogWithBookSellByTheStore

	^ Dictionary with: (self bookSellByTheStoreWithPrice)! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'pedro 11/6/2022 14:13:38'!
priceOfbookSellByTheStore

	^ 100! !


!StoreTestObjectsFactory methodsFor: 'creditCard' stamp: 'pedro 11/6/2022 14:09:37'!
creditCardName

	^ 'pedro'! !

!StoreTestObjectsFactory methodsFor: 'creditCard' stamp: 'pedro 11/6/2022 14:09:10'!
monthNotExpired

	^ Date today month monthIndex! !

!StoreTestObjectsFactory methodsFor: 'creditCard' stamp: 'pedro 11/6/2022 14:10:16'!
notExpiredCreditCard

	^ CreditCard of: self creditCardName number: self validCreditCardNumber expirationMonth: self monthNotExpired expirationYear: self yearNotExpired! !

!StoreTestObjectsFactory methodsFor: 'creditCard' stamp: 'pedro 11/6/2022 14:10:26'!
validCreditCardNumber

	^ '1234123412341234'! !

!StoreTestObjectsFactory methodsFor: 'creditCard' stamp: 'pedro 11/6/2022 14:10:36'!
yearNotExpired

	^ Date today yearNumber + 10! !


!classDefinition: #TLFacade category: 'TusLibros'!
Object subclass: #TLFacade
	instanceVariableNames: 'loginAuthorizer carts catalog purchases cartSessions clock cartRecords lastCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TLFacade methodsFor: 'checkout' stamp: 'pedro 11/6/2022 17:56:07'!
checkoutCartWithId: cartID ofUser: userID cardName: cardName number: cardNumber expirationMonth: cardExpirationMonth expirationYear: cardExpirationYear andMerchantProcessor: merchantProcessor 

	| cart card cashier userPurchases |
	cart := self getCartAndThrowsAnErrorIfAbsent: cartID.
	self assertCartIsNotExpired: cartID.
	
	card := CreditCard of: cardName number: cardNumber  expirationMonth: cardExpirationMonth expirationYear: cardExpirationYear.
	cashier := Cashier for: cart withMerchantProcessor: merchantProcessor.
	userPurchases :=  self getPurchasesOfUser: userID.
	cashier checkoutWith: card registeringOn: userPurchases.! !


!TLFacade methodsFor: 'assertions' stamp: 'pedro 11/6/2022 19:19:39'!
assertCartIsNotExpired: cartID
	| cartSession cartRecord |
	
	cartRecord := self findCartRecord: cartID.
	cartSession := cartRecord lastUsed.
	(((cartSession distanceTo: clock now) convertTo: minute) >= (30*minute)) ifTrue: [self error: TLFacade cartIsExpiredErrorDescription].! !


!TLFacade methodsFor: 'checkout - private' stamp: 'pedro 11/6/2022 19:10:02'!
findCartRecord: cartID

	^ cartRecords 
		detect: [:aCartRecord | aCartRecord id = cartID]  
		ifNone: [self error: TLFacade invalidCartIdErrorDescription]! !

!TLFacade methodsFor: 'checkout - private' stamp: 'pedro 11/6/2022 19:10:40'!
getCartAndThrowsAnErrorIfAbsent: cartID

	| cartRecord |
	cartRecord := self findCartRecord: cartID.
	^ cartRecord cart.! !

!TLFacade methodsFor: 'checkout - private' stamp: 'pedro 11/6/2022 12:35:00'!
getPurchasesOfUser: userID

	^ purchases at: userID ifAbsent: [purchases add: userID->OrderedCollection new. purchases at: userID]! !


!TLFacade methodsFor: 'listPurchases' stamp: 'pedro 11/6/2022 12:34:29'!
listPurchasesOf: userId withPassword: userPassword 

	self authorize: userId withPassword: userPassword.
	^ purchases at: userId.! !


!TLFacade methodsFor: 'listCart' stamp: 'pedro 11/6/2022 18:22:36'!
listCartWithId: cartID 

	| cart |
	cart := (self getCartAndThrowsAnErrorIfAbsent: cartID).
	self assertCartIsNotExpired: cartID.
	self updateCartSession: cartID.
	^ cart list.! !


!TLFacade methodsFor: 'addToCart' stamp: 'pedro 11/6/2022 18:20:31'!
addToCart: cartID book: book amount: anAmount 
	| cart |
	
	cart := self getCartAndThrowsAnErrorIfAbsent: cartID.
	self assertCartIsNotExpired: cartID.
	
	cart addBook: book amount: anAmount.
	self updateCartSession: cartID.! !

!TLFacade methodsFor: 'addToCart' stamp: 'pedro 11/6/2022 19:19:26'!
updateCartSession: cartID

	| cartRecord |
	cartRecord := self findCartRecord: cartID.
	^ cartRecord updateLastUsedAt: clock now! !


!TLFacade methodsFor: 'authorization' stamp: 'pedro 11/3/2022 20:42:46'!
authorize: id withPassword: password

	^ loginAuthorizer login: id withPassword: password! !


!TLFacade methodsFor: 'createCart' stamp: 'pedro 11/6/2022 19:02:05'!
createCartFor: id withPassword: password 

	| cartId newCart cartRecord |
	self authorize: id withPassword: password.
	
	newCart := Cart withCatalog: catalog.
	cartId := (self lastCartId) + 1.
	
	cartRecord := CartRecord withId: cartId card: newCart andLastUsed: clock now.
	cartRecords add: cartRecord.
	lastCartID := lastCartID + 1.
	
	^ cartId.
	! !


!TLFacade methodsFor: 'createCart - private' stamp: 'pedro 11/6/2022 19:02:05'!
lastCartId

	^ lastCartID.! !


!TLFacade methodsFor: 'initialization' stamp: 'pedro 11/6/2022 19:02:05'!
initializeWithAuthorizer: aLoginAuthorizer catalog: aCatalog andClock: aClock 
	
	clock := aClock.
	loginAuthorizer := aLoginAuthorizer.
	catalog := aCatalog.
	purchases := Dictionary new.
	cartRecords := OrderedCollection new.
	lastCartID := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLFacade class' category: 'TusLibros'!
TLFacade class
	instanceVariableNames: ''!

!TLFacade class methodsFor: 'instance creation' stamp: 'pedro 11/6/2022 17:27:59'!
withAuthorizer: aLoginAuthorizerDouble catalog: aDictionary andClock: aClock 
	
	^self new initializeWithAuthorizer: aLoginAuthorizerDouble catalog: aDictionary andClock: aClock ! !


!TLFacade class methodsFor: 'error' stamp: 'pedro 11/6/2022 17:41:40'!
cartIsExpiredErrorDescription
	^ 'cart is expired!!!!'.! !

!TLFacade class methodsFor: 'error' stamp: 'pedro 11/3/2022 21:17:18'!
invalidCartIdErrorDescription
	^ 'invalid cart id!!!!'.! !
