Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5D2EC09B
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073994; cv=none; b=qVyJwDLrxlrQlkQBPywSg5RgtkKfnDal0Lqmjgm66aub8as72A1AuhJ/TFewW+siGcPcgd4aaYQQq2IO5olX6naShaUpCaDLscGyFeWMQMvJbzSI+X2o7nyLCtbj7o8zvbgbu5tmAEEOHaBE5yP4EL4+TbxxZeSPCMfQLPFzFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073994; c=relaxed/simple;
	bh=9IgO4T2pqyxqAyo0iKrSzjoreHNZKX5LSMep4sSOC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erulo2giCAl0csTQysygFZtpkcHce9BRYE0/8SAz3B52MvXh5zW0NXeNVZ6hK6eaqm18MCwF53kLFVtUaCTJitb+25ZRCGN1F18K4MXy9r+1oqgn2OSxLlfM4jsV6cNiRWYm4BOT2TLXN4j54XhnS2Z70SePlqiTlvUlz53/qec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwlk+MYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwlk+MYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788073991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGRmg+XBb3ytosqo7Mb6GBbUeZQZNV5RKNZxRGn9VNQ=;
	b=bwlk+MYEar0PKqtonEjGvM0GEh+hRDjr62h3itIOvrLeUWMAbGSouRZabhONyAUY87MSK5
	hfvlEWQ0qbZByeSt9SV8JiIiFK9L+UE8+vxIjH6j+JhCmlcxAxFA5B9HVXcAJyJe2rz/VB
	ErWvikAs8sqgiCAd1EH3MGBcPHhV8j4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-YEcDDOc2MmafWM4yiM4IGQ-1; Sun,
 30 Aug 2026 03:13:09 -0400
X-MC-Unique: YEcDDOc2MmafWM4yiM4IGQ-1
X-Mimecast-MFC-AGG-ID: YEcDDOc2MmafWM4yiM4IGQ_1788073988
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2C351801323;
	Sun, 30 Aug 2026 07:13:07 +0000 (UTC)
Received: from fedora (unknown [10.44.48.13])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 21511426;
	Sun, 30 Aug 2026 07:13:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Aug 2026 09:13:07 +0200 (CEST)
Date: Sun, 30 Aug 2026 09:13:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: Re: [PATCH] exit: hold a reference to thread_pid across
 proc_flush_pid
Message-ID: <apPX_wFXklPwDWbU@redhat.com>
References: <20260829101905.4163730-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829101905.4163730-1-4ncienth@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 08/29, Daehyeon Ko wrote:
>
> release_task() keeps a task's thread_pid across the point where it
> drops tasklist_lock and calls proc_flush_pid().  The commit named in Fixes
> removed the PID reference.  It assumed that the PID cannot go away before
> this release_task() invocation calls free_pids().
>
> That assumption does not cover references represented only by PIDTYPE
> links.  Process B can still use exiting process A's PID as its session and
> process group ID.  A is reaped with wait4(-1); PID-specific waits take
> their own PID reference and mask the bug.  After A's reaper drops
> tasklist_lock, B can call setsid(), remove the final PIDTYPE links, and
> queue the PID from B's own free_pids() call.  The RCU callback can then
> free the object before the reaper dereferences pid->inodes and pid->lock in
> proc_flush_pid().

Thanks Daehyeon. Yes 0a36bad01731 was wrong and should be reverted.

But can you improve the changelog and send V2? I simply can't parse the
explanation above.

But I guess the problem is clear. 0a36bad01731 assumed that the caller
of release_task()path has a reference to thread_pid, and free_pids()
will do put_pid(thread_pid).

However, __unhash_process()->detach_pid(pids)->__change_pid(pids) does
not necessarily add pid to pids[], pid_has_task() can still be true.

IOW, release_task() doesn't necessarily has a reference,
call_rcu(&pid->rcu, delayed_put_pid) is called by the caller of the "last"
detach_pid() which makes pid->tasks[] lists empty.

Hmm... Yes, my explanation doesn't look clear too :/ Can you ask you LLM
to turn it into something meaningful?

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -261,8 +261,8 @@ void release_task(struct task_struct *p)
>  	pidfs_exit(p);
>  	cgroup_task_release(p);
>
> -	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
> -	thread_pid = task_pid(p);
> +	/* Pin @thread_pid before __unhash_process() may set it to NULL. */
> +	thread_pid = get_pid(task_pid(p));

It would be nice to improve the comment a bit if possible...
"may set it to NULL." doesn't explain get_pid().

Thank you,

Oleg.

