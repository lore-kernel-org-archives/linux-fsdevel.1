Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3124825A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251664; cv=none; b=NNF00ZaDar6v/IPytAOJeaOM7wAq/UZKp7F2Z2b4PtGdjuIw+OCtmX9a/2W3KD+OL8KE2wvCGbLU5ZSiPU8uHbcdnbHY/UW1latASlEfcys1SMpuACJzmbbGm5XuNC48p74vBlsE+VmlNUwNEgl7ULX7A9JrWR/nvTG4Nwhyf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251664; c=relaxed/simple;
	bh=KBIS1OCztfa/hDXcLqDP0qbVwmDRsBJeh+/3cN9SgYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHNDZjeXnup7kmI1Y17fjJRtcb60B9LNMjItmAZMcds6k3pNISmH84uSH0UK9kxlQ49SfEZj+kLMO78yu12XYiYRvwkbqhEbuiVo+JswEnxOknetcRWgJ9l1LhYzraaMj8+8m2hZm04+x1iDG6EbGtqurjHgHpMswnc43Lndg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBBUHKC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBBUHKC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790251659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrZPfOuXhdcQwT19h1nAOmLFrkkXWebr8THeR7DZl3c=;
	b=KBBUHKC23c2G84hPAjqWzMBGvgeiZChxy5670sGWaUrPEKuUgYzYfpMR+WHs3EhbB/BkCV
	XvjB2op5w5++waLmRNG4Sp+wjzb8ZB73q6n9rgsv+j74XUTdDfvcqHT4UimpWpvBzcjGTo
	ZUb4IMSg9bPAa19jdqJo6h06J+fQCcs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-ZzZ3Jf7NPlCQNNb2lo4xLA-1; Thu,
 24 Sep 2026 08:07:35 -0400
X-MC-Unique: ZzZ3Jf7NPlCQNNb2lo4xLA-1
X-Mimecast-MFC-AGG-ID: ZzZ3Jf7NPlCQNNb2lo4xLA_1790251653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A9A81840C52;
	Thu, 24 Sep 2026 12:07:32 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1B37E18002A6;
	Thu, 24 Sep 2026 12:07:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Sep 2026 14:07:31 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:07:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 09/18] fs: make close_cloexec_files() synchronous
Message-ID: <arUSf7YBK62yUIZX@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-9-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-9-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/10, Christian Brauner wrote:
>
> Punting file closing to task work during exec slows down exec
> significantly when its done with a bunch of file descriptors. We can
> do this in-band instead. Flush already runs synchronous. Jann moved
> close-on-exec in e780259b54e6 ("exec: do_close_on_exec() before taking
> exec_update_lock") outside of exec_update_lock.
>
> The only lock that's still held now is cred_guard_mutex. It's deprecated
> and has five takers
>
> (1) exec
> (2) ptrace_attach()
> (3) seccomp() with SECCOMP_FILTER_FLAG_TSYNC
> (4) writes to /proc/<pid>/attr/*
> (5) lsm_set_self_attr()
>
> Four of them take the task's own cred_guard_mutex. When
> close_cloexec_files() runs, de_thread() ensured that the calling task is
> the only one alive in its thread-group. That leaves ptrace() waiting on
> cred_guard_mutex of the tracee going through exec. exec already sleeps
> under cred_guard_mutex in de_thread() when it reads binary and
> interpreter. So while we add wait-time to an attaching ptracer no new
> lock dependency is added.

Plus ptrace has other issues with cred_guard_mutex, ptrace_attach() may
deadlock ;) So I agree this is not a problem.

I like 1-9 and believe they are correct with the additional fix

	[PATCH v3 08/17] exit: hang up the tty before closing the files
	https://lore.kernel.org/all/20260921-work-coredump-fixes-v3-8-8e4adb1619e6@kernel.org/

feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

