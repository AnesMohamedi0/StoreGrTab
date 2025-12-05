using Microsoft.AspNetCore.Identity;
using GraphicsTabletStore.API.Models;
using Microsoft.EntityFrameworkCore;

namespace GraphicsTabletStore.API.Services
{
    public class SimpleAdminAuthService
    {
        private readonly AppDbContext _context;

        public SimpleAdminAuthService(AppDbContext context)
        {
            _context = context;
        }


        public async Task<bool> ChangePasswordAsync(string newPassword)
        {
            var admin = await _context.Admins.FirstOrDefaultAsync();
            if (admin != null)
            {
                admin.PasswordHash = AdminService.HashPassword(admin, newPassword);
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }

    }
}
