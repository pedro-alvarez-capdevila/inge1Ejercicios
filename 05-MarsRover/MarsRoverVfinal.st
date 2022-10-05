!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'direction' stamp: 'pedro 10/4/2022 22:26:42'!
eastDirection

	^ EastDirection new! !

!MarsRoverTest methodsFor: 'direction' stamp: 'pedro 10/4/2022 22:26:54'!
northDirection

	^ NorthDirection new! !

!MarsRoverTest methodsFor: 'direction' stamp: 'pedro 10/4/2022 22:27:37'!
southDirection

	^ SouthDirection new! !

!MarsRoverTest methodsFor: 'direction' stamp: 'pedro 10/4/2022 22:25:26'!
westDirection

	^ WestDirection new! !


!MarsRoverTest methodsFor: 'position' stamp: 'pedro 10/4/2022 22:25:52'!
position1at1

	^ 1@1! !


!MarsRoverTest methodsFor: 'marsRover' stamp: 'pedro 10/4/2022 22:29:55'!
marsRoverWithEastDirection

	^ MarsRover at: self position1at1 facingTo: self eastDirection! !

!MarsRoverTest methodsFor: 'marsRover' stamp: 'pedro 10/4/2022 22:29:07'!
marsRoverWithNorthDirection

	^ MarsRover at: self position1at1 facingTo: self northDirection! !

!MarsRoverTest methodsFor: 'marsRover' stamp: 'pedro 10/4/2022 22:29:30'!
marsRoverWithSouthDirection

	^ MarsRover at: self position1at1 facingTo: self southDirection! !

!MarsRoverTest methodsFor: 'marsRover' stamp: 'pedro 10/4/2022 22:30:13'!
marsRoverWithWestDirection

	^ MarsRover at: self position1at1 facingTo: self westDirection! !


