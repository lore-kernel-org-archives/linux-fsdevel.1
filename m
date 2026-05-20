Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEF3EF647
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296525; cv=none; b=jQxLZYXWXGUY1L3M9pC+S4JLYnbfa/1yfdTR3g12d832i+S5jx8zLXrcwZvOn5IVVnmlGruHGeAKJM0SjSraLwRdoewggeCuoNIbmPJEHGMM+GP4Uag7rj7CK2dxoZyobK8LOc+DHKJQ3ITGf/OAYIajo8OdlOYndNalLJCYxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296525; c=relaxed/simple;
	bh=8URWsIbc9eMr1h4MiC2gKQRQm01Rp5RlLgLSqJKTM78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVmbA6ugtyXJ5bOAImkwMnHcFkguCY1esYH9LdU9GffEq6i4Kg8IMelU68Z4jvyDaEgg8ClS6iIvyL9/apJ0DH/sxwuLhWTzmLfQUiYP7TnprruVG3nNv8/WEBZZj3Ee5RXRsxaHcB4hfnp5gVrHcarzW8xekHcLDFVJsOe7d0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDI+46cj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDI+46cj"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83aea7d1fffso198020b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296524; x=1779901324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEkJeL9Z8UZWA2zeOFYFIhYl2cIC1COc0WCjFwNppF0=;
        b=MDI+46cjm0xUQLUTD31Yw9vAqLrN4oydWqn1sgeQbleQuQKvSHDh7L2zjRMK9C2qiD
         9PB2Ki3hZOKnlV8IUH2+gyvoawkJBXej8DhAFaTIWT92PkEew4QVFJKmdMLuKfaJwBMm
         gXq6AbGF4914iO7UGdOI2eHmyhLgN5kt8I/ReIDUhLfeBNZXN8zvoySdbIYFFD7tqrgY
         GM90586Rjx5qsCwSedIxgqO5dvce/mt6Tx9/7tSq23hALs+o1WwG4IH00KWm+4lIKa/l
         nKNvmmTred1PTRk1l3pCvI5haDjBV2B0I0zHnmRjGeUNCM7mKXhFEcATtULDlyaFAp0r
         gG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296524; x=1779901324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEkJeL9Z8UZWA2zeOFYFIhYl2cIC1COc0WCjFwNppF0=;
        b=JYitriEyBSg7CiY5Z6jgtnHeKIhzA1v1abOfVrkz1zkTnicTCcRVIkJRc8T2f7LBPr
         T6+31kOmDW1TQoBYMmHbDPDFHmCFDy4xIzDPmaCEgEfAYTN8kLRr1zhwzi1p8IHOsara
         wihGZfbS5fBOVX7iyjgF4o5U1ZyxATwJMo1Sgb2kWkLHeoQ76mzu0R4zB541zETYuDqW
         tQTs8kYp+Wf2nS3WUK7JX3Ih6tzTse+4GRzrKECgV9tmoFVTi6m2camLMjBbJ9qv++bz
         BvEVohxGgEMiCt1lWI5H6MqtK41iabMe46rH6rXUf2K3hqB4Q8GjnUBncaPGX/pOolVm
         gyxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+PTGghXyBvxL2xoRnYanbFnPPplXH6+4Iuz37FrMDvBqbW32zAbLQDhZ2mM+VTxJMQlLrp0rM5xE+B4rL@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRWw2Qery3hVgwycgNARxho3V5DaOBTEBqr3BNJhAFufFFl5O
	Mi8dRdhMTnJupwfff5T062HkRRYpMsERCC/vhCtNGl4ICd+5nOq/z7fX
X-Gm-Gg: Acq92OEC8GNECi7NqYBnXx2X2u2Wqmr5NX8UIUnq1WXNDnLeQwUAUl7KSY2cGzJq6hw
	+hlGJ4xyxrPE0Y3auYHQIOGzIWEA9OIy4jKzcAlHX/R25LBu1+hudnjbM8ShoXx12evxlc+s6Cn
	dEKhW5iKSYbnu6nlP6WAl86ySMbRAwghgTxw4slaLUThMDSzUj6PSkvNiOIdJuXUTceEzqW4Dep
	XjEc5gqhrBZqdWECtNglJdVl5jTzTdSUZJT0znZ0FJydgNWAHSeWEbEhc63l+bkFL8D3dH0QrO7
	VibksH1eru8nLR0JeSowaHNaqixk/kAJqnB24d4WB6CgEoT7lpafwoaPthgBsnHBnez3Uhmka7a
	eMDUh1qWhByTU5JtivCjiD8fJpifpu1g2RTa8mW9bklFGcS9UH5I7423ppcs4
X-Received: by 2002:a05:6a00:2d95:b0:839:6474:c69f with SMTP id d2e1a72fcca58-83f33dd90e5mr13115560b3a.7.1779296523693;
        Wed, 20 May 2026 10:02:03 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm22125954b3a.0.2026.05.20.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:02:03 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/3] ntfs: wake free-cluster waiters when precalc allocation fails
Date: Thu, 21 May 2026 02:01:50 +0900
Message-ID: <20260520170151.4115308-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520170151.4115308-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_nr_free_clusters() is run from the precalc_free_clusters() worker
queued at the end of ntfs_fill_super().  It is also the only place that
publishes the result by atomic64_set(&vol->free_clusters, ...), sets
NVolSetFreeClusterKnown(), and wakes vol->free_waitq.

The initial kzalloc(sizeof(*ra), ...) can fail before that publication
happens.  Callers that need the free count wait on NVolFreeClusterKnown(),
so this failure can leave statfs, write, and allocation paths blocked
forever.

On the OOM path, publish a conservative free count of zero, initialize
the per-bitmap-page free counters to zero, set NVolFreeClusterKnown, and
wake the wait queue so callers fail with -ENOSPC rather than block
forever.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 super.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/super.c b/super.c
index 6cf09bbe017d..c90cb5673f98 100644
--- a/super.c
+++ b/super.c
@@ -1980,8 +1980,23 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 		return atomic64_read(&vol->free_clusters);
 
 	ra = kzalloc(sizeof(*ra), GFP_NOFS);
-	if (!ra)
+	if (!ra) {
+		max_index = (((vol->nr_clusters + 7) >> 3) +
+				PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		/*
+		 * Publish a conservative free count and wake any waiters; the
+		 * NVolFreeClusterKnown flag is the sole signal the wait_event
+		 * loops in statfs/allocation paths use, so failing to set it
+		 * here would leave those callers blocked forever.
+		 */
+		memset(vol->lcn_empty_bits_per_page, 0,
+		       max_index * sizeof(*vol->lcn_empty_bits_per_page));
+		atomic64_set(&vol->free_clusters, 0);
+		NVolSetFreeClusterKnown(vol);
+		wake_up_all(&vol->free_waitq);
 		return 0;
+	}
 
 	file_ra_state_init(ra, mapping);
 
-- 
2.43.0

