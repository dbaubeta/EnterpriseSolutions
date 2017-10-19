	Public Class Categoria
		Inherits ABM

    Dim u As BE.Categoria

    Public Overrides Sub Eliminar(o As BE.ABM)

    End Sub

    Public Overrides Sub Guardar(ob As BE.ABM)


        Dim params(4) As System.Data.SqlClient.SqlParameter

        u = DirectCast(ob, BE.Categoria)

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Cliente.ID))
                params(3) = DBH.CrearParametro("@P4", u.IDReal)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                Dim resultado As Long = DBH.Insert("INSERT INTO Categoria(Nombre ,DVH, IDCliente, IDReal, borrado) VALUES(@P1, @P2, @P3, @P4, @P5); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(5)
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Cliente.ID))
                params(3) = DBH.CrearParametro("@P4", u.IDReal)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                params(5) = DBH.CrearParametro("@P0", u.ID)

                DBH.Update("update Categoria set Nombre=@P1, DVH=@P2, IDCliente=@P3, IDReal=@P4, borrado=@P5 where ID=@P0", params)

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
        Dim cadena As String = "select * from Categoria where borrado = 0 "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Categoria
        Dim ll As New List(Of BE.ABM)
        Dim c As New Cifrado.Cifrado
        Dim dp As New DAL.Cliente


        Try

            If Not IsNothing(f) Then
                ReDim params(f.Count - 1)

                If f.Count > 0 Then
                    cadena = cadena + " and "
                    For Each x As BE.Categoria In f
                        If Not IsNothing(x.ID) And x.ID <> 0 Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.ID)
                        ElseIf Not IsNothing(x.Nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.Nombre)
                        End If
                    Next
                    cadena += IIf(idx1 > 0, in1 + ")", "") + IIf(idx1 > 0 And idx2 > 0, " or ", "") + IIf(idx2 > 0, in2 + ")", "")
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Categoria
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.IDReal = dr.Item("IDReal")
                l.borrado = dr.Item("borrado")
                l.DVH = dr.Item("DVH")

                l.Cliente.ID = dr.Item("IDCliente")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Cliente)
                l.Cliente = dp.ObtenerLista(li)(0)

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