Public Class Permiso
    Inherits Elemento


    Public Overrides Sub Cargar()

        Dim l As New List(Of BE.Elemento)
        Dim du As New DAL.Elemento

        ' Cargar permiso
        ' =============================================================
        l.Add(Me.Elemento)
        l = du.ObtenerElementos(l)
        If l.Count > 0 Then
            Me.Elemento = l.Item(0)
        Else
            Me.Elemento = Nothing
        End If

    End Sub


    Public Overrides Function ObtenerPermisos() As List(Of Elemento)

        Dim l As New List(Of Elemento)
        l.Add(Me)

        Return l
    End Function


    Public Sub Guardar()

        Dim d As New DAL.Elemento
        d.Guardar(Me.Elemento)

    End Sub

    Public Sub New()
        Me.Elemento = New BE.Elemento
    End Sub

End Class
