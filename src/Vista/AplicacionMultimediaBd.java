
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
                System.out.println("3. DELETE");
                System.out.println("4. SALIR");

               eleccion = sc.nextInt();

                switch (eleccion) {
                    case 1://SELECT
                        consultasSelect(conexion);
                        break;
                    case 2://INSERT

                        break;
                    case 3://DELETE

                        break;
                    case 4://Desconectar
                        System.out.println("Saliendo...");

                            conexion.desconectar();




                        break;
                    default:
                        System.out.println("Indica un numero correcto");
                }
                System.out.println("");
            } while (eleccion != 4);   
            
        } catch (SQLException e) {
            System.out.println("Error en la conexion");
            System.out.println(e);
        }   
        
        
        
    }
    
     private static void consultasSelect(ConexionMySql conexion) throws SQLException {
         Scanner sc = new Scanner(System.in);
         
         System.out.println("------------------------------------------");
         System.out.println("Escriba la tabla que quiere seleccionar");
         String tablaSeleccionada = sc.next();
         
         if(conexion.existeTabla(tablaSeleccionada)){
             System.out.println("");
             System.out.println("Que atributo desea seleccionar?");
             String atributoSeleccionado = sc.next();
             
             System.out.println("Alguna condicion? (Presione 1 para omitr)");
             String condicionSeleccionada = sc.next();
             
             if(condicionSeleccionada.equals("1")){
                 condicionSeleccionada = "";
             }
             
             ResultSet rs = conexion.ejecutarSelect("select  " + atributoSeleccionado + " from " + tablaSeleccionada + " " + condicionSeleccionada);
             
             while(rs.next()){
                System.out.println("----------"+tablaSeleccionada+"----------");
                System.out.println(rs.getString(atributoSeleccionado));
                System.out.println("");
             }
             
             
         }else{
             System.out.println("La tabla introducida no existe");
         }
       
    }
    
}
