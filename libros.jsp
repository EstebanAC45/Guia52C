<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>
<!--  LOGICA DE ACTUALIZAR -->
<%
   String varisbn = request.getParameter("isbn");
   String vartitulo = request.getParameter("titulo");
   String varautor = request.getParameter("autor");
   String vareditorial = request.getParameter("editorial");
   String varanio = request.getParameter("anio");
   String varchecked = request.getParameter("checked");
   String actualizar="actualizar";
   //Estos dos son de ordenar
   String va = request.getParameter("var");
   String var = "1";
   if(varisbn==null&&vartitulo==null&&varchecked==null){
      varisbn="";
      vartitulo="";
      varautor="";
      vareditorial="";
      varanio="";
      varchecked="";
   }
%>

<H1>MANTENIMIENTO DE LIBROS</H1>
<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" name="isbn" value="<%=varisbn%>" size="40"/>
</td>
  </tr>
 <tr>
 <td>Titulo<input type="text" name="titulo" value="<%=vartitulo%>" size="50"/></td>
 </tr>
 <tr>
 <td>Autor<input type="text" name="autor" value="<%=varautor%>" size="40"/></td>
 </tr>
 <tr>
 <td>Editorial<select type="text" name="editorial"/>
    <option><%=vareditorial%></option>
 </td>
 </tr>
 <tr>
 <td>A�o de publicaci�n<input type="text" name="anio" value="<%=varanio%>"/></td>
 </tr>
 <tr><td> Action 
 <%if(varchecked.equals(actualizar)){
    %>
      <input type="radio" name="Action" value="Actualizar" checked /> Actualizar
      <input type="radio" name="Action" value="Eliminar" /> Eliminar
      <input type="radio" name="Action" value="Crear"/> Crear
 <%}else{%>
      <input type="radio" name="Action" value="Actualizar"/> Actualizar
      <input type="radio" name="Action" value="Eliminar" /> Eliminar
      <input type="radio" name="Action" value="Crear" checked/> Crear
 <%}%>
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>
<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path+"\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
out.write("OK");
      String isbn ="", titulo ="", autor= "",editorial= "",anio= "", site= ""+request.getRequestURL(), b="";
      if(va==null){
      b = " order by titulo asc";
      }
      else{
      b = " order by titulo desc";
      }
      String sentencia = "select * from libros"+ b;
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(sentencia);
      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\">");
      %>
         <tr><td>Num.</td><td>ISBN</td><td><a href="<%=site%>?var=<%=var%>"> Titulo</a></td><td>Autor</td><td>Editorial</td><td>A�o Publicaci�n</td><td>Accion</td></tr>
      <%
      int i=1;
      while (rs.next())
      {
         isbn=rs.getString("isbn");
         titulo=rs.getString("titulo");
         autor=rs.getString("autor");
         editorial=rs.getString("editorial");
         anio=rs.getString("anio");
         %>
         <tr>
         <td> <%=i%> </td>
         <td><%=isbn%></td>
         <td><%=titulo%></td>
         <td><%=autor%></td>
         <td><%=editorial%></td>
         <td><%=anio%></td>
         
         <!--EJERCICIO 4-->
         <td><a href="<%=site%>?isbn=<%=isbn%>&titulo=<%=titulo%>&autor=<%=autor%>&editorial=<%=editorial%>&anio=<%=anio%>&checked=<%=actualizar%>">Actualizar</a><br>Eliminar</td>
         </tr>
         <%
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}

%>
 </body>