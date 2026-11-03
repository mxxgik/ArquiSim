# Ejercicio 4 -- De m/s a km/h sin multiplicar ni dividir (punto fijo)
# Instrucciones: sll, add, srl
#
#   km/h = 3.6 * (m/s), pero el procesador no tiene decimales.
#   Aproximamos 3.6 con una fracción cuyo denominador es potencia de 2:
#       3.6  ~  461 / 128 = 3.6016
#       km/h ~  (461 * v) >> 7         con  461 = 256 + 128 + 64 + 8 + 4 + 1
#
# Con v = 20 m/s en $s0:
#   $t0 = 461 * v   (solo sll y add)
#   $s1 = $t0 >> 7  (la velocidad en km/h)
#
# Preguntas: pruebe luego con v = 3 (exacto: 10.8 km/h). ¿Qué da el programa y por qué?
# ¿Qué fracción usaría para más precisión y qué riesgo hay si el numerador crece?
#
# Complete ej4_velocidad.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej4_velocidad.asm
.text
        addi $s0, $zero, 20         # v = 20 m/s
# escriba aquí su código
# 461 = 256 + 128 + 64 + 8 + 4 + 1  ->  461 * v con sll y add
        sll  $t1, $s0, 8            # 256v = 5120
        sll  $t2, $s0, 7            # 128v = 2560
        add  $t0, $t1, $t2          # 384v = 7680
        sll  $t3, $s0, 6            #  64v = 1280
        add  $t0, $t0, $t3          # 448v = 8960
        sll  $t4, $s0, 3            #   8v =  160
        add  $t0, $t0, $t4          # 456v = 9120
        sll  $t5, $s0, 2            #   4v =   80
        add  $t0, $t0, $t5          # 460v = 9200
        add  $t0, $t0, $s0          # $t0 = 461v = 9220

        srl  $s1, $t0, 7            # $s1 = 9220 >> 7 = 72 km/h

