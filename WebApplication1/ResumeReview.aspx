<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResumeReview.aspx.cs" Inherits="WebApplication1.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        Post a resume here to review, or review someone elses!
    </h3>

    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>
         <EditItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 </td>
                 <td>
                     <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                 </td>
             </tr>
         </EditItemTemplate>
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
                     <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl= '<%# "ViewResumePost.aspx?id="+Eval("ID") %>' Text='<%# Eval("Title") %>' Font-Size="Medium"></asp:LinkButton>
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
             <tr style="">
                 <td>
                     <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                 </td>
             </tr>
             <asp:DataPager ID="DataPager1" runat="server" PageSize="4">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" />
                    </Fields>
            </asp:DataPager>
         </SelectedItemTemplate>
       </asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InternshipSiteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:InternshipSiteDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [ID],[Title] FROM [ResumePosts] WHERE [ReplyID] = 0"></asp:SqlDataSource>

    <asp:Button ID="btnNewResumePost" runat="server" Text="New Resume Post" PostBackUrl="NewResumePost.aspx" CssClass="btn btn-primary"/>
</asp:Content>
