const express = require('express');

const app = express();

app.use(express.json());

app.use(express.urlencoded({ 
  extended: true 
}));

const productData = [];

app.listen(3000, () => {
    console.log('Connected to server at 2000');
})

//post api
app.post('/api/product', (req, res) => {

  console.log("Result", req.body);

  const pdata ={
    "id": productData.length + 1,
    "pname": req.body.name,
    "pprice": req.body.price,
    "pdesc": req.body.description
  };

    productData.push(pdata);
    console.log("Final Data", pdata);

    res.status(200).send({
      "status_code": 200,
      "message": "Product added successfully",
      "product": pdata
    });
});