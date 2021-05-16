using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zenject;

public class GameManager : MonoBehaviour
{
    [Inject] CameraController cameraController;

    private void Awake()
    {

    }

    private void Start()
    {
        cameraController.OnStart();
    }

    private void Update()
    {

    }
}
