
class Vista
	def imprimirDetallesAlumno(alum)	
  		puts "*********** DETALLE ALUMNO *************"
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + " EDAD".ljust(15) + "GENERO".ljust(15)
		puts "#{alum.dni_alumno}".ljust(15) + "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35) + " #{alum.edad_alumno}".ljust(15) + "#{alum.genero_alumno}".ljust(15)
	end	
	def imprimirResultadosAlumno(alum)
		exam = alum.examen_alumno
  		puts "*********** DETALLE RESULTADOS ALUMNO *************"
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + " EDAD".ljust(15) + "GENERO".ljust(15)
		puts "#{alum.dni_alumno}".ljust(15) + "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35) + " #{alum.edad_alumno}".ljust(15) + "#{alum.genero_alumno}".ljust(15)
		
		#for i in 0...exam.cantidad_preguntas
		#	rptA =  exam.listaRespuestasAlumno[i]
		#	rptV =  exam.listaRespuestasValida[i]
		#	#if i == 0 then  puts "R.MARCADAS".ljust(23) +   "R.CORRECTAS".ljust(17) end
		#	#puts " #{rptA.codigo}".ljust(3) + "#{rptA.opcion}".ljust(20) +    "           #{rptV.codigo}".ljust(2) + "#{rptV.opcion}".ljust(15)
		#end
		puts ""
		puts "RESULTADOS DE EXAMEN"
		puts "EXAMEN".ljust(15) + "R.CORRECTAS".ljust(15) + "R.INCORRECTAS".ljust(15) + "R.VACIAS".ljust(15) + "PUNTAJE EXAMEN".ljust(15)
		puts "#{exam.codigo_examen}".ljust(15) + "#{exam.calcularPreguntasCorrectas}".ljust(15) + "#{exam.calcularPreguntasIncorrectas}".ljust(15) + "#{exam.calcularPreguntasSinRespuesta}".ljust(15) + "#{exam.calcularPuntaje}".ljust(15)
		puts ""
		puts "CALIFICACION SOCIOECONOMICA (SC)".ljust(35) + ":" + " #{alum.calificarSocioEconomica}".rjust(15)
		puts "RENDIMIENTO 2DO GRADO(RV)".ljust(35) + ":" + " #{alum.calificarRendimiento2Grado}".rjust(15)
		puts "EVAL. CONOCIMIENTO (EC).".ljust(35) + ":" + " #{alum.calificarEvaluacionConocimiento}".rjust(15)
		puts ""
		puts "PUNTAJE".ljust(35) + ":" + " #{alum.calcularPuntajeFinal}".rjust(15)
		puts "ESTADO DE POSTULACION".ljust(35) + ":" + " #{alum.estadoFinal}".rjust(15)
		puts ""
	end	

	def imprimirTutorAlumno(alum)
  		puts "*********** DETALLE TUTORES DE ALUMNO *************"
		puts "TUTORES DEL ALUMNO: "+ "#{alum.dni_alumno}".ljust(8) + "-"+  "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35)
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + "PARENTESCO".ljust(15)
		tutores = alum.lista_tutores
		for tut in tutores
			puts "#{tut.dni_tutor}".ljust(15) + "#{tut.apellidos_tutor}, #{tut.nombres_tutor}".ljust(35) + "#{tut.parentesco}".ljust(15)
		end
	end
	def imprimirCantidadDe(texto, cant)
		puts "#{texto}".ljust(40) + ":" + " #{cant}".rjust(8)
	end
	def imprimirPorcentajeDe(texto, cant)
		puts "#{texto}".ljust(40) + ":" + " #{cant}".rjust(8) + "%"
	end

	def separador
		puts "---------------------------------------------------------------------------------------------------"
	end

	def imprimirResultadosConcurso(lista)
		puts "*********** RESSULTADOS DEL CONCURSO DE ADMISION *************"
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + "P.SOCIOECON.".ljust(15) + "P.REN.2DO".ljust(15) + "EV.CONOC.".ljust(15) + "PUNTAJE".ljust(15) + "ESTADO".ljust(15)
		for alum in lista
			print "#{alum.dni_alumno}".ljust(15) + "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35)
			puts "#{alum.calificarSocioEconomica}".ljust(15)  +  "#{alum.calificarRendimiento2Grado}".ljust(15) +  "#{alum.calificarEvaluacionConocimiento}".ljust(15)  + "#{alum.calcularPuntajeFinal}".ljust(15)  + "#{alum.estadoFinal}".ljust(15)
		end
	end
	def imprimirResultadosIngresantes(lista)
		puts "*********** RESSULTADOS DEL CONCURSO DE ADMISION (INGRESANTES) *************"
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + "P.SOCIOECON.".ljust(15) + "P.REN.2DO".ljust(15) + "EV.CONOC.".ljust(15) + "PUNTAJE".ljust(15) + "ESTADO".ljust(15)
		for alum in lista
			print "#{alum.dni_alumno}".ljust(15) + "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35)
			puts "#{alum.calificarSocioEconomica}".ljust(15)  +  "#{alum.calificarRendimiento2Grado}".ljust(15) +  "#{alum.calificarEvaluacionConocimiento}".ljust(15)  + "#{alum.calcularPuntajeFinal}".ljust(15)  + "#{alum.estadoFinal}".ljust(15)
		end
	end
	def imprimirResultadosNoIngresantes(lista)
		puts "*********** RESSULTADOS DEL CONCURSO DE ADMISION (NO INGRESANTES) *************"
		puts "DNI".ljust(15) + "APELLIDOS, NOMBRES".ljust(35) + "P.SOCIOECON.".ljust(15) + "P.REN.2DO".ljust(15) + "EV.CONOC.".ljust(15) + "PUNTAJE".ljust(15) + "ESTADO".ljust(15)
		for alum in lista
			print "#{alum.dni_alumno}".ljust(15) + "#{alum.apellidos_alumno}, #{alum.nombres_alumno}".ljust(35)
			puts "#{alum.calificarSocioEconomica}".ljust(15)  +  "#{alum.calificarRendimiento2Grado}".ljust(15) +  "#{alum.calificarEvaluacionConocimiento}".ljust(15)  + "#{alum.calcularPuntajeFinal}".ljust(15)  + "#{alum.estadoFinal}".ljust(15)
		end
	end


	def mensajeError(m)
		puts "Error: #{m}"
	end
	def imprimirValido(m)
		puts m
	end

end


