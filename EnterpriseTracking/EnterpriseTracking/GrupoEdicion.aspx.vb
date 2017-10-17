Public Class GrupoEdicion
    Inherits System.Web.UI.Page


    Dim u As New Seguridad.Grupo
    Dim lg As New List(Of Seguridad.Grupo)
    Dim lp As New List(Of Seguridad.Permiso)
    Dim le As New List(Of Seguridad.Elemento)


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Try

            Dim f As New BLL.Facade_Pantalla
            Dim b As New BLL.Idioma
            Dim l As New List(Of BE.Idioma)
            Dim m As New BE.MensajeError


            If Not IsNothing(Session("EditandoGrupo")) Then
                u = DirectCast(Session("EditandoGrupo"), Seguridad.Grupo)
            End If

            If Not IsPostBack Then

                l = b.Obtener_Idiomas()
                'dlIdiomas_SelectedIndexChanged(sender, e)
                If Not IsNothing(Session("GrupoAEditar")) Then

                    u.Elemento.ID = Session("GrupoAEditar")
                    u.Cargar()
                    Session("EditandoGrupo") = u

                    noTranslateGrupoID.Text = u.Elemento.ID.ToString
                    txtGrupoNombre.Text = u.Elemento.nombre
                Else
                    noTranslateGrupoID.Text = 0
                End If

            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

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
        nu.Hijos = u.Hijos

        Dim erroresval As List(Of BE.MensajeError) = nu.ValidarDatos(nu.Elemento)
        If erroresval.Count > 0 Then
            MostrarMensajeModal(erroresval(0).IDError, True)
        Else
            Dim hayerror As Boolean = False
            Try
                nu.Guardar()

            Catch bex As BE.Excepcion
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
                hayerror = True
            Catch ex As Exception
                MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
                hayerror = True
            End Try

            If Not hayerror Then
                Session("GrupoAEditar") = Nothing
                Session("EditandoGrupo") = Nothing
                Response.Redirect("~/GrupoLista.aspx")
            End If

            End If


    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("GrupoAEditar") = Nothing
        Session("EditandoGrupo") = Nothing
        Response.Redirect("~/GrupoLista.aspx")
    End Sub




    Private Sub CargarGrillaPermisos()

        Try
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

            If grdPermisosDisponibles.Rows.Count > 0 Then
                grdPermisosDisponibles.UseAccessibleHeader = True
                grdPermisosDisponibles.HeaderRow.TableSection = TableRowSection.TableHeader
            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrillaGrupos()

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("ID")
            dt.Columns.Add("nombretraducido")

            Dim s As New Seguridad.Seguridad

            lg = s.ObtenerGrupos

            For Each p As Seguridad.Grupo In lg

                If p.Elemento.ID <> u.Elemento.ID Then
                    If Not ElementoYaSeleccionado(p) Then
                        Dim dr As DataRow = dt.NewRow
                        dr("ID") = p.Elemento.ID.ToString
                        dr("nombretraducido") = p.Elemento.nombre
                        dt.Rows.Add(dr)
                    End If
                End If

            Next

            grdGruposDisponibles.Columns(0).Visible = True
            grdGruposDisponibles.DataSource = Nothing
            grdGruposDisponibles.DataSource = dt
            grdGruposDisponibles.DataBind()
            grdGruposDisponibles.Columns(0).Visible = False

            If grdGruposDisponibles.Rows.Count > 0 Then
                grdGruposDisponibles.UseAccessibleHeader = True
                grdGruposDisponibles.HeaderRow.TableSection = TableRowSection.TableHeader
            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub


    Private Sub CargarGrillaElementosSeleccionados()

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("ID")
            dt.Columns.Add("nombretraducido")

            Dim s As New Seguridad.Seguridad
            Dim f As New BLL.Facade_Pantalla
            Dim m As New BE.MensajeError

            For Each p As Seguridad.Elemento In u.Hijos

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

            If grdElementosSeleccionados.Rows.Count > 0 Then
                grdElementosSeleccionados.UseAccessibleHeader = True
                grdElementosSeleccionados.HeaderRow.TableSection = TableRowSection.TableHeader
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub



    Private Function ElementoYaSeleccionado(e As Seguridad.Elemento) As Boolean

        Return Not (IsNothing(u.Hijos.Find(Function(x) x.Elemento.ID = e.Elemento.ID)))

    End Function


    Private Sub noTranslateImgFlechaDerecha_Click(sender As Object, e As ImageClickEventArgs) Handles noTranslateImgFlechaDerecha.Click

        Try
            For Each i As GridViewRow In grdGruposDisponibles.Rows

                Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
                If chk.Checked Then
                    Dim g As New Seguridad.Grupo
                    g.Elemento.ID = Long.Parse(i.Cells(0).Text)
                    g.Cargar()
                    u.Hijos.Add(g)
                End If

            Next


            For Each i As GridViewRow In grdPermisosDisponibles.Rows

                Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
                If chk.Checked Then
                    Dim p As New Seguridad.Permiso
                    p.Elemento.ID = Long.Parse(i.Cells(0).Text)
                    p.Cargar()
                    u.Hijos.Add(p)
                End If

            Next

            Session("EditandoGrupo") = u

            CargarGrillaPermisos()
            CargarGrillaGrupos()
            CargarGrillaElementosSeleccionados()

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub noTranslateImgFlechaIzquierda_Click(sender As Object, e As ImageClickEventArgs) Handles noTranslateImgFlechaIzquierda.Click

        Try
            For Each i As GridViewRow In grdElementosSeleccionados.Rows

                Dim chk As CheckBox = DirectCast(i.FindControl("chkSelected"), CheckBox)
                If chk.Checked Then
                    Dim r As Seguridad.Elemento
                    r = u.Hijos.Find(Function(x) x.Elemento.ID = Long.Parse(i.Cells(0).Text))
                    u.Hijos.Remove(r)
                End If

            Next

            Session("EditandoGrupo") = u

            CargarGrillaPermisos()
            CargarGrillaGrupos()
            CargarGrillaElementosSeleccionados()

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub GrupoEdicion_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Try
            Dim m As New BE.MensajeError
            Dim f As New BLL.Facade_Pantalla

            If Not IsNothing(Session("GrupoAEditar")) Then
                m.IDError = "tituloEditarGrupo"
            Else
                m.IDError = "tituloNuevoGrupo"
            End If
            lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


            CargarGrillaPermisos()
            CargarGrillaGrupos()
            CargarGrillaElementosSeleccionados()

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