Public Class Producto
	Inherits ABM


    Public Sub New()

        d = New DAL.Producto

    End Sub


    Public Overrides Function ValidarDatos(p As BE.ABM) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)
        Dim s As BE.Producto = p

        Try
            If s.Nombre = "" Or IsNothing(s.Nombre) Then
                Dim m As New BE.MensajeError
                m.IDError = "NombreProductoRequerido"
                l.Add(m)
            End If
            If s.IDReal = "" Or IsNothing(s.IDReal) Then
                Dim m As New BE.MensajeError
                m.IDError = "IDRealProductoRequerido"
                l.Add(m)
            End If

            ' Validar que el Id no exista

            If s.Cliente.ID = 0 Or IsNothing(s.Cliente.ID) Then
                Dim m As New BE.MensajeError
                m.IDError = "ClienteProductoRequerido"
                l.Add(m)
            End If
            If s.Categoria.ID = 0 Or IsNothing(s.Categoria.ID) Then
                Dim m As New BE.MensajeError
                m.IDError = "CategoriaProductoRequerido"
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