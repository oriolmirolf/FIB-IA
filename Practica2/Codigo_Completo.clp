;NOTA: Este fichero esta dividido en dos secciones, Ontologia y Codigo.

; -----------------------------------------
; -----------------------------------------
; --------------- ONTOLOGIA ---------------
; -----------------------------------------
; -----------------------------------------

(defclass Circunstancia
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Enfermedad
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (multislot objetivo_enfermedad
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Lesion
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (multislot lesion_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Sintoma
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (multislot no_recomienda_ejercicio
         (type INSTANCE)
         (create-accessor read-write))
)

(defclass Ejercicio
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ejercita
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot requiere
        (type INSTANCE)
        (create-accessor read-write))
	(single-slot puntuacion_ejercicio
		(type INTEGER)
		(create-accessor read-write))
)

(defclass Aerobico
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
    (single-slot Duracion
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Intensidad_MET
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Calentamiento
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
    (single-slot Repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Series
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Equilibrio
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
    (single-slot Repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Series
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Estiramiento
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
	(single-slot Repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Series
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Flexibilidad
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
	(single-slot Repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Series
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Fuerza
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
    (single-slot Intensidad_RM
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (single-slot Series
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Material
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Objetivo
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot se_trabaja_con
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Usuario
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot dispone_de
        (type INSTANCE)
        (create-accessor read-write))
    (multislot sufre_de
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot Nivel
        (type SYMBOL)
		(allowed-values BAJO MEDIO_BAJO MEDIO MEDIO_ALTO ALTO)
        (create-accessor read-write))
	(single-slot Edad
        (type SYMBOL)
		(allowed-values JOVEN MEDIO EXPERIMENTADO)
        (create-accessor read-write))
	(multislot numSesiones
        (type INTEGER)
        (create-accessor read-write))
	(multislot durSesion
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Sesion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot conjunto_de
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot tiempo_restante
        (type INTEGER)
        (create-accessor read-write))
)

(defclass grupo_muscular
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot se_ejercita_con
        (type INSTANCE)
        (create-accessor read-write))
    (multislot afecta_a
        (type INSTANCE)
        (create-accessor read-write))
)

(definstances instances
    ([Canoa_y_remos] of Material
    )

    ([Colesterol_alto] of Enfermedad
		(objetivo_enfermedad [Aumentar_resistencia_o_Bajar_de_peso] [Aumentar_equilibrio])
    )

    ([Fuerza_de_Brazos_con_peso] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Brazos])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Fuerza_de_Hombros] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Hombros])
    )

    ([Extension_de_cadera] of Equilibrio
		(ejercita [Cadera_y_piernas])
    )

    ([Flexion_de_cadera] of Equilibrio
         (ejercita  [Cadera_y_piernas])
    )

    ([Flexion_de_rodilla] of Equilibrio
		(ejercita [Cadera_y_piernas])
    )

    ([Flexion_plantar] of Equilibrio
         (ejercita  [Cadera_y_piernas])
    )

    ([Tai-chi] of Equilibrio
		(ejercita [Cadera_y_piernas] [Espalda] [Hombros])
    )

    ([Levantamiento_lateral_de_pierna] of Equilibrio
         (ejercita  [Cadera_y_piernas])
    )

    ([Abdominales] of grupo_muscular
    )

    ([Acceso_a_escaleras] of Material
    )

    ([Acceso_a_una_piscina] of Material
    )

    ([Aerobic] of Aerobico
         (Intensidad_MET  6)
		(ejercita [Cadera_y_piernas] [Espalda] [Pecho])
    )

    ([Alpinismo] of Aerobico
         (Intensidad_MET  7)
		(ejercita [Cadera_y_piernas])
    )

    ([Aneurisma_disecante] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

    ([Arritmia_ventricular_no_controlada] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

	([Anginas] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Osteoporosis])
    )

    ([Artritis] of Enfermedad
		(objetivo_enfermedad [Aumentar_flexibilidad])
    )

    ([Aumentar_equilibrio] of Objetivo
		(se_trabaja_con [Extension_de_cadera] [Flexion_de_cadera] [Flexion_de_rodilla] [Flexion_plantar] [Tai-chi] [Levantamiento_lateral_de_pierna] [Caminar_con_apoyo_talon_punta] [Desplazamientos_multidireccionales_con_peso_extra] [Posicion_de_semitandem] [Posicion_de_tandem] [Transferencia_de_peso_corporal])
    )

    ([Aumentar_flexibilidad] of Objetivo
         (se_trabaja_con [Tai-chi] [Flexibilidad_de_abdominales] [Flexibilidad_de_brazos] [Flexibilidad_de_cadera_y_piernas] [Flexibilidad_de_espalda] [Flexibilidad_de_hombros] [Flexibilidad_de_pecho])
    )

    ([Aumentar_masa_muscular] of Objetivo
         (se_trabaja_con  [Fuerza_de_Brazos_con_peso] [Fuerza_de_Hombros] [Fuerza_de_Abdominales] [Fuerza_de_Abdominales_con_peso] [Fuerza_de_Brazos] [Fuerza_de_Cadera_y_piernas] [Fuerza_de_Cadera_y_piernas_con_peso] [Fuerza_de_Espalda] [Fuerza_de_Espalda_con_peso] [Fuerza_de_Hombros_con_peso] [Fuerza_de_Pecho] [Fuerza_de_Pecho_con_peso])
    )

    ([Aumentar_resistencia_o_Bajar_de_peso] of Objetivo
         (se_trabaja_con  [Aerobic] [Alpinismo] [Badminton] [Bicicleta_estatica_100w] [Bicicleta_estatica_150w] [Bicicleta_estatica_200w] [Bicicleta_estatica_50w] [Buceo_en_aguas_templadas] [Caminar_a_1.5-3_kmph] [Caminar_a_3-4.5_kmph] [Caminar_a_4.5-5.5_kmph] [Caminar_a_5-6_kmph] [Caminar_a_6-7_km_h] [Caminar_a_7.5_kmph] [Ciclismo_a_7.5_kmph] [Ciclismo_a_10-12_kmph] [Ciclismo_a_12-13_kmph] [Ciclismo_a_18_kmph] [Ciclismo_a_20_kmph] [Ciclismo_a_21_kmph] [Ciclismo_a_7.5-10kmph] [Ciclismo_a_mas_de_21_kmph] [Ciclismo_de_montaña] [Correr_a_7.5_kmph] [Correr_a_8_kmph] [Correr_a_mas_de_9_kmph] [Esqui_de_fondo] [Esqui_intenso] [Esqui_lento] [Fronton] [Gimnasia_suave] [Golf] [Natacion_moderada-rapida] [Natacion_suave] [Patinaje_intenso] [Patinaje_suave] [Pesca] [Remo_o_Canoa_a_6_kmph] [Remo_o_canoa_a_7.5_kmph] [Tenis] [Tenis_de_mesa] [Tiro_con_arco] [Vela] [Voleibol])
    )


    ([Aumento_subito_de_disnea_en_reposo] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Hipertension])
    )

    ([Badminton] of Aerobico
         (Intensidad_MET  5)
         (requiere  [Material_de_badminton])
		 (ejercita [Cadera_y_piernas] [Brazos])
    )

    ([Bicicleta] of Material
    )

    ([Bicicleta_de_montanya] of Material
    )

    ([Bicicleta_estatica] of Material
    )

    ([Bicicleta_estatica_100w] of Aerobico
         (Intensidad_MET  5)
         (requiere  [Bicicleta_estatica])
		 (ejercita [Cadera_y_piernas])
    )

    ([Bicicleta_estatica_150w] of Aerobico
         (Intensidad_MET  6)
         (requiere  [Bicicleta_estatica])
		 (ejercita [Cadera_y_piernas])
    )

    ([Bicicleta_estatica_200w] of Aerobico
         (Intensidad_MET  9)
         (requiere  [Bicicleta_estatica])
		 (ejercita [Cadera_y_piernas])
    )

    ([Bicicleta_estatica_50w] of Aerobico
         (Intensidad_MET  2)
         (requiere  [Bicicleta_estatica])
		 (ejercita [Cadera_y_piernas])
    )

    ([Brazos] of grupo_muscular
    )

    ([Buceo_en_aguas_templadas] of Aerobico
         (Intensidad_MET  6)
         (requiere  [Material_de_buceo])
		 (ejercita [Cadera_y_piernas] [Brazos] [Pecho] [Espalda])
    )

    ([Cadera_y_piernas] of grupo_muscular
    )

    ([Calentamiento_de_abdominales] of Calentamiento
         (ejercita  [Abdominales])
    )

    ([Calentamiento_de_cadera_y_piernas] of Calentamiento
         (ejercita  [Cadera_y_piernas])
    )

    ([Calentamiento_de_brazos] of Calentamiento
         (ejercita  [Brazos])
    )

    ([Calentamiento_de_espalda] of Calentamiento
         (ejercita  [Espalda])
    )

    ([Calentamiento_de_hombros] of Calentamiento
         (ejercita  [Hombros])
    )

    ([Calentamiento_de_pecho] of Calentamiento
         (ejercita  [Pecho])
    )

    ([Cambios_en_la_coloracion] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Caminar_a_1.5-3_kmph] of Aerobico
         (Intensidad_MET  1)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_a_3-4.5_kmph] of Aerobico
         (Intensidad_MET  2)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_a_4.5-5.5_kmph] of Aerobico
         (Intensidad_MET  3)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_a_5-6_kmph] of Aerobico
         (Intensidad_MET  4)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_a_6-7_km_h] of Aerobico
         (Intensidad_MET  5)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_a_7.5_kmph] of Aerobico
         (Intensidad_MET  6)
		 (ejercita [Cadera_y_piernas])
    )

    ([Caminar_con_apoyo_talon_punta] of Equilibrio
		(ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_7.5_kmph] of Aerobico
         (Intensidad_MET  2)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_10-12_kmph] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_12-13_kmph] of Aerobico
         (Intensidad_MET  5)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_18_kmph] of Aerobico
         (Intensidad_MET  6)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_20_kmph] of Aerobico
         (Intensidad_MET  7)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_21_kmph] of Aerobico
         (Intensidad_MET  8)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_7.5-10kmph] of Aerobico
         (Intensidad_MET  3)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_a_mas_de_21_kmph] of Aerobico
         (Intensidad_MET  9)
         (requiere  [Bicicleta])
		 (ejercita [Cadera_y_piernas])
    )

    ([Ciclismo_de_montaña] of Aerobico
         (Intensidad_MET  8)
         (requiere  [Bicicleta_de_montanya])
		 (ejercita [Cadera_y_piernas])
    )

    ([Correr_a_7.5_kmph] of Aerobico
         (Intensidad_MET  7)
		 (ejercita [Cadera_y_piernas])
    )

    ([Correr_a_8_kmph] of Aerobico
         (Intensidad_MET  8)
		 (ejercita [Cadera_y_piernas])
    )

    ([Correr_a_mas_de_9_kmph] of Aerobico
         (Intensidad_MET  9)
		 (ejercita [Cadera_y_piernas])
    )

    ([Depresion] of Enfermedad
		(objetivo_enfermedad  [Aumentar_flexibilidad] [Aumentar_masa_muscular])
    )

    ([Desplazamientos_multidireccionales_con_peso_extra] of Equilibrio
		(requiere [Peso_libre_o_maquina_de_resistencia_variable])
		(ejercita [Cadera_y_piernas])
    )

    ([Diabetes] of Enfermedad
         (objetivo_enfermedad  [Aumentar_resistencia_o_Bajar_de_peso])
    )

	([Artrosis] of Enfermedad
         (objetivo_enfermedad  [Aumentar_resistencia_o_Bajar_de_peso])
    )

    ([Diarrea] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Dolor_en_el_pecho] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Enfermedad_Pulmonar] [Hipertension])
    )

    ([Embolo_pulmonar] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

    ([Enfermedad_Cardiovascular] of Enfermedad
		(objetivo_enfermedad [Aumentar_equilibrio] [Aumentar_flexibilidad])
    )

    ([Enfermedad_Pulmonar] of Enfermedad
		(objetivo_enfermedad [Aumentar_flexibilidad])
	)

    ([Espalda] of grupo_muscular
    )

    ([Esqui_de_fondo] of Aerobico
         (Intensidad_MET  8)
         (requiere  [Material_de_esqui])
		 (ejercita [Cadera_y_piernas] [Brazos])
    )

    ([Esqui_intenso] of Aerobico
         (Intensidad_MET  7)
         (requiere  [Material_de_esqui])
		 (ejercita [Cadera_y_piernas] [Brazos])
    )

    ([Esqui_lento] of Aerobico
         (Intensidad_MET  6)
         (requiere  [Material_de_esqui])
		 (ejercita [Cadera_y_piernas] [Brazos])
		 
    )

    ([Estiramiento_de_abdominales] of Estiramiento
         (ejercita  [Abdominales])
    )

    ([Estiramiento_de_brazos] of Estiramiento
         (ejercita  [Brazos])
    )

    ([Estiramiento_de_cadera_y_piernas] of Estiramiento
         (ejercita  [Cadera_y_piernas])
    )

    ([Estiramiento_de_espalda] of Estiramiento
         (ejercita  [Espalda])
    )

    ([Estiramiento_de_hombros] of Estiramiento
         (ejercita  [Hombros])
    )

    ([Estiramiento_de_pecho] of Estiramiento
         (ejercita  [Pecho])
    )

	
	([Flexibilidad_de_abdominales] of Flexibilidad
         (ejercita  [Abdominales])
    )

    ([Flexibilidad_de_brazos] of Flexibilidad
         (ejercita  [Brazos])
    )

    ([Flexibilidad_de_cadera_y_piernas] of Flexibilidad
         (ejercita  [Cadera_y_piernas])
    )

    ([Flexibilidad_de_espalda] of Flexibilidad
         (ejercita  [Espalda])
    )

    ([Flexibilidad_de_hombros] of Flexibilidad
         (ejercita  [Hombros])
    )

    ([Flexibilidad_de_pecho] of Flexibilidad
         (ejercita  [Pecho])
    )

    ([Estonosis_aortica_grave] of Sintoma
    )

    ([Fuerza_de_Abdominales] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Abdominales])
    )

    ([Fuerza_de_Abdominales_con_peso] of Fuerza
         (Intensidad_RM  -1)
         (ejercita  [Abdominales])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Fuerza_de_Brazos] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Brazos])
    )

    ([Fuerza_de_Cadera_y_piernas] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Cadera_y_piernas])
    )

    ([Fuerza_de_Cadera_y_piernas_con_peso] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Cadera_y_piernas])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Fuerza_de_Espalda] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Espalda])
    )

    ([Fuerza_de_Espalda_con_peso] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Espalda])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Fuerza_de_Hombros_con_peso] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Hombros])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Fuerza_de_Pecho] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Pecho])
    )

    ([Fuerza_de_Pecho_con_peso] of Fuerza
		(Intensidad_RM  -1)
         (ejercita  [Pecho])
         (requiere  [Peso_libre_o_maquina_de_resistencia_variable])
    )

    ([Falta_de_aire] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Fibrosis] of Enfermedad
		(objetivo_enfermedad [Aumentar_equilibrio])
    )

    ([Fragilidad] of Enfermedad
		(objetivo_enfermedad [Aumentar_equilibrio] [Aumentar_masa_muscular])
    )

    ([Fronton] of Aerobico
         (Intensidad_MET  8)
         (requiere  [Material_de_fronton])
		 (ejercita [Cadera_y_piernas] [Brazos])
    )

    ([Gimnasia_suave] of Aerobico
         (Intensidad_MET  3)
		 (ejercita [Cadera_y_piernas] [Brazos] [Espalda])
    )

    ([Golf] of Aerobico
         (Intensidad_MET  2)
         (requiere  [Material_de_golf])
		 (ejercita [Cadera_y_piernas] [Brazos])
    )

    ([Hipertension] of Enfermedad
         (objetivo_enfermedad  [Aumentar_resistencia_o_Bajar_de_peso])
    )

    ([Hipoglucemia] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Hombros] of grupo_muscular
    )

    ([Infeccion_aguda] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Osteoporosis])
    )

    ([Insuficiencia_cardiaca_congestiva_aguda] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

    ([Lesion_abdominales] of Lesion
         (lesion_de  [Abdominales])
    )

    ([Lesion_brazos] of Lesion
         (lesion_de  [Brazos])
    )

    ([Lesion_cadera_y_piernas] of Lesion
         (lesion_de  [Cadera_y_piernas])
    )

    ([Lesion_espalda] of Lesion
         (lesion_de  [Espalda])
    )

    ([Lesion_hombros] of Lesion
         (lesion_de  [Hombros])
    )

    ([Lesion_pecho] of Lesion
         (lesion_de  [Pecho])
    )

    ([Mareo] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Enfermedad_Pulmonar])
    )

    ([Material_de_badminton] of Material
    )

    ([Material_de_buceo] of Material
    )

    ([Material_de_esqui] of Material
    )

    ([Material_de_fronton] of Material
    )

    ([Material_de_golf] of Material
    )

    ([Material_de_patinaje] of Material
    )

    ([Material_de_pesca] of Material
    )

    ([Material_de_tenis] of Material
    )

    ([Material_de_tenis_de_mesa] of Material
    )

    ([Material_de_tiro_con_arco] of Material
    )

    ([Material_de_voleibol] of Material
    )

    ([Material_para_hacer_vela] of Material
    )

    ([Miocarditis] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

    ([Natacion_moderada-rapida] of Aerobico
         (Intensidad_MET  7)
         (requiere  [Acceso_a_una_piscina])
		 (ejercita [Cadera_y_piernas] [Brazos] [Espalda])
    )

    ([Natacion_suave] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Acceso_a_una_piscina])
		 (ejercita [Cadera_y_piernas] [Brazos] [Espalda] [Pecho] [Abdominales] [Hombros])
    )

    ([Nauseas] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Osteoporosis] of Enfermedad
		(objetivo_enfermedad [Aumentar_masa_muscular] [Aumentar_equilibrio])
    )

    ([Palpitaciones] of Sintoma
          (no_recomienda_ejercicio [Hipertension])
    )

    ([Patinaje_intenso] of Aerobico
         (Intensidad_MET  8)
         (requiere  [Material_de_patinaje])
		 (ejercita [Cadera_y_piernas])

    )

    ([Patinaje_suave] of Aerobico
         (Intensidad_MET  5)
         (requiere  [Material_de_patinaje])
		 (ejercita [Cadera_y_piernas])
    )

    ([Pecho] of grupo_muscular
    )

    ([Pesca] of Aerobico
         (Intensidad_MET  3)
         (requiere  [Material_de_pesca])
	     (ejercita [Brazos])
    )

    ([Peso_libre_o_maquina_de_resistencia_variable] of Material
    )

    ([Posicion_de_semitandem] of Equilibrio
	 (ejercita [Cadera_y_piernas])
    )

    ([Posicion_de_tandem] of Equilibrio
	 (ejercita [Cadera_y_piernas])
    )

    ([Presion_arterial_sistolica_alta] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Psicosis] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

    ([Reciente_infarto_de_miocardio_complicado] of Sintoma
          (no_recomienda_ejercicio [Osteoporosis])
    )

	([Remo_o_Canoa_a_4.5_kmph] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Canoa_y_remos])
		 (ejercita [Brazos] [Espalda])
    )

    ([Remo_o_Canoa_a_6_kmph] of Aerobico
         (Intensidad_MET  6)
         (requiere  [Canoa_y_remos])
		 (ejercita [Brazos] [Espalda])
    )

    ([Remo_o_canoa_a_7.5_kmph] of Aerobico
         (Intensidad_MET  7)
         (requiere  [Canoa_y_remos])
		 (ejercita [Brazos] [Espalda])
    )

    ([Sincope] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular] [Enfermedad_Pulmonar])
    )

    ([Sobrepeso_u_Obesidad] of Enfermedad
		(objetivo_enfermedad [Aumentar_resistencia_o_Bajar_de_peso])
    )

    ([Tenis] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Material_de_tenis])
		 (ejercita [Brazos] [Cadera_y_piernas])
    )

    ([Tenis_de_mesa] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Material_de_tenis_de_mesa])
		 (ejercita [Brazos] [Cadera_y_piernas])
    )

    ([Tiro_con_arco] of Aerobico
         (Intensidad_MET  3)
         (requiere  [Material_de_tiro_con_arco])
		 (ejercita [Brazos])
    )

    ([Transferencia_de_peso_corporal] of Equilibrio
		(ejercita [Pecho] [Espalda])
		(ejercita [Cadera_y_piernas])
    )

    ([Vela] of Aerobico
         (Intensidad_MET  4)
         (requiere  [Material_para_hacer_vela])
		 (ejercita [Brazos] [Cadera_y_piernas])
    )

    ([Voleibol] of Aerobico
         (Intensidad_MET  3)
         (requiere  [Material_de_voleibol])
		 (ejercita [Brazos] [Cadera_y_piernas] [Pecho])
    )

    ([Vomitos] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

    ([Tos_intensa] of Sintoma
          (no_recomienda_ejercicio [Enfermedad_Cardiovascular])
    )

)

