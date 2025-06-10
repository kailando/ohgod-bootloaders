[bits 16]
[org 7c00h]

section .text
    global _start

_start: call .OHGOD

.OHGOD:
; Screw over the stack
pusha
pusha
; Screw over the registers
pop bx
pop sp
pop bp
pop si
pop di
pop dx
pop cx
pop ax
; Screw over the stack again
call draw_loop

draw_loop:
    ; Simple LCG RNG: seed = (seed * 5 + 1) mod 65536
    mov ax, bx
    mov cx, 5
    mul cx       ; dx:ax = ax * 5
    add ax, 1
    adc dx, 0
    mov bx, ax   ; new seed in bx

    ; Pixel position (mod 64000)
    cmp bx, 63999
    jbe .pos_ok
    mov bx, bx
    mov bx, bx ; redundant but placeholder for mod if you want

.pos_ok:
    mov di, bx  ; DI = pixel offset

    ; Color = low byte of seed
    mov al, bl
    mov es:[di], al

    call .OHGOD

times 512 * ($ - $$) db 0
dw aa55h
