<div class="sidebar">
    <nav class="sidebar-nav">
        <ul class="nav">
            <li @click="menu=0" class="active nav-item">
                <a class="nav-link active" href="#"><i class="fas fa-chart-pie"></i> Dashboard</a>
            </li>
            {{-- <li class="nav-title">
                Mantenimiento
            </li> --}}
            <li @click="menu=1" class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-ticket-alt"></i> Generar orden </a>
            </li>
            <li class="nav-item nav-dropdown">
                <a class="nav-link nav-dropdown-toggle" href="#"><i class="fas fa-address-card"></i>Registro</a>
                <ul class="nav-dropdown-items">
                    <li @click="menu=2" class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-user-friends"></i>Clientes</a>
                    </li>
                    {{-- <li @click="menu=3" class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-user-cog"></i>Tecnicos</a>
                    </li> --}}
                </ul>
            </li>
            <li class="nav-item nav-dropdown">
                <a class="nav-link nav-dropdown-toggle" href="#"><i class="fas fa-chart-area"></i> Reportes</a>
                <ul class="nav-dropdown-items">
                    <li @click="menu=4" class="nav-item">
                        <a class="nav-link" href="#"><i class="icon-chart"></i> Reporte Ordenes</a>
                    </li>
                    {{-- <li @click="menu=5" class="nav-item">
                        <a class="nav-link" href="#"><i class="icon-chart"></i> Reporte Ventas</a>
                    </li> --}}
                </ul>
            </li>
            
            
           
            
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-book"></i> Ayuda <span class="badge badge-danger">PDF</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-info"></i> Acerca de...<span class="badge badge-info">IT</span></a>
            </li>
        </ul>
    </nav>
    <button class="sidebar-minimizer brand-minimizer" type="button"></button>
</div>