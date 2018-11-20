using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Dapper;

namespace PhoneBookApi.Models
{
    [Table("Telephone_Kind")]
    public class TelephoneKindModel
    {
        [Dapper.Key]
        public long Kind_ID { get; set; }

        [MinLength(3)]
        [MaxLength(50)]
        [Dapper.Required]
        public string Kind_Descr { get; set; }
    }
}