Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8A38D3E6;
	Fri, 14 Aug 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725684; cv=none; b=ZykcOjsfJRc6sHwBm6Q0bQHD6dGwwigHpwokXsmPJshzN1Fjk/BbtrE+UcTLT2SCd+XM26h8QkJYJgogKMSr1N3d7GaMgSjk5ogGmjt6p+7NbZ5+rtdfwwYx4J1jR2YOQfvnarGwD1OCI0rsv8ukRLmzB1PP3N5XXAG96VEcvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725684; c=relaxed/simple;
	bh=wKHVuBmK80CZXjMfoeQmwCagH32D3H4+YndHxjn6bZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dk1zIJ9rDcddyOfCI7dl/H4x/xcU6okxE2bYfiiOvHXhoCfJo9iZlucWGQgHlsb0ohAULUUaBLDKhIUKCVeGSE14UnnzwZ8EteoivZuHbQg1Ysm4RCK/CMNAhC2VtFnLowZy2i+CpIWvHmNd/2o+ZCNUGB8J4i4JndbHQOVCZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DVOT1zQH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKwzdoAK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uMBh3hQD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5FxqU5XW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVOT1zQH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKwzdoAK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uMBh3hQD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5FxqU5XW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4636941BB;
	Fri, 14 Aug 2026 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786725607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTNxmZeLae1qCDpLUYCtBOoaN5t3TnHzAI6P1ElnhL8=;
	b=DVOT1zQHiKB5TCefthhWFXRbZ44qI20UDJO5dnpQwx+cijVax+nHNOQcQYl0oZxtQSR7OB
	xt+Zeugek2CP8att2o7ZuXUMnJ1aQQTMIvUl8PXowEPB+j1w6JvNXjsrzTtTj4BbXkpHNK
	EODU54xXWQZBtgr+q5+c9InQNji6ZPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786725607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTNxmZeLae1qCDpLUYCtBOoaN5t3TnHzAI6P1ElnhL8=;
	b=aKwzdoAKctxwcGzB4l7hUluMJujCFNIwCYHHQgb7f5efCULdYkhBKPgS9/BmhEb32ptq7y
	p/x6Bp48OroXmLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786725603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTNxmZeLae1qCDpLUYCtBOoaN5t3TnHzAI6P1ElnhL8=;
	b=uMBh3hQD65OZ/3UQSTJZMnsq5Uk6K773OfeVXaBMNY/AyItxmYp1CUFYHOuJQAl8Swhyrr
	ML61CqlHnOeJlfaR5d6DZ4Y1754ns204H/7L9vvpuC5t1nXxZY7LNJBNPx5718voXDy0Fj
	/9hxGxJ7GNqJKYPFqckLOfX/fGL4q/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786725603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTNxmZeLae1qCDpLUYCtBOoaN5t3TnHzAI6P1ElnhL8=;
	b=5FxqU5XWbRms+OVR6ymp4qoQK59LlPTuURCr9sUaARuEpAzxrskxzlMVeZVB93Jir0Bb4Y
	8TAyLVfvjml/uNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08F3478492;
	Fri, 14 Aug 2026 16:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKoYN+JEf2p8AwAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 14 Aug 2026 16:40:02 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aditya
 Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: Re: [PATCH v3 2/2] io_uring: add fremovexattr and flistxattr support
In-Reply-To: <20260721103514.2716-3-aditya.ansh182@gmail.com>
Organization: SUSE
References: <20260721103514.2716-1-aditya.ansh182@gmail.com>
 <20260721103514.2716-3-aditya.ansh182@gmail.com>
Date: Fri, 14 Aug 2026 12:39:57 -0400
Message-ID: <87v79c4pwi.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,kernel.org,zeniv.linux.org.uk];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,mailhost.krisman.be:mid]

Aditya Prakash Srivastava <aditya.ansh182@gmail.com> writes:

> Add support for IORING_OP_FREMOVEXATTR and IORING_OP_FLISTXATTR. This
> enables xattr listing and removal operations to be executed in an
> asynchronous fashion.
>
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

Jens has made a point about avoiding new commands just punting to the wq
at [1].[1] https://github.com/axboe/liburing/issues/1492#issuecomment-4683773809

In this case, we have an immediate issue for inline submission with
acquiring the mount and the inode lock and there is no callbacks so we
are not really in good shape to work around it.  Beyond that...


