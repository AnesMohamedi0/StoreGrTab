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

        // Authentication endpoints
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var admin = await _context.Admins.FirstOrDefaultAsync(a => a.Email == request.Email);
            
            if (admin == null || !BCrypt.Net.BCrypt.Verify(request.Password, admin.PasswordHash))
                return Unauthorized(new { message = "Invalid credentials" });

            // Set session
            HttpContext.Session.SetString("AdminId", admin.Id);
            HttpContext.Session.SetString("AdminEmail", admin.Email);

            return Ok(new { message = "Login successful", admin = new { admin.Email } });
        }

        [HttpPost("logout")]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return Ok(new { message = "Logged out successfully" });
        }

        [HttpGet("check-auth")]
        public IActionResult CheckAuth()
        {
            var adminId = HttpContext.Session.GetString("AdminId");
            return Ok(new { isAuthenticated = !string.IsNullOrEmpty(adminId) });
        }

        [HttpPost("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            // Check if admin is authenticated
            var adminId = HttpContext.Session.GetString("AdminId");
            if (string.IsNullOrEmpty(adminId))
                return Unauthorized(new { message = "Not authenticated" });

            var admin = await _context.Admins.FindAsync(adminId);
            if (admin == null || !BCrypt.Net.BCrypt.Verify(request.CurrentPassword, admin.PasswordHash))
                return BadRequest(new { message = "Current password is incorrect" });

            admin.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Password changed successfully" });
        }

        // Protected admin management endpoints
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Admin>>> GetAdmins()
        {
            // Check authentication
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("AdminId")))
                return Unauthorized(new { message = "Not authenticated" });

            return await _context.Admins.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Admin>> GetAdmin(string id)
        {
            // Check authentication
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("AdminId")))
                return Unauthorized(new { message = "Not authenticated" });

            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
                return NotFound();

            return admin;
        }

        [HttpGet("profile")]
        public async Task<IActionResult> GetProfile()
        {
            var adminId = HttpContext.Session.GetString("AdminId");
            if (string.IsNullOrEmpty(adminId))
                return Unauthorized(new { message = "Not authenticated" });

            var admin = await _context.Admins.FindAsync(adminId);
            if (admin == null)
                return NotFound();

            return Ok(new { admin.Id, admin.Email });
        }

        [HttpPost]
        public async Task<IActionResult> PostAdmin(Admin admin)
        {
            // Check authentication
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("AdminId")))
                return Unauthorized(new { message = "Not authenticated" });

            admin.PasswordHash = BCrypt.Net.BCrypt.HashPassword(admin.PasswordHash);
            _context.Admins.Add(admin);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetAdmin), new { id = admin.Id }, admin);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutAdmin(string id, Admin admin)
        {
            // Check authentication
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("AdminId")))
                return Unauthorized(new { message = "Not authenticated" });

            if (id != admin.Id)
                return BadRequest();

            var existingAdmin = await _context.Admins.FindAsync(id);
            if (existingAdmin == null)
                return NotFound();

            // Only update email, keep existing password if not provided
            existingAdmin.Email = admin.Email;
            
            // Only hash new password if provided
            if (!string.IsNullOrEmpty(admin.PasswordHash))
            {
                existingAdmin.PasswordHash = BCrypt.Net.BCrypt.HashPassword(admin.PasswordHash);
            }

            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAdmin(string id)
        {
            // Check authentication
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("AdminId")))
                return Unauthorized(new { message = "Not authenticated" });

            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
                return NotFound();

            _context.Admins.Remove(admin);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AdminExists(string id)
        {
            return _context.Admins.Any(e => e.Id == id);
        }
    }

    // Request models
    public class LoginRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class ChangePasswordRequest
    {
        public string CurrentPassword { get; set; } = string.Empty;
        public string NewPassword { get; set; } = string.Empty;
    }
}