require './modelo.rb'
require './vista.rb'


class Controlador
	attr_accessor :vista, :modelo
	def initialize(vista, modelo)
		@vista, @modelo = vista, modelo
		@examenRealizado = false
	end

	def configDemo
		
		registrar("Colegio", "01", "SAN BUENAVENTURA", 1)
		registrar("Examen", "EXA01", 10)
		exam = configurarExamen("EXA01")

		opcion = ["a", "b", "c", "d", "e"]
		#modelo Rapido Examen
		for p in 1..(exam.cantidad_preguntas)
			exam.registrarPregunta( p, "Pregunta #{p}")
			for r in 0...5
				#alternativas de las respuestas ( 5 ) => ["a", "b", "c", "d", "e"]
				exam.registrarRespuesta(p, opcion[r], "respuesta #{opcion[r]}")
			end
			opcionValida = opcion[ rand(0...5) ]
			exam.registrarRespuestaValida(p, opcionValida)
		end
	end
	def SimularEvaluacion(codigo)
		modelo.simuladorExamen(codigo)
		@examenRealizado = true
		vista.imprimirValido("Evaluacion Simulada #{codigo} en #{modelo.lista_postulantes.size} postulantes(s)")
	end

	def registrar(tipo, *datos)
		begin
			if tipo == "Colegio"
				nuevoColegio = Factory.crear("Colegio", *datos)
        		nuevoColegio.validarDatos
				raise  "El colegio ya existe : #{nuevoColegio.codigo_colegio}" if modelo.obtenerColegio(nuevoColegio.codigo_colegio) != nil
				modelo.registrarColegio(nuevoColegio)
				vista.imprimirValido("Colegio registrado")

			elsif tipo == "Examen"
				nuevoExamen = Factory.crear(tipo, *datos)
				nuevoExamen.validarDatos
				raise  "El examen ya existe : #{nuevoExamen.codigo_examen}" if modelo.obtenerExamen(nuevoExamen.codigo_examen) != nil
				modelo.crearExamen(nuevoExamen)
				vista.imprimirValido("Examen registrado")

			elsif tipo == "AlumnoNacional" || tipo == "AlumnoParticular"
				nuevoAlumno = Factory.crear(tipo, *datos)
				nuevoAlumno.validarDatos
				raise  "El alumno ya existe : #{nuevoAlumno.dni_alumno}" if modelo.obtenerAlumno(nuevoAlumno.dni_alumno) != nil
				modelo.registrarPostulante(nuevoAlumno)
				vista.imprimirValido("Postulante registrado")

			elsif tipo == "Tutor"
				nuevoTutor = Factory.crear(tipo, datos[1], datos[2], datos[3], datos[4])
				nuevoTutor.validarDatos
				raise  "El alumno no existe : #{datos[0]}.Tutor no registrado" if modelo.obtenerAlumno(datos[0]) == nil

				alum = modelo.obtenerAlumno(datos[0])
				raise  "El limite alcanzado para tutores" if modelo.obtenerAlumno(alum.dni_alumno).lista_tutores.size > 1
				alum.registrarTutor(nuevoTutor)
				vista.imprimirValido("Tutor registrado")

			end
        rescue Exception => e
			vista.mensajeError(e.message)
        end
	end

	def configurarExamen(codigoExamen)
		begin
			exam = modelo.obtenerExamen(codigoExamen)
			raise  "El examen no existe : #{codigoExamen}" if exam == nil
			return exam
		rescue Exception => e
			vista.mensajeError(e.message)
		end
	end
    
    
	def mostrarDatosAlumno(dniPostulante)
		begin
			alumno = modelo.obtenerAlumno( dniPostulante )
			raise  "El alumno no existe : #{dniPostulante}" if alumno == nil
			
			if alumno.examen_alumno
				vista.imprimirResultadosAlumno( alumno )
			else
				vista.imprimirDetallesAlumno( alumno )
			end
		rescue Exception => e
			vista.mensajeError(e.message)
		end
    end
    def mostrarTutoresAlumno(dniPostulante)
    	begin
    		
        alumno = modelo.obtenerAlumno( dniPostulante )
        raise  "El alumno no existe : #{dniPostulante}" if alumno == nil	
		vista.imprimirTutorAlumno( alumno )
    	rescue Exception => e
			vista.mensajeError(e.message)
    	end
    end

	def publicarResultadosExamen
		lista = modelo.lista_postulantes.sort_by{|p| p.apellidos_alumno}
		vista.imprimirResultadosConcurso( lista )
    end

	def publicarResultadosIngresantes
		lista = modelo.listaIngresantes
		vista.imprimirResultadosIngresantes( lista )
    end

	def publicarResultadosNoIngresantes
		lista = modelo.listaNoIngresantes
		vista.imprimirResultadosNoIngresantes( lista )
    end

	def mostrarCantidadPostulantesMasculinos
		cant = 0
		for p in modelo.lista_postulantes
			if p.genero_alumno == "Masculino"
				cant = cant + 1
			end
		end
		vista.imprimirCantidadDe("# Postulantes Masculino", cant)
    end
    def mostrarCantidadPostulantesFemeninos
		cant = 0
		for p in modelo.lista_postulantes
			if p.genero_alumno == "Femenino"
				cant = cant + 1
			end
		end
		vista.imprimirCantidadDe("# Postulantes Femenino", cant)
    end
    def mostrarCantidadAlumnosIngresantes
		vista.imprimirCantidadDe("# Postulantes Ingrsantes", modelo.listaIngresantes.size)
    end
    def mostrarCantidadAlumnosNoIngresantes
		vista.imprimirCantidadDe("# Postulantes No Ingrsantes", modelo.listaNoIngresantes.size)
    end



    def mostrarPorcentajeIngresantesMasculinoFemenico
		cant = 0
		cant2 = 0
		total = modelo.listaIngresantes.size
		for p in modelo.listaIngresantes
			if p.genero_alumno == "Masculino"
				cant = cant + 1
			elsif p.genero_alumno == "Femenino"
				cant2 = cant2 + 1
			end
		end
		vista.imprimirCantidadDe("# Ingrsantes Masculino", (cant*100.0/total).round(2) )
		vista.imprimirCantidadDe("# Ingrsantes Femenino", (cant2*100.0/total).round(2) )
    end

    def mostrarPorcentajeNoIngresantesMaculinoFemenino
		cant = 0
		cant2 = 0
		total = modelo.listaNoIngresantes.size
		for p in modelo.listaNoIngresantes
			if p.genero_alumno == "Masculino"
				cant = cant + 1
			elsif p.genero_alumno == "Femenino"
				cant2 = cant2 + 1
			end
		end
		vista.imprimirPorcentajeDe("% No Ingrsantes Masculino", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingrsantes Femenino", (cant2*100.0/total).round(2) )
	end

    def mostrarPorcentajeIngresantesNacionalesParticulares
		cant = 0
		cant2 = 0
		total = modelo.listaIngresantes.size
		for p in modelo.listaIngresantes
			if p.class.to_s == "AlumnoNacional"
				cant = cant + 1
			elsif p.class.to_s == "AlumnoParticular"
				cant2 = cant2 + 1
			end
		end
		vista.imprimirPorcentajeDe("% Ingrsantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% Ingrsantes Alumnos Particular", (cant2*100.0/total).round(2) )   
	end

    def mostrarPorcentajeNoIngresantesNacionalesParticulares
		cant = 0
		cant2 = 0
		total = modelo.listaNoIngresantes.size
		for p in modelo.listaNoIngresantes
			if p.class.to_s == "AlumnoNacional"
				cant = cant + 1
			elsif p.class.to_s == "AlumnoParticular"
				cant2 = cant2 + 1
			end
		end
		vista.imprimirPorcentajeDe("% No Ingrsantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingrsantes Alumnos Particular", (cant2*100.0/total).round(2) )
	end

	def mostrarPorcentajeNoIngresantesNacionalesParticulares
		cant = 0
		cant2 = 0
		total = modelo.listaNoIngresantes.size
		for p in modelo.listaNoIngresantes
			if p.class.to_s == "AlumnoNacional"
				cant = cant + 1
			elsif p.class.to_s == "AlumnoParticular"
				cant2 = cant2 + 1
			end
		end
		vista.imprimirPorcentajeDe("% No Ingrsantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingrsantes Alumnos Particular", (cant2*100.0/total).round(2) )
	end


    def mostrarCantidadIngresantesXEdades
		cant = 0
		cant2 = 0
		cant3 = 0
		cant4 = 0
		cant5 = 0
		for p in modelo.listaIngresantes
			if p.edad_alumno == 11
				cant = cant + 1
			elsif p.edad_alumno == 12
				cant2 = cant2 +1
			elsif p.edad_alumno == 13
				cant3 = cant3 +1
			elsif p.edad_alumno == 14
				cant4 = cant4 +1
			elsif p.edad_alumno == 15
				cant5 = cant5 +1
			end
		end
		vista.imprimirCantidadDe("# Ingrsantes 11 años", cant )
		vista.imprimirCantidadDe("# Ingrsantes 12 años", cant2)
		vista.imprimirCantidadDe("# Ingrsantes 13 años", cant3)
		vista.imprimirCantidadDe("# Ingrsantes 14 años", cant4)
		vista.imprimirCantidadDe("# Ingrsantes 15 años", cant5)
    end
 	def mostrarCantidadNoIngresantesXEdades
		cant = 0
		cant2 = 0
		cant3 = 0
		cant4 = 0
		cant5 = 0
		for p in modelo.listaNoIngresantes
			if p.edad_alumno == 11
				cant = cant + 1
			elsif p.edad_alumno == 12
				cant2 = cant2 +1
			elsif p.edad_alumno == 13
				cant3 = cant3 +1
			elsif p.edad_alumno == 14
				cant4 = cant4 +1
			elsif p.edad_alumno == 15
				cant5 = cant5 +1
			end
		end
		vista.imprimirCantidadDe("# No Ingrsantes 11 años", cant )
		vista.imprimirCantidadDe("# No Ingrsantes 12 años", cant2)
		vista.imprimirCantidadDe("# No Ingrsantes 13 años", cant3)
		vista.imprimirCantidadDe("# No Ingrsantes 14 años", cant4)
		vista.imprimirCantidadDe("# No Ingrsantes 15 años", cant5)
    end


    def resultadosEstadisicos
		mostrarCantidadPostulantesMasculinos
		mostrarCantidadPostulantesFemeninos
		vista.separador
		mostrarCantidadAlumnosIngresantes
		mostrarCantidadAlumnosNoIngresantes
    end
    def resultadosEvaluacion
		if @examenRealizado != false
			mostrarPorcentajeIngresantesMasculinoFemenico
			vista.separador
			mostrarPorcentajeNoIngresantesMaculinoFemenino
			vista.separador
			mostrarPorcentajeIngresantesNacionalesParticulares
			vista.separador
			mostrarPorcentajeNoIngresantesNacionalesParticulares
			vista.separador
			mostrarCantidadIngresantesXEdades
			vista.separador
			mostrarCantidadNoIngresantesXEdades
		end
    end
end


#Inicio Configuraciones Previas
modelo = Administrador.new
vista = Vista.new


# crear 
controlador = Controlador.new(vista, modelo)

#controlador.configDemo  # crea colegio con sus datos, crea examen con codigo EXA01 de 10 y registra sus preguntas y la lista de respuestas que deben ser validas(ejemplo a modo RAMDON)


puts "---------------------------------------------------------------------------------------------------"
#crear Colegio 


#crear el examen
controlador.registrar("Colegio", "01", "SAN BUENAVENTURA", 15)
controlador.registrar("Examen", "EXA01", 10)

puts "---------------------------------------------------------------------------------------------------"
# CONFIGURACION DE EXAMEN
exam = controlador.configurarExamen("EXA01")
opcion = ["a", "b", "c", "d", "e"]
# modelo Rapido Examen
# exam.registrarPregunta( codigo pregunta,  "Texto del enunciado pregunta")
# exam.registrarRespuesta( codigo pregunta, "opcion" , "Texto respuesta de la opcion ")
# exam.registrarRespuestaValida( codigo pregunta, "opcion que es la correcta")

for p in 1..(exam.cantidad_preguntas)
	exam.registrarPregunta( p, "Pregunta #{p}: Texto del enunciado.")
	for r in 0...5
		#alternativas de las respuestas ( 5 ) => ["a", "b", "c", "d", "e"]
		exam.registrarRespuesta( p, opcion[r], "respuesta #{opcion[r]}.")
	end
		opcionValida = opcion[ rand(0...5) ]
		exam.registrarRespuestaValida( p, opcionValida)
end




puts "---------------------------------------------------------------------------------------------------"
# CREANDO  REGISTROS FANTASMA DE ALUMNOS, DATOS RANDON 
# controlador.registrar("AlumnoNacional" , DNI del alumno, ***otros datos del alumno***)
# controlador.registrar("Tutor" , DNI del alumno , ***otros datos del tutor***)
# 
dni = 12300000
for i in 0...20
	dni = dni + 2
	controlador.registrar("AlumnoNacional", dni, "APELLIDO ALUMNO", "NOMBRE ALUMNO", rand(11..15), ["Masculino","Femenino"].sample, ["Rural","Urbano"].sample, rand(8..20))
end
for i in 0...15
	dni = dni + 2
	controlador.registrar("AlumnoParticular", dni, "APELLIDO ALUMNO", "NOMBRE ALUMNO", rand(11..15), ["Masculino","Femenino"].sample, [ 150, 300, 500, 700].sample, rand(1..25))
end


puts "---------------------------------------------------------------------------------------------------"
controlador.SimularEvaluacion("EXA01")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("12300002")
puts "---------------------------------------------------------------------------------------------------"
controlador.registrar("Tutor", "12300002", "23900000", "TUTOR TUTOR", "TUTOR", "PADRE")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarTutoresAlumno("12300002")
puts "---------------------------------------------------------------------------------------------------"
controlador.resultadosEvaluacion
puts "---------------------------------------------------------------------------------------------------"
controlador.resultadosEstadisicos
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("12300000")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("12300002")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarTutoresAlumno("12300002")
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosExamen
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosIngresantes
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosNoIngresantes
puts "---------------------------------------------------------------------------------------------------"
