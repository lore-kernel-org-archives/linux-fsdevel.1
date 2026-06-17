Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165E481642
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712288; cv=none; b=pF7aiZGJgm2L4MOrWkQ6CHtW80hTgn+DTzjiR4jLprFevUFNgJcASK4HN9NSyknAdxa2BEb09JMYdSczftO539ZNh/4hdex6OLEWmM23TpuMw+Y4mc4q8inY70RU8oBmE3LtiwnuQpM//y4ro9eu7GYmgzRQgJo5S0AnYExua9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712288; c=relaxed/simple;
	bh=KOiU33IV2cODyCHRlJgpxMwSvHxKrxsq/G2o98UDqwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt48KFgglR7xKFeqMV4RKFhouRjd7jcm5Y86H0HBKB3LVHFtB+vYHNanGf2gLLxHkU++SnpHuBpxdXb5G2Qk99iVoTl5i02LTzFEwdy3laSigH0+zwjYcdx9hhvedmNhbsB66B4OASDDUQ3dyTj3dnfz2OeuGlYiowhbYJz3SrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAInos6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAInos6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781712276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNlWcD0axJF9L+9kvljyn4/AnuPGjT6Qc1ucnZDV/kc=;
	b=ZAInos6BRA1JwhO02LfQLQVIZq1a/rN/Fik3PgF+xQGU1nJsgLetSW8xADoFz41uigbFZ0
	bSHxJ65uhulKctsLxTECCyhYNwOv5AH93Fb+LTKpVzFJ1/Z0geTB0ZZEYO+qa4oof3RdLg
	sp3/JXggRzTULUbabiMl1R5t9QDT1f4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-kNGru7W5M56lo7O-An6v3A-1; Wed,
 17 Jun 2026 12:04:34 -0400
X-MC-Unique: kNGru7W5M56lo7O-An6v3A-1
X-Mimecast-MFC-AGG-ID: kNGru7W5M56lo7O-An6v3A_1781712270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B7E18009DF;
	Wed, 17 Jun 2026 16:04:30 +0000 (UTC)
Received: from fedora (unknown [10.44.33.75])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 648B119540CE;
	Wed, 17 Jun 2026 16:04:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jun 2026 18:04:30 +0200 (CEST)
Date: Wed, 17 Jun 2026 18:04:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Josh Triplett <josh@joshtriplett.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajLFiIHlSG0KAz5a@redhat.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/17, Mateusz Guzik wrote:
>
> There are trivial touch ups which can be done by adding a bunch of
> predicts and inlining kill_fasync if someone can be bothered.

Speaking of trivial touch ups...

anon_pipe_write() does:

	 * Epoll nonsensically wants a wakeup whether the pipe
	 * was already empty or not.
	 */
	if (was_empty || pipe->poll_usage)
		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);

Again, I have no idea if the unnecessary wakeup affects the performance,
probably not. But somehow this "|| poll_usage" condition looks annoying
to me...

Perhaps it makes sense to change pipe_poll() to not set ->poll_usage
unconditionally?

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..a60be1b71eb7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -760,10 +760,12 @@ pipe_poll(struct file *filp, poll_table *wait)
 	struct pipe_inode_info *pipe = filp->private_data;
 	union pipe_index idx;
 
+#ifdef CONFIG_EPOLL
 	/* Epoll has some historical nasty semantics, this enables them */
-	if (unlikely(!READ_ONCE(pipe->poll_usage)))
+	if ((filp->f_mode & FMODE_READ) && filp->f_ep
+	    && unlikely(!READ_ONCE(pipe->poll_usage)))
 		WRITE_ONCE(pipe->poll_usage, true);
-
+#endif
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
 	 *

