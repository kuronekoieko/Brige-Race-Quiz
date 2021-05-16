using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Character : MonoBehaviour
{
    [SerializeField] Rigidbody rb;
    [SerializeField] bool isPlayer;
    [SerializeField] Animator animator;
    [SerializeField] Transform cartTf;
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
        cartTf.parent = null;
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

        if (direction.sqrMagnitude < 0.001f)
        {
            rb.angularVelocity = Vector3.zero;
            return;
        }
        float dot = Vector3.Dot(direction.normalized, transform.forward);

        // 左側なら正、右側なら負
        float angularDirection = Mathf.Sign(Vector3.Cross(transform.forward, direction.normalized).y);
        if (Mathf.Abs(dot) < 0.99f)
        {
            rb.angularVelocity = Vector3.up * 10f * angularDirection;
        }
        else
        {
            rb.angularVelocity = Vector3.zero;
        }
    }
}