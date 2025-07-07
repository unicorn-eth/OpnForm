#!/bin/bash

# OpnForm Token Gating Setup Script
# Creates the necessary directory structure and files for the token gating feature

set -e  # Exit on any error

echo "🚀 Setting up OpnForm Token Gating directory structure..."

# Check if we're in an OpnForm project (look for composer.json with laravel)
if [ ! -f "composer.json" ] || ! grep -q "laravel/framework" composer.json; then
    echo "⚠️  Warning: This doesn't appear to be a Laravel/OpnForm project"
    echo "   Make sure you're in the OpnForm root directory"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Function to create directory if it doesn't exist
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "📁 Created directory: $1"
    else
        echo "📁 Directory exists: $1"
    fi
}

# Function to create empty file with header comment
create_file() {
    local file_path="$1"
    local file_type="$2"
    local description="$3"
    
    if [ ! -f "$file_path" ]; then
        case "$file_type" in
            "php")
                cat > "$file_path" << EOF
<?php

/**
 * $description
 * Part of OpnForm Token Gating Feature
 * 
 * @created $(date +"%Y-%m-%d")
 */

// TODO: Implement $description

EOF
                ;;
            "vue")
                cat > "$file_path" << EOF
<!--
  $description
  Part of OpnForm Token Gating Feature
  
  @created $(date +"%Y-%m-%d")
-->

<template>
  <div class="$(basename "$file_path" .vue | sed 's/[A-Z]/-\L&/g' | sed 's/^-//')">
    <!-- TODO: Implement $description -->
  </div>
</template>

<script>
export default {
  name: '$(basename "$file_path" .vue)',
  // TODO: Implement component logic
}
</script>

<style scoped>
/* TODO: Add component styles */
</style>
EOF
                ;;
            "js")
                cat > "$file_path" << EOF
/**
 * $description
 * Part of OpnForm Token Gating Feature
 * 
 * @created $(date +"%Y-%m-%d")
 */

// TODO: Implement $description

export default {};
EOF
                ;;
            "migration")
                local timestamp=$(date +"%Y_%m_%d_%H%M%S")
                local migration_name=$(basename "$file_path" .php)
                cat > "$file_path" << EOF
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * $description
 * Part of OpnForm Token Gating Feature
 */
return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // TODO: Implement migration up method
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // TODO: Implement migration down method
    }
};
EOF
                ;;
            "config")
                cat > "$file_path" << EOF
<?php

/**
 * $description
 * Part of OpnForm Token Gating Feature
 * 
 * @created $(date +"%Y-%m-%d")
 */

return [
    // TODO: Add configuration options
];
EOF
                ;;
            *)
                touch "$file_path"
                echo "// TODO: Implement $description" > "$file_path"
                ;;
        esac
        echo "📄 Created file: $file_path"
    else
        echo "📄 File exists: $file_path"
    fi
}

echo
echo "📂 Creating directory structure..."

# Backend directories
create_dir "app/Models/TokenGating"
create_dir "app/Http/Controllers/Api/TokenGating"
create_dir "app/Http/Requests/TokenGating"
create_dir "app/Services/TokenGating"
create_dir "database/migrations"
create_dir "config"
create_dir "tests/Feature/TokenGating"
create_dir "tests/Unit/TokenGating"

# Frontend directories
create_dir "resources/js/components/TokenGating"
create_dir "resources/js/services"
create_dir "resources/js/composables"
create_dir "resources/js/types"

echo
echo "📄 Creating backend files..."

# Database migrations
create_file "database/migrations/$(date +"%Y_%m_%d_%H%M%S")_add_token_gating_to_forms_table.php" "migration" "Migration to add token gating fields to forms table"
create_file "database/migrations/$(date +"%Y_%m_%d_%H%M%S")_create_form_submission_wallets_table.php" "migration" "Migration to create form submission wallets table"

