<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewPost.aspx.cs" Inherits="WebApplication1.ViewPost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="ListView1" runat="server"></asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" SelectCommand="SELECT [PostID], [Title], [PostBody], [ReplyID] FROM [QAPosts]"></asp:SqlDataSource>

</asp:Content>
