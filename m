Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690267;
	b=OYkfIVyGKYyfLGdMNwNRul1ePchAsZKA5GWN7PMILSg7TNqlKhUd55suG3U5gSjW1uiW
	 4ziIOGlll3/zetQom+302Zyrgrw/f498lVzgR3m7qbaSjHhyFhkPy2Mu2clBU7bg83cnk
	 2jKvNblnMuHGAm9UW9jvAiVD4o/+gwwyjB5gtpFme1vSgWh3rRE3ckue4kqWU9DKBlwVf
	 THRlwoYW06LEhK/5jKGozipOtTKJuPFhHpF3C0TJ/pKYcCpvOGZvvyZISrgp8p77JoEmT
	 B3F4LB7xBM0eBpV8Ne1Tuu5HtyKXu3FQ+kjNmQBaTOedVVVpBaCctzRXbeGLF388WQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690267;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=CVdSbvuqngFGYkMK81UV44VU4VJLlbgtcDVIbEqpauw=;
	b=MJ3EdTNaIG+oyO59FFcLCcMkv60shfhbiCN/CjfPcwNas4oEmScDVpnvubLz5OjYrzrO
	 Z/wy2EvjSa+KkN0Yy+/mM6u5S3qrIycyy2SBtMEDy/ezfUEbMb7hBFjmsuqKPpAqslkmK
	 n2pz5c1KZiBZEa9Hq+UYV0KaS3EFvEWtiBEHbr4iYQYiNl7mUBEqR+b93iALdkx3mJ3zq
	 u3NCznD+rrlk+oXIaETntWc6YF/p7i1Vf3ZvXYelWAwawLqKsvMNvSJMrmIwUoGOCkr5+
	 XpcAGgvyfOTdeqw+5TS0Y2jNfIXih4FI/7OEHlYunu7l/dF/+gGsrxCjAMpTPga2DWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IYJd8X59;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612B606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 10:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E612B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IYJd8X59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795690265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVdSbvuqngFGYkMK81UV44VU4VJLlbgtcDVIbEqpauw=;
	b=IYJd8X5949IVd58RBuWCW7n186CS/xQR0azC2dKXdW9ZwehZiVH7h9PbDkPKMrI1hGcj+/
	Sq63yslPwr63DhmGS76uz1dRttqyynJAou6RT7T4HXeIKGN1F0Ozqur+Q+Ik9QFmbvO7Xz
	Hx/mg3rySJLLkvKuyKTq00obaKi3ndg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-NdibSaJiMeOeqtEyoPb28A-1; Thu,
 26 Nov 2026 10:51:00 +0000
X-MC-Unique: NdibSaJiMeOeqtEyoPb28A-1
X-Mimecast-MFC-AGG-ID: NdibSaJiMeOeqtEyoPb28A_1795690259
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC7991955E7F;
	Thu, 26 Nov 2026 10:50:58 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 03D62428;
	Thu, 26 Nov 2026 10:50:55 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 26 Nov 2026 11:50:58 +0100 (CET)
Date: Thu, 26 Nov 2026 11:50:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, adobriyan@gmail.com,
	jannh@google.com, jack@suse.cz, sforshee@kernel.org,
	me@black-desk.cn, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: also check the opener's capability for
 oom_score_adj and oom_adj
Message-ID: <awgPDmEbGpJsT_iS@redhat.com>
References: <20261126045222.20770-1-dennylin0707@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126045222.20770-1-dennylin0707@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/26, Hungyu Lin wrote:
>
> __set_oom_adj() checks CAP_SYS_RESOURCE against the task that calls
> write(). A task without the capability can open its own
> /proc/<pid>/oom_score_adj or /proc/<pid>/oom_adj and have a privileged
> process write to that file descriptor, for example a set-user-ID
> program that inherits it as standard output. The write then lowers the
> value below oom_score_adj_min, down to OOM_SCORE_ADJ_MIN, which the
> opener is not allowed to do.
>
> Require the capability from the opener of the file as well as from the
> writer: check file_ns_capable()

Looks reasonable but

> in addition to capable().

do we really need to keep the old capable(CAP_SYS_RESOURCE) check?

If a privileged opener of /proc/<pid>/oom_score_adj passes fd to
to unprivileged writer, we probably don't care?

Just in case, I am not saying that the old check should be removed,
I am trying to understand.

Oleg.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/proc/base.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index e6d54193b9f5..42e4645899fe 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1099,7 +1099,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	mutex_lock(&oom_adj_mutex);
>  	if (legacy) {
>  		if (oom_adj < task->signal->oom_score_adj &&
> -				!capable(CAP_SYS_RESOURCE)) {
> +				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
> +				 !capable(CAP_SYS_RESOURCE))) {
>  			err = -EACCES;
>  			goto err_unlock;
>  		}
> @@ -1112,7 +1113,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  			  task_pid_nr(task));
>  	} else {
>  		if ((short)oom_adj < task->signal->oom_score_adj_min &&
> -				!capable(CAP_SYS_RESOURCE)) {
> +				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
> +				 !capable(CAP_SYS_RESOURCE))) {
>  			err = -EACCES;
>  			goto err_unlock;
>  		}
> 
> base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
> -- 
> 2.43.0
> 
> 

