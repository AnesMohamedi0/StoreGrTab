using Microsoft.AspNetCore.Mvc;
using GraphicsTabletStore.API.Models;
using Microsoft.EntityFrameworkCore;
namespace GrTabStore.Controllers;


[ApiController]
[Route("[controller]")]
public class BrandsController : ControllerBase
{
    private readonly AppDbContext _context;

    public BrandsController(AppDbContext context)
    {
        _context = context;
    }


    [HttpGet]
    public async Task<ActionResult<IEnumerable<Brand>>> GetBrands()
    {
        return await _context.Brands
                .ToListAsync();
    }

    [HttpGet("{id}")]

    public async Task<ActionResult<Brand>> GetBrand(int id)
    {
        var brand = await _context.Brands.FindAsync(id);
        if (brand == null)
            return NotFound();
        return brand;
    }

    [HttpPost]
    public async Task<IActionResult> PostBrand(Brand brand)
    {
        _context.Brands.Add(brand);
        await _context.SaveChangesAsync();

        return NoContent();
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> PutBrand(int id, Brand brand)
    {
        if (id != brand.BrandId)
            return BadRequest();

        _context.Entry(brand).State = EntityState.Modified;
        await _context.SaveChangesAsync();

        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteBrand(int id)
    {
        var brand = await _context.Brands.FindAsync(id);
        if (brand == null)
            return NotFound();
        _context.Brands.Remove(brand);
        await _context.SaveChangesAsync();
        return NoContent();
    }

}
