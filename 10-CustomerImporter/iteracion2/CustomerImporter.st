!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 18:57:54'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers: 2.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:11:41'!
test02cannotImportAnInvalidRecordType

	self assertCannotImportInvalidRecord: self dataWithInvalidRecordType 
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:11:41'!
test03cannotImportAnInvalidCustomerRecordType

	self assertCannotImportInvalidRecord: self dataWithInvalidCustomerType
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:11:41'!
test04cannotImportAnInvalidAddressRecordType

	self assertCannotImportInvalidRecord: self dataWithInvalidAddressType
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:09:30'!
test05cannotImportAnEmptyRecord

	self 
		should: [ CustomerImporter valueFrom: self dataWithEmptyRecord into: session. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: CustomerImporter emptyRecordErrorDescription equals: anError messageText.
			self assertImportedRightNumberOfCustomers: 1.
			self assertPepeSanchezWasImportedCorrecty
		].
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:11:41'!
test06cannotImportACustomerMissingInformation

	self assertCannotImportInvalidRecord: self dataWithInvalidCustomer.
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:20:42'!
test07cannotImportAnAddressMissingInformation

	self assertCannotImportInvalidRecord: self dataWithInvalidAddress.
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:40:04'!
test08cannotImportACustomerHavingEmptyFields

	self assertCannotImportInvalidRecord: self dataWithCustomerWithEmptyFields.
	! !

!ImportTest methodsFor: 'tests' stamp: 'ms 11/14/2022 19:41:31'!
test09cannotImportAnAddressHavingEmptyFields

	self assertCannotImportInvalidRecord: self dataWithAddressWithEmptyFields.
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'ms 11/14/2022 19:13:38'!
assertCannotImportInvalidRecord: invalidData

	self 
		should: [ CustomerImporter valueFrom: invalidData into: session. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidRecordErrorDescription equals: anError messageText.
			self assertImportedRightNumberOfCustomers: 0.
		].
	
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'ms 11/14/2022 18:57:54'!
assertImportedRightNumberOfCustomers: customerAmount

	^ self assert: customerAmount equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:41:22'!
dataWithAddressWithEmptyFields

	^ ReadStream on: 'A,Maipu,888,Florida,,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:40:35'!
dataWithCustomerWithEmptyFields

	^ ReadStream on: 'C,,Sanchez,,12345678'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:09:30'!
dataWithEmptyRecord

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires

C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:20:08'!
dataWithInvalidAddress

	^ ReadStream on: 'A,Maipu,888,Florida,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:06:56'!
dataWithInvalidAddressType
	
	^ ReadStream on: 'AA,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:15:12'!
dataWithInvalidCustomer

	^ ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:06:04'!
dataWithInvalidCustomerType
	
	^ ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'ms 11/14/2022 19:05:09'!
dataWithInvalidRecordType

	^ ReadStream on: 'X'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:28:13'!
assertRecordElementsAmountIs: anAmount

	^ (record size = anAmount) ifFalse: [ self raiseInvalidRecordError ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:24:27'!
assertRecordIsNotEmpty

	^ record ifEmpty: [self error: CustomerImporter emptyRecordErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 18:16:35'!
createRecord

	^ record := ( line findTokens: $,)! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 18:20:23'!
hasRecordToImport

	line := readStream nextLine.
	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:28:13'!
importAddress

	self assertRecordElementsAmountIs: 6.

	newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:28:13'!
importCustomer

	self assertRecordElementsAmountIs: 5.

	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:25:05'!
importRecord
	
	self assertRecordIsNotEmpty.

	(self isCustomerRecord) ifTrue: [ ^ self importCustomer ].
	(self isAddressRecord) ifTrue: [ ^ self importAddress ].
	
	self raiseInvalidRecordError.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 18:39:40'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 18:37:20'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 19:25:05'!
raiseInvalidRecordError

	^ self error: CustomerImporter invalidRecordErrorDescription! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ms 11/14/2022 18:20:33'!
value

	[ self hasRecordToImport ] whileTrue: [  
		self createRecord.
		self importRecord.
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error' stamp: 'ms 11/14/2022 18:51:40'!
emptyRecordErrorDescription
	
	^ 'The record is empty!!!!'! !

!CustomerImporter class methodsFor: 'error' stamp: 'ms 11/14/2022 19:13:38'!
invalidRecordErrorDescription
	
	^ 'Invalid record type'! !


!CustomerImporter class methodsFor: 'as yet unclassified' stamp: 'ms 11/14/2022 19:13:40'!
invalidRecordTypeErrorDescription
	
	^ 'Invalid record!!'! !


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
