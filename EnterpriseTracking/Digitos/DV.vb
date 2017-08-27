Public MustInherit Class DV

    Private _valor As Long
    Public Property valor() As Long
        Get
            Return _valor
        End Get
        Set(ByVal value As Long)
            _valor = value
        End Set
    End Property

    Public MustOverride Sub Calcular(o As Object)



End Class
