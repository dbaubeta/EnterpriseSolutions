Public Class Idioma

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
        End Set
    End Property

    Private _Nombre As String
    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal value As String)
            _Nombre = value
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

    Private _Leyendas As List(Of Leyenda)
    Public Property Leyendas() As List(Of Leyenda)
        Get
            Return _Leyendas
        End Get
        Set(ByVal value As List(Of Leyenda))
            _Leyendas = value
        End Set
    End Property


    Private _pruebita As Leyenda
    Public Property pruebita() As Leyenda
        Get
            Return _pruebita
        End Get
        Set(ByVal value As Leyenda)
            _pruebita = value
        End Set
    End Property


    Public Sub New()
        Me.DVH = New Digitos.Digito_Horizontal
    End Sub

End Class
