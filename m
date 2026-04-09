Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F57233149
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762135; cv=none; b=icKK/tr5fjteBjJYAZLEkI8wINq6EmKXWRZ5I3re+7eiVUQDvOEkuGQa6r1/zZWpam6F/Sv4cwNAuga7TwJlGbRIW/ePfnrOKlFdwbuCkSyyzqTjCGqLC8MiNQcawel6bZ8zZEpMJqpBj46F2+mnIvKH4rWuISojNKS6+ouHf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762135; c=relaxed/simple;
	bh=mLxbGdF+LocgfZ13nZ2Tg+a474WR2+r7/8rr6DVILOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYEpHXECAO2HVPK1kr6cPMqMpHIqkJ3bSN+HZQaudr0JoMh16utb0kz5WqbbhWsxHvewNszsQEbo1F6nGanzDB8IY+i699HE9cpwxyZSr7WnRFi4YzhUM88VdTUUqx1yvFR/AbAkIyJe8774XQqbW0gwiXDveb2Yv3mF7HHHF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qvMeisT6; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qvMeisT6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65003f40a22so1149507d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775762133; x=1776366933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Ot6MQCY3SHVCp2P/Z1z8XnvK7coQdd/EmtdJmQhrs=;
        b=qvMeisT6z5CprDyM/kuJh5ETD7RZ+BZTFh2/GUUatfZdfRV3l6PchA1fzG2e8Zvu4h
         pLk4+Btk5mlRcQl7WPCiNUDEPBdGKKFi88s3DMYGbXkgRDWRaXGcgVz8U1q5rwY+ZXnu
         GcKmpu2wk4ObNcUVMLMLsnGhcdqLLC5xfqgqK6hadu7d/9LOyIQem6JVINRJhpVEuOX2
         9FHd5DXWoTVWP6Y+IYQ0eI5MI4KOsEUh9Iw5KFz9Fs+4qU47e3Hlx2zQ4eZovm6jkrqK
         g5fd0RI5xXWT6qKXqC7i4Wqds55P1lsqyUOxgknkMpLomgBCYWIAWetwYZFM6h4u6/Py
         nriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762133; x=1776366933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Ot6MQCY3SHVCp2P/Z1z8XnvK7coQdd/EmtdJmQhrs=;
        b=pxOyuIdzZ/emF01uCCkkI2QleaEQn7q21T/MbARgGX35yutFhqx4pKNo3o14T5nYKx
         n7nVNmBcq082vkAyiJ0tEM0qj3igJ19WRqRH1ZzgCu6PWOz7o2V8IXzzMfSF4WQShF5t
         v0TR3WS8yv7R+k5xgPbr4M8qI4+sEXM+7w4urDnGfViZ7aTQPDwIQAW/IlJ5zbN82BpG
         mwmwmMA78IAGDmeimlvOoaGBV0gShEo/IxNtSTNrNTL/l+GGuK7A0cR93ccUP9tUbDpK
         VurLaUSniQ30Kz/9KKp+MDxG9Fpj14BUege4bRBKnNYZ3TDzbWRA5giN7e2nrzcxWzqB
         598A==
X-Forwarded-Encrypted: i=1; AJvYcCVPa5vAPTSZa3ANiX7lKaSnkefwtxYVYzbpbCL6EGNzKDx9IhNparbq9omoIqEQ42HiBMsoDJNXjICtlcCc@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJnIuWQXsbcX0wDnqF/OsQSJnTQKs0581lfd+CWuRF30E8EG+
	1Q+DZsHCACbrwxy2nP3xfH+5Xm4rLBO92GSy9RIGcDpYfOrsVAs8GVSvTD0tqjf7G+E=
X-Gm-Gg: AeBDieszHAPL1z5FN4Ier7ibEK1u+TgAVqAecl9wHpfQ1MDqc/mYMsLhHBDgNENv5L2
	Kyx1mgS0fFvLx1Pjc9hR4jf2siDUM6qj+oWMePlp2Up9DVJKl4/ycNGynaAFkWprhOGuwt1hgo7
	ThP4qUIKCzdRTbzebmkJNskJUD0pZZRbGtEb82Mb4Br1KR0BH8aN13jSIXqqsbbOT48eZ/6BCqZ
	gdv0NO1w2y7uiK24SVMq9ZIUGtZQ4CQZlE5tAjjsLu5hT0aY0i7GT90g/A3GqE9omoQ+8ckTygE
	me2nFwzhS7x7LEcQJeUfjM5cp8qQmdwnPWAy/j8GNGzgqic/OIiegmHokj/Aef/DcFH2cWjne+O
	5h4S6KsAL7o15SkbvmqTBVZTdjvb+M0uChNZqHDege/7n0bhjFh3VAzi70BtHhNFPBprMnpJaZi
	daoEOo1WwDWH03Mh2E5mCuZGTLyksdU7S8QgU50IKCEuO+Z0REHfFKos7x7UCtbl8wvV5DIdr32
	xdSWcEejLb1mGKDBMDuahY/JcdJLM8=
X-Received: by 2002:a53:b1d0:0:b0:64f:fc0d:6240 with SMTP id 956f58d0204a3-65198bda2bemr163013d50.62.1775762132712;
        Thu, 09 Apr 2026 12:15:32 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197a82effsm198983d50.7.2026.04.09.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:15:32 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
Date: Thu,  9 Apr 2026 12:15:18 -0700
Message-ID: <20260409191517.318015-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as part
of a tree-wide transition to make per-CPU workqueue binding explicit.

However, ceph_con_workfn contains a while(true) loop that retries on
-EAGAIN from socket reads and writes, making it capable of hogging a
bound CPU for extended periods. This manifests at runtime as:

  workqueue: ceph_con_workfn hogged CPU for >10000us N times,
  consider switching to WQ_UNBOUND

Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
workers across CPUs, preventing starvation of other work items on the
bound CPU. The loss of cache locality is acceptable for network I/O
work.

Fixes: 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 108adb583744..dbca8bfaf5fc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -253,7 +253,7 @@ int __init ceph_msgr_init(void)
 	 * connections, so leave @max_active at default.
 	 */
 	ceph_msgr_wq = alloc_workqueue("ceph-msgr",
-				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+				       WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
-- 
2.53.0

