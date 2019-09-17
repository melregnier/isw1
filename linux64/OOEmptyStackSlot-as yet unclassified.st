'From Cuis 5.0 [latest update: #3839] on 16 September 2019 at 9:16:11 pm'!


!OOEmptyStackSlot methodsFor: 'as yet unclassified' stamp: 'dr 9/16/2019 20:49:15'!
pop

	^ self error: OOStack stackEmptyErrorDescription ! !

!OOEmptyStackSlot methodsFor: 'as yet unclassified' stamp: 'dr 9/16/2019 20:50:29'!
push: anElement

	^ OONotEmptyStackSlot with: anElement withNext: self! !
