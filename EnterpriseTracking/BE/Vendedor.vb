Public Class Vendedor
    Inherits ABM


    Private _Distribuidor As Distribuidor
    Private _ID_Vendedor_Real As String


    Public Property Distribuidor() As Distribuidor
        Get
            Return _Distribuidor
        End Get
        Set(ByVal Value As Distribuidor)
            _Distribuidor = Value
        End Set
    End Property

    Public Property ID_Vendedor_Real() As String
        Get
            Return _ID_Vendedor_Real
        End Get
        Set(ByVal Value As String)
            _ID_Vendedor_Real = Value
        End Set
    End Property


End Class

