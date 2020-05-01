
=begin
      attr_accessor :dni_alumno, :apellidos_alumno, :nombres_alumno, :edad_alumno, :genero_alumno, :r1 ,:r2, :r3, :r4, :r5, :r6, :r7, :r8, :r9, :r10, :dni_tutor, :apellidos_tutor, :nombre_tutor, :parentesco
 	  def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
 		@dni_alumno, @apellidos_alumno, @nombres_alumno, @edad_alumno, @genero_alumno, @r1, @r2, @r3, @r4, @r5, @r6, @r7, @r8, @r9, @r10, @dni_tutor, @apellidos_tutor, @nombre_tutor, @parentesco = dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco
 	  end
=end
class Tutor
	attr_accessor :dni_tutor, :apellidos_tutor, :nombre_tutor, :parentesco
	def initialize( dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
	 @dni_tutor, @apellidos_tutor, @nombre_tutor, @parentesco = dni_tutor, apellidos_tutor, nombre_tutor, parentesco
	end
end

=begin
 tutor1 = Tutor.new(548638816, "COLOM OLIVERAS", "ADRIAN", "Padre")
 tutor2 = Tutor.new(233766207, "REINOSO JUAN", "JESUS ", "Padre")
 tutor3 = Tutor.new(426648286, "ROA REVILLA", "CRISTIAN", "Padre")
 tutor4 = Tutor.new(822881757, "CASTRILLO CLAROS", "JUAN ", "Padre")
 tutor5 = Tutor.new(606860101, "CERVERA DAZA", "DANIEL ", "Padre")
 tutor6 = Tutor.new(272805579, "LLORCA GIMENEZ", "JOSE RAMON ", "Padre")
 tutor7 = Tutor.new(130237179, "QUINTERO ARREBOLA", "SERGIO ", "Padre")
 tutor8 = Tutor.new(646667976, "CABO MAESO", "MARCOS", "Padre")
 tutor9 = Tutor.new(205853115, "REINOSO MOLANO", "JOSE MARIA ", "Padre"
 tutor10 = Tutor.new(785610499, "LUCENA LLORENS", "JOSE MANUEL ", "Padre"
 tutor11 = Tutor.new(765017989, "FELIU PICO", "MARIO", "Padre")
 tutor12 = Tutor.new(838873084, "ABELLAN ZUÑIGA", "HECTOR ", "Padre")
 tutor13 = Tutor.new(345542985, "MIGUEL LIMA", "CRISTINA ", "Madre")
 tutor14 = Tutor.new(120007286, "ETXEBERRIA PARRADO", "ANGELA ", "Madre"
 tutor15 = Tutor.new(687545163, "PEREZ CAÑADA", "CELIA ", "Madre")
 tutor16 = Tutor.new(183376431, "MORENO GUARDIOLA", "NURIA", "Madre")
 tutor17 = Tutor.new(118885919, "BEDOYA TUDELA", "ANGELES ", "Madre")
 tutor18 = Tutor.new(496649446, "ALDEA ROMANO", "INMACULADA ", "Madre")
 tutor19 = Tutor.new(264273099, "DAZA FARIÑA", "ROSA ", "Madre")
 tutor20 = Tutor.new(201365257, "LOPERA BELLES", "IRENE ", "Madre")
=end

class Alumno
	attr_accessor :dni_alumno, :apellidos_alumno, :nombres_alumno, :edad_alumno, :genero_alumno, :lista_Tutor, :puntajeFinal
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
	@dni_alumno, @apellidos_alumno, @nombres_alumno, @edad_alumno, @genero_alumno = dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno
	@lista_Tutor = Array.new()
	@puntajeFinal = calcularPuntajeFinal

	end

	def calcularPromedio
		
	end
	def calcularPension

	end
	def obtenerPuesto
		
	end
	def obtenerEstadoExamen
		
	end

	def calcularPuntajeFinal
		calcular_calificacion_sc = 0
		calcular_puntaje_re = 0
		calcular_evaluacion_conocimiento_ec = 0
		return (calcular_calificacion_sc*0.2) + (calcular_puntaje_re*0.30) + (calcular_evaluacion_conocimiento_ec*0.50)
		
	end

	def obtenerEstadoIngreso
		if vacantesDisponible < cantidadVacantes
			"Ingreso"
		else
			"No Ingreso"
		end
	end
	def agregarTutor(tutor)
		lista_Tutor.push(tutor)
	end
end

=begin
alumno1 = Alumno.new("12300000", "COLLANTES POZA", "CESAR", 20, "Masculino")
alumno1.agregarTutor(tutor1)
alumno2 = Alumno.new("12300000", "QUINTELA JUAN", "MARIANO", 23, "Masculino")
alumno2.agregarTutor(tutor2)
alumno3 = Alumno.new("12300000", "NIETO PARRAS", "IVAN", 27, "Masculino")
alumno3.agregarTutor(tutor3)
alumno4 = Alumno.new("12300000", "VIVAS PARRILLA", "ALBERT", 29, "Masculino")
alumno4.agregarTutor(tutor4)
alumno5 = Alumno.new("12300000", "CORTIJO IGUAL", "VICENTE", 26, "Masculino")
alumno5.agregarTutor(tutor5)
alumno6 = Alumno.new("12300000", "TENORIO OLMO", "LORENZO", 33, "Masculino")
alumno6.agregarTutor(tutor6)
alumno7 = Alumno.new("12300000", "JULIAS AMPER", "PEDRO", 21, "Masculino")
alumno7.agregarTutor(tutor7)
alumno8 = Alumno.new("12300000", "MAYORGA LUIS", "JUANJOSE", 29, "Masculino")
alumno8.agregarTutor(tutor8)
alumno9 = Alumno.new("12300000", "CLEMENTE FELIU", "XAVIER", 28, "Masculino")
alumno9.agregarTutor(tutor9)
alumno10 = Alumno.new("12300000", "CASALSADRIAN", "ESTEBAN", 30, "Masculino",)
alumno10.agregarTutor(tutor10)
alumno11 = Alumno.new("12300000", "LOBO CABALEIRO", "JOSEIGNACIO", 30, "Masculino")
alumno11.agregarTutor(tutor11)
alumno12 = Alumno.new("12300000", "ANGUITA BLAS", "IGNACIO", 31, "Masculino")
alumno12.agregarTutor(tutor12)
alumno13 = Alumno.new("12300000", "BALAGUER POZA", "PABLO", 27, "Masculino")
alumno13.agregarTutor(tutor13)
alumno14 = Alumno.new("12300000", "DE JESUS AMOROS", "AGUSTIN", 20, "Masculino")
alumno14.agregarTutor(tutor14)
alumno15 = Alumno.new("12300000", "TEJEDOR LINARES", "JULIAN", 28, "Masculino")
alumno15.agregarTutor(tutor15)
alumno16 = Alumno.new("12300000", "CACHO CHACON", "JOSEMIGUEL", 28, "Masculino")
alumno16.agregarTutor(tutor16)
alumno17 = Alumno.new("12300000", "COLORADO CARRILLO", "CAROLINA", 26, "Femenino")
alumno17.agregarTutor(tutor17)
alumno18 = Alumno.new("12300000", "MALAGON CAMPS", "NOELIA", 26, "Femenino")
alumno18.agregarTutor(tutor18)
alumno19 = Alumno.new("12300000", "RODA DELCAMPO", "LIDIA", 30, "Femenino")
alumno19.agregarTutor(tutor19)
alumno20 = Alumno.new("12300000", "CONCEPCION POLOVIERA", "MARIA", 20, "Femenino")
alumno20.agregarTutor(tutor20)
=end

class Examen
	attr_accessor :codigo_examen, :cantidad_preguntas, :cantidad_preguntas_correctas, :cantidad_preguntas_incorrectas, :cantidad_preguntas_sin_responder
	def initialize( codigo_examen, cantidad_preguntas, cantidad_preguntas_correctas, cantidad_preguntas_incorrectas, cantidad_preguntas_sin_responder)
	 @codigo_examen, @cantidad_preguntas, @cantidad_preguntas_correctas, @cantidad_preguntas_incorrectas, @cantidad_preguntas_sin_responder = codigo_examen, cantidad_preguntas, cantidad_preguntas_correctas, cantidad_preguntas_incorrectas, cantidad_preguntas_sin_responder

	 @listaPreguntas = Array.new(cantidad_preguntas)
	 @listaRespuestas = Array.new(cantidad_preguntas)
	end
	def registrarPregunta(pregunta, respuestaLetra)
		@listaPreguntas.push(pregunta => respuestaLetra)
	end
	def listarPreguntas
		@listaPreguntas
	end

	def registrarRespuestaAlumno(pregunta, respuestaLetra)
		@listaRespuestas.push(pregunta => respuestaLetra)
	end

	def listarRespuestas
		@listaRespuestas
	end
	def registrarTotalPreguntas
		pregunatsIncorrectas = 0
		pregunatsCorrectas = 0
		pregunatsSinRespuesta = 0

		for i in 0..@listaPreguntas.size
			punto = 0
			respuestaMarcada = @listaRespuestas[i]
			pregunta = @listaPreguntas[i]
			if respuestaMarcada == nil
				punto = 0
				pregunatsSinRespuesta = pregunatsSinRespuesta + 1

			elsif pregunta == respuestaMarcada
				punto = 10
				pregunatsCorrectas = pregunatsCorrectas + 1
			else
				punto = -5
				pregunatsIncorrectas = pregunatsIncorrectas + 1
			end
			puntaje = puntaje + punto
		end
		return puntaje
	end

end

#exam1 = Examen.new("e00001", 10, nil, nil, nil)
#exam1.registraPreguntas("preg01", "a")
#exam1.registraPreguntas("preg02", "a")
#exam1.registraPreguntas("preg03", "a")
#exam1.registraPreguntas("preg04", "a")
#exam1.registraPreguntas("preg05", "a")
#exam1.registraPreguntas("preg06", "a")
#exam1.registraPreguntas("preg07", "a")
#exam1.registraPreguntas("preg08", "a")
#exam1.registraPreguntas("preg09", "a")
#exam1.registraPreguntas("preg10", "a")

class Respuesta
	def initialize(args)
		
	end
	def obtenerRespuesta(pregunta, respuestaMarcada)
		if pregunta == respuestaMarcada
			true
		else
			false
		end
	end

end

class Concurso
	attr_accessor :examen, :alumno
	def initialize(examen, alumno)
		@examen, @alumno = examen, alumno
	end
	
end


class Colegio
	attr_accessor :nombre, :cantidadVacantes, :arregloAlumnos
	def initialize(nombre, cantidadVacantes)
		@nombre, @cantidadVacantes = nombre, cantidadVacantes
		@arregloAlumnos = Array.new()
	end
	def registraAlumno(alumno)
		arregloAlumnos.push(alumno)
	end
    def obtenerPertenencia
    end
    def obtenerPromedio2Anio

    end
    def calcularMontoPension
    end
    def obtenerRango2Anio
    end
end	

Arrayce = []
Arraycp = []

class ColegioNcional < Colegio

    attr_accessor :zona, :puntaje
	def initialize(zona, puntaje)
		super(nombre, cantidadVacantes)
		@zona, @puntaje = zona, puntaje 
	end

    def obtenerPertenencia
        Zona
    end

    def obtenerPromedio2Anio
        promedio_ponderado = 0
		if promedio_ponderado >= 19
            puntajere=100
          elsif promedio_ponderado >= 18 && promedio_ponderado < 19
            puntajere=80
          elsif promedio_ponderado >= 16 && promedio_ponderado < 18
            puntajere=60
          elsif promedio_ponderado >= 14 && promedio_ponderado < 16
            puntajere=40
          elsif promedio_ponderado >= 111 && promedio_ponderado < 14
            puntajere=20
          else
            puntajere=0
          end 
        return puntajere
    end
end  

class ColegioParticular < Colegio

    attr_accessor :monto, :puntaje
	def initialize(monto, puntaje)
		super(nombre, cantidadVacantes)
		@monto, @puntaje = monto, puntaje 
	end
    
    def obtenerMontoPension
        if monto_pension <= 200
            puntaje=90
        elsif monto_pension > 200 && monto_pension <= 400
            puntajesc=70
        elsif monto_pension > 400 && penmonto_pensionsion <= 600
            puntajesc=70
        else monto_pension > 600
            puntajesc=20
        end
      return puntajesc  
    end

    def obtenerRango2Anio
        if puesto_obt < 20
            puntajere=0
          elsif puesto_obt >= 11 && puesto_obt < 20
            puntajere=40
          elsif puesto_obt >= 6 && puesto_obt <= 10
            puntajere=60
          elsif puesto_obt >= 4 && puesto_obt <= 5
            puntajere=80
          elsif puesto_obt <= 3
            puntajere=100
          else
            puntajere=0
          end
        return puntajere 
    end
end  



