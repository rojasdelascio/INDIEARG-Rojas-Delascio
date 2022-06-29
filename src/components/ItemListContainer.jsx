import './ItemListContainer.css';
import ItemList from './ItemList';
import { arrayProductos } from '../data/productos';
import { useState, useEffect } from 'react';

function ItemListContainer(props) {


    const [items, setItems] = useState([]);

    const obtenerItems = () => {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                arrayProductos.length > 0 ?
                    resolve(arrayProductos)
                    :
                    reject("No hay datos")
            }, 500);
        }
        )
    }


    useEffect(() => {
        obtenerItems()
            .then(res => setItems(res))
            .catch(err => console.log(err))
    }, [])


    return (
        <div className="div-bienvenida">
            <h2 className="texto-bienvenida">{props.texto}</h2>
            {/* <ItemList array={items} /> */}
            <ItemList array={items} />
        </div>


    );
}

export default ItemListContainer;