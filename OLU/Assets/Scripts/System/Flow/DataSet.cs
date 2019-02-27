﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class DataSet
{
    public static int unlockedLevelIdx = -1;
    public static int recentCompletedLevelIdx = -1;
    public static string recentQuitLevelName = null;
    public static Vector2 recentContentPos = new Vector2(0, 0);

    public static bool isInputEnabled = true;

    public static float magicNumber = -373737;
}
