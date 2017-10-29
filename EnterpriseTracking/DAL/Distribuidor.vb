
	Public Class Distribuidor
		Inherits ABM


    Dim u As BE.Distribuidor

    Public Overrides Sub Eliminar(o As BE.ABM)

    End Sub

    Public Overrides Sub Guardar(ob As BE.ABM)


        Dim params(7) As System.Data.SqlClient.SqlParameter

        u = DirectCast(ob, BE.Distribuidor)

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Provincia.ID))
                params(3) = DBH.CrearParametro("@P4", u.Mail)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                params(5) = DBH.CrearParametro("@P6", Long.Parse(u.Usuario.ID))
                params(6) = DBH.CrearParametro("@P7", Long.Parse(u.Cliente.ID))
                params(7) = DBH.CrearParametro("@P8", Long.Parse(u.IDReal))
                Dim resultado As Long = DBH.Insert("INSERT INTO Distribuidor(Nombre ,DVH, IDProvincia, Mail, borrado, IDUsuario, IDCliente, IDReal) VALUES(@P1, @P2, @P3, @P4, @P5, @P6, @P7, @P8); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(8)
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Provincia.ID))
                params(3) = DBH.CrearParametro("@P4", u.Mail)
                params(4) = DBH.CrearParametro("@P5", u.borrado)
                params(5) = DBH.CrearParametro("@P6", Long.Parse(u.Usuario.ID))
                params(6) = DBH.CrearParametro("@P7", Long.Parse(u.Cliente.ID))
                params(7) = DBH.CrearParametro("@P8", Long.Parse(u.IDReal))
                params(8) = DBH.CrearParametro("@P0", u.ID)

                DBH.Update("update Distribuidor set Nombre=@P1, DVH=@P2, IDProvincia=@P3, Mail=@P4, borrado=@P5, IDUsuario=@P6, IDCliente=@P7, IDReal=@P8 where ID=@P0", params)

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
        Dim cadena As String = "select * from Distribuidor where borrado = 0 "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim idx3 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Distribuidor
        Dim ll As New List(Of BE.ABM)
        Dim c As New Cifrado.Cifrado
        Dim dp As New DAL.Provincia
        Dim du As New DAL.Usuario
        Dim dc As New DAL.Cliente


        Try

            If Not IsNothing(f) Then
                ReDim params(f.Count - 1)

                If f.Count > 0 Then
                    cadena = cadena + " and ("
                    For Each x As BE.Distribuidor In f
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
                l = New BE.Distribuidor
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.Mail = dr.Item("Mail")
                l.IDReal = dr.Item("IDReal")
                l.borrado = dr.Item("borrado")
                l.DVH = dr.Item("DVH")

                l.Provincia.ID = dr.Item("IDProvincia")
                Dim li As New List(Of BE.Provincia)
                li.Add(l.Provincia)
                l.Provincia = dp.ObtenerProvincias(li)(0)

                l.Usuario.ID = dr.Item("IDUsuario")
                Dim lu As New List(Of BE.Usuario)
                lu.Add(l.Usuario)
                l.Usuario = du.ObtenerUsuarios(lu)(0)

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


    'Public Overrides Function ObtenerListaUsuario(u As BE.Usuario) As List(Of BE.ABM)


    '    Dim params(0) As System.Data.SqlClient.SqlParameter
    '    Dim in1 As String = ""
    '    Dim in2 As String = ""
    '    Dim cadena As String = "select d.* from Distribuidor d join cliente c on d.Idcliente = c.Id where d.borrado = 0 and c.borrado=0 and c.IDUsuario = @P1"
    '    Dim idx1 As Integer = 0
    '    Dim idx2 As Integer = 0
    '    Dim dt As DataTable
    '    Dim l As BE.Distribuidor
    '    Dim ll As New List(Of BE.ABM)
    '    Dim c As New Cifrado.Cifrado
    '    Dim dp As New DAL.Provincia
    '    Dim du As New DAL.Usuario
    '    Dim dc As New DAL.Cliente


    '    Try

    '        params(0) = DBH.CrearParametro("@P1", u.ID)
    '        dt = DBH.SelectTabla(cadena, params)
    '        For Each dr As DataRow In dt.Rows
    '            l = New BE.Distribuidor
    '            l.ID = dr.Item("ID")
    '            l.Nombre = dr.Item("Nombre")
    '            l.Mail = dr.Item("Mail")
    '            l.borrado = dr.Item("borrado")
    '            l.DVH = dr.Item("DVH")

    '            l.Provincia.ID = dr.Item("IDProvincia")
    '            Dim li As New List(Of BE.Provincia)
    '            li.Add(l.Provincia)
    '            l.Provincia = dp.ObtenerProvincias(li)(0)

    '            l.Usuario.ID = dr.Item("IDUsuario")
    '            Dim lu As New List(Of BE.Usuario)
    '            lu.Add(l.Usuario)
    '            l.Usuario = du.ObtenerUsuarios(lu)(0)

    '            l.Cliente.ID = dr.Item("IDCliente")
    '            Dim lc As New List(Of BE.ABM)
    '            lc.Add(l.Cliente)
    '            l.Cliente = dc.ObtenerLista(lc)(0)

    '            ll.Add(l)
    '        Next

    '        Return ll
    '    Catch bex As BE.Excepcion
    '        Throw bex
    '    Catch ex As Exception
    '        Dim bex As New BE.Excepcion
    '        bex.Excepcion = ex
    '        bex.Capa = Me.GetType().ToString
    '        Throw bex
    '    End Try

    'End Function


End Class ' DAL.Distribuidor

