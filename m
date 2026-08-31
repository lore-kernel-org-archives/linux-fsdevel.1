Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EF4A49AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188351; cv=none; b=bPUdeZs5mkPsRUOQLuAXfSKhaf/eWx9qZMUcWznCm/Ok1Rp7dAGn7qOGp26L+8WQuiVRWHlW3UC5RvBxNj6UdMtN8R5nR5tpeO2Tn7DA4qYW9Dftec3ibQb7wK4Km1h47SUOjVsSSU1W9ZiHsX89KouPXQsjoHDrHlx4pib+Vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188351; c=relaxed/simple;
	bh=q8EQWZqZC8uf6k1wdlO59JYvKDF6JhOjxTdWjHZFyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOrRNxRM7/Epyge9yX9De7R+H25oEWV++soWK587hTMKpgYN0ksUT1UjotTXqd0V33bQIPKtm3RWigyGhEfHj4LRb/opnjUzyKWQtphay5N5BGK0zcGl+Ec9D8tOZEtGONWgl0dptPCVC79onezXIW4MrcOIq/G+KjdkDkmMOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBWCqjVY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBWCqjVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788188349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwLt6dMDsNu9QJmZ+Wwwk6e1q2EtG9fCWBlGkN8d0KM=;
	b=VBWCqjVYepwhc/QTvOTAsqzS+Lpyhlix8EKQtENBmEX/2TO6DIXB7b6grwq0wIr6Fg4h2k
	Meic2q7YIXnQnO7yFfR+NyxKXyWFUaOMBWCKwasYSOCtJZZoL19iBSTJAVBu5fGDrC0ekB
	6UkOQApZOQWNn/G2Ln7v6RBED28gSdA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-XZxpBC6ZPaGhun37oLqfHw-1; Mon,
 31 Aug 2026 10:59:03 -0400
X-MC-Unique: XZxpBC6ZPaGhun37oLqfHw-1
X-Mimecast-MFC-AGG-ID: XZxpBC6ZPaGhun37oLqfHw_1788188342
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC96F185511F;
	Mon, 31 Aug 2026 14:59:01 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BBD9F3000223;
	Mon, 31 Aug 2026 14:58:59 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 31 Aug 2026 16:59:01 +0200 (CEST)
Date: Mon, 31 Aug 2026 16:58:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] exit: hold a reference to thread_pid across
 proc_flush_pid
Message-ID: <apWWsqOzJny1v4ab@redhat.com>
References: <20260831001221.3755948-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831001221.3755948-1-4ncienth@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/31, Daehyeon Ko wrote:
>
> Commit 0a36bad01731 ("release_task: kill the no longer needed
> get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
> It assumed that free_pids(post.pids) at the end of release_task() would
> keep thread_pid alive until then.
>
> That assumption is wrong.  __change_pid() only records a detached PID in
> post.pids when pid_has_task() is false for every PIDTYPE.  If another task
> still uses the exiting task's PID as its process group or session ID,
> __unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
> the PID out of post.pids.  release_task() therefore holds no reference to
> it after dropping tasklist_lock.
>
> The other task can then remove the remaining PIDTYPE links.  Its
> free_pids() call schedules delayed_put_pid(), and the RCU callback can free
> the PID before the first release_task() reaches proc_flush_pid().

Much better, thanks. The comment above get_pid(task_pid(p)) looks better too.

Acked-by: Oleg Nesterov <oleg@redhat.com>


> A tested source reproducer is available privately on request.  No
> controlled read or write, information leak, or privilege escalation is
> claimed.  The mainline patch applies directly to v6.19.y and newer;
> v6.16.y through v6.18.y need a context-adjusted backport.

Up to you and Christian (I am hoping we can take your fix), but I think
that this paragraph should be removed from the changelog... At least the
"A tested source reproducer is available privately on request." part.

Heh. I didn't even know that 0a36bad01731 was backported to stable. Why?
I guess I missed some AUTOSEL email...

Thanks,

Oleg.

