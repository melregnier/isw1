!classDefinition: #AccountReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:21:15'!
accountSummaryForAllTransactions

	^ 'Depósito por 50.', String newLineString ,
	'Extracción por 25.', String newLineString ,
	'Entrada por transferencia de 100.', String newLineString ,
	'Salida por transferencia de 10.', String newLineString ,
	 'Balance = 115'.! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:34:08'!
netTransferReportFor: aValue

	^ 'Neto de transferencia = ', aValue asString.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:28:32'!
registerAllTransactionsIn: anAccount

	| aTransferingAccount |
	
	aTransferingAccount := ReceptiveAccount new.

	Deposit register: 50 on: anAccount.
	Withdraw register: 25 on: anAccount. 
	Transfer register: 100 from: aTransferingAccount to: anAccount.
	Transfer register: 10 from: anAccount to: aTransferingAccount.
	
	^ aTransferingAccount .
	

! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:25:59'!
test01EmptyReceptiveAccountHasEmptyAccountSummary

	| anAccount anAccountSummaryReport |

	anAccount := ReceptiveAccount new.
	
	anAccountSummaryReport := AccountSummaryReport for: anAccount.
	
	self assert: anAccountSummaryReport value equals: 'Balance = 0' .! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:07'!
test02ReceptiveAccountWithDepositHasValidAccountSummary

	| anAccount anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anAccountSummaryReport := AccountSummaryReport for: anAccount.

	self assert: anAccountSummaryReport value equals: 
	'Depósito por 100.',String newLineString , 'Balance = 100' .! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:14'!
test03ReceptiveAccountWithWithdrawHasValidAccountSummary

	| anAccount anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 50 on: anAccount .

	anAccountSummaryReport := AccountSummaryReport for: anAccount.

	self assert: anAccountSummaryReport value equals: 
	'Extracción por 50.',String newLineString , 'Balance = -50' .! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:19'!
test04ReceptiveAccountWithTransferInHasValidAccountSummary

	| anAccount aTransferingAccount anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	aTransferingAccount := ReceptiveAccount new.

	Transfer register: 100 from: aTransferingAccount to: anAccount.

	anAccountSummaryReport := AccountSummaryReport for: anAccount.

	self assert: anAccountSummaryReport value equals: 
	'Entrada por transferencia de 100.', String newLineString , 'Balance = 100' .! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:26'!
test05ReceptiveAccountWithTransferOutHasValidAccountSummary

	| anAccount aTransferingAccount anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	aTransferingAccount := ReceptiveAccount new.

	Transfer register: 100 from: aTransferingAccount to: anAccount.

	anAccountSummaryReport := AccountSummaryReport for: aTransferingAccount.

	self assert: anAccountSummaryReport value equals: 
	'Salida por transferencia de 100.', String newLineString , 'Balance = -100' .! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:34'!
test06ReceptiveAccountWithAllPossibleTransactionsHasValidAccountSummary

	| anAccount anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	self registerAllTransactionsIn: anAccount .

	anAccountSummaryReport := AccountSummaryReport for: anAccount.

	self assert: anAccountSummaryReport value equals: self accountSummaryForAllTransactions. ! !

!AccountReportTest methodsFor: 'test' stamp: 'mr 10/26/2019 19:32:46'!
test07EmptyPortfolioHasEmptyAccountSummary

	| aPortfolio anAccountSummaryReport |

	aPortfolio := Portfolio new.
	
	anAccountSummaryReport := AccountSummaryReport for: aPortfolio.

	self assert: anAccountSummaryReport value equals: 'Balance = 0'.! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:26:45'!
test08PortfolioWithOneReceptiveAccountHasTheAccountSummary

	| anAccount aPortfolio anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	self registerAllTransactionsIn: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: anAccount.

	anAccountSummaryReport := AccountSummaryReport for: aPortfolio.

	self assert: anAccountSummaryReport value equals: self accountSummaryForAllTransactions.! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:30:19'!
test09PortfolioWithManyReceptiveAccountsHasTheAccountsSummary

	| anAccount aTransferingAccount aPortfolio anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	aTransferingAccount := self registerAllTransactionsIn: anAccount .

	aPortfolio := Portfolio new.
	aPortfolio add: anAccount.
	aPortfolio add: aTransferingAccount.

	anAccountSummaryReport := AccountSummaryReport for: aPortfolio.

	self assert: anAccountSummaryReport value equals: 
	'Depósito por 50.', String newLineString ,
	'Extracción por 25.', String newLineString ,
	'Entrada por transferencia de 100.', String newLineString ,
	'Salida por transferencia de 10.', String newLineString ,
	'Salida por transferencia de 100.', String newLineString ,
	'Entrada por transferencia de 10.', String newLineString ,
	'Balance = 25'.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:29:51'!
