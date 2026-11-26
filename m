Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704145;
	b=WQ103azIlpSvtYUGH2h3DfuVg6ghD6zozgJ9gIX3ZqYaawpl7nMfz/pjw5jZ2VLchKGE
	 7bqwXIsl6/BvqH7aNjz4HMSDQ/762T3Ao9jKxO/Y5bN9+ubf27EQT1QOZaHSRL3apCssK
	 ZPwUh8Q2PGJuQGUGs1WhlneD7KgjDv6PvhhuMhwoNNFDttpXfSyTkqUdJFGQwQn/d2JRY
	 cLiGDwEElhiogv7GZLeSgTlWb+MYnwk/Xkma8u6y+ohs7YwggCIyBKctPCaZz4sdRir/h
	 G189vjjltnbpEcK9geLKqZ6icl5H3B7FKyv+x7FD2gyVXI9vJtUEkH1V7W+eXsMmNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704145;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=X+UEfdPlPHSdpvtar/pMrv8c8styrKwg7W1Xm8SQCis=;
	b=DW1Bv5InSUqHv0Br4Zj2PYXBgRGZ69fPHCQ4goC+W2Uifv9NO7G0CZkEjuZX1nZJYIJ8
	 kfZ4opH/ypp60Ofy/JJvkkYCFRsgvaLXvfA1N/TdYb4+g9iqpQJdfN0o5Ro6X2YcyNKKj
	 GDOdM3x6iWDyukii8WGXkzOzg8lE3H7UdTNlaNVfn1mIJKDcDg8QzFNOr5L5mqZGUnOE0
	 fgHu7CRUh6YeIynd069ZZRNi4rTIMmB/fJaLILbtuOTynuXg6QoUnM+XP+g1sxu9TPZI7
	 PwEAzbxXdBYYQDAqwXArU/Rsdy7nMz9xITMX10i+GOlPTeBS2hpdHfLZFzOtiu4+8xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Axy9WtE2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F3606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 14:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Axy9WtE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UEfdPlPHSdpvtar/pMrv8c8styrKwg7W1Xm8SQCis=;
	b=Axy9WtE25PMZ0S+oDUA6EvxlrmclA42luLa53rzWMDG13UVkyxA9eJi0Glf22n8V8boa7T
	n4BW+llp6ZM3xYUHuC+NpODkxcZoPPmRQ4+UlBgoeKdVkcaSZ7SLjkpq8PmhKoZYt8xplw
	BiEtXr7EiBv4GxJT21h8ujXSoNn7y3A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-ELcWVIXGPbC36g1IkrAzzw-1; Thu,
 26 Nov 2026 14:42:17 +0000
X-MC-Unique: ELcWVIXGPbC36g1IkrAzzw-1
X-Mimecast-MFC-AGG-ID: ELcWVIXGPbC36g1IkrAzzw_1795704135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B88F180025C;
	Thu, 26 Nov 2026 14:42:15 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9644118011E6;
	Thu, 26 Nov 2026 14:42:12 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 26 Nov 2026 15:42:15 +0100 (CET)
Date: Thu, 26 Nov 2026 15:42:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, adobriyan@gmail.com,
	jannh@google.com, jack@suse.cz, sforshee@kernel.org,
	me@black-desk.cn, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: also check the opener's capability for
 oom_score_adj and oom_adj
Message-ID: <awhFQzXfWnDh1mKe@redhat.com>
References: <20261126045222.20770-1-dennylin0707@gmail.com>
 <awgPDmEbGpJsT_iS@redhat.com>
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
In-Reply-To: <awgPDmEbGpJsT_iS@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I just noticed that __set_oom_adj() has more CAP_SYS_RESOURCE checks below.

Shouldn't we unify them or even factor out?

Oleg.

On 11/26, Oleg Nesterov wrote:
>
> On 11/26, Hungyu Lin wrote:
> >
> > __set_oom_adj() checks CAP_SYS_RESOURCE against the task that calls
> > write(). A task without the capability can open its own
> > /proc/<pid>/oom_score_adj or /proc/<pid>/oom_adj and have a privileged
> > process write to that file descriptor, for example a set-user-ID
> > program that inherits it as standard output. The write then lowers the
> > value below oom_score_adj_min, down to OOM_SCORE_ADJ_MIN, which the
> > opener is not allowed to do.
> >
> > Require the capability from the opener of the file as well as from the
> > writer: check file_ns_capable()
>
> Looks reasonable but
>
> > in addition to capable().
>
> do we really need to keep the old capable(CAP_SYS_RESOURCE) check?
>
> If a privileged opener of /proc/<pid>/oom_score_adj passes fd to
> to unprivileged writer, we probably don't care?
>
> Just in case, I am not saying that the old check should be removed,
> I am trying to understand.
>
> Oleg.
>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  fs/proc/base.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index e6d54193b9f5..42e4645899fe 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1099,7 +1099,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  	mutex_lock(&oom_adj_mutex);
> >  	if (legacy) {
> >  		if (oom_adj < task->signal->oom_score_adj &&
> > -				!capable(CAP_SYS_RESOURCE)) {
> > +				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
> > +				 !capable(CAP_SYS_RESOURCE))) {
> >  			err = -EACCES;
> >  			goto err_unlock;
> >  		}
> > @@ -1112,7 +1113,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  			  task_pid_nr(task));
> >  	} else {
> >  		if ((short)oom_adj < task->signal->oom_score_adj_min &&
> > -				!capable(CAP_SYS_RESOURCE)) {
> > +				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
> > +				 !capable(CAP_SYS_RESOURCE))) {
> >  			err = -EACCES;
> >  			goto err_unlock;
> >  		}
> >
> > base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
> > --
> > 2.43.0
> >
> >

