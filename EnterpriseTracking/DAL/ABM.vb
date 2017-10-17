Public MustInherit Class ABM

    Protected DBH As New SqlHelper

    Public MustOverride Sub Eliminar(o As BE.ABM)


    Public MustOverride Sub Guardar(ob As BE.ABM)


    Public MustOverride Function ObtenerLista(Optional f As List(Of BE.ABM) = Nothing) As List(Of BE.ABM)


End Class

