Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353780;
	b=Zh06xtZBZHj5qjwmkbEfFLC4gxXmmy2Cc3CJ6GYEU7nRykvirTX/ssVtSMBRXvRNcwd+
	 ml4eTvHAKNwVidAwQIvqmR6oES60ePKZtd+Gh90Q9nDaiLZhy8aEUpLXj9ltJNsipT8Kh
	 mpr1KqvJag95qxMAC4SnGKX1qMrjhuYjEo69Fu8mlSXujPR+krEvCnOr+v1IiLbWTOjbK
	 YbUYdKqFkbiO0wo0/FJp99C+e4G8Mb9yxycnsVmsqod2y7Lm5SAB/Jgr5Zu9J7e8e+DeG
	 IW0WFXNPyoY/s6iLzptTTpFzC20ZxXpVJN0+4xduwgThkXkDxgHiDXPYmWufT2gx8dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DhyHXjqCuztb63PxZ1O7LhMFys3Q28OminyWGfw7Ef4=;
	b=W1n4onW90CioL8B1e5KPslm3izQQ7QGNTKXm+NZzBTk+AtvXqcYjDqGEzSRCilgFZHfM
	 OMqxChS7nDUDajffqLVoLveaUGCtewhqyFuc6dnybWJzeLKslMehzKUZpw4ACIBsbzauI
	 MINfdEvg1TAQlV26027u4+vm9vq/s7pSmLw7ajrjSuzZ4iHE1dqXFrAxqQF2nWAHa+QWr
	 D7IIu151ajpKyppQh0qAdsBBO7kQfh3AgX0+OkOvcufAuVorTcB1EE9tSXYBMkvgES4pZ
	 D1jeEcUWgBxdwuUiKKY8wHIX27179k+PwHP1a4S9Li56csL4xRgTUZlvujGv0e3c5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bMBAb0vA;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29660A2608
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB29660A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bMBAb0vA
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b33de9d2b1so21563357b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794353779; x=1794958579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhyHXjqCuztb63PxZ1O7LhMFys3Q28OminyWGfw7Ef4=;
        b=bMBAb0vAz941tkfnWeRA0uExGPe39wBJH6mluguoORT1xnehdUqqr6UWpfaiRH05Or
         DXFHTO3NFeF6S/t8/daPx/d75OTSMqHcAFP89QeqSSh8WLtpURCyh/kU3HyoIVpiioG+
         gk4fc7qV2HEjzCQ7TqjVNa4RS87dUZ8PGZvGDGr7bhWFuHwapQNLTpvct6xLp705UBA8
         QcmVWLNMU38K8PSGCfx4OSedpJhxxFHB+tZlCSgNkhiNEfoEZe3BK4MI8CkDFd3J8I/Z
         lylFWd0DTiEhWdLw+ahLNtzCQVKBJEGzNOnu1zHQenV35hlb60cEC4fvFx2XxlOtn9dI
         B4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353779; x=1794958579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DhyHXjqCuztb63PxZ1O7LhMFys3Q28OminyWGfw7Ef4=;
        b=ztJlnKiGugQft9DFqC2shcX23KMjkHXu5TQHQva+OyV9/5+yp8Me7lJq8Y3iiGVXpd
         deVNHiH6SZ5KQ3xCs6A8zsN/iFgFAXIOt1aJ7b6euhMiF0DDQy2ce0jXrebqqfoWNFHh
         5gc3StaekI0UdXcmUGaaoPDHNrjJkzh6o6NQayxl26jvLwZCagBgUU42zZwgXp30Fdso
         3e/N6nvxWkO1ISwIuEbfhHuhq24p01d8oQjUJeXvL0L2kaRI/LLka95rTlWgI4Y0NXZN
         o4qB+dd1B6kPso0xrtRfPADaA+4NSvLDmMy1QfHz2QVWtlKZsQIWltPwedKRW2JoP26b
         Mxpw==
X-Gm-Message-State: APuU4Z9AGNbJEpeDFSRXmljBgMtAYflrqZpQ5J9decP7u/zJFQd9Fyw4
	RPQOqIHToF3vF2TWvMSqUGDhe6+4M8uW2vFM555oqOtPWcP5BsYNb26on3LQfZGjQHE=