test10PortfolioWithPortfolioWithReceptiveAccountsHasTheAccountsSummary

	| anAccount aPortfolio anotherPortfolio anAccountSummaryReport |
	
	anAccount := ReceptiveAccount new.
	self registerAllTransactionsIn: anAccount .

	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount.

	aPortfolio := Portfolio new.
	aPortfolio add: anotherPortfolio.

	anAccountSummaryReport := AccountSummaryReport for: aPortfolio.

	self assert: anAccountSummaryReport value equals: 
	'Depósito por 50.', String newLineString ,
	'Extracción por 25.', String newLineString ,
	'Entrada por transferencia de 100.', String newLineString ,
	'Salida por transferencia de 10.', String newLineString ,
	'Balance = 115'.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:27:10'!
test11EmptyReceptiveAccountHasEmptyNetTransferReport

	| anAccount aTransferReport |
	
	anAccount := ReceptiveAccount new.
	
	aTransferReport := NetTransferReport for: anAccount .

	self assert: aTransferReport value equals: 'Neto de transferencia = 0'.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:35:02'!
test12ReceptiveAccountWithTransferInHasValidNetTransferReport

	| anAccount aTransferingAccount aTransferReport |

	anAccount := ReceptiveAccount new.
	aTransferingAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: aTransferingAccount to: anAccount.

	aTransferReport := NetTransferReport for: anAccount .

	self assert: aTransferReport value equals: (self netTransferReportFor: 100).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:35:31'!
test13ReceptiveAccountWithTransferOutHasValidNetTransferReport

	| anAccount aTransferingAccount aTransferReport |

	anAccount := ReceptiveAccount new.
	aTransferingAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: aTransferingAccount to: anAccount.

	aTransferReport := NetTransferReport for: aTransferingAccount .

	self assert: aTransferReport value equals: (self netTransferReportFor: -100).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:36:27'!
test14ReceptiveAccountWithDepositHasValidNetTransferReport

	| anAccount aTransferReport |

	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.

	aTransferReport := NetTransferReport for: anAccount .

	self assert: aTransferReport value equals: (self netTransferReportFor: 0).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:37:00'!
test15ReceptiveAccountWithWithdrawHasValidNetTransferReport

	| anAccount aTransferReport |

	anAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anAccount.

	aTransferReport := NetTransferReport for: anAccount .

	self assert: aTransferReport value equals: (self netTransferReportFor: 0).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:37:24'!
test16ReceptiveAccountWithAllTransactionsHasValidNetTransferReport

	| anAccount aTransferReport |
	
	anAccount := ReceptiveAccount new.
	self registerAllTransactionsIn: anAccount .

	aTransferReport := NetTransferReport for: anAccount .

	self assert: aTransferReport value equals: (self netTransferReportFor: 90).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:38:00'!
test17EmptyPortfolioHasValidNetTransferReport

	| aPortfolio aTransferReport |

	aPortfolio := Portfolio new.
	
	aTransferReport := NetTransferReport for: aPortfolio.

	self assert: aTransferReport value equals: (self netTransferReportFor: 0).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:39:58'!
test18PortfolioWithOneReceptiveAccountHasValidNetTransferReport

	| anAccount aPortfolio aTransferReport |
	
	anAccount := ReceptiveAccount new.
	self registerAllTransactionsIn: anAccount .

	aPortfolio := Portfolio new.
	aPortfolio  add: anAccount.

	aTransferReport := NetTransferReport for: aPortfolio.

	self assert: aTransferReport value equals: (self netTransferReportFor: 90).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 20:41:10'!
test19PortfolioWithManyReceptiveAccountsHasValidNetTransferReport

	| anAccount aTransferingAccount aPortfolio aTransferReport |
	
	anAccount := ReceptiveAccount new.
	aTransferingAccount := self registerAllTransactionsIn: anAccount .

	aPortfolio := Portfolio new.
	aPortfolio add: anAccount.
	aPortfolio add: aTransferingAccount.
	
	aTransferReport := NetTransferReport for: aPortfolio.

	self assert: aTransferReport value equals: (self netTransferReportFor: 0).
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 17:21:15'!
test20ReceptiveAccountHasNameOfAccountInAccountStructureReport

	| anAccount  aStructureReport |
	
	anAccount := ReceptiveAccount named: 'Cuenta de Dago'.
	
	aStructureReport := AccountStructureReport for: anAccount .

	self assert: aStructureReport value equals: 'Cuenta de Dago'.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 17:19:57'!
