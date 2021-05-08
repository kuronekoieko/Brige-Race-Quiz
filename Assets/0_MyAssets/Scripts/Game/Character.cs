using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Character : MonoBehaviour
{
    [SerializeField] Rigidbody rb;
    [SerializeField] bool isPlayer;
    public Player player;
    public NPC nPC;
    float walkSpeed = 7f;

    private void Awake()
    {
        if (isPlayer)
        {
            DestroyImmediate(nPC);
        }
        else
        {
            DestroyImmediate(player);
        }
    }


    void Start()
    {
        if (player) player.OnStart();
        if (nPC) nPC.OnStart();
    }


    void Update()
    {

    }

    private void FixedUpdate()
    {

    }

    public void Walk(Vector3 direction)
    {
        var vel = rb.velocity;
        vel.x = direction.normalized.x;
        vel.z = direction.normalized.z;
        rb.velocity = vel * walkSpeed;
        if (direction.sqrMagnitude > 0.01f) transform.forward = direction;
    }
}
