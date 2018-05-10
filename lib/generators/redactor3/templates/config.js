$(function () {
    // Pass authenticity_token
    var params = '[name="authenticity_token"]';
    // Set global settings
    $R.options = {
        //plugins: ['source', 'fullscreen', 'textdirection', 'clips'],
        imageUpload: '/redactor3_rails/images',
        imageUploadFields: params,
        fileUpload: '/redactor3_rails/files',
        fileUploadFields: params
    };
    // Initialize Redactor
    $R('.redactor');
});