test21EmptyPortfolioHasNameOfPortfolioInAccountStructureReport

	| aPortfolio  aStructureReport |
	
	aPortfolio := Portfolio named: 'Portfolio de Dago'.
	
	aStructureReport := AccountStructureReport for: aPortfolio .

	self assert: aStructureReport value equals: 'Portfolio de Dago'.
! !

!AccountReportTest methodsFor: 'test' stamp: 'dr 10/27/2019 17:25:17'!
test22PortfolioWithOneReceptiveAccountHasNameOfPortfolioAndReceptiveAccountInAccountStructureReport

	| aPortfolio  aStructureReport aReceptiveAccount |
	
	aPortfolio := Portfolio named: 'Portfolio de Dago'.
	
	aReceptiveAccount := ReceptiveAccount named: 'Cuenta 1'.
	aPortfolio add: aReceptiveAccount .
	
	aStructureReport := AccountStructureReport for: aPortfolio .

	self assert: aStructureReport value equals: 'Portfolio de Dago', String newLineString ,  '    Cuenta 1'.	
! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:18:12'!
test01TransferChangeBalanceOfSender

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: anAccount balance equals: 50.
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:18:04'!
test02TransferChangeBalanceOfReceiver

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: anotherAccount balance equals: 150.
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:28:30'!
test03TransferCannotTransferZero

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	self 
		should: [ Transfer register: 0 from: anAccount to: anotherAccount . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorMessage equals: anError messageText.
			self assert: anAccount  balance equals: 100.
			self assert: anotherAccount balance equals: 100.
			]

	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:38:44'!
test04TransferCannotStealFromTheReceiver

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	self 
		should: [ Transfer register: -50 from: anAccount to: anotherAccount . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferNegativeAmountErrorMessage equals: anError messageText.
			self assert: anAccount  balance equals: 100.
			self assert: anotherAccount balance equals: 100.
			]

	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:21:22'!
test05TransferCannotBeToYourself

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	self 
		should: [ Transfer register: 50 from: anAccount to: anAccount . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToYourselfErrorMessage equals: anError messageText.
			self assert: anAccount  balance equals: 100.
			]

	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:20:24'!
test06TransferIsRegisteredInSender

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: anAccount transactions includes: aTransfer transferOut
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:24:14'!
test07TransferIsRegisteredInReceiver

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: anotherAccount transactions includes: aTransfer transferIn
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:26:05'!
test08SenderAccountHasRegisteredTransferOut

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: ( anAccount hasRegistered: aTransfer transferOut ).
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:26:39'!
test09ReceiverAccountHasRegisteredTransferIn

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert: ( anotherAccount hasRegistered: aTransfer transferIn ).
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'Dr 10/24/2019 15:11:14'!
test10TransferOutHasKnowledgeOfTransferIn

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert:  aTransfer transferIn transferOut equals: aTransfer transferOut .
	

	
	

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'Dr 10/24/2019 15:12:08'!
test11TransferInHasKnowledgeOfTransferOut

	| anAccount anotherAccount aTransfer |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount .
	
	aTransfer := Transfer register: 50 from: anAccount to: anotherAccount .
	
	self assert:  aTransfer transferOut transferIn equals: aTransfer transferIn .
	

	
	

	! !


!TransferTest methodsFor: 'test - private' stamp: 'mr 10/21/2019 19:20:53'!
addAccountWith: anAmount to: aPortfolio 
	
	| anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: anAmount on: anAccount .
	
	aPortfolio add: anAccount .
	^aPortfolio .! !



!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'mr 10/26/2019 20:03:43'!
forEachTransactionsDo: aClosureToRun andInjectInto: anAccumulator

	^ self transactions inject: anAccumulator into: aClosureToRun.! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'dr 10/27/2019 16:46:19'!
initializeNamed: aName

	name := aName .! !


!Account methodsFor: 'accesing' stamp: 'dr 10/27/2019 16:47:01'!
name

	^ name .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'dr 10/27/2019 16:44:49'!
named: aName
	
	^ self new initializeNamed: aName .! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'dr 10/28/2019 15:04:20'!
forEachAccountInject: aReport into: aClosureToRun withDepth: aDepth

	| reportExtended |
	
	reportExtended := aClosureToRun value: aReport value: self value: aDepth.
	
	accounts inject: reportExtended into: [:report :anAccount | anAccount forEachAccountInject: report into: aClosureToRun withDepth: aDepth + 1].
	
	^ reportExtended.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'mr 10/21/2019 19:59:47'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'dr 10/28/2019 15:07:17'!