; -----------------------------------------
; -----------------------------------------
; ---------------  CODIGO  ----------------
; -----------------------------------------
; -----------------------------------------

;NOTA: Aqui empieza el codigo. Esta dividido en modulos.

; ------------------------------------
; 				  MAIN 
; ------------------------------------

;Modulo main
(defmodule MAIN (export ?ALL))

;Modulo de recopilacion de la informacion basica del usuario 
(defmodule recopilacion-informacion-usuario
	(import MAIN ?ALL)
	(export ?ALL)
)

;Modulo de recopilacion de las restricciones del usuario
(defmodule recopilacion-restricciones-usuario
	(import MAIN ?ALL)
	(export ?ALL)
)


;Modulo de abstraccion de datos
(defmodule abstraccion-datos
	(import MAIN ?ALL)
	(import recopilacion-informacion-usuario ?ALL)
	(import recopilacion-restricciones-usuario ?ALL)
	(export ?ALL)
)

;Modulo de abstraccion de inferencia
(defmodule inferir-datos
	(import MAIN ?ALL)
	(export ?ALL)
)

;Modulo de abstraccion de sintesis
(defmodule sintesis
	(import MAIN ?ALL)
	(export ?ALL)
)

;Modulo de abstraccion de impresion de rutina (resultados)
(defmodule imprimir-rutina
	(import MAIN ?ALL)
	(import recopilacion-informacion-usuario ?ALL)
	(import recopilacion-restricciones-usuario ?ALL)
	(import abstraccion-datos ?ALL)
	(import inferir-datos ?ALL)
	(import sintesis ?ALL)
	(export ?ALL)
)

