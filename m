Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762A225A38
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742112; cv=none; b=C2LbxCSaeLEub/wjv6xlfw4ipX7U0SBdlop7Bzj2BQmbB8t3sSKZTxe2iSBdlHzCN6t9M6o56gOsksL+g99OmrQf94JXMg//EECzQr0H0cb2G6OGgzh7+/tBU2RIpn1mcgjq5huTWY294TCWpq4dPM56zfrm3Wdnogdwl6tLfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742112; c=relaxed/simple;
	bh=KlrsJ+xWx55By5AGQiDhl1NdRFnMonqmoIeuB7vdp5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z07deNiD7xZQY2Q2QMtSecqkDKjN1MtBawQnNbrQpHn/EgtWPpIBCcMLPSrNnAgIqIpIJ/yNYVHuwHKk4+iRdUFMTIq+3ICkhTw55FFUwm/8CXEshFNm8Ok9RTV2hQW3ZLZyTrNXJPpcrNSZCJJUk7JcRpN1QRcp65eF/vL/70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6I1ZE8V; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6I1ZE8V"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso2587036a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790742111; x=1791346911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lB7hyHSXLltAudB1hHTz2rUZpBJb7tlLLr+gvCXCEhQ=;
        b=M6I1ZE8VQEL0mOxpa2ldxq5B70o2L1x7Pjf8x2D+eKezNYulT74YXRWCsGqKX3FalI
         Lb2NfYn+L7VzRfazfa0lqwZ6C6FMLjoTvUC68md5tBQROsg3euwFmJx5vABJOQyRLlap
         YaUZp5Mg5WxOViPynjOZtJHcBbw5rZuRMhENz5CniMbqGEtYOWPLjqG3DY1VNi0rI0yx
         qITaw+sjlOiadPA5DZKe4VZS5W2uv/lSFH5zb3+Ekg9nonWmVhszr97zeTMnP+bsInbY
         onmpPFtOBN8Z2YePob1Idlvr337JVW5585XX7t/mdLk18ijM4i2XeV+etplUGUJz5r02
         AOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790742111; x=1791346911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lB7hyHSXLltAudB1hHTz2rUZpBJb7tlLLr+gvCXCEhQ=;
        b=keAmK6xMwag/G0eNDZOVVpVMQrTmfHJ637xvkWr5/bkEZFmDwiryH+qrcK2uLWUUc/
         i1+uv1c80mCvZqoAmp5a50n8IcseEaf3Q+odizorIUD5u7v36cVeao67Lb8A2rAAHsaL
         /onrJ7WSCeeFn6Aq/LuabvIIg6T5UttrjN4xCo6lCXW1/BVXHG2zSEyMhR2MovQZXkkg
         QThIEWArER5E6zqn+cbGUPSdXpOykHjzEWkyHdPQhPU3CCoMIgtY1NglGuHbt1SMkbZM
         AUGOMNyx6auoDEwlOFt0WhPc7cEgpIk0o85IyhQrOgSYSfnyiVNysiuHsOVpncfxf9TS
         Bdsg==
X-Forwarded-Encrypted: i=1; AKwUvBykVFwVD+iyR9y2zgRC2i71TKGmHD/ayrZdBopm94kRUg2tblfZtvhNa14htYkwq8CD/BMZ2sciiVwLJP+U@vger.kernel.org
X-Gm-Message-State: AFq9FYILyeMBNYYpl7flfdfzVLmRam8VOzTeaGiPxRldApWzagpQBvcl
	zw1HMKpz1FPIfy3rKqLMXF4r08vLrxSZSkymLihGCWe8wUKjitVM6zvx
