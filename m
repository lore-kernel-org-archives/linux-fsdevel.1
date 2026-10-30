Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334561;
	b=LA03UER5u/y6ds5+FOViTpL+R86E4zvkPhrQUDD2cYTD9fOg7zBho9OfVfdRzR7xmcWn
	 kMakx5lf12B+dgD11jb27Xqz8SZ1dFaazmsE71UrQVqt4tnPL0socUCYNKOxtDRYgHxQB
	 J7qJFtjw3kzeDlVkza6qt1IkNTC4HMUIcLM8nrZNL6jWWLnGk/MrxNqof00+EXXNuj6M2
	 EZNL9vmFz1vwRzd8xfa8RsIhUsSx/J+G4CpLojX3uHqJN4BYqoMnKRBbpK3LUnIfKRbRv
	 h2Z0NsoPc7dIWdOoWxziKIv3b3Fa1SzM1H789yctTsu6VZHaDFpCzB6uGGRlDrb5lJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WAgjRnjnnTYEYGCit5YnSshprwmU8petoCTh8/Dj9t8=;
	b=N1zAmRVrvVa/0taVAt3PDNgC98vR3BLV3At2wv36WchYJLB+dyMgxa5rF6K43X/kYonx
	 JUL8AyIVjEZJz1yRpWX/3T7MRbZ9WR7ScEUrIS9tkDllrk9uJMb+BlCBZosa/62SpBBji
	 FPTZDg9aHHB+YXzpQgduBDoECrNSLcKAgmZhvTDYLIuuRByD6OBf8RQkZz4kmNP2MyHm+
	 RfGAMJf/hh61/Bcaib0HCMapEH8skZpAts+fSvSMio/BOTVXVwmpZILI28FFSTEYG+IGC
	 f4UJaTEF4YTkVIWy0nyuyR1jO/u01Dh9C/af9mYvqo+ltjST04QaDOUxV7XHaXJUG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=V1kHecWQ;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00499606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00499606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=V1kHecWQ
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c9cfd8b1bso3901896d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793334560; x=1793939360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAgjRnjnnTYEYGCit5YnSshprwmU8petoCTh8/Dj9t8=;
        b=V1kHecWQpbCK2IinlXdXNiWGNXKdn9T2qVdSNVWh67zBaPILWWK7YmAPnGBWrMDfQQ
         neN3fkE1j85jaHkfDolxgieFQn6tzj1AE8B8N7JueLTE8IVyw4iuc9VbQJGl/1IEkt2D
         TG2TFCL6ozUtc8ZZTJGMqdjZPggzfEgRVT5SbHWjPiQqqnkmuN/V6yZRwd5wwBSL2cJQ
         eFmqVyYWQ86znE6OoFzpP75Uo3rKoYancp+CgJFBRk7DpGDthr69FzCRgnZMC+TZnyWC
         CNcR62CXss8xvpe1r2zSApXhoO0S1tPWrNPj9SMlpNS2iPNHyKxfNOGiz/7ZNH6GF0QO
         nmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334560; x=1793939360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WAgjRnjnnTYEYGCit5YnSshprwmU8petoCTh8/Dj9t8=;
        b=uoYPjhMTn27JMQZc4W3Q/GwnVYgChsmUTznWoSlcLg5ZmUDoLSr+WP0YsmHbah+AXj
         WojPirT4kej31UFcAb+3e3uAnt2bOk4cmx6fRk43FiSmFjZ2F98T0kblH+eX3lgrvIXU
         gKZPxKWzGR1H/l0lENoqqVsU+6s72yTm68CVNjGIzMvSr/ZwnxRI8AEnaSNf1FlV3rnE
         ZAnfuYnYJdtYBRBuzBggrI+P4ZJ0xAhJBXDuT3HFDnud4npDRAsB7D93RftyOFyYk3iz
         KfWynaXgiY1a+yrDKV9QPpj+OqXTQAknc6210tPE9N9j/taZR2B4J6glQXcB1+bBwI1L
         xDnA==
X-Forwarded-Encrypted: i=1; AKwUvBxVbztZFjwBaXKrDHmzV/kKzwTNJgP00/EfWxIhRHEGnpyG4WduihLCyteGnLHOF8F3ouPMrDKdRDZkYHGE@vger.kernel.org
X-Gm-Message-State: AFq9FYIbhhVdiGnwr3UQpIUFAm0YLDqegq8n8NZ+7yQJJ6HnCJrP3izw
	UW8gzFCRcx7TE1nYtJTQsFyJ0XCzjLDw7s+sMRaReVGK2ozVlimQCSyH1wX+cApOorW8mHxHeer
	ggt999Q==