X-Gm-Gg: AYBFou108gQ4Ne53/4lytIxyWM+BRPZhVGhTrv1YviYEe8t9708pvUSapTdWbIRJ0Z2
	ig8fps75lFfA5rxcKmfb+jHmJ6ZzRvQ0rotRgA8IGJHUkftJalC3h8tldD5IjBqbYzMcsQVJpz9
	XBZk4mWaKvKviuVeOj0emA25oE6ZPnk9ctBd19eZuTVhGUQZlTjxV621ZMWrSRmPJAr+yJze24A
	cFS7+h+NZ/hdBCEpJRU/+A8+EmVb3XBtQB01MZ1qogk8bFCxWwH8CLYJ/3P6Sx5n4PUnHXR/k4K
	ao/POtMTFu7INlrWT/rxuE6S6KiEH2i3svfAUAJaSLHbGXQfM40SH6PSeVsXdBS8U8lo7gJfzNy
	5bGca5Ihe9ueTCrc6Twfg+P1qVcqb+2IWo8CRFmWJjMdHrNtCTyRywYOD7K6SuBUveX55izf/Lf
	5pQ7cOpSQeeHNp/XkdQZOMaT0x3d8glxpedpwaXyP+Ph8jXzGVcrXIu+pVYjqa9Wlf3U++Jw4mf
	IHHeckZkpcvlSM7k3rnjDBiNnuoJytvZZPiLcAZCa2uMTdV1qfpPlJ3CXGzzp/3YWLq360ELW7l
	b3oUZeoQOfOQ0FA8ZO9MLqYmVhMuqYXc2mT9v0tUHFU4kIK8tAIlTQuNc8/GhtlHfGygvH2y193
	C6C61F1SX6t7PEKek71Z8jHl4kC2zKJrW/wxCZDzKKimZ6HlwpNsqXYRXuFTybhdf1n5kIf4=
X-Received: by 2002:a05:690c:e14f:b0:8b3:3a68:f3af with SMTP id 00721157ae682-8b3a805e8c7mr3541447b3.23.1794353778972;
        Tue, 10 Nov 2026 15:36:18 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1541:987e:e160:f038])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d1047sm31652577b3.19.2026.11.10.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:36:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/2] hfs: release preallocated blocks in hfs_file_truncate()
Date: Tue, 10 Nov 2026 15:36:09 -0800
Message-ID: <20261110233609.561557-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110233609.561557-1-slava@dubeyko.com>
References: <20261110233609.561557-1-slava@dubeyko.com>
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

hfs_get_block() extends a fork through hfs_extend_file(),
which allocates whole clumps. Also, hfs_inode_read_fork()
initializes alloc_blocks from the on-disk physical EOF,
while i_size and phys_size are set to the logical EOF.
As a result, alloc_blocks can be ahead of the number of
blocks really needed to hold i_size, even when phys_size
matches i_size.

hfs_file_truncate() returns early whenever i_size equals
phys_size, before it compares the required block count with
alloc_blocks. So, for example, a file whose size is aligned
on the block size keeps its clump preallocation after the
last close. Moreover, hfs_cat_delete() does not free the data
fork and relies on hfs_delete_inode() truncating the file to
zero size. If a file has zero logical size but allocated
blocks, the early return skips the truncation, and its blocks
remain marked as used in the volume bitmap after the file has
been deleted.

Compute the required block count first and return early only
when neither the size nor the allocation needs to be trimmed.
This keeps the intent of the original early return of not
dirtying an unchanged inode. The existing logic further down
already handles the case of blk_cnt being equal to alloc_blocks.

Fixes: f76d28d235cf ("[PATCH] hfs: don't dirty unchanged inode")
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/extent.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 26357086517f..42231618f3f1 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -507,11 +507,20 @@ void hfs_file_truncate(struct inode *inode)
 		if (res)
 			inode->i_size = HFS_I(inode)->phys_size;
 		return;
-	} else if (inode->i_size == HFS_I(inode)->phys_size)
-		return;
+	}
+
 	size = inode->i_size + HFS_SB(sb)->alloc_blksz - 1;
 	blk_cnt = size / HFS_SB(sb)->alloc_blksz;
 	alloc_cnt = HFS_I(inode)->alloc_blocks;
+
+	/*
+	 * hfs_extend_file() allocates whole clumps, so alloc_blocks can
+	 * be ahead of phys_size even when phys_size matches i_size. Return
+	 * early only if neither the size nor the allocation needs trimming.
+	 */
+	if (inode->i_size == HFS_I(inode)->phys_size && blk_cnt == alloc_cnt)
+		return;
+
 	if (blk_cnt == alloc_cnt)
 		goto out;
 
-- 
2.43.0

