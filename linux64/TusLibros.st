!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:05:53'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook for: testObjectsFactory validUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:06:08'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new for: testObjectsFactory validUser.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:06:12'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook for: testObjectsFactory validUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:06:19'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook for: testObjectsFactory validUser.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:06:23'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook for: testObjectsFactory validUser.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'mr 11/14/2019 20:06:28'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook for: testObjectsFactory validUser.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosServiceTest category: #TusLibros!
TestCase subclass: #TusLibrosServiceTest
	instanceVariableNames: 'testObjectsFactory store currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:08'!
test01EmptyCartCreatedWithValidUserAndValidPasswordReturnsAnIdOfEmptyCart

	| tusLibrosService cartId |
	
	tusLibrosService := self defaultRestInterface.
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.
	
	self assert: (tusLibrosService listCart: cartId) isEmpty.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:15'!
test02CreateCartWithInvalidUserRaisesInvalidUserError

	| tusLibrosService |
	
	tusLibrosService := self defaultRestInterface.
	
	self should: [tusLibrosService createCartForClient: store invalidUser withPassword: store validPassword.]
	      raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService invalidClientErrorMessage.
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:20'!
test03CreateCartWithInvalidPasswordRaisesInvalidPasswordError

	| tusLibrosService |
	
	tusLibrosService := self defaultRestInterface.
	
	self should: [tusLibrosService createCartForClient: store validUser withPassword: store invalidPassword.]
	      raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService invalidPasswordErrorMessage.
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:26'!
test04AddAQuantityOfABookToAnExistentCartShowsTheBooksWhenListed

	| tusLibrosService cartId |
	
	tusLibrosService := self defaultRestInterface.
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.
	
	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore .
	
	self assert: (tusLibrosService listCart: cartId) equals: store defaultListCart .! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:33'!
