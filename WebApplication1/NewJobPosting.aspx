<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewJobPosting.aspx.cs" Inherits="WebApplication1.NewJobPosting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-sm-3">Enter the title for the posting:</div>
    <div class="col-sm-7">
        <asp:TextBox ID="txtTitle" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtQuestion" ErrorMessage="The question being asked is required" 
                Display="Dynamic" CssClass="text-danger" ValidationGroup="Add"/>
    </div> 
    <div class="col-sm-3">Enter a description of the job:</div>
    <div class="col-sm-7">
        <asp:TextBox ID="txtPostingDesc" runat="server" Rows="6" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtQuestion" ErrorMessage="A description is required" 
                Display="Dynamic" CssClass="text-danger" ValidationGroup="Add"/>
    </div>
    <div class="col-sm-3">Enter the web address for the application:</div>
    <div class="col-sm-7">
        <asp:TextBox ID="txtPostLink" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txtQuestion" ErrorMessage="A web address is required" 
            Display="Dynamic" CssClass="text-danger" ValidationGroup="Add"/>
    </div>
    

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM [JobPostings]"
        InsertCommand="INSERT INTO [JobPostings] ([PostingTitle], [PostingBody], [PostingLink]) VALUES (@PostingTitle, @PostingBody, @PostingLink)">
        <InsertParameters>
            <asp:Parameter Name="PostingTitle" Type="String" />
            <asp:Parameter Name="PostingBody" Type="String" />
            <asp:Parameter Name="PostingLink" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Button ID="btnAddPosting" runat="server" Text="Submit Question" CssClass="btn btn-primary" ValidationGroup="Add" OnClick="btnAddPosting_Click" />
</asp:Content>
