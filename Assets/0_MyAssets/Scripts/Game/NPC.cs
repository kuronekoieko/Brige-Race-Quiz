using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour
{
    public Character character;
    Vector3 dir;
    Vector3 targetPos;

    public void OnAwake()
    {
        character.onStart = OnStart;
        character.onUpdate = OnUpdate;
        character.onFixedUpdate = OnFixedUpdate;
    }

    void OnStart()
    {
        character.walkSpeed = 5f;
        SetTargetPos();
    }

    void OnUpdate()
    {

    }

    void OnFixedUpdate()
    {
        dir = targetPos - transform.position;
        if (dir.sqrMagnitude > 1)
        {
            character.Walk(dir);
        }
        else
        {
            SetTargetPos();
        }
    }

    void SetTargetPos()
    {
        targetPos.x = Random.Range(-10f, 10f);
        targetPos.z = Random.Range(-10f, 10f);
    }
}
