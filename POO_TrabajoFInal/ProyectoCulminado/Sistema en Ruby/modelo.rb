
class Colegio
	attr_accessor :codigo_colegio, :nombre_colegio, :cantidad_vacantes
	def initialize(codigo_colegio, nombre_colegio, cantidad_vacantes)
		@codigo_colegio, @nombre_colegio, @cantidad_vacantes = codigo_colegio, nombre_colegio, cantidad_vacantes
	end
	def validarDatos

		raise  "La codigo de colegio no se ha ingresado" if (codigo_colegio==nil)
		raise  "El nombre del colegio no se ha ingresado" if (codigo_colegio==nil)
		raise  "La cantidad de vacantes no se ha ingresado" if (cantidad_vacantes==nil)
		raise  "El numero de vacantes es invalido : #{cantidad_vacantes}" if (cantidad_vacantes == 0)

	end
end

class Examen
	attr_accessor :codigo_examen, :cantidad_preguntas, :listaPreguntas ,:listaRespuestasValida, :listaRespuestasAlumno
	def initialize( codigo_examen, cantidad_preguntas)
		@codigo_examen, @cantidad_preguntas = codigo_examen, cantidad_preguntas

		@listaPreguntas = Array.new
		@listaRespuestasValida = Array.new
		@listaRespuestasAlumno = Array.new
	end
	def validarDatos
		raise  "La codigo de examen no se ha ingresado" if (codigo_examen==nil)
		raise  "La cantidad de preguntas no se ha ingresado" if (cantidad_preguntas==nil)
		raise  "La cantidad de preguntas es invalido, solo valor 10 0 20: #{cantidad_preguntas}" if (cantidad_preguntas != 10 && idad_preguntas != 20)
	end

	def registrarPregunta(codPregunta, textoPregunta)
		if listaPreguntas.size < cantidad_preguntas
			pregunta = Pregunta.new(codPregunta, textoPregunta)
			for preg in listaPreguntas
				if preg.codigo == codPregunta
					preg.texto = textoPregunta
					return
				end
			end
			listaPreguntas.push(pregunta)
		end
	end
	def registrarRespuesta(codPregunta, opcion, texto)
		respuesta = Respuesta.new(codPregunta, opcion, texto)
		for preg in listaPreguntas
			if preg.codigo == codPregunta
				for resp in preg.respuestas
					if resp.opcion == opcion
						resp.texto = texto
						return
					end
				end
				preg.respuestas.push(respuesta)
				return
			end
		end
	end
	def registrarRespuestaValida(codPregunta, opcionValida)
		respuesta = Respuesta.new(codPregunta, opcionValida,nil)
		for resp in listaRespuestasValida
			if resp.codigo == codPregunta
				resp.opcion = opcionValida
				return
			end
		end
		listaRespuestasValida.push(respuesta)
	end
	def registrarRespuestaAlumno(codPregunta, opcionaAlumno)
		respuesta = Respuesta.new(codPregunta, opcionaAlumno, nil)
		for resp in listaRespuestasAlumno
			if resp.codigo == codPregunta
				resp.opcion = opcionaAlumno
				return
			end
		end
		listaRespuestasAlumno.push(respuesta)
	end

	def calcularPreguntasSinRespuesta
		cont = 0
		for rptV in listaRespuestasValida
			for rptA in listaRespuestasAlumno
				if rptV.codigo == rptA.codigo and rptA.opcion == nil
					cont = cont + 1
					#print "NA  #{ rptV.codigo } == #{rptA.codigo} , #{rptV.opcion} == #{rptA.opcion} , cont = #{cont} \n"
				end
			end
		end
		return cont
	end
	def calcularPreguntasCorrectas
		cont = 0
		for rptV in listaRespuestasValida
			for rptA in listaRespuestasAlumno
				if rptV.codigo == rptA.codigo && rptA.opcion == rptV.opcion
					cont = cont + 1
					#print "RC  #{ rptV.codigo } == #{rptA.codigo} , #{rptV.opcion} == #{rptA.opcion} , cont = #{cont} \n"
				end
			end
		end
		return cont
	end
	def calcularPreguntasIncorrectas
		cont = cantidad_preguntas - calcularPreguntasCorrectas
		cont = cont - calcularPreguntasSinRespuesta
		return cont
	end
	def calcularPuntaje
		cant = cantidad_preguntas
		return (calcularPreguntasCorrectas* 100/cant) - (calcularPreguntasIncorrectas*100/(cant*2))
	end
end

class Pregunta
	attr_accessor :codigo, :texto, :respuestas
	def initialize(codigo, texto)
		@codigo, @texto, @respuestas = codigo, texto, []
	end 
end

class Respuesta
	attr_accessor :codigo, :opcion, :texto
	def initialize(codigo, opcion, texto)
		@codigo, @opcion, @texto = codigo, opcion, texto
	end 
end

