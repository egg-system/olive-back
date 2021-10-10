$(() => {
    $('input[name="radio_integration_customer_id"]').on('change', () => {
        $('#integration_button').prop('disabled', false)
        $('#integration_button').addClass('btn-danger')
    })

    $('#integration_button').on('click', () => {
        if(confirm('顧客を統合します。よろしいですか？')) {
            // form送信
            $('#integration_customer_id').val($('input[name="radio_integration_customer_id"]:checked').val())
            $('#integration_form').trigger('submit')
        }
    })
})