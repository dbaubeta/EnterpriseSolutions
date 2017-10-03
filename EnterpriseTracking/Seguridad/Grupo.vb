Public Class Grupo
    Inherits Elemento

    Dim DBH As New DAL.SqlHelper

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
        l = du.ObtenerElementos(l)
        If l.Count > 0 Then
            Me.Elemento = l.Item(0)
            ' Cargar permisos 
            ' =============================================================
            Dim de As New DAL.Elemento
            For Each x As BE.Elemento In de.ObtenerHijos(Me.Elemento)
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
        Dim DVV As New Digitos.Digito_Vertical

        Me.Elemento.DVH = DVH.calcular(Me.Elemento)

        DBH.Delete("delete from ElementoElemento where IDPadre=" + Me.Elemento.ID.ToString)
        d.Guardar(Me.Elemento)
        DVV.tabla = "Elemento"
        DVV.calcular()

        GuardarPermisos(Me)
        DVV.tabla = "ElementoElemento"
        DVV.calcular()


    End Sub

    Public Sub Eliminar()

        Dim d As New DAL.Elemento
        Dim DVV As New Digitos.Digito_Vertical

        d.Eliminar(Me.Elemento)
        DVV.tabla = "Elemento"
        DVV.calcular()
        DVV.tabla = "ElementoElemento"
        DVV.calcular()
        DVV.tabla = "UsuarioElemento"
        DVV.calcular()



    End Sub

    Private Sub GuardarPermisos(e As Grupo)
        Dim d As New DAL.Elemento

        For Each h As Elemento In e.Hijos

            Dim dvh As Long = 0
            For j As Integer = 0 To e.Elemento.ID.ToString.Length - 1
                dvh += Asc(e.Elemento.ID.ToString.Substring(j, 1))
            Next
            For j As Integer = 0 To h.Elemento.ID.ToString.Length - 1
                dvh += Asc(h.Elemento.ID.ToString.Substring(j, 1))
            Next
            d.AgregarPermiso(e.Elemento, h.Elemento, dvh)
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

        For Each x As BE.Elemento In de.ObtenerHijos(e)
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
