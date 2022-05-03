.code
getBin proc

;EAX - BIT COUNT
;EBX - CHAR
;ECX - NUMBER
;EDX - BUFFER PTR
;ESI - BUFFER COUNTER
;EDI - MASK
;R8 - LENGTH

push rbx

mov edi, 1
mov rsi, 31

measure:	test ecx, edi

				jz zero
					mov r8, 31
					sub r8, rsi
				zero: 

				dec esi
				shl edi, 1
				jl m_done

				jmp measure
m_done:

mov edi, 1
mov eax, 0

cycle:		test ecx, edi

				jz zero_case
					inc eax
					mov bl, "1"
					mov [rdx + r8], bl
				jmp one
					zero_case: 
					mov bl, "0"
					mov [rdx + r8], bl

					one:	  
					shl edi, 1

						dec r8
						jl fin

					jmp cycle

fin:			pop rbx	
				ret

getBin endp
end