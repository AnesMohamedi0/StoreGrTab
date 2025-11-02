using Microsoft.AspNetCore.Identity;
using GraphicsTabletStore.API.Models;

namespace GraphicsTabletStore.API.Services
{
    public class AdminService
    {
        private readonly PasswordHasher<Admin> _passwordHasher = new();

        public string HashPassword(Admin admin, string plainPassword)
        {
            return _passwordHasher.HashPassword(admin, plainPassword);
        }

        public bool VerifyPassword(Admin admin, string enteredPassword)
        {
            var result = _passwordHasher.VerifyHashedPassword(admin, admin.PasswordHash, enteredPassword);
            return result == PasswordVerificationResult.Success;
        }
    }
}
