<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="WebApplication1.ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        Manage Users
    </h3>
    <h4>
        View/Delete Users:
    </h4>
    <asp:GridView ID="grdUsers" runat="server" DataKeyNames="Id" ItemType="WebApplication1.Models.ApplicationUser" CssClass="table table-bordered table-striped table-consdensed"
        AutoGenerateColumns="false" SelectMethod="GridView1_GetData" OnPreRender="GridView1_PreRender">
        <Columns>
            <asp:BoundField HeaderText="Email" DataField="Email" />
            <asp:TemplateField HeaderText="Roles">
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# ListRoles(Item.Roles) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="true" />
        </Columns>
    </asp:GridView>

    <asp:DetailsView ID="dvUsers" runat="server" AutoGenerateRows="false" SelectMethod="dvUsers_GetItem" DeleteMethod="dvUsers_DeleteItem" ItemType="WebApplication1.Models.ApplicationUser">
        <HeaderTemplate>
            <p>Selected User:</p>
        </HeaderTemplate>
        <Fields>
            <asp:BoundField DataField="id" SortExpression="id" />
            <asp:BoundField DataField='Email' SortExpression="Email" />
            <asp:CommandField ButtonType="Link" ShowDeleteButton="true" />
        </Fields>
    </asp:DetailsView>

    <div>
        <h4>
            Add roles to a user:
        </h4>
        <div>
            <asp:DropDownList ID="ddlUsers" runat="server" SelectMethod="ddlUsers_GetData" ItemType="WebApplication1.Models.ApplicationUser" DataValueField="Email"></asp:DropDownList>
        </div>
        <div>
            <asp:DropDownList ID="ddlRoles" runat="server" SelectMethod="ddlRoles_GetData" DataValueField="Name"></asp:DropDownList>
        </div>
    </div>
    <asp:Button runat="server" Text="Add/Remove Role To User" ID="btnAddRoles" OnClick="btnAddRoles_Click" />
    <br />
    <br />
    <h4>
        <asp:Label ID="lblAddRole" runat="server" Text="Add new Role" ></asp:Label>
    </h4>
   
    <div>
        <div>
            <asp:Label ID="lblInstruct" runat="server" Text="Enter a name for the role here:"></asp:Label>
            <asp:TextBox ID="txtRoleName" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
        </div>
    </div>
    <asp:Button runat="server" ID="btnAddRole" Text="Add New Role" OnClick="btnAddRole_Click" />

</asp:Content>
