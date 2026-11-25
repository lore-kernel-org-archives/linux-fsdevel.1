Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608954;
	b=HW8YCTaVpJ1NNXJ9enain/6co24vSiq9F4JU9BuLuITIkyq0ucXF1nzXoR4EaoMhtfq5
	 kYJGx2cUVCCZLJ2VikuYYPkdjhYA+6gWfT0BZ90c90zlI2+cJNIV3IDg+Yv+2NGatvD8k
	 vrSXL4Qr6U4TJXumuMiIwbH3VK69IUjXiTUqTG+v8u9rW+YBmSZzWmsvgA14ZQs7UGfKq
	 L1MTQRkQ73EpKigykfvC6CNk6f/K4GG6s4sCw2YI/E1eUbgfWzRhG9ElIzGUTYD5iQQrk
	 UtwMJNV1P3x3dTL5ghfSORFPrOF1CTFmDp/mq6bgXYNLuHc1smvCmgRCRTZJh+GdT6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608954;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=zoN7I0BDPbXDDeNenHos3vHXfJ3u5ltkjoBOqq3KTgU=;
	b=1Autk/li0amRiIRNfVb6gFVEGU00X6T5iTI5BTLcTQIkQPUii3z0bOHknYkxNQ6BPOI+
	 M3G6NUL39y9WE1qNnI3Swm70B/h6p0N0oWMz9EjV3j3ymcRAt6zJhQ0XUrKipQsnBeIwl
	 KdlFvysZR8NMFmVwDdnLQgltwJ8kMll9sinmGNT78xq7oA4XL3iy3D9q40wvWT3ox+9yG
	 CDLvBrw/106lJl81Mz3F+vrapMBH686yWAhZvNnbMiwR4KTAFUypTjpDoUo4rFDY9xiad
	 fjYFk3ya5F0vNDowEyEKNR27/woMkTfrHfEabKS3YOD3d68Y0B3JVAkp6NvCddBA6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="G/CktXkt";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A0606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/CktXkt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795608952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoN7I0BDPbXDDeNenHos3vHXfJ3u5ltkjoBOqq3KTgU=;
	b=G/CktXktkKQDZE0/jrCSzOMefBU8noKzfNfw8G5m8Kl7FAc6S0U2EUoYRln/9K/CyercGI
	TXTiqkcLdpu7tZLFvmr2XnmE9nAewUrZmxQyytRR+IeSa4fRUzTs3KCNe/0/4l+dcwhaZi
	tQVjxrgF4e9M0lQumXuAGTJH42P82eQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-GDTU3zJxMsaXpCLmoG1DuQ-1; Wed,
 25 Nov 2026 12:15:47 +0000
X-MC-Unique: GDTU3zJxMsaXpCLmoG1DuQ-1
X-Mimecast-MFC-AGG-ID: GDTU3zJxMsaXpCLmoG1DuQ_1795608945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344C119560B1;
	Wed, 25 Nov 2026 12:15:45 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9B8C18004FC;
	Wed, 25 Nov 2026 12:15:41 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 13:15:44 +0100 (CET)
Date: Wed, 25 Nov 2026 13:15:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user
 space waiters
Message-ID: <awbRbH35xP3KEEOF@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
 <awbJz9stwx_JzZFX@redhat.com>
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
In-Reply-To: <awbJz9stwx_JzZFX@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/25, Oleg Nesterov wrote:
>
> On 11/24, Linus Torvalds wrote:
> >
> > @@ -105,10 +111,16 @@ static int __wake_up_common(struct
> > wait_queue_head *wq_head, unsigned int mode,
> >  		unsigned flags = curr->flags;
> >  		int ret;
> >
> > +		if ((flags & WQ_FLAG_POLL_EXCLUSIVE) && poll_woken)
> > +			continue;
> >  		ret = curr->func(curr, mode, wake_flags, key);
> >  		if (ret < 0)
> >  			break;
> > -		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> > +		if (!ret)
> > +			continue;
> > +		if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> > +			poll_woken = nr_exclusive > 0;
> > +		else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> >  			break;
>
> I obviously like this change, but note that wake_up_all*() helpers
> use nr_exclusive == 0, so
>
> 		poll_woken = nr_exclusive > 0;
>
> doesn't look correct.

Yes, but ...

> I think this patch should also change them to
> use nr_exclusive = -1.

No, this won't help. It seems that __wake_up_common() needs
"bool all = !nr_exclusive" before the main loop.

Oleg.

