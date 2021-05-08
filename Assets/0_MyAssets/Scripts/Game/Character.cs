using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Character : MonoBehaviour
{
    [SerializeField] Rigidbody rb;
    [SerializeField] bool isPlayer;
    [SerializeField] Animator animator;
    public Player player;
    public NPC nPC;
    float walkSpeed = 10f;
    public UnityAction onStart = () => { };
    public UnityAction onUpdate = () => { };
    public UnityAction onFixedUpdate = () => { };

    private void Awake()
    {
        if (isPlayer)
        {
            DestroyImmediate(nPC);
            player.OnAwake();
        }
        else
        {
            DestroyImmediate(player);
            nPC.OnAwake();
        }
    }


    void Start()
    {
        onStart();
    }


    void Update()
    {
        onUpdate();
    }

    private void FixedUpdate()
    {
        animator.SetBool("IsRun", rb.velocity.sqrMagnitude > 0);
        onFixedUpdate();
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
