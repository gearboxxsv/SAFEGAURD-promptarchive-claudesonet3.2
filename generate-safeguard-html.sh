// generate-html.js
const fs = require('fs');
const path = require('path');

// Function to extract summary from markdown content
function extractSummary(content, maxLength = 150) {
    // Remove code blocks and headers
    const cleanContent = content
        .replace(/```[\s\S]*?```/g, '')
        .replace(/#+\s.*/g, '')
        .trim();
    
    // Get first paragraph or truncate
    const summary = cleanContent.split('\n\n')[0] || cleanContent;
    
    if (summary.length <= maxLength) {
        return summary;
    }
    
    return summary.substring(0, maxLength) + '...';
}

// Function to create pair HTML file
function createPairHtml(queryFile, responseFile, pairId) {
    const queryContent = fs.readFileSync(queryFile, 'utf8');
    const responseContent = fs.readFileSync(responseFile, 'utf8');
    
    const title = `Pair ${pairId} - Safeguard LLM Responses`;
    const queryTitle = path.basename(queryFile, '.md').replace('_Query', '');
    const responseTitle = path.basename(responseFile, '.md').replace('_LLM', '').replace('_llm', '');
    
    const html = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/default.min.css">
    <style>
        pre {
            background-color: #f8f9fa;
            border-radius: 4px;
            padding: 15px;
        }
        .query-section {
            border-left: 4px solid #007bff;
            padding-left: 15px;
        }
        .response-section {
            border-left: 4px solid #28a745;
            padding-left: 15px;
        }
        .code-block {
            margin: 20px 0;
            position: relative;
        }
        .language-label {
            position: absolute;
            top: 0;
            right: 0;
            padding: 2px 8px;
            background: #6c757d;
            color: white;
            font-size: 12px;
            border-radius: 0 4px 0 4px;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <header class="mb-5">
            <h1>Pair ${pairId}</h1>
            <p class="text-muted">${queryTitle} and ${responseTitle}</p>
            <a href="index.html" class="btn btn-outline-secondary mb-3">← Back to Index</a>
        </header>

        <div class="row">
            <div class="col-lg-12">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3>Query ${queryTitle}</h3>
                    </div>
                    <div class="card-body query-section">
                        ${queryContent.replace(/```([\s\S]*?)```/g, (match, code) => {
                            const language = code.split('\n')[0].trim();
                            const actualCode = code.split('\n').slice(1).join('\n');
                            return `<div class="code-block">
                                <span class="language-label">${language || 'code'}</span>
                                <pre><code class="language-${language || 'plaintext'}">${actualCode}</code></pre>
                            </div>`;
                        })}
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        <h3>Response ${responseTitle}</h3>
                    </div>
                    <div class="card-body response-section">
                        ${responseContent.replace(/```([\s\S]*?)```/g, (match, code) => {
                            const language = code.split('\n')[0].trim();
                            const actualCode = code.split('\n').slice(1).join('\n');
                            return `<div class="code-block">
                                <span class="language-label">${language || 'code'}</span>
                                <pre><code class="language-${language || 'plaintext'}">${actualCode}</code></pre>
                            </div>`;
                        })}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-light p-4 mt-5">
        <div class="container text-center">
            <p>© 2025 Safeguard System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
</body>
</html>`;

    fs.writeFileSync(`pair${pairId}.html`, html);
    console.log(`Created pair${pairId}.html`);
    
    return {
        pairId,
        queryTitle,
        responseTitle,
        querySummary: extractSummary(queryContent),
        responseSummary: extractSummary(responseContent)
    };
}

// Main function to generate all files
function generateAllFiles() {
    // Get all query and response files
    const files = fs.readdirSync('.');
    const queryFiles = files.filter(file => file.includes('_Query') && file.endsWith('.md'));
    const responseFiles = files.filter(file => (file.includes('_LLM') || file.includes('_llm')) && file.endsWith('.md'));
    
    // Match pairs
    const pairs = [];
    queryFiles.forEach(queryFile => {
        const queryNum = queryFile.match(/(\d+)/)[0];
        const responseFile = responseFiles.find(file => {
            const match = file.match(/(\d+)/);
            return match && match[0] === queryNum;
        });
        
        if (responseFile) {
            pairs.push({
                queryFile,
                responseFile,
                pairId: queryNum
            });
        }
    });
    
    // Generate HTML for each pair
    const pairInfos = [];
    pairs.forEach(pair => {
        const pairInfo = createPairHtml(pair.queryFile, pair.responseFile, pair.pairId);
        pairInfos.push(pairInfo);
    });
    
    // Generate index.html
    generateIndexHtml(pairInfos);
}

// Function to generate index.html
function generateIndexHtml(pairInfos) {
    // Sort pairs by ID
    pairInfos.sort((a, b) => parseInt(a.pairId) - parseInt(b.pairId));
    
    const pairsHtml = pairInfos.map(pair => `
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5>Pair ${pair.pairId}: ${pair.queryTitle}</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card query-card">
                            <div class="card-body">
                                <h5 class="card-title">Query ${pair.queryTitle}</h5>
                                <p class="card-text">${pair.querySummary}</p>
                                <a href="pair${pair.pairId}.html" class="btn btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card response-card">
                            <div class="card-body">
                                <h5 class="card-title">Response ${pair.responseTitle}</h5>
                                <p class="card-text">${pair.responseSummary}</p>
                                <a href="pair${pair.pairId}.html" class="btn btn-outline-success">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `).join('');
    
    const html = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Safeguard LLM Responses</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        .card {
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .query-card {
            border-left: 4px solid #007bff;
        }
        .response-card {
            border-left: 4px solid #28a745;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <header class="mb-5">
            <h1 class="text-center">Safeguard LLM Responses</h1>
            <p class="text-center text-muted">Collection of queries and corresponding LLM responses</p>
        </header>

        <div class="row">
            <div class="col-md-12">
                <div class="list-group">
                    ${pairsHtml}
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-light p-4 mt-5">
        <div class="container text-center">
            <p>© 2025 Safeguard System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>`;

    fs.writeFileSync('index.html', html);
    console.log('Created index.html');
}

// Run the generator
generateAllFiles();
