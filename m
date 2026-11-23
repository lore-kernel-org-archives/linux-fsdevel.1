Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444126;
	b=Ge3pDGHAEzEy93v2wXoT13kDixB3xTM4oXiFWvEB2dqn3aJLxad9RmojWmRzmTGKrAro
	 vgq4FkXEjVkQSFPzO9ioupl72WwiBh8vbM1sbDkjSbgblsVeQNUq8y+AAIZ3E/gRPIo6J
	 btQTmzKUd+ymf6tCE4IVxtblOTJ3S1d3VqjMpFUKcmyDQHlNUM0JPoGUyaTGqdYAOy6ZW
	 GAJuFgDhHDp0kqNrEA4G3PJ9japb95ww859xYwoGKN8mUEsVWm0bRuaAxiRc/nn4KJWUD
	 MvMhR6ooGVRFQ8d01U4CveyQ4RBuS4nkZZeANnV3sjRD1FnNGjpTxwrP+XYLA7b7cOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444126;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=BZHrx5urPjZ9zwkbeuhAeuZPyJQSzP9ovkRNKMVXKrQ=;
	b=kpM1rd8ZX/yJQU6Y/LyRbW4o0huIWskvdx1ymUncYKwDb3f7ifNQ//9ycZKrpr3h6JTS
	 USHrbZYetXUn7Hfo7C6k3m22I6wtnCts42xORrdXS5l5olc7nCFFDI/MFmOPwVdLijKCP
	 JYSr+Blqfj0iT94eJeGxd7j8S11DjFxkmdc0c4cw07m9YWprocgHqKsvLOpSXGVtpPrFy
	 tTTBxh3UrQQp7Q2F3u0SiIhoaxenzBm8qI0epu8ELDJivObRbf9m8zAHOolxlR/hlLh9y
	 mtz9nSdCXgiiUl/o0Bv0Le1s2le5ISU5yDGiMLJZwgCOFI7N+aYYQM+t+qkxJDq3KTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMmwKoXA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C77606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C77606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMmwKoXA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795444124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZHrx5urPjZ9zwkbeuhAeuZPyJQSzP9ovkRNKMVXKrQ=;
	b=cMmwKoXAx5+1qXHEWrjLTXbRLv1S6UFwgYUWeSC0ku02D76Ew103HtSX279LFvqiXPGvIJ
	yDa1BYetyDviz76yR4/rK/1TFCge1BWlNL2iqTPoC8qIvW6WvFWrZ4TcApBv0/hemG+i4P
	x3L3OVCgkmKZfvK+KOpeSUwA35kBE0k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Qa4nCwT-OHSl3pXPre216w-1; Mon,
 23 Nov 2026 14:28:40 +0000
X-MC-Unique: Qa4nCwT-OHSl3pXPre216w-1
X-Mimecast-MFC-AGG-ID: Qa4nCwT-OHSl3pXPre216w_1795444118
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C63C1955D4A;
	Mon, 23 Nov 2026 14:28:37 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ADBF8195B3CC;
	Mon, 23 Nov 2026 14:28:33 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 15:28:37 +0100 (CET)
Date: Mon, 23 Nov 2026 15:28:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
Message-ID: <awRNkGITm1FlgdRr@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
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
In-Reply-To: <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/22, Mani Tofigh via B4 Relay wrote:
>
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -319,8 +319,12 @@ EXPORT_SYMBOL(prepare_to_wait_event);
>   */
>  int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
>  {
> -	if (likely(list_empty(&wait->entry)))
> -		__add_wait_queue_entry_tail(wq, wait);
> +	if (likely(list_empty(&wait->entry))) {
> +		if (wait->flags & WQ_FLAG_EXCLUSIVE)
> +			__add_wait_queue_entry_tail(wq, wait);
> +		else
> +			__add_wait_queue(wq, wait);
> +	}
>  
>  	set_current_state(TASK_INTERRUPTIBLE);
>  	if (signal_pending(current))
> @@ -336,8 +340,12 @@ EXPORT_SYMBOL(do_wait_intr);
>  
>  int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
>  {
> -	if (likely(list_empty(&wait->entry)))
> -		__add_wait_queue_entry_tail(wq, wait);
> +	if (likely(list_empty(&wait->entry))) {
> +		if (wait->flags & WQ_FLAG_EXCLUSIVE)
> +			__add_wait_queue_entry_tail(wq, wait);
> +		else
> +			__add_wait_queue(wq, wait);
> +	}
>  
>  	set_current_state(TASK_INTERRUPTIBLE);
>  	if (signal_pending(current))

perhaps it makes sense to add the new trivial helper later,
prepare_to_wait_event() can use it too.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

