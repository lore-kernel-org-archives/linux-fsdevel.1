Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17B23C8A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782357582; cv=none; b=Ax4uqNxN+0xWuC/tEpnKTnQYD/52IMon7dOzhxM0ry5dgf12mtLHdclKpzDbmFuBdGP8z32yKE817h8oTBRJUodbnmYqHb8DtsXADamo5dF+g1foWyonF+KOJmdLZs7PUH1hWksGQH0cHwvS+d1+xxMqXRr/pXLL26AlNDG1ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782357582; c=relaxed/simple;
	bh=ocAdWgVVI9eKE6+SQhdNnJ3AljxoIAnRJT4HyGiFT4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXeqpMKHPCW+1MfwW9TFFq0s3igCXylet3ciyR7nxiwwtEUReuSLNRLT01x/kPCx+FP3ZfmUQZd/ojLlnTKLyAXp7Xi1LjGMPi7BgS8+/hLyl9nqh/TA6uvxaW9o3tXVY78siJNJiXbiVlZlIGALTwNntM9ViCjDJFPShxq9Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JchvMgt0; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JchvMgt0"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30c52f96f60so3321744eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 20:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782357579; x=1782962379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uY5fzMvXX5YHwz0Ydg9UGDt+EYXOYezLqMeVC2OApGU=;
        b=JchvMgt09LkeIKX7uSkwCMUPWzakHu0tQbjm4tQy9MOGJsPZXpweEaqIgHlpULbQ1e
         iuj3OVub+rjW1DaRGkttjSkm9akf6p2UlaxvrjEDQVlgzbNFMWL121muJyHKPFbEpUbG
         TRmPSmtnyzc65GqJRiPJoyFiUfGQZ6HOIzY2Ch/hssIHJOjOlkqKcLRS6uZGkis0pHhD
         E04o/Ln7ehEZFwgzNS95XCBCvnz6tfyQgQ3UpRlAcpeL4GxRW7wbB0p9PAah94d/1vlF
         ccJ+JPrriUAhKk4lIjZp5F68T5dlRAb7TAh0xEVA/NM6jvkg08uBzmSC7qHAPetP0Bgi
         oU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782357579; x=1782962379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY5fzMvXX5YHwz0Ydg9UGDt+EYXOYezLqMeVC2OApGU=;
        b=Co5hdX8z2F3SAf7XKXsebu0fNYC/MjYE8nhg9t694ZDbm18S+SW98RIg6eazVV59m9
         tQ00h2Ul8F/A6H6Fxn0Vpwq6xWoDmUkcP2gZctnh9jHw4+KfGN1xJrqec26A3yjRw8x/
         2PnGFh8i3ranVySbaevgFzfy/Eo9xzXGtTXE5F1+O7LMaYG+dweTP+gMeLSYaIKukI6u
         ONIQvrjsiCjmlEQQIw056hDS2XNWk989lk9aKNqxxA6NYwY4pirsLw/f0puRGQzteddu
         OR96sP9bLzgIVXtb2X4mOw/2sXAOwrLrrE5U5T4yk8PpjlBJ6FqaBmBB8n+zHUM5uezG
         WPQg==
X-Forwarded-Encrypted: i=1; AHgh+RrY29Ef06dFg6gIqtyJ+2EdAATMNnip/QsqTNWTCF1VlRWEJInOebf/p5qyYLUUpVKEEtG8b35OqcSyn4fv@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdBUOqUNZlpsEskDDogs2iMlrpEcIgryPCyETQnbMzJKzw30K
	QCTN9U8mFeZFKYGtORwM2BlAlKPZyfqfJtW4Sj75E/Scp4RkegiNt4j6/hgJ2CtWv0Udn+g0
