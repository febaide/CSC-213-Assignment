.data
  inputA:   .asciiz  "enter the value of a::\n"
  inputB:   .asciiz  "enter the value of b::\n"
  inputC:   .asciiz  "enter the value of c::\n"
  number4:  .float  4.0
  number2:  .float 2.0
  numberzero: .float 0
  x1: .asciiz "the value of x1 is::   \n"
 x2: .asciiz "the value of x2 is ::   \n"
 comroot: .asciiz "this is a complex root\n"

.text
main:
li $v0, 4
la $a0, inputA
syscall

li $v0, 6
syscall
mov.s $f1, $f0   # $f1 is holding the value of a

li $v0, 4
la $a0, inputB
syscall

li $v0, 6
syscall
mov.s $f2, $f0    # $f2 is holding the value of b

li $v0, 4
la $a0, inputC
syscall

li $v0, 6
syscall
mov.s $f3, $f0     # $f3 is holding the value of c

# this is computing b^2
mul.s $f4, $f2, $f2 
# storing 4.0 into  $f5
lwc1 $f5, number4
lwc1 $f6, number2
lwc1 $f7, numberzero
# this is computing 4*a*c
mul.s $f8, $f5, $f1
mul.s $f8, $f8, $f3
# this is computing b^2 -4*a*c
sub.s $f9, $f4,$f8    # $f9 is holding D
mfc1 $t1, $f9
mfc1 $t2, $f7
blt $t1, $t2, complex
# this is computing the sqrt
sqrt.s $f10, $f9
 
 #turning b into -b
 sub.s $f11, $f7, $f2
 
 #this is for 2*a
 mul.s $f11, $f6, $f1
 
 # this is for x1
 add.s $f16, $f11, $f10   # -b + sqrt(D)
 div.s $f13, $f16, $f11
 
 
 # this is for x2
 sub.s $f14,$f11, $f10   #-b - sqrt(D)
 div.s $f15, $f14, $f11
   
   
   
   # this are printing out x1 and x2
 li $v0, 4
 la $a0, x1
 syscall
 
 mov.s $f12, $f13
 li $v0, 2
 syscall
 
  li $v0, 4
 la $a0, x2
 syscall
 
 mov.s $f12, $f15
 li $v0, 2
 syscall
 
 
 b end
 


complex:
 li $v0, 4
 la $a0, comroot
 syscall 
 b end


end:
li $v0, 10
syscall