forEachAccountInject: aReport into: aClosureToRun withDepth: aDepth

	^ aClosureToRun value: aReport value: self value: aDepth.! !


!classDefinition: #AccountReport category: #'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'mr 10/26/2019 19:04:38'!
initializeFor: anAccount
	
	account := anAccount.! !


!AccountReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:50:52'!
forDeposit: aDeposit

	self subclassResponsibility.! !

!AccountReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:51:26'!
forTransferIn: aTransferIn

	self subclassResponsibility.! !

!AccountReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:51:35'!
forTransferOut: aTransferOut

	self subclassResponsibility.! !

!AccountReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:51:10'!
forWithdraw: aWithdraw

	self subclassResponsibility.! !


!AccountReport methodsFor: 'value' stamp: 'mr 10/26/2019 19:03:27'!
value

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: #'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance initialization' stamp: 'mr 10/26/2019 19:04:19'!
for: anAccount

	^ self new initializeFor: anAccount.! !


!classDefinition: #AccountStructureReport category: #'Portfolio-Solucion'!
AccountReport subclass: #AccountStructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountStructureReport methodsFor: 'transactions description' stamp: 'dr 10/27/2019 16:55:05'!
forDeposit: aDeposit

! !

!AccountStructureReport methodsFor: 'transactions description' stamp: 'dr 10/27/2019 16:55:22'!
forTransferIn: aTransferIn

! !

!AccountStructureReport methodsFor: 'transactions description' stamp: 'dr 10/27/2019 16:55:29'!
forTransferOut: aTransferOut

! !

!AccountStructureReport methodsFor: 'transactions description' stamp: 'dr 10/27/2019 16:55:43'!
forWithdraw: aWithdraw

! !


!AccountStructureReport methodsFor: 'value' stamp: 'dr 10/28/2019 15:02:27'!
add: anAccount toReport: report withIndentationDepth: depth

	^ report, (self tabTimes: depth), anAccount name.
	! !

!AccountStructureReport methodsFor: 'value' stamp: 'dr 10/28/2019 14:39:34'!
tabTimes: depth

	| tabs |
	
	tabs := String new.

	depth timesRepeat: [ tabs := tabs, '    ' ].
	
	^ tabs.! !

!AccountStructureReport methodsFor: 'value' stamp: 'dr 10/28/2019 14:42:28'!
value
	
	^ account forEachAccountInject: String new into: [ :report :anAccount :depth | self add: anAccount toReport: report withIndentationDepth: depth ] withDepth: 0.  
	! !



!classDefinition: #AccountSummaryReport category: #'Portfolio-Solucion'!
AccountReport subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!AccountSummaryReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:22:53'!
forDeposit: aDeposit

	^ 'Depósito por ', aDeposit value asString, '.'.! !

!AccountSummaryReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:41:35'!
forTransferIn: aTransferIn

	^ 'Entrada por transferencia de ', aTransferIn value asString, '.'.! !

!AccountSummaryReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:41:55'!
forTransferOut: aTransferOut

	^ 'Salida por transferencia de ', aTransferOut value asString, '.'.! !

!AccountSummaryReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:42:25'!
forWithdraw: aWithdraw

	^ 'Extracción por ', aWithdraw value asString, '.'.! !

!AccountSummaryReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 20:12:21'!
transactionsDescriptions
	
	^ account forEachTransactionsDo:  [ :report : aTransaction | report, (aTransaction reportInfoFor: self), 
										     String newLineString ] 
				andInjectInto: String new .
	! !


!AccountSummaryReport methodsFor: 'value' stamp: 'mr 10/26/2019 20:14:34'!
value

	^ self transactionsDescriptions, self balanceDescription.! !


!AccountSummaryReport methodsFor: 'balance description' stamp: 'mr 10/26/2019 20:14:08'!
balanceDescription

	^ 'Balance = ', account balance asString.! !


!classDefinition: #NetTransferReport category: #'Portfolio-Solucion'!
AccountReport subclass: #NetTransferReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!NetTransferReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:39:48'!
forDeposit: aDeposit

	^ 0.! !

!NetTransferReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:40:38'!
forTransferIn: aTransferIn

	^ aTransferIn value.! !

!NetTransferReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:40:55'!
forTransferOut: aTransferOut

	^ aTransferOut value negated.! !

!NetTransferReport methodsFor: 'transactions description' stamp: 'mr 10/26/2019 19:40:00'!
forWithdraw: aWithdraw

	^ 0.! !


