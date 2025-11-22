using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using GraphicsTabletStore.API.Models;

namespace GraphicsTabletStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrderController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Order>>> GetOrders()
        {
            return await _context.Orders
                .ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Order>> GetOrder(int id)
        {
            var order = await _context.Orders
                .FirstOrDefaultAsync(o => o.OrderId == id);

            if (order == null)
                return NotFound();

            return order;
        }
[HttpPost]
public async Task<IActionResult> PostOrder(Order order)
{
    try
    {
        Console.WriteLine($"Received order: Name={order.Name}, Products={order.Products}");
        
        // Don't set OrderId - let EF handle it
        order.OrderId = 0; // Ensure it's 0 so EF will auto-generate
        
        _context.Orders.Add(order);
        await _context.SaveChangesAsync();

        Console.WriteLine($"Order saved successfully with ID: {order.OrderId}");

        var response = new { 
            message = "Order created successfully", 
            orderId = order.OrderId 
        };

        Console.WriteLine($"Returning response: {System.Text.Json.JsonSerializer.Serialize(response)}");
        
        return Ok(response);
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error creating order: {ex.Message}");
        Console.WriteLine($"Inner exception: {ex.InnerException?.Message}");
        Console.WriteLine($"Stack trace: {ex.StackTrace}");
        
        return BadRequest(new { 
            error = ex.Message,
            details = ex.InnerException?.Message 
        });
    }
}

        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrder(int id, Order order)
        {
            if (id != order.OrderId)
                return BadRequest();

            _context.Entry(order).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrder(int id)
        {
            var order = await _context.Orders.FindAsync(id);
            if (order == null)
                return NotFound();

            _context.Orders.Remove(order);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
