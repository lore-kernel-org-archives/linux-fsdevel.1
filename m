Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FD4A0924
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056102; cv=none; b=DG3nnG0zzdAvmej/8u8s36m8ytNExp+9+Ady/6X4E7tcHIde2Y67Gkp2Pcy7ny+GJVxpfN6vgTPJ1crJ8hgTEXVqV/MF/3zCRXZ5P/FOz+VFlWDczmmaMFKY0Vj72ng5gbFbBTIkwkScCL1OjUuq0fpIpGIE5PN8aMYcmkX31Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056102; c=relaxed/simple;
	bh=sr0bSd9ynGbTFgNCIZwrhzTqIlzKR4bDn3xzOgSWMQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejtB+TzcTj9UFx83VBNeZ/XCgR2d7lLRNi/ZByW03ivfodjeY3CoH6bXbWY/+8Wvxc1C4wY5d/2EBVw7j3x9GpFRaaXMKIsblnfiBBDShM6JAHm4KEu8daON4GPbQvt9TVvXCVwGBnl1kfRc//cfqtOm16aolWeJa7/eQnaLGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrd+/ORV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrd+/ORV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so4817800a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789056100; x=1789660900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKB1T8mcm5Xa8kORYrA70kCPtUYorZOcKwhVmBy0tqY=;
        b=mrd+/ORVqatNaAW3HbFq4Tmoff7GuFlHsr5r1rCI7HDVcSAeEw+Yxa+bpyr2bBjoec
         3EpStfQdPhnA0kueZUXkJYFpkuGM/1EHEOg3I7boDfgcvoZN1yyIGn5VxK8YbVWtKiE3
         2GYSGBYA7/4Wf3AKjYS4EYQi0rfGDbYg0yg005n4XEeUAJhAg6V87DVEeKJUVaNrW7+0
         +M8Zlv4KttuxO2Cx2fHryQRi1ztSUF+5ypB01dH+rnFi8PHnh9qAmIJl6JS6pHD5gpjP
         iCkKwLoLQIMq7POdwG8qY6vVfi2lROVDBaXvaw8xc6el4u8h8prU9AtoEZqlguy48Il+
         cYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056100; x=1789660900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKB1T8mcm5Xa8kORYrA70kCPtUYorZOcKwhVmBy0tqY=;
        b=PDeZuLHnZtTSH+F2Gbq0KVT2BU1P+WaYEw4rveAl5ONtCs4eKlqHQ+nml5jB2uJ1b9
         aVvKp+YEErD/iDbT2c3Czq1utF6or444NPl3Uch9PgCFy173COOAfALFHMVuCp5knwsf
         a9wD5g8gQOJ/9ho0SEVC4AFdYQNa0cDA4UFB0MhCPZ8MlRr9fnNX2EjeHEVijlX5Fb/B
         85RMIkj91CsSTV0ceRk5b3AaV5HH65Ia29tFQx3/GpNnYR1rh7/uLiWzYmM9NqwNXKEa
         weTm/JKghS4K5txPa/bUDvpGTsInZmzv/W3ZbKBOi3S18GpFCbLJK44qJxH75aHjbnki
         qK4A==
X-Forwarded-Encrypted: i=1; AKwUvBwaYkG9kUeuMMqICvRHKY/8hwsBtv5pjhgIuwzbpk9uACRUi9U/BXW0tQoA93IeeTg4dDU5bwe+WBIHt+An@vger.kernel.org
X-Gm-Message-State: AFuF++l4Y4XsNBqFUcL+RfYMNTx6SuP/piwv/SjpL5XE3cV7uZrFGsln
	aFpF4bwWRJEha63cy04Yo8DBFa+gbduKxMiVvb0l2vjrItyf63xnziO79Rth9A==
