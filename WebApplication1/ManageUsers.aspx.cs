using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Models;

namespace WebApplication1
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        ApplicationUserManager userMgr;
        ApplicationRoleManager roleMgr;

        protected void Page_Load(object sender, EventArgs e)
        {
            userMgr = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            roleMgr = Context.GetOwinContext().Get<ApplicationRoleManager>();

        }

        public IQueryable<WebApplication1.Models.ApplicationUser> GridView1_GetData()
        {
            return userMgr.Users;
        }

        public IQueryable<WebApplication1.Models.ApplicationUser> ddlUsers_GetData()
        {
            return userMgr.Users;
        }

        public IQueryable<IdentityRole> ddlRoles_GetData()
        {
            return roleMgr.Roles;
        }

        public Object dvUsers_GetItem([Control] string grdUsers)
        {
            if (grdUsers == null) return new ApplicationUser();
            return (from u in userMgr.Users where u.Id == grdUsers select u).SingleOrDefault();
        }

        public object dvRoles_GetItem([Control] string grdRoles)
        {
            if (grdRoles == null) return new IdentityRole();
            return (from u in roleMgr.Roles where u.Id == grdRoles select u).SingleOrDefault();
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            GridView grid = (GridView) sender;
            if (grid.HeaderRow != null) grid.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void dvUsers_DeleteItem(string id)
        {
            ApplicationUser user = (from u in userMgr.Users where u.Id == id select u).SingleOrDefault();
            IdentityResult result = userMgr.Delete(user);
            if (result.Succeeded) Reload();
        }

        protected void btnAddRoles_Click(object sender, EventArgs e)
        {
            ApplicationUser user = userMgr.FindByEmail(ddlUsers.SelectedValue);
            string roleID = ddlRoles.SelectedValue;
            if(!userMgr.IsInRole(user.Id, ddlRoles.SelectedItem.Text))
            {
                userMgr.AddToRole(user.Id, ddlRoles.SelectedItem.Text);
            }
            else
            {
                if(userMgr.IsInRole(user.Id, ddlRoles.SelectedItem.Text))
                {
                    userMgr.RemoveFromRole(user.Id, ddlRoles.SelectedItem.Text);
                }
            }

            grdUsers.DataBind();
        }

        public string ListRoles(ICollection<IdentityUserRole> userRoles)
        {
            IdentityRole role;
            var names = new List<string>();

            foreach(var ur in userRoles)
            {
                role = (from r in roleMgr.Roles where r.Id == ur.RoleId select r).SingleOrDefault();
                names.Add(role.Name);
            }
            return string.Join(", ", names);
        }

        private void Reload()
        {
            grdUsers.DataBind();
            ddlRoles.DataBind();
            ddlUsers.DataBind();
        }

        protected void btnAddRole_Click(object sender, EventArgs e)
        {
            if (txtRoleName.Text != null)
            {
                ApplicationRoleManager roleMgr = Context.GetOwinContext().Get<ApplicationRoleManager>();
                IdentityRole role = new IdentityRole();
                role.Name = txtRoleName.Text;
                IdentityResult result = roleMgr.Create(role);
                if (result.Succeeded)
                {
                    Reload();
                }
            }
        }

        // The id parameter should match the DataKeyNames value set on the control
        // or be decorated with a value provider attribute, e.g. [QueryString]int id

    }
}