
class Tutor
	attr_accessor :dni_tutor, :apellidos_tutor, :nombre_tutor, :parentesco
	def initialize( dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
	 @dni_tutor, @apellidos_tutor, @nombre_tutor, @parentesco = dni_tutor, apellidos_tutor, nombre_tutor, parentesco
	end
	def validarDatos
        raise  "El dni no se ha ingresado" if (dni_tutor==nil)
        raise  "El apellido no se ha ingresado" if (apellidos_tutor==nil)
        raise  "El nombre no se ha ingresado" if (nombre_tutor==nil)
        raise  "El parentesco no se ha ingresado" if (parentesco==nil)
        raise  "El numero de dni es invalido por la cantidad de digitos : #{dni_tutor}" if (dni_tutor.size != 8)
        true
    end
    def validarRegistro(lista)
        raise  "El limite alcanzado para tutores" if lista.size == 2
        for tutor in lista
            raise  "El tutor ya existe : #{dni_tutor}" if tutor.dni_tutor == dni_tutor
        end
        true
    end
end

class Alumno
	attr_accessor :dni_alumno, :apellidos_alumno, :nombres_alumno, :edad_alumno, :genero_alumno
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
		@dni_alumno, @apellidos_alumno, @nombres_alumno, @edad_alumno, @genero_alumno = dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno
	end
	def calificarSocioEconomica 
    end
	def calificarRendimiento2Anio
	end
    def calificarEvaluacionConocimiento

    end
	def calcularPuntajeFinal
		return (calificarSocioEconomica*0.2) + (calificarSocioEconomica*0.30) + (calificarEvaluacionConocimiento*0.50)
	end

	def rendirExamen(examen)
	end

	def registrarTutor(*datosTutor)
		begin
            nuevoTutor = Factory.crear("Tutor",*datosTutor)
            nuevoTutor.validarDatos
            nuevoTutor.validarRegistro(lista_tutores)
            lista_tutores.push(nuevoTutor)
        rescue Exception => e
            raise e.message
        end
    end
    def validarDatos
		raise  "El dni no se ha ingresado" if (dni_alumno==nil)
        raise  "El apellido no se ha ingresado" if (apellidos_alumno==nil || apellidos_alumno=="")
        raise  "El nombre no se ha ingresado" if (nombres_alumno==nil || nombres_alumno=="")
        raise  "La edad no se ha ingresado" if (edad_alumno==nil)
        raise  "El genero no se ha ingresado" if (genero_alumno==nil || genero_alumno=="")
        raise  "El numero de dni es invalido por la cantidad de digitos : #{dni_alumno}" if (dni_alumno.length != 8 )
        raise  "la edad debe ser entre '11 - 15' : #{edad_alumno}" if (edad_alumno < 11 && edad_alumno > 15)
        raise  "El genero debe ser Masculino o Femenino : #{genero_alumno}" if (genero_alumno != "Masculino" && genero_alumno != "Femenino")
        
        true
	end
	def validarRegistro(lista)
        for item in lista
            raise  "El alumno ya existe : #{dni_alumno}" if item.dni_alumno == dni_alumno
        end
        true
    end
end

class AlumnoNacional < Alumno

    attr_accessor :zona_alumno, :promedio_ponderado, :examen_alumno, :lista_tutores
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, zona_alumno, promedio_ponderado)
		super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno)
		@zona_alumno, @promedio_ponderado = zona_alumno, promedio_ponderado 
		@lista_tutores = []
        @examen_alumno = []
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
    def calificarRendimiento2Anio
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
		
		examen_alumno.push(examen)
	end
	def registrarTutor(*datosTutor)
		super
	end
	def validarDatos
        super
    end
    def validarRegistro(lista)
        super
    end
end  

class AlumnoParticular < Alumno
    attr_accessor :monto_pension, :puntaje, :examen_alumno, :lista_tutores
	def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, monto_pension, puntaje)
		super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, lista_Tutores)
		@monto_pension, @puntaje = monto_pension, puntaje  
        @lista_tutores = []
        @examen_alumno = []
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

    def calificarRendimiento2Anio
        if puestoObt < 20
            puntajere=0
          elsif puestoObt >= 11 && puestoObt < 20
            puntajere =40
          elsif puestoObt >= 6 && puestoObt <= 10
            puntajere =60
          elsif puestoObt >= 4 && puestoObt <= 5
            puntajere =80
          elsif puestoObt <= 3
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
		
		examen_alumno.push(examen)
	end
	def registrarTutor(*datosTutor)
		super
	end
	def validarDatos
        super
    end
    def validarRegistro(lista)
        super
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
        true
    end
    def registrarPreguntaExamen(codPregunta, textoPregunta)
        if listaPreguntas.size < cantidad_preguntas
            listaPreguntas.push([codPregunta, textoPregunta])
        end
    end
    def registrarRespuestaExamen(codPregunta, respuestaValida)
    	respuesta = Respuesta.new(codPregunta, respuestaValida)
            listaRespuestasValida.push(respuesta)
    end
    def registrarRespuestaAlumno(codPregunta, respuestaAlumno)
    	respuesta = Respuesta.new(codPregunta, respuestaAlumno)
        listaRespuestasAlumno.push(respuesta)
    end

    def calcularPreguntasSinRespuesta
        cont = 0
        for i in listaRespuestaValida.size
            rpt = i
            for j in listaRespuestasAlumno
                if j[0] == i[0] and j[1] == nil
                    cont = cont + 1
                    break
                end
            end
        end
        return cont
    end
    def calcularPreguntasCorrectas
        cont = 0
        for i in listaRespuestaValida.size
            rpt = i
            for j in listaRespuestasAlumno
                if j[0] == i[0] and j[1] == i[1]
                    cont = cont + 1
                    break
                end
            end
        end
        return cont
    end
    def calcularPreguntasIncorrectas
        cont = 0
        for i in listaRespuestaValida.size
            rpt = i
            for j in listaRespuestasAlumno
                if j[0] == i[0] 
                    if j[1] != i[1] and  i[1] != nil
                        cont = cont + 1
                        break
                    end
                end
            end
        end
        return cont
    end
    def calcularPuntaje
        cant = listaRespuestasValida.size
        return (calcularPreguntasCorrectas* 100/cant) - (calcularPreguntasIncorrectas*100/(cant*2))
    end
