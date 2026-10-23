Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792723042;
	b=Usb5MlfM7ROJ4q2IcIPJdaqVDk1/4434tlLY2f/Fci1CXI5+VaJh0CQYDvbq91Y1/2Ma
	 hDi1s64PRgeDR46km65oAps9gmmmO+SP2a/jbBS8dhDxJk3rnYpL2ehI03ZViU9svJiOH
	 TWRW0Y4HOBK7FpmyUDwawxZ6ajIxzsb8ne++yDjFw8qiAX/Aj9KC2c1roQBhQe+tusg98
	 t5XGoTpsW5+rpy+qkfMsYt/DU8sBpP12KVc33L99okOoyvh3O/WMGnzoCFuUHrKEiFdgd
	 s3RrnrkX8e8758Y9l8SSI2/EDcf8xYgUKToTnANe9CU/GxfuVpuZB6soI5ZtrEGtCSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
	b=sFzdnIt5gv2iR1UoAWlHBEIVixZW3OceKDClPLI6BQdLrNXjBSyLcPK+Xg6RevZyeZuz
	 GuYASn734Z5WTc4khZ/pl1atA9RHqpc4H3in2Wp8Yxb6e2ThaQ5LrdO/r+eCfERBhtqN+
	 PbF36hgTP1l1BH39F5cGeDIk+oLNIq7BD1nmhM27pC7X3Qq3GgVm4h6+CallbXe0O41v8
	 pLKZh28+f+jSVOuyyliFVX4fl9ssfSSoX2WnB/CbDO/6GdGyRRYQkQ+XSnpB3rAmpXQgt
	 n5aiiMmoJcVao+3sFzUv41TjWhJ2QCCGXclzDx/q/Z7YyxgEw6Vn/NF+7s1eiDbMCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4+CJh4U;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7016606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 02:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7016606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4+CJh4U
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-868b3248b2cso331999b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 19:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792723041; x=1793327841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=H4+CJh4U/XQB1x17laGpiGn3y8Ag9afkIWxee4g/X2XMGCfrdKdT/k/gt/eXaxDIL6
         i0AIVO2H8yi0JT3FIz/rsEAOfW54qBSHsCz8Wee3VVBke67Myew2Nnj/WlnFlqboC/Tt
         xLywkMVz25Oe15lVOLS60TBP0hbWN483AozsjKkGSBlViCqjYPD4iUp3cOc/sRpylXDm
         8FWezW2khsT6RMSccathtrgnQeVykvydGXh0xt64Loa+9gD+jxaDLbfCM9H2SJTo9yq3
         Ic9pGGndhaKN3t3YU01nMNpRGse8hdcXuvQXExab8gYYvSHF0xIb4D2rXudkIpigU1H5
         NfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792723041; x=1793327841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=ys/r1xkmB8vnmLamrsDcarXbSa/nggp1xflyRf9pM/N4bcZNzVyBbD0Gm0coyykPgi
         BA7z4htrIRxoPgPDXA4GJoxccsGwwrJrNK+WO0MB/Yvtl7+7yzh6IsF/UIXwcryhn/2C
         MAVGy+GWYsWcVrv3LzI2A93iy59kZFg+vmkHFQGQmb6fkGjdM1xHTG8nydeuk5UVPw51
         ivE7UNiQ4uftsK9mjkoGg+yusULeITC9NknEZsJ5AbIlPOW/daW0Qskk4dZ/Ge9g5qkm
         x52FbEfuL791AvK5V96LtQIF9jmsEWHEnaj9fY+U6u/mKGmR2V1bLG7nEh/miTb3pgzf
         6ldQ==
X-Gm-Message-State: AFq9FYJNbbHsSqbAunz1WK8aprhBA7G/R9IYQ4I0B6Hb9EZZGLhnEKLS
	ndV/g0mejJU/ERwRuXTWA7r8UwfTFTl43KQBlsxgcuwLwwe2VOhbi3ojdwMqgdRn
