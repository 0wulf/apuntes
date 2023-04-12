# _React_
Librería _open source_ para JavaScript que permite crear interfaces de usuario de forma sencilla y rápida.
## ¿Cómo se ve _React_?
1. Requiere importar algunos elementos.
2. Definimos componentes (como función o clase).
3. Renderizamos los componentes con el método _render_.
```js
import { createRoot } from 'react-dom/client';

function HelloMessage({ name }) {
  return <div>Hello {name}</div>;
}

const root = createRoot(document.getElementById('container'));
root.render(<HelloMessage name="Taylor" />);
```

## Un poco de _JSX_
Es una extensión a la sintaxis de JavaScript que permite escribir sintaxis similar a HTML dentro de JavaScript.
```js
// Puedo colocar cualquier {expresion} de JS
const element = <h1>Hello, {name}!</h1>;
const desc = <p>My favourite {isHuman ? 'human' : 'thing'}</p>
```

## ¿Qué es un componente?
_React_ permite describir elementos de UI reusables y combinables. Similar a HTML, estos se pueden componer, ordenar y anidar para diseñar una página. Se pueden definir como una función o una clase.
```js
class WelcomeAsClassComponent extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}

function WelcomeAsFunctionComponent(props) {
  return <h1>Hello, {props.name}</h1>;
}
```
### Clases vs Funciones
Components basados en clases:
- Pueden tener estados.
- Pueden ocupar métodos de ciclo de vida.
- Extiende a `React.Component`
- Usa sintaxis de clase ES6.
- Se ocupa `this` para acceder a `props` y métodos.

Components basados en funciones:
- Definición más simple
- No tienen estado (sin _hooks_)
- No pueden ocupar métodos de ciclo de vida.
- Se enfoca en el UI y no en el comportamiento.
- Básicamente es solo el método `render()`.

### Props o properties
Es la manera que tiene _React_ para que los componentes puedan comunicarse entre si, permitiendo el paso de información a sus descendientes. La sintaxis es similar a HTML, pero en lugar de solo aceptar strings, acepta cualquier tipo.

### Ciclo de vida de un componente
* Inicialización: Se configuran el estado y las propiedades del componente.
* Montaje: El componente React se crea e inserta en el DOM (se agrega como nodo en el DOM).
* Actualización: El estado del componente cambia y se produce el re-renderizado del componente. Aquí, los datos del componente (estado y props) se actualizan en respuesta a eventos desde el usuario.
* Desmontaje: Fase en la que el componente se elimina del DOM.

## _Hooks_
Los _hooks_ son funciones que permiten usar "estados" en componentes de React. Hacen posible hacer seguimiento del estado de un componente sin necesidad de definir clases. 
En resumen, los _hooks_ son APIs que permiten usar el estado y otras características en un componente funcional (y no de clases) de React.
