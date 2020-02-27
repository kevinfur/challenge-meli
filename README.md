# Challenge MeLi
Desarrollar una app que utilice las APIs de Mercado Libre con dos secciones:
- Search: buscador de productos y listado de respuestas.
- Product Page: detalle de un producto (al cual se debería poder acceder al tappear uno
de los items en el resultado del search).

# Dependencias
Se utilizó CocoaPods como manager de dependencias para importar los siguientes pods:
- Alamofire -> Para manejo del networking.
- Kingfisher -> Para cargar las imágenes.
- OHHTTPStubs -> Para mockear respuestas en los tests.

# Arquitectura
Se usó MVC como arquitectura ya que es un proyecto chico y hecho de forma rápida. En proyectos más grandes sería mejor evaluar el uso de otras arquitecturas para dividir código y mejorar su testeabilidad.

# Pantallas
<div>
<img style="float:left;" src="https://i.ibb.co/RN99mML/Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-31.png" alt="Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-31" border="0" width="150">
<img style="float:left;" src="https://i.ibb.co/2Nwhkm4/Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-40.png" alt="Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-40" border="0" width="150">
<img style="float:left;" src="https://i.ibb.co/sjbHBRH/Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-45.png" alt="Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-45" border="0" width="150">
<img style="float:left;" src="https://i.ibb.co/R4t0fcS/Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-49.png" alt="Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-49" border="0" width="150">
<img style="float:left;" src="https://i.ibb.co/zsDXCFw/Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-53.png" alt="Simulator-Screen-Shot-i-Phone-11-2020-02-26-at-22-10-53" border="0" width="150">
</div>

# Autodefiniciones
- Se decidió hacer un scroll 'infinito' en la pantalla de búsqueda con las primeras 5 páginas de 40 items cada una
