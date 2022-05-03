.data
const_zero dq 0.0
const_half dq 0.5
const_one dq 1.0
const_two dq 2.0

.code
approx proc

;RCX - INCREASING FUNCTION

;XMM0 - ARGUMENT
;XMM1 - PRECISION
;XMM2 - UPPER EDGE
;XMM3 - LOWER EDGE
;XMM4 - MIDPOINT 
;XMM5 - FRAGMENT SIZE
;XMM6 - MIDPOINT SQ

comisd xmm0, mmword ptr [const_zero]
je null

xorps xmm3, xmm3
movsd xmm5, mmword ptr [const_one]
movsd xmm2, mmword ptr[const_one]

uplim:	movsd xmm6, xmm2
			mulsd xmm6, xmm6

			comisd xmm0, xmm6
			je upper
			jb seek

			mulsd xmm2, mmword ptr [const_two]
			mulsd xmm5, mmword ptr [const_two]
			jmp uplim

seek:	movsd xmm4, xmm2
			addsd xmm4, xmm3
			mulsd xmm4, mmword ptr [const_half]
			mulsd xmm5, mmword ptr [const_half]

			comisd xmm5, xmm1
			jbe done

			movsd xmm6, xmm4
			mulsd xmm6, xmm6

			comisd xmm6, xmm0
			je done

			jb upscale
				movsd xmm2, xmm4
			jmp seek
			upscale:
				movsd xmm3, xmm4
			jmp seek

null:		xorps xmm0, xmm0
			ret
upper:	movsd xmm0, xmm2
			ret
done:	movsd xmm0, xmm4
			ret

approx endp
end