X-Gm-Gg: AfdE7clkRUmXMUUiVT8njD0a1EitPT1Rv6kcviroiq5ZFOX15QbB/ZIgHl3Xum+oPhW
	5U32Liy5n0TT4QHpD0rU6nb2DIDTecVOBeU3J2eF/9PKp148ICZXd21nGthJTOGzJnsrdVN4IhN
	8pkvzoeVYbj8KW1XeGd/yTtIJa8SkHWnxlj4PQWhfJWoQt/hLYtks0EoUSLj+2lq5J1s+weR9oA
	9A6pkbx/vXzgJ2gOffM+nGXDm/QNr/0/WN+546plu7k72kGV0csCfC35jQym+qRvdm+B1t8U/rm
	hSvDARnGYwPw511spobc4xu/MuS3EdBYisGwDpb13wOklT+jX73+h4PBSu4VqjOT0oxVrnCCdmI
	qwAzQMnjA+b80L0OCT5YxkEDDNzKHohJVvx2zXhK7+gcPH/WAJqa2D+TPSHzC0GsS8MtpVnCEp/
	VIvLdUrI+MBIeIbgvSju27CvYoaPOI8m1PRDwSHNxH
X-Received: by 2002:a05:7300:7c17:b0:30b:f73f:ff6e with SMTP id 5a478bee46e88-30c84b87a74mr872898eec.11.1782357578976;
        Wed, 24 Jun 2026 20:19:38 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c6c2sm3454343eec.10.2026.06.24.20.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 20:19:38 -0700 (PDT)
From: hewei-gikaku <skyexpoc@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
Date: Thu, 25 Jun 2026 12:19:30 +0900
Message-ID: <20260625031932.9412-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: HE WEI (ギカク) <skyexpoc@gmail.com>

ni_create_attr_list() allocates a fixed buffer of al_aligned(record_size)
(== record_size) bytes and then walks every attribute of the primary MFT
record, writing one ATTR_LIST_ENTRY per attribute and advancing the cursor
by le_size(name_len), with no check against the end of the buffer; the
total size is only computed after the loop.

A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 = 24)
bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 = 32)
bytes in the list.  Because the number of attributes in a record is not
bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
minimum-size attributes), a crafted record packed with such attributes
produces a list larger than record_size and overflows the heap buffer.

This is reachable from a crafted, loop-mounted NTFS image: opening the file
and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
ni_create_attr_list().

  BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
  Write of size 4 at addr ffff000008984c00 by task setfattr/345
   ni_create_attr_list+0xc48/0x1058
   ni_ins_attr_ext+0x510/0x7c0
   ni_insert_attr+0x3f8/0x70c
   ni_insert_resident+0xc8/0x3b0
   ntfs_set_ea+0x66c/0xd28
   ntfs_setxattr+0x4d8/0x5b0
   __arm64_sys_setxattr+0xa4/0x124
  Allocated by task 345:
   ni_create_attr_list+0x188/0x1058
  The buggy address belongs to the cache kmalloc-1k of size 1024
  (the write lands at object+1024).

Size the buffer from the actual attributes instead of assuming a single
record_size is always enough.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
v2:
 - Add Cc: stable@vger.kernel.org: this is an attacker-controlled on-disk
   image heap out-of-bounds write and should be backported.
 - No functional change from v1; widening Cc (linux-fsdevel, VFS) for
   review, as the v1 posting received no response.
 - Drop a redundant self Reported-by.

v1: https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.com/
---
 fs/ntfs3/frecord.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 2e901d073fe9..6488d7a415c0 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -768,10 +768,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	rs = sbi->record_size;

 	/*
-	 * Skip estimating exact memory requirement.
-	 * Looks like one record_size is always enough.
+	 * Compute the exact size of the attribute list.  Each attribute in the
+	 * record yields one ATTR_LIST_ENTRY of le_size(name_len) bytes.  The
+	 * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, but an
+	 * unnamed one expands to le_size(0) (0x20) here, so a record crafted
+	 * with many such attributes needs more than a single record_size; the
+	 * previous fixed kzalloc(record_size) could therefore be overflowed by
+	 * an attacker-controlled record.
 	 */
-	le = kzalloc(al_aligned(rs), GFP_NOFS);
+	lsize = 0;
+	attr = NULL;
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr)))
+		lsize += le_size(attr->name_len);
+
+	if (!lsize)
+		return -EINVAL;
+
+	le = kzalloc(al_aligned(lsize), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;

@@ -781,7 +794,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	attr = NULL;
 	nb = 0;
 	free_b = 0;
-	attr = NULL;

 	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
--
2.43.0
