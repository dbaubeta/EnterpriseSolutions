	Public Class Rep_Vtas_Dist_Vend


    Private _Distribuidor As BE.Distribuidor
    Private _Vendedor As BE.Vendedor
    Private _monto As Double

    Public Property Distribuidor() As BE.Distribuidor
        Get
            Return _Distribuidor
        End Get
        Set(ByVal Value As BE.Distribuidor)
            _Distribuidor = Value
        End Set
    End Property


    Public Property Vendedor() As BE.Vendedor
        Get
            Return _Vendedor
        End Get
        Set(ByVal Value As BE.Vendedor)
            _Vendedor = Value
        End Set
    End Property


    Private _cantidad As Long
    Public Property Cantidad() As Long
        Get
            Return _cantidad
        End Get
        Set(ByVal value As Long)
            _cantidad = value
        End Set
    End Property


    Public Property monto() As Double
        Get
            Return _monto
        End Get
        Set(ByVal Value As Double)
            _monto = Value
        End Set
    End Property

    Public Sub New()
        Me.Distribuidor = New Distribuidor
        Me.Vendedor = New BE.Vendedor

    End Sub


	End Class ' BE.Rep_Vtas_Dist_Vend