# Models
create_file "app/Models/TokenGating/FormSubmissionWallet.php" "php" "Model for storing wallet submission data"

# Controllers
create_file "app/Http/Controllers/Api/TokenGating/TokenGatingController.php" "php" "Controller for token gating API endpoints"
create_file "app/Http/Controllers/Api/TokenGating/Web3ConfigController.php" "php" "Controller for Web3 configuration management"

# Requests
create_file "app/Http/Requests/TokenGating/TokenGatingFormRequest.php" "php" "Form request for token gating validation"
create_file "app/Http/Requests/TokenGating/Web3ConfigRequest.php" "php" "Form request for Web3 configuration validation"

# Services
create_file "app/Services/TokenGating/TokenValidationService.php" "php" "Service for token validation and balance checking"
create_file "app/Services/TokenGating/Web3ConfigService.php" "php" "Service for Web3 configuration management"

# Configuration
create_file "config/web3.php" "config" "Web3 networks and RPC configuration"

echo
echo "📄 Creating frontend files..."

# Vue Components
create_file "resources/js/components/TokenGating/TokenGateSettings.vue" "vue" "Admin component for configuring token gating settings"
create_file "resources/js/components/TokenGating/FormAccessGate.vue" "vue" "User-facing component for form access control"
create_file "resources/js/components/TokenGating/WalletConnector.vue" "vue" "Component for wallet connection and network detection"
create_file "resources/js/components/TokenGating/NetworkSelector.vue" "vue" "Component for selecting blockchain networks"
create_file "resources/js/components/TokenGating/CustomRpcManager.vue" "vue" "Component for managing custom RPC endpoints"
create_file "resources/js/components/TokenGating/BalanceTestComponent.vue" "vue" "Component for testing token balance functionality"

# Services
create_file "resources/js/services/web3BalanceService.js" "js" "Service for Web3 token balance checking"
create_file "resources/js/services/web3ConfigManager.js" "js" "Service for Web3 configuration management"
create_file "resources/js/services/networkDetectionService.js" "js" "Service for automatic network detection"
create_file "resources/js/services/tokenValidationService.js" "js" "Service for token contract validation"

# Composables (Vue 3)
create_file "resources/js/composables/useTokenGating.js" "js" "Vue composable for token gating functionality"
create_file "resources/js/composables/useWalletConnection.js" "js" "Vue composable for wallet connection management"
create_file "resources/js/composables/useWeb3Config.js" "js" "Vue composable for Web3 configuration"

# Types (if using TypeScript)
create_file "resources/js/types/tokenGating.ts" "js" "TypeScript types for token gating"
create_file "resources/js/types/web3.ts" "js" "TypeScript types for Web3 functionality"

echo
echo "📄 Creating test files..."

# Feature tests
create_file "tests/Feature/TokenGating/TokenGatingFormTest.php" "php" "Feature tests for token gating forms"
create_file "tests/Feature/TokenGating/Web3ConfigTest.php" "php" "Feature tests for Web3 configuration"

# Unit tests
create_file "tests/Unit/TokenGating/TokenValidationServiceTest.php" "php" "Unit tests for token validation service"
create_file "tests/Unit/TokenGating/Web3ConfigServiceTest.php" "php" "Unit tests for Web3 configuration service"

echo
echo "📄 Creating documentation files..."

# Documentation
create_dir "docs/token-gating"
create_file "docs/token-gating/README.md" "md" "Token Gating Feature Documentation"
create_file "docs/token-gating/INSTALLATION.md" "md" "Installation and Setup Guide"
create_file "docs/token-gating/API.md" "md" "API Documentation"
create_file "docs/token-gating/CONTRIBUTING.md" "md" "Contribution Guidelines"

echo
echo "📄 Creating additional setup files..."

