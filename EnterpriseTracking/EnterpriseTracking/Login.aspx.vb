﻿Public Class Login
    Inherits System.Web.UI.Page



    Public Sub validarbase()

        Dim d As New Digitos.Validador
        Dim li As New List(Of BE.MensajeError)

        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)

        l = b.Obtener_Idiomas()

        li = d.validarDB()
        Dim sb As New StringBuilder
        Dim idi As New BE.Idioma
        idi = l.Find(Function(c) c.ID = 1)
        If li.Count > 0 Then
            Session("BaseValidada") = "No"
        Else
            Session("BaseValidada") = "Si"
        End If


    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.msjError.Visible = False

        validarbase()
        If Session("BaseValidada") <> "Si" Then
            Response.Redirect("~/BaseCorrupta.aspx")
        End If


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
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
                bitac.Guardar(bm)
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
                bitac.Guardar(bm)
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
                    Dim bitac As New Bitacora.Bitacora
                    Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
                    bitac.Guardar(bm)
                    MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
                Catch ex As Exception
                    Dim bitac As New Bitacora.Bitacora
                    Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
                    bitac.Guardar(bm)
                    MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
                End Try

                If IsNothing(Session("EsCliente")) Then
                    Response.Redirect("~/Principal.aspx")
                Else
                    Response.Redirect("~/PanelControl.aspx")
                End If
            End If
            Try
                Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True
            Catch bex As BE.Excepcion
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
                bitac.Guardar(bm)
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
                bitac.Guardar(bm)
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

            'Dim markers As String = ""
            'Label11.Text = (Convert.ToString(vbCr & vbLf & "              <script type='text/javascript'>" & vbCr & vbLf & "                 function initialize() {" & vbCr & vbLf & vbCr & vbLf & "                 var mapOptions = {" & vbCr & vbLf & "                     center: new google.maps.LatLng(39.948427, -101.836428)," & vbCr & vbLf & "                     zoom: 2," & vbCr & vbLf & "                     mapTypeId: google.maps.MapTypeId.ROADMAP" & vbCr & vbLf & "                 };" & vbCr & vbLf & vbCr & vbLf & "                 var myMap = new google.maps.Map(document.getElementById('mapArea')," & vbCr & vbLf & "                             mapOptions);") & markers) + "}" & vbCr & vbLf & "             </script>"

        Catch bex As BE.Excepcion
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
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
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
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