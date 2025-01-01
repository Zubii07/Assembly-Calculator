[ORG 0x100]
jmp start


clrscr:
	push es
	push ax
	push di 
	
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	
next:
	mov word[es: di], 0x0720
	add di, 2
	cmp di, 4000
	jne next
	
	pop di
	pop ax
	pop es
	ret
	
	

	

start:
		call clrscr
		mov ax, 0x4c00
		int 0x21
