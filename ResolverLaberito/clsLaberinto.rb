=begin
    Esta aplicación determina, si un laberinto tiene la posibilidad
    de ser resolvido, el laberinto es una matriz de 0 y 1.
    La ruta para resolver el laberinto depende de la adjuntavilidad vertical y
    horizontal de 0, teniendo un inicio [0,0] (el primer dato) y 
    un final [-1,-1] correspondiente al ultimo dato
=end

#variables globales
$x
$y
$matriz = []
$movimientos=[]
#Arreglo que almacena los movimientos posibles dentro del laberinto y la matriz

class Laberinto
    def generar_laberinto()
        #Pensé de que forma podría ingresar la matriz de datos
        #Elegí en forma de cuestionario, aunque tambien podría hacerla con un ARVG
        print "Ingrese la longitud de X (considere el 0): "
        $x = gets().chomp.to_i
        #Requerir el valor de X, convertirlo en int
        print "Ingrese la longitud de Y (considere el 0): "
        $y = gets().chomp.to_i
        #Requerir el valor de Y, convertirlo a int
        fila = []
        #Instaciaré la fila de la matriz
        #tengo un error al usar each, usé times
        x=$x+1
        #times no considera el 0, es necesario sumar uno
        x.times {|i|
            print "Ingrese los #{$y+1} datos correspondientes a la fila #{i}° sin espacios (1 y 0):"
            cadena = gets()
            #obtengo el string de 0 y 1
            cadena.each_char{|c| fila.push(c)}
            #Actualizo los valores de la fila x
            $matriz.push(fila)
            #Agrego cada fila a una columna conviertiendola en una matriz
            fila = []
            #Vacio la fila
        }
        puts "Matriz creada:"
        for i in $matriz
            for j in i
                print j
            end
        end
        print "\n"
        #Mostar la matriz creada
        return $matriz
        #Obtenerla fuera de la clase
    end
 
    def recorrer(x,y)
        #metodo Recursiva
        $recorridos = 0
        #Dejar en cero los movimientos de esta recursividad
        if x+1<=$x
            #validar que x & y esten dentro de un rango válido
            #Verificar si tengo posibilidades de moverme hacia la derecha
            if $matriz[x+1][y]=="0"
                #Verificar si esta posición es "1" o "0"
                if not $movimientos.include?([x+1,y])
                    #Verificar si esta posicion ya existe dentro del arreglo
                    $movimientos.push([x+1,y])
                    #Agregar posicion a mi arreglo de movimientos
                    $recorridos+=1
                    #contador para saber si en esta recursividad agregué movimientos válidos
                end
            end
        end
        if y+1<=$y
             #validar que x & y esten dentro de un rango válido
             #Verificar si tengo posibilidades de moverme hacia abajo
            if $matriz[x][y+1]=="0" 
                 #Verificar si esta posición es "1" o "0"
                if not $movimientos.include?([x,y+1])
                    #Verificar si esta posicion ya existe dentro del arreglo
                    $movimientos.push([x,y+1])
                    #Agregar posicion a mi arreglo de movimientos
                    $recorridos+=1
                    #contador para saber si en esta recursividad agregué movimientos válidos
                end
            end
        end

        if y-1>=0 
           #validar que x & y esten dentro de un rango válido
           #Verificar si tengo posibilidades de moverme hacia arriba
            if $matriz[x][y-1]=="0" 
                #Verificar si esta posición es "1" o "0"
                if not $movimientos.include?([x,y-1])
                    #Verificar si esta posicion ya existe dentro del arreglo
                    $movimientos.push([x,y-1])
                    #Agregar posicion a mi arreglo de movimientos
                    $recorridos+=1
                    #contador para saber si en esta recursividad agregué movimientos válidos
                end
            end
        end
        
        if x-1>=0
            #validar que x & y esten dentro de un rango válido
             #Verificar si tengo posibilidades de moverme a la izquierda
            if $matriz[x-1][y]=="0"
                #Verificar si esta posición es "1" o "0"
                 if not $movimientos.include?([x-1,y])
                    ##Verificar si esta posicion ya existe dentro del arreglo
                    $movimientos.push([x-1,y])
                    #Agregar posicion a mi arreglo de movimientos
                    $recorridos+=1
                    #contador para saber si en esta recursividad agregué movimientos válidos
                end
            end
        end
        if $recorridos>0
            #contar si hay movimientos validos en esta recursividad
            if $movimientos.include?([$x,$y])
                #Si los movimientos logran llegar al ultimo valor de la matriz, el laberinto se puede completar ($x & $y)
                puts "El laberinto tiene solucion!!!"
            else
                #De lo contrario, vuelvo a ejecutar el mismo metodo con los datos de los movimientos ya almacenados
                num = $movimientos.length
                (0..num.to_i).each { |i| 
                    #IMPORTANTE: Intenté muchas forma de finalizar el Loop, pero la aplicación se crashea cuando el laberinto no tiene solución
                    #De todas formas, la aplicacíon tiene la capacidad de resolver el laberinto
                    #Necesito utilizar un break en alguna parte, mis conocimientos actuales son basicos
                    recorrer($movimientos[i][0],$movimientos[i][1])
                    #$movimientos[i][0] corresponde a x / $movimientos[i][1] corresponde a y
                    #Metodo Recursivo
                 }
            end
        end
    end

    def validar()
        if $matriz[0][0]=="1" or $matriz[-1][-1]=="1"
            #Validar que la matriz tiene una entrada y salida valida ([0,0] es la entrada [$x,$y] es la salida)
            puts "No es posible resolver el laberinto, no tiene una entrada o salida valida"
        elsif
            $movimientos.push([0,0])
            #Inicio de los movimientos
            recorrer(0,0)
        end
    end
end

#Me encantó Ruby, tiene un sintaxis muy simple
