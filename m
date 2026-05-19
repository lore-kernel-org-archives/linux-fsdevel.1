Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7E340419
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199225; cv=none; b=pY6lC5NtDoMDddI8depEICYlXTF3Y/B6mhccW76JrwUA/5xTxJexbolHMi4nCT2Hw64rRXUjtLDMY9aXKsSwML+E9pYS+O47iHVi24vRBZTVR0wYkyczI86N6R2tB4gdqo4tcetrl44OJoxur7mLt5sCQGmsGuiHovp9HVs/LDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199225; c=relaxed/simple;
	bh=rh00+8CkvhUf5L5qQeiUYys/cEAiNnU8gZcvDzmdR6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DzKZkIBeh6X09xxc66VFKMyLPPTcX/sgPo71kE0Wk252v10fSzM/sih5OwYj/vp2dKTn0JIenqlDB+lWSdpF7TFg7C7drcsz1E1ytFUAl3zo0n7n2UcH1kBwGPRhJAe1ttR27aXBzPktbyd43SG7czH+ngwyojZxK9GNP+9WdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIBsI1u1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIBsI1u1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d1c670255so3975e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199222; x=1779804022; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj6Q3RQDF1dvwe9sYLWhvH0vVhTSMw/WV5aqKETF4Bs=;
        b=qIBsI1u1rWRS66GIYQG7ye4vCbtT9RaWxIGm/NQPwbz2j7/CRZOMFoTYLiegznDeqc
         mgkCs7550vbiO19PvvLccjdCIXl2mJfIwXBOKNCdjWC5NlIjAz5FnuRPXbpWS0X3SIDn
         s+eHrGUWiUYTNhk1vbSy4CAfczPhObYT2Vx9+lT3hoy7xJzZ4hlyPSsRLzQU4pSgqfA1
         W8praf34GV4Tz58AOPFrjx7Wsq4gk8Jdr1/i48jIb69ODP6Lq5MuhkoVe3l3oF2Xq6EW
         MITfyCcmoH/EBlgzYdifZm38lIY6HG2NcsT3GI/KqE/lCcVz2Cx81AXyuzm3XII5ln4V
         oqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199222; x=1779804022;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj6Q3RQDF1dvwe9sYLWhvH0vVhTSMw/WV5aqKETF4Bs=;
        b=TkYpKOrYlLD23pC1V6VeoJHj5+6pzqiDyTjyTOGEjG4/kK4nbBVON1Nq+9i5CX4iJf
         IP/plvtlh5IICYcO2OmkurtbC+WYsVgANHHHU0lfhMQ0ZxVSs+O0aobXBwOZDefezOLc
         HjJZRBEpqvw7FXDJ30Qmz/YczlxTVTJFLEGJoqOI7ZjN3bY5D+bhhiUnC1gSB4yKf2Ey
         2OJ0Wt3yobB61FHsRW/JB/6hlrzK+eq6Y047bxHj/0RToN34Xab4ScVEM+9DE4Us6RtA
         nqJhE4a72LuJT0Sf1MQIDlZCdSlRxETNI+VklYognkuUdf+bR6tP6BdpZ1yvvdHYO/8g
         6jZA==
X-Forwarded-Encrypted: i=1; AFNElJ/J5XI/k5PSCrS7Hfndps8rcOU3ribqI1XA+bl1BFYoRaogG63eRIXdWN+AoI6RJEFL0O+MRLQixL3DeLVh@vger.kernel.org
X-Gm-Message-State: AOJu0YyoV7MLb/u59sudIKz0LhpuYP60hsOXs85mmAlPZy7TDaNQqKW8
	6RjX6CJpEWW0W6Z65GeRru1KF//ftncDc1YEmudCKJQ9IBOt6wVs2UueG5HpnCJd3w==
X-Gm-Gg: Acq92OERX3lMoSoPJi2OGVnuLgzmSJWBAupq/THqs6EbLzwI9rEVnNyicUi5TjOXgGW
	yKE/9XcLYuuBTZePJI/6i9jlCRGxA3zqjdlvTFzbbuuC4KQimAT5EkEOdoOVgJrmy9O6lrk2E5i
	+zWtnUlCKBgcjpOmtZIVSY/bW5NOKBtAfzOqTlBNqRPZWQcx2Ds8M4TCqlXC7pOmxw/B/Xbvrn5
	aFjAdSXfbaGKEEGda0/w/6J2YbiAwpFmVczYlTgGgNIN1anqcNFTAyfoFFRP9obQ40nKDB2R2yu
	Y9kXMSPZ1DHs+rD/LIHZZ9D5zDRT/hs7ZfrfIyPM8TIxkx3tOIYNhkd6p/sa7cWQAxxEgg3b9gj
	Daionzv92qM87OCztmUP9q+8/RcLm9CGXKWTKTPw9t2u/QvDbSFxZXlzmaraA8m7tqEOl0uKohF
	m2m47YfPKgN/fC/jbcSzKI/WkrZfWdfQIlJao0yVx8V/NaIJmvq7DHeVM2gyeIS6pDc0GwWVKV
X-Received: by 2002:a05:600c:1716:b0:477:86fd:fb49 with SMTP id 5b1f17b1804b1-48ffa5f3d4amr2992925e9.10.1779199221326;
        Tue, 19 May 2026 07:00:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c208:c046:d3db:6b00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm46180982f8f.22.2026.05.19.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:00:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:00:09 +0200
Subject: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
X-B4-Tracking: v=1; b=H4sIAOhsDGoC/x3MQQqAIBBA0avIrBtIU6muEi3EJptNiVIE4t2Tl
 m/xf4FMiSnDLAokejjzdTbIToA/3BkIeWsG1SvbGznhfmfCjRNGF8g7fxAOo3JGS21HZaGFMdH
 O7z9d1lo/XBar62QAAAA=
X-Change-ID: 20260519-fuse-dir-pagecache-382a54146826
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779199217; l=1640;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=rh00+8CkvhUf5L5qQeiUYys/cEAiNnU8gZcvDzmdR6Q=;
 b=iDn1y5baDHzNvdkad7LwoFZexvVnhokCz3wZmVRWkO3YZ/cefv06OcAjXDIHSHk5PIdC4bnRE
 j+yMRcD4jwUBgSgS0h/GxU3cJYSDlnJPBWa/Cz7HWvazYB4u/r7tRmW
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
FUSE daemon to actively write/read pagecache contents.

For directories with FOPEN_CACHE_DIR, the pagecache is used as
kernel-internal cache storage, and userspace is not supposed to have
direct access to this cache - in particular, fuse_parse_cache() will hit
WARN_ON() if the cache contains bogus data.

Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
-EINVAL.

Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/fuse/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..7096f53d335c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1793,6 +1793,10 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (S_ISDIR(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
@@ -1966,7 +1970,10 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (S_ISDIR(inode->i_mode))
+			err = -EINVAL;
+		else
+			err = fuse_retrieve(fm, inode, &outarg);
 		iput(inode);
 	}
 	up_read(&fc->killsb);

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-fuse-dir-pagecache-382a54146826

--  
Jann Horn <jannh@google.com>

