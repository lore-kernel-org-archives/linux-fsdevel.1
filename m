Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444534;
	b=l01XIGXaF4//jfkahXedomyS43y6wNnrVY5WwcKbIo8n3bFimiX6qPdPKid/kuVaSdVB
	 Guh9DsbuYOyGXIkduBLjz1V7XtUhWzM4wyXoqf/vuZymaqU49eWtTPKA3I//pzW6ta2Ai
	 S7RS8XtratK4HLrRSfPx5RYojpuDjL7akr2jj6u/gwVLj1XldpKbjELmle06+E8pAJkic
	 koLQBDPzyY+tFtYpl5cBjiPwK7PDuhAZfQL03LifmnWJ7CFr6ZRXiOEl9uiCJn+c83haw
	 1AdzJ2ckZKmLR4xj1poU4/hKJ1Dqrw3I4Ke8RWEUCTh+mL7u3MLQsZ0yIxPepzKfcbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444534;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=PcCW+rqNgrACV07eEtKyYGyFh6QSwIbd8Ip3J19mL0A=;
	b=vOvxpYypIQCuVMDb9TLtJPGMkMlCaslwgWvAxnFMTuTrm1OJC+0u4WOlHlaqRb4PDB1/
	 9EpUbNbs4kqK2FH/I8gSU+N+26GZhLvnqg8a+XLdhAV8tX7QGalWPGHaInr5Pik36JXFu
	 9V1afNG4s+XYqbn1rVY6Y+xXIV5bUjNK7b39vhzgBgkfFQ7VjCapqk7UI7EpD1uteV1Gx
	 von0GbfuaDy6c43w0j+K8P56hRZjOcxq9XpmsNy1r15PfYrn36ieoF6pbbtp+jOHvwTpC
	 pDqu3N7VCA1Juh/xzS7tC+RR7mijUB0NZ12g32kada7BetdnFmyIdgeVq9ip78CDT4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YKzgrq8W;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C871606A327
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C871606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YKzgrq8W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795444533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcCW+rqNgrACV07eEtKyYGyFh6QSwIbd8Ip3J19mL0A=;
	b=YKzgrq8WMo4d6lmbQ0Nz+d1Hnr9sLlcPUUcuA/b7Fase3GVb1kgbyhQE2YkSJ/EeR8Bse9
	tCcppjbnZAa6zTyzTZhsDQoA0g6e98JEWJRhqXbk0m35GDY82hLckPVCbMJa5hwtHSmUeH
	THraGhLSuAUTmA2fhG2iKfp86CjgYLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-fAw_F4G0O3WqccqgtDoXig-1; Mon,
 23 Nov 2026 14:35:24 +0000
X-MC-Unique: fAw_F4G0O3WqccqgtDoXig-1
X-Mimecast-MFC-AGG-ID: fAw_F4G0O3WqccqgtDoXig_1795444518
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF90719560B8;
	Mon, 23 Nov 2026 14:35:17 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 929EA348;
	Mon, 23 Nov 2026 14:35:14 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 15:35:17 +0100 (CET)
Date: Mon, 23 Nov 2026 15:35:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH v2 2/2] sched/wait: Pass wq_flags to
 __wait_event_interruptible_locked()
Message-ID: <awRPIenAyY1fCRIg@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-2-4a764b64e8ce@columbia.edu>
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
In-Reply-To: <20261122-b4-sched-wait-intr-head-v2-2-4a764b64e8ce@columbia.edu>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/22, Mani Tofigh via B4 Relay wrote:
>
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -770,12 +770,11 @@ do {										\
>  extern int do_wait_intr(wait_queue_head_t *, wait_queue_entry_t *);
>  extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
>  
> -#define __wait_event_interruptible_locked(wq, condition, exclusive, fn)		\
> +#define __wait_event_interruptible_locked(wq, condition, wq_flags, fn)		\
>  ({										\
>  	int __ret;								\
>  	DEFINE_WAIT(__wait);							\
> -	if (exclusive)								\
> -		__wait.flags |= WQ_FLAG_EXCLUSIVE;				\
> +	__wait.flags = (wq_flags);						\
>  	do {									\
>  		__ret = fn(&(wq), &__wait);					\
>  		if (__ret)							\
> @@ -870,7 +869,8 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
>   */
>  #define wait_event_interruptible_exclusive_locked(wq, condition)		\
>  	((condition)								\
> -	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr))
> +	 ? 0 : __wait_event_interruptible_locked(wq, condition,			\
> +						 WQ_FLAG_EXCLUSIVE, do_wait_intr))
>  
>  /**
>   * wait_event_interruptible_exclusive_locked_irq - sleep until a condition gets true
> @@ -901,7 +901,8 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
>   */
>  #define wait_event_interruptible_exclusive_locked_irq(wq, condition)		\
>  	((condition)								\
> -	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr_irq))
> +	 ? 0 : __wait_event_interruptible_locked(wq, condition,			\
> +						 WQ_FLAG_EXCLUSIVE, do_wait_intr_irq))

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