(defrule MAIN::initialRule "regla inicial"
	(declare (salience 10))
	=>
	(printout t crlf)
	(printout t "--------------- Sistema de Recomendacion de Programa de Ejercicios ---------------" crlf)
	(printout t crlf)
	(focus recopilacion-informacion-usuario)
)


; -----------------------------------------
; 				 TEMPLATES 
; -----------------------------------------

; Para guardar la informacion del usuario
(deftemplate MAIN::informacion-usuario
    (slot edad (type INTEGER)(default -1))
	(slot peso (type INTEGER)(default -1))
	(slot altura (type FLOAT)(default -1.0))
	(slot puntuacion_actividad (type INTEGER)(default -1)) ; Cantidad de puntuacion actual, 0-10 (0 es lo mejor)
)

; Para guardar las restricciones del problema impuestas por las circunstancias del usuario
(deftemplate MAIN::restricciones-usuario
    (multislot enfermedades (type INSTANCE))
    (multislot sintomas (type INSTANCE))
    (multislot lesiones (type INSTANCE))
    ;(multislot otras-circunstancias (type INSTANCE)) DESCARTADO
	(multislot material (type INSTANCE))
)

; Para guardar la lista de ejercicios prohibidos
(deftemplate MAIN::lista-ejercicios-prohibidos
	(multislot ejercicios (type INSTANCE))
)

; Para guardar la lista de grupos musculares que no se permite ejercitar
(deftemplate MAIN::lista-musculos-prohibidos
	(multislot musculos (type INSTANCE))
)


;NOTA: Se guardan de forma dinamica, sacandolos de la lista de ejercicios, en los siguientes dos deftemplates los calentamientos y estiramientos para facilitar en el futuro añadir calentamientos/estiramientos, ya que asi no se ha de tocar el codigo.

; Para guardar la lista de ejercicios de calentamiento
(deftemplate MAIN::lista-calentamientos
	(multislot ejercicios (type INSTANCE))
)

; Para guardar la lista de ejercicios de estiramiento
(deftemplate MAIN::lista-estiramientos
	(multislot ejercicios (type INSTANCE))
)

; Para guardar la lista de ejercicios de ejercicios desordenada
(deftemplate MAIN::lista-ejercicios-desordenada
	(multislot ejercicios (type INSTANCE))
)

; Para guardar la lista de ejercicios una vez ya esta ordenadad
(deftemplate MAIN::lista-ejercicios-ordenada
	(multislot ejercicios (type INSTANCE))
)

; Para guardar la lista de sesiones que forman el programa
(deftemplate MAIN::lista-sesiones
	(multislot sesiones (type INSTANCE))
)

; Para guardar la lista de objetivos a trabajar, para informarlos al usuario al imprimir la rutina
(deftemplate MAIN::objetivos-a-trabajar
    (multislot objetivos (type INSTANCE))
)


; --------------------------------------------------
; 					 FUNCIONES 
; --------------------------------------------------


; Funcion para hacer pregunta numerica 
(deffunction MAIN::pregunta-numerica (?pregunta ?rangini ?rangfi)
	(format t "%s [%d, %d] " ?pregunta ?rangini ?rangfi)
	(bind ?respuesta (read))
	(while (not(and(>= ?respuesta ?rangini)(<= ?respuesta ?rangfi))) do
		(format t "%s [%d, %d] " ?pregunta ?rangini ?rangfi)
		(bind ?respuesta (read))
	)
	?respuesta
)

; Funcion para hacer pregunta numerica floats
(deffunction MAIN::pregunta-numerica-float (?pregunta ?rangini ?rangfi)
	(format t "%s [%f, %f] " ?pregunta ?rangini ?rangfi)
	(bind ?respuesta (read))
	(while (not(and(>= ?respuesta ?rangini)(<= ?respuesta ?rangfi))) do
		(format t "%s [%f, %f] " ?pregunta ?rangini ?rangfi)
		(bind ?respuesta (read))
	)
	?respuesta
)

; Funcion para hacer una pregunta de tipo si/no
(deffunction MAIN::pregunta-booleana (?question)
	(format t "%s [Y/N] " ?question)
	(bind ?response (read))
	(while (not(or(eq ?response Y)(eq ?response N))) do
		(printout t ?question)
		(bind ?response (read))
	)
	(if (eq ?response Y)
		then TRUE
		else FALSE)
)

; Funcion para hacer una pregunta con varios valores posibles como respuesta
(deffunction pregunta-multi (?pregunta $?valores-posibles)
    (bind ?linea (format nil "%s" ?pregunta))
    (printout t ?linea crlf)
    (progn$ (?var ?valores-posibles)
            (bind ?linea (format nil "  %d. %s" ?var-index ?var))
            (printout t ?linea crlf)
    )
    (format t "%s" "Indica los numeros separados por un espacio: ")
    (bind ?resp (readline))
    (bind ?numeros (str-explode ?resp))
    (bind $?lista (create$ ))
    (progn$ (?var ?numeros)
        (if (and (integerp ?var) (and (>= ?var 1) (<= ?var (length$ ?valores-posibles))))
            then
                (if (not (member$ ?var ?lista))
                    then (bind ?lista (insert$ ?lista (+ (length$ ?lista) 1) ?var))
                )
        )
    )
    ?lista
)

; Funcion para obtener ejercicio con maxima puntuacion de una lista
(deffunction maximo-puntuacion ($?lista)
	(bind ?maximo -1)
	(bind ?elemento nil)
	(progn$ (?curr-rec $?lista)
		(bind ?curr-punt (send ?curr-rec get-puntuacion_ejercicio))
		(if (> ?curr-punt ?maximo)
			then 
			(bind ?maximo ?curr-punt)
			(bind ?elemento ?curr-rec)
		)
	)
	?elemento
)

; Funcion para imprimir un ejercicio

;NOTA: CODIGO DESCARTADO, Se pretendía imprimir cada ejercicio en esta funcion, se ha pasado a poner abajo directamente.

