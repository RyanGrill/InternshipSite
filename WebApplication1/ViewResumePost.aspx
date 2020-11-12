<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewResumePost.aspx.cs" Inherits="WebApplication1.ViewResumePost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:LinkButton ID="lnkBtnDownload" runat="server" Text="Download Resume" OnClick="lnkBtnDownload_Click" Font-Size="Large" Font-Bold="true"></asp:LinkButton> 
    <br />
    <asp:ListView ID="ListView1" runat="server">
        <ItemTemplate>
            <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("Title") %>' Font-Size="X-Large" Font-Bold="true"></asp:Label>
            <br />
            <asp:Label ID="bodyLabel" runat="server" Text='<%# Bind("Body") %>' Font-Size="Medium"></asp:Label>
            <br />
            <br />
        </ItemTemplate>
    </asp:ListView>
    <asp:Button ID="btnReply" runat="server" Text="Reply" OnClick="btnReply_Click"/>
    <br />
    <asp:Label ID="replyInstructLabel" runat="server" Text="Enter your feedback here. Feel free to add a title if you would like, but it is not required." Visible="false"></asp:Label>
    <asp:TextBox ID="txtReplyTitle" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txtReplyDesc" runat="server" Rows="6" TextMode="MultiLine" CssClass="form-control" Visible="false"></asp:TextBox>
    <asp:Button ID="btnSubmitReply" runat="server" Text="Submit Reply" OnClick="btnSubmitReply_Click" Visible="false"/>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [ID], [Resume] [Title], [Body], [ReplyID] FROM [Resume]"
        InsertCommand="INSERT INTO [ResumePosts] ([Title], [Body], [ReplyID]) VALUES (@Title, @Body, @ReplyID)">
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Body" Type="String" />
            <asp:Parameter Name="ReplyID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
