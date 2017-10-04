Public Class Usuario

    Private _DVH As Long
    Private _ID_Usuario As Long
    Private _Idioma_usuario As BE.Idioma
    Private _Intentos_fallidos As Integer
    Private _Nombre As String
    Private _Password As String
    Private _Habilitado As String
    Private _borrado As Boolean


    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal Value As Long)
            _DVH = Value
        End Set
    End Property

    Public Property ID() As Long
        Get
            Return _ID_Usuario
        End Get
        Set(ByVal Value As Long)
            _ID_Usuario = Value
        End Set
    End Property

    Public Property Idioma() As BE.Idioma
        Get
            Return _Idioma_usuario
        End Get
        Set(ByVal Value As BE.Idioma)
            _Idioma_usuario = Value
        End Set
    End Property

    Public Property Intentos_fallidos() As Integer
        Get
            Return _Intentos_fallidos
        End Get
        Set(ByVal Value As Integer)
            _Intentos_fallidos = Value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return _Password
        End Get
        Set(ByVal Value As String)
            _Password = Value
        End Set
    End Property

    Public Property Habilitado() As Boolean
        Get
            Return _Habilitado
        End Get
        Set(ByVal value As Boolean)
            _Habilitado = value
        End Set
    End Property

    Public Property borrado() As Boolean
        Get
            Return _borrado
        End Get
        Set(ByVal value As Boolean)
            _borrado = value
        End Set
    End Property



    Public Sub New()
        Me.Idioma = New BE.Idioma

    End Sub

End Class
