const express = require('express');
const multer = require('multer');
const AWS = require('aws-sdk');

const app = express();

const upload = multer({
  storage: multer.memoryStorage(),
});

const s3 = new AWS.S3({
  accessKeyId: 'YOUR_ACCESS_KEY',
  secretAccessKey: 'YOUR_SECRET_KEY',
});

app.post('/upload', upload.single('image'), (req, res) => {
  const params = {
    Bucket: 'YOUR_BUCKET_NAME', // Name of your S3 bucket
    Key: req.file.originalname, // original name of the uploaded file
    Body: req.file.buffer, // Buffer data
  };

	console.log(req.file)
//  s3.upload(params, (err, data) => {
//    if (err) {
//      return res.status(500).send(err);
//    }
  
    res.status(200).send('File uploaded successfully. File URL is ' + data.Location);
//  });
});

const port = 4200;
app.listen(port, () => console.log(`App listening on port ${port}!`));

