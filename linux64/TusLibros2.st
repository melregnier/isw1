!classDefinition: #CartTest category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:14:14'!
test01EmptyCartHasTotalCostOfZero

	| aCart cashier aPriceList |
	aCart := Cart acceptingItemsOf: #('validItem1','validItem2').
	
	aPriceList := Dictionary new.
		
	cashier := Cashier withPriceList: aPriceList for: aCart.
	self assert: (cashier totalCost) equals: 0.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:37:42'!
test02CartWithValidItemHasTotalCostOfThatItem

	| aCart cashier aPriceList |
	aCart := Cart acceptingItemsOf: #('validItem1','validItem2').
	aCart add: 'validItem1'.
	
	aPriceList := Dictionary new.
	aPriceList add: (Association key: 'validItem1' value: 5 * peso).
	
	cashier := Cashier withPriceList: aPriceList for: aCart.
	self assert: (cashier totalCost) equals: 5 * peso.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:45:42'!
test03CartWithInvalidItemRaiseErrorOfItemNotKnownInPriceList

	| aCart cashier aPriceList |
	aCart := Cart acceptingItemsOf: #('invalidItem').
	aCart add: 'invalidItem'.
	
	aPriceList := Dictionary new.
	aPriceList add: (Association key: 'validItem' value: 5 * peso).
	
	self should: [cashier := Cashier withPriceList: aPriceList for: aCart. ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: (Cashier itemNotValidErrorMessageFor: 'invalidItem').
	
	self assert: cashier isNil.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 19:41:10'!
test04CheckOutForAnExpiredCreditCardRaiseError

	| aCart cashier aPriceList aCreditCardNumber anExpirationDate anOwner |
	aCart := Cart acceptingItemsOf: #('validItem').
	aCart add: 'validItem'.

	aPriceList := Dictionary new.
	aPriceList add: (Association key: 'validItem' value: 5 * peso).
	
	cashier := Cashier withPriceList: aPriceList for: aCart.
	
	aCreditCardNumber := 1111222233334444.
	anExpirationDate := March ofYear: (GregorianYear number: 2018).
	anOwner := 'Dago de Renteria'.
	
	self should: [ cashier checkOutFor: aCreditCardNumber withExpirationDate: anExpirationDate withOwner: anOwner ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: (Cashier expiratedCreditCardErrorMessage).
	
	"invariante no quedo como pagado que hacemos aca?"! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 19:40:51'!
test05CheckOutForACreditCardWithInvalidLengthRaiseErrorOfLength

	| aCart cashier aPriceList aCreditCardNumber anExpirationDate anOwner |
	aCart := Cart acceptingItemsOf: #('validItem').
	aCart add: 'validItem'.

	aPriceList := Dictionary new.
	aPriceList add: (Association key: 'validItem' value: 5 * peso).
	
	cashier := Cashier withPriceList: aPriceList for: aCart.
	
	aCreditCardNumber := 11112222333344444.
	anExpirationDate := March ofYear: (GregorianYear number: 2020).
	anOwner := 'Dago de Renteria'.
	
	self should: [ cashier checkOutFor: aCreditCardNumber withExpirationDate: anExpirationDate withOwner: anOwner ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: (Cashier invalidLengthOfCreditCardErrorMessage).
	
	"invariante no quedo como pagado que hacemos aca?"! !


!classDefinition: #Cart category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'sjd 11/2/2019 17:35:48'!
forEachItemDo: aClosureToRun 
	
	items do: aClosureToRun.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 19:38:50'!
assertCreditCardLengthFor: aCreditCardNumber.

	^ aCreditCardNumber size = 16 ifFalse: [ self error: self class invalidLengthOfCreditCardErrorMessage. ].	
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 18:15:09'!
assertCreditCardNotExpiredFor: anExpirationDate

	anExpirationDate < (GregorianMonthOfYear current) ifFalse: [self error: self class expiratedCreditCardErrorMessage ].
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 19:37:34'!
checkOutFor: aCreditCardNumber withExpirationDate: anExpirationDate withOwner: anOwner

	self assertCreditCardNotExpiredFor: anExpirationDate.
	self assertCreditCardLengthFor: aCreditCardNumber.
	
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:44:06'!
priceFor: anItem

	^ priceList at: anItem ifAbsent: [ self error: (self class itemNotValidErrorMessageFor: anItem) ].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:32:56'!
register: anItem 

	total := total + (self priceFor: anItem).! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:37:12'!
registerItemsOf: aCart 
	
	aCart forEachItemDo: [ :anItem | self register: anItem ].
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/2/2019 17:36:29'!
totalCost
	
	^ total.! !


!Cashier methodsFor: 'initialization' stamp: 'sjd 11/2/2019 17:37:24'!
initializeWithPriceList: aPriceList for: aCart
	
	priceList := aPriceList.
	total := 0 * peso.
	self registerItemsOf: aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'sjd 11/2/2019 19:41:35'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 19:39:41'!
expiratedCreditCardErrorMessage
	
	^ 'Expirated credit card. Please verify your information or try with another credit card.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 19:36:47'!
invalidLengthOfCreditCardErrorMessage
	
	^ 'Invalid length of credit card. Please verify your information or try with another credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 17:30:40'!
itemNotValidErrorMessageFor: anItem

	^ anItem printString, ' is not registered in the price list'! !


!Cashier class methodsFor: 'instance creation' stamp: 'sjd 11/2/2019 17:16:10'!
withPriceList: aPriceList for: aCart
	
	^ self new initializeWithPriceList: aPriceList for: aCart.! !