class Tutor
	attr_accessor :dni_tutor, :apellidos_tutor, :nombres_tutor, :parentesco
	def initialize( dni_tutor, apellidos_tutor, nombres_tutor, parentesco)
	 @dni_tutor, @apellidos_tutor, @nombres_tutor, @parentesco = dni_tutor, apellidos_tutor, nombres_tutor, parentesco
	end
	def validarDatos
		raise  "El dni no se ha ingresado" if (dni_tutor==nil)
		raise  "El apellido no se ha ingresado" if (apellidos_tutor==nil)
		raise  "El nombre no se ha ingresado" if (nombres_tutor==nil)
		raise  "El parentesco no se ha ingresado" if (parentesco==nil)
		raise  "El numero de dni es invalido por la cantidad de digitos : #{dni_tutor}" if (dni_tutor.to_s.length != 8)
	end
end

class Alumno
	attr_accessor :dni_alumno, :apellidos_alumno, :nombres_alumno, :edad_alumno, :genero_alumno
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
		@dni_alumno, @apellidos_alumno, @nombres_alumno, @edad_alumno, @genero_alumno = dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno
	end
	def validarDatos
		raise  "El dni no se ha ingresado" if (dni_alumno==nil)
		raise  "El apellido no se ha ingresado" if (apellidos_alumno==nil || apellidos_alumno=="")
		raise  "El nombre no se ha ingresado" if (nombres_alumno==nil || nombres_alumno=="")
		raise  "La edad no se ha ingresado" if (edad_alumno==nil)
		raise  "El genero no se ha ingresado" if (genero_alumno==nil || genero_alumno=="")
		raise  "El numero de dni es invalido por la cantidad de digitos : #{dni_alumno}" if (dni_alumno.to_s.length != 8 )
		raise  "la edad debe ser entre '11 - 15' : #{edad_alumno}" if (edad_alumno < 11 || edad_alumno > 15)
		raise  "El genero debe ser Masculino o Femenino : #{genero_alumno}" if (genero_alumno != "Masculino" && genero_alumno != "Femenino")
	end
	def calificarSocioEconomica 
	end
	def calificarRendimiento2Grado
	end
	def calificarEvaluacionConocimiento
		if examen_alumno
			return examen_alumno.calcularPuntaje
		end
		return nil
	end
	def calcularPuntajeFinal
		if examen_alumno
			return (calificarSocioEconomica * 0.2) + (calificarSocioEconomica * 0.3) + (calificarEvaluacionConocimiento * 0.50)
		end
		return nil
	end

	def rendirExamen(examen)
		@examen_alumno = examen
	end

	def registrarTutor(nuevoTutor)
		for tutor in lista_tutores
			raise  "El tutor ya existe : #{datos[0]}.Tutor no registrado" if tutor.dni_tutor.to_s == nuevoTutor.dni_tutor.to_s
		end
		lista_tutores.push(nuevoTutor)
	end
	def estadoFinal
		@estado_evaluacion
	end
end

class AlumnoNacional < Alumno

	attr_accessor :zona_alumno, :promedio_ponderado, :examen_alumno, :lista_tutores, :estado_evaluacion
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, zona_alumno, promedio_ponderado)
		super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
		@zona_alumno, @promedio_ponderado = zona_alumno, promedio_ponderado 
		@lista_tutores = []
		@examen_alumno = nil
		@estado_evaluacion = "SIN EVALUAR"
	end
	def validarDatos
		super
	end
	def calificarSocioEconomica
		if zona_alumno == "Rural"
			puntajesc = 100
		elsif zona_alumno == "Urbana"
			puntajesc = 80
		else
			puntajesc = 0
		end
		return puntajesc
	end
	def calificarRendimiento2Grado
		if promedio_ponderado >= 19
			puntajere =100
		elsif promedio_ponderado >= 18 && promedio_ponderado < 19
			puntajere =80
		  elsif promedio_ponderado >= 16 && promedio_ponderado < 18
			puntajere =60
		  elsif promedio_ponderado >= 14 && promedio_ponderado < 16
			puntajere =40
		  elsif promedio_ponderado >= 11 && promedio_ponderado < 14
			puntajere =20
		  else
			puntajere =0
		  end 
		return puntajere
	end
	def calificarEvaluacionConocimiento
		super
	end
	def calcularPuntajeFinal
		super
	end
	def rendirExamen(examen)
		super
	end
	def registrarTutor(nuevoTutor)
		super
	end
end  