;(defmessage-handler MAIN::Sesion imprimir ()
;	(printout t "============================================" crlf)    
;	(bind $?ejs ?self:conjunto_de)
;	(progn$ (?curr-ej $?ejs)
;		(printout t "-----------------------------------" crlf)
;		(printout t "Nombre del ejercicio: %s" ?curr-ej)
;		(printout t crlf)
;		;debug
;		;(printout t "Puntuacion: %d" (send ?curr-ej get-puntuacion))
;		;
;		(switch (class ?curr-ej)
;			(case Aerobico then
;				(printout t "Duracion: %d min"  (send ?curr-ej get-Duracion))
;				(printout t "Intensidad: %d MET"  (send ?curr-ej get-Intensidad_MET))
;			)
;			(case Fuerza then
;				(printout t "Series: %d"  (send ?curr-ej get-Series))
;				(printout t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
;				(printout t "Intensidad: %d RM"  (send ?curr-ej get-Intensidad_RM))
;			)
;			(case Equilibrio then
;				(printout t "Series: %d"  (send ?curr-ej get-Series))
;				(printout t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
;			)
;			(case Estiramiento then 
;				(printout t "Series: %d"  (send ?curr-ej get-Series))
;				(printout t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
;			)
;			(case Flexibilidad then 
;				(printout t "Series: %d"  (send ?curr-ej get-Series))
;				(printout t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
;			)
;			(case Calentamiento then 
;				(printout t "Series: %d"  (send ?curr-ej get-Series))
;				(printout t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
;			)
;		)
;		Aqui imprimir material
;		(bind ?mat-nec (send ?curr-ej get-requiere))
;		if (!= (length$ $?mat-nec) 0 
;		then (printout t "Material necesario: %d" (send ?material-necesario get-series))
;		)
;
;	)
;	(printout t "============================================" crlf)
;)

; --------------------------------------------------
; 				 MODULO RECOPILACION 
; --------------------------------------------------


;Recopilacion de datos usuario

(defrule recopilacion-informacion-usuario::establecer-edad "Cual es su edad?"
	(not (informacion-usuario))
	=>
	(printout t crlf)
	(printout t "--------------------------------------------------" crlf)
	(printout t "Primero empezaremos con unas preguntas basicas." crlf)
	(printout t crlf)
	(bind ?edad (pregunta-numerica "Cual es su edad? " 65 150 ))
	(assert (informacion-usuario (edad ?edad)))
)

(defrule recopilacion-informacion-usuario::establecer-peso "Cual es su peso?"
	?u <- (informacion-usuario (peso ?p))
	(test (< ?p 0))
	=>
	(bind ?e (pregunta-numerica"Cual es su peso? (kg) " 30 300))
	(modify ?u (peso ?e))
)

(defrule recopilacion-informacion-usuario::establecer-altura "Cual es su altura?"
	?u <- (informacion-usuario (altura ?altura))
	(test (< ?altura 0))
	=>
	(bind ?altura (pregunta-numerica-float "Cual es su altura? (m)" 1 2.5 ))
	(modify ?u (altura ?altura))
)

(defrule recopilacion-informacion-usuario::preguntas-calcula-nivel "Pregunta al usuario sus conocimientos"
    ?g <- (informacion-usuario (puntuacion_actividad ?puntuacion_actividad))
	(test (< ?puntuacion_actividad 0))
	=>
	(printout t crlf)
	(printout t "--------------------------------------------------" crlf)
	(printout t "A continuacion le realizaremos unas preguntas para determinar su nivel actual de actividad" crlf)
	(printout t crlf)
    (bind ?p 0)
	(bind ?respuesta (pregunta-booleana "Se levanta con facilidad cuando esta sentado?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))
   
	(bind ?respuesta (pregunta-booleana "Suele ir usted a hacer la compra?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

	(bind ?respuesta (pregunta-booleana "Suele realizar usted las tareas del hogar?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))
		
	(bind ?respuesta (pregunta-booleana "Sube con facilidad las escaleras?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))
		
	(bind ?respuesta (pregunta-booleana "Realiza algun deporte?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

	(bind ?respuesta (pregunta-booleana "Realiza actividades como caminar o ir en bici durante 30 minutos al menos 5 dias a la semana?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))
	
	(bind ?respuesta (pregunta-booleana "Hace ejercicio todas las semanas?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

	(bind ?respuesta (pregunta-booleana "Realiza ejercicio de equilibrio i/o flexibilidad cada semana?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

	(bind ?respuesta (pregunta-booleana "Realiza ejercicio de fuerza cada semana?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

	(bind ?respuesta (pregunta-booleana "Realiza actividades intensas, tales como ciclismo en cuesta o correr, durante 20 minutos o mas, 3 dias o mas a la semana?"))
	(if (eq ?respuesta FALSE) then (bind ?p (+ 1 ?p)))

    (modify ?g (puntuacion_actividad ?p))

	(focus recopilacion-restricciones-usuario)
) 

;Recopilacion de datos circunstancias

(deffacts recopilacion-restricciones-usuario::hechos-iniciales "Establece hechos base sobre circunstancias"
	(enfermedades ask)
	(sintomas ask)
	(lesiones ask)
	;(otras-circunstancias ask) DESCARTADO
	(material ask)
	(restricciones-usuario)
)

(defrule recopilacion-restricciones-usuario::establecer-enfermedades "Establece si sufre de alguna enfermedad"
	?circ <- (restricciones-usuario)
	?hecho <- (enfermedades ask)
	=>
	(printout t crlf)
	(printout t "--------------------------------------------------" crlf)
	(printout t "Finalmente necesitamos saber sobre sus circunstancias." crlf)
	(printout t crlf)
	(bind ?e (pregunta-booleana "Ha sido diagnosticado con alguna enfermedad?"))
	(if (eq ?e TRUE)
		then
		(bind $?obj-enfermedades (find-all-instances ((?inst Enfermedad)) True))
		(bind $?nom-enfermedades (create$ ))
		(loop-for-count (?i 1 (length$ $?obj-enfermedades)) do
			(bind ?curr-obj (nth$ ?i ?obj-enfermedades))
			(bind ?curr-nom ?curr-obj)
			(bind $?nom-enfermedades(insert$ $?nom-enfermedades (+ (length$ $?nom-enfermedades) 1) ?curr-nom))
		)
		(bind ?escogido (pregunta-multi "Escoja las enfermedades que se le han diagnosticado: " $?nom-enfermedades))

		(bind $?respuesta (create$ ))
		(loop-for-count (?i 1 (length$ ?escogido)) do
			(bind ?curr-index (nth$ ?i ?escogido))
			(bind ?curr-enf (nth$ ?curr-index ?obj-enfermedades))
			(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-enf))
		)
		(modify ?circ (enfermedades $?respuesta))
	)
	(retract ?hecho)
)	

(defrule recopilacion-restricciones-usuario::establecer-sintomas "Establece si sufre de algun sintoma"
	?circ <- (restricciones-usuario)
	?hecho <- (sintomas ask)
	=>
	(bind ?e (pregunta-booleana "Sufre de algun sintoma actualmente?"))
	(if (eq ?e TRUE)
	then (bind $?obj-sintomas (find-all-instances ((?inst Sintoma)) TRUE))
	(bind $?nom-sintomas (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-sintomas)) do
		(bind ?curr-obj (nth$ ?i ?obj-sintomas))
		(bind ?curr-nom ?curr-obj)
		(bind $?nom-sintomas(insert$ $?nom-sintomas (+ (length$ $?nom-sintomas) 1) ?curr-nom))
	)
	(bind ?escogido (pregunta-multi "Cuales de los siguientes sintomas sufre?: " $?nom-sintomas))

	(bind $?respuesta (create$ ))
	(loop-for-count (?i 1 (length$ ?escogido)) do
		(bind ?curr-index (nth$ ?i ?escogido))
		(bind ?curr-atr (nth$ ?curr-index ?obj-sintomas))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	)
	(modify ?circ (sintomas $?respuesta))
	)
	(retract ?hecho)
)


(defrule recopilacion-restricciones-usuario:establecer-lesiones "Establece si sufre de alguna lesion"
	?circ <- (restricciones-usuario)
	?hecho <- (lesiones ask)
	=>
	(bind ?e (pregunta-booleana "Sufre de alguna lesion actualmente?"))
	(if (eq ?e TRUE)
	then (bind $?obj-lesiones (find-all-instances ((?inst Lesion)) TRUE))
	(bind $?nom-lesiones (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-lesiones)) do
		(bind ?curr-obj (nth$ ?i ?obj-lesiones))
		(bind ?curr-nom ?curr-obj)
		(bind $?nom-lesiones(insert$ $?nom-lesiones (+ (length$ $?nom-lesiones) 1) ?curr-nom))
	)
	(bind ?escogido (pregunta-multi "Cuales de los siguientes lesiones sufre?: " $?nom-lesiones))

	(bind $?respuesta (create$ ))
	(loop-for-count (?i 1 (length$ ?escogido)) do
		(bind ?curr-index (nth$ ?i ?escogido))
		(bind ?curr-atr (nth$ ?curr-index ?obj-lesiones))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	)
	(modify ?circ (lesiones $?respuesta))
	)
	(retract ?hecho)
)

;NOTA: CODIGO DESCARTADO, Se pretendía incluir otras circunstancias possibles, como caidas recientes, descartado debido a que eran demasiado pocas.

;(defrule recopilacion-restricciones-usuario:establecer-otras-circunstancias "Establece si se da alguna otra circunstancia"
;	?circ <- (restricciones-usuario)
;	?hecho <- (otras-circunstancias ask)
;	=>
;	(bind ?e (pregunta-booleana "Sufre alguna otra circunstancia de interes?"))
;	(if (eq ?e TRUE)
;	then (bind $?obj-otras-circunstancias (find-all-instances ((?inst Otra_Circunstancia)) TRUE))
;	(bind $?nom-otras-circunstancias (create$ ))
;	(loop-for-count (?i 1 (length$ $?obj-otras-circunstancias)) do
;		(bind ?curr-obj (nth$ ?i ?obj-otras-circunstancias))
;		(bind ?curr-nom ?curr-obj)
;		(bind $?nom-otras-circunstancias(insert$ $?nom-otras-circunstancias (+ (length$ $?nom-otras-circunstancias) 1) ?curr-nom))
;	)
;	(bind ?escogido (pregunta-multi "Cuales de las siguientes circunstancias sufre?: " $?nom-otras-circunstancias))
;
;	(bind $?respuesta (create$ ))
;	(loop-for-count (?i 1 (length$ ?escogido)) do
;		(bind ?curr-index (nth$ ?i ?escogido))
;		(bind ?curr-atr (nth$ ?curr-index ?obj-otras-circunstancias))
;		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
;	)
;	(modify ?circ (otras-circunstancias $?respuesta))
;	)
;	(retract ?hecho)
;	(focus abstraccion-datos)
;)

(defrule recopilacion-restricciones-usuario:establecer-material "Establece el material del que dispone"
	?circ <- (restricciones-usuario)
	?hecho <- (material ask)
	=>
	(bind $?obj-material (find-all-instances ((?inst Material)) TRUE))
	(bind $?nom-material (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-material)) do
		(bind ?curr-obj (nth$ ?i ?obj-material))
		(bind ?curr-nom ?curr-obj)
		(bind $?nom-material(insert$ $?nom-material (+ (length$ $?nom-material) 1) ?curr-nom))
	)
	(bind ?escogido (pregunta-multi "A cuales de los siguientes materiales tiene acceso?: " $?nom-material))
	(bind $?respuesta (create$ ))
	(loop-for-count (?i 1 (length$ ?escogido)) do
		(bind ?curr-index (nth$ ?i ?escogido))
		(bind ?curr-atr (nth$ ?curr-index ?obj-material))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	)
	(modify ?circ (material $?respuesta))
	(retract ?hecho)
	(focus abstraccion-datos)
)

; --------------------------------------------------
; 				MODULO ABSTRACCION
; --------------------------------------------------

;Para el USUARIO, lo inicializamos con su NIVEL, su EDAD, su CANTIDAD SESIONES y la DURACION POR SESION
(defrule abstraccion-datos::info-usuario
	?u <- (informacion-usuario (edad ?edad) (peso ?peso) (altura ?altura) (puntuacion_actividad ?puntuacion_actividad))
	(not (info-usuario-definido))
	=>

	; abstraccion nivel: 
	(bind ?bmi (abs (- (/ ?peso (* ?altura ?altura)) 21.5))) ;bmi = abs((peso / altura^2) - 21.5), calculamos desviacion de la media "buena".

	(bind ?edadCalc (- ?edad 65))

	(bind ?F_EDAD 3)
	(bind ?F_ACT 5)
	(bind ?F_BMI 1)

	(bind ?A 15)
	(bind ?B 40)
	(bind ?C 80)
	(bind ?D 110)

	(bind ?numero_nivel (+ (* ?edadCalc ?F_EDAD) (* ?puntuacion_actividad ?F_ACT) (* ?bmi ?F_BMI)))
	(if (< ?numero_nivel ?A)
		then (bind ?nivelUsuario ALTO)
		else
			(if (< ?numero_nivel ?B)
				then (bind ?nivelUsuario MEDIO_ALTO)
				else
					(if (< ?numero_nivel ?C) 
						then (bind ?nivelUsuario MEDIO)
						else 
						(if (< ?numero_nivel ?D)
						then (bind ?nivelUsuario MEDIO_BAJO)
						else (bind ?nivelUsuario BAJO)
						)
					)
			)
	)

	;abstraccion edad
	(if (< ?edad 70)
		then (bind ?edadUsuario JOVEN)
		else 
			(if (< ?edad 80)
			then (bind ?edadUsuario MEDIO)
			else (bind ?edadUsuario EXPERIMENTADO)
			)
	)

	; abstraccion sesiones a la semana
	(if (eq ?nivelUsuario ALTO)
		then (bind ?numSesiones 7)
		else
		(if (eq ?nivelUsuario MEDIO_ALTO)
			then (bind ?numSesiones 6)
			else 
				(if (eq ?nivelUsuario MEDIO)
					then (bind ?numSesiones 5)
					else 
						(if (eq ?nivelUsuario MEDIO_BAJO)
							then (bind ?numSesiones 4)
							else (bind ?numSesiones 3)
						)
				)
		)
	)

	;abstraccion duracion de cada sesion
	(if (eq ?nivelUsuario ALTO)
		then (bind ?durSesion 90)
		else
		(if (eq ?nivelUsuario MEDIO_ALTO)
			then (bind ?durSesion 78)
			else 
				(if (eq ?nivelUsuario MEDIO)
					then (bind ?durSesion 66)
					else 
						(if (eq ?nivelUsuario MEDIO_BAJO)
							then (bind ?durSesion 54)
							else (bind ?durSesion 32)
						)
				)
		)
	)

	;creamos el usuario y bind
	(bind ?nuevoUsuario (make-instance usuario of Usuario))
	(send ?nuevoUsuario put-Nivel ?nivelUsuario)
	(send ?nuevoUsuario put-numSesiones ?numSesiones)
	(send ?nuevoUsuario put-durSesion ?durSesion)
	(send ?nuevoUsuario put-Edad ?edadUsuario)
)

(defrule abstraccion-datos::usuario-restricciones
	?u <- (restricciones-usuario (enfermedades $?enfermedades)(sintomas $?sintomas)(lesiones $?lesiones)(material $?material))
	?usuario <- (object (is-a Usuario))
	=>
	(bind $?respuesta (create$))
	(bind $?objetivos (create$))
	(loop-for-count (?i 1 (length$ $?enfermedades)) do
		(bind ?curr-atr (nth$ ?i $?enfermedades))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))

		;aqui haremos la abstraccion de objetivos
		(bind $?objetivos-enf (send ?curr-atr get-objetivo_enfermedad))

		;Loop objetivos de la enfermedad
		(loop-for-count (?j 1 (length$ $?objetivos-enf)) do
			(bind ?curr-obj (nth ?j $?objetivos-enf))
			(if (not (member$ ?curr-obj $?objetivos))
				then
				(bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) ?curr-obj))
			)
		)

		;Añade como objetivos el equilibrio y flexibilidad si es aplicable
		(if (or 
				(eq (send ?usuario get-Edad) MEDIO) 
				(eq (send ?usuario get-Edad) EXPERIMENTADO)
			)
			then
			(if (not (member$ [Aumentar_equilibrio] $?objetivos))
				then
				(bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) [Aumentar_equilibrio]))
			)
			(if (not (member$ [Aumentar_flexibilidad] $?objetivos))
				then
				(bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) [Aumentar_flexibilidad]))
			)
		)
	)
	(loop-for-count (?i 1 (length$ $?sintomas)) do
		(bind ?curr-atr (nth$ ?i $?sintomas))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	)
	(loop-for-count (?i 1 (length$ $?lesiones)) do
		(bind ?curr-atr (nth$ ?i $?lesiones))
		(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	)

	;NOTA: CODIGO DESCARTADO, Se pretendía incluir otras circunstancias possibles, como caidas recientes, descartado debido a que eran demasiado pocas.
	;(loop-for-count (?i 1 (length$ $?otras-circunstancias)) do
	;	(bind ?curr-atr (nth$ ?i $?otras-circunstancias))
	;	(bind $?respuesta(insert$ $?respuesta (+ (length$ $?respuesta) 1) ?curr-atr))
	;)
	(send ?usuario put-sufre_de $?respuesta)

	;Material
	(bind $?resp2 (create$))
	(loop-for-count (?i 1 (length$ $?material)) do
		(bind ?curr-atr (nth$ ?i $?material))
		(bind $?resp2(insert$ $?resp2 (+ (length$ $?resp2) 1) ?curr-atr))
	)
	(send ?usuario put-dispone_de $?resp2)
	
	(assert (objetivos-a-trabajar (objetivos $?objetivos)))
	
	; NOTA: CODIGO DESCARTADO, Se pretendia dar una impotancia relativa a cada tipo de ejercicios para después distribuirlos según esa importancia en las rutinas.
	; Descartado debido a que no había diferencias significativas

	;(bind ?pAerobico 0)
	;(bind ?pFuerza 0)
	;(bind ?pEquilibrio 0)
	;(bind ?pFlexibilidad 0)
	;(bind ?pTotal 0)
	;;abstraccion % sesiones por objetivo
	;(loop-for-count (?i 1 (length$ $?enfermedades)) do
	;	(bind ?curr-rest (nth$ ?i $?enfermedades))
	;	(if (eq (class ?curr-rest) Enfermedad) then
	;		(bind $?objetivos-enf (send ?curr-rest get-objetivo_enfermedad))
;
	;		(loop-for-count (?j 1 (length$ $?objetivos-enf)) do
	;			(bind ?curr-obj (nth$ ?j $?objetivos-enf))
	;			(format t "aa : %s" ?curr-obj)
	;			(printout t crlf)
	;		)
;
	;		;Loop objetivos de la enfermedad
	;		(bind ?pTotal (+ ?pTotal (length$ $?objetivos-enf)))
	;		(loop-for-count (?j 1 (length$ $?objetivos-enf)) do
	;			(bind ?curr-obj (nth$ ?j $?objetivos-enf))
	;			(switch ?curr-obj
	;				(case [Aumentar_resistencia_o_Bajar_de_peso] then (bind ?pAerobico (+ ?pAerobico 1)))
	;				(case [Aumentar_masa_muscular] then (bind ?pFuerza (+ ?pFuerza 1)))
	;				(case [Aumentar_equilibrio] then (bind ?pEquilibrio (+ ?pEquilibrio 1)))
	;				(case [Aumentar_flexibilidad] then (bind ?pFlexibilidad (+ ?pFlexibilidad 1)))
	;			)
	;		)
	;	)
	;)
	;(format t "Importancia aerobico: %f" (/ ?pAerobico ?pTotal))
	;(printout t crlf)
	;(format t "Importancia fuerza: %f" (/ ?pFuerza ?pTotal))
	;(printout t crlf)
	;(format t "Importancia equilibrio: %f" (/ ?pEquilibrio ?pTotal))
	;(printout t crlf)
	;(format t "Importancia flexibilidad: %f" (/ ?pFlexibilidad ?pTotal))
	;(printout t crlf)

	(focus inferir-datos)
)




; --------------------------------------------------
; 				MODULO Inferencia 
; --------------------------------------------------

;En esta funcion le damos al USUARIO las cosas de CIRCUNSTANCIA y el MATERIAL
 
;Aqui comprobamos los sintomas
(defrule inferir-datos::comprobar-sintomas
	?usuario <- (object (is-a Usuario))
	(not (evalSintomas))
	=>
	(bind $?enfermedadesPeligrosas (create$))
	(bind $?usuario-rest (send ?usuario get-sufre_de))
	(loop-for-count (?i 1 (length$ $?usuario-rest)) do
		(bind ?curr-rest (nth$ ?i $?usuario-rest))
		(if (eq (class ?curr-rest) Sintoma)
			then
			(bind $?curr-enf-pel (send ?curr-rest get-no_recomienda_ejercicio))
			(loop-for-count (?j 1 (length$ $?curr-enf-pel)) do
				(bind ?enf-pel (nth$ ?j $?curr-enf-pel))
				(if (not (member$ ?enf-pel $?enfermedadesPeligrosas)) then 
					(bind $?enfermedadesPeligrosas(insert$ $?enfermedadesPeligrosas (+ (length$ $?enfermedadesPeligrosas) 1) ?enf-pel))
				)
			)
		)
	)

	(loop-for-count (?i 1 (length$ $?usuario-rest)) do
		(bind ?curr-rest (nth$ ?i $?usuario-rest))
		(if (and
				(eq (class ?curr-rest) Enfermedad)
				(member$ ?curr-rest $?enfermedadesPeligrosas)
			) then
			(assert (prohibido-ejercicio))
			(focus imprimir-rutina)
		)
	)

	(assert (evalSintomas)) 
)

;Aqui invalidamos los ejercicios que no pueda hacer por lesion
(defrule inferir-datos::comprobar-lesion
	?usuario <- (object (is-a Usuario))
	(not (lista-musculos-prohibidos))
	(not (evalLesiones))
	=>
	(bind $?usuario-rest (send ?usuario get-sufre_de))
	(bind $?musculosProhibidos (create$ ))

	(bind ?contador 0)

	;Loop de las lesiones, guardandonos los grupos musculares prohibidos
	(loop-for-count (?i 1 (length$ $?usuario-rest)) do
		(bind ?curr-rest (nth$ ?i $?usuario-rest))
		(switch (class ?curr-rest)
			(case Lesion then
				(bind $?musculosProhibidos(insert$ $?musculosProhibidos (+ (length$ $?musculosProhibidos) 1) (send ?curr-rest get-lesion_de)))
				(bind ?contador (+ ?contador 1))
			)
		)
	)
	
	;Aqui abstraemos por si hay demasiadas lesiones, prohibir o limitar el ejercicio
	;Prohibido si >= 5 lesiones
	(if (>= ?contador 5)
		then
		(assert (prohibido-ejercicio))
		(focus imprimir-rutina)
	)
	;Si tiene >=3 && <5, limitamos a 3 sesiones 
	(if (>= ?contador 3)
		then
		(assert (limitacion_por_lesiones))
		(send ?usuario put-numSesiones 3)
	)

	(assert (lista-musculos-prohibidos (musculos $?musculosProhibidos))) 
	(assert (evalLesiones))
)

;Aqui invalidamos los ejercicios que no pueda hacer por falta de material o intensidad demasiado alta o pesas si es muy mayor
(defrule inferir-datos::comprobar-material-y-niveles
	?usuario <- (object (is-a Usuario))
	(not (lista-ejercicios-prohibidos))
	(not (evalFaltaMaterial))
	=>
	(bind $?ejerciciosProhibidos (create$ ))
	(bind $?usuario-mat (send ?usuario get-dispone_de))
	(bind $?all-ej (find-all-instances ((?inst Ejercicio)) TRUE))
	(loop-for-count (?i 1 (length$ $?all-ej)) do
		(bind ?ejercicio (nth$ ?i $?all-ej))

		;no tenemos el material
		(bind ?req (send ?ejercicio get-requiere))
		(if (and (neq ?req [nil]) (not (member$ ?req $?usuario-mat)) (not (member$ ?ejercicio $?ejerciciosProhibidos)))
			then (bind $?ejerciciosProhibidos (insert$ $?ejerciciosProhibidos (+ (length$ $?ejerciciosProhibidos) 1) ?ejercicio) )
		)	

		;es aerobico y demasiado avanzado
		(bind ?nivelUs (send ?usuario get-Nivel))
		(switch ?nivelUs
			(case ALTO then (bind ?limiteMET 9))
			(case MEDIO_ALTO then (bind ?limiteMET 7))
			(case MEDIO then (bind ?limiteMET 5))
			(case MEDIO_BAJO then (bind ?limiteMET 4))
			(case BAJO then (bind ?limiteMET 2))
		)
		(if (and 
					(eq (class ?ejercicio) Aerobico) 
					(or 
						(> (send ?ejercicio get-Intensidad_MET) ?limiteMET) 
						(< (send ?ejercicio get-Intensidad_MET) (- ?limiteMET 2))
					) 
					(not (member$ ?ejercicio $?ejerciciosProhibidos))
		
			) then 
			(bind $?ejerciciosProhibidos (insert$ $?ejerciciosProhibidos (+ (length$ $?ejerciciosProhibidos) 1) ?ejercicio) )
		)

		;es de fuerza, usa peso y el anciano es mayor
		(if (and 
				(eq (send ?usuario get-Edad) EXPERIMENTADO) 
				(eq (class ?ejercicio) Fuerza)
				(eq ?req [Peso_libre_o_maquina_de_resistencia_variable])
				(not (member$ ?ejercicio $?ejerciciosProhibidos))
			) then
			(bind $?ejerciciosProhibidos (insert$ $?ejerciciosProhibidos (+ (length$ $?ejerciciosProhibidos) 1) ?ejercicio) )
		)
	)
	(assert (lista-ejercicios-prohibidos (ejercicios $?ejerciciosProhibidos)))
	(assert (evalFaltaMaterial)) 
)



;Aqui metemos los ejercicios a saco.
(defrule inferir-datos::anadir-ejercicios
	(not (prohibido-ejercicio)) ;importante, tirar atrás ya en este módulo para no hacer calculo inutil en caso de no ser necesario.
	(evalFaltaMaterial)
	(evalLesiones)
	(evalSintomas)
	(calculo-ejercicio)
	(puntuar_ejercicios)
	?usuario <-(object (is-a Usuario))
	(not (lista-ejercicios-desordenada))
	(lista-ejercicios-prohibidos (ejercicios $?ejerciciosProhibidos))
	(lista-musculos-prohibidos (musculos $?musculosProhibidos))
	=>
	;(bind $?usuario-rest (send ?usuario get-sufre_de))
	(bind $?ejerciciosAnadir (create$))
	(bind $?calentamientos (create$ ))
	(bind $?estiramientos (create$ ))

	(bind $?all-ej (find-all-instances ((?inst Ejercicio)) TRUE))
	(loop-for-count (?i 1 (length$ $?all-ej)) do
		(bind ?ejercicio (nth$ ?i $?all-ej))
		(if (and (not (eq (class ?ejercicio) Calentamiento)) (not (eq (class ?ejercicio) Estiramiento)) (not (member$ ?ejercicio $?ejerciciosProhibidos)))
			then
			(bind ?bool TRUE)
			(bind $?gm_afectados (send ?ejercicio get-ejercita))

			(loop-for-count (?j 1 (length$ $?gm_afectados)) do
				(if (member$ (nth$ ?j $?gm_afectados) $?musculosProhibidos)
					then (bind ?bool FALSE)
				)
			)
			(if (eq ?bool TRUE) 
				then  
				(bind $?ejerciciosAnadir (insert$ $?ejerciciosAnadir (+ (length$ $?ejerciciosAnadir) 1) ?ejercicio) )
			)
		)	
		(switch (class ?ejercicio)
			(case Calentamiento then 
				(bind $?calentamientos (insert$ $?calentamientos (+ (length$ $?calentamientos) 1) ?ejercicio) )
			)
			(case Estiramiento then 
				(bind $?estiramientos (insert$ $?estiramientos (+ (length$ $?estiramientos) 1) ?ejercicio) )
			)
		)
	)
	(assert (lista-ejercicios-desordenada (ejercicios $?ejerciciosAnadir)))
	(assert (lista-calentamientos (ejercicios $?calentamientos)))
	(assert (lista-estiramientos (ejercicios $?estiramientos)))
)

(defrule inferir-datos::puntuar-ejercicios
	(declare (salience 10))
	?usuario <-(object (is-a Usuario))
	(not (puntuar_ejercicios))
	=>
	;Primero puntuamos segun las enfermedades
	(bind $?usuario-enf (send ?usuario get-sufre_de))
	(bind $?ejerciciosAnadir (create$))
	
	;Loop enfermedades
	(loop-for-count (?i 1 (length$ $?usuario-enf)) do
		(bind ?curr-rest (nth$ ?i $?usuario-enf))
		(if (eq (class ?curr-rest) Enfermedad) then
			(bind $?objetivos-enf (send ?curr-rest get-objetivo_enfermedad))

			;Loop objetivos de la enfermedad
			(loop-for-count (?j 1 (length$ $?objetivos-enf)) do
					(bind $?curr-obj (nth ?j $?objetivos-enf))
					(bind $?ejercicios-obj (send $?curr-obj get-se_trabaja_con))

					;Loop ejercicios recomendados para el objetivo
					(loop-for-count (?k 1 (length$ $?ejercicios-obj)) do
						(bind ?curr-ej (nth$ ?k $?ejercicios-obj))
						(send ?curr-ej put-puntuacion_ejercicio (+ (send ?curr-ej get-puntuacion_ejercicio) 1))
					)
			)
		)
	)

	;Ahora sumamos por la edad del usuario
	(bind ?edadUsuario (send ?usuario get-Edad))
	(bind ?constSum 0)
	(if (eq ?edadUsuario MEDIO) then (bind ?constSum 1))
	(if (eq ?edadUsuario EXPERIMENTADO) then (bind ?constSum 2))

	(bind $?ejercicios (find-all-instances ((?inst Ejercicio)) TRUE))
	(loop-for-count (?i 1 (length$ $?ejercicios)) do
		(bind ?curr-ej (nth$ ?i $?ejercicios))
		(switch (class ?curr-ej)
			(case Equilibrio then (send ?curr-ej put-puntuacion_ejercicio (+ (send ?curr-ej get-puntuacion_ejercicio) ?constSum)))
			(case Flexibilidad then (send ?curr-ej put-puntuacion_ejercicio (+ (send ?curr-ej get-puntuacion_ejercicio) ?constSum)))
		)
	)
	(assert (puntuar_ejercicios))
)

;En esta funcion se calculan ciertas cosas de los ejercicios en funcion del usuario.
(defrule inferir-datos::calcular-cosas-ejercicios
	(declare (salience 5)) ; se ha de hacer la segunda
	(not (calculo-ejercicio))
	?usuario <-(object (is-a Usuario))
	=>
	(bind ?nivel (send ?usuario get-Nivel))

	(bind $?ejercicios (find-all-instances ((?inst Ejercicio)) TRUE))
	(loop-for-count (?i 1 (length$ $?ejercicios)) do
		(bind ?curr-ej (nth$ ?i $?ejercicios))
		(switch (class ?curr-ej)
			(case Fuerza then 
				(switch ?nivel
					(case BAJO then 
						(bind ?repes 8)
						(bind ?series 1)
						(bind ?intensidad 30)
					)
					(case MEDIO_BAJO then 
						(bind ?repes 9)
						(bind ?series 2)
						(bind ?intensidad 40)
					)
					(case MEDIO then 
						(bind ?repes 10)
						(bind ?series 2)
						(bind ?intensidad 50)
					)
					(case MEDIO_ALTO then 
						(bind ?repes 11)
						(bind ?repes 2)
						(bind ?intensidad 60)
					)
					(case ALTO then 
						(bind ?repes 12)
						(bind ?series 3)
						(bind ?intensidad 70)
					)
				)
				(send ?curr-ej put-Series ?series)
				(send ?curr-ej put-Repeticiones ?repes)
				(send ?curr-ej put-Intensidad_RM ?intensidad)
			)
			(case Aerobico then 
				(bind ?duracion 10)
				(switch ?nivel
					(case BAJO then 
						(bind ?duracion 10)
					)
					(case MEDIO_BAJO then 
						(bind ?duracion 20)
					)
					(case MEDIO then 
						(bind ?duracion 30)
					)
					(case MEDIO_ALTO then 
						(bind ?duracion 40)
					)
					(case ALTO then 
						(bind ?duracion 50)
					)
				)
				(send ?curr-ej put-Duracion ?duracion)
			)
			(case Estiramiento then 
				(switch ?nivel
					(case BAJO then 
						(bind ?repes 8)
						(bind ?series 1)
					)
					(case MEDIO_BAJO then 
						(bind ?repes 9)
						(bind ?series 2)
					)
					(case MEDIO then 
						(bind ?repes 10)
						(bind ?series 2)
					)
					(case MEDIO_ALTO then 
						(bind ?repes 11)
						(bind ?series 2)
					)
					(case ALTO then 
						(bind ?repes 12)
						(bind ?series 3)
					)
				)
				(send ?curr-ej put-Series ?series)
				(send ?curr-ej put-Repeticiones ?repes)
			)
			(case Flexibilidad then 
				(switch ?nivel
					(case BAJO then 
						(bind ?repes 8)
						(bind ?series 1)
					)
					(case MEDIO_BAJO then 
						(bind ?repes 9)
						(bind ?series 2)
					)
					(case MEDIO then 
						(bind ?repes 10)
						(bind ?series 2)
					)
					(case MEDIO_ALTO then 
						(bind ?repes 11)
						(bind ?series 2)
					)
					(case ALTO then 
						(bind ?repes 12)
						(bind ?series 3)
					)
				)
				(send ?curr-ej put-Series ?series)
				(send ?curr-ej put-Repeticiones ?repes)
			)
			(case Calentamiento then 
				(switch ?nivel
					(case BAJO then 
						(bind ?repes 8)
						(bind ?series 1)
					)
					(case MEDIO_BAJO then 
						(bind ?repes 9)
						(bind ?series 2)
					)
					(case MEDIO then 
						(bind ?repes 10)
						(bind ?series 2)
					)
					(case MEDIO_ALTO then 
						(bind ?repes 11)
						(bind ?series 2)
					)
					(case ALTO then 
						(bind ?repes 12)
						(bind ?series 3)
					)
				)
				(send ?curr-ej put-Series ?series)
				(send ?curr-ej put-Repeticiones ?repes)
			)
			(case Equilibrio then 
				(switch ?nivel
					(case BAJO then 
						(bind ?repes 8)
						(bind ?series 1)
					)
					(case MEDIO_BAJO then 
						(bind ?repes 9)
						(bind ?series 2)
					)
					(case MEDIO then 
						(bind ?repes 10)
						(bind ?series 2)
					)
					(case MEDIO_ALTO then 
						(bind ?repes 11)
						(bind ?series 2)
					)
					(case ALTO then 
						(bind ?repes 12)
						(bind ?series 3)
					)
				)
				(send ?curr-ej put-Series ?series)
				(send ?curr-ej put-Repeticiones ?repes)
			)
		)
	)
	(assert (calculo-ejercicio))
)

(defrule inferir-datos::lista-ordenada
	(not (lista-ejercicios-ordenada))
	(lista-ejercicios-desordenada (ejercicios $?lista))
	=>
	(bind $?resultado (create$ ))
	(while (not (eq (length$ $?lista) 0))  do
		(bind ?curr-rec (maximo-puntuacion $?lista))
		(bind $?lista (delete-member$ $?lista ?curr-rec))
		(bind $?resultado (insert$ $?resultado (+ (length$ $?resultado) 1) ?curr-rec))
	)
	(assert (lista-ejercicios-ordenada (ejercicios $?resultado)))
	(focus sintesis)
)


; --------------------------------------------------
; 			MODULO SINTESIS
; --------------------------------------------------


(defglobal ?*num-sesiones* = 0)

(deffunction sintesis::get-tiempo-ejercicio (?ejercicio)
	(bind ?tipo_ej (class ?ejercicio))
	(switch ?tipo_ej
		(case Fuerza then
			(bind ?series (send ?ejercicio get-Series))
			(bind ?repes (send ?ejercicio get-Repeticiones))
			(bind ?tiempo (+ (/ (* ?series ?repes 5) 60) (* ?series 1.5))) ;tiempo = series*repes*5 + repes*2 (descanso entre series = 2 min!) 
		)
		(case Equilibrio then
			(bind ?series (send ?ejercicio get-Series))
			(bind ?repes (send ?ejercicio get-Repeticiones))
			(bind ?tiempo (+ (/ (* ?series ?repes 5) 60) (* ?series 1.5))) ;tiempo = series*repes*5 + repes*2 (descanso entre series = 2 min!) 
			
		)
		(case Estiramiento then
			(bind ?series (send ?ejercicio get-Series))
			(bind ?repes (send ?ejercicio get-Repeticiones))
			(bind ?tiempo (+ (/ (* ?series ?repes 5) 60) (* ?series 1.5))) ;tiempo = series*repes*5 + repes*2 (descanso entre series = 2 min!) 
		)
		(case Flexibilidad then
			(bind ?series (send ?ejercicio get-Series))
			(bind ?repes (send ?ejercicio get-Repeticiones))
			(bind ?tiempo (+ (/ (* ?series ?repes 5) 60) (* ?series 1.5))) ;tiempo = series*repes*5 + repes*2 (descanso entre series = 2 min!) 
		)
		(case Calentamiento then
			(bind ?series (send ?ejercicio get-Series))
			(bind ?repes (send ?ejercicio get-Repeticiones))
			(bind ?tiempo (+ (/ (* ?series ?repes 5) 60) (* ?series 1.5))) ;tiempo = series*repes*5 + repes*2 (descanso entre series = 2 min!) 
		)
		(case Aerobico then
			(bind ?tiempo (send ?ejercicio get-Duracion))
		)
	)
	?tiempo
)

(deffunction sintesis::cabe-ejercicio (?ejercicio ?sesion ?us)
	(bind ?tiempo_restante (- (send ?sesion get-tiempo_restante) (get-tiempo-ejercicio ?ejercicio)))
	(bind ?cabe (> ?tiempo_restante 1))	
	?cabe
)

(defrule sintesis::asigna-ejercicios-a-sesion
	?g <- (object (is-a Usuario) (durSesion ?durSesion)(numSesiones ?numSesiones)(Nivel ?nivel))
	(lista-ejercicios-ordenada (ejercicios $?recs))
	(lista-calentamientos (ejercicios $?calentamientos))
	(lista-estiramientos (ejercicios $?estiramientos))
	(not (lista-sesiones))
	=>
	(bind ?minutos ?durSesion)
	(bind $?lista (create$))

	(while (not (= (length$ $?lista) ?numSesiones)) do
		(bind $?lista (insert$ $?lista (+ (length$ $?lista) 1) (make-instance (gensym) of Sesion (tiempo_restante ?minutos))))
	)
	(bind ?i 1)
	(bind $?recs-descartadas (create$))
	
	;Para controlar que musculos se han trabajado en la ultima sesion
	; DESCARTADO
	;(bind $?gm-ultima-sesion (create$))

	(while (<= ?i ?numSesiones)
		(bind ?sesion (nth$ ?i $?lista))
		(bind $?recs-sesion (create$ ))
		(bind $?cals-sesion (create$ ))
		(bind $?ests-sesion (create$ ))
		(bind $?gm-esta-sesion (create$))
		(bind ?t-max (send ?sesion get-tiempo_restante))
		(bind ?t-ocu 0)
		(bind ?try 1)
        (bind ?j 1)

		;lim de ejercicios: aerobico: 1 / sesion, fuerza, equilibrio, flexibilidad: 3 / sesion
		(bind ?cantidad_aerobico 0)
		(bind ?cantidad_fuerza 0)
		(bind ?cantidad_equilibrio 0)
		(bind ?cantidad_flexibilidad 0)
		
		;Se dan 10 intentos para meter un ejercicio
		(while (and(< ?t-ocu ?t-max) (< ?try 10)) do
			
			;Si nos salimos del rango, volvemos al primero
			(if (and
					(> ?j (length$ ?recs))
					(> (length$ $?recs) 0)
				) then
				(bind ?j 1)
			)

			;ciclamos ejercicios! En caso de haberlos puesto todos
			(if (= (length$ $?recs) 0) then 
				(bind $?recs $?recs-descartadas)
				(bind $?recs-descartadas (create$))
				(bind ?j 1)
			)
			(bind ?rec (nth$ ?j $?recs))

			;Inicializamos por si fueran 0
			(bind ?tc 0)
			(bind ?te 0)
			
			;Guardamos el grupo muscular
			(bind $?gms (send ?rec get-ejercita))

			;Aqui se guardan los calentamientos y estiramientos que se han de hacer para el ejercicio que intentamos tratar
			(bind $?cals (create$))
			(bind $?ests (create$))

			;Requieren un calentamiento y estiramiento
			(if (or (eq (class ?rec) Fuerza) (eq (class ?rec) Aerobico)) then

				;Buscamos un ejercicio de calentamiento / estiramiento por cada grupo muscular
				(loop-for-count (?j 1 (length$ $?gms)) do
					(bind ?gm (nth$ ?j $?gms))

					(loop-for-count (?i 1 (length$ $?calentamientos)) do
						(bind ?curr-cal (nth$ ?i $?calentamientos))					
						(if (eq ?gm (nth$ 1 (send ?curr-cal get-ejercita))) then
							;lo añadimos ssi no estaba ya
							(if (not (member$ ?curr-cal $?cals)) then
								(bind $?cals (insert$ $?cals (+ (length$ $?cals) 1) ?curr-cal))
								(bind ?tc (+ ?tc (get-tiempo-ejercicio ?curr-cal)))
							)
						)
					)
					;Encontramos un estiramiento para el gm
					(loop-for-count (?i 1 (length$ $?estiramientos)) do
						(bind ?curr-est (nth$ ?i $?estiramientos))
						(if (eq ?gm (nth$ 1 (send ?curr-est get-ejercita))) then
							(if (not (member$ ?curr-est $?ests)) then
								(bind $?ests (insert$ $?ests (+ (length$ $?ests) 1) ?curr-est))
								(bind ?te (+ ?te (get-tiempo-ejercicio ?curr-est)))
							)
						)
					)

				)
			)

			(bind ?t (get-tiempo-ejercicio ?rec))
			
			;Si caben y respetan las proporciones de cada tipo por sesion
			(if (and
					(< (+ ?t-ocu ?t ?tc ?te) ?t-max)
					(or
						(neq (class ?rec) Aerobico)
						(and 
							(eq (class ?rec) Aerobico)
							(< ?cantidad_aerobico 1)
						)
					)
					(or
						(neq (class ?rec) Fuerza)
						(and 
							(eq (class ?rec) Fuerza)
							(< ?cantidad_fuerza 3)
						)
					)
					(or
						(neq (class ?rec) Equilibrio)
						(and 
							(eq (class ?rec) Equilibrio)
							(< ?cantidad_equilibrio 3)
						)
					)
					(or
						(neq (class ?rec) Flexibilidad)
						(and 
							(eq (class ?rec) Flexibilidad)
							(< ?cantidad_flexibilidad 3)
						)
					)
				) then
					(bind ?t-ocu (+ ?t-ocu ?t ?tc ?te))
					(bind ?try 1)
					(bind ?recs-sesion (insert$ $?recs-sesion (+ (length$ $?recs-sesion) 1) ?rec))

					(if (or (eq (class ?rec) Fuerza) (eq (class ?rec) Aerobico)) then
						
						;añadimos todos los calentamientos nuevos
						(loop-for-count (?i 1 (length$ $?cals)) do
							(bind ?curr-cal (nth$ ?i $?cals))

							;lo añadimos ssi no estaba ya
							(if (not (member$ ?curr-cal $?cals-sesion)) then
								(bind $?cals-sesion (insert$ $?cals-sesion (+ (length$ $?cals-sesion) 1) ?curr-cal))
							)
							
						)
						
						;añadimos todos los estiramientos nuevos
						(loop-for-count (?i 1 (length$ $?ests)) do
							(bind ?curr-est (nth$ ?i $?ests))

							;lo añadimos ssi no estaba ya
							(if (not (member$ ?curr-est $?ests-sesion)) then
								(bind $?ests-sesion (insert$ $?ests-sesion (+ (length$ $?ests-sesion) 1) ?curr-est))
							)
							
						)					
					)
					(bind $?recs-descartadas (insert$ $?recs-descartadas (+ (length$ $?recs-descartadas) 1) ?rec))
					(bind $?recs (delete-member$ $?recs ?rec))
				else
					(bind ?try (+ ?try 1))
			)
        	(bind ?j (+ ?j 1))
		)
		

		;juntar los 3
		(bind $?lista-def (create$ ))

		;añadimos los calentamientos
		(loop-for-count (?i 1 (length$ $?cals-sesion)) do
			(bind ?lista-def (insert$ $?lista-def (+ (length$ $?lista-def) 1) (nth$ ?i $?cals-sesion)))
		)
		;añadimos los ejercicios
		(loop-for-count (?i 1 (length$ $?recs-sesion)) do
			(bind ?lista-def (insert$ $?lista-def (+ (length$ $?lista-def) 1) (nth$ ?i $?recs-sesion)))
		)
		;añadimos los estiramientos
		(loop-for-count (?i 1 (length$ $?ests-sesion)) do
			(bind ?lista-def (insert$ $?lista-def (+ (length$ $?lista-def) 1) (nth$ ?i $?ests-sesion)))
		)

		(send ?sesion put-conjunto_de $?lista-def)		
		(bind ?i (+ ?i 1))	
	)
	(assert (lista-sesiones (sesiones $?lista)))
	(focus imprimir-rutina)
)


; --------------------------------------------------
; 			  MODULO IMPRIMIR RUTINA
; --------------------------------------------------


(defrule imprimir-rutina::imprime-rutina "regla ini"
	(declare (salience 10)) ; se ha de hacer la primera
	=>
	(printout t crlf)
	(printout t "---------- Programa personalizado----------" crlf)
	(printout t crlf)
)

(defrule imprimir-rutina::imprime-limitacion-lesiones
	(declare (salience 5)) ; se ha de hacer la segunda
	(not (final))
	(limitacion_por_lesiones)
	(not (prohibido-ejercicio))
	=>
	(printout t crlf)
	(printout t "Debido a sus lesiones, se han limitado la cantidad de sesiones a 3" crlf)
	(printout t crlf)
)
(defrule imprimir-rutina::mostrar-respuesta "Muestra el contenido escogido"
	(lista-sesiones (sesiones $?sesiones))
	(not (final))
	(not (prohibido-ejercicio))
	(objetivos-a-trabajar (objetivos $?objetivos))
	=>
	(printout t crlf)
	(format t "Recomendacion de programa de ejercicios.")
	(printout t crlf)
    (format t "%n")
    (printout t crlf)
	
	(if (!= (length$ $?objetivos) 0)
		then
		(format t "Debido a su edad y circunstancias, se recomienda trabajar los siguientes objetivos:")
		(printout t crlf)
		(loop-for-count (?i 1 (length$ $?objetivos)) do
			(if (!= ?i 1)
				then
				(printout t ", ")
			)
			(format t "%s" (nth$ ?i $?objetivos))
		)
		(printout t crlf)
		(printout t crlf)
	)

    (printout t "============================================" crlf)
    (bind ?i 0)
	(progn$ (?curr-sesion $?sesiones)
        (bind ?i(+ ?i 1))
		(format t "Sesion %d" ?i)
		(printout t crlf)
		;(printout t (send ?curr-sesion imprimir))
	
			(printout t "============================================" crlf)    
			(bind $?ejs (send ?curr-sesion get-conjunto_de))
			(progn$ (?curr-ej $?ejs)
				(printout t "-----------------------------------" crlf)
				(format t "Nombre del ejercicio: %s" ?curr-ej)
				(printout t crlf)
				;debug
				;(printout t "Puntuacion: %d" (send ?curr-ej get-puntuacion))
				;
				(switch (class ?curr-ej)
					(case Aerobico then
						(format t "Duracion: %d min"  (send ?curr-ej get-Duracion))
						(printout t crlf)
						(format t "Intensidad: %d MET"  (send ?curr-ej get-Intensidad_MET)) 
						(printout t crlf)
					)
					(case Fuerza then
						(format t "Series: %d"  (send ?curr-ej get-Series))
						(printout t crlf)
						(format t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
						(printout t crlf)
						(format t "Intensidad: %d porciento de su RM"  (send ?curr-ej get-Intensidad_RM))
						(printout t crlf)
					)
					(case Equilibrio then
						(format t "Series: %d"  (send ?curr-ej get-Series))
						(printout t crlf)
						(format t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
						(printout t crlf)
					)
					(case Estiramiento then 
						(format t "Series: %d"  (send ?curr-ej get-Series))
						(printout t crlf)
						(format t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
						(printout t crlf)
					)
					(case Flexibilidad then 
						(format t "Series: %d"  (send ?curr-ej get-Series))
						(printout t crlf)
						(format t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
						(printout t crlf)
					)
					(case Calentamiento then 
						(format t "Series: %d"  (send ?curr-ej get-Series))
						(printout t crlf)
						(format t "Repeticiones: %d"  (send ?curr-ej get-Repeticiones))
						(printout t crlf)
					)
				)

		;		Aqui imprimir material
				(bind ?mat-nec (send ?curr-ej get-requiere))
				(if (neq ?mat-nec [nil]) then 
					(format t "Material necesario: %s" ?mat-nec)
					(printout t crlf)
				)

			)
			(printout t "-----------------------------------" crlf)

			(printout t crlf)
			(printout t "============================================" crlf)
	)
	(assert (final))
)

(defrule imprimir-rutina::imprimir-aviso
	(not (final))
	(prohibido-ejercicio)
	=>
	(printout t "Debido a sus enfermedades, sintomas y lesiones actuales, no le podemos recomendar un programa de ejercicio. Por favor, consulte a su medico." crlf)
	(printout t crlf)
	(assert (final))
)

