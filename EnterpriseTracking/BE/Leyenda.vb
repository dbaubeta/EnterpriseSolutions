Public Class Leyenda

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
        End Set
    End Property

    Private _Nombre_Leyenda As String
    Public Property Nombre_Leyenda() As String
        Get
            Return _Nombre_Leyenda
        End Get
        Set(ByVal value As String)
            _Nombre_Leyenda = value
        End Set
    End Property

    Private _DVH As Digitos.DV
    Public Property DVH() As Digitos.DV
        Get
            Return _DVH
        End Get
        Set(ByVal value As Digitos.DV)
            _DVH = value
        End Set
    End Property

    Public Sub New()
        Me.DVH = New Digitos.Digito_Horizontal
    End Sub

End Class