!NetTransferReport methodsFor: 'value' stamp: 'dr 10/28/2019 14:52:44'!
value
	
	^ 'Neto de transferencia = ', self netTransfer asString.! !


!NetTransferReport methodsFor: 'net transfer' stamp: 'mr 10/26/2019 20:10:11'!
netTransfer

	^(account forEachTransactionsDo: [ :amount :aTransaction | amount + (aTransaction  
																	reportInfoFor: self) ] 
											andInjectInto: 0).! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'mr 10/26/2019 19:17:08'!
reportInfoFor: aReport
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'mr 10/26/2019 19:16:52'!
reportInfoFor: aReport
	
	^ aReport forDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferIn
	instanceVariableNames: 'mainTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferIn methodsFor: 'accesing' stamp: 'Dr 10/24/2019 15:13:32'!
transferOut
	
	^ mainTransfer transferOut .! !


!TransferIn methodsFor: 'balance' stamp: 'mr 10/21/2019 20:15:30'!
affectBalance: aBalance

	^ aBalance + mainTransfer value.! !


!TransferIn methodsFor: 'initialization' stamp: 'mr 10/21/2019 20:14:08'!
initializeFor: aMainTransfer

	mainTransfer  := aMainTransfer .! !


!TransferIn methodsFor: 'report' stamp: 'mr 10/26/2019 19:18:03'!
reportInfoFor: aReport
	
	^ aReport forTransferIn: self.! !


!TransferIn methodsFor: 'value' stamp: 'mr 10/21/2019 20:49:31'!
value

	^ mainTransfer  value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferIn class' category: #'Portfolio-Solucion'!
TransferIn class
	instanceVariableNames: ''!

!TransferIn class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:11:09'!
for: aMainTransfer

	^ self new initializeFor: aMainTransfer .! !


!classDefinition: #TransferOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferOut
	instanceVariableNames: 'mainTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferOut methodsFor: 'accesing' stamp: 'Dr 10/24/2019 15:14:12'!
transferIn
	
	^ mainTransfer transferIn .! !


!TransferOut methodsFor: 'balance' stamp: 'mr 10/21/2019 20:15:45'!
affectBalance: aBalance

	^ aBalance - mainTransfer value.! !


!TransferOut methodsFor: 'initialization' stamp: 'mr 10/21/2019 20:14:00'!
initializeFor: aMainTransfer

	mainTransfer  := aMainTransfer .! !


!TransferOut methodsFor: 'report' stamp: 'mr 10/26/2019 19:18:23'!
reportInfoFor: aReport
	
	^ aReport forTransferOut: self.! !


!TransferOut methodsFor: 'value' stamp: 'mr 10/21/2019 20:49:38'!
value

	^ mainTransfer  value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOut class' category: #'Portfolio-Solucion'!
TransferOut class
	instanceVariableNames: ''!

!TransferOut class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:12:02'!
for: aMainTransfer

	^ self new initializeFor: aMainTransfer .! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'Dr 10/24/2019 15:10:53'!
affectBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'mr 10/26/2019 16:45:12'!
reportMessage

	^ 'Extracción por ', value asString, '.'.! !


!Withdraw methodsFor: 'report' stamp: 'mr 10/26/2019 19:18:48'!
reportInfoFor: aReport
	
	^ aReport forWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value transferIn transferOut'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:09:59'!
initializeWith: anAmount from: aSender to: aReceiver

	value := anAmount .
	transferOut := TransferOut for: self.
	transferIn  := TransferIn for: self.
	
	aSender register: transferOut.
	aReceiver register: transferIn.
	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:10:03'!
transferIn

	^ transferIn ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:10:12'!
transferOut

	^ transferOut ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:16:42'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:32:30'!
cannotTransferNegativeAmountErrorMessage

	^ 'Stop trying to steal, the bank will file a report '! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:53:06'!
cannotTransferToYourselfErrorMessage
	
	^ 'You cannot transfer to the same account '! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 20:30:45'!
cannotTransferZeroErrorMessage

	^ 'You cannot transfer zero '! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'mr 10/21/2019 21:22:27'!
register: anAmount from: aSender to: aReceiver
	
	anAmount = 0 ifTrue: [ self error: self cannotTransferZeroErrorMessage ].
	anAmount < 0 ifTrue: [ self error: self cannotTransferNegativeAmountErrorMessage ].
	aSender = aReceiver ifTrue: [ self error: self cannotTransferToYourselfErrorMessage ].
	
	^ self new initializeWith: anAmount from: aSender to: aReceiver.
! !
