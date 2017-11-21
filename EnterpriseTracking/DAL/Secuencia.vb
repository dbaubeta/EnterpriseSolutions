	Public Class Secuencia

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Secuencia)

        Dim params(4) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then

                ' Insert
                params(0) = DBH.CrearParametro("@P1", Long.Parse(u.Nro_Secuencia_Real))
                params(1) = DBH.CrearParametro("@P2", u.Fecha)
                params(2) = DBH.CrearParametro("@P3", u.Estado)
                params(3) = DBH.CrearParametro("@P4", Long.Parse(u.DVH))
                params(4) = DBH.CrearParametro("@P5", Long.Parse(u.Distribuidor.ID))
                Dim resultado As Long = DBH.Insert("INSERT INTO Secuencia (IDReal,Fecha,Estado,DVH,IDDistribuidor) VALUES(@P1, @P2, @P3, @P4, @P5); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(5)
                params(0) = DBH.CrearParametro("@P1", Long.Parse(u.Nro_Secuencia_Real))
                params(1) = DBH.CrearParametro("@P2", u.Fecha)
                params(2) = DBH.CrearParametro("@P3", u.Estado)
                params(3) = DBH.CrearParametro("@P4", Long.Parse(u.DVH))
                params(4) = DBH.CrearParametro("@P5", Long.Parse(u.Distribuidor.ID))
                params(5) = DBH.CrearParametro("@P0", u.ID)

                DBH.Update("update Secuencia set IDReal=@P1, Fecha=@P2, Estado=@P3, DVH=@P4, IDDistribuidor=@P5 where ID=@P0", params)
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


    Public Function ObtenerSecuencias() As List(Of BE.Secuencia)

        Dim cadena As String = "select * from secuencia"
        Dim dt As DataTable
        Dim l As BE.Secuencia
        Dim ll As New List(Of BE.Secuencia)
        Dim dd As New DAL.Distribuidor
        Try

            dt = DBH.SelectTabla(cadena)
            For Each dr As DataRow In dt.Rows
                l = New BE.Secuencia
                l.ID = dr.Item("ID")
                l.Fecha = dr.Item("Fecha")
                l.DVH = dr.Item("DVH")
                l.Nro_Secuencia_Real = dr.Item("IDReal")
                l.Estado = dr.Item("Estado")

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Distribuidor)
                l.Distribuidor = dd.ObtenerLista(li)(0)

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

