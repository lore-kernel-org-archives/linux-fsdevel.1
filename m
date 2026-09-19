Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FD394EBD
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856787; cv=none; b=NjW/WFrfHSYpHKlrddA+vK2ZIcLu1aBh04/d5uE7ON+ecynKBm4tJyyKGN9LqVCNf3i9d2SrEvyxmQJhhqcY5ecC7H6msyOOu3xale3l60eutr+ggq2ao0RfeOoMXVFvA2kqdvR+KrfML4m4Ravw/iDhPq6lCulW/m6rGdBL+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856787; c=relaxed/simple;
	bh=l+cZ5RnQezSJqBE/UyFFt7hxjbdQOSwBbQXYOdjohsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvDKNSbU/tZyvjUo92R/5ZIcdESg/Fb2IAlgpoKNcYakvVzZHow1n1qXHtpIOMaibqwjVtk/3kIkllkWnsGRozDEZH5kLf7YozSN/o7Ro+D1eQCZYetNtia3rw+bzafR7eECcsi4ufCdeNuS10fuHTN9QaWS4sAOavIA9/86Z7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TomsMDiA; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TomsMDiA"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c6so1640822b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856784; x=1790461584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SJTdXVhPRFNVOuFEoF0cnUAxxkqxs0nKM5uVJ7VwjD0=;
        b=TomsMDiAC/w6OOQW/s8+XG04BoWE5+lZLVMpXuzovAc4NIczIH9mOxFAZw97Pmp3JF
         TT5eTJ0lSf7ewhSJq4UXr4+GHkH+YDZYQWNXT2wCD9QVaj15vhWQEgTCU1aX8NUrQaGA
         +yjZcsMGAuaA6BFLzj3e1fBiJt0X4RxN6z/1F5aIG5DDZEme7uwHcwfKpeT+xvad4xQl
         gXQjO4WuCwqDvMo/VIwKcsqT4jBBJqkwyj/+8BQDAkK/Zktyt1Ngan7zMv3lCkT+rLB3
         B8YkvHUTHf/bqk3Jp/zG19KAwTNLWtquX4nkPDDh0ZRQoT9MiKvUlC9kmeIZm5FlpIwY
         6VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856784; x=1790461584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJTdXVhPRFNVOuFEoF0cnUAxxkqxs0nKM5uVJ7VwjD0=;
        b=nQl4XabBOQA03UaHMrfPWb/uvh7ZVbronIaBIDweeEZAssLQ2MwoOU4g6aF9dMHsJd
         XASTNZLIY+80MfVw91AEBJ3BHpSxIxrDYoebGxu2LQtK+NR7d/jfzgzpjUNAKLqX+BU9
         J/uPRYdNydh6zJiEYQ1OjDyZ9bp0kq+xe3/PehWU3pAd9qFJQlpdrW+yETZEEe7f/RlB
         xznqN/EPkNMbHS+O/+juxiTKPqQgRBPME2tzj3+aG2t9CgVE6xXWYZSFD0t138GCW2QW
         iAFSUeM5oyzVtbMe65zAYjL08lXb/UVTjUuboop/XxKCHAilHRtZXjCMTZ10UeDkoIcY
         LgUw==
X-Gm-Message-State: AFuF++nFYjYJPo7vBwCFP32FTZBkWENw/GZ1IN48Aka/9KX5FOoavfnt
	WuGFfiwLonJawGjY4QIzCmAc6QBYb90ybaXTAaB8Cw4JLUu5pPSmGcDQ
X-Gm-Gg: AYBFou1umXorlxzjd59I3I0nUlWlmKpYnYxwAnQ60UL+MpV+y69HwdS4Porsb4raUvx
	2fHox/PjE+e1vlOz7k2wh37n7QG5j5BrKMIi9f7JwRUU3Is1FI6o71ib/OyBKxXX13t/2QttKV9
	JNwoi2/51F+xJjr0fo7QJiNyLbFJtLBQy2PfmCmrxp4gtKKZawjXDCg7ePgW7A/i3KE4szbWW58
	T/cQLpee0TysIrUki8AZBs4Z2Evq43SBpi0zG1AZ7fGv7Hnh5Qk08aWpZGnCiqDmF861D15Jiev
	ed8nlsd1XQbSlCZz/dmaUbwmyb69lAOZqiDQTPoZjnxoz6THWBoZyCARDkz52AD8PHA6dMTRveN
	/IhmC2VSRlhi5UnpplCWZ9jwwS9sddmBmTMl0FwJ4k62wrK9HKvIziRfsPrbaOHIyZHouleeYXS
	g8F2yaX+41M8ahR5nx7GL5wt0H4kVhGjU2VcWThbblMtOMTDzRgiIjrwxdbVKFpQGhKWmlPnTZL
	cZwfF15elPqJK8qzR/q+ctRy2EEAmKNhNXRbzBKZ1IDMyltKBAbKEzCI5DZae/UwkE5+7DLHAlh
	3v9TSm+ian+x4UXdrxNT
X-Received: by 2002:a05:6300:278b:10b0:3dd:a196:53a8 with SMTP id adf61e73a8af0-3dda19654d7mr3108334637.74.1789856784240;
        Sat, 19 Sep 2026 15:26:24 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8bf29sm1346750a12.12.2026.09.19.15.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:23 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qnx4: validate xblk_num_xtnts and rootdir size in qnx4_block_map() and mount
Date: Sat, 19 Sep 2026 22:26:23 +0000
Message-ID: <20260919222623.3797296-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx4_block_map() and qnx4_fill_super() (fs/qnx4/inode.c), check that
xblk->xblk_num_xtnts is between 1 and QNX4_MAX_XTNTS_PER_XBLK (60),
return 0 instead of (unsigned long)-EIO on error, and validate the root
directory inode size on mount to prevent out-of-bounds reads past the
512-byte buffer_head.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 42fcd500fad2..f6eb08cac09b 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -104,12 +104,15 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 				bh = sb_bread(inode->i_sb, i_xblk - 1);
 				if ( !bh ) {
 					QNX4DEBUG((KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1));
-					return -EIO;
+					return 0;
 				}
 				xblk = (struct qnx4_xblk*)bh->b_data;
-				if ( memcmp( xblk->xblk_signature, "IamXblk", 7 ) ) {
+				if (memcmp(xblk->xblk_signature, "IamXblk", 7) ||
+				    xblk->xblk_num_xtnts == 0 ||
+				    xblk->xblk_num_xtnts > QNX4_MAX_XTNTS_PER_XBLK) {
 					QNX4DEBUG((KERN_ERR "qnx4: block at %ld is not a valid xtnt\n", qnx4_inode->i_xblk));
-					return -EIO;
+					brelse(bh);
+					return 0;
 				}
 			}
 			block = try_extent(&xblk->xblk_xtnts[ix], &offset);
