
using System.Text.Json;
using Microsoft.EntityFrameworkCore;

namespace GraphicsTabletStore.API.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Product> Products { get; set; }
        public DbSet<Brand> Brands { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Commune> Communes { get; set; }
        public DbSet<Province> Provinces { get; set; }
        public DbSet<Admin> Admins { get; set; }
public DbSet<Ad> Ads { get; set; } 

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Order>()
                .Property(e => e.OrderId)
                .ValueGeneratedOnAdd(); // Auto-generate on add
            
             modelBuilder.Entity<Product>()
                .Property(e => e.PhotoUrl)
                .HasConversion(
                    v => JsonSerializer.Serialize(v, (JsonSerializerOptions)null),
                    v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions)null) ?? new List<string>()
                );
        }

    }
}