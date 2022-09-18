!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'ms 9/18/2022 17:52:16'!
initialize

	topElement := BaseElement new! !


!OOStack methodsFor: 'operations' stamp: 'ms 9/18/2022 16:09:39'!
pop
	
	| lastElementValue |

	lastElementValue := self top.
	topElement := topElement previous.
	
	^ lastElementValue ! !

!OOStack methodsFor: 'operations' stamp: 'ms 9/18/2022 17:52:37'!
push: aValue

	topElement := ElementWithValue new initializeWith: aValue andAsNextOf: topElement! !


!OOStack methodsFor: 'status operations' stamp: 'ms 9/18/2022 17:52:16'!
isEmpty

	^ topElement isKindOf: BaseElement! !

!OOStack methodsFor: 'status operations' stamp: 'ms 9/18/2022 15:57:11'!
size

	^ topElement distanceFromStackBase! !

!OOStack methodsFor: 'status operations' stamp: 'ms 9/18/2022 16:06:00'!
top

	^ topElement value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'ms 9/18/2022 16:11:32'!
value

	self subclassResponsibility! !


!OOStackElement methodsFor: 'auxiliar operations' stamp: 'ms 9/18/2022 16:11:03'!
distanceFromStackBase

	self subclassResponsibility! !


!classDefinition: #BaseElement category: 'Stack-Exercise'!
OOStackElement subclass: #BaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseElement methodsFor: 'accessing' stamp: 'ms 9/18/2022 16:05:08'!
value

	self error: OOStack stackEmptyErrorDescription! !


!BaseElement methodsFor: 'auxiliar operations' stamp: 'ms 9/18/2022 15:57:29'!
distanceFromStackBase

	^ 0! !


!classDefinition: #ElementWithValue category: 'Stack-Exercise'!
OOStackElement subclass: #ElementWithValue
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementWithValue methodsFor: 'accessing' stamp: 'ms 9/18/2022 16:08:02'!
previous

	^ previous! !

!ElementWithValue methodsFor: 'accessing' stamp: 'ms 9/18/2022 15:52:53'!
value

	^ value! !


!ElementWithValue methodsFor: 'auxiliar operations' stamp: 'ms 9/18/2022 15:58:00'!
distanceFromStackBase

	^ 1 + previous distanceFromStackBase! !


!ElementWithValue methodsFor: 'instance creation' stamp: 'ms 9/18/2022 15:35:28'!
initializeWith: aValue andAsNextOf: aPreviousElement

	value := aValue.
	previous  := aPreviousElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementWithValue class' category: 'Stack-Exercise'!
ElementWithValue class
	instanceVariableNames: ''!

!ElementWithValue class methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 15:29:29'!
initializeWith: aValue andPrevious: aPreviousElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 18:45:48'!
find: aPrefix in: aStack

	| auxiliarStack sentences |
	
	auxiliarStack := OOStack new.
	sentences := OrderedCollection new.
	
	self findAllMatchesOf: aPrefix in: aStack with: auxiliarStack andSaveThemIn: sentences.

	self restore: aStack with: auxiliarStack.
	
	^ sentences
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 18:59:05'!
findAllMatchesOf: aPrefix in: aStack with: anAuxiliarStack andSaveThemIn: aSentencesCollection

	| sentence |

	self while: [ sentence := aStack pop ] 
		doesNotRaise: Error - MessageNotUnderstood
		do: [	
			anAuxiliarStack push: sentence.
			(self is: aPrefix aPrefixOf: sentence) ifTrue: [ aSentencesCollection add: sentence ].
		]
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 18:21:06'!
is: aString aPrefixOf: aSentence
	
	^ aSentence is: aString substringAt: 1
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 19:01:34'!
restore: aStack with: anotherStack

	| stackElement |
	
	self while: [ stackElement := anotherStack pop ]
		doesNotRaise: Error - MessageNotUnderstood  
		do: [ aStack push: stackElement ]
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ms 9/18/2022 19:00:03'!
while: anOperation doesNotRaise: anError do: aClosure 

	anOperation
		on: anError
		do: [ ^ 'returning' ].
		
	aClosure value.

	thisContext restart.
	
	
	
	 ! !
