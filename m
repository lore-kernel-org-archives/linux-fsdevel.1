Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642048;
	b=nNWVYCHxkq3K6h1y5szK2hz6jO8OU4vzuzyJY1Cf0C+NtxZXGfirxy54RqFKcfPIwDIy
	 91XMaNPqPLfn5tN1qqq0oBhCa8F/aqXNFXkDQR4dgLVu3LMNfRX2LQcJUjgAiAOlTV7Fr
	 nC3O3iU9XAMsENt1qJzYPOucnFOA4AvbodSw+YfUNWY2VMubBv9URnyr8/JBHsMj4/rGp
	 QkbO0H7m3X1Nne8fTO/BgdXYprXHiMVoiBVnEnfgThcVQZcz67vW7/lCMDqW1NkhGZ2O1
	 jaS2MbrN6x6e5ufMYd2du4AMbvD3+ejgl+g8YHlcXwrI8pZpnxYY6IfXk+zdQwYsR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642048;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=Wkz/I9/uycoNpfb2ILPsq2+UwaDmVC8MrE9vadsgTkk=;
	b=YhyquRBZmdb4V6WoSB18gqeTaMGAdOtV/ccwiv464s/7bZqsRx/5zPj9Kz0I8qe8iRQC
	 OvIZ+G5K/uEcPR/ap0a0YjS6gkZOLT2Mmn2Z/gIEmVnFvJpPcOE+D7fF3EbG112xLJJQR
	 2/0WhPcX7NmrRY2RCCJUOPcWsVInEgYI8nNueF04+nDqN9avxFY5oHA1RoSiaFg9d9J2P
	 QCr4/GqLqZ7j062ZoX64halelBQkkeFNRrxVE0J1ZmQPl2cN7jVgeukR5UE+icyDWQtVA
	 mlOdhLQ8+ZGIde0kv7GKJ9KtLzFh5LY9jq4seFwofX6BRKApox/OaK2nhFjWMN4CP4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=mNy0v0Zu;
	arc=none smtp.remote-ip=195.121.94.183
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF6606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDFF6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=mNy0v0Zu
X-KPN-MessageId: fcca9c92-e916-11f1-8e5e-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fcca9c92-e916-11f1-8e5e-005056992ed3;
	Wed, 25 Nov 2026 22:27:16 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id fcc98153-e916-11f1-be6a-00505699693e;
	Wed, 25 Nov 2026 22:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Wkz/I9/uycoNpfb2ILPsq2+UwaDmVC8MrE9vadsgTkk=;
	b=mNy0v0ZuaAX/i5Gh6Wud0W/kVa5l1yBLQM+mdeiUH0J/r8rzv7RgKkXq8BHWglsJUq1nYjr5Pfgot
	 aUkLZyo7FMLanK6hISDNmwoh9eGwhvU8xJCLjsuhz/msGi5r+UzOgbS2zDQs82h6uPIAHbwsm6CjQL
	 9dwKf6Z9hTDqWtCghwAZqsoRPrkF9Do/dFJ2F1KoZJF5jZmK0INlvWMiaz1knQw8Ym2AYVgg5fUY5Y
	 KtUckGLwF5O7XKqje5ymw5xn4RnOgDuHjLXqBToZQBsF2UAUHVSBkArvfNUXG6fzubd45oYfYYZY/i
	 Ux8y21JiZHDgGS9XghsZITgp3O5HmtA==
X-KPN-MID: 33|YyG/3koVDQrbm+KMSsajlXfp57Gs1QqJxUYCnezE0qtAa+YT66UPutjebbpOqB4
 mQJ/GD++ObdnysO6QWvEhnOHosK/0lXjYUK7Cg4fRAGM=
X-CMASSUN: 33|GapsSioku5fVb9d+9lY8Dg9MIm4SfPm+R+aKKWQG1/5oRn/ta4T5HFx4qek3+ip
 s5p7WWHFTX8kwRIxjByA1MQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id fcbf625d-e916-11f1-acfd-00505699eff2;
	Wed, 25 Nov 2026 22:27:16 +0100 (CET)
