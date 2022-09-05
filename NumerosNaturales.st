!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next and previous' stamp: 'pedro 8/25/2022 21:30:14'!
next
	^II! !


!I class methodsFor: 'operations' stamp: 'pedro 8/28/2022 22:26:18'!
* aMultiplier
	^ aMultiplier.! !

!I class methodsFor: 'operations' stamp: 'pedro 8/25/2022 21:34:01'!
+ anAdder
	II previous ifNil: (II previous: I).
	^ anAdder next.! !

!I class methodsFor: 'operations' stamp: 'ms 9/4/2022 18:56:30'!
- subtrahend

	^ self error: self negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'ms 9/4/2022 18:58:23'!
/ aDivisor
	aDivisor = I ifTrue: [^self] ifFalse: [self error: self canNotDivideByBiggerNumberErrorDescription.]
	! !

!I class methodsFor: 'operations' stamp: 'pedro 8/28/2022 22:56:00'!
> aNumber
	^ false.! !

!I class methodsFor: 'operations' stamp: 'pedro 8/28/2022 23:37:12'!
>= aNumber
	^ aNumber = I! !

!I class methodsFor: 'operations' stamp: 'ms 8/29/2022 20:33:07'!
subtractFrom: aMinuend

	^ aMinuend previous.! !


!I class methodsFor: 'errors' stamp: 'ms 9/4/2022 18:58:09'!
canNotDivideByBiggerNumberErrorDescription

	^'divisor should be lower than dividend'.! !

!I class methodsFor: 'errors' stamp: 'ms 9/4/2022 18:55:26'!
negativeNumbersNotSupportedErrorDescription

	^'subtrahend can not be greater than minuend'! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'remove all next' stamp: 'pedro 8/25/2022 21:38:18'!
removeAllNext

	next ifNotNil: 
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'next and previous' stamp: 'ms 9/4/2022 19:06:54'!
nameOfNext
	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix: 'III'), 'IV'].
	^ self name, 'I'! !

!II class methodsFor: 'next and previous' stamp: 'ms 8/29/2022 21:17:25'!
next
	next ifNil: [ 
		next := II createChildNamed: self nameOfNext.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'next and previous' stamp: 'pedro 8/25/2022 21:19:45'!
previous
	^ previous! !

!II class methodsFor: 'next and previous' stamp: 'pedro 8/25/2022 21:23:33'!
previous: previousNumber
	previous := previousNumber ! !


!II class methodsFor: 'operations' stamp: 'ms 8/29/2022 20:59:54'!
* aNumber
	^ self previous * aNumber + aNumber.! !

!II class methodsFor: 'operations' stamp: 'pedro 8/25/2022 21:17:51'!
+ anAdder
	^ self previous + anAdder next! !

!II class methodsFor: 'operations' stamp: 'ms 8/29/2022 20:34:25'!
- aSubtrahend
	
	^ aSubtrahend subtractFrom: self.! !

!II class methodsFor: 'operations' stamp: 'ms 9/4/2022 18:59:03'!
/ aDivisor
	self > aDivisor  ifTrue: [
		self - aDivisor >= aDivisor ifTrue: [^ self - aDivisor / aDivisor + I]
		ifFalse: [^ I]
	] ifFalse: [self = aDivisor ifTrue: [^ I] ifFalse: [^ self error: self canNotDivideByBiggerNumberErrorDescription] ]

	! !

!II class methodsFor: 'operations' stamp: 'pedro 8/28/2022 23:24:09'!
> aNumber
	aNumber = I ifTrue: [^ true] ifFalse: [^ self previous > aNumber previous.]
	! !

!II class methodsFor: 'operations' stamp: 'pedro 8/28/2022 23:39:11'!
>= aNumber
	aNumber = I ifTrue: [^ true] ifFalse: [^ self previous >= aNumber previous.]! !

!II class methodsFor: 'operations' stamp: 'ms 8/29/2022 20:39:16'!
subtractFrom: aMinuend

	^ aMinuend	 previous - self previous! !


!II class methodsFor: 'errors' stamp: 'ms 9/4/2022 18:59:46'!
canNotDivideByBiggerNumberErrorDescription

	^'divisor should be lower than dividend'.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'ms 9/5/2022 14:53:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'ms 9/5/2022 14:53:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NumerosNaturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NumerosNaturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'ms 9/5/2022 14:53:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!