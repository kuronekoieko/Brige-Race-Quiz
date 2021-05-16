using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public enum CharacterType
{
    Blue,
    Red,
    Green,
    Yellow,
}

public class Character : MonoBehaviour
{
    [SerializeField] Rigidbody rb;
    [SerializeField] Animator animator;
    [SerializeField] Transform cartTf;
    [SerializeField] Transform itemPosTf;
    public Player player;
    public NPC nPC;
    [SerializeField] bool isPlayer;
    public CharacterType characterType;
    float walkSpeed = 10f;
    public UnityAction onStart = () => { };
    public UnityAction onUpdate = () => { };
    public UnityAction onFixedUpdate = () => { };
    ItemController ownItem;

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

    private void OnCollisionEnter(Collision other)
    {
        HitItem(other);
    }

    void HitItem(Collision other)
    {
        var item = other.gameObject.GetComponent<ItemController>();
        if (item == null) return;
        if (ownItem) return;
        if (item.owner) return;
        ownItem = item;
        ownItem.owner = this;
        ownItem.transform.position = itemPosTf.position;
        ownItem.transform.parent = transform;
        ownItem.OnOwned();
    }

    public void ReleaseItem()
    {
        if (!ownItem) return;
        ownItem.Release();
        ownItem.owner = null;
        ownItem.transform.parent = null;
        ownItem = null;

    }

    public void Walk(Vector3 direction)
    {
        var vel = rb.velocity;
        vel.x = direction.normalized.x;
        vel.z = direction.normalized.z;
        rb.velocity = vel * walkSpeed;

        if (direction.sqrMagnitude > 0.1f) transform.forward = direction;

        /*if (direction.sqrMagnitude < 0.001f)
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
                }*/
    }
}