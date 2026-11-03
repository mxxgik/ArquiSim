# Ejercicio 2 -- Constantes de 32 bits y máscaras
# Instrucciones: lui, ori, addi, and, andi, or, xor, xori, nor, srl
#
# 1. Cargue x = 0x12345678 en $s0 (con lui + ori).
# 2. $s1 = los bits 11..8 de x, como número de 0 a 15.
# 3. $s2 = x con el bit 3 apagado (los demás bits iguales).
#    Ojo: andi extiende el inmediato con CEROS; arme la máscara en un registro.
# 4. $s3 = x con el byte bajo (bits 7..0) invertido.
# 5. Ya está escrito al final: prediga el valor de $s4 y de $s5 antes de ejecutar.
#
# Preguntas: ¿por qué $s4 no es 0xDEADBEEF? ¿Por qué el paso 3 no sirve con andi?
#
# Complete ej2_mascaras.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej2_mascaras.asm
.text
# escriba aquí los pasos 1 a 4
# 1. x = 0x12345678
        lui  $s0, 0x1234            # $s0 = 0x12340000
        ori  $s0, $s0, 0x5678       # $s0 = 0x12345678

# 2. bits 11..8 de x como número de 0 a 15
        srl  $t0, $s0, 8            # baja los bits 11..8 a la posición 3..0
        andi $s1, $t0, 0xF          # se queda solo con esos 4 bits

# 3. x con el bit 3 apagado
        addi $t1, $zero, 8          # $t1 = 0x00000008 (solo el bit 3)
        nor  $t1, $t1, $zero        # $t1 = 0xFFFFFFF7 (todos menos el bit 3)
        and  $s2, $s0, $t1          # apaga el bit 3, conserva el resto

# 4. x con el byte bajo invertido
        xori $s3, $s0, 0xFF         # XOR con 1 invierte; con 0 conserva


# ---------------- Paso 5 (no lo modifique) ----------------
        lui  $s4, 0xDEAD
        addi $s4, $s4, 0xBEEF       # ¿qué valor queda?
        andi $s5, $s0, 0xFFF7       # ¿es lo mismo que el paso 3?
