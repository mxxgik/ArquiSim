# Ejercicio 3 -- Multiplicar y dividir con desplazamientos
# Instrucciones: sll, srl, sra, add, sub, addi
#
# Con x = 37 en $s0, calcule SIN mult (solo desplazamientos, sumas y restas):
#   $s1 = 10x        pista: 10x = 8x + 2x
#   $s2 = 7x
# Con y = -20 en $s3 y z = -7 en $s4:
#   $s5 = y sra 2
#   $s6 = y srl 2
#   $s7 = z sra 1
#
# Preguntas: ¿por qué $s6 da un número enorme? ¿Hacia dónde redondea sra (-7/2)?
#
# Complete ej3_desplazamientos.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej3_desplazamientos.asm
.text
        addi $s0, $zero, 37         # x
        addi $s3, $zero, -20        # y
        addi $s4, $zero, -7         # z
# escriba aquí su código
# --- 10x = 8x + 2x ---
        sll  $t0, $s0, 3            # 8x = 296
        sll  $t1, $s0, 1            # 2x = 74
        add  $s1, $t0, $t1          # $s1 = 10x = 370

# --- 7x = 4x + 2x + x ---
        sll  $t2, $s0, 2            # 4x = 148
        sll  $t3, $s0, 1            # 2x = 74
        add  $t4, $t2, $t3          # 6x = 222
        add  $s2, $t4, $s0          # $s2 = 7x = 259

# --- desplazamientos con signo ---
        sra  $s5, $s3, 2            # $s5 = -20 sra 2 = -5
        srl  $s6, $s3, 2            # $s6 = -20 srl 2 = 0x3FFFFFFB (enorme)
        sra  $s7, $s4, 1            # $s7 = -7 sra 1 = -4

