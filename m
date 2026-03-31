Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC03EE1DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986241; cv=pass; b=ZuppVlV6y8kiSsSoV74/OIbo2NFQ8XKGa9QzmKX1XhLKb8Ze4IXRUaHaj+JwAIcRzYNmQfaiEWtsN08Ybj/Ds52dGQ4m9XlDrg7IDdE3P5QbaiHPVGmjcw81k5jke+3jQQ2596eNjYYXsUwB7qUEpTot2LPMgIha1s8vGPE7h+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986241; c=relaxed/simple;
	bh=YUELv8ViZKtga1atWoviIuY3T3Zh0ws8oWzMmh87XV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h2qLF4HDZXvDmC37bm5unjWL8HcLagTxARwRIcHdNImjMApsOD7PzJmzBaa2C0YgJn1Vd8R2UTXHjRtxKUv0h4kEK1vhR0e6exdEyxTfOia0Zq8lWimGdNgRlZZKqwZRpHWcMNa2zfKCdq9z6YqT7VmxFk1pzpqOnHu8R5uyCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfzkFVgb; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfzkFVgb"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-60328e74569so3979659137.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 12:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986239; cv=none;
        d=google.com; s=arc-20240605;
        b=M/1mcbzV9LONQ9PM61n9LJbusboxEuy8VulKmb3ld0xq3Z8dTFzhTFZP6exGL8IGvo
         O8effYbh9Y4dnCSkNc6g5A6vcSC1bL0hriAd62AOc/YDQZyZZkRbosDMgHi6P/6l6bje
         TvvKUwCs9rTYfNVV8FY6o0ZqMedgDqBQgwyVssTAqAe4AfqGUpZ2PRaKJQnqEkcEASU5
         3o56uAakONZ8m3Wuc20ZuyyDrDp0jiWBNBARaejGpmuwIbqMWUVOeu827BoJtLpjIKrB
         Bsy3oqIbMoiuxiLoUP8RWVfMa15NZpN2qWjxBv9tQxiBhyK4SeUEsb5V3Ll+uquSTskj
         /R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nr14MB9jKoo/1LC8ydE0zzpt55tHEenOreaGRoyDC6E=;
        fh=+PqK1gP19aGdeoii+r7wqLHTdS9srSLjf23mqP0gD9Y=;
        b=RfW/TMdIiovqd4EWbR75EQU7uk5g5zRnF95kJZND/Q2x6H0bCoBVPEyvpFBoq17Tn8
         L/Xhjdx91c4WZBZHiNU6WWeI9phiar33oDPdlKwPJfjAJTZ/VtyuXhyQ1RhwCFhtvQPV
         N9wxXXE4On0Fw5vNRVoawEi7mLQSn0Dej7gcLhVHMvkkZUNK29ENOb1DvmameVCLPKcP
         7MfBdcjeJKnbPnyl7a5EjddFY0gg1F1rhgphgmGLoFC1Pgs/LVm1hSYK5JByD3jnX7s2
         4pvxpY/MZiYPq9+tWUazQ/h8kpK43t0iqYLkCJfDthAdQiqCowR5MonqB21CQKhvXt6R
         1k+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774986239; x=1775591039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nr14MB9jKoo/1LC8ydE0zzpt55tHEenOreaGRoyDC6E=;
        b=jfzkFVgbdNLCp7ByrRW1Y8i8k44ehitvdaiK8EZmvbcRzwzpnu12qrLIu30uB5xIuK
         4FZAZnUD0jdHntae/PWVE0sq2ow9pHoRTQrhEzfwHGVqStqprxLbZ8h+8JZHJPqMuGY9
         qSmdymNKMaBr5HCvqgGV56P3A36ubjCjt6iFmvZzN87p+u6HNu8AJnoB1AhrY9H1epv6
         5aCbHasJaJ2kDDHkcyrsq+qh1uAKLREn0ucBLh1iCAy0c+uxZrZaxp8WbZmBq+MrxFKE
         90snprzbbot4k96pyYqkz6XekGUnIAS2gRZkf3kZiShQZco0XWswAX6TksuGABK6OTHg
         vS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986239; x=1775591039;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr14MB9jKoo/1LC8ydE0zzpt55tHEenOreaGRoyDC6E=;
        b=TjNeuR56P9xSPPDjUt+LnsFVe8oqUz8S0xfMuaqyVIL7oh5WeMU6b8sJ/dJ9CqlvJE
         vK3+DPb+s4CDLZ1MYoQV5utn9R8y02FrOK79I0cO4Adz2ycv1pwWlli2msLPwz6llNd3
         UOlCnlNHe60Hjc0hftIjPaKOmcvu3j5PIhjf4apvttuMwNPr0756YQyjJXa9Md7zkItj
         VF53Irj0fPQCXt89WrkT3/n4R2Rktg12gTIqh/0UznX+/lC6O0jPJX0Jtkxgkuyizf9E
         fo9zSTdq40b1m54KbExt70jQY1xfQLumEQbWLpjtSr5ABh64Irx99pMKDUj4UFEdfHUC
         qPZA==
