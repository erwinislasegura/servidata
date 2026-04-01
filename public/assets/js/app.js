(() => {
  const canvas = document.getElementById('statusChart');
  if (!canvas) return;
  const data = JSON.parse(canvas.dataset.chart || '[]');
  new Chart(canvas, {
    type: 'doughnut',
    data: {
      labels: data.map(x => x.name),
      datasets: [{ data: data.map(x => Number(x.total)), backgroundColor: ['#0d6efd','#198754','#ffc107','#6f42c1','#dc3545','#20c997'] }]
    }
  });
})();
