.data

size1				dq ?
size2				dq ?
scale				dq ?
step1Scaled	dq ?
step2Scaled	dq ?
columnReturn dq ?

;mat1	R10
;mat2	R11
;res		R12

;R14 = SIZE2

.code
asmMatrixMul proc

push rbx
push r12
push r13
push r14

;LOAD ARGUMENTS FROM REGS
mov r10, rcx
mov r11, rdx
sub r11, 4
mov columnReturn, r11
mov r12, r8
mov size1, r9

; LOAD ARGUMENTS FROM STACK
mov ecx,  [rsp + 32 + 5*8]
mov eax, [rsp  + 32 + 6*8]
mov scale, rcx
mov size2, rax

mov r14, rax

shl rax, 2
mov step2Scaled, rax
mov rax, scale
shl rax, 2
mov step1Scaled, rax

sub r10, step1Scaled 
mov rbx, -1

;RBX: PRODUCT WIDTH COUNTER
;RCX: PRODUCT HEIGHT COUNTER
;R14: LINEAR COMBINATION SUM COUNTER

;MOVE TO NEXT ROW
jumprow:
inc rbx
cmp rbx, size1
je finished

;MOVE POINTER1
add r10, step1Scaled

mov rcx, -1
mov r11, columnReturn

;MOVE TO NEXT COLUMN
jumpcol:
inc rcx
cmp rcx, size2
je jumprow

;MOVE POINTER2
add r11, 4

;GETTING ADDRESSES

mov rax, rbx
mul size2
add rax, rcx
shl rax, 2
add rax, r12
mov r9, rax
mov rsi, 0

mov r8, r10
mov r13, r11

mov r14, -1

;MAKE UP LINEAR COMBINATION
sumcycle:
inc r14
cmp r14, scale

jl continue
mov [r9], esi
jmp jumpcol

continue:

; R8: FIRST MATRIX POINTER
; R13: SECOND MATRIX POINTER
; ESI: CURRENT SUM
; EDI: MULTIPLIERS
; R9: RESULT ADDRESS

	mov eax, [r8]
	mov edi, [r13]
	imul edi
	add esi, eax

	add r8, 4
	add r13, step2Scaled

jmp sumcycle

finished:		
mov rax, scale

pop r14
pop r13
pop r12
pop rbx

ret
	asmMatrixMul endp
end