Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7713A63EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788565; cv=none; b=Z8Sxp39EI3gR5ZwCF0nolUCsNi9+NvfEcsKNZOGs77liiFLicLPM6HR98LgKJRDvtqd9JmK7jEXvkWhER+UTGqs95ZK65yKprAPqQQPDPVDpePorLV9v8JLNj7kpPBF9/vvXBtybXLQ/VTZWWTIHFyFpvQN8GavMD65jltoX+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788565; c=relaxed/simple;
	bh=8kG6UDkpQsUjb+G+QT2gaydD29/8OMk+TYhP9Jg0lpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dY2ifq7ATUjhoQX7gylU/7ozsX7MlIbIV/g4f9RAeKM4DJkzFHil/lVq0Uafzd1kBhlfBVGuZfRDUHBrmgxtPTDlhgGp6nO+I9VVf4TxV7/BwQ5BS7p6oFcniBpLKt8sLFoZ6KXRvMsuFHodLWoG4NsP5suEQ6vv0i8/CYEYAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FvnD8irq; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FvnD8irq"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6530287803cso10212984d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778788563; x=1779393363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVfV/rlRY1uPbYbkz9MJ3QfT0jcJ0WTrBEhtW5gEzk8=;
        b=FvnD8irqLIElW1co64WSp7keBWPGR0Q2Nec/9aBiHi8YVVHrSHpGy44MrOIUxaFpIB
         L/XEjnHqZNAOyog7lSKcwfWZpPyNsxyfk9mt5dIwLhbtfAeN5DPC3aQzpYMrhODTJskp
         GWx8par8tmvU5l18D2grf0n5cXHCAQg1vjU/f0JyFACY0fbhQ6vGnmZ4SGqyf61FuaTj
         ryaMLMozjl/jqIbvEcCd5Pqdd1cMVbGayqZxiGb1Wvv680/fnWhPH7BPPFlQLhxjkFGh
         Tc9QGy8Rp7bCj4CGX1b53ud2XQvP/6nTjJt+TYcPbZDDee9y8Vwqp9faK0SbJ0KVR71B
         dRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788563; x=1779393363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVfV/rlRY1uPbYbkz9MJ3QfT0jcJ0WTrBEhtW5gEzk8=;
        b=XXXASZRHnSwUJj8iRA2tUKMjk5Mqo+6/qjlht0PQqyd2y33Qx7xSZ7rtp+c0p64jqn
         7mqp6dRCmNGrjrjLw/hmS0y4IrbluyAfpHueqJEX/dwSzyLvTMjCCJXeVRMRTVgOQ0dp
         2P6pirw7c4/q+/h5Vc0I3Q6yqDjUQRi4DY/ptc0jpqZHwOknZ3JiA7rLuklQS/M5ymIF
         YumfVb0dNMabl2NQ7c6R/A+hv3aJg+u2flg6JUQBJx7jkJ4VV3qhiFdhHsAtAgRserxc
         8skWF4tUZE4ITFcfng7cpYA9PrATj3AH77Nnhni/XJ1u8sYWHVExRhUXjwiRb44kGpES
         /JNg==
X-Forwarded-Encrypted: i=1; AFNElJ+XJ2UhpxI2NSorLLAAcRhi3Sl3HeGjEE/Op6DEsTj/yvOTMd9aZnzPazQAsi3NneImwBKzMJBVbRvp+Euc@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSajcpRcI3KOT194s29IM2jLnccGeEMPy/5x3oZ8E+j22AW0l
	gcVrT2nhYkIotxt85lUn/4syaLAto1QuV5tgBIYdsTAUMTWkV9nxxLC+lzAHw1B5sZUb21ath2N
	C0xHos1Q=
X-Gm-Gg: Acq92OHxIDRT2RA3upYuFies39wKa+UIlt29R2LMwD8NoWN+ocJWvbjERGkPTWJpINp
	bxQZu9/P9hKBtAWJ5zeYj1+scOB+jalFEgWOX3TTd1P3QnmP/g6YadF2RxnxP86Dee8ZCnlm8/z
	7FsbpJMD01fvpKyuwWVv5dYRR1VCOZMYkhyYdoGAq8ixLUO0ZebaHW0E+yQNZrHxF0OHN0jNAhc
	no6yxKl49uwAYLzFkc1VjsOV1PkftdU+vjOZEN/mwKrlpHxEQ/z1IQVkJnLeZxqIXvjPmbIkZ8G
	avJi9LF+Kvz3LG4Kj5mU01Ln+CJF/zZyDvvWCp+/DIjkdfxqu6aUKX6UgU9YRGoLBJbHYIkSW65
	PYFfhaOBQp369EuYHH+Wol8Q8Z0FdOEXgXua9LXD66OFI2DXuoRJ7zW/WUSGk0Ie133ydmBHoV7
	fIyi0dAwB0qNUqh84X696h5ajzjvWVus98YE/MNqyJurzDGcaYbngSP+or9IyA2qZeTvyr1XiBf
	snKjCx3Yky5iVlJAHUu9g==
X-Received: by 2002:a05:690c:8d0c:b0:7bd:69b8:f2e5 with SMTP id 00721157ae682-7c95a56f98fmr9521497b3.3.1778788563221;
        Thu, 14 May 2026 12:56:03 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1475:85f:92c5:666])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f5c965c8sm18837587b3.46.2026.05.14.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:56:02 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix incorrect inode ID assignment in hfs_new_inode()
Date: Thu, 14 May 2026 12:55:19 -0700
Message-ID: <20260514195518.354108-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/003 reveals the HFS volume
corruption:

sudo ./check generic/003
FSTYP -- hfs
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #18 SMP PREEMPT_DYNAMIC Fri Mar 13 17:54:19 PDT 2026
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/003 51s ... _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent

sudo fsck.hfs -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
invalid MDB drNxtCNID
Master Directory Block needs minor repair
(1, 0)
Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking HFS volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The reason of corruption is incorrect value of drNxtCNID (next
CNID) in the MDB or superblock. The generic/003 test-case
creates several new inodes:

kernel: run fstests generic/003
hfs: hfs_mdb_get():179 next_id 16
hfs: hfs_mdb_get():179 next_id 16
hfs: hfs_new_inode():208 next_id 17
hfs: hfs_new_inode():208 next_id 18
hfs: hfs_mdb_commit():307 next_id 18
hfs: hfs_mdb_get():179 next_id 18
hfs: hfs_new_inode():208 next_id 19
hfs: hfs_new_inode():208 next_id 20
hfs_mdb_commit():307 next_id 20
hfs: hfs_mdb_get():179 next_id 20
hfs: hfs_new_inode():208 next_id 21
hfs: hfs_mdb_commit():307 next_id 21
hfs: hfs_mdb_get():179 next_id 21

The final assigned CNID was 21 but fsck correct it on 22.
It is possible to see that the reason of the issue is
incrementing the next_id value at first and assigning
already incremented value to the inode->i_ino:

struct inode *hfs_new_inode(...)
{
<skipped>

    next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
<skipped>
    inode->i_ino = (u32)next_id;

<skipped>
}

This patch fixes the issue by assigning the decremented
value to inode->i_ino.

Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..1cbba7345038 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -204,7 +204,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		pr_err("cannot create new inode: next CNID exceeds limit\n");
 		goto out_discard;
 	}
-	inode->i_ino = (u32)next_id;
+	inode->i_ino = (u32)next_id - 1;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-- 
2.43.0

