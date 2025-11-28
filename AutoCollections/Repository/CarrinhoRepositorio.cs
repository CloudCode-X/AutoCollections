using AutoCollections.Models;
using Newtonsoft.Json;

namespace AutoCollections.Repository
{
    public class CarrinhoRepositorio
    {
        private const string CartSessionKey = "Carrinho";

        public List<ItemCarrinho> CarrinhoItems(ISession session)
        {
            var cartJson = session.GetString(CartSessionKey);
            return cartJson == null ? new List<ItemCarrinho>() : JsonConvert.DeserializeObject<List<ItemCarrinho>>(cartJson);
        }

        public void AdicionarCarrinho(ISession session, Produto produto, int quantidade)
        {
            var cart = CarrinhoItems(session);
            var existingItem = cart.FirstOrDefault(item => item.IdProduto == produto.IdProduto);

            if (existingItem != null)
            {
                existingItem.QuantidadeProduto += quantidade;
            }
            else
            {
                cart.Add(new ItemCarrinho
                {
                    IdProduto = produto.IdProduto,
                    //Produto = produto,
                    QuantidadeProduto = quantidade,
                    PrecoUnitario = produto.PrecoUnitario
                });
            }
            SalvarCarrinho(session, cart);
        }

        public void AlterarQuantidadeItem(ISession session, int produtoId, int novaQuantidade)
        {
            var cart = CarrinhoItems(session);
            var itemAlterar = cart.FirstOrDefault(item => item.IdProduto == produtoId);

            if (itemAlterar != null)
            {
                if (novaQuantidade <= 0)
                {
                    cart.Remove(itemAlterar);
                }
                else
                {
                    itemAlterar.QuantidadeProduto = novaQuantidade;
                }
                SalvarCarrinho(session, cart);
            }
        }

        public void RemoverItemCarrinho(ISession session, int produtoId)
        {
            var cart = CarrinhoItems(session);
            var itemRemover = cart.FirstOrDefault(item => item.IdProduto == produtoId);
            if (itemRemover != null)
            {
                cart.Remove(itemRemover);
                SalvarCarrinho(session, cart);
            }
        }

        public void LimparCarrinho(ISession session)
        {
            session.Remove(CartSessionKey);
        }

        public decimal TotalCarrinho(ISession session)
        {
            return CarrinhoItems(session).Sum(item => item.SubTotal);
        }

        private void SalvarCarrinho(ISession session, List<ItemCarrinho> cart)
        {
            session.SetString(CartSessionKey, JsonConvert.SerializeObject(cart));
        }
    }
}