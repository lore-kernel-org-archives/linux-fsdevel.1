Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCB3002DC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763524; cv=none; b=U5veV7G2JUf/jAHd6YiCrmZu3eI8/2cIfRMj47mhUw//zQY/oRgQD4zjqsA2Du/qZlvs7VX1i1d+ko7DqPMcaGg3okboHh/O7TaXcGLEXnk9Oi5j1UsspTBogSHhKdOJ9vV0xhbTnbiCJHxefQl6MsL8oLT1/aFfXbh+Lt7UrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763524; c=relaxed/simple;
	bh=M3keG6vQkBcVahfdNtoAk2Jdip7RTKHKrW1dvJ0kByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp7OMeTYg7e1FqR7jo8j2ftv8t7X02PnYsCcfsuNY63sWX2eVGzqDNJyINaDMkf+zrZpKGCT55X3hnFGobPyiw85TpfKpK2+bBmVIK1KHo/DU3EKOR+Z/Et/TQCsFby7U2G2wO2iJJYCzQ5Qi2e24I8WHqJHzug+ka7lWq6xV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=cu5hfNiv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="cu5hfNiv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7a17bc5745eso13543627b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775763522; x=1776368322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDMf5DiqxzIRFODg39rHWew8Gffuqkfj+AOOcAvVplo=;
        b=cu5hfNivBe5KkChwlaW+Ni3oUOhzyP+JlwPi2OH4FOo72QXT/WwPc4qeXE2KKUP8A+
         9OzP0yYiPk4L9cXa2bDW+o3lPh48AtoZ53vEnG3mbgCBlEOYufbK/IaTB6J8omeLOBYF
         wy2mfX2seF5yoNV5MW/iS6uY9MfFn1DpEbJsrXKLBkgEGnjzY9i3h3utMpxmwbUMAsir
         2sSszhk8tWjOs7JKDPq1NkUyFNp6tCYPB8Jz3pp0UdL8mpPvK8btiM2VJ7/PmpAoZFez
         64IQN+hbTLc6B4F3WzNeKE8IUVM4L1mDg/rL5xMSMW9/PtrQUJ5IMcoo//UQRcvUVD/U
         N8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775763522; x=1776368322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDMf5DiqxzIRFODg39rHWew8Gffuqkfj+AOOcAvVplo=;
        b=nic1AjH9+bg30TKvJ721k1Wnyk+NpqC05cfBGVTBx9D4sRlsYiJudJdbb65cEzEPhZ
         DrkbIMw6JwLTqVTaXQCQ2LZPLur+LvsdkiHkhwg25MJTAEFwVks2PEa91MaSsdNMCfoA
         Rnbt4xV2nwI+4wsiF2runhVFxElXnijAdkJD1BKp1BRasRWmSsE5WcmaqOGVUwJ0dXZ2
         tdj4Z0u4WfsOXSVT9VlOCyMBcv+R1EQ5sfPNalH5trVjt/WYOvovhKFdxU4kNATLKRWV
         zyKW+PNw9u6q30jIESEFx9FJdkt2AcXC+RaTbq8QYWvpz5q55bKIBLrcZAxySHMwsceG
         jdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV03mxM3TZHM0ILgxsZv3dLtTopZNaH/J18V2fMFWsBYihEl+FrcUf304loLlzPN9fwNO67lNpkDx5iR/An@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5KZK7pGxBaoWvJjsYLwJG55nA++aESU4hqNLqh4SbtCarRSo
	va1NZzwNw5UobEd0MaBglM/r8SzoOJiTet0Q39Qd2jdnR4m0aQZFAI6QOP4n1UZMw5I=
X-Gm-Gg: AeBDies7xQgDZuZ4NP40t8HpAOM1aUyMARtX+zkqRUMxDRW5rRoOxOm4I8JbuICvYOK
	XGQTv/trGNOmY8VY7rChSUEgUwaBUPiQ89CADpbM33V2hi2T/sSPjeOsDkfOCaA4cLLEmguoWKZ
	U+IT9Q2jj8EsAlTdfaI45R7hm83CS/HDn5zx2Jl7MtfduxcBugKqPFHIuWoDF8Uz6W3fiwtew5N
	UqNg6hp4aJGOAfxO9NZCgmTgqudW/IiClGeX2aaxAx4OXdhFqUyOcc41+6L723YNaRyf7U696c8
	UMEXnD7ZFvaEL+ODBq9KjSmqofUkOPWK97qZbbZW+4UXTS8UiGJzsQVpyfGHKHa+LRyJ6VrWMA2
	LbT991PgomZYP1VE+OjZfkmRmIV3UVXrwKwqIqPvbJWi5OsFCTV70mp2EUARFU0WlEBfzIlCgv2
	1KAo//ZLkWYSEBIYCl5YsGlrLa+i0Nh4UQEm4abe2TSumydw9qgMTOXT2WNb17uosS24b1Ufk2l
	zKzwrs28H5SAqnj1+zEXX5K4XWCakUF6RSnwAnikw==
X-Received: by 2002:a05:690c:e3cd:b0:7af:6904:3f1a with SMTP id 00721157ae682-7af6f327232mr3590377b3.11.1775763521895;
        Thu, 09 Apr 2026 12:38:41 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3cfcba46sm3343917b3.16.2026.04.09.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:38:41 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix a buffer leak in __ceph_setxattr()
Date: Thu,  9 Apr 2026 12:38:33 -0700
Message-ID: <20260409193832.318303-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The old_blob in __ceph_setxattr() can store
ci->i_xattrs.prealloc_blob value during the retry.
However, it is never called the ceph_buffer_put()
for the old_blob object. This patch fixes the issue of
the buffer leak.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5f87f62091a1..c6fcbf428317 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1294,6 +1294,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 do_sync:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_buffer_put(old_blob);
 do_sync_unlocked:
 	if (lock_snap_rwsem)
 		up_read(&mdsc->snap_rwsem);
-- 
2.53.0

