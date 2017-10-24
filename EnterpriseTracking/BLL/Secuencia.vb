Imports System.IO

Public Class Secuencia

    Public Function Cargar(Archivo As StreamReader, seq As BE.Secuencia) As List(Of BE.MensajeError)
        Cargar = Nothing
    End Function

	Public Sub Guardar(ByVal ob As BE.Secuencia)

	End Sub

	Public Function ObtenerSecuencias(ByVal f As List( Of BE.Secuencia)) As List( Of BE.Secuencia)
		ObtenerSecuencias = Nothing
	End Function

    Public Function Validar(ByVal s As BE.Secuencia) As List(Of BE.MensajeError)
        Validar = Nothing
    End Function


End Class ' BLL.Secuencia