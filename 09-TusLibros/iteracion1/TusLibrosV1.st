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


!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:47:00'!
cartWithCatalogWithValidBook1

	^ Cart withCatalog: self catalogWithValidBook1! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:49:44'!
cartWithCatalogWithValidBook1And2

	^ Cart withCatalog: (self catalogWithValidBook1And2)! !

!CartTest methodsFor: 'cart' stamp: 'pedro 10/30/2022 20:43:08'!
newCart

	^ Cart new! !


!CartTest methodsFor: 'catalog' stamp: 'pedro 10/30/2022 20:45:17'!
catalogWithValidBook1

	^ OrderedCollection with: self validBook1.! !

!CartTest methodsFor: 'catalog' stamp: 'pedro 10/30/2022 20:49:44'!
catalogWithValidBook1And2

	^ OrderedCollection with: self validBook1 with: self validBook2! !


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

!CartTest methodsFor: 'test' stamp: 'pedro 10/30/2022 20:48:41'!
test07ListOfProductsOfCartHasTheBooksOfTheCart

	| cart book1 book2 |
	
	book1 := self validBook1.
	book2 := self validBook2.
	cart := self cartWithCatalogWithValidBook1And2.
	cart addBook: book1 amount: 2. 
	cart addBook: book2 amount: 1.
	
	self assert: cart list equals: (OrderedCollection with: book1 with: book1 with: book2).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'pedro 10/27/2022 21:50:31'!
addBook: aBook amount: amountToAdd 
	
	self assertIsValidBook: aBook.
	(amountToAdd < 1) ifTrue: [self error: Cart cannotAddLessThanOneBookErrorDescription].
	books add: aBook withOccurrences: amountToAdd.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'pedro 10/27/2022 21:37:31'!
assertIsValidBook: aBook

	^ (catalog includes: aBook) ifFalse: [self error: Cart bookNotFoundOnCatalogErrorDescription]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'pedro 10/27/2022 21:33:14'!
hasBook: aBook amount: amountOfBooks 
	^ (books occurrencesOf: aBook) = amountOfBooks.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'pedro 10/27/2022 21:14:49'!
initialize

	books := OrderedCollection new.
	catalog := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'pedro 10/27/2022 20:54:19'!
isEmpty
	^ books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'pedro 10/27/2022 21:17:58'!
initializeWithCatalog: aCatalog 
	
	catalog := aCatalog.
	books := OrderedCollection new.! !


!Cart methodsFor: 'accessing' stamp: 'pedro 10/30/2022 20:42:10'!
list
	^ books.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error' stamp: 'pedro 10/27/2022 21:15:34'!
bookNotFoundOnCatalogErrorDescription
	^ 'Cannot add a book that is not in the catalog!!!!'! !

!Cart class methodsFor: 'error' stamp: 'pedro 10/27/2022 21:51:11'!
cannotAddLessThanOneBookErrorDescription
	^ 'the amount of books to add should be greater than 0'.! !


!Cart class methodsFor: 'instance creation' stamp: 'pedro 10/27/2022 21:17:25'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !
