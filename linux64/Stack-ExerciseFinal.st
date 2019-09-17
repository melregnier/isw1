!classDefinition: #OOStackTest category: #'Stack-Exercise'!
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

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
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


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:12:42'!
test01EmptySentencesShouldReturnAnEmptyCollection
	
	| emptySentenceFinder |

	emptySentenceFinder := SentenceFinderByPrefix new.

	self assert: (emptySentenceFinder find: 'anything') = OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:18:56'!
test02APrefixNotFoundShouldReturnEmptyCollection

	| sentences |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'una oración en minúsculas'; pushSentence: 'otra oración en minúsculas'.
	self assert: (sentences find: 'cualquiera') = OrderedCollection new.

	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:29:59'!
test03ACaseSensitivePrefixFindsOnlyMatchingCaseSentences

	| sentences collectionWithCorrectSentence |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'una oración en minúsculas'; pushSentence: 'Una oración en mayúsculas'.
	collectionWithCorrectSentence := OrderedCollection new.
	collectionWithCorrectSentence add: 'Una oración en mayúsculas'.
	
	self assert: (sentences find: 'Un') = collectionWithCorrectSentence.

	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:32:01'!
test04FindSearchsPrefixAndNotSubstring

	| sentences |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'una oración en minúsculas'; pushSentence: 'Una oración en mayúsculas'.
	
	self assert: (sentences find: 'oración') = OrderedCollection new.

	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:39:16'!
test05FindDoesNotChangeTheAmountOfSentences

	| sentences |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'una oración en minúsculas'; pushSentence: 'Una oración en mayúsculas'.
	sentences find: 'oración'; find: 'una'; find: 'ESTO'.

	self assert: sentences amountOfSentences = 2.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:42:46'!
test06FindDoesNotChangeTheOrderOfSentences

	| sentences |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'una oración en minúsculas'; pushSentence: 'Una oración en mayúsculas'.
	sentences find: 'oración'; find: 'una'; find: 'ESTO'.

	self assert: sentences popSentence = 'Una oración en mayúsculas'.
	self assert: sentences popSentence = 'una oración en minúsculas'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:49:07'!
