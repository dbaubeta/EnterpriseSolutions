Public Class Usuario

    Dim DBH As DAL.SqlHelper

    Private Class UsuarioElemento
        Public IDUsuario As Long
        Public IdElemento As Long
        Public Sub New(u As Long, e As Long)
            IDUsuario = u
            IdElemento = e
        End Sub
    End Class


    Private _elementos As List(Of Elemento)
    Public Property Elementos() As List(Of Elemento)
        Get
            Return _elementos
        End Get
        Set(ByVal value As List(Of Elemento))
            _elementos = value
        End Set
    End Property


    Private _Usuario As BE.Usuario
    Public Property Usuario() As BE.Usuario
        Get
            Return _Usuario
        End Get
        Set(ByVal value As BE.Usuario)
            _Usuario = value
        End Set
    End Property

    Public Sub Agregar_elemento(ByVal p_elemento As Elemento)
    End Sub


    Public Sub Bloquear_Usuario(ByVal u As BE.usuario)

    End Sub

    Public Sub Guardar()

        Dim d As New DAL.Usuario
        Dim DVH As New Digitos.Digito_Horizontal
        Me.Usuario.DVH = DVH.calcular(Me.Usuario)

        d.Guardar(Me.Usuario)

        If Me.Elementos.Count > 0 Then
            DBH.Delete("delete from UsuarioElemento where IDUsuario=" + Me.Usuario.ID.ToString)
            For Each h As Elemento In Me.Elementos
                Dim ue As New UsuarioElemento(Me.Usuario.ID, h.Elemento.ID)
                d.Agregar_Elemento(Me.Usuario, h.Elemento, DVH.calcular(ue))
            Next
        End If

    End Sub

    Public Sub Cargar()

        Dim l As New List(Of BE.Usuario)
        Dim du As New DAL.Usuario

        ' Cargar usuario
        ' =============================================================
        l.Add(Me.Usuario)
        l = du.ObtenerUsuarios(l)
        If l.Count > 0 Then
            Me.Usuario = l.Item(0)
            ' Cargar permisos 
            ' =============================================================
            Dim de As New DAL.Elemento
            For Each x As BE.Elemento In de.ObtenerElementos(Me.Usuario)
                If x.Tipo = 0 Then ' Permiso
                    Dim y As New Permiso
                    y.Elemento = x
                    Me.Elementos.Add(y)
                Else
                    Dim y As New Grupo
                    y.Elemento = x
                    y.Hijos = ObtenerElementos(x) ' si es grupo uso funcion recursiva.
                    Me.Elementos.Add(y)
                End If
            Next

        Else
            Me.Usuario = Nothing
        End If


    End Sub


    Public Function Usuario_Bloqueado(ByVal u As BE.Usuario) As List(Of BE.MensajeError)
        Usuario_Bloqueado = Nothing
    End Function

    Public Function ValidarDatos(ByVal s As BE.Usuario) As List(Of BE.MensajeError)
        ValidarDatos = Nothing
    End Function

    Public Function ValidarPassword(s As String) As Boolean
        Dim c As New Cifrado.Cifrado
        Return c.encriptar_md5(s) = Me.Usuario.Password
    End Function

    Public Sub New()
        Me.Usuario = New BE.Usuario
        Me.Elementos = New List(Of Elemento)
    End Sub


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

End Class
