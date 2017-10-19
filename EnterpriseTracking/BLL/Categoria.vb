Public Class Categoria
	Inherits ABM


    Public Sub New()

        d = New DAL.Categoria

    End Sub


    Public Overrides Function ValidarDatos(p As BE.ABM) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)
        Dim s As BE.Categoria = p

        Try
            If s.Nombre = "" Or IsNothing(s.Nombre) Then
                Dim m As New BE.MensajeError
                m.IDError = "NombreCategoriaRequerido"
                l.Add(m)
            End If
            If s.IDReal = "" Or IsNothing(s.IDReal) Then
                Dim m As New BE.MensajeError
                m.IDError = "IDRealCategoriaRequerido"
                l.Add(m)
            End If
            If s.Cliente.ID = 0 Or IsNothing(s.Cliente.ID) Then
                Dim m As New BE.MensajeError
                m.IDError = "ClienteCategoriaRequerido"
                l.Add(m)
            End If
            ' Validar que el Id no exista


            Return l
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