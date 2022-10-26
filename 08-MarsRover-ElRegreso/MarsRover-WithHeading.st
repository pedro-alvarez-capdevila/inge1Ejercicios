!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:23:44'!
test01LoggingPositionOfMarsRoverWithoutCommandsReturnsTheStartingPosition

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRover process: ''.
	
	positionLogger := PositionLogger for: marsRover.
	
	self assert: positionLogger log equals: (OrderedCollection with: '1@1')! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:23:25'!
test02LoggingPositionOfMarsRoverWithMultipleCommandsLogsThePositions

	| marsRover positionLogger expectedPositions |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogger := PositionLogger for: marsRover.
	
	marsRover process: 'ffb'.
	expectedPositions := OrderedCollection with: '1@1' with: '1@2' with: '1@3' with: '1@2'.
	
	self assert: positionLogger log equals: expectedPositions ! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:24:31'!
test03LoggingDirectionOfMarsRoverWithoutCommandsReturnsTheStartingDirection

	| marsRover headingLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLogger := HeadingLogger for: marsRover.
	
	marsRover process: ''.
	
	self assert: headingLogger log equals: (OrderedCollection with: 'North')! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:25:36'!
test04LoggingDirectionsOfMarsRoverWithMultipleCommandsLogsTheDirections

	| marsRover positionLogger expectedDirections |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogger := HeadingLogger for: marsRover.
	
	marsRover process: 'rrl'.
	expectedDirections := OrderedCollection with: 'North' with: 'East' with: 'South' with: 'East'.
	
	self assert: positionLogger log equals: expectedDirections! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:25:50'!
test05LoggingDirectionsOfMarsRoverJustTakesIntoAccountHeadChanges

	| marsRover positionLogger expectedDirections |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogger := HeadingLogger for: marsRover.
	
	marsRover process: 'rbrfl'.
	expectedDirections := OrderedCollection with: 'North' with: 'East' with: 'South' with: 'East'.
	
	self assert: positionLogger log equals: expectedDirections! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:26:05'!
test06LoggingPositionOfMarsRoverOnlyTakesIntoAccountThePositions

	| marsRover positionLogger expectedPositions |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogger := PositionLogger for: marsRover.
	
	marsRover process: 'frfbl'.
	expectedPositions := OrderedCollection with: '1@1' with: '1@2' with: '2@2' with: '1@2'.
	
	self assert: positionLogger log equals: expectedPositions ! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:26:23'!
test07MarsRoverCanHandleMultipleLoggers

	| marsRover positionLogger headingLogger expectedPositions expectedHeadings |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogger := PositionLogger for: marsRover.
	headingLogger := HeadingLogger for: marsRover.
	
	marsRover process: 'frfbl'.
	expectedPositions := OrderedCollection with: '1@1' with: '1@2' with: '2@2' with: '1@2'.
	expectedHeadings := OrderedCollection with: 'North' with: 'East' with: 'North'.
	
	self assert: positionLogger log equals: expectedPositions. 
	self assert: headingLogger log equals: expectedHeadings! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:35:47'!
test08LoggingPositionAndHeadingOfMarsRoverWithoutCommandsLogsTheStartingPositionAndHeading

	| marsRover headingAndPositionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionLogger := HeadingAndPositionLogger for: marsRover.
	
	self assert: headingAndPositionLogger log equals: (OrderedCollection with: '1@1' with: 'North')! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'ms 10/26/2022 18:40:03'!
test09LoggingPositionAndHeadingOfMarsRoverWithMultipleCommands

	| marsRover headingAndPositionLogger expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionLogger := HeadingAndPositionLogger for: marsRover.
	
	marsRover process: 'fr'.
	expectedLog := OrderedCollection with: '1@1' with: 'North' with: '1@2' with: 'East'.
	self assert: headingAndPositionLogger log equals: expectedLog ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
Object subclass: #Logger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'logging' stamp: 'ms 10/26/2022 18:36:45'!
log

	^ log! !

!Logger methodsFor: 'logging' stamp: 'ms 10/26/2022 18:29:13'!
update: aMarsRover

	self subclassResponsibility ! !


