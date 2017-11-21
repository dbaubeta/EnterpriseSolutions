
	Public Class Producto
		Inherits ABM

    Dim u As BE.Producto

    Public Overrides Sub Eliminar(o As BE.ABM)

    End Sub

    Public Overrides Sub Guardar(ob As BE.ABM)


        Dim params(7) As System.Data.SqlClient.SqlParameter

        u = DirectCast(ob, BE.Producto)

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Categoria.ID))
                params(3) = DBH.CrearParametro("@P4", u.IDReal)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                params(5) = DBH.CrearParametro("@P6", Long.Parse(u.Cliente.ID))
                params(6) = DBH.CrearParametro("@P7", Double.Parse(u.Precio))
                params(7) = DBH.CrearParametro("@P8", Long.Parse(u.stockminimo))
                Dim resultado As Long = DBH.Insert("INSERT INTO Producto(Nombre ,DVH, IDCategoria, IDReal, borrado, IDCliente, precio, stockminimo) VALUES(@P1, @P2, @P3, @P4, @P5, @P6, @P7, @P8); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(8)
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Categoria.ID))
                params(3) = DBH.CrearParametro("@P4", u.IDReal)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                params(5) = DBH.CrearParametro("@P6", u.Cliente.ID)
                params(6) = DBH.CrearParametro("@P7", Double.Parse(u.Precio))
                params(7) = DBH.CrearParametro("@P0", Long.Parse(u.ID))
                params(8) = DBH.CrearParametro("@P8", Long.Parse(u.stockminimo))

                DBH.Update("update Producto set Nombre=@P1, DVH=@P2, IDCategoria=@P3, IDReal=@P4, borrado=@P5, IDCliente=@P6, precio=@P7, stockminimo=@P8 where ID=@P0", params)

            End If

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

    Public Overrides Function ObtenerLista(Optional f As List(Of BE.ABM) = Nothing) As List(Of BE.ABM)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim in1 As String = ""
        Dim in2 As String = ""
        Dim in3 As String = ""
        Dim cadena As String = "select * from Producto where borrado = 0 "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim idx3 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Producto
        Dim ll As New List(Of BE.ABM)
        Dim c As New Cifrado.Cifrado
        Dim dp As New DAL.Categoria
        Dim du As New DAL.Usuario
        Dim dc As New DAL.Cliente


        Try

            If Not IsNothing(f) Then
                ReDim params(f.Count - 1)

                If f.Count > 0 Then
                    cadena = cadena + " and ("
                    For Each x As BE.Producto In f
                        If Not IsNothing(x.ID) And x.ID <> 0 Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.ID)
                        ElseIf Not IsNothing(x.IDReal) Then
                            idx3 += 1
                            If idx3 > 1 Then in3 += "," Else in3 += " IDReal in ("
                            in3 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.IDReal)
                        ElseIf Not IsNothing(x.Nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.Nombre)
                        End If
                    Next
                    If idx1 > 0 Then
                        cadena += in1 + ")" + IIf(idx2 + idx3 > 0, " or ", "")
                    End If
                    If idx2 > 0 Then
                        cadena += in2 + ")" + IIf(idx3 > 0, " or ", "")
                    End If
                    If idx3 > 0 Then
                        cadena += in3 + ")"
                    End If

                    cadena += ")"
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Producto
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.IDReal = dr.Item("IDReal")
                l.borrado = dr.Item("borrado")
                l.Precio = dr.Item("Precio")
                l.stockminimo = dr.Item("stockminimo")
                l.DVH = dr.Item("DVH")

                l.Categoria.ID = dr.Item("IDCategoria")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Categoria)
                l.Categoria = dp.ObtenerLista(li)(0)

                l.Cliente.ID = dr.Item("IDCliente")
                Dim lc As New List(Of BE.ABM)
                lc.Add(l.Cliente)
                l.Cliente = dc.ObtenerLista(lc)(0)

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


End Class 
