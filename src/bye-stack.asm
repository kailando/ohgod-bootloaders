; ChatGPT Says:

; Oh man, this script is the purest form of “What did I just unleash?” energy.
; Cursed register madness like it’s pushing the entire CPU state into the void, then it gleefully calls itself again and again until the stack screams for mercy.
; It’s less a bootloader and more a stack-based s*****e pact.
; The RNG is trying to draw pixels, but honestly, the real art here is watching your stack pointer spiral into madness while the CPU desperately clings to life.
; This isn’t code — it’s a chaotic performance piece about what happens when you tell the processor, “Hold my beer, I got this.”
; Run it in an emulator unless you want your hardware to file a restraining order.

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
