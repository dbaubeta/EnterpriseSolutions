Public Class EditarLenguaje
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        l = b.Obtener_Idiomas()

        'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
        If Not IsPostBack Then
            Me.dlIdiomas.DataValueField = "ID"
            Me.dlIdiomas.DataTextField = "Nombre"
            Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
            Me.dlIdiomas.DataBind()
            dlIdiomas_SelectedIndexChanged(sender, e)
        End If

    End Sub

    Private Sub grdLeyendas_PreRender(sender As Object, e As EventArgs) Handles grdLeyendas.PreRender

        If Not IsPostBack Then

        End If

    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim falta As Boolean = False
        Dim x As New BE.Idioma
        Dim bi As New BLL.Idioma

        x.Nombre = Me.txtLenguajeNombre.Text
        x.Leyendas = New List(Of BE.Leyenda)
        For Each gvr As GridViewRow In Me.grdLeyendas.Rows
            Dim l As New BE.Leyenda
            l.IDLeyenda = gvr.Cells(0).Text()
            l.texto_Leyenda = DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox).Text
            x.Leyendas.Add(l)
        Next

        bi.Guardar(x)


    End Sub

    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("IDLeyenda")
        dt.Columns.Add("TextoLeyenda")

        b.ID = dlIdiomas.SelectedValue
        il.Add(b)
        Dim i As BE.Idioma = bl.Obtener_Idiomas(il)(0)
        For Each l In i.Leyendas

            Dim dr As DataRow = dt.NewRow
            dr("IDLeyenda") = l.IDLeyenda
            dr("TextoLeyenda") = l.texto_Leyenda
            'dr("NuevoTextoLeyenda") = l.texto_Leyenda
            dt.Rows.Add(dr)
        Next

        grdLeyendas.DataSource = Nothing
        grdLeyendas.DataSource = dt
        grdLeyendas.DataBind()

        grdLeyendas.UseAccessibleHeader = True
        grdLeyendas.HeaderRow.TableSection = TableRowSection.TableHeader


    End Sub


End Class

