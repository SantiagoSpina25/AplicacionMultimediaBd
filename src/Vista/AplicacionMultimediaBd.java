
package Vista;

import Controlador.ConexionMySql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;


public class AplicacionMultimediaBd {

    
    public static void main(String[] args) {
        ConexionMySql conexion = new ConexionMySql("aplicacionmultimedia");
        Scanner sc = new Scanner(System.in);
        
        try {
            conexion.conectar();
            System.out.println("Base de datos conectada correctamente");
            int eleccion;

            do {
                System.out.println("Que desea realizar?");
                System.out.println("1. SELECT");
                System.out.println("2. INSERT");
                System.out.println("3. UPDATE");
                System.out.println("4. DELETE");
                System.out.println("5. SALIR");

               eleccion = sc.nextInt();

                switch (eleccion) {
                    case 1://SELECT
                        conexion.consultasSelect();
                        break;
                    case 2://INSERT
                        conexion.insertarDato();
                        break;
                    case 3://UPDATE
                        conexion.actualizarDato();
                        break;
                    case 4://DELETE
                        conexion.borrarDato();
                        break;
                    case 5://salir
                        System.out.println("Saliendo...");
                        conexion.desconectar();
                        break;
                    case 6: 
                        System.out.println("Indica un numero correcto");
                        break;
                }
                 System.out.println("------------------------------------------");
            } while (eleccion != 5);   
            
        } catch (SQLException e) {
            System.out.println("Error en la conexion");
            System.out.println(e);
        }   
        
        
        
    }
    
     
    
}
