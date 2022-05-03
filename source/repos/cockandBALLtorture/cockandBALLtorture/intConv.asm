.data
chars db "0123456789", 0
.code
intConv proc

;EAX - INTEGER
;EBX - [NOT USED]
;ECX - BUFFER POINTER
;EDX - CHARACTER
;ESI - 10 (CONSTANT)
;EDI - SAMPLE POINTER
;R8 - BUFFER COUNTER
;R9 - SAMPLE COUNTER
;R10 - NEGATIVE INDICATOR

lea rdi, chars
mov esi, 10
mov rax, 0
mov r8, 0
mov r10, 0

mov dl, [rcx]
cmp dl, "-"
jne positive
inc r8
mov r10, 1
positive:

measure:	mov dl, [rcx + r8]
				mov r9, 9

				comp:			cmp dl, [rdi + r9]
									je c_done
									dec r9
									jl m_done
									jmp comp
				c_done:

				mul esi				
				add rax, r9

				inc r8
				jmp measure
m_done:	

dec r10
jne fin
		mov edx, 0
		sub edx, eax
		mov eax, edx

fin:			ret

intConv endp
end