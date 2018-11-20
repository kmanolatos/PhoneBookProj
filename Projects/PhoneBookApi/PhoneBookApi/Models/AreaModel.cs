using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Dapper;

namespace PhoneBookApi.Models
{
    [Table("Area")]
    public class AreaModel
    {       
        [Dapper.Key]
        public long Area_ID { get; set; }

        [MinLength(3)]
        [MaxLength(50)]
        [Dapper.Required]
        public string Area_Descr { get; set; }

        [Dapper.Required]
        public long Owner_City_ID { get; set; }
    }
}