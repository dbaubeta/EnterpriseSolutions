Public Class UsuarioAsignarPermisos
    Inherits System.Web.UI.Page


    Dim u As New Seguridad.Usuario
    Dim lg As New List(Of Seguridad.Grupo)
    Dim lp As New List(Of Seguridad.Permiso)
    Dim le As New List(Of Seguridad.Elemento)


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        Dim m As New BE.MensajeError


        If Not IsNothing(Session("EditandoUsuario")) Then
            u = DirectCast(Session("EditandoUsuario"), Seguridad.Usuario)
        End If

        If Not IsPostBack Then

            l = b.Obtener_Idiomas()
            'dlIdiomas_SelectedIndexChanged(sender, e)
            If Not IsNothing(Session("UsuarioAEditar")) Then

                u.Usuario.ID = Session("UsuarioAEditar")
                u.Cargar()
                Session("EditandoUsuario") = u

                noTranslatelblUsuarioNombre.Text = u.Usuario.Nombre.ToString

            End If

        End If

    End Sub


    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim nu As New Seguridad.Usuario
        Dim c As New Cifrado.Cifrado

        ' Creo un Usuario nuevo y lo guardo. Si ya existe se va a actualizar los datos
        If IsNothing(Session("UsuarioAEditar")) Then
            nu.Usuario.ID = 0
        Else
            nu.Usuario.ID = Long.Parse(Session("UsuarioAEditar"))
        End If
        nu.Usuario.Nombre = u.Usuario.Nombre
        nu.Usuario.DVH = u.Usuario.DVH
        nu.Usuario.Habilitado = u.Usuario.Habilitado
        nu.Usuario.Idioma = u.Usuario.Idioma
        nu.Usuario.Intentos_fallidos = u.Usuario.Intentos_fallidos
        nu.Usuario.Password = u.Usuario.Password
        nu.Elementos = u.Elementos

        Dim erroresval As List(Of BE.MensajeError) = nu.ValidarDatos(nu.Usuario)
        If erroresval.Count > 0 Then
            MostrarMensajeModal(erroresval(0).IDError, True)
        Else
            nu.Guardar()
            Session("UsuarioAEditar") = Nothing
            Session("EditandoUsuario") = Nothing
            Response.Redirect("~/UsuarioLista.aspx")
        End If

    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("UsuarioAEditar") = Nothing
        Session("EditandoUsuario") = Nothing
        Response.Redirect("~/UsuarioLista.aspx")
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
        dt.Columns.Add("ID")
        dt.Columns.Add("nombretraducido")

        Dim s As New Seguridad.Seguridad
        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError

        lp = s.ObtenerPermisos

        For Each p As Seguridad.Permiso In lp

            If Not ElementoYaSeleccionado(p) Then
                Dim dr As DataRow = dt.NewRow
                dr("ID") = p.Elemento.ID.ToString
                m.IDError = "Permiso_" + p.Elemento.nombre
                dr("nombretraducido") = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                dt.Rows.Add(dr)
            End If
        Next

        grdPermisosDisponibles.Columns(0).Visible = True
        grdPermisosDisponibles.DataSource = Nothing
        grdPermisosDisponibles.DataSource = dt
        grdPermisosDisponibles.DataBind()
        grdPermisosDisponibles.Columns(0).Visible = False

        grdPermisosDisponibles.UseAccessibleHeader = True
        grdPermisosDisponibles.HeaderRow.TableSection = TableRowSection.TableHeader


    End Sub


    Private Sub CargarGrillaGrupos()

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("nombretraducido")

        Dim s As New Seguridad.Seguridad

        lg = s.ObtenerGrupos

        For Each p As Seguridad.Grupo In lg

            If Not ElementoYaSeleccionado(p) Then
                Dim dr As DataRow = dt.NewRow
                dr("ID") = p.Elemento.ID.ToString
                dr("nombretraducido") = p.Elemento.nombre
                dt.Rows.Add(dr)
            End If

        Next

        grdGruposDisponibles.Columns(0).Visible = True
        grdGruposDisponibles.DataSource = Nothing
        grdGruposDisponibles.DataSource = dt
        grdGruposDisponibles.DataBind()
        grdGruposDisponibles.Columns(0).Visible = False

        grdGruposDisponibles.UseAccessibleHeader = True
        grdGruposDisponibles.HeaderRow.TableSection = TableRowSection.TableHeader


    End Sub


    Private Sub CargarGrillaElementosSeleccionados()

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("nombretraducido")

        Dim s As New Seguridad.Seguridad
        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError

        For Each p As Seguridad.Elemento In u.Elementos

            Dim dr As DataRow = dt.NewRow
            dr("ID") = p.Elemento.ID.ToString
            m.IDError = "Permiso_" + p.Elemento.nombre
            If p.Elemento.Tipo = 0 Then
                dr("nombretraducido") = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
            Else
                dr("nombretraducido") = p.Elemento.nombre
            End If

            dt.Rows.Add(dr)

        Next

        grdElementosSeleccionados.Columns(0).Visible = True
        grdElementosSeleccionados.DataSource = Nothing
        grdElementosSeleccionados.DataSource = dt
        grdElementosSeleccionados.DataBind()
        grdElementosSeleccionados.Columns(0).Visible = False

        grdElementosSeleccionados.UseAccessibleHeader = True
        grdElementosSeleccionados.HeaderRow.TableSection = TableRowSection.TableHeader


    End Sub



    Private Function ElementoYaSeleccionado(e As Seguridad.Elemento) As Boolean

        Return Not (IsNothing(u.Elementos.Find(Function(x) x.Elemento.ID = e.Elemento.ID)))

    End Function


    Private Sub noTranslateImgFlechaDerecha_Click(sender As Object, e As ImageClickEventArgs) Handles noTranslateImgFlechaDerecha.Click



        For Each i As GridViewRow In grdGruposDisponibles.Rows

            Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
            If chk.Checked Then
                Dim g As New Seguridad.Grupo
                g.Elemento.ID = Long.Parse(i.Cells(0).Text)
                g.Cargar()
                u.Elementos.Add(g)
            End If

        Next


        For Each i As GridViewRow In grdPermisosDisponibles.Rows

            Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
            If chk.Checked Then
                Dim p As New Seguridad.Permiso
                p.Elemento.ID = Long.Parse(i.Cells(0).Text)
                p.Cargar()
                u.Elementos.Add(p)
            End If

        Next

        Session("EditandoUsuario") = u

        CargarGrillaPermisos()
        CargarGrillaGrupos()
        CargarGrillaElementosSeleccionados()


    End Sub

    Private Sub noTranslateImgFlechaIzquierda_Click(sender As Object, e As ImageClickEventArgs) Handles noTranslateImgFlechaIzquierda.Click


        For Each i As GridViewRow In grdElementosSeleccionados.Rows

            Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
            If chk.Checked Then
                Dim r As Seguridad.Elemento
                r = u.Elementos.Find(Function(x) x.Elemento.ID = Long.Parse(i.Cells(0).Text))
                u.Elementos.Remove(r)
            End If

        Next

        Session("EditandoUsuario") = u

        CargarGrillaPermisos()
        CargarGrillaGrupos()
        CargarGrillaElementosSeleccionados()


    End Sub

    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla

        m.IDError = "tituloAsignarPermisosUsuario"
        lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

        CargarGrillaPermisos()
        CargarGrillaGrupos()
        CargarGrillaElementosSeleccionados()

    End Sub

End Class