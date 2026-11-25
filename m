Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622173;
	b=Wl2x725wRqSzW3Q9x6oVDnGl2dSuhNrNqp40qu9bdSCd7vFj/AqtE3nMYf+6Wv39Yty8
	 bZ6dnat/bBOsuSIsDbvBD3RgRj95PCLf3UqnR3l1lZ2J2KE2R2Uzk3e+InvT4p1DitvxQ
	 ZpCD1obtpq+DdtVXYGM0HRSatqRCaMHTICXIR7MjidsoiKQMkwInlL0JIzmTSGwiRHGOQ
	 5jAIZ5cJ5Lbo7WAEK4hNcXPU1yRYkwt2Ai0oSk/Uqubx7ct3Vdi53NVfQcIL/AEfmX8vH
	 ha+DuPxJMPcnHbX4x6ggb+XpsdMBKYrmwOmaU8nJCxJjv4Pg9YrFa8kObJ29DZnjHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jx+9TpizadpQKBLHxL23KFlEYMCU+nwylP7180AvooA=;
	b=k8D1zi2c9ZyBwr8IvFSWfXghNhbSDb4JkUT22dYGmEdL5D+U30Q0VIy7Nfn7GvGtXGPO
	 Jyw71YujnRTFp2mw0SuWxKag5xWGA8hAxyxvP0X0QzK4Ak8AZc7D+estF8H7lm/T4mR9o
	 ctbQQiYLtxlT2GzSsbmdgMDAu5/pemqbsRZog7csi3GeZRK2tJbz/n5Tf+RZ3FjtwDkwR
	 dajar3r4iPH7fXqi9gNKp53HRjxOhw+Y7anGTYDUsOFsAv8uwOnmim2CQEF0lI/kGj6So
	 a15BKcvjl/aBG88RcOuB+K6OPr75uioZx27F7TjDGECXPVJOQNq9Y2YhRd0lzkIcnSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1aGW84S;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBC606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CBC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1aGW84S
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f04ad2c46dso36624665ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795622173; x=1796226973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jx+9TpizadpQKBLHxL23KFlEYMCU+nwylP7180AvooA=;
        b=q1aGW84SUiBzdEdeFr+avVY2LCrsH6fXhU5M5QqLXW2IWElBZeF2VPKvEYGdebnb5b
         VZynbb9QeI9TgvyZmIH2JL5Sxs2sP3Fwu4qRraJHphPKb1MuAqeV+zSy0Tn84M8kWK9m
         TZcNpewQGU8YHmkFgN4y8BdMfpSp23yRHzn+cxA0YWKwDiTLSriz0CGzIUIxJ3Snntoi
         e6QpUacKCKxEwS+KTNyCTfwQ1gv3owdTvCiJ9B/grFirDFHk0MEQDeTRC3uTCgYS8kKZ
         qgHCN+o433IqlfsOpkEm6xnTNAy8qiQKumh29nmhMfdU69UORKyhyKEmKgCS7RcDoofd
         KZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622173; x=1796226973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jx+9TpizadpQKBLHxL23KFlEYMCU+nwylP7180AvooA=;
        b=03uSV7M3/VlA15iZ7cXeAMlfXL79vwpJazpGv6X/jNKM2ib/+rZrLj1O35+rgkjz5Y
         csLYv8xa1ZWBNFVIBaJOupqkTr8IngxCXEUbEAvz0OSSdbLJtJ2SOJlnROW4xHdqOQCU
         IH34b/yqTyWcU0aIB1g9cJXhg1LplDr8FWTy4v9QE7Wio3WwsKg3vAzqnt33UUYbn42h
         oG8jOaa4YM1l02rAVloocOC5OYgkSczjFUDjw9tgyTZtiF4bqC2mmq7yXFIM9HDx/trH
         0pqiVpUsrKvMKrxlTwbCm1Hd4sv0Int7k6aHjsCEjnbUBHMYK+Re7DtRlSgivHKt/wME
         tmQQ==
X-Forwarded-Encrypted: i=1; AL+hErGXIa5ZKyb2qZJSm1ePWphBj+itGF1qWbelgq7Gsj866cyrHgYS30z3gPE9jvVH7nfg+hUAmYxxIRI18JGS@vger.kernel.org
X-Gm-Message-State: APuU4Z8fgOgGGkP6GYy+SvtLe7R9NQqEZWz8tcZ0LOv+SQMoKlcDcLSO
	3SnrPfWhyJbSS8NloL0A63E41kybEhvk5EkjzhP0yMkcfaOx7WlKxovf
