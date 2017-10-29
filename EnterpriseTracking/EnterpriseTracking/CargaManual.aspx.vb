Imports System.IO
Imports System.Xml
Imports System.Xml.Schema

Public Class CargaManual
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click

        Dim folderPath As String = Server.MapPath("~/files/")
        Dim xsdfile As String = Server.MapPath("~/xml/secuencia.xsd")

        ' Si no existe el directorio lo creo
        If Not Directory.Exists(folderPath) Then
            Directory.CreateDirectory(folderPath)
        End If

        'Guardo el archivo 
        Dim archivosalida As String = folderPath & Path.GetFileName(fuArchivo.FileName)
        fuArchivo.SaveAs(archivosalida)


        Dim s As New BE.Secuencia
        Dim bs As New BLL.Secuencia
        Dim l As List(Of BE.MensajeError)

        l = bs.Cargar(archivosalida, xsdfile, s)
        If IsNothing(l) Then
            MsgBox("Todo ok")
        Else
            MsgBox("caca")
        End If

    End Sub















End Class


