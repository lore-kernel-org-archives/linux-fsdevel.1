Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CF4FD29B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738921; cv=none; b=GqOy0SVoMi7nMrX6acbsiVOHwWo2N5EXr1vzlUhb2hg7S5nyOL6669ea7Onb9rZqhzGLGSHs3A/2VGEQXOuAXStEO+s+KFV5IbF1h3UDS9f+AsV+TQGpMW4WO3CLJCEqiS4jhI7/2JJJs/NLwTpPKZcKZ+t+cjj235MkhIqhZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738921; c=relaxed/simple;
	bh=sNMGJrjxGOQII/cy/jQVIut5noFDYuUvTYdYnxLVNGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoOP2C639sSk5HM0w8UcM+kCtOW1MDe49OhAp5+TMtoxnLirxi2Ph7VlxpRbjaRqB8dUVmJsSSbFsN/sORiJdNqulhVipo5KwXQLH9v2duQWyXPyj7tQlZn+n+Pwlb4KVkXqHTpJv6Lz3fhhk+v9Wf++mR2TRDp1mNaSkgIA5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVcW4316; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVcW4316"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789738914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1G7pn6seS/SOuHvOw8pJc1Knwr72Zy5SeN7YDV021M=;
	b=CVcW4316g12O3q1B9/AUQsSArIEqPRvpmnPsXPW0GekElhB7JC3UwrVUGxko3fvL5kFFGS
	hSDP8pRivNifAa3EnucBwIS2NDD4b9ftdHxT46Ar7VznlGPok+nGZHP2FP5PQLEhwtq2Hz
	ueNs4fxyiLuxJ/cvVb97UtQSOMTgDes=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-H0K6Lj2APcaU4-gCZgc4kA-1; Fri,
 18 Sep 2026 09:41:50 -0400
X-MC-Unique: H0K6Lj2APcaU4-gCZgc4kA-1
X-Mimecast-MFC-AGG-ID: H0K6Lj2APcaU4-gCZgc4kA_1789738909
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D66E819776A8;
	Fri, 18 Sep 2026 13:41:47 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3B334180034C;
	Fri, 18 Sep 2026 13:41:44 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 15:41:47 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:41:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <aq0_lvHDViIpX_Mu@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/18, Christian Brauner wrote:
>
> I think this works but they also need to check ->in_execve as the
> exec'ing thread is obviously never signaled:
>
> @@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>                 .user_worker    = 1,
>         };
>
> +       /* A creator past its fatal signal or in execve gets no thread. */
> +       if ((current->flags & PF_SIGNALED) || current->in_execve)
> +               return ERR_PTR(-EINTR);

Ah, I forgot to mention...

Can we shift io_uring_task_cancel() up, after setting bprm->point_of_no_return
but before de_thread() ?

I know nothing about io_uring, not sure this would be enough...

Oleg.

