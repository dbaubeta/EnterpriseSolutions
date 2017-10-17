	Public Class Provincia


    Private _ID As Long
    Private _Nombre As String

    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal Value As Long)
            _ID = Value
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


	End Class ' BE.Provincia
