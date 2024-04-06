let selectedFile;

// Handle the click to trigger the hidden file input
document.getElementById('upload-zone').addEventListener('click', () => {
    document.getElementById('image').click();
});

// Prevent default drag behaviors
['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
  document.getElementById('upload-zone').addEventListener(eventName, preventDefaults, false);
});

function preventDefaults (e) {
  e.preventDefault();
  e.stopPropagation();
}

// Handle dropped files
document.getElementById('upload-zone').addEventListener('drop', (event) => {
    selectedFile = event.dataTransfer.files[0];
    document.getElementById('upload-button').style.display = 'inline-block';  // Show the upload button
});

// Handle file selection through file input
document.getElementById('image').addEventListener('change', (event) => {
    selectedFile = event.target.files[0];
    document.getElementById('upload-button').style.display = 'inline-block';  // Show the upload button
});

// Handle form submission
document.getElementById('upload-button').addEventListener('click', async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('image', selectedFile);

    const response = await fetch('http://localhost:4200/upload', {
        method: 'POST',
        body: formData,
    });

    if (response.ok) {
        const data = await response.text();
        document.getElementById('status').textContent = data;
    } else {
        document.getElementById('status').textContent = 'File upload failed';
    }
});

