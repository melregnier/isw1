!classDefinition: #CartTest category: #TusLibros stamp: 'dr 10/31/2019 15:58:16'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 14:40:06'!
test01NewCartIsEmpty

	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:02:44'!
test02CartWithProductIsNotEmpty

	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	cart add: 1 of: aBook .
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:09:24'!
test03CartWithProductsContainsProducts
	
	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	cart add: 1 of: aBook .
	
	self assert: (cart contains: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:09:31'!
test04CartWithAProductDoesNotContainOtherProducts
	
	| cart aBook anotherBook |
	cart := Cart new.
	aBook := Book new.
	cart add: 1 of: aBook.
	anotherBook := Book new.
	
	self deny: (cart contains: anotherBook).! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:30:17'!
test05CannotAddNotPositiveAmountOfABookToCart

	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	
	self should: [ cart add: 0 of: aBook. ]
		 raise: Error
		withMessageText: Cart cannotAddNotPositiveAmountOfBooksMessageError.
	
	self deny: (cart contains: aBook)! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:36:46'!
test06AmountOfAddedBookIsCorrect

	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	
	cart add: 1 of: aBook.
	
	self assert: (cart amountOf: aBook)  equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:37:20'!
test07AmountOfNotAddedBookIsZero

	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	
	self assert: (cart amountOf: aBook)  equals: 0.! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:39:48'!
test08AmountOfAnAddedBookIsIncreasedIfAddedAgain

	| cart aBook |
	cart := Cart new.
	aBook := Book new.
	
	cart add: 1 of: aBook.
	cart add: 1 of: aBook.
		
	self assert: (cart amountOf: aBook)  equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:49:27'!
test09EmptyCartHasEmptyListCart

	| cart |
	cart := Cart new.
	
	self assert: (cart listCart isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'dr 10/31/2019 15:55:00'!
test10CartWithBooksHasBooksAndItsQuantityInListCart

	| cart aBook |
	
	cart := Cart new.
	aBook := Book new.
	
	cart add: 1 of: aBook.
	
	self assert: (cart listCart includesKey: aBook).
	self assert: (cart listCart at: aBook) equals: 1.
	self assert: (cart listCart size) equals: 1.! !


!classDefinition: #Book category: #TusLibros stamp: 'dr 10/31/2019 15:58:16'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: #TusLibros stamp: 'dr 10/31/2019 15:58:16'!
Object subclass: #Cart
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'dr 10/31/2019 15:08:36'!
contains: aBook 
	
	^ contents includesKey: aBook .! !

!Cart methodsFor: 'testing' stamp: 'dr 10/31/2019 14:48:28'!
isEmpty
	
	^ contents isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'dr 10/31/2019 15:07:24'!
initialize

	contents := Dictionary new.! !


!Cart methodsFor: 'accessing' stamp: 'dr 10/31/2019 15:37:59'!
amountOf: aBook 
	
	^ contents at: aBook ifAbsent: [ ^ 0. ].! !

!Cart methodsFor: 'accessing' stamp: 'dr 10/31/2019 15:53:43'!
listCart
	
	^ contents.! !


!Cart methodsFor: 'assertions' stamp: 'dr 10/31/2019 15:25:16'!
assertIfNotPositive: aQuantity.	
	
	aQuantity <= 0 ifTrue: [ self error: self class cannotAddNotPositiveAmountOfBooksMessageError. ].! !


!Cart methodsFor: 'adding' stamp: 'dr 10/31/2019 15:45:06'!
add: aQuantity of: aBook 

	| previousAmount |
	self assertIfNotPositive: aQuantity.	
	previousAmount := contents at: aBook ifAbsent: [ 0 ].
	
	contents at: aBook put: previousAmount + aQuantity .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'dr 10/31/2019 15:58:16'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'dr 10/31/2019 15:22:50'!
cannotAddNotPositiveAmountOfBooksMessageError
	
	^ 'You cannot add not positive amount of that book'! !
