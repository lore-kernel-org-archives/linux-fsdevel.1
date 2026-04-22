Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347728A1E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873543; cv=none; b=ApVb5x7jBXXWCZ98VPNigj5NkXcfjwBTLZjKC2hstScQQx/6yo3jTf8wGwv9b/ln0U30CGdiiR2e85Yiw5bKspXW7CQMYKN6vja5u48j6R6NnwdpQp82Zsomlp5M5g+NyEAazzlN/VpgbbYNiuHvai4jeVI5qHnr9K8NgX8OPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873543; c=relaxed/simple;
	bh=1EyxcKO/nUApGhARmp1AedGru9RgJuydJVerpTfmZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHcwbswlnwQBujMYecUIxMsu+1BjVCQZOzdBXoJ99faQk3mCbCgkzCLs2cSHY/QyLdYmezLnPP+XAmhpvCb38p3JVODINS+DxzGjIVHtnYlA3sKeqY/0hiHLHAdBTEo6tN8gGH5ZybTPA6DeEkhzPln3TReSzzmLTSkx4JWWUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAi5i+VD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAi5i+VD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ef0ba61d46so175930485a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873541; x=1777478341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkTj2C9YliubRyWKE8nCInm/VBiYVrnMT7BPVcl4dBw=;
        b=kAi5i+VDkwGNcovTuJR8aeog2qupFbdR30y0/17VxvEhBhkQkmbR16cipYs+AmUXTk
         o/mh98OgmkDY0dmJ45tGP84t0Sz8pDaMK2U/9R6h/sbKq5sHXx1jfbB8OPjBMxSAZa+i
         eQJiPatNL6ZaR/SnoXYJuq4liGsvVGCxME0vFoNghcl4hIt2YcbBHtK4RXF4mSueQNy/
         0aKmTgAVjInAaIoiAoYkTMk9hiVk/9CJzNrXD2khBejk3tHxSKS35S1Q6c4mqeGn5gBw
         +4rprbkwt42M9jF8akFgHwpuX9qd71sY0OTySsA6B4VHcdBqrl4nQKNPzJ/CV5KdCS2C
         LkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873541; x=1777478341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkTj2C9YliubRyWKE8nCInm/VBiYVrnMT7BPVcl4dBw=;
        b=H+aZSiyQ4dlAUDbRrNimsqOdzLCU31WUZemaLYh+ht8+o876fKXgEAsqFAICTLedMT
         Cz3jEn8bCsFhhzLEW5xhKb/f6Aaz64zHQoa3oRuXgalFRzBAJHqkGWCZZ1/3nFoBckt+
         PR+0r2Q1T5L55zG8o3d2/I3gvkJNeVeHBEgFeOzzF72YG7962fJ77qxAaAiQPLM6Icq5
         12ns5CBVDmCYq/AwEteqJyyStVqZlFrtE2ma+9VeB9XzBTa52825XLV+KeYbtuLpBR+E
         pb2TlGKiph5jZSc03/kF16T0KBl0qN5gZ+xKQfA22DDZQaLbZkWNH/s+QhxgtAdl1H6i
         1lRw==
X-Gm-Message-State: AOJu0YxdzX3OAtDko1/1G6WjygysNbeOQakbToG/dSVDLTxg54Pa+Bdx
	ybUQXdDahdMm3mN1QwT55yxBy93xsxyYpazkopKws5VZqangFX9UXFUC5k7nEp7Q
