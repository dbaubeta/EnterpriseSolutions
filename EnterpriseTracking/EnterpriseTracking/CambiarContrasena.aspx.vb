Public Class CambiarContrasena
    Inherits System.Web.UI.Page


    Dim p As New BLL.Persistencia
    Dim u As New BE.Cliente
    Dim strClase As String = "Cliente"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

    End Sub



    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim bit As New Bitacora.Bitacora
        Dim us As New Seguridad.Usuario
        Dim cif As New Cifrado.Cifrado

        ' Valido los datos ingresados
        Dim hayerror As Boolean = False
        Try

            us = DirectCast(Session("Usuario"), Seguridad.Usuario)
            If String.IsNullOrWhiteSpace(Me.txtcontrasena.Text) Or String.IsNullOrWhiteSpace(Me.txtNuevaContrasena.Text) Or String.IsNullOrWhiteSpace(Me.txtRepetirContrasena.Text) Then
                ' Contrasñea no matchea la que existe
                hayerror = True
                MostrarMensajeModal("Todosloscamposrequeridos", True)
            ElseIf Not us.ValidarPassword(Me.txtcontrasena.Text) Then
                ' Contrasñea no matchea la que existe
                hayerror = True
                MostrarMensajeModal("ContrasenaNoMatchea", True)
            ElseIf Me.txtNuevaContrasena.Text <> Me.txtRepetirContrasena.Text Then
                ' Contraseñas no son iguales
                hayerror = True
                MostrarMensajeModal("ContrasenasNoSonIguales", True)
            Else
                us.Usuario.Password = cif.encriptar_md5(Me.txtNuevaContrasena.Text)
                us.Guardar()
                ' Guardo en la bitacora
                bit.Guardar(New BE.Bitacora("BIT_CambioContrasena", "CambioContrana", us.Usuario.ID.ToString, us.Usuario.ID.ToString))

                Dim mas As Object
                mas = DirectCast(Me.Master, MasterPage)
                mas.logout()

            End If

        Catch bex As BE.Excepcion
            hayerror = True
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            hayerror = True
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        ' Si todo anduvo bien regreso a la lista principal
        If Not hayerror Then
            Response.Redirect("~/" + strClase + "Principal.aspx")
        End If

    End Sub


#Region "Modal"
    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
    End Sub

    Private Sub btnModalNo_ServerClick(sender As Object, e As EventArgs) Handles btnModalNo.ServerClick

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
#End Region


End Class