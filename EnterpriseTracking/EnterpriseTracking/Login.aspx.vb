Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.msjError.Visible = False
    End Sub


    Protected Sub LogIn(sender As Object, e As EventArgs) Handles btnLogin.Click

        If IsValid Then
            ' Validate the user password
            'IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
            Dim s As New Seguridad.Seguridad
            Dim u As New BE.Usuario
            Dim us As New Seguridad.Usuario
            Dim b As New BLL.Facade_Pantalla
            Dim bi As New BLL.Idioma
            Dim bit As New Bitacora.Bitacora

            u.Nombre = Me.txtUsuario.Text
            Try
                us = s.ObtenerUsuario(u)
            Catch bex As BE.Excepcion
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
            End Try

            Dim em As New BE.MensajeError

            If us Is Nothing Then ' Usuario Inexistente
                em.IDError = "msjErrorUsuarioIncorrecto"
            ElseIf Not us.ValidarPassword(Me.txtcontrasena.Text) Then ' Contraseña incorrecta
                em.IDError = "msjErrorcontrasenaIncorrecta"
            ElseIf us.Usuario.Habilitado = 0 Then ' Usuario Inhabilitado
                em.IDError = "msjErrorUsuarioInhabilitado"
            Else ' Login correcto
                Session("Usuario") = us
                Session("Idioma") = us.Usuario.Idioma

                ' Verifico si el usuario esta asociado a un cliente
                Dim bx As New BLL.Cliente
                Session("EsCliente") = bx.ObtenerLista().Find(Function(z) DirectCast(z, BE.Cliente).Usuario.ID = DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID)

                ' Verifico si el usuario esta asociado a un Distribuidor
                Dim by As New BLL.Distribuidor
                Session("EsDistribuidor") = by.ObtenerLista().Find(Function(z) DirectCast(z, BE.Distribuidor).Usuario.ID = DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID)

                Try
                    bit.Guardar(New BE.Bitacora("BIT_Login", "Login", us.Usuario.ID))
                Catch bex As BE.Excepcion
                    MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
                Catch ex As Exception
                    MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
                End Try

                Response.Redirect("~/Principal.aspx")
            End If
            Try 
            Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True
            Catch bex As BE.Excepcion
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
            End Try


        End If


    End Sub


    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)

        Try
            l = b.Obtener_Idiomas()

            'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
            If Not IsPostBack Then
                Me.dlIdiomas.DataValueField = "ID"
                Me.dlIdiomas.DataTextField = "Nombre"
                Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
                Me.dlIdiomas.DataBind()
            End If

            'Traduzco la pagina
            Session("Idioma") = l.Find(Function(c) c.ID = dlIdiomas.SelectedValue)
            f.Traducir(Me, DirectCast(Session("Idioma"), BE.Idioma))
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        Try
            b.ID = dlIdiomas.SelectedValue
            il.Add(b)
            b = bl.Obtener_Idiomas(il)(0)

            f.Traducir(Me, b)
            Session("Idioma") = b
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try
    End Sub


    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean, Optional traducir As Boolean = True)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla
        m.IDError = Msg
        If Not simple Then
            If traducir Then
                Try
                    noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessageSiNo.Text = Msg
                End Try
            Else
                noTranslateModalMessageSiNo.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
        Else
            If traducir Then
                Try
                    noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessage.Text = Msg
                End Try
            Else
                noTranslateModalMessage.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
        End If

    End Sub


End Class