
package Vista;

import Controlador.ConexionMySql;
import java.sql.SQLException;


public class AplicacionMultimediaBd {

    
    public static void main(String[] args) {
        ConexionMySql conexion = new ConexionMySql("aplicacionmultimedia");
        
        try {
            conexion.conectar();
            System.out.println("Base de datos conectada correctamente");
            
        } catch (SQLException e) {
            System.out.println("Error en la conexion");
            System.out.println(e);
        }
        
        
        
    }
    
}
