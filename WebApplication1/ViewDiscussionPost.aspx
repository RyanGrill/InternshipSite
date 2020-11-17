<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewDiscussionPost.aspx.cs" Inherits="WebApplication1.ViewDiscussionPost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="ListView1" runat="server">
        <ItemTemplate>
            <div class="panel panel-default">
                <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("Title") %>' Font-Size="X-Large" Font-Bold="true"></asp:Label>
                <br />
                <asp:Label ID="bodyLabel" runat="server" Text='<%# Bind("PostBody") %>' Font-Size="Medium"></asp:Label>
                <br />
                
            </div>
        </ItemTemplate>
    </asp:ListView>
    <asp:Button ID="btnReply" runat="server" Text="Reply" OnClick="btnReply_Click"/>
    <br />
    <asp:Label ID="replyInstructLabel" runat="server" Text="Enter your reply here. Feel free to add a title if you would like, but it is not required." Visible="false"></asp:Label>
    <asp:TextBox ID="txtReplyTitle" runat="server" Rows="2" TextMode="MultiLine" CssClass="form-control" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txtReplyDesc" runat="server" Rows="6" TextMode="MultiLine" CssClass="form-control" Visible="false"></asp:TextBox>
    <asp:Button ID="btnSubmitReply" runat="server" Text="Submit Reply" OnClick="btnSubmitReply_Click" Visible="false"/>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [PostID], [Title], [PostBody], [ReplyID] FROM [QAPosts]"
        InsertCommand="INSERT INTO [QAPosts] ([Title], [PostBody], [ReplyID]) VALUES (@PostingTitle, @PostingBody, @ReplyID)">
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="PostBody" Type="String" />
            <asp:Parameter Name="ReplyID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnDelete" runat="server" Text="Delete Post And Replies" Visible="false" OnClick="btnDelete_Click"/>
</asp:Content>

