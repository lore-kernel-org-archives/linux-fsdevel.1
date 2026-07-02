Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E1309F1C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970105; cv=none; b=Dt9uFzFATVJITeJKSW9MAHHISKzoJ4rS9Jvos16nFcW3jyVHklnXGulhbvbpPM3euEMYP0cRsmiMnSxDebaqNhXFLZP6ZVE25YsGZyW+OnEy3MjQnHJujEV/DZ3FPJzjGEOAYD8hWtgo4Qf3lB6lVpyWcne+6//xJFZLEoS9fkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970105; c=relaxed/simple;
	bh=lQtmVLwNBWkxqTLg9tYuRhH2hUW+InGrLu4tIiTeJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uC5pHutg2HJLjp/XfmG3ZrnYwczoXNT9L8G9lAbpZQ+XkLy7X6a7fj8nzJ1+avjnl+wUXJnPmUNzXn3TAx8JBPPa0U1dURkijPIojmRdl7KdYr0AwRUcKijeLNv1g0omQBEoRusnWtonmv2VGS674bA7baUORj2GkwrSRGO9sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snhI8/wF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snhI8/wF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-847d1e9db22so253817b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970102; x=1783574902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNtTOoShZvK//y8UxKZL0ixNJ3K6se2hU6GGK++MvJ4=;
        b=snhI8/wFoxITKV/AswQwuGIlO8dorqG1d/xGcp69/rTJog3QYEjb9e1jpI4h+GHFob
         D2VCdR507mNQtAlGsqw2Sq9MFexnJjGrtFizQpFNZGTiiiz7MLsueKhgMYBCgVDfmtuM
         uDLo9vrWeTXO1hTck7wU7wflc7V/hh6aYojHVaA3Bi7bqf7o6ULwGmJbocHYZdYraRbw
         3unaHoF6Q3uHznIRG56NDhBuI37E479KUhUlx/FtSy38QbWOZrzpbhpVdJjQ9Q9oN/EZ
         NlJixdH4WpAzJ7I4YnOkQGvq5AhtLGFJkiVDkUeCiG3KU6nNW5IWMlx4tYdKRfN/xqNg
         ppGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970102; x=1783574902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNtTOoShZvK//y8UxKZL0ixNJ3K6se2hU6GGK++MvJ4=;
        b=Tf/zzFtYLAYcVnSIN6DUTgc+yWHJq0/BSh4tsiGMVLyVZ+20ABMnQAfbMsbIhwqjPV
         XLOqlnyo6Mn8bDGTO9GrlhbNjuN0lHKLwg5FJ+LRwj9loYFvMrSxaJ3bgg7snfLxMHCH
         Uunn3SNuapHJPA1hBd+s2MmZZsSvc/n0i1oeuuunIn8+/njoV5lqfHLZd/7JVTpSJdl6
         fbteJNsCFuvP/BOakeTQn4tsWq3rhN4+3yV15bSMmwHZP6Zck2PlBsLvBVKU08EoJZkG
         SwbvNlUBfWtr4cqAZklWb6o09ALe7pwj/f+sBzPVAFJQkWiJ1EnVQAHjIDIYs2SnUoUG
         a03Q==
X-Forwarded-Encrypted: i=1; AHgh+RpS5q8mMqHAX0dC86WMKEIHHL/eFhhSUvdUbPmpUiTNNMwUIIockmsYegf4DTTFzPBQ5hyT0fj7NqLpxAKQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44qyS6QPdiDhPPankO9r8Rjpds2Qx1lZcGX2f9LhKefk0e0R4
	ZZWR7tt6FRfhBO0EErNj0xM1Ye4efN7SWb4MQPH1qn1vEvMl3A2DMTb0sijhKtiH
X-Gm-Gg: AfdE7cnNV42uTEQ+C9jXFhYKKuiTED9SwAcdzVpwtx74L9E+A+a9fiST4ttrMClQ9H/
	/bZA4aATA71mh2PAVV9kBFYIO/U72XzT+mngB27eZLMWoBffeyuu4VVWk4N+yBxJJlxk6L0POqs
	UUihxKCrS0Gb6GqTpxGKnTGetUTnk2+yCBNgK3J0rDL/k4R541OyVsZF3d6Cnh/CQRxj+rFRMwY
	zffLxRUs0Tqzff9Mgp0eGrTZD5bbmlMLOfk+6ueF5k3U5AR6qen0A3JRU8XtvgXgxANP+92klcp
	eCGm5gb17IEej2Vo3KjTlRYHSu9tV4AOWOYOOnrsv/4uxERPtXCZEEb9r1kxTgHi9D93FdH9/kS
	aL6gKw4ovVWKIfYAzpd9X2gC4hmz1Akr7WMgo4EPYkk4wRZ02dMBIDghhjnTLnNf1OLOUM1cbwp
	QtlLBsDnz5Rg0LsUaEYpo=
