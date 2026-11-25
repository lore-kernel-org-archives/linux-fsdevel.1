Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630103;
	b=m2y2cGJJG2fSovZo85Wm9XYivabq5bo1vnjOGQIVpILlkPIE80HbdcSBXakuNI4wuTQs
	 vtqg7J6bapUkkHJ31HTrsFLY8Nw+/y4pBL2iGa7W/JIaJTDrRIjV8wcibIk0HbpzxTMBf
	 ucjATp2cSo+ZMKeuxBpKDp/uIgCz3qpy3lMvQfVGU3+i4oEKpANxUeQgt8Nl4vv+C+xlZ
	 dj/WFQP0n0TX5ydEMgAg5IIgYHF0p6vgNNKWBvWOzRPc1gY64F4bEzrLcRuXrQ7o/VGBC
	 /6zkgvisq33UcbNr3hEOKDfwHKx/v6+CaeWgpFtrPkiiGSKmEtYsqKeoJ15oo15eQ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dHM8QuM6MY/pSqOPOop7gPxP9CND5feIuBhfsBIhnlk=;
	b=2Axhq3BqzBxtgIn1xOEe1qKDiRbYFl8Zk9YofAgq342uP2Jn3Dew3tN8waLGiIvWxQ3f
	 5wzboI22iU03F6McDzgzcGSVOgLjg1suPwRWnKX/9z07291Tp4AlHnllm6GRJbky39UgZ
	 +lYqJ+l6JNrybwS3sLZzYs8IFS98i4AYahtVe60LjqFkajL9Cetj33hkiWJCN9tgy0Alw
	 kSxLgXCd8rbX9ixTkE9ArdgEJy9eH5aPyO+mRZ9wsjISJc2mHD5K4ZNtPdMLBcO/Hga6h
	 XlvFrzZm6/ulR5nwjtuJdjYJmgB1R/jK5wNeA2GilQoCNYGB1K4djLw7ghNg3ye0j4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Pw1yTcSe;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C557606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C557606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Pw1yTcSe
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67be1e468a8so5893293d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795630101; x=1796234901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHM8QuM6MY/pSqOPOop7gPxP9CND5feIuBhfsBIhnlk=;
        b=Pw1yTcSew1tJWPymC+EtTRZkEr+5tKy29+ynnVbyUao6v1cTb3h2c86QP8jy2LO7iB
         v3EGy9XAL8lNHqht6WJpIjOhlALmCvzgkursP11zUP4ceia2Bf5Px8hg00FFcASj07FI
         co0UQR4YEGuawnGC/1HPrkLdeTp/NImxuNm2SK7ZieoqZyw+TCeGN6u8+dBG7Gfyvfts
         FxNKHYh7zU5qp2y3JDdtDm85fOcJb3tYbJVAXetO70nLmk/mDWj60TXlkRC3Vw9uZONM
         C8gKtG6H7Qm9+1xB8dKpGvgZcu2SXU7jH9RaP4y7R8bPA8NbPUse1zMMOH1hi+BnjN3P
         ubww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630101; x=1796234901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHM8QuM6MY/pSqOPOop7gPxP9CND5feIuBhfsBIhnlk=;
        b=vIKHPvw/8ZnqswTbLAbYP39I5dte7j09jokgGLTzjfaERZlY0PrjPj5o7Nb2BaIj2M
         rc3419GWwK5EeyFA6WfQAgUyKDXNGzGDJtMFpFh/pcR442zF6LMVFi1eu7C7hdBXiUqP
         OFn36E7u56Ed0ugiPnCb5dQ11nOdyOoV8wKGD4/lam+vQEuf7p7I87zJdAwu0Maee06u
         mMPs7RCUBGE/imb4wrlfnz/YN2Cp5KXFR6KEduOC1NnEasvNab+SVhMkcvpLBmFgEyqY
         V/UTtorPjOfItuYpRQa0Wp2p4hUSVktaobiNSfa6l8gZeyu27nTHCqKILUxL74LCVSX2
         lRsA==
X-Forwarded-Encrypted: i=1; AL+hErELM5TgWxxPGyE55X4V1pfDusLj2V21QGXiulu+P8wih6nAar+4SsD45oxDrN4yCZZQES7wnM493iCpjKOh@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yef4e8a90276yx2cQrPKisfOzfFAKjfWmfmcTQAKP7GUbQHZ9
	lTLDO/d6pf1HxAEanbr/Sc1/5/sQ4SM0MdLJlZ8yefiKdnLoJ2ZL9m6iGYp1hn0uDQ==
