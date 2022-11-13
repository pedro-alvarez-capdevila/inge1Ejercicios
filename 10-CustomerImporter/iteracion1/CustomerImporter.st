!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'stream' stamp: 'pedro 11/13/2022 11:00:04'!
validReadStream

	^ ReadStream on: self validStream! !

!ImportTest methodsFor: 'stream' stamp: 'pedro 11/13/2022 10:22:27'!
validStream

	^ 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:01:39'!
test01ImportCustomerImports2Customers

	
	
	self importCustomerWithValidReadStream.
	self assert2CustomersInCurrentSession.
	! !

!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:03:55'!
test02PepeSanchesIsImportesCorrectly

	| customer |
	
	self importCustomerWithValidReadStream.
	
	customer := self pepeSanches.
	
	self assertCustomerWasImportedCorrectly: customer firstName: 'Pepe' lastName: 'Sanchez' identificationType: 'D' identificationNumber: '22333444' numberOfAddreses: 2.
! !

!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:05:20'!
test03SanMartinAddressOfPepeSanchesIsImportedCorrectly

	| address |
	
	self importCustomerWithValidReadStream.
	
	address := self addressOfCustomer: self pepeSanches at: 'San Martin'.
	
	self assertAddressWasImportedCorrectly: address streetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.! !

!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:05:14'!
test04MaipuAddressOfPepeSanchesIsImportedCorrectly

	| address |
	
	self importCustomerWithValidReadStream.
	
	address := self addressOfCustomer: self pepeSanches at: 'Maipu'.
	
	self assertAddressWasImportedCorrectly: address streetName: 'Maipu' streetNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.
! !

!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:08:24'!
test05JuanPerezIsImportedCorrectly

	self importCustomerWithValidReadStream.
	
	self assertCustomerWasImportedCorrectly: self juanPerez firstName: 'Juan' lastName: 'Perez' identificationType: 'C' identificationNumber: '23-25666777-9' numberOfAddreses: 1.! !

!ImportTest methodsFor: 'test' stamp: 'pedro 11/13/2022 11:08:53'!
test06AlemAddressOfJuanPerezIsImportedCorrectly

	| address |
	self importCustomerWithValidReadStream.
	
	address := self addressOfCustomer: self juanPerez at: 'Alem'.
	
	self assertAddressWasImportedCorrectly: address streetName: 'Alem' streetNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.! !


!ImportTest methodsFor: 'assertions' stamp: 'pedro 11/13/2022 10:54:58'!
assert2CustomersInCurrentSession

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'pedro 11/13/2022 10:52:38'!
assertAddressWasImportedCorrectly: address streetName: streetName streetNumber: streetNumber town: town zipCode: zipCode province: province     

	self assert: streetName equals: address streetName.
	self assert: streetNumber equals: address streetNumber.
	self assert: town equals: address town.
	self assert: zipCode equals: address zipCode.
	self assert: province equals: address province! !

!ImportTest methodsFor: 'assertions' stamp: 'pedro 11/13/2022 10:43:41'!
assertCustomerWasImportedCorrectly: customer firstName: firstName lastName: lastName identificationType: idenfiticationType identificationNumber: identificationNumber numberOfAddreses: numberOfAddreses     

	self assert: firstName equals: customer firstName.
	self assert: lastName equals: customer lastName.
	self assert: idenfiticationType equals: customer identificationType .
	self assert: identificationNumber equals: customer identificationNumber.
	self assert: numberOfAddreses equals: customer numberOfAddreses! !


!ImportTest methodsFor: 'import' stamp: 'pedro 11/13/2022 11:01:02'!
importCustomerWithValidReadStream

	^ (CustomerImporter aSession: session anAReadStream: self validReadStream) value! !


!ImportTest methodsFor: 'address' stamp: 'pedro 11/13/2022 10:50:17'!
addressOfCustomer: customer at: anAddress

	^ customer addressAt: anAddress ifNone: [ self fail ].! !


!ImportTest methodsFor: 'setup' stamp: 'pedro 11/13/2022 11:00:41'!
setUp

	
	session := DataBaseSession for: (Array with: Address with: Customer).! !


!ImportTest methodsFor: 'customer' stamp: 'pedro 11/13/2022 10:58:34'!
customerOfSessionWithIdentificationType: identificationType andIdentificationNumber: identificationNumber

	^ (session 
		select: [:aCustomer | aCustomer identificationType = identificationType and: [aCustomer identificationNumber = identificationNumber]]
		ofType: Customer) anyOne! !

!ImportTest methodsFor: 'customer' stamp: 'pedro 11/13/2022 11:07:00'!
juanPerez

	^ self customerOfSessionWithIdentificationType: 'C' andIdentificationNumber: '23-25666777-9'! !

!ImportTest methodsFor: 'customer' stamp: 'pedro 11/13/2022 11:03:55'!
pepeSanches

	^ self customerOfSessionWithIdentificationType: 'D' andIdentificationNumber: '22333444'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'pedro 11/13/2022 10:05:11'!
isAt: aStreetName 
	^ aStreetName = streetName.! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'pedro 11/13/2022 10:01:35'!
numberOfAddreses
	^ addresses size.! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'as yet unclassified' stamp: 'pedro 11/13/2022 10:04:58'!
addressAt: aStreetName ifNone: aNoneBlock 
	
	^ addresses detect: [:anAddress | anAddress isAt: aStreetName] ifNone: aNoneBlock.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'pedro 11/13/2022 10:26:58'!
initializeASession: aSession anAReadStream: anAReadStream
	session := aSession.
	readStream := anAReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'pedro 11/13/2022 10:26:58'!
value

	| newCustomer line |
	session beginTransaction.
	line := readStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := readStream nextLine. ].
	session commit.
	session close.
	readStream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'pedro 11/13/2022 10:26:58'!
aSession: aSession anAReadStream: anAReadStream
	^self new initializeASession: aSession anAReadStream: anAReadStream! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
