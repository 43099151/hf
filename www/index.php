<?php
// 简单备份触发（保持原功能）
if ($_GET['backup'] == 'your-secret-key-here') {
    exec('/scripts/backup.sh 2>&1', $output);
    echo "<pre style='background:#f4f4f4;padding:20px;font-family:monospace;'>Backup triggered:\n" . implode("\n", $output) . "</pre>";
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenLeaf Labs - Sustainable AI Research</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            line-height: 1.6; color: #333; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        header { text-align: center; margin-bottom: 60px; }
        .logo { font-size: 2.8em; font-weight: 700; color: #2d5a2d; margin-bottom: 10px; }
        .tagline { font-size: 1.3em; color: #666; font-style: italic; }
        .hero { 
            background: white; border-radius: 20px; padding: 50px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); 
            margin-bottom: 50px; text-align: center;
        }
        .hero img { 
            width: 100%; max-width: 600px; height: 300px; object-fit: cover; 
            border-radius: 15px; margin-bottom: 30px; box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 30px; margin: 60px 0; }
        .card { 
            background: white; border-radius: 15px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); 
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover { transform: translateY(-5px); box-shadow: 0 20px 40px rgba(0,0,0,0.15); }
        .card h3 { color: #2d5a2d; font-size: 1.4em; margin-bottom: 15px; }
        .card p { color: #555; margin-bottom: 20px; }
        .stats { display: flex; justify-content: space-around; background: #e8f5e8; padding: 40px; border-radius: 15px; margin: 40px 0; }
        .stat { text-align: center; }
        .stat-number { font-size: 2.5em; font-weight: 700; color: #27ae60; }
        .stat-label { color: #666; font-size: 1.1em; }
        footer { text-align: center; padding: 40px 0; color: #888; border-top: 1px solid #eee; }
        @media (max-width: 768px) { .grid { grid-template-columns: 1fr; } .stats { flex-direction: column; gap: 20px; } }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">🌿 GreenLeaf Labs</h1>
            <p class="tagline">Sustainable AI for a Greener Tomorrow</p>
        </header>

        <section class="hero">
            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZGVmcz48cmVjdCBpZD0iYmciIGZpbGw9IiNmMGY4NDYiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiLz48L2RlZnM+PGcgZmlsdGVyPSJ1cmwoI2JsdXIpIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjBmODQ2Ii8+PC9nPjxyZWN0IGlkPSJkZWNvIiB4PSIyNSUiIHk9IjE1JSIgd2lkdGg9IjUwJSIgaGVpZ2h0PSI3MCUiIGZpbGw9IiNmZmYiIHJ4PSIyMCIvPjxyZWN0IHg9IjQwJSIgeT0iMjAlIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjQwJSIgZmlsbD0iIzI1YWQ1ZiIgc3Ryb2tlPSIjMGI4MjUwIiBzdHJva2Utd2lkdGg9IjMiIG9wYWNpdHk9IjAuOSIgcng9IjMiLz48Y2lyY2xlIGN4PSI1NSUiIGN5PSIzNSUiIHI9IjYiIGZpbGw9IiMyNWFkNWYiLz48Y2lyY2xlIGN4PSI0NSUiIGN5PSIzNSUiIHI9IjQiIGZpbGw9IiMyNWFkNWYiLz48L3N2Zz4=" alt="Green AI Research">
            <h2>AI-Powered Environmental Intelligence</h2>
            <p>Harnessing the latest machine learning techniques to monitor deforestation, optimize renewable energy distribution, and predict climate patterns with unprecedented accuracy.</p>
        </section>

        <section class="grid">
            <div class="card">
                <h3>🌍 ForestWatch AI</h3>
                <p>Real-time satellite imagery analysis detecting illegal logging and forest fires within 2 hours of occurrence. 98.7% accuracy across 12M hectares monitored globally.</p>
            </div>
            <div class="card">
                <h3>☀️ SolarOptix</h3>
                <p>Optimizes solar panel placement and predicts energy output with weather pattern integration. Reduced installation costs by 23% for 450+ commercial projects.</p>
            </div>
            <div class="card">
                <h3>🌊 OceanClean Tracker</h3>
                <p>Computer vision system tracking plastic waste movement in ocean currents. Deployed on 27 research vessels, mapped 1.2M km² of Pacific gyres.</p>
            </div>
        </section>

        <section class="stats">
            <div class="stat">
                <div class="stat-number">12M+</div>
                <div class="stat-label">Hectares Monitored</div>
            </div>
            <div class="stat">
                <div class="stat-number">450+</div>
                <div class="stat-label">Projects Deployed</div>
            </div>
            <div class="stat">
                <div class="stat-number">98.7%</div>
                <div class="stat-label">Accuracy Rate</div>
            </div>
        </section>

        <footer>
            <p>&copy; 2026 GreenLeaf Labs. Hosted on <strong>Hugging Face Spaces</strong> | <a href="/backup?key=your-secret-key-here" style="color:#2d5a2d;">System Status</a></p>
            <p style="margin-top:10px; font-size:0.9em;">Sustainable computing powered by renewable energy infrastructure.</p>
        </footer>
    </div>
</body>
</html>
