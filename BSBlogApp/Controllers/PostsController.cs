using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using BSBlogApp.Models;

namespace BSBlogApp.Controllers
{
    public class PostsController : ApiController
    {
        private BSBlogAppDBEntities db = new BSBlogAppDBEntities();

        // GET: api/Posts
        public HttpResponseMessage GetPosts()
        {
            return Request.CreateResponse(HttpStatusCode.OK, db.Posts.ToList());
        }

        
        [Route("api/Posts/PostGrid")]
        [HttpGet]
        public HttpResponseMessage PostGrid()
        {
            var posts = (from post in db.Posts
                         select new
                         {
                             post.PostTitle,
                             Author = post.AppUser.UserName,
                             post.DatePosted,
                             commentsCount = post.Comments.Count(),                         
                             comments = (
                             from comment in db.Comments
                             where comment.PostID == post.PostId
                             select new
                             {
                                 comment.CommentDescription,
                                 CommentedBy = comment.AppUser.UserName,
                                 comment.CommentDate,
                                 likeCount = comment.CommentStats.Where(m => m.CommentID == comment.CommentId && m.LikeCount == true).Count(),
                                 dislikeCount = comment.CommentStats.Where(m => m.CommentID == comment.CommentId && m.DislikeCount == true).Count()
                             }
                             ).ToList()
                         }).ToList();
            return Request.CreateResponse(HttpStatusCode.OK, posts);
        }

        [Route("api/Posts/SearchResult/{searchString}")]
        [HttpGet]
        public HttpResponseMessage SearchResult(string searchString)
        {
            var posts = (from post in db.Posts
                         where post.PostTitle.Contains(searchString)
                         select new
                         {
                             post.PostTitle,
                             Author = post.AppUser.UserName,
                             post.DatePosted,
                             commentsCount = post.Comments.Count(),
                             comments = (
                             from comment in db.Comments
                             where comment.PostID == post.PostId
                             select new
                             {
                                 comment.CommentDescription,
                                 CommentedBy = comment.AppUser.UserName,
                                 comment.CommentDate,
                                 likeCount = comment.CommentStats.Where(m => m.CommentID == comment.CommentId && m.LikeCount == true).Count(),
                                 dislikeCount = comment.CommentStats.Where(m => m.CommentID == comment.CommentId && m.DislikeCount == true).Count()
                             }
                             ).ToList()
                         }).ToList();
            return Request.CreateResponse(HttpStatusCode.OK, posts);
        }

        // GET: api/Posts/5
        [ResponseType(typeof(Post))]
        public async Task<HttpResponseMessage> GetPost(int id)
        {
            Post post = await db.Posts.FindAsync(id);
            if (post == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            return Request.CreateResponse(HttpStatusCode.OK, post);
        }

        // PUT: api/Posts/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutPost(int id, Post post)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != post.PostId)
            {
                return BadRequest();
            }

            db.Entry(post).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PostExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Posts
        [ResponseType(typeof(Post))]
        public async Task<IHttpActionResult> PostPost(Post post)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Posts.Add(post);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (PostExists(post.PostId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = post.PostId }, post);
        }

        // DELETE: api/Posts/5
        [ResponseType(typeof(Post))]
        public async Task<IHttpActionResult> DeletePost(int id)
        {
            Post post = await db.Posts.FindAsync(id);
            if (post == null)
            {
                return NotFound();
            }

            db.Posts.Remove(post);
            await db.SaveChangesAsync();

            return Ok(post);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool PostExists(int id)
        {
            return db.Posts.Count(e => e.PostId == id) > 0;
        }
    }
}