Date: Wed, 25 Nov 2026 22:27:16 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Hengyu Liang <hengyul@cs.unc.edu>, Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <170898867.2781789.1795642036410@kpc.webmail.kpnmail.nl>
In-Reply-To: <20261125180817.3682397-1-hengyul@cs.unc.edu>
References: <20261125180817.3682397-1-hengyul@cs.unc.edu>
Subject: Re: [PATCH] io_uring/openclose: allow an empty path with
 O_EMPTYPATH
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 25-11-2026 19:08 CET schreef Hengyu Liang <hengyul@cs.unc.edu>:
> 
>  
> Commit 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
> made build_open_flags() accept O_EMPTYPATH and turn it into
> LOOKUP_EMPTY, so that openat(fd, "", O_EMPTYPATH) reopens the file
> behind fd.
> 
> However, io_uring also uses build_open_flags(), but __io_openat_prep()
> still copies the name with delayed_getname(), which rejects an empty
> name with -ENOENT. As of now, IORING_OP_OPENAT and IORING_OP_OPENAT2
> accept O_EMPTYPATH, but fail on the empty path this flag is meant for.
> 

I think you should leave the reproducer from the commit message.

> The issue can be reproduced with this program:
> 
>     #define _GNU_SOURCE
>     #include <fcntl.h>
>     #include <liburing.h>
>     #include <stdio.h>
> 
>     #ifndef O_EMPTYPATH
>     #define O_EMPTYPATH (1 << 26)
>     #endif
> 
>     int main(void)
>     {
>             struct io_uring ring;
>             struct io_uring_sqe *sqe;
>             struct io_uring_cqe *cqe;
>             int fd = open("/etc/passwd", O_PATH);
> 
>             printf("openat: %d\n", openat(fd, "", O_RDONLY | O_EMPTYPATH));
> 
>             io_uring_queue_init(1, &ring, 0);
>             sqe = io_uring_get_sqe(&ring);
>             io_uring_prep_openat(sqe, fd, "", O_RDONLY | O_EMPTYPATH, 0);
>             io_uring_submit_and_wait(&ring, 1);
>             io_uring_peek_cqe(&ring, &cqe);
>             printf("IORING_OP_OPENAT: %d\n", cqe->res);
>             return 0;
>     }
> 
> Before that commit (v7.1), both calls fail: it prints "openat: -1" and
> "IORING_OP_OPENAT: -2". After that commit (v7.2), the result is:
> 
>     openat: 4
>     IORING_OP_OPENAT: -2
> 
> This patch will copy the name with delayed_getname_uflags() and
> AT_EMPTY_PATH when O_EMPTYPATH is set, as io_uring's statx already does
> for AT_EMPTY_PATH.

It ain't a sin, but try to avoid "this patch" references.

> 
> Fixes: 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> I found this while comparing the behavior of different kernel versions.
> I used an LLM to analyze the problem and to draft the patch and this
> message, and I analyzed the result myself.
> 
> Tested on io_uring-7.4 (0659e44ce739) with KASAN and lockdep. A test
> that runs 24 cases through IORING_OP_OPENAT/OPENAT2 and through
> openat(2)/openat2(2) now gets the same result from both (32 of 42
> results differed before). The cases include O_PATH and regular fds,
> AT_FDCWD, forced async opens, RESOLVE_CACHED, a direct descriptor slot,
> a bad pointer and an unprivileged reopen of a 0600 file (EACCES). The
> liburing open tests and the openat2 selftests pass on both kernels.
> 
>  io_uring/openclose.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index 24cf3ce2e2bc..29fe31f16a2b 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -54,6 +54,7 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>  {
>  	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
>  	const char __user *fname;
> +	int uflags = 0;
>  	int ret;
>  
>  	if (unlikely(sqe->buf_index))
> @@ -67,7 +68,9 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>  
>  	open->dfd = READ_ONCE(sqe->fd);
>  	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
> -	ret = delayed_getname(&open->filename, fname);
> +	if (open->how.flags & O_EMPTYPATH)
> +		uflags = AT_EMPTY_PATH;
> +	ret = delayed_getname_uflags(&open->filename, fname, uflags);
>  	if (unlikely(ret))
>  		return ret;
>  	req->flags |= REQ_F_NEED_CLEANUP;
> 
> base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d
> -- 
> 2.53.0

Reviewed-by: Jori Koolstra (CIQ) <jkoolstra@xs4all.nl>

@Jens - You've pulled this already, I don't know if io_uring appreciates reviews
after pull. Let me know if not.

Thanks,
Jori.
