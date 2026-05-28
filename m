Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E83AF664
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961309; cv=none; b=Z0FAHrBdSbNaxZHTAO9Hh+0NCyGtG8ApMnW/R0ing4fVwK++5zdEOYQX0aqfh5NzYlPUzAEVhBBJcGyUw+wq3s5QEjwAR7eJhbeVxEUymS9ichDoymSL+58LXHQwH1eFDnKyFQgpuLg1HHsaw+BBukuQxsn5jNkX8iehfRFfN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961309; c=relaxed/simple;
	bh=MUL158TIarDsv3txrX32xNfRGNKHiG1GhJq8gii1TLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMM0bf3qvP+S45/NQNvzVuaKQyLiBdKfG7ANfLNjF9kKpolBHllxkJoMkrFe8Q3SlIXvyeuB4S5pDi0Y52A7NMDGS022UQp0HtcgFT2nMJgSVoy/3p3ZN78vYlkZ7TgADho2MWKhFkqJ3jUNKkMuq+Me0QK5TUu0IFltkYzVVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso291810a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 02:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961307; x=1780566107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Va/8UHj/muCxXwz4cRtoHIipkT2i9Y/gR+pknqm6No=;
        b=GofuhjGH7xxf3SfY/LCDcmpeXJko9DbEUsc25vncVVzPtHupBvIyz3wtz4quiUO4Ix
         kznsR9BJAdd27YBg/u7HPcKACdPy8HP2iyA2UlWiNnT6JsgAwnqQUA37oB1lI/JU9Zz1
         4+gAC1O25RSsahf1WOXQtVFjHn3OYou0SGcWRxsUxcL8th8gIYhuUtOiGC83hL53wdit
         fl7j7XyDRDAU8JncyWKyl+vz3MjRYXPbPuAp2MUvtqEfMn5WpkOxtmuvGvHrFpErNayA
         tGo2v9sWib4TmuR/5tal6TVmyWxLcuF1urLY0jlpF3JqDVsATGpIYHc3ihY//1trvfOe
         ZBpA==
X-Forwarded-Encrypted: i=1; AFNElJ9494CQI/038rtIBSO1dg0V/tdBuED7STM44rDXtxmGSKCmq6OxWIz6IpvydNBY0TN2oR7Ls5gpNhI1ieJB@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSToBFK4Lp2dnlQh9WMYlvvVYlza6pN0y+LQo+97WAsWkpZTf
	NwR8snmN+M8DBQOBQII1xX+P8MicOyJ8BuNdlp4eJ5Elw8THvl7mqLC2
X-Gm-Gg: Acq92OHafNn97kdvuWKGZxpezeqyL0hiq113wsUqLo55EujkGaXriRQp4aSvJq4jbnQ
	UwQLkYpfeaMLjO0m1c8KsSRFoPeIqobaSg6HdmhPDBXoUmVwfxieLWL/X+Z/1UGTOpari8UVhu2
	M79Oo+LF2zbQJkmH5DKXy4gN0ObAKRJrqXUT/mmiiX827F+t6EcaGBgU0xOFn/tSlEmLrVsDbOs
	BnyK0KEM6PDM5BJ8IT8FVgp0txr32lHmwvg1TnLQiwwfj2ndus3SqxTqQZzUGlR0t8/i2ekDEYC
	hTJTvRWMgwFAocQpNAnGq7uqFOAe8VrdNq4nAmmeQStFQtSRS6AO4nmNCYseM6admCgc3ftsZuV
	MNEkNABRaNBNKo/0Shhks4Aea2/o2y2MXG1+RX4Z7ibz8NWu+DXHih3h2T+bhL1Doe/jpjFoDxq
	+D/oo9QILCrYqNrihrjyT8BmnDmlPj2o4csEaEdCQjKn7kvGqZ46Sisf0=
X-Received: by 2002:a05:6a20:d486:b0:3a8:7fb:ca0e with SMTP id adf61e73a8af0-3b328ce50f0mr28880426637.23.1779961307007;
        Thu, 28 May 2026 02:41:47 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70f1ed8sm5468915b3a.43.2026.05.28.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:41:46 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH -next] initramfs: Add CRC32 debugging mechanism for unpack failures
Date: Thu, 28 May 2026 17:41:37 +0800
Message-ID: <20260528094137.200674-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some motherboards report high probability unpack initramfs failed,
resulting in the system cannot start normally. The error is as follows:

[    9.400739][ 0] [   T11] Trying to unpack rootfs image as initramfs...
[    9.408430][ 5] [    T1] calling  register_arm64_panic_block+0x0/0x40 @ 1
[    9.417144][ 0] [   T11] Initramfs unpacking failed: junk at the end of compressed archive

Initramfs unpacking failures can be difficult to diagnose because it is
often unclear whether the initrd image was corrupted before unpacking or
whether the decompressor failed while processing a valid image.

Add an optional debugging mode that computes and prints a CRC32 checksum
of the external initrd before unpacking.

Comparing the CRC32 value across multiple boot attempts may help
distinguish between corrupted initrd contents and decompression failures.

This patch does not change the default boot behavior unless explicitly
enabled through the "initramfs_debug=1" kernel command-line parameter.

Co-developed-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 init/initramfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 20a18fcda48e..4809065aed29 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/umh.h>
 #include <linux/utime.h>
+#include <linux/crc32.h>
 
 #include <asm/byteorder.h>
 
@@ -30,6 +31,9 @@
 static __initdata bool csum_present;
 static __initdata u32 io_csum;
 
+static bool initramfs_debug;
+core_param(initramfs_debug, initramfs_debug, bool, 0400);
+
 static ssize_t __init xwrite(struct file *file, const unsigned char *p,
 		size_t count, loff_t *pos)
 {
@@ -716,6 +720,20 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
+/*
+ * Record a CRC32 checksum of the initrd contents for diagnostics.
+ */
+static void debug_initrd_crc32(const void *data, size_t len)
+{
+	u32 crc;
+
+	pr_info("initramfs: integrity diagnostics enabled\n");
+
+	crc = crc32_le(~0, data, len);
+
+	pr_info("initramfs: external initrd CRC32 checksum: %08x\n", crc);
+}
+
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
@@ -726,6 +744,10 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
 		goto done;
 
+	if (initramfs_debug)
+		debug_initrd_crc32((char *)initrd_start,
+				   initrd_end - initrd_start);
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 	else
-- 
2.43.0

