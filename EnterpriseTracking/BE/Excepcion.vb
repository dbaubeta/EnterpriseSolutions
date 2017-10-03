Public Class Excepcion
    Inherits Exception

    Private _Capa As String
    Public Property Capa() As String
        Get
            Return _Capa
        End Get
        Set(ByVal value As String)
            _Capa = value
        End Set
    End Property

    Private _excepcion As Exception
    Public Property Excepcion() As Exception
        Get
            Return _excepcion
        End Get
        Set(ByVal value As Exception)
            _excepcion = value
        End Set
    End Property


End Class
