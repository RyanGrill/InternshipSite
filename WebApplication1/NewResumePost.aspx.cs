using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Content
{
    public partial class NewResumePost : System.Web.UI.Page
    {
        public string url = ConfigurationManager.ConnectionStrings["InternshipSiteDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitResumeButton_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string[] allowedFile = { ".doc", ".docx"};
                string path = string.Concat(Server.MapPath("~/UploadedItems/" + FileUpload1.PostedFile.FileName));
                FileUpload1.SaveAs(path);

                if (!allowedFile.Contains(Path.GetExtension(FileUpload1.PostedFile.FileName)))
                {
                    fileWarningLabel.Visible = true;
                }
                else
                {
                    
                    byte[] fileBytes = File.ReadAllBytes(path);
                    using (var conn = new OleDbConnection(url))
                    {
                        using (var cmd = new OleDbCommand("INSERT INTO ResumePosts ([Resume], [Title], [Body]) VALUES (@1, @2, @3)", conn))
                        {
                            conn.Open();
                            cmd.Parameters.AddWithValue("@1", fileBytes);
                            cmd.Parameters.AddWithValue("@2", txtTitle.Text);
                            cmd.Parameters.AddWithValue("@3", txtDesc.Text);
                            try
                            {
                                cmd.ExecuteNonQuery();
                                File.Delete(path);
                                Response.Redirect("~/ResumeReview");
                            }
                            catch(Exception ex)
                            {
                                Session["Exception"] = ex;
                                Session["Page"] = "~/NewResumePost";
                                Response.Redirect("~/ErrorMessage");
                            }
                        }
                    }
                    
                }
            }
        }
    }
}