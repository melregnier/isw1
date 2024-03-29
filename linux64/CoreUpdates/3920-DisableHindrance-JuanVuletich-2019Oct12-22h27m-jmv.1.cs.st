'From Cuis 5.0 [latest update: #3916] on 12 October 2019 at 10:29:16 pm'!

!ProgressInitiationException methodsFor: 'exceptionDescription' stamp: 'jmv 9/5/2019 17:41:17'!
defaultAction

	| delta textFrame barFrame outerFrame result range width filledWidth f h textWidth textForm innerBarFrame oldFilledWidth oldFilledWidth2 prevContents |
	f _ AbstractFont default.
	h _ f lineSpacing * 3//2.
	textWidth _ (f widthOfString: progressTitle) + h.
	width _ 150 max: textWidth.

	textForm _ Form extent: width@h depth: 32.
	textForm fillBlack.
	textForm fillWhite: (textForm boundingBox insetBy: 2).
	progressTitle displayOn: textForm at: (width-textWidth+h//2@4).
	barFrame _ Rectangle center: aPoint extent: width@h.
	textFrame _ `0@0` extent: width@h.
	textFrame _ textFrame
					aligned: textFrame bottomCenter
					with: barFrame topCenter + `0@2`.
	outerFrame _ barFrame merge: textFrame.
	delta _ outerFrame amountToTranslateWithin: Display boundingBox.
	barFrame _ barFrame translatedBy: delta.
	textFrame _ textFrame translatedBy: delta.
	outerFrame _ outerFrame translatedBy: delta.
	prevContents _ Form fromDisplay: outerFrame.
	range _ maxVal = minVal ifTrue: [1] ifFalse: [maxVal - minVal].  "Avoid div by 0"
	innerBarFrame _ barFrame insetBy: 2.
	textForm displayAt: textFrame topLeft.
	Display fillBlack: barFrame.
	Display fillWhite: innerBarFrame.
	oldFilledWidth _ 0.
	oldFilledWidth2 _ 0.
	result _ workBlock value:  "Supply the bar-update block for evaluation in the work block"
		[ :barVal |
		barVal
			ifNotNil: [ currentVal _ barVal ]
			ifNil: [
				currentVal _ currentVal + 1.
				currentVal >= maxVal
					ifTrue: [ currentVal _ minVal ]].
		filledWidth _ ((barFrame width-4) asFloat * ((currentVal-minVal) asFloat / range min: 1.0)) asInteger.
		filledWidth  > oldFilledWidth ifTrue: [
			textForm displayAt: textFrame topLeft.
			Display fillBlack: barFrame.
			Display fillWhite: innerBarFrame.
			Display fillGray: (barFrame topLeft + `2@2` extent: filledWidth@(h-4)).
			filledWidth -200 > oldFilledWidth2
				ifFalse: [
					"Usually just request an update, to be done asynchronously."
					DisplayScreen screenUpdateRequired: outerFrame ]
				ifTrue: [
					"Once in a while, force a real screen update (warning: really slow on MacOS if done too often)"
					Display forceToScreen: outerFrame. oldFilledWidth2 _ filledWidth ].
			oldFilledWidth _ filledWidth ]].
	prevContents displayAt: outerFrame topLeft.
	self resume: result! !

!ProgressInitiationException methodsFor: 'exceptionDescription' stamp: 'jmv 1/30/2009 15:24'!
display: argString at: argPoint from: argMinVal to: argMaxVal during: argWorkBlock

	progressTitle _ argString.
	aPoint _ argPoint.
	minVal _ argMinVal.
	maxVal _ argMaxVal.
	currentVal _ minVal.
	workBlock _ argWorkBlock.
	^self signal! !

