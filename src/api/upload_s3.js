
const express = require('express')
const multer = require('multer')
const AWS = require('aws-sdk')

const app = express()

const upload = multer({
  storage: multer.memoryStorage(),
})

const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
})

AWS.config.update({region: process.env.REGION})
const sns = new AWS.SNS({apiVersion: '2010-03-31'})
const topicArn = process.env.TOPIC_ARN

app.post('/upload', upload.single('image'), (req, res) => {
  const params = {
    Bucket: process.env.BUCKET,
    Key: req.file.originalname,
    Body: req.file.buffer,
  }

  s3.upload(params, (err, data) => {
    if (err) {
      return res.status(500).send(err)
    }

    const message = JSON.stringify({ s3_data: data, params: params })

    sns.publish({
      Message: message,
      TopicArn: topicArn,
    }, (err, data) => {
      if (err) {
        console.error('Error publishing to SNS', err, err.stack)
      } else {
        console.log('Message published to SNS', data)
      }
    })
    
    res.status(200).send('File uploaded successfully. File URL is ' + data.Location)
  })
})

const port = 4200
app.listen(port, () => console.log(`App listening on port ${port}!`))
