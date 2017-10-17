Public Class Cliente
    Inherits ABM


    Private _Mail As String
    Private _Provincia As BE.Provincia
    Private _Usuario As BE.Usuario

    Public Property Mail() As String
        Get
            Return _Mail
        End Get
        Set(ByVal Value As String)
            _Mail = Value
        End Set
    End Property

    Public Property Provincia() As BE.Provincia
        Get
            Return _Provincia
        End Get
        Set(ByVal Value As BE.Provincia)
            _Provincia = Value
        End Set
    End Property

    Public Property Usuario() As BE.Usuario
        Get
            Return _Usuario
        End Get
        Set(ByVal Value As BE.Usuario)
            _Usuario = Value
        End Set
    End Property


    Public Sub New()
        Usuario = New BE.Usuario
        Provincia = New BE.Provincia
    End Sub

End Class

