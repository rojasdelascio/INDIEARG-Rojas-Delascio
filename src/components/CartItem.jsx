import React from 'react';
import { useCart } from './Context/CartContext';
import { useState } from 'react';
import './CartItem.css'


function CartItem(props) {

    const imgto = `/${props.URL}`

    const carrito = useCart();
    console.log('carricarritoo', carrito);

    const quantityCondition = (i) => {
        return i.id === props.id
    }


    const cantidadInicial = carrito.cart.find(quantityCondition)


    return (
        <>
            <div className="card bg-light mb-3" id="div-total" >
                <div className="card-header">Nombre: {props.name}</div>
                <img className="card-img-top" src={imgto} alt="Card image cap" />
                <div className="card-body">
                    <div className="div-botones">
                        <button type="button" onClick={() => { carrito.disminuirItem(props.id) }} className="btn btn-secondary" id="masymenos">-</button>
                        <input value={props.quantity} className="input" />{/* <h5 className="card-title">Cantidad: {props.quantity} unidades</h5> */}
                        <button onClick={() => { carrito.aumentarItem(props.id) }} type="button" className="btn btn-secondary" id="masymenos">+</button>
                    </div>
                    <div className="div-inputtotal">
                        <h5>Total</h5> <input id="inputotal" className="input" value={props.price * props.quantity} /></div>
                    <button onClick={() => { carrito.removeItem(props.id) }} type="button" className="btn btn-danger" id="eliminaritem">Eliminar Item</button>
                </div>
            </div>
        </>
    )
}

export default CartItem;