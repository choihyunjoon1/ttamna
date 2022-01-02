import * as THREE from '../three/build/three.module.js';

class App {
    constructor(){
        var divContainer = document.querySelector("#webgl-container");
        this._divContainer = divContainer;

        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true});
        renderer.setPixelRatio(window.devicePixelRatio);
        divContainer.appendChild(renderer.domElement);
        this._renderer = renderer;

        var scene = new THREE.Scene();
        this._scene = scene;

        this._setupCamera();
        this._setupLight();
        this._setupModel();

        window.onresize = this.resize.bind(this);
        this.resize();

        requestAnimationFrame(this.render.bind(this));
    }

    _setupCamera(){
        var width = this._divContainer.clientWidth;
        var height = this._divContainer.clientHeight;
        var camera = new THREE.PerspectiveCamera(
            75,
            width / height,
            0.1,
            100
        );
        camera.position.z = 2;
        this._camera = camera;
    }

    _setupLight(){
        var color = 0xffffff;
        var intensity = 1;
        var light = new THREE.DirectionalLight(color, intensity);
        light.position.set(-1, 1, 40);
        this._scene.add(light);
    }

    _setupModel(){
        var geometry = new THREE.BoxGeometry(1.5, 1.5, 1.5);

        var textureLoader = new THREE.TextureLoader();
        var map = textureLoader.load("./resources/img/ruby.png");
        var material = new THREE.MeshPhongMaterial({color: 0xffffff, map : map});

        var cube = new THREE.Mesh(geometry, material);

        this._scene.add(cube);
        this._cube = cube;
    }

    resize(){
        var width = this._divContainer.clientWidth;
        var height = this._divContainer.clientHeight;

        this._camera.aspect = width / height;
        this._camera.updateProjectionMatrix();

        this._renderer.setSize(width, height);
    }

    render(time){
        this._renderer.render(this._scene, this._camera);
        this.update(time);
        requestAnimationFrame(this.render.bind(this));
    }

    update(time){
        time *= 0.001; //second convert
        this._cube.rotation.x = time;
        this._cube.rotation.y = time;
    }
}

window.onload = function(){
    new App();
}