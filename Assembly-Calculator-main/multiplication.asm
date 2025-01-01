[ORG 0x100]
jmp start
multiplication: dw 10, 10
result: dw 0

multiplyNumber:
		push bp
		mov bp, sp
		mov ax, 0
		push si 

		mov si, [bp + 4]
		mov ax, [si]
		mul word[si + 2]
		mov [result], ax
		pop si
		pop bp
		ret

printNum:
		push bp
		mov bp, sp
		push es
		push ax
		push bx
		push cx
		push dx
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		mov ax, [bp + 4]
		mov bx, 10
		mov cx, 0
		
next: 		
		xor dx, dx
		div bx
		add dl, 0x30
		push dx
		inc cx
		cmp ax, 0
		jnz next
		
		xor di, di
		
nextProc:	
		pop dx
		mov dh, 0x07
		mov [es:di], dx
		add di, 2
		loop nextProc
		
		pop di
		pop dx
		pop cx
		pop bx
		pop ax
		pop es
		pop bp
		ret 2
		
	

start:
		mov ax, multiplication
		push ax
		call multiplyNumber
		mov ax, [result]
		push ax
		call printNum
		mov ax, 0x4c00
		int 0x21
