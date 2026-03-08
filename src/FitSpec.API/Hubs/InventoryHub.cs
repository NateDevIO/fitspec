using Microsoft.AspNetCore.SignalR;

namespace FitSpec.API.Hubs;

public class InventoryHub : Hub
{
    public async Task SubscribeToProducts(int[] productIds)
    {
        foreach (var id in productIds)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, $"product_{id}");
        }
    }

    public async Task UnsubscribeFromProducts(int[] productIds)
    {
        foreach (var id in productIds)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"product_{id}");
        }
    }
}
