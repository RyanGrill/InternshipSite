<%@ Page Title="New Post" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewDiscussionPost.aspx.cs" Inherits="InternshipSite.Forms.WebForm2" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="col-sm-3">Enter your question:</div>
    <div class="col-sm-7">
        <asp:TextBox ID="txtQuestion" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtQuestion" ErrorMessage="The question being asked is required" 
                Display="Dynamic" CssClass="text-danger" ValidationGroup="Add"/>
    </div> 
    <div class="col-sm-3">Enter a description of the question:</div>
    <div class="col-sm-7">
        <asp:TextBox ID="txtQuestionDesc" runat="server" Rows="6" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtQuestion" ErrorMessage="A description is required" 
                Display="Dynamic" CssClass="text-danger" ValidationGroup="Add"/>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM [QAPosts]"
        InsertCommand="INSERT INTO [QAPosts] ([Title], [PostBody]) VALUES (@PostingTitle, @PostingBody)">
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="PostBody" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Button ID="btnAddPost" runat="server" Text="Submit Question" CssClass="btn btn-primary" ValidationGroup="Add" OnClick="btnAddPost_Click" />
</asp:Content>

