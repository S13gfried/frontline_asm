.data
sizeDec		dq	0
sizeFull	dq	0

.code

; RCX: ARGUMENT: Array pointer
; RDX: ARGUMENT: Array size / swap variable
; RAX: Current minimum
; RBX: Current minimum index
; RSI: Cycle offset
; RDI: Cycle counter

signedIntSort proc

push rbx

mov sizeFull, rdx
dec rdx
mov sizeDec, rdx
mov rsi, -1
jmp init

cycle : mov edx, [rcx + rbx * 4]
	xchg edx, [rcx + rsi * 4]
	mov[rcx + rbx * 4], edx

init :  inc rsi
	cmp rsi, sizeDec
	jae endSort

	mov eax, [rcx + rsi * 4]
	mov rbx, rsi
	mov rdi, rsi
	jmp skipUnsign

	findMin :	add eax, 2147483648
	skipUnsign :	inc rdi
			cmp rdi, sizeFull
			jae cycle

			mov edx, [rcx + rdi * 4]
			add eax, 2147483648
			add edx, 2147483648
			cmp eax, edx

			jbe findMin
			mov rbx, rdi
			mov eax, [rcx + rdi*4]
			jmp skipUnsign

	endSort : mov rax, 0
	  pop rbx
	  ret

signedIntSort endp
end
