Public Class Cliente
	Inherits ABM

    Public Sub New()

        d = New DAL.Cliente

    End Sub


    Public Overrides Function ValidarDatos(p As BE.ABM) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)
        Dim s As BE.Cliente = p

        Try
            If s.Nombre = "" Or IsNothing(s.Nombre) Then
                Dim m As New BE.MensajeError
                m.IDError = "NombreClienteRequerido"
                l.Add(m)
            End If
            If s.Mail = "" Or IsNothing(s.Mail) Then
                Dim m As New BE.MensajeError
                m.IDError = "MailClienteRequerido"
                l.Add(m)
            End If
            If s.Provincia.ID = 0 Or IsNothing(s.Provincia.ID) Then
                Dim m As New BE.MensajeError
                m.IDError = "ProvinciaClienteRequerido"
                l.Add(m)
            End If
            If s.Usuario.ID = 0 Or IsNothing(s.Usuario.ID) Then
                Dim m As New BE.MensajeError
                m.IDError = "UsuarioClienteRequerido"
                l.Add(m)
            End If

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