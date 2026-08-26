Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE034A77D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719479; cv=none; b=EnkJbKCbph4GxqyqDxjk5PZbkDL/ZCdhiRreegfYrT7ja+yMJLVDI1+bWYqBY+1xInDp3N4kxMXA+MeUM8GZ+sYoNd8gLYy9dPSMYuDO7D9ZR1r2EV0McO2BD7XA9qJfYq1oa/yf+uFWvMdlgj/AU4lOQ6weHbMSjCiTCScZBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719479; c=relaxed/simple;
	bh=WwCaBsH4oLqHXKummXL3cGn/RQ7bD/S39q7wytygq+M=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=mLYfoiosajAKMzuuK2CjcKIpH1yPtgYD1GbcIyxO354PWbxTv8vvviN/d4rkNl6EpYzeNS/szDHH4vxqOLn5uOCSK5vAUnFv0NgPWMMeSLQbo0ccanublnx0Dxh3mFfj4US8vQH7fV9iNM0LmLbbw1M1T+105gA/LAllWAnOf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5LrsAX3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5LrsAX3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6f624c323so7410295ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787719476; x=1788324276; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqv4vSBtkWp4LVhCDMdBCum88ni/PanP/bbO0zmwvxg=;
        b=T5LrsAX3ajTL2MrMhoNF78nOvsikankbl4uF3TPk6jybv73np+A9UGKndcYDM3pg9V
         Edy4RHRCzBiKDG1c860sOjnihsEx6+M33tDy2XBgWxvQ2pZRgpg10P6FB3YidPIOQ10p
         +RlBuE0UXY+wtO/fdNKV6/Yz6OFmN0D1wiBrtMiPYZMcHSa6QAeXTOJ8ZIx2lLJmNEFz
         CbfVZ3gldOxOP+02rvxwVDcaTuS0wazgjR4eX1LyEZUMccvl3mo5UME/eeZdjcxLiwgG
         df1vB8mgU8PGD4GUdiJjO23IUAEFaADrIJ9A8wkygiXjEurK5xJgmhy0GiEkP9jiUX4s
         8Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787719476; x=1788324276;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqv4vSBtkWp4LVhCDMdBCum88ni/PanP/bbO0zmwvxg=;
        b=ck31uT3ddp9uY69khgBOj6hwNEtSLODUqm5SVdFGImFLPWjnxZcQGD1nhjOTUWJwbp
         lpeXhVvaqLBEOQXGsSscZYmV2pt7dwJCVQHBYISlPhg1Pj8yqmM9ntKj30jThTOoOFq4
         CNPlCUB40LDXh2v03/83Z8DNz+hDv4+LKXb24kulGWAns2QecVyVydj1t+p+NVjfqbfi
         HEEoHKOPD1f/SwGXmjwNssg2oadbuK12gqZbVM44va1ZctE8tWNh9QW+2zNSDj1MmoXr
         5BlCrUw804gTaZzMy9jZVOSk41qaZQOP57l56McsbdgXkF7yjlMkB+fJ6/bT1LeOqCWH
         pfZA==
X-Gm-Message-State: AFuF++kY9chZwQflJf0wK4q7kF6MkXWpVzUVggjnbpnA5x5GkHx/CSsX
	q3nKXKnKrLkOoGTsOPUHuSCZaY+DM7wjmDtbytXqgIyZOQfERotEQ6dy
X-Gm-Gg: AR+sD10SM2qURT8rj2QN0dP2ISJp+Jenbbw3uzooKKXXhRRcpZnsXtjk4ygp2Pg5m0P
	sNtMG22e0aJ435TASy6z90O223PCypRrf++qYsTczNKxnJIERsNAWC58T34KAU5KyassFDPoEiA
	6jn+EpRhqx3Qwew0cPDRYyJsQIaq2inb/tBcsm9ZthhbQIZEYhqZVeARAfgv33i9ZHR6nP0ZwSK
	1hkpsCDGtV1YwsWbaAyGSnNPG2/6kRqbL8LW8NSZ9z/9MBWR+FYi0OBYZm33IyQkcA9bAeTQirm
	S1U9s7+C6ZsBfo6pOvNw/hDJUvu5Hhslnej8mZR/K9YvtcZ6NLVaLIZCQNAgelGZ+ReZNdjw5jE
	AMjt3NVyN+qsaXdYh2HTKb5wswQ5c37shxYmOY/pIIxWsZL0Y12UqaTvJJC0HGY/eMPhBUIly0e
	AuMSdckodDC4WtR6IrOnBYqnDLQeYUFGzgYpAUWyimkYWvtZIYDR+HkXoZa/XRSmqtGATTBk1wb
	Ib1mJXXTbUk24XWO7Sxx2WlqHta1ua2aoKpj9d4pwyAaQ==
X-Received: by 2002:a17:902:d581:b0:2d1:134:b86e with SMTP id d9443c01a7336-2d707a0190cmr70840405ad.2.1787719468915;
        Tue, 25 Aug 2026 21:44:28 -0700 (PDT)
Received: from localhost (75-172-73-38.tukw.qwest.net. [75.172.73.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c11ab7sm3821795ad.65.2026.08.25.21.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 21:44:28 -0700 (PDT)
Message-ID: <6a8e6f2c.8c92e5db.197682.4689@mx.google.com>
X-Google-Original-Message-ID: <ao5vKDX48pUjME9O@DESKTOP-HH660AU.>
Date: Tue, 25 Aug 2026 21:44:24 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: bound $AttrDef table walk to the loaded table size
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
Changes in v2:
 - Rewrite the loop guard to bound the entry offset without forming a
   pointer past the end of the buffer. Good call by Namjae Jeon.

 fs/ntfs/attrib.c | 4 ++--
 fs/ntfs/super.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 990c3937a..7d0816de7 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1737,8 +1737,8 @@ static struct attr_def *ntfs_attr_find_in_attrdef(const struct ntfs_volume *vol,
 	struct attr_def *ad;
 
 	WARN_ON(!type);
-	for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
-			vol->attrdef_size && ad->type; ++ad) {
+	for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <=
+	     vol->attrdef_size - (s32)sizeof(*ad) && ad->type; ++ad) {
 		/* We have not found it yet, carry on searching. */
 		if (likely(le32_to_cpu(ad->type) < le32_to_cpu(type)))
 			continue;
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
