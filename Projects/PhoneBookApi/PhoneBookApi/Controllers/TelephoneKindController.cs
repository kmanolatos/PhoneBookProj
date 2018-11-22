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
    [RoutePrefix("api/telephoneKind")]
    public class TelephoneKindController : ApiController
    {
        [Route("getList")]
        [HttpGet]
        public HttpResponseMessage GetList()
        {

            List<TelephoneKindModel> model = new List<TelephoneKindModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                model = db.GetList<TelephoneKindModel>().ToList();
                model = model.OrderBy(p => p.Kind_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("get/id/{id}")]
        [HttpGet]
        public HttpResponseMessage GetById(int id)
        {

            TelephoneKindModel model = new TelephoneKindModel();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                model = db.Get<TelephoneKindModel>(id);
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);

        }

        [Route("getListByWhere/{text}")]
        [HttpGet]
        public HttpResponseMessage GetListByWhere(string text)
        {

            string where = "";
            if (!text.Equals("null"))
            {
                where += "where Kind_Descr like N'" + text + "%'";
            }
            List<SearchedModel> model = new List<SearchedModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select Kind_ID as Id, Kind_Descr from Telephone_Kind " + where;
                model = db.Query<SearchedModel>(sql).ToList();
                model = model.OrderBy(p => p.Kind_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);

        }

        [Route("delete")]
        [HttpPost]
        public HttpResponseMessage Delete(TelephoneKindModel model)
        {

            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"update Telephones_Detail set Kind_ID = null where Kind_ID = " + model.Kind_ID +
                            "delete from Telephone_Kind where Kind_ID = " + model.Kind_ID;
                db.Query(sql);
            }
            return Request.CreateResponse(HttpStatusCode.OK);

        }

        [Route("update")]
        [HttpPost]
        public HttpResponseMessage Update(TelephoneKindModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {
                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    string sql = @"select count(*) as rows from Telephone_Kind as u where Kind_Descr = N'" + model.Kind_Descr + "'";
                    var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                    int row;
                    Int32.TryParse(result["rows"].ToString(), out row);
                    if (row == 1)
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Telephone Kind already exists!");
                    db.Update(model);
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

        }

        [Route("insert")]
        [HttpPost]
        public HttpResponseMessage Insert(TelephoneKindModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {
                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    string sql = @"select count(*) as rows from Telephone_Kind as u where Kind_Descr = N'" + model.Kind_Descr + "'";
                    var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                    int row;
                    Int32.TryParse(result["rows"].ToString(), out row);
                    if (row == 1)
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Telephone Kind already exists!");
                    db.Insert(model);
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }
    }
}
