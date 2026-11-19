Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131683;
	b=fkaB9XiMirCcL5jjswDLYck7c+m4SWwxbpuVnJkZlPSrvRXP97qWUdXhn2yivn44L9cV
	 MlSQGSYUo5oM/k8oUFE2hujBrsSxla9L8bMvnxxCeGo0FFVhQNKDL3SQolFoj9p2GD5kJ
	 wS/M6Pk6Q1rf97SYmOF9xAnWMHApiDlYsENLPyuz7n54bB1BwT42Yv4K6lVy1yyP/uCKj
	 VlYJrmpMz9NmyC5NOlIIvUiKUBZ8EeiHqeZ6ktjOZNG43cYsN0eja3+ETfFr+KZy/52lA
	 DkaU4A4jehiqItD6Vulqi0dkbLWwRsXH1DBmTWXSFaDqlWWe2cAUm2TYa0/254mU+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/bBpAqV6vKIYvVAXxXWFQ3lwfUYXqc1KvZzM1h1nZSo=;
	b=YHSoDmLX7+RSZGZ+EWfaHIljP+tNyHTKEGbL/gDs6wJl/Nu/HKRyiU012/dSR1ngpDhW
	 K2UUH4zRG1e9xPYSwi6fEgQSsUxeKBwmUlYk929F4/jkk3Sy9jgWYGON/SOAkuYzHlDdP
	 FLXbHoHHbFG5IKGglbOgUhEttJs3z6r6Rqj/8ynfGd1X/Zw62nONCUW7Pkv75aEBMNoOS
	 PzGWVS1s8CZ4x4YsPuHzHhN5gWwwZxjmYYcfKkjwBztsttvXyFFAQ7mgDE1TeaNu7T6N8
	 W5P62NwNNFbcZFeZAf8q9Din2DMxr5LqzdMqE69Fiz+sNsuRPOzL8YF7/zzChjuWIZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=auFLyBTn;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3960A2638
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A3960A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=auFLyBTn
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db8985419so520450d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131682; x=1795736482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bBpAqV6vKIYvVAXxXWFQ3lwfUYXqc1KvZzM1h1nZSo=;
        b=auFLyBTnc+OU0Af5z2ALEYZwf+jLBIma9RB4NffGVhAWF64YbWiXh2L8BhkEttnzc5
         TGmfG7/5Eh2DAXYwmOWiuqqlNeCdtuJPeApkpm9S4f9oOuoNXvKA64puEIZkAXRoTgaC
         R6w43OfpNbaqrXXiBLmqpLkUpf0NOyElgB31YXPoYZEy3trjUoNakJfpZtCo8mZNxykq
         gHx8yP3ZTvW7Z9qqKdIfiTLB7PwKt3DcnVb1MEslTAJnhg2eSLHMfvxoLd7Lhv+1+eKw
         69WH7W+O5HLISkT1/EohyVQmRk0Hj7mqZ4LTsYmhl4lIew9jEqDZMZ7Mq8yoUGQy2fIX
         svrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131682; x=1795736482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bBpAqV6vKIYvVAXxXWFQ3lwfUYXqc1KvZzM1h1nZSo=;
        b=qOzzS/0HkU+JYOoi3NwXp+3bY4ezT9XjeXDIqomb1oxoWLdKdJZML/5NXJYZAItFgy
         J87gXKCGnDIEZ+TpRLrdQtMd6cMOFu52+DTA9zx6E0DI2i8YLfSpquMsIlJUMko0QuS7
         +mLcxJkvGCKO6iAwXCeb2KIOmsK5b8P/K9EyReoY09+RI7UHqtrkLqtXvMP2DpBtMmlc
         HfdaRCZwzcHE3v9JSi/wd5xgKePfDVpjYvpV+8Mlv0dWwmuei9RhLylYT4r2Ffr7XbdU
         WgeqkLeQA9NUP9k0+AjPMFOwAlwb/z/KpXM7O0ppI+Koh4E2+QVolhGw0gxD3cir7+tf
         Cwug==
X-Gm-Message-State: APuU4Z9Yr7w4UM21vfHLVeDbUZ9oLMoYZu/AzJhnQqu03kbhjL1OU/UK
	KO7CF45Tc+H98TgJYTXIy4DSQmWmHm7ovcGLw2HDdRXQm26ojalpuRo8nB3WsDeTnMQ=
