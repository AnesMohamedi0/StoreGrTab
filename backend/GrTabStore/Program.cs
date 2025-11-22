using GraphicsTabletStore.API.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add controllers
builder.Services.AddControllers();

// ✅ Add DbContext and read connection string
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
// ...existing code...
// ...existing code...
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.AllowAnyOrigin()  // Allow any origin for development
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});
// ...existing code...

// Add Swagger (optional but useful for testing)
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Use Swagger in dev mode
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowFrontend");

app.UseAuthorization();
app.MapControllers();
app.Run();
