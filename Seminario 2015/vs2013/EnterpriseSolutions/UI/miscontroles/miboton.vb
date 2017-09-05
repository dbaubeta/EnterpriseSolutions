
Public Class miboton
    Inherits System.Web.UI.WebControls.Button

    Implements ITraducible

    Public Sub Traducir(keyIdioma As String) Implements ITraducible.Traducir
        Me.Text = keyIdioma
    End Sub

End Class