class AlumnoParticular < Alumno
	attr_accessor :monto_pension, :puesto_obtenido, :examen_alumno, :lista_tutores, :estado_evaluacion
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, monto_pension, puesto_obtenido)
		super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
		@monto_pension, @puesto_obtenido = monto_pension, puesto_obtenido  
		@lista_tutores = []
		@examen_alumno = nil
		@estado_evaluacion = "SIN EVALUAR"
	end
	
	def calificarSocioEconomica
		if monto_pension <= 200
			puntajesc =90
		elsif monto_pension > 200 && monto_pension <= 400
			puntajesc =70
		elsif monto_pension > 400 && monto_pension <= 600
			puntajesc =70
		elsif monto_pension > 600
			puntajesc =20
		else
			puntajesc =0
		end
	  return puntajesc  
	end

	def calificarRendimiento2Grado
		if puesto_obtenido < 20
			puntajere=0
		  elsif puesto_obtenido >= 11 && puesto_obtenido < 20
			puntajere =40
		  elsif puesto_obtenido >= 6 && puesto_obtenido <= 10
			puntajere =60
		  elsif puesto_obtenido >= 4 && puesto_obtenido <= 5
			puntajere =80
		  elsif puesto_obtenido <= 3
			puntajere =100
		  else
			puntajere=0
		  end
		return puntajere 
	end
	def calificarEvaluacionConocimiento
		super
	end
	def calcularPuntajeFinal
		super
	end
	def rendirExamen(examen)
		super
	end
	def registrarTutor(nuevoTutor)
		super
	end
	def validarDatos
		super
	end
end

class Administrador
	attr_accessor :lista_examenes, :lista_postulantes, :lista_colegios
	def initialize
		@lista_examenes, @lista_postulantes, @lista_colegios = [], [], []
	end
	def registrarColegio(nuevoColegio)
		lista_colegios.push(nuevoColegio)
	end
	# configuracion Examen
	def crearExamen(nuevoExamen)
		lista_examenes.push(nuevoExamen)
	end
	def registrarPostulante(nuevoAlumno)
		lista_postulantes.push(nuevoAlumno)
	end
	def obtenerAlumno(dniPostulante)
		datos = nil
		for alumno in lista_postulantes
			if alumno.dni_alumno.to_s == dniPostulante.to_s
				datos = alumno
			end
		end
		return datos
	end
	def obtenerExamen(codigoExamen)
		datos = nil
		for examen in lista_examenes
			if examen.codigo_examen == codigoExamen
				datos = examen
			end
		end
		return datos
	end
	def obtenerColegio(codigoColegio)
		datos = nil
		for colegio in lista_colegios
			if colegio.codigo_colegio == codigoColegio
				datos = colegio
			end
		end
		return datos
	end

	def simuladorExamen(codigoExamen)
		examen = obtenerExamen(codigoExamen)

		opcionAlt = ["a", "b", "c", "d", "e", nil]
		for alumno in lista_postulantes
			examenAlu = Factory.crear("Examen", examen.codigo_examen, examen.cantidad_preguntas)
			examenAlu.listaRespuestasValida = examen.listaRespuestasValida

			rCorrectas = examenAlu.listaRespuestasValida
			limite = examenAlu.cantidad_preguntas
			
			loop do
				cont = 0
				for nPreg in 1..limite
					correcto = rand(0..1)
					if correcto == 1
						cont = cont + 1
						examenAlu.registrarRespuestaAlumno( nPreg, rCorrectas[nPreg-1].opcion )
					else
						examenAlu.registrarRespuestaAlumno( nPreg, opcionAlt[rand(0..5)] )
					end
				end 
				# using boolean expressions 
				if cont > (limite/2) && 2 >= examenAlu.calcularPreguntasSinRespuesta
					break
				end
				# ending  do..while loop  
			end
			alumno.rendirExamen(examenAlu)
			#alumno.examen_alumno = examenAlu
		end
		procesarResultadosConcurso
	end
	def procesarResultadosConcurso
		lista = lista_postulantes.sort_by{|p| p.calcularPuntajeFinal}.reverse
		cont = 0
		colegio = lista_colegios[0]
		for alumno in lista
			if cont < colegio.cantidad_vacantes #alumno.colegio == "cod_colegio" && 
				alumno.estado_evaluacion = "INGRESA"
				cont = cont + 1
			else
				alumno.estado_evaluacion = "NO INGRESA" 
			end
		end
	end
	def listaIngresantes
		lista = []
		for p in lista_postulantes.sort_by{|p| p.calcularPuntajeFinal}.reverse
			if p.estado_evaluacion == "INGRESA"
				lista.push(p)
			end
		end
		return lista
	end
	def listaNoIngresantes
		lista = []
		for p in lista_postulantes.sort_by{|p| p.calcularPuntajeFinal}.reverse
			if p.estado_evaluacion == "NO INGRESA"
				lista.push(p)
			end
		end
		return lista
	end
end

class Factory
	def self.crear(tipo, *args)
		case tipo
		when "AlumnoNacional"
			AlumnoNacional.new(args[0], args[1], args[2], args[3], args[4], args[5], args[6])
		when "AlumnoParticular"
			AlumnoParticular.new(args[0], args[1], args[2], args[3], args[4], args[5], args[6])
		when "Tutor"
			Tutor.new(args[0], args[1], args[2], args[3])
		when "Examen"
			Examen.new(args[0], args[1])
		when "Colegio"
			Colegio.new(args[0], args[1], args[2])
		end
	end
end


