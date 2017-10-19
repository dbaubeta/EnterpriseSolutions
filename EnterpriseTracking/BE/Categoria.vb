Public Class Categoria
    Inherits ABM


    Private _Cliente As BE.Cliente
    Private _IDReal As String

    Public Property Cliente() As BE.Cliente
        Get
            Return _Cliente
        End Get
        Set(ByVal Value As BE.Cliente)
            _Cliente = Value
        End Set
    End Property

    Public Property IDReal() As String
        Get
            Return _IDReal
        End Get
        Set(ByVal Value As String)
            _IDReal = Value
        End Set
    End Property


End Class
