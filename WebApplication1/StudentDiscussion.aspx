<%@ Page Title="DiscussionStartPage" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentDiscussion.aspx.cs" Inherits="InternshipSite.Forms.StudentDiscussion" %>

<asp:Content ID="main" ContentPlaceHolderID="mainContent" runat="server">
    <h3>
        Find a question that you have or create a new post here:
    </h3> 
    
    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
         <EmptyDataTemplate>
             <table runat="server" style="">
                 <tr>
                     <td>No data was returned.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                 </td>
                 <td>
                     <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="">
                 <td>
                     <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl= '<%# "ViewDiscussionPost.aspx?id="+Eval("PostID") %>' Text='<%# Eval("Title") %>' Font-Size="Medium"></asp:LinkButton>
                 </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                            <tr runat="server" style="">
                                <th runat="server">Title</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>
         <SelectedItemTemplate>
             <asp:DataPager ID="DataPager1" runat="server" PageSize="4">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" />
                    </Fields>
            </asp:DataPager>
         </SelectedItemTemplate>
       </asp:ListView>

    
    <asp:Button ID="btnNewQuestion" runat="server" Text="New Question" PostBackUrl="NewDiscussionPost.aspx" CssClass="btn btn-primary"/>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" SelectCommand="SELECT [PostID],[Title], [PostBody] FROM [QAPosts] WHERE [ReplyID] = 0"></asp:SqlDataSource>
</asp:Content>
