//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BSBlogApp.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CommentStat
    {
        public int StatId { get; set; }
        public int CommentID { get; set; }
        public Nullable<bool> LikeCount { get; set; }
        public Nullable<bool> DislikeCount { get; set; }
    
        public virtual Comment Comment { get; set; }
    }
}
