Public Class Grupo
    Inherits Elemento



    Private Class ElementoElemento
        Public IDPadre As Long
        Public IdHijo As Long
        Public Sub New(p As Long, h As Long)
            IDPadre = p
            IdHijo = h
        End Sub
    End Class


    Private _hijos As List(Of Elemento)
        Public Property Hijos() As List(Of Elemento)
            Get
                Return _hijos
            End Get
            Set(ByVal value As List(Of Elemento))
                _hijos = value
            End Set
        End Property

        Public Overrides Function Cargar() As Elemento
            Return Nothing
        End Function


    Public Overrides Function ObtenerPermisos() As List(Of Elemento)
        Dim l As New List(Of Elemento)
        l.Add(Me)

        For Each el As Elemento In Hijos
            l.AddRange(el.ObtenerPermisos)
        Next

        Return l

    End Function


    Public Sub Guardar()

        Dim d As New DAL.Elemento
        Dim DVH As New Digitos.Digito_Horizontal

        d.Guardar(Me.Elemento)
        GuardarPermisos(Me)

    End Sub
    Private Sub GuardarPermisos(e As Grupo)
        Dim DVH As New Digitos.Digito_Horizontal
        Dim d As New DAL.Elemento

        For Each h As Elemento In e.Hijos
            Dim ee As New ElementoElemento(e.Elemento.ID, h.Elemento.ID)
            d.AgregarPermiso(e.Elemento, h.Elemento, DVH.calcular(ee))
            If h.Elemento.Tipo = 1 Then GuardarPermisos(h)
        Next

    End Sub






End Class
