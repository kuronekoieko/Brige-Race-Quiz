using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zenject;

public class GameManager : MonoBehaviour
{
    [Inject] CameraController cameraController;
    [Inject] ItemGenerator itemGenerator;

    private void Awake()
    {

    }

    private void Start()
    {
        cameraController.OnStart();
        itemGenerator.OnStart();
    }

    private void Update()
    {

    }
}
