Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB831E830
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734237; cv=none; b=KuANcYtWDwHxmy7HGXT2VPcbswPBm5XTnlcu/wKrzIb+pYqkTOtj4vfOFslbPzAjfS+Mt46tRi9lDx7YTN/5/KMXKAbLJ86Trw6dDeKHN7Z29QLuB7kZZBFw5F8QOVHN5mDxUlEUIgvF1lB48DXvO4wOAo1Xt4JxDmx+7xyVj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734237; c=relaxed/simple;
	bh=/wKppWVauAwkR8jjbb7vgLhKkBzM/jGht9Jccc+FVl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIOhY42SwV/ETz698bHtLi8pheskBM0y7rmFam4vmraxKmfi6Cs35QfiGSMLJ0L4fyNpml5aNIKfPMpij3tDZCqP+qAlGMyh6DDhtx5isMYJ3dUgVE+jnKsjbWxYbihAOEfXacCrQOc/LnnGoA6C4l/YUwVKI3cij4/ub04ayKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8RnB9Ea; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8RnB9Ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791734234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0uXsmAXIe+ctkQ1z1JD1VbTuxvydK1QTZStvK1VYihI=;
	b=Z8RnB9EateANargB++be7p/PuhPS0m2+ihNVZr/K82OJ/svvQ6NdEgPGIlCLi+hyrqPWu0
	/5HNb4OMo+sRc4MCw5qp2MRWTvxGUJxZ5BAYiUmpL5j2rLCpP/hd5FpuS0EyT2kCgZES+g
	ol9yep1wnpH96BMA5FGjX0kM3CpTdqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-9vB34xm5Ml-ZghlUVAo6Qw-1; Sun,
 11 Oct 2026 15:57:10 +0000
X-MC-Unique: 9vB34xm5Ml-ZghlUVAo6Qw-1
X-Mimecast-MFC-AGG-ID: 9vB34xm5Ml-ZghlUVAo6Qw_1791734229
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A21918011F3;
	Sun, 11 Oct 2026 15:57:08 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BAEC71956042;
	Sun, 11 Oct 2026 15:57:04 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sun, 11 Oct 2026 17:57:08 +0200 (CEST)
Date: Sun, 11 Oct 2026 17:57:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>
Cc: jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
Message-ID: <asuxzwl4iWjjEjRD@redhat.com>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com>
 <asI5Fn87_SoEd4G5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asI5Fn87_SoEd4G5@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Nobody replied ;)

In case it was not clear, I believe the commit 00633c4683828
("fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling")
backported to stable trees is wrong.

Right now the fix is not clear to me, I don't even fully understand
the changelog:

    The deadlock is caused by the rwlock writer fairness mechanism:
    1. CPU 0 (process context) holds read_lock(&tasklist_lock) in do_wait().
    2. CPU 1 (process context) attempts write_lock(&tasklist_lock) in
       fork() or exit() and spins, which blocks all new readers.

see below ...

    3. CPU 0 is interrupted by a softirq (e.g., TCP URG packet reception).
    4. The softirq calls send_sigurg() and attempts to acquire
       read_lock(&tasklist_lock), deadlocking because CPU 1 is waiting.

but queued_read_lock_slowpath() does not block the reader if
in_interrupt() == T ?

Mingyu, could you provide more details? How was this problem reported?

So far I only sent the doc patch to explain that we can't simply avoid tasklist:

	[PATCH] pid: document that do_each_pid_task() needs tasklist_lock
	https://lore.kernel.org/all/asuaU8H_5MbO3-cW@redhat.com/

Oleg.

On 10/04, Oleg Nesterov wrote:
>
> Hi,
>
> On 05/23, w15303746062@163.com wrote:
> >
> > Since PID hashing and do_each_pid_task() traversals are already
> > RCU-protected, the read_lock on tasklist_lock is no longer strictly
> > required for safe traversal. Fix this by replacing tasklist_lock with
> > rcu_read_lock(),
>
> I don't think we can simply avoid tasklist_lock. Let me quote my old email,
>
> 	do_each_pid_task(PIDTYPE_PGID) can race with change_pid(PIDTYPE_PGID)
> 	which moves the task from one hlist to another. Yes, it is safe in
> 	that task_struct can't go away. But still this is not right because
> 	do_each_pid_task() can scan the wrong (2nd) hlist.
>
> And... I need to recheck, but perhaps signal_struct->multiprocess logic
> is another reason why the lockless do_each_pid_task() is wrong...
>
> See also the recent discussion
> https://lore.kernel.org/all/20261003182224.2171b574@pumpkin/
>
> Oleg.
>
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -929,11 +929,11 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
> >  			send_sigio_to_task(p, fown, fd, band, type);
> >  		rcu_read_unlock();
> >  	} else {
> > -		read_lock(&tasklist_lock);
> > +		rcu_read_lock();
> >  		do_each_pid_task(pid, type, p) {
> >  			send_sigio_to_task(p, fown, fd, band, type);
> >  		} while_each_pid_task(pid, type, p);
> > -		read_unlock(&tasklist_lock);
> > +		rcu_read_unlock();
> >  	}
> >   out_unlock_fown:
> >  	read_unlock_irqrestore(&fown->lock, flags);
> > @@ -975,11 +975,11 @@ int send_sigurg(struct file *file)
> >  			send_sigurg_to_task(p, fown, type);
> >  		rcu_read_unlock();
> >  	} else {
> > -		read_lock(&tasklist_lock);
> > +		rcu_read_lock();
> >  		do_each_pid_task(pid, type, p) {
> >  			send_sigurg_to_task(p, fown, type);
> >  		} while_each_pid_task(pid, type, p);
> > -		read_unlock(&tasklist_lock);
> > +		rcu_read_unlock();
> >  	}
> >   out_unlock_fown:
> >  	read_unlock_irqrestore(&fown->lock, flags);
> > --
> > 2.34.1
> >