!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:07'!
test01MarsRoverInitializeWithPositionAndDirection
	| marsRover |
	marsRover := self marsRoverWithNorthDirection.
	
	self assert: (marsRover isAt: self position1at1 facingTo: self northDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:28:19'!
test02MarsRoverWithInvalidPositionRaisesAnError
	| direction |
	direction := $A.
	
	self
		should: [MarsRover at: self position1at1 facingTo: direction.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: MarsRover invalidDirectionDescription ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:07'!
test03SendingOnlyAnFToMarsRoverWithNorthDirectionMovesItUp
	| marsRover |
	marsRover := self marsRoverWithNorthDirection. 
	
	marsRover do: 'f'.
	self assert: (marsRover isAt: 1@2 facingTo: self northDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:30'!
test04SendingOnlyAnFToMarsRoverWithSouthDirectionMovesItDown
	| marsRover |
	marsRover := self marsRoverWithSouthDirection. 
	
	marsRover do: 'f'.
	self assert: (marsRover isAt: 1@0 facingTo: self southDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:55'!
test05SendingOnlyAnFToMarsRoverWithEastDirectionMovesItRight
	| marsRover |
	marsRover := self marsRoverWithEastDirection. 
	
	marsRover do: 'f'.
	self assert: (marsRover isAt: 2@1 facingTo: self eastDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:30:13'!
test06SendingOnlyAnFToMarsRoverWithWestDirectionMovesItLeft
	| marsRover |
	marsRover := self marsRoverWithWestDirection. 
	
	marsRover do: 'f'.
	self assert: (marsRover isAt: 0@1 facingTo: self westDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:07'!
test07SendingOnlyAnBToMarsRoverWithNorthDirectionMovesItDown
	| marsRover |
	marsRover := self marsRoverWithNorthDirection. 
	
	marsRover do: 'b'.
	self assert: (marsRover isAt: 1@0 facingTo: self northDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:30'!
test08SendingOnlyAnBToMarsRoverWithSouthDirectionMovesItUp
	| marsRover |
	marsRover := self marsRoverWithSouthDirection. 
	
	marsRover do: 'b'.
	self assert: (marsRover isAt: 1@2 facingTo: self southDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:55'!
test09SendingOnlyAnBToMarsRoverWithEastDirectionMovesItLeft
	| marsRover |
	marsRover := self marsRoverWithEastDirection. 
	
	marsRover do: 'b'.
	self assert: (marsRover isAt: 0@1 facingTo: self eastDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:30:13'!
test10SendingOnlyAnBToMarsRoverWithWestDirectionMovesItRight
	| marsRover |
	marsRover := self marsRoverWithWestDirection. 
	
	marsRover do: 'b'.
	self assert: (marsRover isAt: 2@1 facingTo: self westDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:07'!
test11SendingOnlyAnLToMarsRoverWithNorthDirectionRotatesItToWest
	| marsRover |
	marsRover := self marsRoverWithNorthDirection. 
	
	marsRover do: 'l'.
	self assert: (marsRover isAt: self position1at1 facingTo: self westDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:30'!
test12SendingOnlyAnLToMarsRoverWithSouthDirectionRotatesItToEast
	| marsRover |
	marsRover := self marsRoverWithSouthDirection. 
	
	marsRover do: 'l'.
	self assert: (marsRover isAt: self position1at1 facingTo: self eastDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:29:55'!
test13SendingOnlyAnLToMarsRoverWithEastDirectionRotatesItToNorth
	| marsRover |
	marsRover := self marsRoverWithEastDirection.
	
	marsRover do: 'l'.
	self assert: (marsRover isAt: self position1at1 facingTo: self northDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:30:13'!
test14SendingOnlyAnLToMarsRoverWithWestDirectionRotatesItToSouth
	| marsRover |
	marsRover := self marsRoverWithWestDirection.
	
	marsRover do: 'l'.
	self assert: (marsRover isAt: self position1at1 facingTo: self southDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:32:34'!
test15SendingOnlyAnRToMarsRoverWithNorthDirectionRotatesItToEast
	| marsRover |
	marsRover := self marsRoverWithNorthDirection. 
	
	marsRover do: 'r'.
	self assert: (marsRover isAt: self position1at1 facingTo: self eastDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:35:57'!
test16SendingOnlyAnRToMarsRoverWithSouthDirectionRotatesItToWest
	| marsRover |
	marsRover := self marsRoverWithSouthDirection.
	
	marsRover do: 'r'.
	self assert: (marsRover isAt: self position1at1 facingTo: self westDirection ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:37:15'!
test17SendingOnlyAnRToMarsRoverWithEastDirectionRotatesItToSouth
	| marsRover |
	marsRover := self marsRoverWithEastDirection.
	
	marsRover do: 'r'.
	self assert: (marsRover isAt: self position1at1 facingTo: self southDirection ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 22:40:10'!
test18SendingOnlyAnRToMarsRoverWithWestDirectionRotatesItToNorth
	| marsRover |
	marsRover := self marsRoverWithWestDirection.
	
	marsRover do: 'r'.
	self assert: (marsRover isAt: self position1at1 facingTo: self northDirection ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 23:13:19'!
test19SendingTwoCommandsExecutesItInOrder

	| marsRover |
	marsRover := self marsRoverWithNorthDirection.
	
	marsRover do: 'fr'.
	self assert: (marsRover isAt: (1@2) facingTo: self eastDirection ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/4/2022 23:18:04'!
test20SendingMoreThanTwoCommandsExecutesItInOrder

	| marsRover |
	marsRover := self marsRoverWithNorthDirection.
	
	marsRover do: 'frfr'.
	self assert: (marsRover isAt: (2@2) facingTo: self southDirection).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'pedro 10/5/2022 18:05:47'!
test21SendingAnInvalidCommandRaisesAnError

	| marsRover |
	marsRover := self marsRoverWithNorthDirection.
	
	
	self
		should: [marsRover do: 'a'.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Command invalidCommandDescription ]! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'execute' stamp: 'pedro 10/5/2022 18:06:35'!
executeIn: aMarsRover withDirection: aDirection 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'pedro 10/5/2022 17:56:21'!
with: aChar
	self subclasses 
		detect: [:aCommandSubclass | aCommandSubclass canHandle: aChar ]
		ifFound: [:aCommandSubclass | ^ aCommandSubclass new]
		ifNone: [^ self error: self invalidCommandDescription].
	! !


!Command class methodsFor: 'errorDescription' stamp: 'pedro 10/5/2022 17:59:12'!
invalidCommandDescription
	^ 'invalid command!!!!'! !


!classDefinition: #BackwardCommand category: 'MarsRover'!
Command subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!BackwardCommand methodsFor: 'execute' stamp: 'pedro 10/5/2022 18:17:10'!
executeIn: aMarsRover withDirection: aDirection 
	aDirection moveBackward: aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'MarsRover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'instance creation - private' stamp: 'pedro 10/5/2022 17:57:49'!
canHandle: aChar 
	^ aChar = $b.! !


!classDefinition: #ForwardCommand category: 'MarsRover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ForwardCommand methodsFor: 'execute' stamp: 'pedro 10/5/2022 18:17:05'!
executeIn: aMarsRover withDirection: aDirection 
	aDirection moveForward: aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'MarsRover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'instance creation - private' stamp: 'pedro 10/5/2022 17:57:23'!
canHandle: aChar 
	^ aChar = $f.! !


!classDefinition: #LeftCommand category: 'MarsRover'!
Command subclass: #LeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!LeftCommand methodsFor: 'execute' stamp: 'pedro 10/5/2022 18:17:00'!
executeIn: aMarsRover withDirection: aDirection 
	aDirection rotateToLeft: aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftCommand class' category: 'MarsRover'!
LeftCommand class
	instanceVariableNames: ''!

!LeftCommand class methodsFor: 'instance creation - private' stamp: 'pedro 10/5/2022 17:58:14'!
canHandle: aChar 
	^ aChar = $l.! !


!classDefinition: #RightCommand category: 'MarsRover'!
Command subclass: #RightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RightCommand methodsFor: 'execute' stamp: 'pedro 10/5/2022 18:16:54'!
executeIn: aMarsRover withDirection: aDirection 
	aDirection rotateToRight: aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightCommand class' category: 'MarsRover'!
RightCommand class
	instanceVariableNames: ''!

!RightCommand class methodsFor: 'instance creation - private' stamp: 'pedro 10/5/2022 17:58:33'!
canHandle: aChar 
	^ aChar = $r.! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'moveForward' stamp: 'pedro 10/5/2022 18:07:23'!
moveForward: aMarsRover 
	self subclassResponsibility.! !


!Direction methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:07:20'!
rotateToRight: aMarsRover 
	self subclassResponsibility.! !


!Direction methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:07:18'!
rotateToLeft: aMarsRover 
	self subclassResponsibility.! !


!Direction methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:07:09'!
moveBackward: aMarsRover 
	self subclassResponsibility.! !


!classDefinition: #EastDirection category: 'MarsRover'!
Direction subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:15:06'!
moveBackward: aMarsRover 
	aMarsRover moveBackwardWhenIsFacingToEast.! !


!EastDirection methodsFor: 'moveForward' stamp: 'pedro 10/5/2022 18:14:55'!
moveForward: aMarsRover 
	aMarsRover moveForwardWhenIsFacingToEast.! !


!EastDirection methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:16:13'!
rotateToRight: aMarsRover 
	aMarsRover rotateToRightWhenIsFacingToEast.! !


!EastDirection methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:15:00'!
rotateToLeft: aMarsRover 
	aMarsRover rotateToLeftWhenIsFacingToEast.! !


!classDefinition: #NorthDirection category: 'MarsRover'!
Direction subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:15:22'!
moveBackward: aMarsRover 
	aMarsRover moveBackwardWhenIsFacingToNorth. ! !


!NorthDirection methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:34:00'!
moveForward: aMarsRover 
	aMarsRover moveForwardWhenIsFacingToNorth.! !


!NorthDirection methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:15:17'!
rotateToLeft: aMarsRover 
	aMarsRover rotateToLeftWhenIsFacingToNorth. ! !


!NorthDirection methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:15:13'!
rotateToRight: aMarsRover 
	aMarsRover rotateToRightWhenIsFacingToNorth ! !


!classDefinition: #SouthDirection category: 'MarsRover'!
Direction subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:15:35'!
moveBackward: aMarsRover 
	aMarsRover moveBackwardWhenIsFacingToSouth. ! !


!SouthDirection methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:32:51'!
moveForward: aMarsRover 
	aMarsRover moveForwardWhenIsFacingToSouth.! !


!SouthDirection methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:15:29'!
rotateToLeft: aMarsRover 
	aMarsRover rotateToLeftWhenIsFacingToSouth.! !


!SouthDirection methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:15:26'!
rotateToRight: aMarsRover 
	aMarsRover rotateToRightWhenIsFacingToSouth.! !


!classDefinition: #WestDirection category: 'MarsRover'!
Direction subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:15:49'!
moveBackward: aMarsRover 
	aMarsRover moveBackwardWhenIsFacingToWest.! !


!WestDirection methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:36:52'!
moveForward: aMarsRover 
	aMarsRover moveForwardWhenIsFacingToWest.! !


!WestDirection methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:15:43'!
rotateToLeft: aMarsRover 
	aMarsRover rotateToLeftWhenIsFacingToWest.! !


!WestDirection methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:15:39'!
rotateToRight: aMarsRover 
	aMarsRover rotateToRightWhenIsFacingToWest.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initializing' stamp: 'pedro 10/4/2022 18:37:50'!
initializeAt: aPosition facingTo: aDirection 
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'testing' stamp: 'pedro 10/4/2022 22:19:27'!
isAt: aPosition facingTo: aDirection 
	^ position = aPosition and: [direction class = aDirection class].! !


!MarsRover methodsFor: 'do' stamp: 'pedro 10/5/2022 17:59:32'!
do: commands 
	commands do: [:aCommand | (Command with: aCommand ) executeIn: self withDirection: direction].

	
	! !


!MarsRover methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:48:09'!
moveForwardWhenIsFacingToEast
	position := position + (1@0).! !

!MarsRover methodsFor: 'moveForward' stamp: 'pedro 10/5/2022 18:19:24'!
moveForwardWhenIsFacingToNorth
	position := position + (0@1).! !

!MarsRover methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:49:16'!
moveForwardWhenIsFacingToSouth
	position := position - (0@1).! !

!MarsRover methodsFor: 'moveForward' stamp: 'pedro 10/4/2022 21:51:17'!
moveForwardWhenIsFacingToWest
	position := position - (1@0).! !


!MarsRover methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:16:01'!
moveBackwardWhenIsFacingToEast
	position := position - (1@0).! !

!MarsRover methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:17:35'!
moveBackwardWhenIsFacingToNorth
	position := position - (0@1).! !

!MarsRover methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:17:41'!
moveBackwardWhenIsFacingToSouth
	position := position + (0@1).! !

!MarsRover methodsFor: 'moveBackward' stamp: 'pedro 10/5/2022 18:17:39'!
moveBackwardWhenIsFacingToWest
	position := position + (1@0).! !


!MarsRover methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:19:06'!
rotateToLeftWhenIsFacingToEast
	direction := NorthDirection new.! !

!MarsRover methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:19:11'!
rotateToLeftWhenIsFacingToNorth
	direction := WestDirection new.! !

!MarsRover methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:19:14'!
rotateToLeftWhenIsFacingToSouth
	direction := EastDirection new.! !

!MarsRover methodsFor: 'rotateToLeft' stamp: 'pedro 10/5/2022 18:19:09'!
rotateToLeftWhenIsFacingToWest
	direction := SouthDirection new.! !


!MarsRover methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:19:01'!
rotateToRightWhenIsFacingToEast
	direction := SouthDirection new.! !

!MarsRover methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:18:58'!
rotateToRightWhenIsFacingToNorth
	direction := EastDirection new.! !

!MarsRover methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:18:54'!
rotateToRightWhenIsFacingToSouth
	direction := WestDirection new.! !

!MarsRover methodsFor: 'rotateToRight' stamp: 'pedro 10/5/2022 18:18:33'!
rotateToRightWhenIsFacingToWest
	direction := NorthDirection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'pedro 10/5/2022 18:20:26'!
assertValidDirection: aDirection

	^ (aDirection isKindOf: Direction) ifFalse: [self error: self invalidDirectionDescription ]! !

!MarsRover class methodsFor: 'instance creation' stamp: 'pedro 10/5/2022 18:20:37'!
at: aPosition facingTo: aDirection 
	self assertValidDirection: aDirection.
	
	^self new initializeAt: aPosition facingTo: aDirection ! !


!MarsRover class methodsFor: 'error' stamp: 'pedro 10/4/2022 18:55:21'!
invalidDirectionDescription

	^ 'invalid direction!!!!!!'! !
