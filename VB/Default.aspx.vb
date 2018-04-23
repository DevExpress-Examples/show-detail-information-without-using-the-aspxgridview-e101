Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxTabControl
Imports System.ComponentModel

Partial Public Class Grid_MasterDetail_ShowDetailInfo_ShowDetailInfo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
    End Sub
    Protected Sub ordersGrid_DataSelect(ByVal sender As Object, ByVal e As EventArgs)
        Session("ProductID") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
    End Sub
    Private Function GetSupplierRow(ByVal visibleIndex As Integer) As DataRowView
        Session("SupplierID") = masterGrid.GetRowValues(visibleIndex, "SupplierID")
        Dim supplierView As DataView = TryCast(suppliersDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Return If(supplierView IsNot Nothing AndAlso supplierView.Count > 0, supplierView(0), Nothing)
    End Function
    #Region "Using HtmlRowCreated"
    Protected Sub masterGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As ASPxGridViewTableRowEventArgs)
        If e.RowType <> GridViewRowType.Detail Then
            Return
        End If
        Dim pageControl As ASPxPageControl = TryCast(masterGrid.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl"), ASPxPageControl)
        If pageControl Is Nothing Then
            Return
        End If
        SetSupplierLabels(GetSupplierRow(e.VisibleIndex), pageControl.TabPages(1))
    End Sub
    Private Sub SetSupplierLabels(ByVal supplierRecord As DataRowView, ByVal tabPage As TabPage)
        If supplierRecord Is Nothing Then
            Return
        End If
        SetSupplierLabel(supplierRecord, tabPage, "CompanyName")
        SetSupplierLabel(supplierRecord, tabPage, "ContactName")
        SetSupplierLabel(supplierRecord, tabPage, "ContactTitle")
        SetSupplierLabel(supplierRecord, tabPage, "Address")
        SetSupplierLabel(supplierRecord, tabPage, "City")
        SetSupplierLabel(supplierRecord, tabPage, "Region")
    End Sub
    Private Sub SetSupplierLabel(ByVal supplierRecord As DataRowView, ByVal tabPage As TabPage, ByVal fieldName As String)
        SetSupplierLabel(supplierRecord, tabPage, "lbl" & fieldName, fieldName)
    End Sub
    Private Sub SetSupplierLabel(ByVal supplierRecord As DataRowView, ByVal tabPage As TabPage, ByVal labelId As String, ByVal fieldName As String)
        Dim label As Label = TryCast(tabPage.FindControl(labelId), Label)
        If label IsNot Nothing Then
            label.Text = Convert.ToString(supplierRecord(fieldName))
        End If
    End Sub
    #End Region
    #Region "Using Server Tags"
    Private cachedSupplierRecord As DataRowView = Nothing
    Protected Function PrepareSupplierRecord(ByVal visibleIndex As Integer) As String
        cachedSupplierRecord = GetSupplierRow(visibleIndex)
        Return String.Empty
    End Function
    Protected Function GetSupplierFieldValue(ByVal fieldName As String) As String
        If cachedSupplierRecord Is Nothing Then
            Return String.Empty
        End If
        Return Convert.ToString(cachedSupplierRecord(fieldName))
    End Function
    #End Region
End Class
