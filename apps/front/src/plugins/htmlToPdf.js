import html2Canvas from 'html2canvas'
import JsPdf from 'jspdf'

export default {
  install (Vue, option) {
    Vue.prototype.getPdf = function (title, id, isShowPreviewFullTime) {
      html2Canvas(document.getElementById('pdfDom' + id), {
        allowTaint: true,
        removeContainer: true,
        backgroundColor: null,
        imageTimeout: 15000,
        logging: true,
        scale: 2,
        useCORS: true
      }).then(function (canvas) {
        let contentDataURL = canvas.toDataURL('image/png')
        let imgWidth = 210
        let pageHeight = 295
        let imgHeight = canvas.height * imgWidth / canvas.width
        let heightLeft = imgHeight
        let pdf = new JsPdf('p', 'mm', 'a4', true)
        let position = 0

        pdf.addImage(contentDataURL, 'PNG', 0, position, imgWidth, imgHeight, undefined, 'FAST')
        heightLeft -= pageHeight

        while (heightLeft >= 0) {
          position = heightLeft - imgHeight
          pdf.addPage()
          pdf.addImage(contentDataURL, 'PNG', 0, position, imgWidth, imgHeight, undefined, 'FAST')
          heightLeft -= pageHeight
        }
        pdf.save(title + '.pdf')
      })
    }
  }
}
