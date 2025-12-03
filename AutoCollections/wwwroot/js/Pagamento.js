document.getElementById('payButton').addEventListener('click', function() {
    document.getElementById('successMessage').style.display = 'block';

    if (window.opener) {
        window.opener.adicionarCompraEmAndamento?.();
    }

    this.disabled = true;
    this.textContent = 'Pagamento concluído';
});