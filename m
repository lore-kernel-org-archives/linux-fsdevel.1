Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6C3D6CB7
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901503; cv=none; b=V/Ybarzzh1jgi/5VcwhcvQIAns03wczK8VM1VQbcpaSxXOhcSb4s4ZdcM6EHQjHh4q4yTM8S/S6xd9tqUjM/7aDUIwnH5YNjIxE+zafQGvLjeoXJkb79WnqsUjExFjvM3XHbocdiJw0S4HQw9Lbfx9VGFlAWGLHY3GUOqK2Syos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901503; c=relaxed/simple;
	bh=OVJzpWfHSM6a6wCkK3C71K/fLknshrLRt2xkWr7HMRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pji75NKwEZEJfijw9O9hsRPPIU0QXEezpiVf58uSoa/2zPG4vtgKzBnq6mY1F6u01zUDGaZLzQKUFvLFCK+a3tZRH7dJvx4VKZ8+2BzLGIlkeX3bNqVmOWSzxHnp+Ge1Fe5coNWAx4cIZeWGFDI2pU44Bncw9EqEpMehyoHMP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=U8+CWeSh; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="U8+CWeSh"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66fc2844f0eso5274461d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901500; x=1789506300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=U8+CWeShrP14rgd44xgUXmUiojOa1fT3Mhh3nlczkGv1oipwxynmAEQEqNxrMtp4m1
         LHp+zbkug6yh1QwpdXbI3+jBIehKxHKKtLaLh+MTKxaQ50cfrDLUfCPUFzxOjho4dnSU
         8F08P7LDTRpP5d0leXwrRILcSSYwztvT/eNCMQgbU0NVwLU900vW0bfAjtKjYn7Zob4u
         egwRy9ZeTOHMkyQRgf8eK2dsIPC668Q6Gicavzx6dBznLxqyJ891EuKeaqpEcWTb0Sue
         TbfzF+PIxtytl6Sd72GiyQrX9yplM/Iwo7iY/RyTNrgvrVIVjNbLytph4ZfzltSTe1un
         jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901500; x=1789506300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=stkirP8jcVF4k7bYhYBiA6Mp+V7686PVXlpyrdAgb2PBFQWXROnjSFD+SuHn/0Lr0m
         i4nGXYy3TKQ2Z4Cefwv+5agvz0IUtnXFFruQHcAF8cYE7U/fRvKub5rbzpB1jwJEIHDD
         3xTNKazrZ5MYBLjeiP8/8azOAtkYMurgIQak3G2opCx8PwL3QaytXFIgU1mBAO5KYj2K
         DU7LOajKgIVoICfY4ND5o9ki/bwE96DKi07SBbl2JaqUVAtioiN1Vd/UesFZFb3pNVRZ
         a48dZaa4o2auETo4xzHoEXyUFfKqyHsASIfuVSGDPzsuSyLEFJNvYZWz7aNW67Mx9Ug6
         7lPQ==
X-Gm-Message-State: AFuF++mCiEYz6SwkOxVvWASEBM8WXnPHSy7Qt0oh9y3NI3OB3BkLimJV
	AQ2sBVfuJQ8Lq16uhhGW/pHRY24FMZhHejScf85Rohky027C/tAx1fFDhS28eApk1KU=
X-Gm-Gg: AYBFou2N44i/EfE1dFi18/OqFQjHfoLYVs+wdby7Tr2GQUYhn238Qn0r9800NwikQ6t
	zbt/BOL0ZM+cnOad9xShNl0v92xM5I9P7SrxTKGRbZjbsOrTO3r5mW9TT12j8i//HEo7oJvoCr/
	a5jGaKWT8NMl9NPWvDZA648Td9PhICFr5iVuOYLK8SJdttuT0gurnS3i4VUjkwSo7JfKWAc/4Pq
	wDwxmq0fHpfuME2zOQpgDP7R/yN9Y9Y64RwHkOWLYJrLOIjPo/2AiLKKcHjRv6898syFOSLp1xz
	bCGrgE72Ldx68rcjGMGPQ6OMCFEZrz86lZlvHhExjA/JcRGzXVkIXkL146/rT3CIKOdnUpi76Zf
	qCVTbtMme2j0VbwNqgwn4uQexRpg48v6QhE16+m515ct74sZlhru3Ub8ysXO5k5Dov1RMSnZJkm
	0M8nKp4pd3C3Czjb408plB5SQ+X1msvijJTsq4hov7PvMNpqeeq6bRGX1ay9j2Aj7uAfrrU5yz3
	Dq6kc3C3V7L03Ihksm7X3kyXjJdvEu5SwfjPhXko3H4AC9vD/Jguyqh87GCTnrbe3K8MoD4FBvu
	4DbSRMi0y8fpVEog
X-Received: by 2002:a05:690e:2599:b0:66f:c1be:84c9 with SMTP id 956f58d0204a3-66fc1be8d51mr6688418d50.55.1788901500408;
        Tue, 08 Sep 2026 14:05:00 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:04:59 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 1/7] hfs/hfsplus: exchange hardcoded number of extents on named constants
Date: Tue,  8 Sep 2026 14:04:42 -0700
Message-ID: <20260908210448.296772-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>
References: <20260908210448.296772-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the magic 8/3 fork extent-count literals with named
constants (HFS_FORK_EXTENT_COUNT and HFSPLUS_FORK_EXTENT_COUNT).
No functional change.

cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 include/linux/hfs_common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..8673933bbee5 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -171,18 +171,22 @@ enum {
 	HFS_XATTR_NAME,
 };
 
+#define HFS_FORK_EXTENT_COUNT	(3)
+
 struct hfs_extent {
 	__be16 block;
 	__be16 count;
 };
-typedef struct hfs_extent hfs_extent_rec[3];
+typedef struct hfs_extent hfs_extent_rec[HFS_FORK_EXTENT_COUNT];
+
+#define HFSPLUS_FORK_EXTENT_COUNT	(8)
 
 /* A single contiguous area of a file */
 struct hfsplus_extent {
 	__be32 start_block;
 	__be32 block_count;
 } __packed;
-typedef struct hfsplus_extent hfsplus_extent_rec[8];
+typedef struct hfsplus_extent hfsplus_extent_rec[HFSPLUS_FORK_EXTENT_COUNT];
 
 /* Information for a "Fork" in a file */
 struct hfsplus_fork_raw {
-- 
2.43.0