test05AddAQuantityOfABookToAnInexistentCartRaisesCartInexistentError

	| tusLibrosService |
	
	tusLibrosService := self defaultRestInterface.
	
	self should: [ tusLibrosService add: 1 ToCart: store invalidCartId ofBook: store itemSellByTheStore. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: tusLibrosService cartInexistentErrorMessage.	
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:39'!
test06ListAnInexistentCartRaisesCartInexistentError

	| tusLibrosService |
	
	tusLibrosService := self defaultRestInterface.
	
	self should: [ tusLibrosService listCart: store invalidCartId. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: tusLibrosService cartInexistentErrorMessage.	
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:44'!
test07CheckOutAnInexistentCartRaisesCartInexistentError

	| tusLibrosService |
	
	tusLibrosService := self defaultRestInterface.
	
	self should: [ tusLibrosService checkOutCart: store invalidCartId withCreditCardNumber: store notExpiredCreditCard number
																		  withExpiration: store notExpiredCreditCard expirationMonthOfYear
																		  withOwner: store notExpiredCreditCard owner
																		  on: store today. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: tusLibrosService cartInexistentErrorMessage.	
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:50'!
test08CheckOutAnExistentCartRegistersTotalInSale

	| tusLibrosService cartId salesBook |

	salesBook := OrderedCollection new.

	tusLibrosService := self defaultRestInterfaceRegisteringIn: salesBook .
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.

	tusLibrosService checkOutCart: cartId withCreditCardNumber: store notExpiredCreditCard number
											withExpiration: store notExpiredCreditCard expirationMonthOfYear 
										     withOwner: store notExpiredCreditCard owner
											on: store today.
	self deny: salesBook isEmpty.
	self assert: salesBook first total equals: store itemSellByTheStorePrice.
	! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:53:59'!
test09CheckOutAnExistentCartRegistersCartInSale

	| tusLibrosService cartId salesBook |

	salesBook := OrderedCollection new.

	tusLibrosService := self defaultRestInterfaceRegisteringIn: salesBook .
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.

	tusLibrosService checkOutCart: cartId withCreditCardNumber: store notExpiredCreditCard number
											withExpiration: store notExpiredCreditCard expirationMonthOfYear 
										     withOwner: store notExpiredCreditCard owner
											on: store today.
	self deny: salesBook isEmpty.
	self assert: (salesBook first cart occurrencesOf: store itemSellByTheStore) equals: 1.
	self assert: salesBook first total equals: store itemSellByTheStorePrice.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:05'!
test10CannotInteractWithCheckedOutCart

	| tusLibrosService cartId |

	tusLibrosService := self defaultRestInterface.
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.

	tusLibrosService checkOutCart: cartId withCreditCardNumber: store notExpiredCreditCard number
											withExpiration: store notExpiredCreditCard expirationMonthOfYear 
										     withOwner: store notExpiredCreditCard owner
											on: store today.
	
	self should: [ tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService cartInexistentErrorMessage.
		
	self should: [ tusLibrosService listCart: cartId ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService cartInexistentErrorMessage.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:11'!
test11CannotAddItemsToTimedOutCart

	| tusLibrosService cartId |

	tusLibrosService := self defaultRestInterface.

	self timeSetToInitial.

	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	self timeIncreaseMinutes: 30.
	
	self should: [ tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService cartInexistentErrorMessage.

! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:16'!
test12CannotListTimedOutCart

	| tusLibrosService cartId |

	tusLibrosService := self defaultRestInterface.

	self timeSetToInitial.

	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	self timeIncreaseMinutes: 30.

	self should: [ tusLibrosService listCart: cartId ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService cartInexistentErrorMessage.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:20'!
test13CannotCheckOutTimedOutCart

	| tusLibrosService cartId salesBook |

	salesBook := OrderedCollection new.

	tusLibrosService := self defaultRestInterfaceRegisteringIn: salesBook .

	self timeSetToInitial .

	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.
	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.

	self timeIncreaseMinutes: 30.

	self should: [ tusLibrosService checkOutCart: cartId 
								    withCreditCardNumber: store validCreditCardNumber 
								    withExpiration: store notExpiredCreditCard expirationMonthOfYear
								    withOwner: store notExpiredCreditCard owner 
								    on: store today. ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: tusLibrosService cartInexistentErrorMessage.
		
	self assert: salesBook isEmpty.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:26'!
test14AddItemsToCartUpdatesTheAccessTimeOfTheCartSession

	| tusLibrosService cartId |

	tusLibrosService := self defaultRestInterface.

	self timeSetToInitial .

	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	self timeIncreaseMinutes: 1.

	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.

	self timeIncreaseMinutes: 29.

	self assert: (tusLibrosService listCart: cartId) equals: store defaultListCart.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:32'!
test15ListCartUpdatesTheAccessTimeOfTheCartSession

	| tusLibrosService cartId |

	tusLibrosService := self defaultRestInterface.

	self timeSetToInitial .

	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.

	self timeIncreaseMinutes: 1.

	tusLibrosService listCart: cartId.

	self timeIncreaseMinutes: 29.

	self assert: (tusLibrosService listCart: cartId) isEmpty.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:39'!
test16ListPurchasesOfAnInexistentClientRaisesError

	| tusLibrosService |

	tusLibrosService := self defaultRestInterface.

	self should: [ tusLibrosService listPurchasesOf: store invalidUser withPassword: store validPassword. ]
		  raise: Error - MessageNotUnderstood
		 withMessageText: tusLibrosService invalidClientErrorMessage.
! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:44'!
test17ListPurchasesOfAValidClientWithAnInvalidPasswordRaisesError

	| tusLibrosService |

	tusLibrosService := self defaultRestInterface.

	self should: [ tusLibrosService listPurchasesOf: store validUser withPassword: store invalidPassword. ]
		  raise: Error - MessageNotUnderstood
		 withMessageText: tusLibrosService invalidPasswordErrorMessage.
! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:49'!
test18ListPurchasesOfAValidClientWithNoPurchasesReturnsTotalZeroAndEmptyPurchases

	| tusLibrosService listPurchases |

	tusLibrosService := self defaultRestInterface.
	
	listPurchases := tusLibrosService listPurchasesOf: store validUser withPassword: store validPassword.
	
	self assert: listPurchases total equals: 0.
	self assert: listPurchases purchases isEmpty.! !

!TusLibrosServiceTest methodsFor: 'tests' stamp: 'dr 11/17/2019 16:54:55'!
test19ListPurchasesOfAValidClientWithPurchasesReturnsTotalAndPurchases

	| tusLibrosService listPurchases cartId |

	tusLibrosService := self defaultRestInterface.
	
	cartId := tusLibrosService createCartForClient: store validUser withPassword: store validPassword.
	
	tusLibrosService add: 1 ToCart: cartId ofBook: store itemSellByTheStore.
	
	tusLibrosService checkOutCart: cartId withCreditCardNumber: store notExpiredCreditCard number 
											withExpiration: store notExpiredCreditCard expirationMonthOfYear 
											withOwner: store notExpiredCreditCard owner
											on: store today.
	
	listPurchases := tusLibrosService listPurchasesOf: store validUser withPassword: store validPassword.
	
	self assert: listPurchases total equals: store itemSellByTheStorePrice.
	self assert: (listPurchases purchases at: store itemSellByTheStore) equals: 1.
	self assert: listPurchases purchases keys size equals: 1. ! !


!TusLibrosServiceTest methodsFor: 'setup' stamp: 'dr 11/17/2019 16:52:02'!
defaultRestInterface

	^ TusLibrosService withUsers: store defaultUsers andCatalog: store defaultCatalog storingIn: OrderedCollection new 
						through: self withClock: self.
	
	! !

!TusLibrosServiceTest methodsFor: 'setup' stamp: 'dr 11/17/2019 16:52:02'!
defaultRestInterfaceRegisteringIn: aSalesBook

	^ TusLibrosService withUsers: store defaultUsers andCatalog: store defaultCatalog storingIn: aSalesBook 
						through: self withClock: self.
	
	! !

!TusLibrosServiceTest methodsFor: 'setup' stamp: 'mr 11/14/2019 15:32:07'!
setUp

	store := StoreTestObjectsFactory new.
	currentTime := DateAndTime now.! !


!TusLibrosServiceTest methodsFor: 'clock protocol' stamp: 'mr 11/11/2019 19:55:38'!
now

	^ currentTime.

! !


!TusLibrosServiceTest methodsFor: 'merchant processor protocol' stamp: 'mr 11/11/2019 17:48:32'!
debit: aSmallInteger from: aCreditCard 
	! !


!TusLibrosServiceTest methodsFor: 'time management' stamp: 'dr 11/15/2019 15:05:33'!
timeIncreaseMinutes: aNumberOfMinutes

	currentTime := currentTime + (Duration minutes: aNumberOfMinutes) .! !

!TusLibrosServiceTest methodsFor: 'time management' stamp: 'dr 11/15/2019 15:05:45'!
timeSetToInitial

	currentTime := DateAndTime year: 2020 day: 19 hour: 12 minute: 0 second: 0.! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'mr 11/11/2019 15:32:53'!
forEachItemDo: aBlockToRun

	items do: aBlockToRun.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart lastAccess clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'accessing' stamp: 'mr 11/14/2019 15:26:28'!
cart

	^cart! !

!CartSession methodsFor: 'accessing' stamp: 'mr 11/14/2019 15:17:13'!
client

	^ clientId.! !

!CartSession methodsFor: 'accessing' stamp: 'mr 11/14/2019 15:09:38'!
lastAccess

	^ lastAccess.! !


!CartSession methodsFor: 'initialization' stamp: 'mr 11/14/2019 15:08:44'!
initializeCart: aCart accessedAt: aTimeOfAccess for: aClientId

	cart := aCart.
	lastAccess := aTimeOfAccess.
	clientId := aClientId.! !


!CartSession methodsFor: 'accessed at' stamp: 'mr 11/14/2019 15:08:44'!
accessedAt: aTimeOfAccess

	lastAccess := aTimeOfAccess.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'mr 11/14/2019 15:06:57'!
cart: aCart accessedAt: aTimeOfAccess for: aClientId

	^ self new initializeCart: aCart accessedAt: aTimeOfAccess for: aClientId.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'mr 11/14/2019 20:02:18'!
createSale

	^ Sale of: cart for: client.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'mr 11/14/2019 20:09:42'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aClient
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := aClient.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'mr 11/14/2019 20:09:16'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aClient 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aClient.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'mr 11/11/2019 16:06:38'!
initializeExpiringOn: aMonth number: aCreditCardNumber 

	expiration := aMonth.
	number := aCreditCardNumber.! !


!CreditCard methodsFor: 'accessing' stamp: 'mr 11/11/2019 16:02:18'!
expirationMonthOfYear

	^ expiration.	
! !

!CreditCard methodsFor: 'accessing' stamp: 'mr 11/11/2019 16:01:32'!
number

	^ number.
	
! !

!CreditCard methodsFor: 'accessing' stamp: 'mr 11/11/2019 16:01:44'!
owner

	^ owner.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'mr 11/11/2019 16:08:07'!
expiringOn: aMonth number: aCreditCardNumber owner: anOwner   
	
	^self new initializeExpiringOn: aMonth number: aCreditCardNumber.! !


!classDefinition: #ListPurchases category: #TusLibros!
Object subclass: #ListPurchases
	instanceVariableNames: 'total purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ListPurchases methodsFor: 'initialization' stamp: 'dr 11/15/2019 15:30:11'!
initialize

	purchases := Dictionary new.
	total := 0.! !

!ListPurchases methodsFor: 'initialization' stamp: 'mr 11/14/2019 17:39:25'!
initializePurchases: aListOfPurchases total: aTotal

	purchases := aListOfPurchases.
	total := aTotal.! !


!ListPurchases methodsFor: 'accessing' stamp: 'mr 11/14/2019 20:45:14'!
purchases

	^ purchases.! !

!ListPurchases methodsFor: 'accessing' stamp: 'mr 11/14/2019 17:37:08'!
total

	^ total.! !


!ListPurchases methodsFor: 'adding' stamp: 'dr 11/15/2019 15:46:07'!
register: aSale

	aSale forEachItemDo: [ :anItem | 
								self addItem: anItem.
							  ].
	
	total := total + aSale total.! !


!ListPurchases methodsFor: 'adding - private' stamp: 'dr 11/15/2019 15:40:42'!
addItem: anItem

	purchases at: anItem ifPresent: [ :aQuantity | purchases at: anItem put: aQuantity + 1 ]
							 ifAbsent: [ purchases at: anItem put: 1 ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListPurchases class' category: #TusLibros!
ListPurchases class
	instanceVariableNames: ''!

!ListPurchases class methodsFor: 'as yet unclassified' stamp: 'mr 11/14/2019 20:42:18'!
purchases: aListOfPurchases total: aTotal

	^ self new initializePurchases: aListOfPurchases total: aTotal.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total cart client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'mr 11/14/2019 20:08:13'!
initializeCart: aCart for: aClient

	cart := aCart.
	client := aClient.! !


!Sale methodsFor: 'cart' stamp: 'mr 11/11/2019 18:02:26'!
cart

	^ cart.! !


!Sale methodsFor: 'total' stamp: 'mr 11/11/2019 18:06:16'!
total
	
	^ cart total.
! !


!Sale methodsFor: 'client' stamp: 'mr 11/14/2019 20:08:30'!
client

	^ client! !


!Sale methodsFor: 'accessing' stamp: 'dr 11/15/2019 15:38:52'!
forEachItemDo: aBlockToRun

	cart forEachItemDo: aBlockToRun.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'mr 11/14/2019 20:07:46'!
of: aCart for: aClient 

	^self new initializeCart: aCart for: aClient.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mr 11/11/2019 15:40:10'!
invalidCartId
	
	^ 'abcdef'.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mr 11/11/2019 16:08:56'!
defaultOwner

	^ 'Owner Owner'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mr 11/11/2019 16:08:07'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) number: self validCreditCardNumber owner: self defaultOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mr 11/11/2019 16:08:07'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) number: self validCreditCardNumber owner: self defaultOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mr 11/11/2019 16:04:59'!
validCreditCardNumber

	^ 1111222233334444! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'dr 11/7/2019 20:21:01'!
defaultUsers

	^ Dictionary new add: (Association key: self validUser value: self validPassword ); yourself ! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'dr 11/7/2019 20:06:51'!
invalidPassword

	^ 'Melissa'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'dr 11/7/2019 20:07:36'!
invalidUser

	^ 'Dago'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'dr 11/7/2019 19:59:10'!
validPassword

	^ 'Dago'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'dr 11/7/2019 19:58:27'!
validUser

	^ 'Melissa'! !


!StoreTestObjectsFactory methodsFor: 'list cart' stamp: 'mr 11/14/2019 16:19:26'!
defaultListCart

	^ Dictionary new add: (Association key: self itemSellByTheStore  value: 1); yourself.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosService category: #TusLibros!
Object subclass: #TusLibrosService
	instanceVariableNames: 'clients catalog carts lastId salesBook merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosService methodsFor: 'initialization' stamp: 'dr 11/15/2019 15:54:10'!
initializeWithClients: anUsersDictionary andCatalog: aCatalog storingIn: aSalesBook through: aMerchantProcessor withClock: aClock
	
	clients := anUsersDictionary.
	catalog := aCatalog.
	lastId := 0.
	carts := Dictionary new.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.! !


!TusLibrosService methodsFor: 'assertions' stamp: 'mr 11/14/2019 15:45:39'!
assertNotTimedOutSession: aCartSession withId: aCartId 

	(self hasPassedHalfHourSince: aCartSession lastAccess) ifTrue: [ 
				self removeCartWithId: aCartId.
				self error: self cartInexistentErrorMessage.
	].! !

!TusLibrosService methodsFor: 'assertions' stamp: 'dr 11/15/2019 15:55:13'!
verifyCredentialsForClient: anUser withPassword: aPassword
	| password |
	
	password := clients at: anUser ifAbsent: [ self error: self invalidClientErrorMessage. ]. 
	password = aPassword ifFalse: [ self error: self invalidPasswordErrorMessage. ].! !


!TusLibrosService methodsFor: 'assertions - private' stamp: 'mr 11/14/2019 16:13:40'!
hasPassedHalfHourSince: aTime

	^ aTime + (Duration minutes: 30) <= clock now.! !


!TusLibrosService methodsFor: 'cart - private' stamp: 'dr 11/15/2019 09:57:32'!
addCart: aCartId withSession: aCartSession
	
	carts add: (Association key: aCartId value: aCartSession).
	
	
! !

!TusLibrosService methodsFor: 'cart - private' stamp: 'dr 11/15/2019 15:59:20'!
cartSessionOf: aCartId

	| cartSession |

	cartSession := carts at: aCartId ifAbsent: [ self error: self cartInexistentErrorMessage ].

	self assertNotTimedOutSession: cartSession withId: aCartId.
	
	^ cartSession.! !

!TusLibrosService methodsFor: 'cart - private' stamp: 'dr 11/7/2019 19:54:16'!
newId

	^ lastId := lastId + 1.
	
	! !

!TusLibrosService methodsFor: 'cart - private' stamp: 'mr 11/14/2019 15:44:24'!
removeCartWithId: aCartId

	carts removeKey: aCartId.! !

!TusLibrosService methodsFor: 'cart - private' stamp: 'dr 11/15/2019 16:00:18'!
updateAccessOf: cartSession.
	
	cartSession accessedAt: clock now.! !


!TusLibrosService methodsFor: 'cart' stamp: 'dr 11/15/2019 16:00:37'!
add: aQuantity ToCart: aCartId ofBook: aBook

	| cartSession |

	cartSession := self cartSessionOf: aCartId .

	cartSession cart add: aQuantity of: aBook.
	
	self updateAccessOf: cartSession.! !

!TusLibrosService methodsFor: 'cart' stamp: 'dr 11/15/2019 16:05:02'!
createCartForClient: anUser withPassword: aPassword

	| idForCart cartSession |
	self verifyCredentialsForClient: anUser withPassword: aPassword .
	
	idForCart := self newId.
	
	cartSession := self newCartSessionFor: anUser.
	
	"cart := Cart acceptingItemsOf: catalog .
	cartSession := CartSession cart: cart accessedAt: clock now for: anUser.
	"
	self addCart: idForCart withSession: cartSession .
	
	^ idForCart! !

!TusLibrosService methodsFor: 'cart' stamp: 'dr 11/15/2019 16:01:46'!
listCart: aCartId

	| list cartSession |

	list := Dictionary new.

	cartSession := self cartSessionOf: aCartId.
	
	cartSession cart forEachItemDo: [ :anItem | 
											list at: anItem ifPresent: [ :aQuantity | list at: anItem put: aQuantity + 1 ] 
															 ifAbsent: [ list add: (Association key: anItem value: 1) ].
										  ].

	self updateAccessOf: cartSession.

	^ list.! !

!TusLibrosService methodsFor: 'cart' stamp: 'dr 11/15/2019 16:06:12'!
newCartSessionFor: anUser
	
	| cart |
	
	cart := Cart acceptingItemsOf: catalog .
	
	^ CartSession cart: cart accessedAt: clock now for: anUser.
! !


!TusLibrosService methodsFor: 'error messages' stamp: 'mr 11/11/2019 15:39:42'!
cartInexistentErrorMessage
	
	^ 'The cart does not exist.'! !

!TusLibrosService methodsFor: 'error messages' stamp: 'dr 11/15/2019 15:55:13'!
invalidClientErrorMessage
	
	^ 'Invalid user caps sensitive try again'! !

!TusLibrosService methodsFor: 'error messages' stamp: 'dr 11/7/2019 20:24:19'!
invalidPasswordErrorMessage
	
	^ 'The password is invalid, try your alter password'! !


!TusLibrosService methodsFor: 'check out' stamp: 'mr 11/14/2019 20:07:02'!
checkOutCart: aCartId withCreditCardNumber: aCreditCardNumber withExpiration: anExpirationMonthOfYear withOwner: anOwner on: aDate

	| cart cartSession creditCard cashier |

	cartSession := carts at: aCartId ifAbsent: [ self error: self cartInexistentErrorMessage. ].

	self assertNotTimedOutSession: cartSession withId: aCartId.
	
	cart := cartSession cart.
	
	creditCard := CreditCard expiringOn: anExpirationMonthOfYear number: aCreditCardNumber owner: anOwner.
	
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: aDate registeringOn: salesBook for: cartSession client.
	
	cashier checkOut.
	
	carts removeKey: aCartId .
	! !


!TusLibrosService methodsFor: 'purchases' stamp: 'dr 11/15/2019 15:44:40'!
listOfPurchasesFor: aClient

	| listOfPurchases salesForClient |

	listOfPurchases := ListPurchases new.

	salesForClient := salesBook select: [ :aSale | aSale client = aClient ].

	salesForClient do: [ :aSale | listOfPurchases register: aSale. ].

	^ listOfPurchases.

	
	
	! !

!TusLibrosService methodsFor: 'purchases' stamp: 'dr 11/15/2019 15:54:35'!
listPurchasesOf: aClient withPassword: aPassword 

	self verifyCredentialsForClient: aClient withPassword: aPassword.

	^ self listOfPurchasesFor: aClient.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosService class' category: #TusLibros!
TusLibrosService class
	instanceVariableNames: ''!

!TusLibrosService class methodsFor: 'instance creation' stamp: 'dr 11/15/2019 15:54:02'!
withUsers: anUsersDictionary andCatalog: aCatalog storingIn: aSalesBook through: aMerchantProcessor withClock: aClock
	
	^self new initializeWithClients: anUsersDictionary andCatalog: aCatalog storingIn: aSalesBook through: aMerchantProcessor withClock: aClock.! !