X-Gm-Gg: AYBFou2f/lQRTB6ipLLqsOolVYsptkXplGBvMiSl2nD+J8JAILlvCxtqz+khDFyoCD9
	CI322qLXg/ljnlwg/fA67wBQ+LVYMdgD4fMC7M5XxXlTEOyXXMBmJ6U5ZCZYOPIPGkdah4UHnnD
	0t9DXujmuX9oSYV1ZteCh13UvhrepiTmVi20jfGshKd7juXc8QZ4wAXN2f5PW7YwOO82eLlZ/nk
	G+BjMO4ZZlISDmQ7vlo6AzL6EiL7MrnyncJ5MzarYWi0k51CSoT/8Mu0Hh3DQyGT5ojfnc3IMjQ
	ZnV2BckvghvB0OPc/+gq5kZdnymXocLOR1LGKAUFNb40z2z8u9UIeHU+gCm//Esm8rNRh5EMjzT
	8KfkwEIM3qdJQT9SYfr4EGJb8hfuMXaDuJTUbKt+e8mnDgxUJC+fI7/9Cy9Uic2FPdDsAYyLGWb
	6JaXzyReel3kFVUTf3iPaSTY60Ynm1UI+fPQmYmwYcBh0BwlQoukMfjeI8hxIP5b28WqzR+3OpQ
	CpsxFkrIYsR0+6shJhMh9MbR93IahvZ6jQoHolMgVXi32Y+wVhkSjbg+AVZPxm78TTjed2YnEMm
	xvdwAbVXEOjSCBkrt0A65wA3JM6URzisP3kq0vlKInGvLe51ktpdEsB+QXX3mki1dCZh2dfGGQ=
	=
X-Received: by 2002:a05:6214:4801:b0:917:a253:4f8f with SMTP id 6a1803df08f44-91ca4b6f554mr14970576d6.40.1793334559740;
        Thu, 29 Oct 2026 21:29:19 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254a1sm5058166d6.7.2026.10.29.21.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:29:19 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hfs: fall back to buffered I/O for direct writes past phys_size
Date: Fri, 30 Oct 2026 00:29:02 -0400
Message-ID: <20261030042903.4160506-2-hengyul@cs.unc.edu>
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

hfs_direct_IO() passes direct writes to blockdev_direct_IO(), which
does not go through hfs_write_begin(). When such a write needs a new
block, hfs_get_block() only adds the block size to phys_size. phys_size
starts at i_size when the inode is read, which does not have to be
block aligned, so after the write phys_size is smaller than i_size.

However, at the last close, hfs_file_truncate() sees i_size larger than
phys_size and calls hfs_write_begin() at i_size, which zeroes the file
from phys_size up to i_size. As of now, part of the data that a direct
write has just written past the old end of the file is lost, and fsck
reports no error.

The issue can be reproduced with:

    truncate -s 32M hfs.img
    mkfs.hfsplus -h hfs.img
    mount -t hfs -o loop hfs.img /mnt
    printf 'A%.0s' $(seq 100) > /mnt/f
    umount /mnt
    mount -t hfs -o loop hfs.img /mnt
    xfs_io -d -c 'pwrite -S 0x42 512 512' /mnt/f
    umount /mnt
    mount -t hfs -o loop hfs.img /mnt
    od -An -tx1 -j 512 -N 512 /mnt/f

The last 412 bytes read back as zeros instead of 0x42.

This patch will make a direct write that ends past phys_size fall back
to a buffered write, as fat_direct_IO() and affs_direct_IO() do.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/hfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index d9abab2a1e61..d476a16f4ef9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -139,6 +139,16 @@ static ssize_t hfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	size_t count = iov_iter_count(iter);
 	ssize_t ret;
 
+	/*
+	 * blockdev_direct_IO() does not go through ->write_begin(), so it
+	 * neither zeroes the file from phys_size up to the write nor keeps
+	 * phys_size in step with i_size. Return 0 for a write that ends
+	 * past phys_size, so that it falls back to a buffered write.
+	 */
+	if (iov_iter_rw(iter) == WRITE &&
+	    iocb->ki_pos + count > HFS_I(inode)->phys_size)
+		return 0;
+
 	ret = blockdev_direct_IO(iocb, inode, iter, hfs_get_block);
 
 	/*
-- 
2.53.0

