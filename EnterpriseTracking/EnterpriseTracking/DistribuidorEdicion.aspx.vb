Imports System.Globalization

Public Class DistribuidorEdicion
    Inherits System.Web.UI.Page


    Dim p As New BLL.Persistencia
    Dim u As New BE.Distribuidor
    Dim strClase As String = "Distribuidor"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError
        Dim b As New BLL.Provincia
        Dim bu As New Seguridad.Seguridad
        Dim lp As New List(Of BE.Provincia)
        Dim lu As New List(Of Seguridad.Usuario)

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Try

            ' Establezco el objeto strategy que va a atender el requerimiento
            p.EstablecerObjetoNegocio(New BLL.Distribuidor)


        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError
        Dim b As New BLL.Provincia
        Dim bu As New Seguridad.Seguridad
        Dim lp As New List(Of BE.Provincia)
        Dim lu As New List(Of Seguridad.Usuario)

        Try

            If Not IsNothing(Session(strClase + "AEditar")) Then
                u.ID = Session(strClase + "AEditar")
                Dim lc As New List(Of BE.ABM)
                lc.Add(u)
                u = p.ObtenerLista(lc)(0)
            End If

            If Not IsPostBack Then
                ' Cargo la lista de provincias
                lp = b.ObtenerProvincias()
                Me.dlProvincias.DataValueField = "ID"
                Me.dlProvincias.DataTextField = "Nombre"
                Me.dlProvincias.DataSource = lp
                Me.dlProvincias.DataBind()

                ' Cargo la lista de usuarios
                lu = bu.ObtenerUsuariosSinAsignar()
                Dim lu2 As New List(Of BE.Usuario)
                lu2.Clear()
                For Each x As Seguridad.Usuario In lu
                    lu2.Add(x.Usuario)
                Next
                If Not IsNothing(Session(strClase + "AEditar")) Then lu2.Add(u.Usuario)
                Me.dlUsuarios.DataValueField = "ID"
                Me.dlUsuarios.DataTextField = "Nombre"
                Me.dlUsuarios.DataSource = lu2
                Me.dlUsuarios.DataBind()

                ' Cargo los campos de la pantalla por primera vez 
                If Not IsNothing(Session(strClase + "AEditar")) Then
                    noTranslateDistribuidorID.Text = u.ID.ToString
                    txtDistribuidorNombre.Text = u.Nombre
                    txtmail.Text = u.Mail
                    dlProvincias.SelectedValue = u.Provincia.ID
                    dlUsuarios.SelectedValue = u.Usuario.ID
                    m.IDError = "tituloEditar" + strClase
                    txtIDRealDistribuidor.Text = u.IDReal
                    Me.chkDomingo.Checked = IIf(u.diasfactura.Substring(0, 1) = 1, True, False)
                    Me.chkLunes.Checked = IIf(u.diasfactura.Substring(1, 1) = 1, True, False)
                    Me.chkMartes.Checked = IIf(u.diasfactura.Substring(2, 1) = 1, True, False)
                    Me.chkMiercoles.Checked = IIf(u.diasfactura.Substring(3, 1) = 1, True, False)
                    Me.chkJueves.Checked = IIf(u.diasfactura.Substring(4, 1) = 1, True, False)
                    Me.chkViernes.Checked = IIf(u.diasfactura.Substring(5, 1) = 1, True, False)
                    Me.chkSabado.Checked = IIf(u.diasfactura.Substring(6, 1) = 1, True, False)
                    Dim us As CultureInfo = New CultureInfo("en-US")
                    Me.txtAreaVentasLat.Text = u.AreaVentasCentroLat.ToString(us)
                    Me.txtAreaVentasLong.Text = u.AreaVentasCentroLong.ToString(us)
                    Me.txtAreaVentasRadio.Text = u.AreaVentasRadio.ToString
                Else
                    noTranslateDistribuidorID.Text = 0
                    If dlProvincias.Items.Count > 0 Then dlProvincias.SelectedIndex = 0
                    If dlUsuarios.Items.Count > 0 Then dlUsuarios.SelectedIndex = 0
                    m.IDError = "tituloNuevo" + strClase
                    Me.chkDomingo.Checked = True
                    Me.chkLunes.Checked = True
                    Me.chkMartes.Checked = True
                    Me.chkMiercoles.Checked = True
                    Me.chkJueves.Checked = True
                    Me.chkViernes.Checked = True
                    Me.chkSabado.Checked = True
                End If
                Me.txtAreaVentasLat.Attributes.Add("ReadOnly", "ReadOnly")
                Me.txtAreaVentasLong.Attributes.Add("ReadOnly", "ReadOnly")
                lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try
    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim bit As New Bitacora.Bitacora
        Dim us As New Seguridad.Usuario
        Dim erroresval As New List(Of BE.MensajeError)

        Try
            ' Cargo los valores en el usuario 
            If IsNothing(Session(strClase + "AEditar")) Then
                u.ID = 0
            Else
                u.ID = Long.Parse(noTranslateDistribuidorID.Text)
            End If
            u.Nombre = txtDistribuidorNombre.Text
            u.Provincia.ID = dlProvincias.SelectedValue
            u.borrado = False
            u.Mail = txtmail.Text
            u.Usuario.ID = dlUsuarios.SelectedValue
            u.Cliente = DirectCast(Session("ClientePadre"), BE.Cliente)
            u.IDReal = txtIDRealDistribuidor.Text
            u.diasfactura = IIf(Me.chkDomingo.Checked, "1", "0") + _
            IIf(Me.chkLunes.Checked, "1", "0") + _
            IIf(Me.chkMartes.Checked, "1", "0") + _
            IIf(Me.chkMiercoles.Checked, "1", "0") + _
            IIf(Me.chkJueves.Checked, "1", "0") + _
            IIf(Me.chkViernes.Checked, "1", "0") + _
            IIf(Me.chkSabado.Checked, "1", "0")
            Dim us2 As CultureInfo = New CultureInfo("en-US")
            u.AreaVentasCentroLat = Double.Parse(Me.txtAreaVentasLat.Text, us2)
            u.AreaVentasCentroLong = Double.Parse(Me.txtAreaVentasLong.Text, us2)
            u.AreaVentasRadio = Long.Parse(Me.txtAreaVentasRadio.Text)

            erroresval = p.ValidarDatos(u)

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


        If erroresval.Count > 0 Then
            MostrarMensajeModal(erroresval(0).IDError, True)
        Else
            Dim hayerror As Boolean = False
            Try
                ' Intento guardar los datos. Si ya existe se va a actualizar los datos
                p.Guardar(u)

                ' Guardo en la bitacora
                If IsNothing(Session(strClase + "AEditar")) Then
                    bit.Guardar(New BE.Bitacora("BIT_" + strClase + "Alta", strClase, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, u.ID.ToString))
                Else
                    bit.Guardar(New BE.Bitacora("BIT_" + strClase + "Modificacion", strClase, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, u.ID.ToString))
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
                Session(strClase + "AEditar") = Nothing
                Response.Redirect("~/" + strClase + "Lista.aspx")
            End If

        End If

    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub




#Region "Modal"
    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session(strClase + "AEditar") = Nothing
        Response.Redirect("~/" + strClase + "Lista.aspx")
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

    Protected Sub btndibujarmapa_Click(sender As Object, e As EventArgs) Handles btndibujarmapa.Click




    End Sub



End Class