using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InternshipSite.Forms
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void btnAddPost_Click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["Title"].DefaultValue = txtQuestion.Text;
            SqlDataSource1.InsertParameters["PostBody"].DefaultValue = txtQuestionDesc.Text;
            try
            {
                SqlDataSource1.Insert();
                Response.Redirect("~/StudentDiscussion");
            }
            catch (Exception ex)
            {
                Session["Exception"] = ex;
                Session["Page"] = "~/NewDiscussionPost";
                Response.Redirect("~/ErrorMessage");
            }

        }
    }
}