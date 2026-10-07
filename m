Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FD1419A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338273; cv=none; b=JBGoeEwzhuE/PKNpH/wRK6C9+pvOWHt73W5kgz1hNLKukrqVEuhFIk6L+oY/+FhaA01GL5zwlVH4kSu+gy/24QnRVxbRGtTO4gYsjbzl5ETgBDJQTtfH2YWa11jaux6CDbhPsGUsY11lVivESh+i1YPP3WO6iDpijrFHRG3k2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338273; c=relaxed/simple;
	bh=EnH+Y+4cL2AjL+MfdV9nfQghjAGlt8P35VugtZxmsj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSQDSHo36S1K4bpQR/nEdPDETKtkLUmAjGcKFgsFq2l0NZOfF+AOhWfnUp8is7JhA+3tz+lH5/LILAAZ9kOrMd0a7ntvPIOcKJcE5tm4P/iKkoIHpz0fWhEHmI/2v6zQ13qTEApdw409syj06sO8s794+XxCD+82aC9bx0QqkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwzuOkWJ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwzuOkWJ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so9574202eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791338271; x=1791943071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Co7b2LMbzdCPsCsbgcCtLsS9QDYuBuOKqGML2L6dVHc=;
        b=TwzuOkWJgAM8y1k2TehcGGNInheRgn0BFiGCW25ci6z3d5+E6NR2bZiWTsC965lqlM
         pfzXMAauczy+xc5HrEVJfwMl2NnYfn9v82MsiUxJ0bisx+UMzmOH4d8ti8hyXvvceh7X
         IwiVX5h1+ak6GA2PwRRpB67GqvBtxXVwZJyYMNw7bX0RPwlkzRdw/1NCjhwZbITl3MuG
         ve3tVTzAUA107cO8voRpYOBOBKuH63pZpcS6jsekp1SMKqE09Xzy6SW2mzOArXIe2MIr
         bUplMHpRfWC5xWKz5kHK0A09+7FArkNtuUjGewMnHEye5JOZ5g+VKKGP3VyiE+lZjpNE
         WS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791338271; x=1791943071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Co7b2LMbzdCPsCsbgcCtLsS9QDYuBuOKqGML2L6dVHc=;
        b=i7zrBzgzzvzC2PJXHKbjqxAqjUsGF3KlDhsFzRlIPE0CjDNEr+xIbswi88cA2FIDQg
         KPpCZocKB2XGQxbqnPah8zXz7Dx6GrjPjM3KJNqmwbBLnWgYOxiwig55cQq4F3v0X6Jy
         Nb0DOl8c53sG7EkujSYt+7ZyoJHxNcgpZ/iqxnjs155ZkMLY5YtaqH3m/CBv4Jrc+gHL
         tzCxdCkmeyjxg9UA7lN92jhtXJpSy66hF6i+TILnr4peCfkpuBWrUHFcsjAbb3Tf3xqf
         QxR0yYdpsWrKowBSPZmcTLKo/kNaTVOadm1aWVbBRx6hevG+/iE4qtvlg/IyF6jjoQOT
         KUiw==
X-Forwarded-Encrypted: i=1; AKwUvBxt+ReNg4ifjD2UX7WDJBEqk/eXAOYuOBZP5EkJz5wgaibEqiwwUsvsJULCjN3LzjoOcUB3x1AMhYZSOvH4@vger.kernel.org
X-Gm-Message-State: AFuF++kmqQvM1rdXjSc+Aj/9iRjZKF+9Q4+vyk8WzmE6fIo8J6a1zbRv
	E1GwngYFoS1Rv5BkqxeAFV0Eo1KMu5B4yNAL9h45e5xtIHaEiDIgbuSK
X-Gm-Gg: AYBFou3miCOoyJh0Eh31BRaj/URAxOjCgXpRTCNA+Svi1Df4KhEsi8o59XwNvcNDVkl
	GoJi1jjSoyhlWa3OIQBsxEDIZ9D55yEEO74ZmAMVCcl3oUToBBuSuDYeXd67+rkHAS6yzyDcoPF
	Asb3Yb0tO++tHremkvDw13V4XPxdfNzPkwvd1m/tzP8juAAdmDK7jRJBYm+tioNinL51sCHmERQ
	ENIyeP1I/wxaLYJuUbyg2EbQ3U5KKY5/HEszfoOh1uXOMXVs4SPhOGBK/BeCXkSc1az6hjlY2n6
	RVYSmagfRIOH+jcEHIcDRYZs55/I1gOp1WZU+kSGNH3m/XsheDLeTYd2Ur0oFIzj82WEZHvbW/r
	JMQx0egFQoy6cLAllGrQbpp/BidIY1TaNlq8GSf1QXNFbJ8dQZKsiJ1oHrqrsSki6O9knTf6jSF
	kpT0+WgbpgGmTr2MCWkuVphn95H/EWPb/YgsnY1C7MXoniZXwOmKjyuQQoTQFqh/rnj8JcJ0s4n
	GOlHGobfM/L2S2YoU9THZTj0A==
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id a92af1059eb24-1620966b83amr909080c88.38.1791338270950;
        Tue, 06 Oct 2026 18:57:50 -0700 (PDT)
Received: from FredPC.lan ([2600:381:9f1f:6c0f:5b83:27bd:dced:34e2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616980c3b7sm2156652c88.16.2026.10.06.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:57:49 -0700 (PDT)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>
Subject: [PATCH] netfs: Fix off-by-one in the flush range in netfs_page_mkwrite()
Date: Tue,  6 Oct 2026 18:57:01 -0700
Message-ID: <20261007015702.111459-1-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a page fault wants to make a folio writable but the folio belongs
to a different netfs group (e.g. a ceph snap context) than the one the
write is being made under, netfs_page_mkwrite() flushes the folio and
retries the fault.  It does so with:

	filemap_fdatawrite_range(mapping,
				 folio_pos(folio),
				 folio_next_pos(folio));

filemap_fdatawrite_range() takes an inclusive end offset, but
folio_next_pos() is the position of the first byte of the following
folio.  The range therefore covers one byte too many, and writeback is
also run on whichever folio contains that byte.

filemap_fdatawrite_range() is a WB_SYNC_ALL operation documented as
waiting upon dirty or in-writeback pages in the range, so the faulting
task can stall behind I/O on a neighbouring folio that has nothing to
do with the fault, and a neighbouring dirty folio is written out early.

The off-by-one dates from the original implementation, which passed
folio_pos(folio) + folio_size(folio) as the end of a
filemap_fdatawait_range() call, which also takes an inclusive end.  It
was carried over when the call was changed to
filemap_fdatawrite_range().

The flush of the faulting folio itself is unaffected, so this does not
cause data loss or incorrect results, only unneeded writeback and
latency.

Fix it by passing folio_next_pos(folio) - 1, as the flush_content path
in netfs_perform_write() already does with fpos + flen - 1.

Assisted-by: LLM
Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()")
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ecf119b4f9166..b398c3bef6f3c 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -579,7 +579,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		folio_unlock(folio);
 		err = filemap_fdatawrite_range(mapping,
 					       folio_pos(folio),
-					       folio_next_pos(folio));
+					       folio_next_pos(folio) - 1);
 		switch (err) {
 		case 0:
 			ret = VM_FAULT_RETRY;
-- 
2.53.0

