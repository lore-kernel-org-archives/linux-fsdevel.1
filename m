Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B093A1A27
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355683; cv=none; b=N1EhBZ8SNoMh/Mp9htDCqune2YVTB3+YgagbzqcOOMwtxUn/BX9X21aAqnwIM4SyB7nELYQBvkoULz0NDV8VjAuCIyQVVwkixsp4h9xmEcZj9gkzMKGy6mCcXTv0rH+Oajvd/zM33orsd53J+wt0fJeRFtI2xSnXEXdplD4vILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355683; c=relaxed/simple;
	bh=73xzuFPs2JJWbAgU4+I+Qwk2eNu9ebrZ9MIDWhKyETQ=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=WPznPhokLIj84xl5uA1lHtSXrB+Aw/I1cSZIe9JH4vUH7sS+VUV24Plwm+iov6AeXuZ9JNG6IN2aNcH3hVhJJrl2EuP4t9+sVTUYEWUaquK629c0Schsa/Y3wT4uIKFfJkEBLOHxAqI9XjKw2S460cJ2OCukxAxqp17HNBt7uDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtYkrwnM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtYkrwnM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d049069377so14543795ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355681; x=1787960481; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BX/q/fzHpO9j+bEE1N60OvmhKcTiaQqPpyDyZokjCRA=;
        b=GtYkrwnMnu2k5VdK0T5aj+Z4fffGlm87rP96eW2nbZLa4tyUbtzxcW1YnL8GAwe+3c
         pgxX6P2zi42pGx04YpEynu6f/N3k0JEhPWmqmtrIWxQ5+iUzf5yVVk3Ef5qqhB3RJYDF
         gbDA3tvaBR0P0Jkaa1hDRanEeUh+fQfuT2RCFK7eMcwsXgROi/1ayrgIR6oLS+lxHT8z
         BtYrZKOUbRqvfDv9pa1UKJhBEFarsB3YsDDdgJSJt3vEF8ZjE8RSXFC5bHKeagHMQze9
         5Wl3BtowP8FZjT2TFGoZ4dZQZ9JnMjLG+vANj8gualAv1eVxbsPiXB8dVhbUrujbSYeQ
         0zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355681; x=1787960481;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX/q/fzHpO9j+bEE1N60OvmhKcTiaQqPpyDyZokjCRA=;
        b=rMNIARhtUGzbWk9JXBLzF3JSlr1Ld9I9VW1iNBrBs15OR1bHyySxs34hMikM2kKbpM
         DOCszAmeHiiGb3mUT05pUEzqEc03lfFWLbLuukArUBFbBROa/1K9RW/nw23To+CpmAAv
         m86v/Xw1fGT4NLBpE42AgpM/eT8hYbQX11GU9J9yfWVSfZA7RLcnpfXH7cNzQD5vRjub
         V0m/Bsvd7tWt0yTsyFjg8jrYgMvGntFsumYZx85Btrluw3CroByuCKuZae901KSdNfKT
         2RDBdwsKRuQbmQBO5FIcnUNn4Hi516i/nv11J4c9jVwMX+nsScWWTslQobNXoQe42bsP
         mObw==
X-Gm-Message-State: AFuF++l6CU4zGEL4ELf/gQOVlGKmxndcEhY1DFS56tzf+bT8EWLGxSov
	Oi7F/yuNq7rz+ZcYRLFtBn+HPUYyj/C/wwNumeMj6on466G58o7p/4F5
X-Gm-Gg: AR+sD106rxYxucIEXM6veMfxqXqaOxvl9LojtMuY7e7bQUFBNRocIJqLjIQXwH3gg8v
	iaKx0S3V8DsDFMq/5umeW60TJNSXMZAkf4QhQhTI0yCUMfRAr8IcsoqUfex6osvfSvCfg48xkDI
	dAitW7NHSjiDlFPN6EDggPk155ubG4/fkYjQdi0uFgFIsBChiAq+hDO8NpPGXMTvFMnMMKEIlTW
	G3btFEZuTb9EakcdIU1GdOd4/x73Z0u5pfmD+SQm1S55qHMMF9EVLAjVogT84olSyQretBO9f1Z
	oo3YxdsvByL5jiFtuw8/joSkaNdIDma0fdJzIFMWxgYa6fV50kEmWu2Y1bWwmxdP7zetltq91DV
	Q3zaFvkLvW54JhAL/9guKhbmRGHEOtVYmdvx0XVQOjR/Tdkb3UpntykpYof0wJt66XBealMYp31
	Qs6QQur2Aq9O3Hh+Xp/SUwkl6AhsRs8sI8iQN67v3vsPQ4dKzV0fXCdV9i68FXlrFeaIRpq24oi
	DUvfvW99saQsxer1sOqsivvlfjB2B6ws6PsvI43gVdOYw==
