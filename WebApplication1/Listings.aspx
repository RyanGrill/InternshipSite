﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listings.aspx.cs" Inherits="InternshipSite.Forms.Listings" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="row">
        <div class="col-sm-6 table-responsive">

            <%-- Posting GridView --%>
            <asp:GridView ID="grdListings" runat="server" AllowPaging="True" PageSize="8" AllowSorting="True" 
                AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" SelectedIndex="0" 
                CssClass="table table-bordered table-condensed" OnPreRender="grdListings_PreRender">
                <Columns>
                    <asp:BoundField DataField="PostingTitle" HeaderText="PostingTitle" SortExpression="PostingTitle" />
                </Columns>
                <HeaderStyle CssClass="header" />
                <AlternatingRowStyle CssClass="active" />
                <SelectedRowStyle CssClass="warning" />
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle CssClass="header" HorizontalAlign="Center"  />
            </asp:GridView>
            <%-- Sql data source --%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>"
                SelectCommand="SELECT [ID], [PostingTitle] FROM [JobPostings]" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>">
            </asp:SqlDataSource>
        </div>

        <div class="col-sm-6 ">
            <%-- Posting DetailsView --%>
            <asp:DetailsView ID="dtlCustomer" runat="server" DataSourceID="SqlDataSource2" 
                AutoGenerateRows="False" 
                CssClass="table table-bordered table-condensed" DataKeyNames="ID">
                <HeaderTemplate>
                    <p>Job Listing:</p>
                </HeaderTemplate>
                <HeaderStyle CssClass="header" />
                <Fields>
                    <asp:BoundField DataField="PostingTitle" SortExpression="PostingTitle" />
                    <asp:BoundField DataField="PostingBody" SortExpression="PostingBody"/>
                    <asp:HyperLinkField DataNavigateUrlFields="PostingLink" DataTextField="PostingLink" SortExpression="PostingLink"  />
                </Fields>
            </asp:DetailsView>
            <%-- Sql data source --%>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>"  
                SelectCommand="SELECT [ID], [PostingTitle], [PostingBody], [PostingLink] FROM [JobPostings] WHERE ([ID] = @ID)" 
                ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>">
                <SelectParameters>
                    <asp:ControlParameter ControlID="grdListings" Name="ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    
</asp:Content>
