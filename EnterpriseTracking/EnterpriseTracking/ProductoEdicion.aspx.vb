Public Class ProductoEdicion
    Inherits System.Web.UI.Page



    Dim p As New BLL.Persistencia
    Dim u As New BE.Producto
    Dim strClase As String = "Producto"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError
        Dim b As New BLL.Categoria
        Dim bu As New Seguridad.Seguridad
        Dim lp As New List(Of BE.Categoria)
        Dim lu As New List(Of Seguridad.Usuario)

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Try

            ' Establezco el objeto strategy que va a atender el requerimiento
            p.EstablecerObjetoNegocio(New BLL.Producto)


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

    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError
        Dim b As New BLL.Categoria
        Dim bu As New Seguridad.Seguridad
        Dim lp As New List(Of BE.ABM)
        Dim lu As New List(Of Seguridad.Usuario)

        Try

            If Not IsNothing(Session(strClase + "AEditar")) Then
                u.ID = Session(strClase + "AEditar")
                Dim lc As New List(Of BE.ABM)
                lc.Add(u)
                u = p.ObtenerLista(lc)(0)
            End If

            If Not IsPostBack Then
                ' Cargo la lista de Categorias
                lp = b.ObtenerLista()
                Me.dlCategorias.DataValueField = "ID"
                Me.dlCategorias.DataTextField = "Nombre"
                Me.dlCategorias.DataSource = lp
                Me.dlCategorias.DataBind()

                ' Cargo la lista de usuarios
                lu = bu.ObtenerUsuariosSinAsignar()
                Dim lu2 As New List(Of BE.Usuario)
                lu2.Clear()
                For Each x As Seguridad.Usuario In lu
                    lu2.Add(x.Usuario)
                Next

                ' Cargo los campos de la pantalla por primera vez 
                If Not IsNothing(Session(strClase + "AEditar")) Then
                    noTranslateProductoID.Text = u.ID.ToString
                    txtProductoNombre.Text = u.Nombre
                    txtPrecio.Text = u.Precio.ToString
                    dlCategorias.SelectedValue = u.Categoria.ID
                    m.IDError = "tituloEditar" + strClase
                    txtIDRealProducto.Text = u.IDReal
                    Me.txtStockMinimo.Text = u.stockminimo.ToString
                Else
                    noTranslateProductoID.Text = 0
                    If dlCategorias.Items.Count > 0 Then dlCategorias.SelectedIndex = 0
                    m.IDError = "tituloNuevo" + strClase
                End If
                lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

            End If

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

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim bit As New Bitacora.Bitacora
        Dim us As New Seguridad.Usuario
        Dim erroresval As New List(Of BE.MensajeError)

        Try
            ' Cargo los valores en el usuario 
            If IsNothing(Session(strClase + "AEditar")) Then
                u.ID = 0
            Else
                u.ID = Long.Parse(noTranslateProductoID.Text)
            End If
            u.Nombre = txtProductoNombre.Text
            u.Categoria.ID = dlCategorias.SelectedValue
            u.borrado = False
            If Not Double.TryParse(txtPrecio.Text, u.Precio) Then
                erroresval.Add(New BE.MensajeError("PrecioDebeSerNumerico"))
            End If

            If Not Long.TryParse(txtStockMinimo.Text, u.stockminimo) Then
                erroresval.Add(New BE.MensajeError("StockMinimoDebeSerNumerico"))
            End If

            u.Cliente = DirectCast(Session("ClientePadre"), BE.Cliente)
            u.IDReal = txtIDRealProducto.Text

            erroresval = p.ValidarDatos(u)

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
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
                bitac.Guardar(bm)
                hayerror = True
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                Dim bitac As New Bitacora.Bitacora
                Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
                bitac.Guardar(bm)
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


End Class