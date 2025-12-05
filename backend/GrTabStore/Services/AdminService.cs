using Microsoft.AspNetCore.Identity;
using GraphicsTabletStore.API.Models;

namespace GraphicsTabletStore.API.Services
{
    public class AdminService
    {
        public static string HashPassword(Admin admin, string plainPassword)
        {
            PasswordHasher<Admin> _passwordHasher = new();
            return _passwordHasher.HashPassword(admin, plainPassword);
        }

        public static bool VerifyPassword(Admin admin, string enteredPassword)
        {
            PasswordHasher<Admin> _passwordHasher = new();
            var result = _passwordHasher.VerifyHashedPassword(admin, admin.PasswordHash, enteredPassword);
            return result == PasswordVerificationResult.Success;
        }

    }
}