X-Gm-Gg: AZFdTZd1iSS6q3v3VEVZh3gjqwBGpvw4MvuvkE3Unllv87WzUI/9Qpzaz+wfTGXUSHG
	Y7ZbIryvB0v7sos6iuvMophP8BYL7k5XhV+XF72v4B7sjWCJe15oItkZLELZ/EIn0TPGz6zCrwi
	3tN3RhW4tOk13F9+LOon2Pmdk+EI+1rIlJW0z4xHZztYzWKjHCgSL04ypkqeO3Hdz1yCk80sfKW
	6aN8xbKue7M2p9V3HqlZeiAGP2N5qNxR3hjlEYk/sZWdQ0OyWcrgIUgMBGx9+RRPPbElMFRmSvS
	Uwd3H9dtifomxtjtpNtZquST7WPe00zoUQLbvrZz2ZJC/Q1cXJe3Q49q6KtHWF5+DZqErxt6zWr
	C9Ixj5KkdBB1ivCoMq0bSn8YRukTbioZfG0NtPm9bz+dwvZ6hf3JrA82lCXsSFygX/HMcVCNp69
	3Oa4bR7Sxctp6jUecltV6eGjHevmIVj221Sa8tpNzdPpuOwoKL4jU9+VnawjKbkdod6pAjA0dsH
	qxlo3g5Y7JB/CpWVdOM/JsSwE6mBGY6GnXe10+6yqO1B4Ogy7svJ9/JiRB8XQnM0sxfOFltSW5U
	kI2M0U6Q4HXtD5UFUv+4dimMWXe1VSomZkRbXN1XPwlLNPrD9NTCKENrAuSYbEfCqdDZskeBxkQ
	lBUAEC/UECECGrOW/74D6JnIotXe9HFDsaRhXdgqNKQR4PFpkywJ7kkzxioVH7cckb0GcQ5A=
X-Received: by 2002:a05:690e:1489:b0:679:5bea:d3fb with SMTP id 956f58d0204a3-67df44ff2a3mr507091d50.98.1795131682495;
        Thu, 19 Nov 2026 15:41:22 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:22 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 5/5] hfsplus: name the constants of the allocation bitmap check
Date: Thu, 19 Nov 2026 15:41:12 -0800
Message-ID: <20261119234112.720963-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
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

hfsplus_file_extend() refuses to allocate when the allocation bitmap
has fewer than eight bits beyond the blocks in use, written as

  i_size * 8 < total_blocks - free_blocks + 8

where the first 8 is the number of bits per byte and the second one is
a margin. Use BITS_PER_BYTE for the first and a new constant,
HFSPLUS_ALLOC_BITMAP_SPARE_BITS, for the second, and name the two sides
of the comparison. The number of blocks in use plus the margin is now
computed in 64 bits, as the bitmap size already was; there is no other
functional change.

Tested on a KASAN and lockdep kernel: filling a volume whose allocation
file is exactly as large as the volume needs fails with -ENOSPC at 0
free blocks and fsck.hfsplus reports the volume as OK; generic/001,
002, 013, 075 and 112 pass.

cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/extents.c    | 9 +++++----
 fs/hfsplus/hfsplus_fs.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index da6ab85a64ae..f910699338e5 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -552,15 +552,16 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	struct super_block *sb = inode->i_sb;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	u64 bitmap_bits = (u64)sbi->alloc_file.inode->i_size * BITS_PER_BYTE;
+	u32 used_blocks = sbi->total_blocks - sbi->free_blocks;
 	u32 start, len, goal;
 	int res;
 
-	if (sbi->alloc_file.inode->i_size * 8 <
-	    sbi->total_blocks - sbi->free_blocks + 8) {
+	if (bitmap_bits < (u64)used_blocks + HFSPLUS_ALLOC_BITMAP_SPARE_BITS) {
 		/* extend alloc file */
 		pr_err_ratelimited("extend alloc file! (%llu,%u,%u)\n",
-				   sbi->alloc_file.inode->i_size * 8,
-				   sbi->total_blocks, sbi->free_blocks);
+				   bitmap_bits, sbi->total_blocks,
+				   sbi->free_blocks);
 		return -ENOSPC;
 	}
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 9a304d946297..4f604c664cb9 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -120,6 +120,12 @@ struct hfsplus_alloc_file {
 	struct hfsplus_overflow_extents overflow;
 };
 
+/*
+ * Bits the allocation bitmap must have beyond the blocks in use for
+ * hfsplus_file_extend() to allocate more blocks.
+ */
+#define HFSPLUS_ALLOC_BITMAP_SPARE_BITS	8
+
 struct hfsplus_sb_info {
 	void *s_vhdr_buf;
 	struct hfsplus_vh *s_vhdr;
-- 
2.53.0

