using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxTabControl;
using System.ComponentModel;

public partial class Grid_MasterDetail_ShowDetailInfo_ShowDetailInfo : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
    }
    protected void ordersGrid_DataSelect(object sender, EventArgs e) {
        Session["ProductID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    DataRowView GetSupplierRow(int visibleIndex) {
        Session["SupplierID"] = masterGrid.GetRowValues(visibleIndex, "SupplierID");
        DataView supplierView = suppliersDataSource.Select(DataSourceSelectArguments.Empty) as DataView;
        return supplierView != null && supplierView.Count > 0 ? supplierView[0] : null;
    }
    #region Using HtmlRowCreated
    protected void masterGrid_HtmlRowCreated(object sender, ASPxGridViewTableRowEventArgs e) {
        if(e.RowType != GridViewRowType.Detail) return;
        ASPxPageControl pageControl = masterGrid.FindDetailRowTemplateControl(e.VisibleIndex, "pageControl") as ASPxPageControl;
        if(pageControl == null) return;
        SetSupplierLabels(GetSupplierRow(e.VisibleIndex), pageControl.TabPages[1]);
    }
    void SetSupplierLabels(DataRowView supplierRecord, TabPage tabPage) {
        if(supplierRecord == null) return;
        SetSupplierLabel(supplierRecord, tabPage, "CompanyName");
        SetSupplierLabel(supplierRecord, tabPage, "ContactName");
        SetSupplierLabel(supplierRecord, tabPage, "ContactTitle");
        SetSupplierLabel(supplierRecord, tabPage, "Address");
        SetSupplierLabel(supplierRecord, tabPage, "City");
        SetSupplierLabel(supplierRecord, tabPage, "Region");
    }
    void SetSupplierLabel(DataRowView supplierRecord, TabPage tabPage, string fieldName) {
        SetSupplierLabel(supplierRecord, tabPage, "lbl" + fieldName, fieldName);
    }
    void SetSupplierLabel(DataRowView supplierRecord, TabPage tabPage, string labelId, string fieldName) {
        Label label = tabPage.FindControl(labelId) as Label;
        if(label != null) {
            label.Text = Convert.ToString(supplierRecord[fieldName]);
        }
    }
    #endregion
    #region Using Server Tags
    DataRowView cachedSupplierRecord = null;
    protected string PrepareSupplierRecord(int visibleIndex) {
        cachedSupplierRecord = GetSupplierRow(visibleIndex);
        return string.Empty;
    }
    protected string GetSupplierFieldValue(string fieldName) {
        if(cachedSupplierRecord == null) return string.Empty;
        return Convert.ToString(cachedSupplierRecord[fieldName]);
    }
    #endregion
}
