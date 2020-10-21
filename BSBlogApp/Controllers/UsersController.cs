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
    public class UsersController : ApiController
    {
        private BSBlogAppDBEntities db = new BSBlogAppDBEntities();

        // GET: api/Users
        public IQueryable<AppUser> GetUsers()
        {
            return db.AppUsers;
        }

        // GET: api/Users/5
        [ResponseType(typeof(AppUser))]
        public async Task<IHttpActionResult> GetUser(int id)
        {
            AppUser user = await db.AppUsers.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        // PUT: api/Users/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutUser(int id, AppUser user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != user.UserId)
            {
                return BadRequest();
            }

            db.Entry(user).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
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

        // POST: api/Users
        [ResponseType(typeof(AppUser))]
        public async Task<IHttpActionResult> PostUser(AppUser user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.AppUsers.Add(user);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = user.UserId }, user);
        }

        // DELETE: api/Users/5
        [ResponseType(typeof(AppUser))]
        public async Task<IHttpActionResult> DeleteUser(int id)
        {
            AppUser user = await db.AppUsers.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            db.AppUsers.Remove(user);
            await db.SaveChangesAsync();

            return Ok(user);
        }

        // Login: api/Users/5
        [Route("api/Users/Login")]
        [HttpPost]
        [ResponseType(typeof(AppUser))]
        public async Task<string> Login(AppUser user)
        {
            AppUser check = await db.AppUsers.FirstOrDefaultAsync(m => m.UserName == user.UserName && m.Password == user.Password);
            if (check != null)
            {
                return "Ok";
            }
            return null;
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool UserExists(int id)
        {
            return db.AppUsers.Count(e => e.UserId == id) > 0;
        }
    }
}