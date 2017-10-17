Public Class Categoria
	Inherits ABM

    Public Sub New()

        d = New DAL.Categoria

    End Sub


    Public Overrides Function ValidarDatos(p As BE.ABM) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)
        Try

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