using Microsoft.AspNetCore.Mvc;
using GraphicsTabletStore.API.Models;
using Microsoft.EntityFrameworkCore;
namespace GrTabStore.Controllers;

[ApiController]
[Route("[controller]")]
public class ProvincesController : ControllerBase 
{
    private readonly AppDbContext _context;

    public ProvincesController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Province>>> GetProvinces()
    {
        return await _context.Provinces
                .ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Province>> GetProvince(int id)
    {
        var province = await _context.Provinces.FindAsync(id);
        if (province == null)
            return NotFound(); 
        return province;
    }

    [HttpPost]
    public async Task<IActionResult> PostProvince(Province province)
    {
        _context.Provinces.Add(province);
        await _context.SaveChangesAsync();
        return NoContent();
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> PutProvince(int id, Province province)
    {
        if (id != province.Id)
            return BadRequest();
        _context.Entry(province).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        return NoContent();
    }

    [HttpDelete("{id}")]

    public async Task<IActionResult> DeleteProvince(int id)
    {
        var province = await _context.Provinces.FindAsync(id);
        if (province == null)
            return NotFound();
        _context.Provinces.Remove(province);
        await _context.SaveChangesAsync();
        return NoContent();
    }
}
