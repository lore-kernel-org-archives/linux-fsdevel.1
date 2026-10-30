Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334568;
	b=aKy5t/Pzn3IO9TDqop5m9rZ4GID5OrZsuRIdNbp3QPs1C6KLowdqTmgGYhFrHN622AZW
	 o8H6Sus3fn72Lj4bOAmcLaA0xfaX8uLH0i2FIGp/KHVTvoIXqoPCCxox5D6STGJZ8g5gI
	 WJV/xkK5dCMtfxDK7bgWsbtU6d9EQt+1hbUQiLdpulXW5ms2hR1iW0vE+EYrxYuXeZCXF
	 q+zGS67BEQnGcXM9aOYr3rbT9aLRHTpqiQ0PY8hyjYahiHL4CKMRAN7/wvGMaUDfcbB+f
	 WKUUiK3ZJ2M9CYG7p4T5DJXEzPNbMUQmmPuU4hR0bJXk+4k4zY501v1SEUCHljcaITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tN9CKb1zjGPoBG8E6tp5fkfqBwx6I1Gzk/q0OBzU968=;
	b=3vFI1SgBWl8tBWzeJ/Cm+7l2KmC4/fQc3jR4M3apFfblyRAIz4L6XzN/vdUMjBxb9ba0
	 ftwDSGnJONL6yHcOXmrlSQPGti3YrxyZeDMEo3hxSzsnNo5YcXM3f4QYzCZsdtNU4Ff33
	 3HXnz6lqBL7NZEeeReCwPCb+v7ocHobu3faGxlthHiNkLSZ5FsAooIaKSq9HKHveZN1oC
	 9kCyBaKceGIkWMAayPIG/qiEygHWgYJHWXtbE2K2+lwZdz42FtLeHM3KHMtuP4zxpctGK
	 cvxKtgg3vVghYykviEO2CMkGrTSKHEVJpv6UeC+BRaH6SFZrVfTk1Sh05Soi3KTYuYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TnTHEefo;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F572606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F572606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TnTHEefo
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c60e30054so3537736d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793334567; x=1793939367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tN9CKb1zjGPoBG8E6tp5fkfqBwx6I1Gzk/q0OBzU968=;
        b=TnTHEefo4JKAswq9qfZvxmUHBDF7NYxptwSPDg1uOJ7c7Q6LnDSWlzpJkmzOpEqvoO
         RkqgWDib1q1SgBXZG0JiVOh88yk/xaHtLr6QZjk7WWXwXuqI2w9p8QW+aDJkAsKB41gD
         oS7+Ira9D1BEG6DihyzsrY898BIV6cQ6HKSaNODThS7Vb5KN5lbMYDB2bTUwVbrD3eT7
         0mNYPOE4u2oXgf60TjG9oHbxxOkx6aj/2lUvvnZhfgGSBS6XSbbPwnV4jnuYvToSKAWD
         gpORyaVCA+VypH0r8EhISPYHFSrajUSnBpZjAruh/ORJBOnf77wotLwBzf4KBm+GE2/+
         InJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334567; x=1793939367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tN9CKb1zjGPoBG8E6tp5fkfqBwx6I1Gzk/q0OBzU968=;
        b=XU+TUP9zPyqJRvm23Lr4c59saWeCTyR1hEKHt3lCOk3m4yeu2p2fS3tsbVkCVh+5C9
         eYf4niByFE5I7WPs8t/alMAMTTNhvnCYbnIxgqV0EhaOfPbNnkl5EWnkpFoM3vWvnUvu
         8mWs9NHVLNOjpfUHUBHk3Ychg9rKa53ehZ4F/XH1hGV2fncMX8muD3Ke3P8VNFGl1v15
         hZx0sHpHJhFb7jibn5OV/yeKepSkkJ475RryRC3utmBfmDch8P3a7uXv9QDv4r10Gsnz
         eIlip57LfreKDiLyW22SKuZB2x/0euCUyoURAr3VmFQX1r0Zc8vH6rpWPBvjC/UgRuQI
         IgxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdSdB4e1Gg7+Gxk4h1lmxuehuAF6ZE/+RffVeJgOdl2b+ylSFZ0+wVXx/CdxJbjYXGlAxhedi6zl6FCml3@vger.kernel.org