X-Received: by 2002:a05:6a00:420d:b0:846:2f5c:dc39 with SMTP id d2e1a72fcca58-847c0a39468mr4467510b3a.42.1782970102017;
        Wed, 01 Jul 2026 22:28:22 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9b0b77sm743988b3a.49.2026.07.01.22.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:28:21 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: avoid self-deadlock during inode eviction
Date: Thu,  2 Jul 2026 14:28:16 +0900
Message-ID: <20260702-fix-deadlock-inode-eviction-v1-1-2abcfcdce38a@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=lQtmVLwNBWkxqTLg9tYuRhH2hUW+InGrLu4tIiTeJsg=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqRfZb1xOONQEM/MQ1tFcDodKhGDyHFFgnpbixU
 5WyrqG7D5KJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCakX2WwAKCRA08jD6945I
 0+WtD/wKP4CScyU+vBdYl77WdrTmrO0kY+QT6LWCkuZBoEprQI8JgiXpJRO7E6yMNSr42IuFyFb
 LdKG1veplaciU0Wd13DGvrWlbgU23WrCu3udCpTFZX40hz17J8PqsKm17RddSYqJTPVpUUbDwSv
 J2cjs7/04qfu2sv3MaTcihvsnoPXlBUZsGakxyCkUdcwu46V5DWS3smObNJn6CqcAtsgR2b/Mqm
 nkdVWfYJQ/FSWlc+JZrQZV0qYfG1DZUeFnWnaBa7Gbn5IWyH+++PIcOiZq99fBiL2hDUaKzLjxu
 DJ4A/atMvJpX1X56UCkra5aR7gSLK+cZXbbg87Zyb1hwghih6gyLESHjrJaV+XQURKeRigPLFnN
 6lVNbjlIGkxmjuLgelqkvumox2U++Qd7I4q5Lr44wlVHXe/ZmxgYT4pM+YR0Qrpnlw0tdgz/t0D
 lfRWAxd4+z8MIOUV9RSbL5edOZLkmry4UzWLX3+FPtqSnjIrpUoh7bifxccFXd5W/BNuRuSlvgr
 QoPdKQcLDqJvbsLn9qakoHjeVfReZ0EekHeUZBSBmLqDNYWdOcs9WRYIMIAiH1jfeOChgl3lalc
 hBKnE6xAXzeWVgVsalM1w6F06LR57Pzh14vdVT+FyS0KmyR2H88rd8c18KA6jO9MXWS7gLD+UWm tAk60MHz+wfpEGg==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

An attribute-list update performed while allocating clusters can drop the
last reference to the temporary attribute inode. Evicting that inode
drops its reference to the base inode and can invoke ntfs_drop_big_inode()
for the base inode from within the base inode's own writeback path.

If the base inode is unlinked, ntfs_drop_big_inode() calls
truncate_setsize(), which waits for the inode's folio writeback to
complete. The same writeback worker is responsible for completing that
writeback, so it waits for itself indefinitely.

Prevent this self-deadlock by grabbing a reference to the base inode at the
beginning of ntfs_writepages() and releasing it at the end of the function.
This defers eviction until all bios have been submitted, allowing the wait
for folio writeback to complete safely.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/aops.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad165..88e5b2def66c 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -251,6 +251,8 @@ static int ntfs_writepages(struct address_space *mapping,
 		.wbc		= wbc,
 		.ops		= &ntfs_writeback_ops,
 	};
+	bool need_iput = false;
+	int ret;
 
 	if (NVolShutdown(ni->vol))
 		return -EIO;
@@ -267,7 +269,20 @@ static int ntfs_writepages(struct address_space *mapping,
 		return -EOPNOTSUPP;
 	}
 
-	return iomap_writepages(&wpc);
+	/*
+	 * Prevent eviction in writeback to avoid deadlock in
+	 * ntfs_drop_big_inode().
+	 */
+	if ((ni->type == AT_DATA || ni->type == AT_INDEX_ALLOCATION) &&
+	    igrab(inode))
+		need_iput = true;
+
+	ret = iomap_writepages(&wpc);
+
+	if (need_iput)
+		iput(inode);
+
+	return ret;
 }
 
 static int ntfs_swap_activate(struct swap_info_struct *sis,

---
base-commit: ec050fc4cf17d341e08c8e25dd9dd6af37bb2e67
change-id: 20260702-fix-deadlock-inode-eviction-086ee99bd59d

Best regards,
-- 
Thanks,
Hyunchul

