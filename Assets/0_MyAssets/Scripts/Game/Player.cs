using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    Joystick joystick;
    Vector3 dir;
    public Character character;

    private void Awake()
    {
        joystick = FindObjectOfType<Joystick>();
    }

    public void OnStart()
    {

    }


    void Update()
    {
        dir.x = joystick.Horizontal;
        dir.z = joystick.Vertical;
    }

    private void FixedUpdate()
    {
        character.Walk(dir);
    }
}
