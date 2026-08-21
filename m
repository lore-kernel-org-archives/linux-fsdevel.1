Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65B3F4856
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302501; cv=none; b=d82/JMp5sqp+TiNUfJUXm0rX9Du8DKBn039ZKIH6VxqMifeBcSoIAqATBiAt5w6IF4Htfx7A+9hdKzDHhdNoFLoQeqyyDqkDYud4NHiF1ZdiMBb26OZoLHoNFv9oKdjKzkmf/LuqeBmgcnVQvRcorim90W9QuvzfSUU+wDDXueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302501; c=relaxed/simple;
	bh=ZzXyLvXgNXKSd0Is+uAXDYIe209T0A4xpMCAhmt73Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pphXGR/cZ6Yj+MzT1MpEhqvmW8Y2jgN3h/PaSJnmmnA1oDj0GNNHbDT+gN/KB4F8IuRAGi6zdh3l13Q6DRtaV+4aB2dC8/bcTiewCA/b2AVXdTOU/3yZ/g8C84dqstxc3OEuslCix1eIOrsw53sbCuvaOrlCyPNpNO/hOYHl35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Y1n5Z+Dk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Y1n5Z+Dk"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a3fda88184so1392361a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1787302496; x=1787907296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVmSaJddfKw7maiY0Ul23B+CdDc5RGqdzGtXSntORqo=;
        b=Y1n5Z+DkV1VGE7fLQxlwhSOc8bQRRvOoCESiuCFCuSt1OenrZ+cw093cvE2RI59SA5
         +DiD5pSfJd0/5uMP2y9xBnTpRGqWkvwNOZ7aJ3XVkFteBc7DQndWMmKndT5nDTtQ1Peb
         1JDfpXgJnXLKUIeFMO0k55DYfFu4Y8sjKmoXOf5+R4WrYsbZ7yc1vxPq7ZM15yittMxm
         CViirIRluBDO+WkhBQ+00qN3gvgyAw1HONpXoaGPDDh2l+KqMaL/BaRAWET5moAi/tOi
         qbLHuBStdoQqeaIJeFNtbswkusoOsxBSkV1st+LFD0vSX3AnUB65t97m9VwVmnjFmW6d
         dkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302496; x=1787907296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVmSaJddfKw7maiY0Ul23B+CdDc5RGqdzGtXSntORqo=;
        b=onklTmXCCfEKgZe67zhQTmzi1y6HKk1VBcmltHJIKgqobwtneMQdZ4BgqyMGoU2YFv
         B5j8wFG8xXset3tubr7vZPEvqI6G9AVHPwIEv/P6WxraCUFdB5eeggvxJphptL4uE0Tm
         QNF0ONhsLni4ErhypWsCwVQf06eOYv0/vHauL0U7YkSk5Dbrv2DqNrwqq0N/iJxTGlt7
         fOwSFoL3CiQWL8LwH9eecV66KTD/621QM9gy9K+vbhGkRsTeFy4AU5d19hKCDqX4xkDA
         JKF+9eVy5MwgdT0N38O/35V7pLx0Oh9hpqKqrX9/Wm97AcZyjKCCm9148IjeSdeWhFad
         nqVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr03pJIp8YXfEp5WHGM7usRL8/f+mnD0pNPMyEb2w8qUee27Lhmrsn50SD51WVxwGcY4eWprlBABqUAqFhW@vger.kernel.org
X-Gm-Message-State: AFuF++m3SP3LRCqi043ZsXuFmWJDxAgJTK1EMXT0rX1VPycuMjoacnMm
	J09AQ0CapO+6/eJ37Y0zE22wVNnomDIHAM0X21WnQ6Sruwq46eP1o9YvzzAvQH/P8MgTcYs0h+V
	YO8h4l3I=
