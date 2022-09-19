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
	instanceVariableNames: 'finder stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'ms 9/19/2022 00:46:19'!
setUp

	finder := SentenceFinderByPrefix new.
	
	stack := OOStack new.
	
	sentenceThatMatchPrefix := 'aaa bb aaac'.
	sentenceThatDoesNotMatchPrefix := 'aaa ab aaac'.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:51:31'!
test01findReturnsOnlySentencesStartingWithThePrefix

	| prefix firstSentence secondSentence sentencesWithPrefix |
	
	firstSentence := 'aaa bb aaac'.
	secondSentence := 'aaa ab aaac'.
	prefix := 'aaa b'.
	
	stack push: firstSentence.
	stack push: secondSentence.
	
	sentencesWithPrefix := finder find: prefix in: stack.
	
	self assert: sentencesWithPrefix size equals: 1.
	self assert: sentencesWithPrefix includes: firstSentence.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:42:27'!
test02findReturnsAnEmptyCollectionWhenThereAreNoMatches

	| prefix sentence |
	
	sentence := 'aabb cc'.
	prefix := 'ab ab'.
	
	stack push: sentence.
	
	self assert: (finder find: prefix in: stack) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:42:43'!
test03findReturnsAnEmptyCollectionWhenTheStackIsEmpty
	
	| prefix |

	prefix := 'hello world'.
	
	self assert: (finder find: prefix in: stack) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:42:54'!
test04findPreservesTheStackElements

	| prefix firstSentence secondSentence |
	
	firstSentence := 'aaa bb aaac'.
	secondSentence := 'aaa ab aaac'.
	prefix := 'aaa'.
	
	stack push: firstSentence.
	stack push: secondSentence.
	
	finder find: prefix in: stack.
	
	self assert: stack pop equals: secondSentence.
	self assert: stack pop equals: firstSentence.
	self assert: stack isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:43:09'!
test05findIsCaseSensitive

	| prefix firstSentence secondSentence sentencesWithPrefix |
	
	firstSentence := 'aAa bb aaac'.
	secondSentence := 'aaa ab aaac'.
	prefix := 'aaa'.
	
	stack push: firstSentence.
	stack push: secondSentence.
	
	sentencesWithPrefix := finder find: prefix in: stack.
	
	self assert: sentencesWithPrefix size equals: 1.
	self assert: sentencesWithPrefix includes: secondSentence! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:54:52'!
test06findRaisesAnErrorWhenPrefixIsEmpty

	| prefix |
	
	prefix := ''.
	
	self assertInvalidPrefix: prefix raises: SentenceFinderByPrefix emptyPrefixErrorDescription! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ms 9/19/2022 00:55:12'!
test07findRaisesAnErrorWhenPrefixHasOnlySpaces

	| prefix |
	
	prefix := '    '.
	
	self assertInvalidPrefix: prefix raises: SentenceFinderByPrefix allSpacesPrefixErrorDescription! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'ms 9/19/2022 00:54:03'!
assertInvalidPrefix: aPrefix raises: anErrorMessage

	self
		should: [ finder find: aPrefix in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorMessage ]! !


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

!OOStack methodsFor: 'operations' stamp: 'ms 9/18/2022 16:06:00'!
top

	^ topElement value! !


!OOStack methodsFor: 'testing' stamp: 'ms 9/18/2022 17:52:16'!
isEmpty

	^ topElement isKindOf: BaseElement! !

!OOStack methodsFor: 'testing' stamp: 'ms 9/18/2022 15:57:11'!
size

	^ topElement distanceFromStackBase! !

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

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/18/2022 23:40:03'!
add: aSentence to: aSentencesCollection ifIsPrefix: aPrefix.

	(self is: aPrefix aPrefixOf: aSentence) ifTrue: [ aSentencesCollection add: aSentence ].
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/18/2022 23:40:30'!
findAllMatchesOf: aPrefix in: aStackOfSentences andSaveThemIn: aSentencesCollection

	| sentence auxiliarStack |

	auxiliarStack  := OOStack new.
	
	self whileStackIsNotEmpty: aStackOfSentences
		do: [
			sentence := aStackOfSentences pop.
			auxiliarStack push: sentence.
			self add: sentence to: aSentencesCollection ifIsPrefix: aPrefix.
		].
	
	self restore: aStackOfSentences with: auxiliarStack.
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/19/2022 00:27:32'!
hasOnlySpaces: aPrefix

	^ aPrefix allSatisfy: [ :char | char isSeparator ]
	! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/18/2022 18:21:06'!
is: aString aPrefixOf: aSentence
	
	^ aSentence is: aString substringAt: 1
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/18/2022 23:36:09'!
restore: aStack with: anotherStack

	| stackElement |
	
	self whileStackIsNotEmpty: anotherStack
		do: [
			stackElement := anotherStack pop.
			aStack push: stackElement
		].
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ms 9/18/2022 23:34:41'!
whileStackIsNotEmpty: aStack do: aClosure

	
	[aStack size > 0] whileTrue: aClosure.
	
	
	
	 ! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'ms 9/19/2022 00:07:31'!
find: aPrefix in: aStackOfSentences

	| sentences |

	self assertPrefixIsNotEmpty: aPrefix.
	self assertPrefixDoesNotHaveOnlySpaces: aPrefix.
	
	sentences := OrderedCollection new.
	
	self findAllMatchesOf: aPrefix in: aStackOfSentences andSaveThemIn: sentences.
	
	^ sentences
	
	
	
	 ! !


!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'ms 9/19/2022 00:03:44'!
assertPrefixDoesNotHaveOnlySpaces: aPrefix

	^ (self hasOnlySpaces: aPrefix) ifTrue: [ self error: SentenceFinderByPrefix allSpacesPrefixErrorDescription ]
	
	
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'ms 9/18/2022 23:59:24'!
assertPrefixIsNotEmpty: aPrefix

	^ aPrefix isEmpty ifTrue: [ self error: SentenceFinderByPrefix emptyPrefixErrorDescription ]
	
	
	
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'ms 9/19/2022 00:01:20'!
allSpacesPrefixErrorDescription

	^ 'The prefix only has spaces!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'ms 9/18/2022 23:54:29'!
emptyPrefixErrorDescription

	^ 'The prefix is empty!!!!'! !
