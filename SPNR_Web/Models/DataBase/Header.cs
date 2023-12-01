﻿using System.ComponentModel.DataAnnotations.Schema;

namespace SPNR_Web.Models.DataBase
{
    public class Header
    {
        public Guid Id { get; set; }
        public string Place {  get; set; }
        public string ImgPath { get; set; }
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        public Event Event { get; set; }
    }
}