X-Gm-Gg: AZFdTZce9qFi38kboM11jpYLfmxNdsSFd+IjJ/Epx8OdUd0mKyNG/lQv5fnjogy81hg
	g056u8n7cLCsj54F/jJFBIdFVRisG3ubVdJux9PagXqsU0s4GJabNS0xdjlsWki3T8+fbd+KGNP
	tV6VP82++PTJI2A5qFfVnV2n6tvCWHwEo0V5MryWCLpUz6+MMRwHW78ZZTWc9xO8EldkJFpRTVD
	8eBGE4KwkvwOculxifjtRpqPUEWFSOzyL9+C9Y7xLHmFy0sMWHn7t1kQ3n4TGz8JCwn7tHvM/V8
	1copVARHI+jQSeBylu0x3PMk2T++tdXvkxwym9Ew0Rmv//7ecWf7Y+TV6PzKfcnR9Zrb5Qjkeyf
	imVPq9az42xwdEQH/RoPMcJ9sZpSBYjmjHOGpWscetOL87CSmKp8qnl5LkfphFlOQ33V+bT0a20
	IhByn/skCbPV9ieCAgUlllTzGsC5jiQPLcYZFCbeFoVFI/pt4KE81YtGS2/yOHjcpM3OhQ4c4mQ
	H1LjqaDQoW7/VCL1JVObsoPBlegVEoKJy0cWDXMHejivlbfw5V9+X4nhZ86A47nj33EUmsupzBl
	tEPYLYANR8thQo0r0DcviVjlNwX+jEiSRIMMFBxjnpBy8ni21g==
X-Received: by 2002:a17:903:2a88:b0:2f0:4fa1:9661 with SMTP id d9443c01a7336-2f04fa19715mr153580775ad.18.1795622172893;
        Wed, 25 Nov 2026 07:56:12 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f147a9esm87467165ad.72.2026.11.25.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:56:12 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: validate logical volume partition map lengths before parsing
Date: Thu, 26 Nov 2026 00:56:07 +0900
Message-ID: <20261125155608.282719-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
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

udf_load_logicalvol() checks the aggregate partition map table length,
but uses each entry's unvalidated partitionMapLength to walk the table.
A truncated type-2 map near the end of a Logical Volume Descriptor can
contain the sparable partition identifier while its packetLength field
lies past the descriptor buffer. This causes a two-byte out-of-bounds
read in udf_load_sparable_map(), reported by KASAN in
udf_process_sequence().

Check that each map header fits in the remaining table and that its
declared length fits in the table and covers the fields for its type.
The 64-byte generic type-2 size covers the virtual, sparable, and
metadata partition map layouts. Report and reject truncated headers
and invalid map lengths before accessing type-specific fields. The
unchecked walk is present in the initial imported tree.

A custom LLM agent assisted with discovery and reproducer setup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
The malformed image uses a 4096-byte Logical Volume Descriptor with a
3656-byte partition map table and 16 maps. The last map begins at table
offset 3626 and declares a 30-byte type-2 sparable map. Its
packetLength field lies at descriptor byte 4106, past the end of the
4096-byte buffer. A second image declares a 3627-byte table, leaving
only one byte of the last map header inside the table.

On unmodified mainline 4dce97c6c265 with UDF and KASAN enabled, the
first image produced:

  BUG: KASAN: use-after-free in udf_process_sequence+0x3cfe/0x3f60
  Read of size 2 at addr ffff88807ffc000a by task busybox/57
  Call Trace:
    udf_process_sequence+0x3cfe/0x3f60
    udf_check_anchor_block+0x270/0x460
    udf_load_vrs+0x67b/0xde0
    udf_fill_super+0x778/0x19d0

The read crossed the descriptor boundary into an adjacent freed page;
that is why KASAN classified it as use-after-free. The mount failed
with EIO after the invalid packetLength was read. On patched mainline,
three boots rejected map length 30 at offset 3626 before that read;
three boots of the second image rejected the truncated header at the
same offset. Neither patched case produced a KASAN report. Valid UDF
and sparable UDF images mounted before and after the patch.

 fs/udf/super.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index a81a8509524a..41988a07b86b 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1580,9 +1580,29 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	     i < sbi->s_partitions && offset < table_len;
 	     i++, offset += gpm->partitionMapLength) {
 		struct udf_part_map *map = &sbi->s_partmaps[i];
+		unsigned int min_len;
+
+		if (table_len - offset < sizeof(*gpm)) {
+			udf_err(sb, "Truncated partition map header at offset %d\n",
+				offset);
+			ret = -EIO;
+			goto out_bh;
+		}
 		gpm = (struct genericPartitionMap *)
 				&(lvd->partitionMaps[offset]);
 		type = gpm->partitionMapType;
+		min_len = sizeof(*gpm);
+		if (type == 1)
+			min_len = sizeof(struct genericPartitionMap1);
+		else if (type == 2)
+			min_len = sizeof(struct genericPartitionMap2);
+		if (gpm->partitionMapLength < min_len ||
+		    gpm->partitionMapLength > table_len - offset) {
+			udf_err(sb, "Invalid partition map length %u at offset %d\n",
+				gpm->partitionMapLength, offset);
+			ret = -EIO;
+			goto out_bh;
+		}
 		if (type == 1) {
 			struct genericPartitionMap1 *gpm1 =
 				(struct genericPartitionMap1 *)gpm;

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