X-Received: by 2002:a17:902:ec87:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d64b024c86mr170032115ad.10.1787355681276;
        Fri, 21 Aug 2026 16:41:21 -0700 (PDT)
Received: from localhost (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm311677eec.7.2026.08.21.16.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:41:20 -0700 (PDT)
Message-ID: <6a88e220.1e1ac41d.2d530b.7cac@mx.google.com>
X-Google-Original-Message-ID: <aojiFgxaUXwVw01b@DESKTOP-HH660AU.>
Date: Fri, 21 Aug 2026 16:41:10 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: bound $AttrDef table walk to the loaded table size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ntfs_attr_find_in_attrdef() walks the in-memory $AttrDef table, but the
loop condition bounds only the start of each entry, not the whole entry:

	for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
			vol->attrdef_size && ad->type; ++ad)

struct attr_def is 160 bytes; the guard reads ad->type at offset 128 and
the loop body reads further fields. vol->attrdef is kvzalloc(i_size),
where i_size is the on-disk $AttrDef data size, checked in
load_and_init_attrdef() only as 0 < i_size <= 0x7fffffff. A volume whose
$AttrDef data size is smaller than one entry (e.g. 120 bytes) makes the
read of ad->type run past the allocation. Creating a file reaches this
through ntfs_attr_size_bounds_check() and reads out of bounds:

  BUG: KASAN: slab-out-of-bounds in ntfs_attr_find_in_attrdef+0x66/0xa0
  Read of size 4 at addr ffff888005833280 by task init/1
   ntfs_attr_find_in_attrdef
   ntfs_attr_size_bounds_check
   ntfs_attr_can_be_non_resident
   ntfs_attr_add

Require the whole entry to lie within attrdef_size in the loop guard, and
reject at mount a $AttrDef too small to hold one attr_def entry.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
Two parts in this change.
1/ The loop guard in ntfs_attr_find_in_attrdef() to fix the OOB access.
2/ A mount-time check in load_and_init_attrdef() that rejects a $AttrDef
that can't hold an entry. This is a clearly corrupt table and is refused up
front.

A reproducer is available on request.

 fs/ntfs/attrib.c | 2 +-
 fs/ntfs/super.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 990c3937a..3f68a8ad1 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1737,7 +1737,7 @@ static struct attr_def *ntfs_attr_find_in_attrdef(const struct ntfs_volume *vol,
 	struct attr_def *ad;
 
 	WARN_ON(!type);
-	for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
+	for (ad = vol->attrdef; (u8 *)(ad + 1) - (u8 *)vol->attrdef <=
 			vol->attrdef_size && ad->type; ++ad) {
 		/* We have not found it yet, carry on searching. */
 		if (likely(le32_to_cpu(ad->type) < le32_to_cpu(type)))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index cd8fa2c13..2fd7db672 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1241,9 +1241,9 @@ static bool load_and_init_attrdef(struct ntfs_volume *vol)
 		goto failed;
 	}
 	NInoSetSparseDisabled(NTFS_I(ino));
-	/* The size of FILE_AttrDef must be above 0 and fit inside 31 bits. */
+	/* FILE_AttrDef must hold at least one entry and fit inside 31 bits. */
 	i_size = i_size_read(ino);
-	if (i_size <= 0 || i_size > 0x7fffffff)
+	if (i_size < (s64)sizeof(struct attr_def) || i_size > 0x7fffffff)
 		goto iput_failed;
 	vol->attrdef = kvzalloc(i_size, GFP_NOFS);
 	if (!vol->attrdef)