> ---
>  include/uapi/linux/io_uring.h       |  2 +
>  io_uring/opdef.c                    | 18 +++++++
>  io_uring/xattr.c                    | 74 +++++++++++++++++++++++++++++
>  io_uring/xattr.h                    |  6 +++
>  tools/include/uapi/linux/io_uring.h | 13 +++++
>  5 files changed, 113 insertions(+)
>
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 909fb7aea638..805f1e31f492 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -318,6 +318,8 @@ enum io_uring_op {
>  	IORING_OP_PIPE,
>  	IORING_OP_NOP128,
>  	IORING_OP_URING_CMD128,
> +	IORING_OP_FREMOVEXATTR,
> +	IORING_OP_FLISTXATTR,
>  
>  	/* this goes last, obviously */
>  	IORING_OP_LAST,
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 4e58eb1344ea..25d9229d8fc0 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -591,6 +591,16 @@ const struct io_issue_def io_issue_defs[] = {
>  		.prep			= io_uring_cmd_prep,
>  		.issue			= io_uring_cmd,
>  	},
> +	[IORING_OP_FREMOVEXATTR] = {
> +		.needs_file		= 1,
> +		.prep			= io_fremovexattr_prep,
> +		.issue			= io_fremovexattr,
> +	},
> +	[IORING_OP_FLISTXATTR] = {
> +		.needs_file		= 1,
> +		.prep			= io_flistxattr_prep,
> +		.issue			= io_flistxattr,
> +	},
>  };
>  
>  const struct io_cold_def io_cold_defs[] = {
> @@ -849,6 +859,14 @@ const struct io_cold_def io_cold_defs[] = {
>  		.sqe_copy		= io_uring_cmd_sqe_copy,
>  		.cleanup		= io_uring_cmd_cleanup,
>  	},
> +	[IORING_OP_FREMOVEXATTR] = {
> +		.name			= "FREMOVEXATTR",
> +		.cleanup		= io_xattr_cleanup,
> +	},
> +	[IORING_OP_FLISTXATTR] = {
> +		.name			= "FLISTXATTR",
> +		.cleanup		= io_xattr_cleanup,
> +	},
>  };
>  
>  const char *io_uring_get_opcode(u8 opcode)
> diff --git a/io_uring/xattr.c b/io_uring/xattr.c
> index 5303df3f247f..9b410f91ef43 100644
> --- a/io_uring/xattr.c
> +++ b/io_uring/xattr.c
> @@ -195,3 +195,77 @@ int io_setxattr(struct io_kiocb *req, unsigned int issue_flags)
>  	io_xattr_finish(req, ret);
>  	return IOU_COMPLETE;
>  }
> +
> +int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
> +	const char __user *name;
> +	int ret;
> +
> +	INIT_DELAYED_FILENAME(&ix->filename);
> +	name = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +
> +	if (READ_ONCE(sqe->addr2) || READ_ONCE(sqe->len) || READ_ONCE(sqe->xattr_flags))
> +		return -EINVAL;

There are more fields to be rejected here, check the latest patches from
Yi Xie such as cc609376e9a4 ("io_uring/fs: check unused sqe fields for
unlinkat").

> +
> +	ix->ctx.kname = kmalloc_obj(*ix->ctx.kname);
> +	if (!ix->ctx.kname)
> +		return -ENOMEM;
> +
> +	ret = import_xattr_name(ix->ctx.kname, name);
> +	if (ret) {
> +		kfree(ix->ctx.kname);
> +		return ret;
> +	}
> +
> +	req->flags |= REQ_F_NEED_CLEANUP;
> +	req->flags |= REQ_F_FORCE_ASYNC;

This will cause the cleanup to call io_xattr_cleanup, which does kfree
on ix->ctx.kvalue, which is never initialized.  If it has garbage from a
previous command in the kiocb cmd space, you can craft a corruption or,
more likely, a crash.


> +	return 0;
> +}
> +
> +int io_fremovexattr(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
> +	int ret;
> +
> +	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
> +
> +	ret = file_removexattr(req->file, ix->ctx.kname);
> +	io_xattr_finish(req, ret);
> +	return IOU_COMPLETE;
> +}
> +
> +int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
> +
> +	INIT_DELAYED_FILENAME(&ix->filename);
> +	ix->ctx.kname = NULL;
> +	ix->ctx.kvalue = NULL;
> +
> +	if (READ_ONCE(sqe->addr))
> +		return -EINVAL;
> +
> +	ix->ctx.value = u64_to_user_ptr(READ_ONCE(sqe->addr2));
> +	ix->ctx.size = READ_ONCE(sqe->len);
> +	ix->ctx.flags = READ_ONCE(sqe->xattr_flags);
> +
> +	if (ix->ctx.flags)
> +		return -EINVAL;
> +
> +	req->flags |= REQ_F_NEED_CLEANUP;
> +	req->flags |= REQ_F_FORCE_ASYNC;
> +	return 0;
> +}
> +
> +int io_flistxattr(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
> +	int ret;
> +
> +	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
> +
> +	ret = file_listxattr(req->file, ix->ctx.value, ix->ctx.size);
> +	io_xattr_finish(req, ret);
> +	return IOU_COMPLETE;
> +}
> diff --git a/io_uring/xattr.h b/io_uring/xattr.h
> index 9b459d2ae90c..d2487b49a5d2 100644
> --- a/io_uring/xattr.h
> +++ b/io_uring/xattr.h
> @@ -13,3 +13,9 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags);
>  
>  int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>  int io_getxattr(struct io_kiocb *req, unsigned int issue_flags);
> +
> +int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
> +int io_fremovexattr(struct io_kiocb *req, unsigned int issue_flags);
> +
> +int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
> +int io_flistxattr(struct io_kiocb *req, unsigned int issue_flags);
> diff --git a/tools/include/uapi/linux/io_uring.h b/tools/include/uapi/linux/io_uring.h
> index f1c16f817742..79bf7c22009d 100644
> --- a/tools/include/uapi/linux/io_uring.h
> +++ b/tools/include/uapi/linux/io_uring.h
> @@ -253,6 +253,19 @@ enum io_uring_op {
>  	IORING_OP_FUTEX_WAIT,
>  	IORING_OP_FUTEX_WAKE,
>  	IORING_OP_FUTEX_WAITV,
> +	IORING_OP_FIXED_FD_INSTALL,
> +	IORING_OP_FTRUNCATE,
> +	IORING_OP_BIND,
> +	IORING_OP_LISTEN,
> +	IORING_OP_RECV_ZC,
> +	IORING_OP_EPOLL_WAIT,
> +	IORING_OP_READV_FIXED,
> +	IORING_OP_WRITEV_FIXED,
> +	IORING_OP_PIPE,
> +	IORING_OP_NOP128,
> +	IORING_OP_URING_CMD128,
> +	IORING_OP_FREMOVEXATTR,
> +	IORING_OP_FLISTXATTR,

I'd rather these (minus the xattr ones) go in a separate fix patch ahead of
the series...

-- 
Gabriel Krisman Bertazi
