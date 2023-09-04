<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="GenerateQrCode.aspx.cs" Inherits="eAPF.admin.GenerateQrCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    
<style type="text/css">
   
    .GridPager a,
.GridPager span {
    display: inline-block;
    padding: 0px 9px;
    margin-right: 4px;
    border-radius: 3px;
    border: solid 1px #c0c0c0;
    background: #e9e9e9;
    box-shadow: inset 0px 1px 0px rgba(255,255,255, .8), 0px 1px 3px rgba(0,0,0, .1);
    font-size: .875em;
    font-weight: bold;
    text-decoration: none;
    color: #717171;
    text-shadow: 0px 1px 0px rgba(255,255,255, 1);
}

.GridPager a {
    background-color: #f5f5f5;
    color: #969696;
    border: 1px solid #969696;
}

.GridPager span {

    background: #616161;
    box-shadow: inset 0px 0px 8px rgba(0,0,0, .5), 0px 1px 0px rgba(255,255,255, .8);
    color: #f0f0f0;
    text-shadow: 0px 0px 3px rgba(0,0,0, .5);
    border: 1px solid #3AC0F2;
}
</style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="panel-group">



        <div class="panel panel-success">
            <div class="panel-heading">QR Entry Form</div>
            <div class="panel-body">

                </div>
            </div>




        <div class="panel panel-success">
            <div class="panel-heading">Generate QR Code</div>
            <div class="panel-body">

                <asp:GridView ID="qrCodesGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" AllowPaging="True" PageSize="5" OnPageIndexChanging="qrCodesGridView_PageIndexChanging">
                    <Columns>
                        <asp:BoundField DataField="QRCodeNo" HeaderText="QRCodeNo" />
                        <asp:BoundField DataField="ContactName" HeaderText="Content Name" />

                        <asp:BoundField DataField="ContactDesignation" HeaderText="Designation" />
                        <asp:BoundField DataField="ContactOrg" HeaderText="Org" />
                        <asp:BoundField DataField="EmailId" HeaderText="EmailId" />
                        <asp:BoundField DataField="ContactMob" HeaderText="Mobile No." />

                        <asp:TemplateField HeaderText="QR Code">
                            <ItemTemplate>
                                <asp:Image ID="qrCodeImage" runat="server" Width="100" Height="100" ImageUrl='<%# "~/images/qrcode_" + Eval("QRCodeNo") + ".png" %>' />
                                <%--                     <asp:Image ID="Image1"  runat="server" Width="100" Height="100" ImageUrl='<%# "~/images/qrcode_" + Eval("QRCodeNo") + ".png" %>'  />--%>
                                <asp:Button ID="downloadButton" runat="server" Text="Download" OnClick="DownloadButton_Click" CommandArgument='<%# Eval("QRCodeNo") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    
<PagerStyle HorizontalAlign = "Right" CssClass = "GridPager" />

                </asp:GridView>


            </div>
            <div class="panel-footer">End</div>

        </div>






    </div>




</asp:Content>
