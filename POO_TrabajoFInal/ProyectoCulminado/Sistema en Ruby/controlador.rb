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
		vista.imprimirCantidadDe("# Postulantes Ingresantes", modelo.listaIngresantes.size)
    end
    def mostrarCantidadAlumnosNoIngresantes
		vista.imprimirCantidadDe("# Postulantes No Ingresantes", modelo.listaNoIngresantes.size)
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
		vista.imprimirCantidadDe("# Ingresantes Masculino", (cant*100.0/total).round(2) )
		vista.imprimirCantidadDe("# Ingresantes Femenino", (cant2*100.0/total).round(2) )
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
		vista.imprimirPorcentajeDe("% No Ingresantes Masculino", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingresantes Femenino", (cant2*100.0/total).round(2) )
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
		vista.imprimirPorcentajeDe("% Ingresantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% Ingresantes Alumnos Particular", (cant2*100.0/total).round(2) )   
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
		vista.imprimirPorcentajeDe("% No Ingresantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingresantes Alumnos Particular", (cant2*100.0/total).round(2) )
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
		vista.imprimirPorcentajeDe("% No Ingresantes Alumnos Nacional", (cant*100.0/total).round(2) )
		vista.imprimirPorcentajeDe("% No Ingresantes Alumnos Particular", (cant2*100.0/total).round(2) )
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
		vista.imprimirCantidadDe("# Ingresantes 11 años", cant )
		vista.imprimirCantidadDe("# Ingresantes 12 años", cant2)
		vista.imprimirCantidadDe("# Ingresantes 13 años", cant3)
		vista.imprimirCantidadDe("# Ingresantes 14 años", cant4)
		vista.imprimirCantidadDe("# Ingresantes 15 años", cant5)
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
		vista.imprimirCantidadDe("# No Ingresantes 11 años", cant )
		vista.imprimirCantidadDe("# No Ingresantes 12 años", cant2)
		vista.imprimirCantidadDe("# No Ingresantes 13 años", cant3)
		vista.imprimirCantidadDe("# No Ingresantes 14 años", cant4)
		vista.imprimirCantidadDe("# No Ingresantes 15 años", cant5)
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
controlador.registrar("Colegio", "01", "SAN BUENAVENTURA", 20)
controlador.registrar("Colegio", "02", "SANTIAGO APOSTOL", 5)
controlador.registrar("Colegio", "03", "JORGE CHAVEZ", 10)

#crear el examen
controlador.registrar("Examen", "EXA01", 10)
controlador.registrar("Examen", "EXA02", 10)
controlador.registrar("Examen", "EXA03", 10)

puts "---------------------------------------------------------------------------------------------------"
# CONFIGURACION DE EXAMEN
exam = controlador.configurarExamen("EXA01")
opcion = ["a", "b", "c", "d", "e"]

# modelo Rapido Examen
# exam.registrarPregunta( codigo pregunta,  "Texto del enunciado pregunta")
# exam.registrarRespuesta( codigo pregunta, "opcion" , "Texto respuesta de la opcion ")
# exam.registrarRespuestaValida( codigo pregunta, "opcion que es la correcta")

exam.registrarPregunta("CP001","Cuantas manzanas rojas se encuentran en el arbol")
exam.registrarRespuesta("CP001", "a" , "3")
exam.registrarRespuesta("CP001", "b" , "4")
exam.registrarRespuesta("CP001", "c" , "5")
exam.registrarRespuesta("CP001", "d" , "7")
exam.registrarRespuesta("CP001", "e" , "8")
exam.registrarRespuestaValida("CP001", "b")

exam.registrarPregunta("CP002","Cuantas peras verdes se encuentran en la canastao")
exam.registrarRespuesta("CP002", "a" , "3")
exam.registrarRespuesta("CP002", "b" , "4")
exam.registrarRespuesta("CP002", "c" , "5")
exam.registrarRespuesta("CP002", "d" , "7")
exam.registrarRespuesta("CP002", "e" , "8")
exam.registrarRespuestaValida("CP002", "a")

exam.registrarPregunta("CP003","Cuantos policias estan con el uniforme")
exam.registrarRespuesta("CP003", "a" , "3")
exam.registrarRespuesta("CP003", "b" , "4")
exam.registrarRespuesta("CP003", "c" , "5")
exam.registrarRespuesta("CP003", "d" , "7")
exam.registrarRespuesta("CP003", "e" , "8")
exam.registrarRespuestaValida("CP003", "e")

exam.registrarPregunta("CP004","Cuantas bomberos estan apagando el incendio")
exam.registrarRespuesta("CP004", "a" , "3")
exam.registrarRespuesta("CP004", "b" , "4")
exam.registrarRespuesta("CP004", "c" , "5")
exam.registrarRespuesta("CP004", "d" , "7")
exam.registrarRespuesta("CP004", "e" , "8")
exam.registrarRespuestaValida("CP004", "d")

exam.registrarPregunta("CP005","Cuanto es la suma de 3 + 4")
exam.registrarRespuesta("CP005", "a" , "3")
exam.registrarRespuesta("CP005", "b" , "4")
exam.registrarRespuesta("CP005", "c" , "5")
exam.registrarRespuesta("CP005", "d" , "7")
exam.registrarRespuesta("CP005", "e" , "8")
exam.registrarRespuestaValida("CP005", "d")

exam.registrarPregunta("CP006","Cuanto sale al dividir 40 entre 8")
exam.registrarRespuesta("CP006", "a" , "3")
exam.registrarRespuesta("CP006", "b" , "4")
exam.registrarRespuesta("CP006", "c" , "5")
exam.registrarRespuesta("CP006", "d" , "7")
exam.registrarRespuesta("CP006", "e" , "8")
exam.registrarRespuestaValida("CP006", "c")

exam.registrarPregunta("CP007","Si hoy es lunes, cuantos dias faltan para el jueves")
exam.registrarRespuesta("CP007", "a" , "3")
exam.registrarRespuesta("CP007", "b" , "4")
exam.registrarRespuesta("CP007", "c" , "5")
exam.registrarRespuesta("CP007", "d" , "7")
exam.registrarRespuesta("CP007", "e" , "8")
exam.registrarRespuestaValida("CP007", "a")

exam.registrarPregunta("CP008","Cuantas estaciones tiene el año")
exam.registrarRespuesta("CP008", "a" , "3")
exam.registrarRespuesta("CP008", "b" , "4")
exam.registrarRespuesta("CP008", "c" , "5")
exam.registrarRespuesta("CP008", "d" , "7")
exam.registrarRespuesta("CP008", "e" , "8")
exam.registrarRespuestaValida("CP008", "b")

exam.registrarPregunta("CP009","Si se tiene 10 manzanas y se regalan 7 cuantas me quedan")
exam.registrarRespuesta("CP009", "a" , "3")
exam.registrarRespuesta("CP009", "b" , "4")
exam.registrarRespuesta("CP009", "c" , "5")
exam.registrarRespuesta("CP009", "d" , "7")
exam.registrarRespuesta("CP009", "e" , "8")
exam.registrarRespuestaValida("CP009", "a")

exam.registrarPregunta("CP010","Cuantos son los meses del año")
exam.registrarRespuesta("CP010", "a" , "12")
exam.registrarRespuesta("CP010", "b" , "11")
exam.registrarRespuesta("CP010", "c" , "10")
exam.registrarRespuesta("CP010", "d" , "7")
exam.registrarRespuesta("CP010", "e" , "8")
exam.registrarRespuestaValida("CP010", "a")

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

controlador.registrar("AlumnoNacional", 54863881,"COLLANTES POZA", "CESAR", 12, "Masculino", "Rural", 13)
controlador.registrar("AlumnoNacional", 23376620, "QUINTELA JUAN", "MARIANO", 13, "Masculino", "Urbano", 15)
controlador.registrar("AlumnoNacional", 42664828, "NIETO PARRAS", "IVAN", 12, "Masculino", "Rural", 15)
controlador.registrar("AlumnoNacional", 82288175, "VIVAS PARRILLA", "ALBERT", 12, "Masculino", "Urbano", 13)
controlador.registrar("AlumnoNacional", 60686010, "CORTIJO IGUAL", "VICENTE", 15, "Masculino", "Rural", 12)
controlador.registrar("AlumnoNacional", 27280557, "TENORIO OLMO", "LORENZO", 13, "Masculino", "Urbano", 18)
controlador.registrar("AlumnoNacional", 13023717, "JULIAS AMPER", "PEDRO", 12, "Masculino", "Rural", 14)
controlador.registrar("AlumnoNacional", 64666797, "MAYORGA LUIS", "JUANJOSE", 14, "Masculino", "Urbano", 15)
controlador.registrar("AlumnoNacional", 20585311, "CLEMENTE FELIU", "XAVIER", 11, "Masculino", "Urbano", 17)
controlador.registrar("AlumnoNacional", 78561049, "CASALSADRIAN", "ESTEBAN", 12, "Masculino", "Rural", 13)
controlador.registrar("AlumnoNacional", 76501798, "LOBO CABALEIRO", "JOSEIGNACIO", 14, "Masculino", "Urbano", 16)
controlador.registrar("AlumnoNacional", 83887308, "ANGUITA BLAS", "IGNACIO", 11, "Masculino", "Urbano", 11)
controlador.registrar("AlumnoNacional", 34554297, "BALAGUER POZA", "PABLO", 12, "Masculino", "Rural", 12)
controlador.registrar("AlumnoNacional", 34554298, "BALAGUER POZA", "JORGE", 13, "Masculino", "Rural", 15)
controlador.registrar("AlumnoNacional", 12000728, "DE JESUS AMOROS", "AGUSTIN", 11, "Masculino", "Urbano", 15)
controlador.registrar("AlumnoNacional", 68754516, "TEJEDOR LINARES", "JULIAN", 12, "Masculino", "Urbano", 14)
controlador.registrar("AlumnoNacional", 18337643, "CACHO CHACON", "JOSEMIGUEL", 14, "Masculino", "Urbano", 12)
controlador.registrar("AlumnoNacional", 11888591, "COLORADO CARRILLO", "CAROLINA", 15, "Femenino", "Rural", 14)
controlador.registrar("AlumnoNacional", 49664944, "MALAGON CAMPOS", "NOELIA", 13, "Femenino", "Rural", 13)
controlador.registrar("AlumnoNacional", 26427309, "RODA DEL CAMPO", "LIDIA", 15, "Femenino", "Urbano", 12)

controlador.registrar("Tutor", 54863881, 10863881, "COLLANTES OLIVERAS", "ADRIAN", "PADRE")
controlador.registrar("Tutor", 23376620, 11337662, "QUINTELA JUAN", "JESUS ", "PADRE")
controlador.registrar("Tutor", 42664828, 42664818, "NIETO REVILLA", "CRISTIAN", "PADRE")
controlador.registrar("Tutor", 82288175, 14512288, "VIVAS CLAROS", "JUAN ", "PADRE")
controlador.registrar("Tutor", 60686010, 65106860, "CORTIJO DAZA", "DANIEL ", "PADRE")
controlador.registrar("Tutor", 27280557, 25172805, "TENORIO GIMENEZ", "JOSE RAMON ", "PADRE")
controlador.registrar("Tutor", 13023717, 13023717, "JULIAS ARREBOLA", "SERGIO ", "PADRE")
controlador.registrar("Tutor", 64666797, 65115466, "MAYORGA MAESO", "MARCOS", "PADRE")
controlador.registrar("Tutor", 20585311, 20115158, "CLEMENTE MOLANO", "JOSE MARIA", "PADRE")
controlador.registrar("Tutor", 78561049, 84561049, "CASALSADRIAN LLORENS", "JOSE MANUEL", "PADRE")
controlador.registrar("Tutor", 76501798, 76450179, "LOBO PICO", "MARIO", "PADRE")
controlador.registrar("Tutor", 83887308, 87738873, "ANTIGUA ZUÑIGA", "HECTOR", "PADRE")
controlador.registrar("Tutor", 34554297, 34221125, "BALAGUER LIMA", "CRISTINA", "MADRE")
controlador.registrar("Tutor", 34554298, 12210007, "POZA ETXEBERRIA", "ANGELA", "MADRE")
controlador.registrar("Tutor", 12000728, 68751214, "AMORES CAÑADA", "CELIA", "MADRE")
controlador.registrar("Tutor", 68754516, 18325376, "LINARES GUARDIOLA", "NURIA", "MADRE")
controlador.registrar("Tutor", 18337643, 11121888, "CHACON TUDELA", "ANGELES", "MADRE")
controlador.registrar("Tutor", 11888591, 49466494, "CARRILLO ROMANO", "INMACULADA", "MADRE")
controlador.registrar("Tutor", 49664944, 26114273, "CAMPOS FARIÑA", "ROSA", "MADRE")
controlador.registrar("Tutor", 26427309, 20141365, "DEL CAMPO BELLES", "IRENE", "MADRE")

controlador.registrar("AlumnoParticular", 45145705,"CHACON CAMPOS", "MARIA", 12, "Femenino", 150, 7)
controlador.registrar("AlumnoParticular", 40124523,"DE JESUS LOBO", "LUS", 11, "Masculino", 200, 5)
controlador.registrar("AlumnoParticular", 74520124,"COLORADO MALAGA", "KAREN", 13, "Femenino", 600, 2)
controlador.registrar("AlumnoParticular", 35247854,"CASTILLO ROJAS", "MIGUEL", 14, "Masculino", 220, 10)
controlador.registrar("AlumnoParticular", 25478214,"REYES REYES", "CARLOS", 12, "Masculino", 185, 12)
controlador.registrar("AlumnoParticular", 36547896,"CISNEROS PERES", "AINER", 12, "Masculino", 220, 6)
controlador.registrar("AlumnoParticular", 45124575,"RUIZ GOMEZ", "KELYN", 14, "Femenino", 300, 4)
controlador.registrar("AlumnoParticular", 45415101,"LOPEZ ARIAS", "NORMA", 13, "Femenino", 270, 1)
controlador.registrar("AlumnoParticular", 55255315,"URCOS TRUCIOS", "FELIPE", 11, "Masculino", 170, 8)
controlador.registrar("AlumnoParticular", 61616814,"TERREROS GOMEZ", "PAULO", 14, "Masculino", 330, 9)
controlador.registrar("AlumnoParticular", 46161618,"HUERTA FLORES", "MAGALLY", 11, "Femenino", 190, 9)
controlador.registrar("AlumnoParticular", 68661874,"RODRIGUEZ PEREZ", "KATHERINE", 12, "Femenino", 190,	11)
controlador.registrar("AlumnoParticular", 46161643,"PEREZ PEREZ", "DORIS", 14, "Femenino", 250,	15)
controlador.registrar("AlumnoParticular", 61616914,"LONGA DI PAOLA", "JORGE", 13, "Masculino", 120, 13)
controlador.registrar("AlumnoParticular", 34346486,"SILVA NUNEZ", "ANTONIO", 15, "Masculino", 300, 3)

controlador.registrar("Tutor", 45145705, 58114511, "CAMPOS SORIANO", "LUISA", "MADRE")
controlador.registrar("Tutor", 40124523, 14242444, "DE JESUS LOPEZ", "JUAN", "PADRE")
controlador.registrar("Tutor", 74520124, 32457896, "COLORADO COLORADO", "LUIS", "PADRE")
controlador.registrar("Tutor", 35247854, 45781245, "ROJAS NEGREIRO", "ROSA", "MADRE")
controlador.registrar("Tutor", 25478214, 23568978, "REYES FELIPA", "JORGE", "PADRE")
controlador.registrar("Tutor", 36547896, 78451256, "CISNEROS CASTILLO", "PAULO", "PADRE")
controlador.registrar("Tutor", 45124575, 12457845, "GOMEZ SIFUENTES", "MARIA", "MADRE")
controlador.registrar("Tutor", 45415101, 15487542, "ARIAS VIGIL", "FIORELLA", "MADRE")
controlador.registrar("Tutor", 55255315, 26594878, "TRUCIOS VEGA", "MAGALY", "MADRE")
controlador.registrar("Tutor", 61616814, 32547841, "GOMEZ VACA", "GIOVANNA", "MADRE")
controlador.registrar("Tutor", 46161618, 24578965, "HUERTA FLORES", "JUAN", "PADRE")
controlador.registrar("Tutor", 68661874, 35148256, "RODRIGUEZ GUTIERREZ", "OMAR", "PADRE")
controlador.registrar("Tutor", 46161643, 12451245, "PEREZ CARTI", "JEAN", "PADRE")
controlador.registrar("Tutor", 61616914, 31649785, "LONGA HIDALGO", "JOSE LUIS", "PADRE")
controlador.registrar("Tutor", 34346486, 89415236, "SILVA PINTO", "KEVIN", "PADRE")

puts "---------------------------------------------------------------------------------------------------"
controlador.SimularEvaluacion("EXA01")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("25478214")
puts "---------------------------------------------------------------------------------------------------"
controlador.registrar("Tutor", 83887308, 87738874, "BLAS FLORES", "MARIA", "MADRE")
controlador.registrar("Tutor", 83887308, 45127845, "BLAS FLORES", "VICTORIA", "TIA")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarTutoresAlumno("78561049")
puts "---------------------------------------------------------------------------------------------------"
controlador.resultadosEvaluacion
puts "---------------------------------------------------------------------------------------------------"
controlador.resultadosEstadisicos
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("34554298")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarDatosAlumno("26427309")
puts "---------------------------------------------------------------------------------------------------"
controlador.mostrarTutoresAlumno("64666797")
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosExamen
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosIngresantes
puts "---------------------------------------------------------------------------------------------------"
controlador.publicarResultadosNoIngresantes
puts "---------------------------------------------------------------------------------------------------"
