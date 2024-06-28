const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors()); // Enable CORS for all routes
app.use(bodyParser.json());

const consumerKey = 'bx2fG9ztnCrtSI0FvGuf6D6mKptEwpnPZxwI6S4W9xnh7RBQ';
const consumerSecret = 'HMQj608uNKbSb3VBoLNhk8Y95pMBlRnaDbDUfEXDaFq4GqPNxM9wRBoLwqqh7HEh';
const shortCode = '174379'; // demo code
const lipaNaMpesaOnlineUrl = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
const tokenUrl = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
const passKey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';

// Function to get access token
async function getAccessToken() {
  const credentials = Buffer.from(`${consumerKey}:${consumerSecret}`).toString('base64');
  try {
    const response = await axios.get(tokenUrl, {
      headers: {
        'Authorization': `Basic ${credentials}`,
      },
    });
    return response.data.access_token;
  } catch (error) {
    throw new Error('Failed to get access token');
  }
}

// Route to initiate STK push
app.post('/initiate-payment', async (req, res) => {
  const { phoneNumber, amount } = req.body; // Extract phoneNumber and amount from request body

  try {
    const accessToken = await getAccessToken();
    const timestamp = new Date().toISOString().replace(/[-:.TZ]/g, '').slice(0, 14); // format timestamp
    const password = Buffer.from(`${shortCode}${passKey}${timestamp}`).toString('base64');

    const response = await axios.post(lipaNaMpesaOnlineUrl, {
      BusinessShortCode: shortCode,
      Password: password,
      Timestamp: timestamp,
      TransactionType: 'CustomerPayBillOnline',
      Amount: amount,
      PartyA: phoneNumber,
      PartyB: shortCode,
      PhoneNumber: phoneNumber,
      CallBackURL: 'https://ca07-102-167-171-239.ngrok-free.app', // 
      AccountReference: 'Hotel',
      TransactionDesc: 'Hotel Room Payment',
    }, {
      headers: {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
    });

    res.status(200).send('STK Push initiated successfully');
  } catch (error) {
    res.status(500).send(`Failed to initiate STK Push: ${error.message}`);
  }
});

// Callback endpoint to receive response from Mpesa
app.post('/callback', (req, res) => {
  console.log('Callback received:', req.body); // Log the entire request body

  const { Body } = req.body;
  const { stkCallback } = Body;

  if (stkCallback.ResultCode === 0) {
    console.log('Payment successful');
    // Handle successful payment
  } else {
    console.log('Payment failed:', stkCallback.ResultDesc);
    // Handle failed payment
  }

  res.status(200).send('Callback received');
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