X-Gm-Message-State: AFq9FYKyhKCjaQhNosOykaUInvr6kqwzMQKhuf54WOdM1XqwdS5d2QTO
	iCZT6HqYT+BqB5FANZ2bgHLx56bcyaMrgWU1hcrxWgAMV1L3xFFgySJWtgL7V2IOMA==
X-Gm-Gg: AYBFou0cHYprUwpV7SCKhjPzDMwC3xH2PXItAy6H/j1HXmmkeu5fIkzerDM03Wu+jtc
	AI2dYAwqVBPSZLy8YFQppHbJWkmYNozKAr+6jE4MG0JFALOiel1QCxiHyYjq0ZE7USdoJKTEbj7
	B3jnqQZZonSa33rvRPJ+jOIUHNwVF3dxZrynhK4/zmeBoFjPvbzRMBcg6TUYFdxNOZ8zpfHL1p+
	fkXMUHruOpkRCQD3xPZR8X3Hltz78477OB159hOnZzXwqZ6RT+ePSATXrQ80ytn42NsVRhQ5Zy9
	fiXHpmrnWkIjlSCPVlin5NsTY2GnC7HHuoVGz2aLgNIFphUkBX+fn2RMPtfmwvx5oaqdfe+DwLJ
	xxmTqAOw0F2pXAuQclCtCuxnw5iqtxld8e5xVMtJQWWdvamuc1NREjb+BNrXdjHHdbGKCJlNqXC
	RCRu7GC4enOQBp7bDCXkKplec5mYRg9jarByvMNBMgp2RppY4MFUcPR111S23RdXf4l+cr3OiKU
	xxQJMXEZbC+WF5FyYaOrjKSwXSZNu2v2r3St54GIeXqG7hKAzA75eZam8BzLY42R0R+4CMrH83K
	ia5ya8dkee58p/KGytHAeqMbn7p01FlLU1CWDF1pap7WwU75p8fD
X-Received: by 2002:a05:6214:524a:b0:91b:82a6:d2f2 with SMTP id 6a1803df08f44-91ca4adcf10mr14769366d6.11.1793334561851;
        Thu, 29 Oct 2026 21:29:21 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254a1sm5058166d6.7.2026.10.29.21.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:29:21 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hfs: remove the dead grow path from hfs_file_truncate()
Date: Fri, 30 Oct 2026 00:29:03 -0400
Message-ID: <20261030042903.4160506-3-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030042903.4160506-1-hengyul@cs.unc.edu>
References: <20261030042903.4160506-1-hengyul@cs.unc.edu>
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

hfs_file_truncate() grows the file through hfs_write_begin() when
i_size is larger than phys_size. That case no longer happens.

phys_size is set to i_size when the inode is read. After that, i_size
only grows through hfs_write_begin(), which grows phys_size first, or
through a direct write that ends within phys_size.
"hfs: report errors when extending files with setattr" made
hfs_inode_setattr() extend files with generic_cont_expand_simple(),
and "hfs: fall back to buffered I/O for direct writes past phys_size"
made direct writes past phys_size go through hfs_write_begin() too.

This patch removes the grow path, and warns and returns if i_size is
ever larger than phys_size.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/hfs/extent.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 26357086517f..8d04b7c0911e 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -491,23 +491,9 @@ void hfs_file_truncate(struct inode *inode)
 	hfs_dbg("ino %llu, phys_size %llu -> i_size %llu\n",
 		inode->i_ino, (long long)HFS_I(inode)->phys_size,
 		inode->i_size);
-	if (inode->i_size > HFS_I(inode)->phys_size) {
-		struct address_space *mapping = inode->i_mapping;
-		void *fsdata = NULL;
-		struct folio *folio;
-
-		/* XXX: Can use generic_cont_expand? */
-		size = inode->i_size - 1;
-		res = hfs_write_begin(NULL, mapping, size + 1, 0, &folio,
-				&fsdata);
-		if (!res) {
-			res = generic_write_end(NULL, mapping, size + 1, 0, 0,
-					folio, fsdata);
-		}
-		if (res)
-			inode->i_size = HFS_I(inode)->phys_size;
+	if (WARN_ON_ONCE(inode->i_size > HFS_I(inode)->phys_size))
 		return;
-	} else if (inode->i_size == HFS_I(inode)->phys_size)
+	if (inode->i_size == HFS_I(inode)->phys_size)
 		return;
 	size = inode->i_size + HFS_SB(sb)->alloc_blksz - 1;
 	blk_cnt = size / HFS_SB(sb)->alloc_blksz;
-- 
2.53.0

