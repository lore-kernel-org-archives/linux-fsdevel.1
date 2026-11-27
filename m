Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739947;
	b=2Yt4XuHBhIusBCVgwPtBvNGTY9SCBJZXF2kFaWmPGZEH19mvAdcN+2TRYAIGmWB5inC9
	 IrI5YO7Hx2rCaCFWGNCE9xEy/eIydFC/no+dXUBSAGMGpuz0YV1X3qhg0+V3E5hmQuzAC
	 0vRkZ+mik0SukNcAQO86Cc3kl/Mh9Rq0NzxEDK6tamudxJRnKHIOgw31PeL22NQErvGsw
	 ojTQQXRET+0kD4RZ4msy0nlK1oLKAuCWIKyjaVrUBFC27ldQhZLHpj2tDA3lq8zv70LBh
	 Oae/PGdropi31dscjoymjsAniLp77fiC6tGhNUmiGhUmjrbnXKI5nqjmWpLCZC0xPRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OvwsNYV9K/LXXZpGZnFqU4JXKALJmJzA8uLyf3/RYp8=;
	b=ad4Vkvo6E4zezqiKXhIxSyNJFn6tQH43sXD4F8gUfHyn16GUUq3SufT6+LOXVpSjbLfq
	 xZD3ZeCCeqwc7xKqkyMaQwtlQopATmpOaouKbR1kUC55A5Sp2N9Jq74eu36P1DX1VqyHJ
	 le6HmJbOZ3BU7roHv2cP6rbM2q+d40wLuLLI438hOQ5xcsSJ+QRbKTyGFED9LCktFdcMt
	 NguqRDxQOctReSwEP+OiBQevcdL2ZrxtQ68UbPUbUcO6JAbZ4M4hs90XpL8p8xMntj8Ja
	 XMxU/0OTpe8VboCMKXQJyLvBdNLSsLUTALnfwCp4J60tVfODQLznecIBEOTwFM1RoDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HLkjDly;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C25606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HLkjDly
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-921318b2eb8so92315426d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795739946; x=1796344746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OvwsNYV9K/LXXZpGZnFqU4JXKALJmJzA8uLyf3/RYp8=;
        b=0HLkjDlyNv1L0j/syzitLwcg571pG03B3AT3w+IaHzH1wQN753d0d1Imvf6t6spOM5
         9iB74sWWyJCbFMZ5Jho0FRsyFBFB0PpvPBLcywajuZnsSSrvW2dMseU7Gclrb11dIdx9
         zy+eD8IKbTc+9GLLSM6zocvnZ3nkwPdIYT85vHAcIX2+V+8GxS0e6X/NEgmlBd750qd/
         URRT5rc8DmJyKAobSr1d/Ca9Dths9uOUUIljRDSI0dXQC9jtvkTw9yKq1NKPqc8vk0iF
         9YFKKc8u6m53mYmK+FTiMGYw80r0ofR12//5B3cy/YPutbtMP+GlrfECxk6Hq4rF7YWK
         oQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739946; x=1796344746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvwsNYV9K/LXXZpGZnFqU4JXKALJmJzA8uLyf3/RYp8=;
        b=i6ChmsRj2suP+5d3E1OqNOBQRvcp1dstFdUVr8dVlp/dubJmK/h+QKdXneHrmOgD/n
         o4aObqnptv/z2cqC2XeulxvqoSkvrhCQbPxvhaLTI8E1iZpaeYTo7mQSZEMSH/oEkv8c
         ymKRIbh3no2U2gJk/GC9IywO/nQvE8/eYnFxwb7PWnWTzP/13MjuFL4+YpiYZpQKQhr7
         acjxjWfQnF0wmXyc1jl+dkSo5ejHJ4aqeewQZp4pXO1Isvl9aqg60uCXbsCivejmVBbI
         6z/9W0N/XiZGHD+U+K/2D2h8D2jmxTi3tfMDkRsPpC273pW9KLXSZzcMsYX6wV9EBgh9
         HTfA==
X-Gm-Message-State: APuU4Z/fcEwt/GibqTw3/2KITis1P8P8ojB4GqEO3Dsqh7ThW8QgZSn1
	1Lm/OP3UBKq9EjQaGBcl1fVBxjVFEwbRs2ma11gTVbtbchVd05RdoaCv9Ds1K3of9FQ1Gw==
X-Gm-Gg: AZFdTZdOzjZUY+uP5l9UjNcGCWS+XaiS1lZBv2GKMTOmVEoN0QqZ4MDeaCfGRbVQyYh
	SULachi/D2/G8uBNoCMhGskSpzFLlRej8+8nsyVQF5DTnj9r18mSAmE6IepHF86Hjba4ut/955t
	/pCiXnghUe/6KVjYN1X8YRpXeaYiF0Qg2USjzFK+e+9yXUIjPkp1OIH+dcwqIL0cqOaTlfvnLfs
	0m4YQ0J4CL+2L+uA+wM/bCTTbFm0MT7TbSP7MSTmEoN7Kip6ZcsOhq6PyTXc5WrwAHZFNNSezC7
	EZOGglVXSn8Wh2JR5f+6jPXZTQV/yU5CMJgjxRDpsZsMpclRyZlCUh6p3V6LCewmqeGiV7xBvYH
	j+pIpOYK/g6eHwj2s/BHcGX+Kx2NSsuRKtp+MntzReJbvjsHKIEVcQ7YP7l1bN1EhRAe1CqbtrG
	3z9epTceXObfk/OoxpxaoPk2RACAVvpvsfRvqrvcd9dhPQ0uUjL5eknjPGbINM2p+kG7gF/KI4g
	QjWxXSodTHN9vLBRAZQ2HY0EUfzh/ZqZPI2RsQeEixf7eK/JztVRelBfVjQ6qK7hRwczLPYoTQI
	ZvkezuF75/bYxDDg9BCz9UUDO2p4zMoZlrzAkoaUx0SlSQLBhk7J0bUX+GPOG9N8FNCY31u4xMP
	CKivHNMlH99wmPDcBSE5RTzx2sQ==
