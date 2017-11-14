	Public Class Reportes

    Protected DBH As New SqlHelper

    Public Function Obtener_Ventas_Cat_prod(ByVal desde As BE.Factura, ByVal hasta As BE.Factura) As List(Of BE.Rep_Vtas_prod_cat)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select p.IDCategoria, c.Nombre NombreCategoria, fd.IDProducto , p.nombre as NombreProducto, sum(fd.Cantidad) cantidad, sum(fd.Precio * fd.Cantidad ) Monto "
        cadena += "from FacturaDetalle fd "
        cadena += "join factura f on f.id = fd.IDFactura "
        cadena += "join producto p on p.id = fd.IDProducto "
        cadena += "join categoria c on c.id = p.IDCategoria "
        cadena += "where f.borrado = 0 "
        cadena += "and cast(Fecha as date) >= cast(@P1 as date) "
        cadena += "and cast(Fecha as date) <= cast(@P2 as date) "
        cadena += "and f.IDDistribuidor = @P3 "
        cadena += "group by p.IDCategoria, c.Nombre , fd.IDProducto , p.nombre "
        cadena += "order by p.IDCategoria, c.Nombre , fd.IDProducto , p.nombre "

        Dim dt As DataTable
        Dim l As BE.Rep_Vtas_prod_cat
        Dim ll As New List(Of BE.Rep_Vtas_prod_cat)
        Dim dd As New DAL.Producto
        Try
            params(0) = DBH.CrearParametro("@P1", desde.Fecha)
            params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
            params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Rep_Vtas_prod_cat

                l.Producto.ID = dr.Item("IDProducto")
                l.Producto.Nombre = dr.Item("NombreProducto")
                l.Categoria.ID = dr.Item("IDCategoria")
                l.Categoria.Nombre = dr.Item("NombreCategoria")

                l.Cantidad = dr.Item("cantidad")
                l.monto = dr.Item("monto")

                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex

        End Try
    End Function

		Public Function Obtener_Ventas_Dist_Vend(ByVal desde As BE.Factura, ByVal hasta As BE.Factura) As List(Of BE.Rep_Vtas_Dist_Vend)
        Dim params(1) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select f.IDDistribuidor, c.Nombre NombreDistribuidor, f.IDVendedor , p.nombre as NombreVendedor, sum(fd.Cantidad) cantidad, sum(fd.Precio * fd.Cantidad ) Monto "
        cadena += "from FacturaDetalle fd "
        cadena += "join factura f on f.id = fd.IDFactura "
        cadena += "join Vendedor p on p.id = f.IDVendedor "
        cadena += "join Distribuidor c on c.id = f.IDDistribuidor "
        cadena += "where f.borrado = 0 "
        cadena += "and cast(Fecha as date) >= cast(@P1 as date) "
        cadena += "and cast(Fecha as date) <= cast(@P2 as date) "
        'cadena += "and f.IDDistribuidor = @P3 "
        cadena += "group by f.IDDistribuidor, c.Nombre , f.IDVendedor , p.nombre "
        cadena += "order by f.IDDistribuidor, c.Nombre , f.IDVendedor , p.nombre "

        Dim dt As DataTable
        Dim l As BE.Rep_Vtas_Dist_Vend
        Dim ll As New List(Of BE.Rep_Vtas_Dist_Vend)
        Dim dd As New DAL.Vendedor
        Try
            params(0) = DBH.CrearParametro("@P1", desde.Fecha)
            params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
            'params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Rep_Vtas_Dist_Vend

                l.Vendedor.ID = dr.Item("IDVendedor")
                l.Vendedor.Nombre = dr.Item("NombreVendedor")
                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                l.Distribuidor.Nombre = dr.Item("NombreDistribuidor")

                l.Cantidad = dr.Item("cantidad")
                l.monto = dr.Item("monto")

                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex

        End Try
		End Function

	End Class ' DAL.Reportes

