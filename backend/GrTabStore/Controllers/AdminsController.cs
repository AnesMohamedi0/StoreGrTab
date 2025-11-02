using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using GraphicsTabletStore.API.Models;

namespace GraphicsTabletStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AdminController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Admin>>> GetAdmins()
        {
            return await _context.Admins.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Admin>> GetAdmin(string id)
        {
            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
                return NotFound();

            return admin;
        }

        [HttpPost]
        public async Task<IActionResult> PostAdmin(Admin admin)
        {
            _context.Admins.Add(admin);
            admin.PasswordHash = new Services.AdminService().HashPassword(admin, admin.PasswordHash);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAdmin(string id, Admin admin)
        {
            if (id != admin.Id)
                return BadRequest();

            admin.PasswordHash = new Services.AdminService().HashPassword(admin, admin.PasswordHash);

            _context.Entry(admin).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAdmin(string id)
        {
            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
                return NotFound();

            _context.Admins.Remove(admin);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
