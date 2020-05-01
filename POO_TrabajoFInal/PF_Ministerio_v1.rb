class Colegio
	  attr_accessor :dni_alumno, :apellidos_alumno, :nombres_alumno, :edad_alumno, :genero_alumno, :cat_colegio, :r1 ,:r2, :r3, :r4, :r5, :r6, :r7, :r8, :r9, :r10, :dni_tutor, :apellidos_tutor, :nombre_tutor, :parentesco
 	  def initialize(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, cat_colegio, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
 		@dni_alumno, @apellidos_alumno, @nombres_alumno, @edad_alumno, @genero_alumno, @cat_colegio, @r1, @r2, @r3, @r4, @r5, @r6, @r7, @r8, @r9, @r10, @dni_tutor, @apellidos_tutor, @nombre_tutor, @parentesco = dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, cat_colegio, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco
 	  end
 	  
    def calcular_calificacion_cs
    end
    def calcular_puntaje_re
    end
    def calcular_evaluacion_conocimiento_ec
    end
  	def calcular_puntaje_final
  	end
end	

Arrayce = []
Arraycp = []

class ColegioEstatal < Colegio

    attr_accessor :tipo_zona, :promedio_ponderado
    def initialize (tipo_zona, promedio_ponderado)
      super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, cat_colegio, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
      @tipo_zona, @promedio_ponderado = tipo_zona, promedio_ponderado
      Arrayce.push(dni_alumno)
    end
    
    def calcular_calificacion_cs
        if tipo_zona == "Rural"
            puntajesc=100
          elsif tipo_zona == "Urbana"
            puntajesc=80  
          end
        return puntajesc
    end
    
    def calcular_puntaje_re
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

    def calcular_evaluacion_conocimiento_ec
          if    r1 == "a"
                  puntaje1=10
              elsif r1 =! "a"
                  puntaje1=(-5)
          elsif r2 == "c"
                  puntaje2=10
              elsif r2 =! "c"
                  puntaje2=(-5)
          elsif r3 == "e"
                  puntaje3=10
              elsif r3 =! "e"
                  puntaje3=(-5)
          elsif r4 == "c"
                  puntaje4=10
              elsif r4 =! "c"
                  puntaje4=(-5)
          elsif r5 == "a"
                  puntaje5=10
              elsif r5 =! "a"
                  puntaje5=(-5)
          elsif r6 == "d"
                  puntaje6=10
              elsif r6 =! "d"
                  puntaje6=(-5)
          elsif r7 == "c"
                  puntaje7=10
              elsif r7 =! "c"
                  puntaje7=(-5)
          elsif r8 == "b"
                  puntaje8=10
              elsif r8 =! "b"
                  puntaje8=(-5)
          elsif r9 == "b"
                  puntaje9=10
              elsif r9 =! "b"
                  puntaje10=(-5)
          elsif r10 == "c"
                  puntaje10=10
              elsif r10 =! "c"
                  puntajeec=(-5)
          else
                  puntajeec=0
          end 
        return (puntaje1 + puntaje2 + puntaje3 + puntaje4 + puntaje5 + puntaje6 + puntaje7 + puntaje8 + puntaje9 + puntaje10) 

    end

    def calcular_puntaje_final
      (calcular_calificacion_sc*0.2) + (calcular_puntaje_re*0.30) + (calcular_evaluacion_conocimiento_ec*0.50)
    end
end  

class ColegioParticular < Colegio

    attr_accessor :monto_pension, :puesto_obt
    def initialize (monto_pension , puesto_obt)
      super(dni_alumno, apellidos_alumno, nombres_alumno, edad_alumno, genero_alumno, cat_colegio, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, dni_tutor, apellidos_tutor, nombre_tutor, parentesco)
      @monto_pension, @puesto_obt = monto_pension, puesto_obt
      Arraycp.push(dni_alumno)
    end
    
    def calcular_calificacion_cs
        if monto_pension <= 200
            puntajesc=90
        elsif monto_pension > 200 && monto_pension <= 400
            puntajesc=70
        elsif monto_pension > 400 && penmonto_pensionsion <= 600
            puntajesc=70
        else monto_pension > 600
            puntajesc=20
        end
      return puntajesc  
    end

    def calcular_puntaje_re
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

    def calcular_evaluacion_conocimiento_ec
          if    r1 == "a"
                  puntajeec=10
              elsif r1 =! "a"
                  puntajeec=(-5)
          elsif r2 == "c"
                  puntajeec=10
              elsif r2 =! "c"
                  puntajeec=(-5)
          elsif r3 == "e"
                  puntajeec=10
              elsif r3 =! "e"
                  puntajeec=(-5)
          elsif r4 == "c"
                  puntajeec=10
              elsif r4 =! "c"
                  puntajeec=(-5)
          elsif r5 == "a"
                  puntajeec=10
              elsif r5 =! "a"
                  puntajeec=(-5)
          elsif r6 == "d"
                  puntajeec=10
              elsif r6 =! "d"
                  puntajeec=(-5)
          elsif r7 == "c"
                  puntajeec=10
              elsif r7 =! "c"
                  puntajeec=(-5)
          elsif r8 == "b"
                  puntajeec=10
              elsif r8 =! "b"
                  puntajeec=(-5)
          elsif r9 == "b"
                  puntajeec=10
              elsif r9 =! "b"
                  puntajeec=(-5)
          elsif r10 == "c"
                  puntajeec=10
              elsif r10 =! "c"
                  puntajeec=(-5)
          else
                  puntajeec=0
          end 
        return (r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10) 

    end

    def calcular_puntaje_final
      (calcular_calificacion_sc*0.2) + (calcular_puntaje_re*0.30) + (calcular_evaluacion_conocimiento_ec*0.50)
    end
end  