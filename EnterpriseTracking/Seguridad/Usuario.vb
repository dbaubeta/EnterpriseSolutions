Public Class Usuario

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

    Public Sub Guardar(ByVal u As BE.Usuario)

    End Sub

    Public Sub Cargar()

        Dim l As New List(Of BE.Usuario)
        Dim du As New DAL.Usuario

        l.Add(Me.Usuario)
        l = du.ObtenerUsuarios(l)
        If l.Count > 0 Then
            Me.Usuario = l.Item(0)
            ' Cargar permisos 
            Dim de As New DAL.Elemento
            For Each x As BE.Elemento In de.ObtenerElementos(Me.Usuario)
                If x.Tipo = 0 Then ' Permiso
                    Dim y As New Permiso
                    y.Elemento = x
                    Me.Elementos.Add(y)
                Else
                    Dim y As New Grupo
                    y.Elemento = x
                    y.Hijos = ObtenerElementos(x)
                    Me.Elementos.Add(y)
                End If
            Next

            '            WITH x AS
            '(
            '    -- anchor:
            '    SELECT IDHijo, IdPadre , [level] = 0
            '    FROM (select IDElemento IDHijo, cast(NULL as bigint) IDPadre from Elemento_Usuario eu 
            '			join elemento e on e.ID = eu.IDElemento 
            '			where tipo = 1) as n
            '    UNION ALL
            '    -- recursive:
            '    SELECT t.IDHijo, t.IDPadre, [level] = x.[level] + 1
            '    FROM x INNER JOIN Elemento_Elemento  AS t
            '    ON t.IDPadre = x.IDHijo
            ')
            'SELECT IDHijo , IDPadre, [level] FROM x
            'ORDER BY [level]
            'OPTION (MAXRECURSION 32);





        Else
            Me.Usuario = Nothing
        End If


    End Sub


    Public Function ObtenerUsuarios(ByVal f As List(Of BE.Usuario)) As List(Of BE.Usuario)
        ObtenerUsuarios = Nothing
    End Function

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
