Public Class Usuario

    Dim DBH As New DAL.SqlHelper

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

    Public Sub Eliminar()
        Dim dvv As New Digitos.Digito_Vertical

        Dim d As New DAL.Usuario
        Try
            If IsNothing(Me.Usuario.ID) Or Me.Usuario.ID = 0 Then
            Else
                'DBH.Delete("delete from UsuarioElemento where IDUsuario=" + Me.Usuario.ID.ToString)
                Me.Cargar()
                Me.Usuario.borrado = True
                Me.Guardar()
            End If
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub



    Public Sub Guardar()

        Dim d As New DAL.Usuario
        Dim DVH As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical

        Try
            Me.Usuario.DVH = DVH.calcular(Me.Usuario)
            d.Guardar(Me.Usuario)
            dvv.tabla = "Usuario"
            dvv.calcular()

            If Me.Elementos.Count > 0 Then
                DBH.Delete("delete from UsuarioElemento where IDUsuario=" + Me.Usuario.ID.ToString)
                For Each h As Elemento In Me.Elementos

                    Dim dvhue As Long = 0
                    For j As Integer = 0 To Me.Usuario.ID.ToString.Length - 1
                        dvhue += Asc(Me.Usuario.ID.ToString.Substring(j, 1))
                    Next
                    For j As Integer = 0 To h.Elemento.ID.ToString.Length - 1
                        dvhue += Asc(h.Elemento.ID.ToString.Substring(j, 1))
                    Next

                    d.Agregar_Elemento(Me.Usuario, h.Elemento, dvhue)
                Next
                dvv.tabla = "UsuarioElemento"
                dvv.calcular()
            End If
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Sub Cargar()

        Dim l As New List(Of BE.Usuario)
        Dim du As New DAL.Usuario

        Try
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

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub


    Public Function Usuario_Bloqueado(ByVal u As BE.Usuario) As List(Of BE.MensajeError)
        Usuario_Bloqueado = Nothing
    End Function

    Public Function ValidarDatos(ByVal s As BE.Usuario) As List(Of BE.MensajeError)

        Dim l As New List(Of BE.MensajeError)

        Try
            If s.Nombre = "" Or IsNothing(s.Nombre) Then
                Dim m As New BE.MensajeError
                m.IDError = "NombreUsuarioRequerido"
                l.Add(m)
            End If
            If s.Password = "" Or IsNothing(s.Password) Then
                Dim m As New BE.MensajeError
                m.IDError = "contrasenaUsuarioRequerido"
                l.Add(m)
            End If

            Return l
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Function

    Public Function ValidarPassword(s As String) As Boolean

        Try
            Dim c As New Cifrado.Cifrado
            Return c.encriptar_md5(s) = Me.Usuario.Password
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Sub New()
        Me.Usuario = New BE.Usuario
        Me.Elementos = New List(Of Elemento)
    End Sub


    ' Funcion Recursiva para obtener el arbol de permisos y grupos
    Private Function ObtenerElementos(e As BE.Elemento) As List(Of Elemento)

        Dim de As New DAL.Elemento
        Dim l As New List(Of Elemento)

        Try
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
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Function

End Class