X-Gm-Gg: AYBFou0Pg9O8m9pfCBmGLsOWL9K4q7Sm2KpKRqym7rUM/XHKMT4x3Cokar9icKH2rSW
	BBkhIqkD80bN6MMt8VGkWtnnFP6DANwdgsOr7iwe3uWtGiCuJsx0chELhZxUMIzSpZzrDVvc0oT
	oPiWAjv+xGCk9NjBnJkrRcw/Wma4xPl2+GOi9V1kz5rho2tkUIsFI1RKvKl9hCseFr5sOtmHzID
	fLYJLam3QWP6mSuqtk+DjpmhHVFECSVfCPUOGxe37VfS+r8FTUV/7pTdJ3HHIrQYxbW1FYM3tp+
	bYTdFldL/uWvPh3m6MjMc/cbvfa2d+zFVmrl4hZCzTc7V4IQpOjUA4MNJwvX1UBLmQ2rsJLCOnL
	scFVJ3Qyw+JNhz7J3ANpKk4JcpD4WRVLK2DCda2ZDfYdGEVKJjBWD0Z9d6tZb6CXlOdp8UKHDP8
	MOQSLL6jhR4zckDJ9DJamC2x7tdmkJilEF4zpGecitZOV6vVZsZn85NpdrfeuzqE0SYwUMBF/Ft
	O0PdEbwiIKHCSZRBnLzcWTlESk0GWzRO+TdMl6LFfL62HaAzxw=
X-Received: by 2002:a05:6a00:2d22:b0:8a2:b10c:faef with SMTP id d2e1a72fcca58-8a2c66b5aa5mr763722b3a.48.1792723041105;
        Thu, 22 Oct 2026 19:37:21 -0700 (PDT)
Received: from linux ([103.155.143.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c92f2a01sm189340b3a.46.2026.10.22.19.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 19:37:20 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
X-Google-Original-From: Hongyu Jin <hongyu.jin@unisoc.com>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: hongyu.jin.cn@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND PATCH] writeback: don't requeue inode already on b_dirty
Date: Fri, 23 Oct 2026 10:37:07 +0800
Message-ID: <20261023023707.263101-1-hongyu.jin@unisoc.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 846a3351ddfe ("writeback: Avoid skipping inode writeback"),
writeback_single_inode() calls redirty_tail_locked() for any inode left
dirty. When that inode is already on b_dirty and older than the newest
inode there, redirty_tail_locked() moves it to the head and stamps
dirtied_when with jiffies.

Append to an f2fs file so the i_size update puts it on DIRTY_META, and
dirty a newer inode before each checkpoint. Every 17s the checkpoint
syncs that file and redirty_tail_locked() stamps a new dirtied_when.
17s is shorter than the default 30s dirty_expire_interval, so kupdate
never expires it. Dirty pages pile up until writeback or fsync().

An inode that was I_DIRTY on entry is already on b_dirty, so only
redirty it if it was not. The b_dirty_time case fixed by commit
846a3351ddfe ("writeback: Avoid skipping inode writeback") enters without
I_DIRTY and is still handled.

Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 fs/fs-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..fb33a63710ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1898,6 +1898,7 @@ static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
 {
 	struct bdi_writeback *wb;
+	bool was_dirty;
 	int ret = 0;
 
 	spin_lock(&inode->i_lock);
@@ -1932,6 +1933,7 @@ static int writeback_single_inode(struct inode *inode,
 		    !(inode_state_read(inode) & I_METADATA_WRITEBACK))
 			goto out;
 	}
+	was_dirty = inode_state_read(inode) & I_DIRTY;
 	inode_state_set(inode, I_SYNC);
 	wbc_attach_and_unlock_inode(wbc, inode);
 
@@ -1954,7 +1956,7 @@ static int writeback_single_inode(struct inode *inode,
 		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
 		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
+			if ((inode_state_read(inode) & I_DIRTY) && !was_dirty)
 				redirty_tail_locked(inode, wb);
 			else if (inode_state_read(inode) & I_DIRTY_TIME) {
 				inode->dirtied_when = jiffies;
-- 
2.53.0

