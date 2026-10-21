Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568222;
	b=z3dIq/pQvMshmuMALzbZZjNSlFlGu6GourSaKW/LoM+WYK8+zBvyPEiLbTfSqUuNJBWV
	 3kiToTgF//dyn58Ogqqp7+/HeCHP/jvD+3ZnLbNuDLreSpUwMs8TtCMwE1k8Ty5G6FPSY
	 6PislwoO5ieHozaT/53USKcPclHIBjLmlksWG7OrQFdftFd/XCkYdfRdDLs7FLslAbqPT
	 GNdC7gjcJEAG6Xw3Cd+NcEdDz4sdi3w60ZP3nf+1pwKksnACQhVdPIAaxC3Qvto9rP1Dp
	 pUT2z362Qm6NN9MJG8As/G04lRfBKAa9sCz5TOxEC2GgE/+gteAERhWfAIH8EFW6NDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
	b=ThTGAT5BomHlyY5qG9ZC7oTvVnMD4VQZTbv/41vKLVd3ECuHyRXRJHTvoYCuiRe8WSVB
	 6nv/AjYiqpFuaXD1S1orM2C8DdpObD0qedwb8Sv9O/fu7GraV5V4hKcvRX3pbHYYiYizs
	 mP9HBiGX/QuRRlWz+hoOeTiWWsGQ8LHzIWCVcRudKxK7/pqWAXcEQ/9bp80p3qVIVXI9I
	 nPMZT4wXAhibijNW6zYPUaIufi+pyNgOxC8+KeZQbuXLaP3pkWXCER1kZahvderjhobLx
	 S5A/N9PG8sB4LqwBWIXRMmj1oyKdmKoElXAtsf1864GmjZjLgvGFuvYkjJmu20BSZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gagodWgB;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2F606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 07:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B2F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gagodWgB
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06e79e152so186335b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792568221; x=1793173021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=gagodWgBrgFA2S7b38LrES3z1xTNxB2kePPhg4Th6LZJTOssH549Zk5x5ny88HFah+
         vKG9FKZnV8i0jqsHU6lhMf/+/L7XD3H8SwpN8IxefAD+LvQUGLoPK0PdLIz48F3Yqt+l
         dviCyu+7XfHzDAMgm2o1wULlGbFcv1pkVmalVRV1I4HdlY/B24YAu4pGy3DRbr+SDDtw
         QgK+bPW41dChCJRH+4c/gPi3g8B4g1ADLu3qF8/wAaFv7qxfbx0leJLPa0IbFlcKP/cJ
         NRHHvV5Tv7rsylfBuURyLghW2AIfF1efHWFM1r7lx1h8G8e6d2ipA8VifrV7coTzD6Fy
         +BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568221; x=1793173021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=QuHSz24QS0HBDM/baDxhFDp+Z3HFqLMYxYmE1XI+IGptq4w+TUoOAHV2QzlWPYbeyi
         mhvJF6i4yBunIymCtd5OFdRgsixSxZOSbA3GuTx60jVPzFw3ynjitcGNs36udmzk8rkV
         01tJLuAfTNvgJUFALQupu2D7QA+GglbFEH8GdIjonAsYBy0Rlu5u4Datez7/swC/cWQN
         MI+3KjWtspRXhecXf53mwbImSxntAMHBQdh/zBfGYw0qjlcKsr4YBtVCLdrICO5MwkUz
         ast6Dxqo6Y/wP4m8sZf5ObJnszuxjgeQOb+o/pOgq+orP3K7DzZ/f20Zwtr/BbRsCHuA
         K3OA==
X-Gm-Message-State: AFq9FYJ85d90VTp1cD8vPsQtGm+KJxeqSf9dOCU9gunN//XRr2swOeXE
	lL6GyK3/bT9atVenVC+yLB+L/Ovsw9kQYb6Zqnj13I5/x6oa5bwU6iRiGfqVjg==
X-Gm-Gg: AYBFou3JsnYyXRZurWVrCqEhC1dUUfWQMrkaCDBNqQuI8A2HJc5HHSsYtgQxcaSVbuH
	X4oMK0jRYdkMw99EtyDjf5yQfqWfj+layUAVfHMU+6ZdDCvezBjw2ZA49UJl/UL3rYXcKRqWxaV
	uvp36B689R9jQS5WVIyxO2S63OElkUleIHCgKzXnOW6dLypu15ifBAvAuAqRnsrIioPxvdMmhJK
	+yn1brDmHg0npUBs/4VBDfG9ALJduDfu9ng10axhzKxJ/S+USqEs+dAB2VqbFhMY/SkjlnpKHZ9
	M8Ful0UcGEwkGE5rvUDaIoQyS53dqaSwanwj0ThFJqn2uzEYflrmdismV++u4J1JcFyhuaprGUz
	Fey1AMEuFPIzXFJkJtVlJWu+Ky6jqjr6zq04bS6OP+/OetIO1bRmHRrnqZRrcNEKpbOUwKl9gve
	XrkDjP2DC2vLNPze3+nFNUzu8fyFKA3R5hGSb/lC1vJiL62Ar8O5FqQFb6N67PNK3IVsTLUkt7v
	H6n1EHfDiRusdzue1HLs60XgQzkSw3FpSdt9ee4z+Jx7l+Hpd4=
X-Received: by 2002:a05:6a00:1c94:b0:8a0:20e0:b131 with SMTP id d2e1a72fcca58-8a089f250cemr919057b3a.19.1792568220671;
        Wed, 21 Oct 2026 00:37:00 -0700 (PDT)
Received: from linux ([103.155.143.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895dc12asm541962b3a.40.2026.10.21.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:37:00 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
X-Google-Original-From: Hongyu Jin <hongyu.jin@unisoc.com>
To: linux-fsdevel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com,
	hch@lst.de,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] writeback: don't requeue inode already on b_dirty
Date: Wed, 21 Oct 2026 15:36:34 +0800
Message-ID: <20261021073634.132369-1-hongyu.jin@unisoc.com>
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

