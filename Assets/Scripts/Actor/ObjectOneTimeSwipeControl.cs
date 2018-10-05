﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using DG.Tweening;

public class ObjectOneTimeSwipeControl : ObjectAutoControl
{
    public Vector3 swipeOffset;

    // Use this for initialization
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
    }

    public override void Swipe()
    {
        if (IsReady() && !IsLocked())
        {
            transform.DOMove(transform.position + swipeOffset, 0.5f)
                .OnComplete(() =>
                {
                    FreeAllMan();
                    Lock();
                    Deactivate();
                }
                );
        }
    }
}