X-Gm-Message-State: AOJu0YwjQgjPvH4o5HZYd3ZZ7L9H/NAEJcKGarzOZFppeME9xYLqIzwE
	kbywaYUnJt6Kw9pF+317BOYBkvv0AJm/XQG6YN+ChFvre+cWxPctzczZY1mltyAJNKgzN8Pi8Ol
	FB9SpDZZ90w6aTaedjTZFPh7SzgFyxMQ=
X-Gm-Gg: ATEYQzzrkRzy9Gh9vjf7YXy4Ih131cT9O8dCiz9mwvwc+fHxILy5PHaHFRvH/Ji2Gs6
	Jh2Aki6DN7is1K23XRu01yExl/3vh5idrxPmhUFNbwpxsftKmZ/GuPsQqjXCpLYBjEOFXpPeO2Y
	K81Ane9IOyKZ14pKz00BOYobwrc2EzRiMcKc0jyExad7DrTEFMIbRbJ/ALKj2RZ+vb0UyknElA3
	15IZWawICzfLJ8TuM+I9/z5t7Y2VkLMSfhyCnDgrc55wIkNsZ1jzhuzHfSUb0CHsZPCXB/W/TQS
	njB9n5MJrg4YqSeZ
X-Received: by 2002:a05:6102:3e17:b0:5fd:ff75:f437 with SMTP id
 ada2fe7eead31-6056826cfbcmr252787137.33.1774986239232; Tue, 31 Mar 2026
 12:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JTQsNC90LjQuNC7INCR0YPQu9Cz0LDRgNGM?= <bulgardaniil18@gmail.com>
Date: Tue, 31 Mar 2026 21:43:48 +0200
X-Gm-Features: AQROBzCDnwbcWvG5-YkXWZSpaTNbTMDVAAeJ-kLYJYVEfEGgOu7qkjZZKAO126E
Message-ID: <CAMPU55iWEB0h1u8V0VcRGRxP14n+_GGE7BMXGtTZA1Tr+nyLFg@mail.gmail.com>
Subject: fs/ufs: refactor ufs_set_de_type in util.h to use a table lookup
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fs/ufs: refactor ufs_set_de_type in util.h to use a table lookup

Replace the switch-case logic with a more efficient table lookup for
converting mode bits to directory entry types.
This addresses an explicit TODO in the code.
The change reduces code complexity and slightly decreases the
compiled size of the function by replacing
branching logic with a constant 16-byte array.

Signed-off-by: Daniil Bulgar <bulgardaniil18@gmail.com>
---
 fs/ufs/util.h | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 391bb4f11..8966c3ab5 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -152,34 +152,17 @@ ufs_set_de_type(struct super_block *sb, struct
ufs_dir_entry *de, int mode)
     if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
         return;

-    /*
-    * TODO turn this into a table lookup
-    */
-    switch (mode & S_IFMT) {
-    case S_IFSOCK:
-        de->d_u.d_44.d_type = DT_SOCK;
-        break;
-    case S_IFLNK:
-        de->d_u.d_44.d_type = DT_LNK;
-        break;
-    case S_IFREG:
-        de->d_u.d_44.d_type = DT_REG;
-        break;
-    case S_IFBLK:
-        de->d_u.d_44.d_type = DT_BLK;
-        break;
-    case S_IFDIR:
-        de->d_u.d_44.d_type = DT_DIR;
-        break;
-    case S_IFCHR:
-        de->d_u.d_44.d_type = DT_CHR;
-        break;
-    case S_IFIFO:
-        de->d_u.d_44.d_type = DT_FIFO;
-        break;
-    default:
-        de->d_u.d_44.d_type = DT_UNKNOWN;
-    }
+    static const unsigned char type_table[16] = {
+        [S_IFSOCK >> 12]    = DT_SOCK,
+        [S_IFLNK >> 12]        = DT_LNK,
+        [S_IFREG >> 12]        = DT_REG,
+        [S_IFBLK >> 12]        = DT_BLK,
+        [S_IFDIR >> 12]        = DT_DIR,
+        [S_IFCHR >> 12]        = DT_CHR,
+        [S_IFIFO >> 12]        = DT_FIFO,
+    };
+
+    de->d_u.d_44.d_type = type_table[(mode & S_IFMT) >> 12];
 }

 static inline u32
-- 
2.53.0
