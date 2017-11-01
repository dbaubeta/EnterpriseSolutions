Public Class Vendedor
		Inherits ABM


	Private _Distribuidor As BE.Distribuidor
	Private _ID As Long
    Private _IDReal As String
    Private _Nombre As String

    Public Property Distribuidor() As BE.Distribuidor
        Get
            Return _Distribuidor
        End Get
        Set(ByVal Value As BE.Distribuidor)
            _Distribuidor = Value
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

    Public Sub New()
        Me.Distribuidor = New BE.Distribuidor
    End Sub

End Class ' BE.Vendedor