X-Gm-Gg: AYBFou0AkU74TwLu79a6JMtCipztAVIu4hls10xQU2SmU+up2piCywBqjCb/NKuxnyk
	t+aVbLaFf1n1GuT6S2IyW4V6M7mK+Be9qTWCpmycEOvrZrcEHo7UvJv5M0M7pjzvg3KVip3dezp
	cMWvuBw7yKaaWB8r6A1YxZ4ru3zJmy2NPRRf2iZc4+9SSUXgOjzSrTe0qTtod9+P9a5xxwihVG+
	VJXO4A/DyKfFHZyYglsxnyOTqSNt18s8WsPFoYQKKRbWfAi3esLnczV150uEYJuV1H7aM9SwLPn
	R/0nRYJPlucdGIeD9cmvN1a/RDqRiEhGqLDSTNcDb3zeXwHeW9PT2kiIJGiD59jLNU9d64qUGsS
	gaTktzh6nIWaB4crWEfUF53MfY79+sh+V2RxeA0znpX1kPLa0Ky6qUTt5Gc1vCgCaYf72V8L2ZE
	3BC4tj/ekX7LPHUU2+KwlZeGAhK6k0LsqMZBQru31s9nJTp/T1CevUwlOGmW9a5DcXo3jfFvAQw
	0VvMYcCULM+eDW8faw=
X-Received: by 2002:a17:90a:616:b0:39d:8222:6436 with SMTP id 98e67ed59e1d1-39d82226893mr4452317a91.7.1789056099650;
        Thu, 10 Sep 2026 09:01:39 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:ced9:ef96:e152:2608])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9540fd76sm279431a91.9.2026.09.10.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:01:39 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in hfsplus_file_extend()
Date: Thu, 10 Sep 2026 23:01:33 +0700
Message-ID: <20260910160133.27143-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <73cc2e394cc0269a62e2e6503aac5fef2a3ac65a.camel@dubeyko.com>
References: <73cc2e394cc0269a62e2e6503aac5fef2a3ac65a.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

> Probably, hfs_bmap_reserve() is the proper place for checking
> capability of growing Extents Overflow file. But it needs to take
> into account that if fork has empty extents, then we can grow the
> b-tree. We have -ENOSPC situation only if we already used all
> extents in the fork.

Right, and it turns out the existing control flow already computes
exactly that, so I kept the check in extents.c rather than duplicating
fork-layout knowledge in hfs_bmap_reserve(): hfsplus_add_extent()
returns -ENOSPC only when it has walked all eight slots and the last
one can't be extended contiguously (the ++i >= 8 case). If there's an
empty slot, or the last extent can be grown in place, it consumes that
and returns 0 -- hfsplus_file_extend() never reaches the
"insert_extent" label in that case. So arriving at insert_extent
already means the fork is exhausted; no slot scan needed there.

v2, two hunks in the same function:

--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -458,6 +458,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
+		/*
+		 * The fork already claims more blocks than its eight extents
+		 * describe (a corrupt on-disk fork): looking up the rest
+		 * would re-enter hfs_find_init() on the extents tree, whose
+		 * tree_lock is already held here.
+		 */
+		if (inode->i_ino == HFSPLUS_EXT_CNID) {
+			res = -ENOSPC;
+			goto out;
+		}
 		res = hfsplus_ext_read_extent(inode, hip->alloc_blocks);
 		if (res)
 			goto out;
@@ -534,6 +543,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;

 insert_extent:
+	/*
+	 * Getting here means the fork's eight extents are exhausted (see
+	 * hfsplus_add_extent()). The extents overflow file can't record
+	 * an overflow extent of its own, so it cannot grow any further.
+	 */
+	if (inode->i_ino == HFSPLUS_EXT_CNID) {
+		res = -ENOSPC;
+		goto out;
+	}
+
 	hfs_dbg("insert new extent\n");
 	res = hfsplus_ext_write_extent_locked(inode);
 	if (res)

First hunk: fork was already inconsistent when read from disk at
mount. Second hunk: fork was consistent but genuinely ran out of the
eight slots during this call -- your ENOSPC case. Both land on the
same tree_lock recursion, so both need the guard.

On the severity split you described (consistent first extent + garbage
elsewhere -> construct + flag inconsistent + read-only; unusable first
extent -> hard error, mount fails): agreed, and that's the direction
I'll take the fork-validator follow-up once this one's in, applying it
to all three trees as you asked.

Both hunks build cleanly here.

Thanks,
Thang