# Package.json additions (note for manual editing)
create_file "token-gating-package-additions.json" "js" "Package.json dependencies to add for token gating"
cat > "token-gating-package-additions.json" << EOF
{
  "dependencies_to_add": {
    "ethers": "^5.7.0",
    "@walletconnect/web3-provider": "^1.8.0"
  },
  "devDependencies_to_add": {
    "@types/ethers": "^5.7.0"
  },
  "note": "Add these dependencies to your package.json file"
}
EOF

# Environment variables template
create_file ".env.token-gating.example" "env" "Environment variables for token gating"
cat > ".env.token-gating.example" << EOF
# Token Gating Environment Variables
# Copy these to your .env file

# Enable/disable token gating feature
WEB3_ENABLED=true

# Custom RPC URLs (optional - will use public RPCs if not set)
ETHEREUM_RPC_URL=https://eth-mainnet.alchemyapi.io/v2/your-api-key
POLYGON_RPC_URL=https://polygon-mainnet.infura.io/v3/your-project-id
BASE_RPC_URL=https://mainnet.base.org
ARBITRUM_RPC_URL=https://arb1.arbitrum.io/rpc
OPTIMISM_RPC_URL=https://mainnet.optimism.io

# API Keys for RPC providers (if using custom endpoints)
ALCHEMY_API_KEY=your-alchemy-api-key
INFURA_PROJECT_ID=your-infura-project-id
EOF

# Routes file for token gating
create_file "routes/token-gating.php" "php" "API routes for token gating functionality"
cat > "routes/token-gating.php" << EOF
<?php

/**
 * Token Gating API Routes
 * Part of OpnForm Token Gating Feature
 */

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\TokenGating\TokenGatingController;
use App\Http\Controllers\Api\TokenGating\Web3ConfigController;

Route::middleware(['auth:sanctum'])->group(function () {
    // Token gating configuration routes
    Route::prefix('token-gating')->group(function () {
        Route::get('/config', [TokenGatingController::class, 'getConfig']);
        Route::post('/validate-contract', [TokenGatingController::class, 'validateContract']);
        Route::post('/check-balance', [TokenGatingController::class, 'checkBalance']);
        
        // Web3 configuration routes
        Route::prefix('web3-config')->group(function () {
            Route::get('/networks', [Web3ConfigController::class, 'getNetworks']);
            Route::post('/custom-rpc', [Web3ConfigController::class, 'addCustomRpc']);
            Route::delete('/custom-rpc', [Web3ConfigController::class, 'removeCustomRpc']);
            Route::post('/test-rpc', [Web3ConfigController::class, 'testRpc']);
        });
    });
});

// Public routes for form access
Route::prefix('public/token-gating')->group(function () {
    Route::post('/check-access', [TokenGatingController::class, 'checkFormAccess']);
});
EOF

echo
echo "✅ Repository structure created successfully!"
echo
echo "📋 Next Steps:"
echo "1. Add dependencies to package.json:"
echo "   npm install ethers@^5.7.0"
echo
echo "2. Copy environment variables from .env.token-gating.example to your .env file"
echo
echo "3. Add token-gating routes to your main routes file:"
echo "   Include routes/token-gating.php in your RouteServiceProvider"
echo
echo "4. Run database migrations (after implementing them):"
echo "   php artisan migrate"
echo
echo "5. Implement the actual code in the created files"
echo
echo "📁 Directory structure:"
echo "├── app/"
echo "│   ├── Models/TokenGating/"
echo "│   ├── Http/Controllers/Api/TokenGating/"
echo "│   ├── Http/Requests/TokenGating/"
echo "│   └── Services/TokenGating/"
echo "├── database/migrations/"
echo "├── resources/js/"
echo "│   ├── components/TokenGating/"
echo "│   ├── services/"
echo "│   └── composables/"
echo "├── tests/"
echo "│   ├── Feature/TokenGating/"
echo "│   └── Unit/TokenGating/"
echo "├── docs/token-gating/"
echo "└── routes/token-gating.php"
echo
echo "🎯 Ready to start implementing the token gating feature!"