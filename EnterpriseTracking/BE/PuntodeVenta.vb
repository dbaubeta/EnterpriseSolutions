Public Class PuntodeVenta


	Private _Calle As String
	Private _CodigoPostal As String
    Private _CUIT As String
	Private _Depto As String
	Private _Distribuidor As BE.Distribuidor
    Private _DVH As Long
	Private _ID As Long
	Private _IDReal As String
	Private _Nombre As String
	Private _Provincia As BE.Provincia
    Private _Vendedor As BE.Vendedor
    Private _borrado As Boolean

	Public Property Calle() As String
		Get
			Return _Calle
		End Get
		Set(ByVal Value as String)
			_Calle = Value
		End Set
	End Property

	Public Property CodigoPostal() As String
		Get
			Return _CodigoPostal
		End Get
		Set(ByVal Value as String)
			_CodigoPostal = Value
		End Set
	End Property

    Public Property CUIT() As String
        Get
            Return _CUIT
        End Get
        Set(ByVal Value As String)
            _CUIT = Value
        End Set
    End Property

	Public Property Depto() As String
		Get
			Return _Depto
		End Get
		Set(ByVal Value as String)
			_Depto = Value
		End Set
	End Property

	Public Property Distribuidor() As BE.Distribuidor
		Get
			Return _Distribuidor
		End Get
		Set(ByVal Value as BE.Distribuidor)
			_Distribuidor = Value
		End Set
	End Property

	Public Property DVH() As Long
		Get
			Return _DVH
		End Get
		Set(ByVal Value as Long)
			_DVH = Value
		End Set
	End Property

	Public Property ID() As Long
		Get
            Return _ID
		End Get
		Set(ByVal Value as Long)
            _ID = Value
		End Set
	End Property

	Public Property IDReal() As String
		Get
            Return _IDReal
		End Get
		Set(ByVal Value as String)
            _IDReal = Value
		End Set
	End Property

	Public Property Nombre() As String
		Get
			Return _Nombre
		End Get
		Set(ByVal Value as String)
			_Nombre = Value
		End Set
	End Property

	Public Property Provincia() As BE.Provincia
		Get
			Return _Provincia
		End Get
		Set(ByVal Value as BE.Provincia)
			_Provincia = Value
		End Set
	End Property

	Public Property Vendedor() As BE.Vendedor
		Get
			Return _Vendedor
		End Get
		Set(ByVal Value as BE.Vendedor)
			_Vendedor = Value
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

    Private _numero As String
    Public Property numero() As String
        Get
            Return _numero
        End Get
        Set(ByVal value As String)
            _numero = value
        End Set
    End Property

    Private _latitud As Double
    Public Property Latitud() As Double
        Get
            Return _latitud
        End Get
        Set(ByVal value As Double)
            _latitud = value
        End Set
    End Property


    Private _longitud As Double
    Public Property Longitud() As Double
        Get
            Return _longitud
        End Get
        Set(ByVal value As Double)
            _longitud = value
        End Set
    End Property

    Public ReadOnly Property invade() As Boolean
        Get

            If Latitud <> 0 And Longitud <> 0 And Me.Distribuidor.AreaVentasCentroLat <> 0 And Me.Distribuidor.AreaVentasCentroLong <> 0 Then

                If (distancia(Latitud, Longitud, Distribuidor.AreaVentasCentroLat, Distribuidor.AreaVentasCentroLong, "K") * 1000 > Distribuidor.AreaVentasRadio) Then
                    Return True
                End If
            End If
            Return False

        End Get
    End Property


    Private _tipoPDV As String
    Public Property TipoPDV() As String
        Get
            Return _tipoPDV
        End Get
        Set(ByVal value As String)
            _tipoPDV = value
        End Set
    End Property



    Public Sub New()

        Me.Distribuidor = New BE.Distribuidor
        Me.Provincia = New BE.Provincia
        Me.Vendedor = New BE.Vendedor
        Me.Latitud = 0
        Me.Longitud = 0

    End Sub


    Private Function distancia(ByVal lat1 As Double, ByVal lon1 As Double, ByVal lat2 As Double, ByVal lon2 As Double, ByVal unit As Char) As Double
        Dim theta As Double = lon1 - lon2
        Dim dist As Double = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta))
        dist = Math.Acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        If unit = "K" Then
            dist = dist * 1.609344
        ElseIf unit = "N" Then
            dist = dist * 0.8684
        End If
        Return dist
    End Function

    Private Function deg2rad(ByVal deg As Double) As Double
        Return (deg * Math.PI / 180.0)
    End Function

    Private Function rad2deg(ByVal rad As Double) As Double
        Return rad / Math.PI * 180.0
    End Function

End Class ' BE.PuntodeVenta