X-Gm-Gg: AeBDievscA1mCWYKBR5fura0wMB5jIdTKiG3m3xQlRBEu6QOg1vnk+1jzm/0OGjbGmL
	Nt3EnuzV08pxBZyWXXfvx4XvzBmYkoEhg9WEHx+2rITZdKJT4dD4LB57lIaqQjO7Wiy6ktMXR+k
	v1Wf3N2JNibDWJAzWNE5GC+Vg14khATLazBmBKQZ3vxYkNhjEG4V4rkuQz04Fjwa8AavDLqE79k
	7+qVuwIRdOFjPaKWWWc7cY+S88Pm76SzXmohIBiQzFP36XcpPIXQuFcx1Dbm9Asr7jINL8RQzNY
	0k/YS2ltIiYVsi0w9vfecuwg30+zTSdGlGX6CXhDF6fqX/4OqKM6KL9Qd4W1NhX3ny3QNKMIDo3
	p3HadGByZjNW0wTthDmf1QSfMLtKx97FuizBZxXhG8gcYM680elpwAMoVJftLsV13JSsmmYhAB8
	cWwZ/yFZrzsEKgIj7ku+1rDrUXMBEnGuF7FbMjDzDqwMzp50w3HuY2ly47QzS4AhFRUd2L9kKKm
	y2ghsOqwaOVVzEJCevD5Z13f5OAN9M=
X-Received: by 2002:a05:620a:46a9:b0:8cf:d70d:cf0e with SMTP id af79cd13be357-8e79236d606mr3376452385a.47.1776873540726;
        Wed, 22 Apr 2026 08:59:00 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ee585e9fcdsm496696885a.16.2026.04.22.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:59:00 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] exfat: fix potential use-after-free in exfat_find_dir_entry()
Date: Wed, 22 Apr 2026 11:58:44 -0400
Message-ID: <20260422155844.1967148-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exfat_find_dir_entry(), the buffer_head obtained from
exfat_get_dentry() is released with brelse(bh) before the fall-through
TYPE_EXTEND branch reads the directory entry through ep (which points
into bh->b_data):

	brelse(bh);
	if (entry_type == TYPE_EXTEND) {
		...
		len = exfat_extract_uni_name(ep, entry_uniname);
		...
	}

After brelse() drops our reference, nothing guarantees that the
underlying page backing bh->b_data remains valid for the subsequent
exfat_extract_uni_name() read. This is the same pattern fixed in
commit fc961522ddbd ("exfat: Fix potential use after free in
exfat_load_upcase_table()").

Move brelse(bh) so it runs after ep is no longer dereferenced on
each branch.

Confirmed on QEMU x86_64 with CONFIG_KASAN=y + CONFIG_DEBUG_PAGEALLOC=y
+ CONFIG_PAGE_POISONING=y on linux-next, using a crafted exFAT image
(long filename with same-hash collisions forcing the TYPE_EXTEND path).
With a debug-only invalidate_bdev() inserted between brelse(bh) and
the ep read to make the stale-deref window deterministic, the
unpatched kernel faults:

  BUG: KASAN: use-after-free in exfat_find_dir_entry+0x133b/0x15a0
  BUG: unable to handle page fault for address: ffff88801a5fa0c2
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  RIP: 0010:exfat_find_dir_entry+0x1188/0x15a0

With this patch applied, the same instrumented harness completes
cleanly under the same sanitizer stack. I have not reproduced a
crash on an uninstrumented kernel under ordinary reclaim; the
instrumented A/B establishes the lifetime violation and that the
patch closes it, not an unaided triggerability claim.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/exfat/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac008ccaa97d..561fd2349218 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1027,12 +1027,12 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				continue;
 			}
 
-			brelse(bh);
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
 				if (step != DIRENT_STEP_NAME ||
 				    name_len >= MAX_NAME_LENGTH) {
+					brelse(bh);
 					step = DIRENT_STEP_FILE;
 					continue;
 				}
@@ -1043,6 +1043,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					uniname += EXFAT_FILE_NAME_LEN;
 
 				len = exfat_extract_uni_name(ep, entry_uniname);
+				brelse(bh);
 				name_len += len;
 
 				unichar = *(uniname+len);
@@ -1061,6 +1062,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				continue;
 			}
 
+			brelse(bh);
 			if (entry_type &
 					(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)) {
 				if (step == DIRENT_STEP_SECD) {
-- 
2.53.0

