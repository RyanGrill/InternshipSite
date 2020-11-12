<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewResumePost.aspx.cs" Inherits="WebApplication1.Content.NewResumePost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        New Resume Post
    </h3>
    
    <asp:Label ID="UploadInstructLabel" Text="Upload a resume here (doc/docx only please): " runat="server" Font-Bold="true"></asp:Label>
    <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:Label ID="fileWarningLabel" Text="File is not of correct file type" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
    <br /> 
    <asp:Label ID="TitleInstructLabel" Text="Enter a title for your post: " runat="server" Font-Bold="true"></asp:Label>
    <asp:TextBox ID="txtTitle" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
    <asp:Label ID="DescIntructLabel" Text="Enter additional information or questions here: " runat="server" Font-Bold="true"></asp:Label>
    <asp:TextBox ID="txtDesc" runat="server" Rows="6" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>

    <asp:Button ID="btnSubmitResumeButton" Text="Submit Post" OnClick="SubmitResumeButton_Click" runat="server" Font-Bold="true"/>
</asp:Content>