X-Gm-Gg: AZFdTZcsyRbyVy1Iz8s/bo6j7hki5PWE+Z/1GPNyPU80qX591mwymFHMhgxtFHC5zHA
	Mm9HBVjDloS4B2Wy4Ce9jt8e0+rzpx5QlDT9lq7tp3lSNejITkoNCn6n9jM2G2Ui1cUj+DhKy2r
	71x7ALVGscYy1qcSofNMSUHY10SVcqnKPBr8QT9zXHzrxsnlfc5uTaD5qlXYhRililqm1qM/487
	q5orDFPuG9vhw+9v9k/ffBjJirinEXsHT+nZVT30Xi+uMCDVbttvqckSJD00yIH0sgRfauryuQN
	tyy9EH7XEm3I6kh7cclPJcKpaE6aQeL4L2pUGnetXNCGpDA1JGu5d2nwMT440RTJZ58mG73Lmmr
	42uTPlsaSr5sDPNvtxSJYGbgawLxvY4AMelrbEEJUKwkfDytXcDBQ3R2feH+QWt56th8YRPnCj/
	JxPWtcz241fZqeijZ253O2janIoim1leYQXOaolDEL1ki2YsgSARpL0pr+bNZTia4XakFeuIwDn
	oD1QTQNFphoTbulAyTEIN5Ll8sDNOeDuCD6RpfH9SoP0dWZfVYT3jMtgz04FHA7FN6lUhMo85Am
	e83ULD3cVHY1GQcus9uZXv34Hl2ECwvgu8l0QYi0dsjyORWr9y3jEZWVfjnQH36Rlhw8GpbPeQ=
	=
X-Received: by 2002:a05:690e:1247:b0:67d:ebad:8ca2 with SMTP id 956f58d0204a3-67df4410cabmr7287298d50.53.1795630101276;
        Wed, 25 Nov 2026 10:08:21 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df337bfd7sm9193210d50.15.2026.11.25.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:08:20 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/openclose: allow an empty path with O_EMPTYPATH
Date: Wed, 25 Nov 2026 13:08:17 -0500
Message-ID: <20261125180817.3682397-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
made build_open_flags() accept O_EMPTYPATH and turn it into
LOOKUP_EMPTY, so that openat(fd, "", O_EMPTYPATH) reopens the file
behind fd.

However, io_uring also uses build_open_flags(), but __io_openat_prep()
still copies the name with delayed_getname(), which rejects an empty
name with -ENOENT. As of now, IORING_OP_OPENAT and IORING_OP_OPENAT2
accept O_EMPTYPATH, but fail on the empty path this flag is meant for.

The issue can be reproduced with this program:

    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <liburing.h>
    #include <stdio.h>

    #ifndef O_EMPTYPATH
    #define O_EMPTYPATH (1 << 26)
    #endif

    int main(void)
    {
            struct io_uring ring;
            struct io_uring_sqe *sqe;
            struct io_uring_cqe *cqe;
            int fd = open("/etc/passwd", O_PATH);

            printf("openat: %d\n", openat(fd, "", O_RDONLY | O_EMPTYPATH));

            io_uring_queue_init(1, &ring, 0);
            sqe = io_uring_get_sqe(&ring);
            io_uring_prep_openat(sqe, fd, "", O_RDONLY | O_EMPTYPATH, 0);
            io_uring_submit_and_wait(&ring, 1);
            io_uring_peek_cqe(&ring, &cqe);
            printf("IORING_OP_OPENAT: %d\n", cqe->res);
            return 0;
    }

Before that commit (v7.1), both calls fail: it prints "openat: -1" and
"IORING_OP_OPENAT: -2". After that commit (v7.2), the result is:

    openat: 4
    IORING_OP_OPENAT: -2

This patch will copy the name with delayed_getname_uflags() and
AT_EMPTY_PATH when O_EMPTYPATH is set, as io_uring's statx already does
for AT_EMPTY_PATH.

Fixes: 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on io_uring-7.4 (0659e44ce739) with KASAN and lockdep. A test
that runs 24 cases through IORING_OP_OPENAT/OPENAT2 and through
openat(2)/openat2(2) now gets the same result from both (32 of 42
results differed before). The cases include O_PATH and regular fds,
AT_FDCWD, forced async opens, RESOLVE_CACHED, a direct descriptor slot,
a bad pointer and an unprivileged reopen of a 0600 file (EACCES). The
liburing open tests and the openat2 selftests pass on both kernels.

 io_uring/openclose.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 24cf3ce2e2bc..29fe31f16a2b 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -54,6 +54,7 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 {
 	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
 	const char __user *fname;
+	int uflags = 0;
 	int ret;
 
 	if (unlikely(sqe->buf_index))
@@ -67,7 +68,9 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 
 	open->dfd = READ_ONCE(sqe->fd);
 	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
-	ret = delayed_getname(&open->filename, fname);
+	if (open->how.flags & O_EMPTYPATH)
+		uflags = AT_EMPTY_PATH;
+	ret = delayed_getname_uflags(&open->filename, fname, uflags);
 	if (unlikely(ret))
 		return ret;
 	req->flags |= REQ_F_NEED_CLEANUP;

base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d
-- 
2.53.0

