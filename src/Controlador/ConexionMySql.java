package Controlador;

import Vista.JFrameSelect;
import java.sql.*;
import java.util.Scanner;
import javax.swing.JOptionPane;

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

    public ConexionMySql(String bd) {
        this.bd = bd;
    }

    private void registrarDriver() throws SQLException {

        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error");
        }

    }

    public void conectar() throws SQLException {
        if ((connection == null) || connection.isClosed()) {
            registrarDriver();
            connection = (Connection) DriverManager.getConnection(urlConexion + bd, usuario, password);
        }
    }

    public void desconectar() throws SQLException {
        if ((connection != null) && !connection.isClosed()) {
            connection.close();
        }
    }

    public ResultSet ejecutarSelect(String consulta) throws SQLException {
        Statement stmt = connection.createStatement();
        return stmt.executeQuery(consulta);
    }

    public int ejecutarInsertDeleteUpdate(String consulta) throws SQLException {
        Statement stmt = connection.createStatement();
        return stmt.executeUpdate(consulta);
    }

    public boolean existeTabla(String tabla) throws SQLException {
        boolean existe = false;

        //DatabaseMetaData es una clase que contiene la informacion de la base de datos
        DatabaseMetaData metaData = connection.getMetaData();

        //getTables devuelve si la tabla con el nombre introducido existe
        ResultSet tablas = metaData.getTables(null, null, tabla, null);

        if (tablas.next()) {
            existe = true;
        }
        return existe;
    }

    public void consultasSelect() throws SQLException {
        Scanner sc = new Scanner(System.in);

        System.out.println("------------------------------------------");
        System.out.println("Escriba la tabla que quiere seleccionar");
        String tablaSeleccionada = sc.next();

        if (existeTabla(tablaSeleccionada)) {
            System.out.println("");
            System.out.println("Que atributo(s) desea seleccionar? (separe con comas, por ejemplo: nombre, edad, ciudad)");
            sc.nextLine();

            String atributosSeleccionados = sc.nextLine();

            System.out.println("Alguna condicion? (Presione 1 para omitr)");

            String condicionSeleccionada = sc.nextLine();

            if (condicionSeleccionada.equals("1")) {
                condicionSeleccionada = "";
            }

            ResultSet rs = ejecutarSelect("select  " + atributosSeleccionados + " from " + tablaSeleccionada + " " + condicionSeleccionada);
            System.out.println("----------" + tablaSeleccionada + "----------");

            String[] atributos = atributosSeleccionados.split(",");

            //Por cada registro encontrado, muestro cada uno de sus atributos
            while (rs.next()) {
                System.out.print("- ");
                for (int i = 0; i < atributos.length; i++) {
                    //Borro los espacios entre cada atributo
                    String atributo = atributos[i].trim();
                    System.out.print(atributo + ": " + rs.getString(atributo) + " | ");
                }
                System.out.println("");

            }

        } else {
            System.out.println("La tabla introducida no existe");
        }

    }

    public void insertarDato() throws SQLException {
        Scanner sc = new Scanner(System.in);

        System.out.println("------------------------------------------");
        System.out.println("Escriba la tabla sobre la que quiere insertar un registro");
        String tablaSeleccionada = sc.next();
        sc.nextLine();
        if (existeTabla(tablaSeleccionada)) {

            System.out.println("Introduzca TODOS los valores separados por coma y en orden, ejemplo: 1, 'Santiago', 'Spina'");
            String valores = sc.nextLine();
            int filasAfectadas = ejecutarInsertDeleteUpdate("insert into " + tablaSeleccionada + " values (" + valores + ")");

            if (filasAfectadas > 0) {
                System.out.println("El registro fue insertado correctamente");
            } else {
                System.out.println("El registro no fue insertado");
            }

        } else {
            System.out.println("La tabla introducida no existe");
        }

    }

    public void actualizarDato() throws SQLException {
        Scanner sc = new Scanner(System.in);

        System.out.println("------------------------------------------");
        System.out.println("Escriba la tabla sobre la que quiere actualizar un dato");
        String tablaSeleccionada = sc.next();
        sc.nextLine();

        if (existeTabla(tablaSeleccionada)) {

            System.out.println("Ingrese el campo y el valor en formato campo=valor, separados por comas. Ej: nombre='Santiago' ");
            String valores = sc.nextLine();

            System.out.println("Introduzca la condicion para la actualizacion. Ej: where id = 1");
            String condicion = sc.nextLine();
            int filasAfectadas = ejecutarInsertDeleteUpdate("update " + tablaSeleccionada + " set " + valores + " " + condicion);

            if (filasAfectadas > 0) {
                System.out.println("El registro fue actualizados correctamente");
            } else {
                System.out.println("El registro no fue actualizado");
            }

        } else {
            System.out.println("La tabla introducida no existe");
        }
    }

    public void borrarDato() throws SQLException {
        Scanner sc = new Scanner(System.in);

        System.out.println("------------------------------------------");
        System.out.println("Escriba la tabla sobre la que quiere borrar un registro");
        String tablaSeleccionada = sc.next();
        sc.nextLine();

        if (existeTabla(tablaSeleccionada)) {

            System.out.println("Introduzca la condicion para borrar el registro. Ej: where id = 1");
            String condicion = sc.nextLine();
            int filasAfectadas = ejecutarInsertDeleteUpdate("delete from " + tablaSeleccionada + " " + condicion);

            if (filasAfectadas > 0) {
                System.out.println("El registro fue borrado correctamente");
            } else {
                System.out.println("El registro no fue borrado");
            }

        } else {
            System.out.println("La tabla introducida no existe");
        }
    }

    public void ejecutarBusquedaFrame(String tablaSeleccionada, String atributosSeleccionados, String condicionesSeleccionadas) throws SQLException {
        ResultSet rs = ejecutarSelect("SELECT " + atributosSeleccionados + " FROM " + tablaSeleccionada + " " + condicionesSeleccionadas);
        JFrameSelect jFrameSelect = new JFrameSelect(rs);
        jFrameSelect.setVisible(true);
    }

    public void ejecutarInsercionFrame(String tablaSeleccionada, String atributosSeleccionados, String condicionesSeleccionadas) throws SQLException {
        int filasInsertadas = ejecutarInsertDeleteUpdate("INSERT INTO " + tablaSeleccionada + " VALUES (" + atributosSeleccionados + ")");

        if (filasInsertadas > 0) {
            JOptionPane.showMessageDialog(null, "El registro fue insertado correctamente", "Insercion", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "El registro no fue insertado", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void ejecutarActualizacionFrame(String tablaSeleccionada, String atributosSeleccionados, String condicionesSeleccionadas) throws SQLException {
        int filasActualizadas = ejecutarInsertDeleteUpdate("UPDATE  " + tablaSeleccionada + " SET " + atributosSeleccionados + " " + condicionesSeleccionadas);

        if (filasActualizadas > 0) {
            JOptionPane.showMessageDialog(null, "El registro fue actualizado correctamente", "Insercion", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "El registro no fue actualizado", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void ejecutarBorrarFrame(String tablaSeleccionada, String atributosSeleccionados, String condicionesSeleccionadas) throws SQLException {
        int filasBorradas = ejecutarInsertDeleteUpdate("DELETE FROM " + tablaSeleccionada + "  " + condicionesSeleccionadas);

        if (filasBorradas > 0) {
            JOptionPane.showMessageDialog(null, "Borrado correctamente", "Insercion", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "El registro no fue borrado correctamente", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

}
