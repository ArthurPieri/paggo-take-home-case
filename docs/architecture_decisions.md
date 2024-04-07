# Architecture Decisions
Before we get into the solution itself, we have a few decisions to make:

1. Synchronous or Asynchronous?
2. Which OCR service to use?
3. How to store the files?
4. Should we keep the file after processing?
5. How to store the metadata?
6. When retrieving the metadata, we nedd to retrieve everyhing or one invoice at a time?
7. How to display the data?
8. Should we accept only PDF files?
9. Should we allow any kind of invoice? Or do we need to define an schema on write?

## Synchronous or Asynchronous?

If we choose to go with a synchronous approach, we will have to wait for the OCR service to finish processing the file before we can return a response to the user. This can be a problem if the OCR service takes too long to process the file.

If we choose to go with an asynchronous approach, we can return a response to the user immediately and process the file in the background. This way, the user doesn't have to wait for the OCR service to finish processing the file.

## Which OCR service to use?

There are many OCR services available, such as Google Cloud Vision, Amazon Textract, and Microsoft Azure Computer Vision. Each service has its own pros and cons, so we need to choose the one that best fits our needs.
Since the requirements defines that we are using Amazon AWS we should stick with Textract.

## How to store the files?

We can store the files in a database, in a file system, or in a cloud storage service like Amazon S3. Storing the files in a database can be expensive and inefficient, so we should probably go with Amazon S3.

## Should we keep the file after processing?

We can keep the file after processing it, or we can delete it. If we keep the file, we can display it to the user later but we would also have to consider data privacy and security. If we delete the file, we can save storage space and reduce the risk of data breaches. Regardless of the decision, we should anonymize the metadata extracted from the invoice.

## How to store the metadata?

We can store the metadata in a database, in a file, or in a cloud storage service like Amazon S3. Storing the metadata in a database can be expensive and inefficient, so we should probably go with Amazon S3.

In order to resolve the problem I decided to break it down:

- Create the infrastructure using terraform;
- Create the API using nodejs (if Golang was chosen, it could be faster);
- Save the files into S3;
- Use Textract to extract the data from the invoice;
- Save the metadata

I decided to go with an asynchronous approach, so the user doesn't have to wait for the OCR service to finish processing the file. This way, we can return a response to the user immediately and process the file in the background. And in order to do so we will use a message broker to handle the messages.

## When retrieving the metadata, we need to retrieve everything or one invoice at a time?

If we decide that we only need to retrieve one at a time, we could just keep the data in S3 and retrieve it when needed. But if we decide that we need to retrieve everything, we could use a database to store the metadata. We could use something like hive metastore to store the metadata and the path to the file and metadata in s3.

## How to display the data?

Should we display every information from the invoice? Or should we display only the most important information? 

In order to make it easier to develop and to reduce cognitive load to the user, we should display only the most important information.

## Should we accept only PDF files?

Since Textract accetps pdf, png and jpeg files, we should accept only these file types.

## Should we allow any kind of invoice? Or do we need to define a schema on write?

We can accept any kind of invoice on read, but we would display only informations that follows a schema. For example to display the name of the company we could use a regex to extract the name of the company from the invoice.

# Conclusion

In order to solve the problem we will use the following technologies:

- Terraform to create the infrastructure;
- Nodejs running on aws lambda to create the API;
- S3 to store the files;
- Textract to extract the data from the invoice;
- SNS to handle the messages;
- SQS to store the messages;
- Postgres or Hive Metastore to store the metadata;
- HTML/CSS/JS to display the data.
- Cloudfront to serve the static files.

