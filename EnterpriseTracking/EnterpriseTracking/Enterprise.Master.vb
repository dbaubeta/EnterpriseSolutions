Imports System.IO




Public Class Enterprise
    Inherits System.Web.UI.MasterPage

    Dim lp As New List(Of Seguridad.Elemento)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Single el usuario no esta cargado lo mando a login
        If IsNothing(Session("Usuario")) Then
            Session("Idioma") = Nothing
            Session("Usuario") = Nothing
            Response.Redirect("~/Login.aspx")
        End If

        ' Cargo la lista de permisos del usuario en memoria una unica vez
        'If Not IsPostBack Then
        For Each el As Seguridad.Elemento In DirectCast(Session("Usuario"), Seguridad.Usuario).Elementos
            lp.AddRange(el.ObtenerPermisos)
        Next
        'End If

        ' Si la pantalla actual no esta en la lista de permisos del usuario o no es admin lo mando a login
        Dim formname As String = Path.GetFileName(Request.PhysicalPath).Replace(".aspx", "")
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = formname)) And DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID = 1 Then
            Session("Idioma") = Nothing
            Session("Usuario") = Nothing
            Response.Redirect("~/Login.aspx")
        End If


    End Sub


    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        b.ID = dlIdiomas.SelectedValue
        il.Add(b)
        b = bl.Obtener_Idiomas(il)(0)

        f.Traducir(Me, b)
        Session("Idioma") = b

    End Sub



    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma

        ' Creo los permisos de la pagina si no existen -- ESTO NO ES CODIGO FINAL. SOLO SIRVE PARA ACELERAR EL DESARROLLO
        Dim formname As String = Path.GetFileName(Request.PhysicalPath).Replace(".aspx", "")
        Dim s As New Seguridad.Permiso
        s.Elemento.nombre = formname
        s.Elemento.Tipo = 0
        Try
            s.Guardar()
            cargarpermisosbase(Me)
        Catch
        End Try

        'Solo cargo la lista si no es postback (evito cargar cuando cambio el idioma en el dropdwon
        If Not IsPostBack Then
            Me.dlIdiomas.DataValueField = "ID"
            Me.dlIdiomas.DataTextField = "Nombre"
            Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
            Me.dlIdiomas.DataBind()
        End If

        If Not (IsNothing(Session("Idioma"))) Then
            dlIdiomas.SelectedValue = DirectCast(Session("Idioma"), BE.Idioma).ID
        End If

        'Traduzco la pagina
        f.Traducir(Me, DirectCast(Session("Idioma"), BE.Idioma))

        'Aplico los permisos
        f.Aplicar_Permisos(Me, DirectCast(Session("Usuario"), Seguridad.Usuario), formname)

        ' Genero el menu
        GenerarMenu(DirectCast(Session("Usuario"), Seguridad.Usuario))

    End Sub

    Private Sub cargarpermisosbase(c As Control)

        Dim formname As String = Path.GetFileName(Request.PhysicalPath).Replace(".aspx", "")

        If TypeOf c Is Button Or TypeOf c Is Page Or TypeOf c Is HtmlButton Then
            If Not IsNothing(c.ID) Then
                If c.ID.StartsWith("btnNuevo") Or c.ID.StartsWith("btnEditar") Or c.ID.StartsWith("btnEliminar") Or c.ID.StartsWith("btnAsignar") Or c.ID.StartsWith("btnRestore") Then
                    Dim s As New Seguridad.Permiso
                    s.Elemento.nombre = IIf(c.ID.StartsWith("mnuButton"), "", formname + "_") + c.ID
                    s.Elemento.Tipo = 0
                    s.Guardar()
                End If
            End If
        End If


        'Creo todos los permisos de la pantalla.
        For Each x As Control In c.Controls
            cargarpermisosbase(x)
        Next

    End Sub


    Protected Sub mnuButtonLogout_Click(sender As Object, e As EventArgs) Handles mnuButtonLogout.Click

        Dim bit As New Bitacora.Bitacora

        Session("Idioma") = Nothing
        bit.Guardar(New BE.Bitacora("BIT_Logout", "Logout", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID))
        Session("Usuario") = Nothing
        Response.Redirect("~/Login.aspx")

    End Sub


    Private Sub GenerarMenu(p_usuario As Seguridad.Usuario)

        Dim err As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla
        Dim li As HtmlGenericControl
        Dim itemname As String

        Me.noTranslateListaConcursos.Controls.Clear()
        Me.noTranslateListaIdiomas.Controls.Clear()
        Me.noTranslateListaReportes.Controls.Clear()
        Me.noTranslateListaSecuencias.Controls.Clear()
        Me.noTranslateListaSeguridad.Controls.Clear()
        Me.noTranslateListaTablas.Controls.Clear()


        ' Generar Menu tablas
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")
        itemname = "Cliente"
        err.IDError = "mnuButtonTablas_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaTablas.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Producto"
        err.IDError = "mnuButtonTablas_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaTablas.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Categoria"
        err.IDError = "mnuButtonTablas_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaTablas.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Distribuidor"
        err.IDError = "mnuButtonTablas_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaTablas.Controls.Add(li)

        ' Generar Menu Secuencias
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")
        itemname = "CargaManual"
        err.IDError = "mnuButtonSecuencias_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSecuencias.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Transmisiones"
        err.IDError = "mnuButtonSecuencias_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSecuencias.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "PanelControl"
        err.IDError = "mnuButtonSecuencias_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSecuencias.Controls.Add(li)


        ' Generar Menu Reportes
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")
        itemname = "VtasxDistVend"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "RAnkingDistVend"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Stock"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "ValStockPPP"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "ValStockFIFO"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "ValStockLIFO"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "ProyeccionVtas"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "InvasionZonas"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "VtasxCatProd"
        err.IDError = "mnuButtonReportes_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaReportes.Controls.Add(li)

        ' Generar Menu Concursos
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")
        itemname = "Concurso"
        err.IDError = "mnuButtonConcursos_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaConcursos.Controls.Add(li)


        ' Generar Menu Seguridad
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")
        itemname = "Usuario"
        err.IDError = "mnuButtonSeguridad_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSeguridad.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Grupo"
        err.IDError = "mnuButtonSeguridad_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSeguridad.Controls.Add(li)

        li = New HtmlGenericControl("li")
        itemname = "Backup"
        err.IDError = "mnuButtonSeguridad_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaSeguridad.Controls.Add(li)

        ' Generar Menu Idioma
        ' =====================================================================================================================
        li = New HtmlGenericControl("li")

        itemname = "Idioma"
        err.IDError = "mnuButtonIdioma_" + itemname
        li.InnerHtml = "<a href=""" + itemname + "Lista.aspx"">" + f.ObtenerLeyenda(err, Session("Idioma")).texto_Leyenda + "</a>"
        If Not IsNothing(lp.Find(Function(x) x.Elemento.nombre = itemname + "Lista")) Or p_usuario.Usuario.ID = 1 Then Me.noTranslateListaIdiomas.Controls.Add(li)

        'Oculto los botones que no tengan ningun permiso
        If noTranslateListaTablas.Controls.Count = 0 Then mnuButtonTablas.Visible = False
        If noTranslateListaSecuencias.Controls.Count = 0 Then mnuButtonSecuencias.Visible = False
        If noTranslateListaReportes.Controls.Count = 0 Then mnuButtonReportes.Visible = False
        If noTranslateListaConcursos.Controls.Count = 0 Then mnuButtonConcursos.Visible = False
        If noTranslateListaSeguridad.Controls.Count = 0 Then mnuButtonSeguridad.Visible = False
        If noTranslateListaIdiomas.Controls.Count = 0 Then mnuButtonIdioma.Visible = False

    End Sub



End Class