X-Received: by 2002:a05:6214:3bc9:b0:921:89a9:d5c4 with SMTP id 6a1803df08f44-92189a9d8cdmr68634676d6.11.1795739945651;
        Thu, 26 Nov 2026 16:39:05 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a058aasm200373866d6.33.2026.11.26.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:39:05 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH] fs: tolerate an unfrozen superblock in the block-layer thaw
Date: Fri, 27 Nov 2026 03:39:02 +0300
Message-ID: <20261127003902.48-1-ndokutovich@gmail.com>
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

The in-tree selftest tools/testing/selftests/filesystems/freeze fails in
shared_bdev.unmounted_sharer on v7.4-rc1 and v7.4-rc3.

DM suspend locks filesystems by default, so lock_fs() calls bdev_freeze(),
which freezes the superblock through fs_bdev_freeze() -> fs_super_freeze()
with FREEZE_HOLDER_USERSPACE.  A userspace FITHAW thaws that same credit.
On resume bdev_thaw() calls fs_bdev_thaw() -> fs_super_thaw(); the
superblock is already thawed, thaw_super() returns -EINVAL, and
fs_bdev_thaw() propagates the error when a single superblock uses the
device.  bdev_thaw() drops bd_fsfreeze_count only on success, so the count
stays elevated and every later mount that registers a superblock on the
device fails in super_dev_add() with -EBUSY.

The same condition is already tolerated when more than one superblock
uses the device.  Tolerate it for the single-superblock case too.

Add FREEZE_SKIP_UNFROZEN, set only by fs_super_thaw(), the holder thaw of
fs_bdev_thaw().  thaw_super_locked() returns success instead of -EINVAL
when the superblock is SB_UNFROZEN and the flag is set; a partially
frozen superblock, a superblock frozen by a different holder, and a
filesystem thaw error still fail, so the block-device reference is
released only when the holder thaw succeeds.

Filesystems with a custom ->thaw_super (gfs2) are not changed.

Block-layer freezes remain marked FREEZE_HOLDER_USERSPACE, so a userspace
FITHAW can still consume a device-manager freeze credit.  Marking them
FREEZE_HOLDER_KERNEL was considered but would change FITHAW behaviour
during a suspend.

Verified with the in-tree selftest: 5/6 before, 6/6 after.

Fixes: ea4e4cc26301 ("block: allow making a block device unfreezable")
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 fs/super.c                     | 11 +++++++++--
 include/linux/fs/super_types.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c5a0658f7aaf..5d850736c8d9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1457,7 +1457,8 @@ static int fs_super_thaw(struct super_block *sb)
 	if (sb->s_op->thaw_super)
 		return sb->s_op->thaw_super(sb,
 				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	return thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+	return thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE |
+			       FREEZE_SKIP_UNFROZEN, NULL);
 }
 
 static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
@@ -2025,7 +2026,8 @@ static int wait_for_partially_frozen(struct super_block *sb)
 }
 
 #define FREEZE_HOLDERS (FREEZE_HOLDER_KERNEL | FREEZE_HOLDER_USERSPACE)
-#define FREEZE_FLAGS (FREEZE_HOLDERS | FREEZE_MAY_NEST | FREEZE_EXCL)
+#define FREEZE_FLAGS (FREEZE_HOLDERS | FREEZE_MAY_NEST | FREEZE_EXCL | \
+		      FREEZE_SKIP_UNFROZEN)
 
 static inline int freeze_inc(struct super_block *sb, enum freeze_holder who)
 {
@@ -2296,6 +2298,11 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 {
 	int error = -EINVAL;
 
+	if (sb->s_writers.frozen == SB_UNFROZEN) {
+		if (who & FREEZE_SKIP_UNFROZEN)
+			error = 0;
+		goto out_unlock;
+	}
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		goto out_unlock;
 
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 6ce105fe8359..434cdc338360 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -64,6 +64,7 @@ struct sb_writers {
  * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
  * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
  * @FREEZE_EXCL: a freeze that can only be undone by the owner
+ * @FREEZE_SKIP_UNFROZEN: tolerate thawing a superblock that is not frozen
  *
  * Indicate who the owner of the freeze or thaw request is and whether
  * the freeze needs to be exclusive or can nest.
@@ -78,6 +79,7 @@ enum freeze_holder {
 	FREEZE_HOLDER_USERSPACE	= (1U << 1),
 	FREEZE_MAY_NEST		= (1U << 2),
 	FREEZE_EXCL		= (1U << 3),
+	FREEZE_SKIP_UNFROZEN	= (1U << 4),
 };
 
 struct super_operations {
-- 
2.43.0

