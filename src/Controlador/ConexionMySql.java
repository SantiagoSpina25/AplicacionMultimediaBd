
package Controlador;


import java.sql.*;
/**
 *
 * @author MEDAC
 */
public class ConexionMySql {
    
            private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
            private String urlConexion = "jdbc:mysql://localhost:3306/";
  
            final String usuario = "root";
            final String password = "root";
            Connection connection = null;
            String bd = "";
            public ConexionMySql(String bd){
                this.bd = bd;
            }
           
           private void registrarDriver() throws SQLException {
            
            try{
                 Class.forName(DRIVER);
            }catch(ClassNotFoundException e){
                throw new SQLException("Error");
            }
           
        }
           
           public void conectar() throws SQLException{
            if((connection == null) || connection.isClosed()){
                 registrarDriver();
                 connection = (Connection) DriverManager.getConnection(urlConexion + bd, usuario, password);
            }
        }
           
        public void desconectar() throws SQLException{
             if((connection != null) && !connection.isClosed()){
                 connection.close();
            }
        }
           
       public ResultSet ejecutarSelect(String consulta) throws SQLException {
            Statement stmt = connection.createStatement();
            return stmt.executeQuery(consulta);
        }
    
        public int ejecutarInsertDeleteUpdate(String consulta) throws SQLException{
            Statement stmt = connection.createStatement();
            return stmt.executeUpdate(consulta);
        }
    
}