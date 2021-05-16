using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    Joystick joystick;
    Vector3 dir;
    public Character character;

    public void OnAwake()
    {
        joystick = FindObjectOfType<Joystick>();
        character.onStart = OnStart;
        character.onUpdate = OnUpdate;
        character.onFixedUpdate = OnFixedUpdate;
    }

    void OnStart()
    {

    }

    void OnUpdate()
    {
        dir.x = joystick.Horizontal;
        dir.z = joystick.Vertical;

        if (Input.GetMouseButtonUp(0))
        {
            character.ReleaseItem();
        }
    }

    void OnFixedUpdate()
    {
        character.Walk(dir);
    }
}
