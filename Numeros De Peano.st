!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'basic' stamp: 'ja 9/16/2020 13:46:51'!
next

	^ self createChildNamed: self name , 'I'.! !

!I class methodsFor: 'basic' stamp: 'ja 9/16/2020 14:01:19'!
previous
	
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !


!I class methodsFor: 'operator' stamp: 'ja 9/15/2020 16:00:21'!
* aNumber
	^ aNumber! !

!I class methodsFor: 'operator' stamp: 'ja 9/16/2020 13:46:51'!
+ aNumber 
	
	^aNumber next! !

!I class methodsFor: 'operator' stamp: 'ja 9/16/2020 13:59:54'!
- aNumber
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'operator' stamp: 'ja 9/16/2020 12:00:15'!
/ aNumber
	^ aNumber siSoyUnoRetornoUnoSiNoError.! !


!I class methodsFor: 'private' stamp: 'ja 9/16/2020 11:47:48'!
< aNumber
	^aNumber parents includes: self.! !

!I class methodsFor: 'private' stamp: 'ja 9/16/2020 11:52:06'!
= aNumber
	^ self name = aNumber name.! !

!I class methodsFor: 'private' stamp: 'ja 9/16/2020 14:03:59'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'private' stamp: 'ja 9/16/2020 14:00:34'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Peano no soporta negativos!!'.! !

!I class methodsFor: 'private' stamp: 'ja 9/16/2020 11:26:49'!
siSoyUnoRetornoUnoSiNoError
	^self.! !

!I class methodsFor: 'private' stamp: 'ja 9/16/2020 10:29:58'!
substractOf: aNumber
	^aNumber previous.! !


!classDefinition: #II category: #'Numeros De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'basic' stamp: 'ja 9/16/2020 10:28:16'!
previous

	^self parent.! !


!II class methodsFor: 'operator' stamp: 'ja 9/15/2020 15:53:42'!
* aNumber
	^ aNumber + (self previous * aNumber).! !

!II class methodsFor: 'operator' stamp: 'ja 9/16/2020 13:47:52'!
+ aNumber 

	^self previous + aNumber next.! !

!II class methodsFor: 'operator' stamp: 'ja 9/16/2020 14:01:42'!
- aNumber 
	
	" La idea de la resta es hacer previous cantidad de aNumber veces"
	^aNumber substractOf: self. ! !

!II class methodsFor: 'operator' stamp: 'ja 9/16/2020 14:02:15'!
/ aNumber
	self < aNumber 
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] 
		ifFalse: [ self = aNumber 
					ifTrue: [ ^I ] 
					ifFalse: [ ^ ((self - aNumber) / aNumber) next ] ]! !


!II class methodsFor: 'private' stamp: 'ja 9/16/2020 14:05:57'!
siSoyUnoRetornoUnoSiNoError
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!II class methodsFor: 'private' stamp: 'ja 9/16/2020 10:29:38'!
substractOf: aNumber
	
	^self previous substractOf: aNumber previous.! !


!classDefinition: #III category: #'Numeros De Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIII category: #'Numeros De Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIII category: #'Numeros De Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIII category: #'Numeros De Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #TestNumerosDePeano category: #'Numeros De Peano'!
DenotativeObject subclass: #TestNumerosDePeano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestNumerosDePeano class' category: #'Numeros De Peano'!
TestNumerosDePeano class
	instanceVariableNames: ''!

!TestNumerosDePeano class methodsFor: 'as yet unclassified' stamp: 'ja 9/15/2020 16:23:27'!
test01SucesorDeIEsII

	Assert that: I successor isEqualTo: II.! !
