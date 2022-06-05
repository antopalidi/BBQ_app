import lightbox from 'lightbox2'

document.addEventListener('turbo:load', () => {
    lightbox.init()

    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true,
        'fadeDuration': 200,
        'imageFadeDuration': 200
    })
})
