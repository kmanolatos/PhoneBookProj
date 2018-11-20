using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Dapper;

namespace PhoneBookApi.Models
{
    public class SearchedModel
    {             
        public long Id { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Mail { get; set; }
        public string Phone_Number { get; set; }
        public string Kind_Descr { get; set; }
        public string City_Descr { get; set; }
        public string Area_Descr { get; set; }
    }
}