end
class Respuesta
	attr_accessor :codigo, :valor
	def initialize(codigo, valor)
		@codigo, @valor = codigo, valor
	end	
end

class Colegio
    attr_accessor :codigo_colegio, :nombre_colegio, :cantidad_vacantes
    def initialize(codigo_colegio, nombre_colegio, cantidad_vacantes)
        @codigo_colegio, @nombre_colegio, @cantidad_vacantes = codigo_colegio, nombre_colegio, cantidad_vacantes
    end
    def validarDatos
        
        raise  "La codigo de colegio no se ha ingresado" if (codigo_colegio==nil)
        raise  "El nombre del colegio no se ha ingresado" if (codigo_colegio==nil)
        raise  "La cantidad de vacantes no se ha ingresado" if (cantidad_vacantes==nil)
        raise  "El nuvero de vacantes es invalido : #{cantidad_vacantes}" if (cantidad_vacantes == 0)
        true
    end
    def validarRegistro(lista)
        for item in  lista
            if item[0] == codigo_colegio
                return false
            end
        end
        true
    end
end

class Factory
	def self.crear(tipo, *args)
		case tipo
		when "AlumnoNacional"
            AlumnoNacional.new(*args)
        when "AlumnoParticular"
            AlumnoParticular.new(*args)
        when "Tutor"
            Tutor.new(*args)
        when "Examen"
            Examen.new(*args)
        when "Colegio"
            Colegio.new(*args)
        end
	end
end

class Sistema
	attr_accessor :lista_Postulantes, :lista_examenes, :lista_Colegios
	def initialize
		@lista_examenes, @lista_Postulantes, @lista_Colegios = [], [], []
	end
	def registrarColegio(*datosColegio)
        begin
            nuevoColegio = Factory.crear("Colegio", *datosColegio)
            nuevoColegio.validarDatos
            lista_Colegios.push(nuevoColegio)
        rescue Exception => e
            raise e.message
        end
    end
    # configuracion Examen
    def crearExamen(*datosExamen)
        begin
            nuevoExamen = Factory.crear("Examen", *datosExamen)
            nuevoExamen.validarDatos
            lista_examenes.push(nuevoExamen)
        rescue Exception => e
            raise e.message
        end
    end
    def configurarExamen(codigoExamen)
        datos = nil
        for exam in lista_examenes
            if exam.codigo_examen == codigoExamen
                datos = exam
            end
        end
        return datos
    end
	def registrarPostulante(tipoAlumno, *datosPostulante)
		begin
			nuevoAlumno = Factory.crear(tipoAlumno, *datosPostulante)
            nuevoAlumno.validarDatos
            nuevoAlumno.validarRegistro(lista_Postulantes)
            lista_Postulantes.push(nuevoAlumno)
        rescue Exception => e
            raise e.message
		end
	end
	def obtenerAlumno(dniPostulante)
        datos = nil
        for alumno in lista_Postulantes
            if alumno.dni_alumno == dniPostulante
                datos = alumno
            end
        end
        return datos
    end

    def simuladorExamen(codigoExamen)
    	examen = configurarExamen(codigoExamen)
    	valores = ["a", "b", "c", "d", "e", nil]
		for alumno in lista_Postulantes
			examenAlu = Factory.crear("Examen", examen.codigo_examen, examen.cantidad_preguntas)
			for preg in 1..examenAlu.cantidad_preguntas
		    	alt = rand(0..5)
				examenAlu.registrarRespuestaAlumno( preg, valores[alt] )
			end
			alumno.rendirExamen(examenAlu)
    	end
    end
end


#Inicio Configuraciones Previas
ministerio = Sistema.new
ministerio.registrarColegio("01", "SAN BUENAVENTURA", 20)
ministerio.crearExamen("EXA01", 10)

	# registro de Respuestas del examen
	valores = ["a", "b", "c", "d", "e"]
	for i in 1..10
		val = rand(0..5)
		ministerio.configurarExamen("EXA01").registrarRespuestaExamen(i, "a")
	end
#Fin configuraciones Previas

#Registro de Alumnos
ministerio.registrarPostulante("AlumnoNacional", "12300000", "COLLANTES POZA", "CESAR", 20, "Masculino", "Rural", 12)
# Replicar **



# ejjecura para todos los postulantes el examen a continacion
ministerio.simuladorExamen("EXA01")





