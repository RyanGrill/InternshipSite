<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="InternshipSite.Forms.FAQ" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <h3>
        Here are some resources that we think can help you.
    </h3>

    <h4>
        Sample Resume/Resume Help:
    </h4>
    <asp:HyperLink NavigateUrl="https://novoresume.com/career-blog/computer-science-resume" runat="server" Text="Click here"></asp:HyperLink>
    <br />
    <asp:Label Text="This website has a pretty in depth guide to writing a resume for someone in computer science. It even gives an example of what one might look like. 
        Remember not to copy this resume exactly, as your resume should be uniquely identifying to you." runat="server"/>

    <br />
    <h4>
        Sample Cover Letter/Cover Leter Help:
    </h4>
    <asp:HyperLink NavigateUrl="https://www.thebalancecareers.com/internship-cover-letter-sample-and-writing-tips-2060231" runat="server" Text="Click Here" />
    <br />
    <asp:Label Text="This website gives an example of what a cover letter may look like, and how you can improve your own. Again, make sure to make the cover letter unique to your experience
        and skills." runat="server" />
    <br />

    <h4>
        Preparing yourself for an interview:
    </h4>
    <asp:Label Text="Once you have applied to a job, you need to be prepared for the questions you may be asked. A common practice in interviews is to have the interviewee complete some form of
        practical demonsration of skill and practices. Some companies will give the candidate a problem to complete before the interview, and then they will review the process during the interview.
        Others will have the candidate complete the examination during the interview. In order to practice for these technical interviews, websites have been created that compile interview questions.
        An example of one of those sites is here:" runat="server"/>
    <asp:HyperLink NavigateUrl="https://leetcode.com/explore/" Text="Click Here" runat="server"/>

</asp:Content>
