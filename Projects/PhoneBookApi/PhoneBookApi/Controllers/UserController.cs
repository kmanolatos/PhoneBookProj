using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AutoMapper;
using Dapper;
using PhoneBookApi.Models;

namespace PhoneBookApi.Controllers
{
    [RoutePrefix("api/user")]
    public class UserController : ApiController
    {
        [Route("login")]
        [HttpPost]
        public HttpResponseMessage Login(LoginModel model)
        {
            string user;
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = "select username as username, id from Users where username = '" + model.username + "' and password = '" + model.password + "'";
                var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                if (result == null)
                    user = "";
                else
                {
                    user = result["username"].ToString() + ", " + result["id"].ToString();
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK, user);
        }

        [Route("get/id/{id}")]
        [HttpGet]
        public HttpResponseMessage GetById(int id)
        {
            ProfileModel model = new ProfileModel();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select u.password, td.Phone_Number, tm.Mail, td.Entry_ID, tm.ID, tm.Lastname, tm.Firstname, td.Phone_Number, tk.Kind_ID, c.City_ID, a.Area_ID, td.Owner_ID from Telephones_Master as tm 
                                inner join Telephones_Detail as td on td.Owner_ID = tm.ID
                                left join Telephone_Kind as tk on tk.Kind_ID = td.Kind_ID
								left join Area as a on a.Area_ID = tm.Area_ID
                                left join City as c on c.City_ID = a.Owner_City_ID
								inner join Users as u on u.Id = tm.UserID and u.Id = " + id;
                model = db.Query<ProfileModel>(sql).FirstOrDefault();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("register")]
        [HttpPost]
        public HttpResponseMessage Register(UserModel model)
        {
            this.Validate(model.loginModel);
            if (ModelState.IsValid)
            {
                this.Validate(model.telephoneMasterModel);
                if (ModelState.IsValid)
                {
                    this.Validate(model.telephoneDetailModel);
                    if (ModelState.IsValid)
                    {
                        using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                        {
                            string sql = "select count(*) as rows from Users where username = '" + model.loginModel.username + "'";
                            var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                            int row;
                            Int32.TryParse(result["rows"].ToString(), out row);
                            if (row == 1)
                                return Request.CreateResponse(HttpStatusCode.OK, 1);
                            sql = @"select count(*) as rows from Users as u
                            inner join Telephones_Master as t on t.UserID = u.Id where t.Mail = '" + model.telephoneMasterModel.Mail + "'";
                            result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                            Int32.TryParse(result["rows"].ToString(), out row);
                            if (row == 1)
                                return Request.CreateResponse(HttpStatusCode.OK, 2);
                            db.Insert(model.loginModel);
                            sql = "select MAX(Id) as maxId from Users";
                            result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                            long id;
                            Int64.TryParse(result["maxId"].ToString(), out id);
                            model.telephoneMasterModel.userID = id;
                            db.Insert(model.telephoneMasterModel);
                            sql = "select MAX(Id) as maxId from Telephones_Master";
                            result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                            Int64.TryParse(result["maxId"].ToString(), out id);
                            model.telephoneDetailModel.Owner_ID = id;
                            db.Insert(model.telephoneDetailModel);
                        }
                        return Request.CreateResponse(HttpStatusCode.OK);
                    }
                    else
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                }
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        [Route("update")]
        [HttpPost]
        public HttpResponseMessage Update(UserModel model)
        {
            this.Validate(model.loginModel);
            if (ModelState.IsValid)
            {
                this.Validate(model.telephoneMasterModel);
                if (ModelState.IsValid)
                {
                    this.Validate(model.telephoneDetailModel);
                    if (ModelState.IsValid)
                    {
                        using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                        {
                            string sql = @"select count(*) as rows from Users as u
                            inner join Telephones_Master as t on t.UserID = u.Id  and t.UserID != " + model.loginModel.Id + " where t.Mail = '" + model.telephoneMasterModel.Mail + "'";
                            var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                            int row;
                            Int32.TryParse(result["rows"].ToString(), out row);
                            if (row == 1)
                                return Request.CreateResponse(HttpStatusCode.OK, 1);
                            db.Update(model.loginModel);
                            db.Update(model.telephoneMasterModel);
                            db.Update(model.telephoneDetailModel);
                        }
                        return Request.CreateResponse(HttpStatusCode.OK);
                    }
                    else
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                }
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

        }
    }
}