!Logger methodsFor: 'initialization' stamp: 'ms 10/26/2022 18:28:45'!
initializeWith: aMarsRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: 'MarsRover-WithHeading'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'as yet unclassified' stamp: 'ms 10/26/2022 18:34:54'!
for: aMarsRover

	^ self new initializeWith: aMarsRover! !


!classDefinition: #HeadingAndPositionLogger category: 'MarsRover-WithHeading'!
Logger subclass: #HeadingAndPositionLogger
	instanceVariableNames: 'lastPosition lastHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingAndPositionLogger methodsFor: 'initialization' stamp: 'ms 10/26/2022 18:48:13'!
initializeWith: aMarsRover
	
	|position heading|
	aMarsRover addLogger: self.
	position := aMarsRover position asString.
	heading := aMarsRover heading.

	log := OrderedCollection with: position with: heading.
	lastPosition := position.
	lastHeading := heading 
	
	! !


!HeadingAndPositionLogger methodsFor: 'logging' stamp: 'ms 10/26/2022 18:51:01'!
update: aMarsRover
	
	| position heading |
	
	position := aMarsRover position asString.
	heading := aMarsRover heading.
	(position ~= lastPosition) ifTrue: [ log add: position. lastPosition := position ].
	(heading ~= lastHeading) ifTrue: [ log add: heading. lastHeading := heading ]! !


!classDefinition: #HeadingLogger category: 'MarsRover-WithHeading'!
Logger subclass: #HeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogger methodsFor: 'logging' stamp: 'ms 10/26/2022 18:26:39'!
update: aMarsRover
	
	| heading |
	heading := aMarsRover heading.
	(heading ~= log last) ifTrue: [ log add: heading asString ]! !


!HeadingLogger methodsFor: 'initialization' stamp: 'ms 10/26/2022 18:25:12'!
initializeWith: aMarsRover
	
	aMarsRover addLogger: self.
	log := OrderedCollection with: aMarsRover heading! !


!classDefinition: #PositionLogger category: 'MarsRover-WithHeading'!
Logger subclass: #PositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogger methodsFor: 'logging' stamp: 'ms 10/26/2022 18:26:50'!
update: aMarsRover

	| position |
	
	position := aMarsRover position.
	(position asString ~= log last) ifTrue: [ log add: position asString ]! !


!PositionLogger methodsFor: 'initialization' stamp: 'ms 10/26/2022 18:24:01'!
initializeWith: aMarsRover

	aMarsRover addLogger: self.
	log := OrderedCollection with: aMarsRover position asString ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head loggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ms 10/26/2022 17:16:30'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	loggers := OrderedCollection new! !


!MarsRover methodsFor: 'heading' stamp: 'ms 10/26/2022 17:48:55'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	self notify! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/26/2022 17:49:10'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	self notify! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/26/2022 17:49:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	self notify! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/26/2022 17:49:22'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	self notify! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/26/2022 17:49:47'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'ms 10/24/2022 20:24:30'!
moveBackward
	
	head moveBackward.! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/26/2022 17:52:26'!
moveEast
	
	position := position + (1@0).
	self notify! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/24/2022 20:24:36'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/26/2022 17:52:30'!
moveNorth
	
	position := position + (0@1).
	self notify! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/26/2022 17:52:34'!
moveSouth
	
	position := position + (0@-1).
	self notify! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/26/2022 17:52:38'!
moveWest
	
	position := position + (-1@0).
	self notify! !


!MarsRover methodsFor: 'command processing' stamp: 'ms 10/24/2022 20:22:21'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:11:44'!
heading

	^ head direction! !

!MarsRover methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:11:22'!
position

	^ position! !


!MarsRover methodsFor: 'logging' stamp: 'ms 10/26/2022 17:18:04'!
addLogger: aLogger

	loggers add: aLogger ! !

!MarsRover methodsFor: 'logging' stamp: 'ms 10/26/2022 17:53:30'!
notify

	^ loggers do: [:logger | logger update: self]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:13:34'!
direction

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:13:52'!
direction	

	^ 'East'! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:14:06'!
direction	

	^ 'North'! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:14:14'!
direction	

	^ 'South'! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'accessing' stamp: 'ms 10/26/2022 18:14:23'!
direction	

	^ 'West'! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !
