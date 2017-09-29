Public Class GrupoEdicion
    Inherits System.Web.UI.Page


    Dim u As New Seguridad.Grupo

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        Dim m As New BE.MensajeError

        If Not IsNothing(Session("GrupoAEditar")) Then
            u.Elemento.ID = Session("GrupoAEditar")
            u.Cargar()
        End If
        If Not IsPostBack Then

            l = b.Obtener_Idiomas()

            'dlIdiomas_SelectedIndexChanged(sender, e)
            If Not IsNothing(Session("GrupoAEditar")) Then
                m.IDError = "tituloEditarGrupo"
                noTranslateGrupoID.Text = u.Elemento.ID.ToString
                txtGrupoNombre.Text = u.Elemento.nombre

            Else
                m.IDError = "tituloNuevoGrupo"
            End If
            lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

        End If

        CargarGrillaPermisos()

    End Sub

    Private Sub GrupoEdicion_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender


    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim nu As New Seguridad.Grupo
        Dim c As New Cifrado.Cifrado

        ' Creo un Grupo nuevo y lo guardo. Si ya existe se va a actualizar los datos
        If IsNothing(Session("GrupoAEditar")) Then
            nu.Elemento.ID = 0
        Else
            nu.Elemento.ID = Long.Parse(noTranslateGrupoID.Text)
        End If
        nu.Elemento.nombre = txtGrupoNombre.Text
        nu.Elemento.Tipo = 1

        Dim erroresval As List(Of BE.MensajeError) = nu.ValidarDatos(nu.Elemento)
        If erroresval.Count > 0 Then
            MostrarMensajeModal(erroresval(0).IDError, True)
        Else
            nu.Guardar()
            Session("GrupoAEditar") = Nothing
            Response.Redirect("~/GrupoLista.aspx")
        End If

    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("GrupoAEditar") = Nothing
        Response.Redirect("~/GrupoLista.aspx")
    End Sub

    Private Sub btnModalNo_ServerClick(sender As Object, e As EventArgs) Handles btnModalNo.ServerClick

    End Sub


    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla

        m.IDError = Msg
        If Not simple Then
            noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
        Else
            noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
        End If

    End Sub



    Private Sub CargarGrillaPermisos()

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("nombre")
        dt.Columns.Add("nombretraducido")

        Dim s As New Seguridad.Seguridad

        For Each p As Seguridad.Permiso In s.ObtenerPermisos

            Dim dr As DataRow = dt.NewRow
            dr("nombre") = p.Elemento.nombre
            dr("nombretraducido") = p.Elemento.nombre
            dt.Rows.Add(dr)
        Next

        grdPermisos.DataSource = Nothing
        grdPermisos.DataSource = dt
        grdPermisos.DataBind()

        grdPermisos.UseAccessibleHeader = True
        grdPermisos.HeaderRow.TableSection = TableRowSection.TableHeader


    End Sub



End Class