test07CanNotFindAnEmptyPrefix

	| sentences |
	
	sentences := SentenceFinderByPrefix new.

	self
	should: [ sentences find: '' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 16:50:28'!
test08CanNotFindAPrefixWithEmptySpaces

	| sentences |
	
	sentences := SentenceFinderByPrefix new.

	self
	should: [ sentences find: 'la la la lala' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText = SentenceFinderByPrefix emptySpacesInPrefixErrorDescription ]
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'dr 9/17/2019 17:01:14'!
test09FindingAPrefixWithManyMatchesReturnAllThoseMatches

	| sentences collectionWithTwoMatches |
	
	sentences := SentenceFinderByPrefix new.
	sentences pushSentence: 'Esto es una oración'; pushSentence: 'Es muy larga'; pushSentence: 'Esta es una manera de escribir'.
	collectionWithTwoMatches := OrderedCollection new.
	collectionWithTwoMatches add: 'Esto es una oración'; add: 'Esta es una manera de escribir'.
	
	self assert: (sentences find: 'Est') = collectionWithTwoMatches.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topOfStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'dr 9/16/2019 20:58:12'!
pop

	| topElement |
	topElement  := topOfStack top.
	topOfStack := topOfStack pop.
	^ topElement 

! !

!OOStack methodsFor: 'operations' stamp: 'dr 9/16/2019 20:58:31'!
push: anElementToPush
	
	topOfStack := topOfStack push: anElementToPush.! !


!OOStack methodsFor: 'testing' stamp: 'dr 9/16/2019 20:57:49'!
isEmpty

	^ topOfStack isEmpty.! !


!OOStack methodsFor: 'initialization' stamp: 'dr 9/16/2019 20:57:34'!
initialize
	
	topOfStack := OOEmptyStackSlot new. 
	! !


!OOStack methodsFor: 'accessing' stamp: 'dr 9/16/2019 20:58:40'!
size

	^ topOfStack size.

! !

!OOStack methodsFor: 'accessing' stamp: 'dr 9/16/2019 21:02:23'!
top

	^ topOfStack top.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackSlot category: #'Stack-Exercise'!
Object subclass: #OOStackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 20:39:24'!
pop

	self subclassResponsibility.! !

!OOStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 20:39:45'!
push: anElement

	self subclassResponsibility.! !


!OOStackSlot methodsFor: 'testing' stamp: 'dr 9/16/2019 20:39:53'!
isEmpty

	self subclassResponsibility.! !


!OOStackSlot methodsFor: 'accessing' stamp: 'dr 9/17/2019 17:09:30'!
size
	
	self subclassResponsibility.! !

!OOStackSlot methodsFor: 'accessing' stamp: 'dr 9/16/2019 20:40:00'!
top

	self subclassResponsibility.! !


!classDefinition: #OOEmptyStackSlot category: #'Stack-Exercise'!
OOStackSlot subclass: #OOEmptyStackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStackSlot methodsFor: 'accessing' stamp: 'dr 9/16/2019 21:06:36'!
size

	^ 0.! !

!OOEmptyStackSlot methodsFor: 'accessing' stamp: 'dr 9/16/2019 20:52:50'!
top

	self error: OOStack stackEmptyErrorDescription ! !


!OOEmptyStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 20:49:15'!
pop

	^ self error: OOStack stackEmptyErrorDescription ! !

!OOEmptyStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 20:50:29'!
push: anElement

	^ OONotEmptyStackSlot with: anElement withNext: self! !


!OOEmptyStackSlot methodsFor: 'testing' stamp: 'dr 9/16/2019 20:47:42'!
isEmpty

	^ true! !


!classDefinition: #OONotEmptyStackSlot category: #'Stack-Exercise'!
OOStackSlot subclass: #OONotEmptyStackSlot
	instanceVariableNames: 'nextSlot value amountOfNextElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotEmptyStackSlot methodsFor: 'accessing' stamp: 'dr 9/16/2019 21:06:18'!
size 
	
	^ amountOfNextElements.

	! !

!OONotEmptyStackSlot methodsFor: 'accessing' stamp: 'dr 9/16/2019 20:53:07'!
top

	^ value.! !


!OONotEmptyStackSlot methodsFor: 'initialization' stamp: 'dr 9/16/2019 21:06:55'!
initializeWith: anElement withNext: aNextSlot
	
	value := anElement. 
	nextSlot := aNextSlot .
	amountOfNextElements := aNextSlot size + 1.
	

	! !


!OONotEmptyStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 21:07:23'!
pop

	^ nextSlot ! !

!OONotEmptyStackSlot methodsFor: 'operations' stamp: 'dr 9/16/2019 21:01:01'!
push: anElement
	
	^ OONotEmptyStackSlot  with: anElement  withNext: self! !


!OONotEmptyStackSlot methodsFor: 'testing' stamp: 'dr 9/16/2019 20:47:57'!
isEmpty

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotEmptyStackSlot class' category: #'Stack-Exercise'!
OONotEmptyStackSlot class
	instanceVariableNames: ''!

!OONotEmptyStackSlot class methodsFor: 'instance creation' stamp: 'dr 9/16/2019 20:47:03'!
with: aValue withNext: aNextSlot

	^ self new initializeWith: aValue withNext: aNextSlot.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'dr 9/17/2019 16:36:32'!
amountOfSentences
	
	^ sentences size! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'dr 9/17/2019 16:04:47'!
find: aPrefix

	aPrefix isEmpty ifTrue: [ self error: self class emptyPrefixErrorDescription ].
	
	(aPrefix findString: ' ') ~= 0 ifTrue: [ self error: self class emptySpacesInPrefixErrorDescription ].
	
	^ self sentencesAsCollection select: [ :sentence | sentence beginsWith: aPrefix ].! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'dr 9/17/2019 15:23:08'!
topSentence

	^ sentences top.! !


!SentenceFinderByPrefix methodsFor: 'converting' stamp: 'dr 9/17/2019 16:05:33'!
sentencesAsCollection

	| sentencesContainer |
	
	sentencesContainer := OrderedCollection new.
	
	[ self isEmpty not ] whileTrue: [
		sentencesContainer addFirst: self popSentence.
	].

	sentencesContainer do: [ :sentence |
		self pushSentence: sentence.
	].

	^ sentencesContainer.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'dr 9/17/2019 15:20:34'!
popSentence

	^ sentences pop.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'dr 9/17/2019 15:20:57'!
pushSentence: aSentence

	^ sentences push: aSentence! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'dr 9/17/2019 15:19:10'!
initialize

	sentences := OOStack new.! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'dr 9/17/2019 15:20:16'!
isEmpty

	^ sentences isEmpty! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'dr 9/17/2019 15:49:50'!
emptyPrefixErrorDescription

	^ 'The prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'dr 9/17/2019 15:50:30'!
emptySpacesInPrefixErrorDescription

	^ 'The prefix cannot have empty spaces'! !