X-Gm-Gg: AR+sD12cX9Jj1u6ECpxQIFSMzCVcKxBrGiLKktQIHPBQvtAbJMTviOErAPt4LWkVh3d
	hRzfZy369Bw6nQCoV7U0ohbxfQM015/lK5WmyFajTJuLjfSQxnGefjyLY2hSHViWZqDKDhnVfZO
	/dKQ0GJblcBgbMLzTiO+f/hKZjfTMqqDPQMPW8yAMaVZwNSY5JVWOlkL9o7iBfZrw3TO2gouASr
	Xi0HAQhpX0Wf67Mv7cg7lBa44ncB9nMkvIv7XC5gsk5kB2HaiZ68dHmlgmr2C4psm0nJUba8FZj
	G85IrscDUyz1dGuuSMaiSn6TEhw91KHaJz5IDsXc3Gx4eflEZ764WKxNCapuqvpm9petiiiO0j4
	k4IB7cpvV19Gy4aHYtOGw2SX9AZbhHK6H9yvBHBGo004z4enr8n8hlulMQmsG1tj0wYx8l3z0hd
	SCa5BF2QplW5CN2Ly2OjnjwhQ6NtVJIYaVqIYDVh9UeKeg1RWVi7xtDHg0v1gyn9il5UkHaOIGV
	n1XurC0RF1POEJIk5E1t8wioynFhLPMZXnts8rP6g==
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a42f18a70cmr4367579a12.10.1787302496033;
        Fri, 21 Aug 2026 01:54:56 -0700 (PDT)
Received: from x1-carbon.home (212-197-167-60.hdsl.highway.telekom.at. [212.197.167.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9c9dsm5676008a12.4.2026.08.21.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:54:55 -0700 (PDT)
From: Moritz Tanner <moritz.tanner@linbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moritz Tanner <moritz.tanner@linbit.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs: don't return -EINVAL for successful nested thaw
Date: Fri, 21 Aug 2026 10:54:51 +0200
Message-ID: <20260821085451.65206-1-moritz.tanner@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7366f8b6fc6a ("fs: handle freezing from multiple devices")
replaced the freeze_holders bitmask with per-holder counters to allow
nested freezes. In the bitmask version, a thaw that released a shared
hold while another holder remained returned 0. Since the rework,
thaw_super_locked() drops the freeze reference via freeze_dec() but
then returns -EINVAL when other freezers remain, misinforming the
caller: the thaw did succeed, the superblock just stays frozen for the
remaining holders.

This breaks bdev-initiated freezing. When a filesystem is frozen with
FIFREEZE and additionally frozen via bdev_freeze() -- which nests by
design, see fs_bdev_freeze() -- the subsequent bdev_thaw() receives
-EINVAL from the holder op although its freeze reference was dropped,
and therefore keeps bd_fsfreeze_count elevated. Then device-mapper's
unlock_fs() ignores bdev_thaw()'s return value, so nothing rebalances
the count. After the user's FITHAW and umount, the block device can
never be mounted again:

    dm-1: Can't mount, blockdev is frozen

There is no way for userspace to drop the leaked count; only
destroying the block device (or a reboot) recovers the device.

Reproducer (any kernel since v6.8):

    dmsetup create dut --table "0 $(blockdev --getsz "$DEV") linear $DEV 0"
    mkfs.ext4 /dev/mapper/dut
    mount /dev/mapper/dut /mnt
    fsfreeze --freeze /mnt      # freeze_ucount == 1
    dmsetup suspend dut         # bd_fsfreeze_count == 1, ucount == 2
    dmsetup resume dut          # ucount 2 -> 1, but thaw_super()
                                # returns -EINVAL, so bdev_thaw()
                                # keeps bd_fsfreeze_count at 1
    fsfreeze --unfreeze /mnt    # filesystem thaws fine
    umount /mnt
    mount /dev/mapper/dut /mnt  # EBUSY, forever

The same happens with fsfreeze held across an LVM snapshot of the
origin volume.

fs_bdev_thaw()'s documentation already describes the intended
semantics: "If this function returns zero it doesn't mean that the
filesystem is unfrozen as it may have been frozen multiple times".
Restore them by returning 0 when a nested thaw drops its hold while
other freezers remain. Thawing without holding a freeze still fails
with -EINVAL as may_unfreeze() rejects that case before the reference
count is touched.

Fixes: 7366f8b6fc6a ("fs: handle freezing from multiple devices")
Cc: <stable@vger.kernel.org> # needs adjustments for < 6.17 (no may_unfreeze())
Signed-off-by: Moritz Tanner <moritz.tanner@linbit.com>
---
 fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 05e443173038..01db6124e409 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2369,11 +2369,14 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 		goto out_unlock;
 
 	/*
-	 * All freezers share a single active reference.
-	 * So just unlock in case there are any left.
+	 * All freezers share a single active reference. If other freezers
+	 * remain, drop our hold and report success; the superblock stays
+	 * frozen until the last holder thaws it.
 	 */
-	if (freeze_dec(sb, who))
+	if (freeze_dec(sb, who)) {
+		error = 0;
 		goto out_unlock;
+	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
-- 
2.55.0