X-Gm-Gg: AYBFou0qF+j1EGXcVcug3wLbQzp32P6bDcGRtzYx/z6qR+yOUtfIU+NN18P15o4tviY
	1P6IYaEThO2AKJd6cp4pxTSUWCZVYRppb+waEShqsmKXGCgwRbavLayuk2iiryA1O4x5B501PjY
	jMKLeeyp5ujuLfKaj7bJJbWV6OfxaGeB8BbTg//bpInVWlpJreM18Oxs5/Cw853mGDqOUv6rMZg
	mDjrm6OsgrxnZRhS9LlEbyO5gSDJ9m1ZxgAM02W7Fr/vSwpQDIuHX26pP/2RQuUUwU5d5fHetEj
	YGZoyjMglIz0mVmTR5U1x6h3VtrPWD3huoLJEQ+Q5ZU3EUsFZRJ6Um8AFZOvdD1Bb6Utqa2zRNR
	1+/d/1gN4ycKk4tYlN8gWIC6MNbeuD4sgSqhs/+LexATvz9VWA0epf2osL5fAJSunMvy7weX9nY
	cDPR0LUtnCBHkuEq954ISaA2OsuvC61bSorPaHuRgbI1ncozFBQJiNmULV2meU5chMFXheRhUlC
	O6ACBaEu3FHe8kN6E/8wa1arCd2g6n+OfOVRIhDTEYE93IZRq6vyGxwdiHyIEObUplaEbvZ2Omu
	nyE278uSMw==
X-Received: by 2002:a17:90b:1d4e:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a4d193d3bfmr194422a91.56.1790742110485;
        Tue, 29 Sep 2026 21:21:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cdf25c6csm857427a91.5.2026.09.29.21.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:21:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] isofs: bound empty directory blocks in isofs_read_level3_size()
Date: Wed, 30 Sep 2026 04:21:48 +0000
Message-ID: <20260930042148.169831-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_read_level3_size() walks the sections of a level-3 (multi-extent)
directory record and, on encountering a zero length byte (de_len == 0),
moves on to the next block without bound. A crafted image with a long run
of empty blocks between two sections of a multi-extent file can force the
walk to read every block to the end of the device.

Count empty blocks (de_len == 0 at offset == 0) towards the existing
100-section limit. Track empty_blocks in a separate variable from section
count 'i' rather than incrementing 'i' directly, because 'if (i == 1)'
records the start of the second section (ei->i_next_section_block/offset);
incrementing 'i' on empty blocks before the second section is read would
cause 'i' to jump past 1, leaving the next-section pointer uninitialized
(0) and reading past the first extent into unrelated disk data.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled using a crafted
ISO image containing 150 consecutive empty blocks between two extents:
on the unfixed kernel the loop reads all 150 blocks; whereas with this fix
applied, the loop aborts with "isofs_read_level3_size: More than 100 file
sections/empty blocks ?!?".

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Co-developed-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Document in code comment why empty_blocks is tracked separately from
  section count 'i' rather than incrementing 'i' directly (preserving
  the 'if (i == 1)' check for the second section pointer), answering Jan
  Kara's reviewer feedback.

Changes in v1:
- Combined section and empty-block bounds check into i + empty_blocks > 100.

 fs/isofs/inode.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 184350d2e6ad..d7b324029a1b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1173,6 +1173,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	struct buffer_head *bh = NULL;
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
+	int empty_blocks = 0;
 	int more_entries = 0;
 	struct iso_directory_record *tmpde = NULL;
 	struct iso_inode_info *ei = ISOFS_I(inode);
@@ -1200,6 +1201,17 @@ static int isofs_read_level3_size(struct inode *inode)
 		de_len = *(unsigned char *) de;

 		if (de_len == 0) {
+			/*
+			 * A zero length byte at the start of a block (offset == 0)
+			 * means the whole block is empty. Count that towards the
+			 * same 100 limit as file sections, or a chain of empty
+			 * blocks could be walked without bound.
+			 * Track empty_blocks separately from section count 'i'
+			 * so that 'if (i == 1)' correctly identifies the start of
+			 * the second section even if an empty block precedes it.
+			 */
+			if (offset == 0 && ++empty_blocks + i > 100)
+				goto out_toomany;
 			brelse(bh);
 			bh = NULL;
 			++block;
@@ -1241,7 +1253,7 @@ static int isofs_read_level3_size(struct inode *inode)
 		more_entries = de->flags[-high_sierra] & 0x80;

 		i++;
-		if (i > 100)
+		if (i + empty_blocks > 100)
 			goto out_toomany;
 	} while (more_entries);
 out:
@@ -1258,7 +1270,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	return -EIO;

 out_toomany:
-	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
+	printk(KERN_INFO "%s: More than 100 file sections/empty blocks ?!?, aborting...\n"
 		"isofs_read_level3_size: inode=%llu\n",
 		__func__, inode->i_ino);
 	goto out;
