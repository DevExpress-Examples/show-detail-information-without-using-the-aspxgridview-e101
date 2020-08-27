<%-- BeginRegion TagPrefix and page properties --%>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Grid_MasterDetail_ShowDetailInfo_ShowDetailInfo" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxEditors"  TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxPager" TagPrefix="dxwp" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>

<%-- EndRegion --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show detail information without using the ASPxGridView</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <dxwgv:ASPxGridView ID="masterGrid" ClientInstanceName="masterGrid" runat="server" DataSourceID="masterDataSource" Width="100%" AutoGenerateColumns="False" KeyFieldName="ProductID" OnHtmlRowCreated="masterGrid_HtmlRowCreated">
        <Columns>
            <dxwgv:GridViewDataColumn FieldName="ProductName" VisibleIndex="0" />
            <dxwgv:GridViewDataColumn FieldName="CategoryName" VisibleIndex="1" />
            <dxwgv:GridViewDataColumn FieldName="Description" VisibleIndex="2" />
            <dxwgv:GridViewDataColumn FieldName="SupplierID" Visible="false" />
        </Columns>
        <SettingsDetail ShowDetailRow="True"/>
        <Templates>
            <DetailRow>
            <div style="padding:3px 3px 2px 3px">
                <%# PrepareSupplierRecord(Container.VisibleIndex) %>
                <dxtc:ASPxPageControl runat="server" ID="pageControl" Width="100%">
                <TabPages>
                    <dxtc:TabPage Text="Orders" Visible="true">
                        <ContentCollection><dxw:ContentControl runat="server">
                            <dxwgv:ASPxGridView ID="ordersGrid" runat="server" DataSourceID="ordersDataSource" 
                                KeyFieldName="OrderID" Width="100%" OnBeforePerformDataSelect="ordersGrid_DataSelect" >
                                <%-- BeginRegion Grid Columns --%>
                                <Columns>
                                    <dxwgv:GridViewDataColumn FieldName="CompanyName" VisibleIndex="0" />
                                    <dxwgv:GridViewDataColumn FieldName="OrderDate" VisibleIndex="1" />
                                    <dxwgv:GridViewDataColumn FieldName="Region" VisibleIndex="2" />
                                    <dxwgv:GridViewDataColumn FieldName="Country" VisibleIndex="3" />
                                    <dxwgv:GridViewDataColumn FieldName="Quantity" VisibleIndex="4" />
                                    <dxwgv:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="5">
                                        <PropertiesTextEdit DisplayFormatString="c">
                                        </PropertiesTextEdit>
                                    </dxwgv:GridViewDataTextColumn>
                                </Columns>
                                <%-- EndRegion --%>
                            </dxwgv:ASPxGridView>
                        </dxw:ContentControl></ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Supplier Info (using the HtmlRowCreated event)"  Visible="true">
                        <ContentCollection><dxw:ContentControl runat="server">
                            <div>Using the HtmlRowCreated event</div>
                            <table cellpadding="3" cellspacing="4" style="font-size:x-small">
                                <tr>
                                    <td> Company Name:</td> <td style="font-weight:bold"><asp:Label ID="lblCompanyName" runat="server"></asp:Label></td>
                                    <td> Contact Name:</td> <td style="font-weight:bold"><asp:Label ID="lblContactName" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td> Contact Title:</td> <td style="font-weight:bold"><asp:Label ID="lblContactTitle" runat="server"></asp:Label></td>
                                    <td> Address:</td> <td style="font-weight:bold"><asp:Label ID="lblAddress" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td> City:</td> <td style="font-weight:bold"><asp:Label ID="lblCity" runat="server"></asp:Label></td>
                                    <td> Region:</td> <td style="font-weight:bold"><asp:Label ID="lblRegion" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                            
                        </dxw:ContentControl></ContentCollection>
                    </dxtc:TabPage>
                    <dxtc:TabPage Text="Supplier Info (using the Server Tags)"  Visible="true">
                        <ContentCollection><dxw:ContentControl runat="server">
                            <div>Using the Server Tags</div>
                            <table cellpadding="3" cellspacing="4" style="font-size:x-small">
                                <tr>
                                    <td> Company Name:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("CompanyName") %></td>
                                    <td> Contact Name:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("ContactName") %></td>
                                </tr>
                                <tr>
                                    <td> Contact Title:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("ContactTitle") %></td>
                                    <td> Address:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("Address") %></td>
                                </tr>
                                <tr>
                                    <td> City:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("City") %></td>
                                    <td> Region:</td> <td style="font-weight:bold"><%#GetSupplierFieldValue("Region") %></td>
                                </tr>
                            </table>
                            
                        </dxw:ContentControl></ContentCollection>
                    </dxtc:TabPage>
                </TabPages>
            </dxtc:ASPxPageControl>
            </div>
            </DetailRow>
        </Templates>
    </dxwgv:ASPxGridView>
    <%-- BeginRegion DataSource --%>
    <asp:AccessDataSource ID="masterDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT [ProductID], [SupplierID], [ProductName], [CategoryName], [Description] FROM [CategoryProducts]"> 
    </asp:AccessDataSource>
    <%-- EndRegion --%>
    <asp:AccessDataSource ID="ordersDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT [Customers.CompanyName] AS CompanyName, [City], [Region], [Country], [OrderID], [UnitPrice], [Quantity], [OrderDate] FROM [Invoices] Where [ProductID] = ?">
        <SelectParameters>
            <asp:SessionParameter Name="ProductID" SessionField="ProductID" Type="int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="suppliersDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage FROM Suppliers WHERE (SupplierID = ?)">
        <SelectParameters>
            <asp:SessionParameter Name="SupplierID" SessionField="SupplierID" Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    </form>
</body>
</html>
