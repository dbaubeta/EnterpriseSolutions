Public Class Grupo
    Inherits Elemento

    Dim DBH As New DAL.SqlHelper

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

    Public Overrides Sub Cargar()
        Dim l As New List(Of BE.Elemento)
        Dim du As New DAL.Elemento

        ' Cargar grupo
        ' =============================================================
        l.Add(Me.Elemento)
        l = du.ObtenerGrupos(l)
        If l.Count > 0 Then
            Me.Elemento = l.Item(0)
            ' Cargar permisos 
            ' =============================================================
            Dim de As New DAL.Elemento
            For Each x As BE.Elemento In de.ObtenerElementos(Me.Elemento)
                If x.Tipo = 0 Then ' Permiso
                    Dim y As New Permiso
                    y.Elemento = x
                    Me.Hijos.Add(y)
                Else
                    Dim y As New Grupo
                    y.Elemento = x
                    y.Hijos = ObtenerElementos(x) ' si es grupo uso funcion recursiva.
                    Me.Hijos.Add(y)
                End If
            Next

        Else
            Me.Elemento = Nothing
        End If

    End Sub


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
        Me.Elemento.DVH = DVH.calcular(Me.Elemento)

        DBH.Delete("delete from ElementoElemento where IDPadre=" + Me.Elemento.ID.ToString)
        d.Guardar(Me.Elemento)
        GuardarPermisos(Me)

    End Sub

    Public Sub Eliminar()

        Dim d As New DAL.Elemento

        d.Eliminar(Me.Elemento)

    End Sub

    Private Sub GuardarPermisos(e As Grupo)
        Dim DVH As New Digitos.Digito_Horizontal
        Dim d As New DAL.Elemento

        For Each h As Elemento In e.Hijos
            Dim ee As New ElementoElemento(e.Elemento.ID, h.Elemento.ID)
            d.AgregarPermiso(e.Elemento, h.Elemento, DVH.calcular(ee))
            'If h.Elemento.Tipo = 1 Then GuardarPermisos(h)
        Next

    End Sub


    Public Function ValidarDatos(s As BE.Elemento) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)

        If s.nombre = "" Or IsNothing(s.nombre) Then
            Dim m As New BE.MensajeError
            m.IDError = "NombreGrupoRequerido"
            l.Add(m)
        End If

        Return l


    End Function



    ' Funcion Recursiva para obtener el arbol de permisos y grupos
    Private Function ObtenerElementos(e As BE.Elemento) As List(Of Elemento)

        Dim de As New DAL.Elemento
        Dim l As New List(Of Elemento)

        For Each x As BE.Elemento In de.ObtenerElementos(e)
            If x.Tipo = 0 Then ' Permiso
                Dim y As New Permiso
                y.Elemento = x
                l.Add(y)
            Else
                Dim y As New Grupo
                y.Elemento = x
                y.Hijos = ObtenerElementos(x)
                l.Add(y)
            End If
        Next

        Return l


    End Function

    Public Sub New()
        Me.Elemento = New BE.Elemento
        Me.Hijos = New List(Of Elemento)
    End Sub


End Class
