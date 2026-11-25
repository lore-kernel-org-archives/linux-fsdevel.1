Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607023;
	b=JWhXolYHmSw3Dx++SeLckStY7OtkE+ehHD2yjqDcO0cpldal+ejf2evZicPWOFb5tC9E
	 OqmMlUE6qKHiRcJ0Xj3Vre1mWZAKsnv63POrbQTzdyJTgJ4C4spiVuoG99O+q2WGpL3tF
	 DMuxcDoI3dr30ZEaMuWAvUTfCcxd7p1KWUCHIHG55iHan2T4Mn3oEx815eeIMNnzOrr4a
	 6M/gV6lL5QCUqgWiAPO9xcW8ak1x9I+WRM07mq6rQHtQTBtBkOaYVqKVFtAVzsVaSaYwq
	 3xuv4bb965+BT7xffslccCMDUFibQ3uTdA8YDPFdNyVH9yVRcXG2p+jbqrG0XVT4myQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607023;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=Ro/q02DiURiwSOcN9QA2cgFPXuLdyWbUrkDRq5unrbc=;
	b=2SDEbGpPfbb1Hx7hv4ppy69xtKOOTM2TzfVcNZfEFNV9Z5kB6CqwqXjxbX4SoBBxVq6t
	 2WwXc7WM7YNOohJ+qGXgsEQjn0ByuR9e5xwDMDqhGC8+JgIyB01hxinW8q35VxzkJGwmY
	 z1S5WtPcOxvBdrrBZeuYxUe0lMhr4C1kcehdsOqINi5cNYoArjPobVokAN4T/9fOJlf4V
	 01B7dkfHqgKW9+h8R75zTHLjBImSaQjvQsFINdyAQA/poKIgo++bY8GS7Znu4njvm3Z58
	 fCaU3p/p9u6VOiTi966YD+g27pS0yOe6XsLtpRFhukFPr8tBpdHN3C+dI5n4Wj7Kn1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkQGb2ZH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB4606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AB4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkQGb2ZH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795607021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro/q02DiURiwSOcN9QA2cgFPXuLdyWbUrkDRq5unrbc=;
	b=JkQGb2ZHje/sH0hqRzbNanewBqDbsINrpZtpgC5jLmCnxJJrIz2hzu/O2BPFnywRtH4eJC
	nco2CL4ZKMKLuAXBasHEl88Ykb9l+zu/8/eBPM6vNuyUUQ0RtMa6MXftpZCVCZEynWYwU2
	yUZ65OvltSqVBODBUa/i5HrAyv/jjBw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-piUuYfOLNh6PqB1vS4-AYA-1; Wed,
 25 Nov 2026 11:43:35 +0000
X-MC-Unique: piUuYfOLNh6PqB1vS4-AYA-1
X-Mimecast-MFC-AGG-ID: piUuYfOLNh6PqB1vS4-AYA_1795607014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D92371977502;
	Wed, 25 Nov 2026 11:43:16 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E2C33001DA7;
	Wed, 25 Nov 2026 11:43:12 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 12:43:16 +0100 (CET)
Date: Wed, 25 Nov 2026 12:43:11 +0100
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
Message-ID: <awbJz9stwx_JzZFX@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/24, Linus Torvalds wrote:
>
> @@ -105,10 +111,16 @@ static int __wake_up_common(struct
> wait_queue_head *wq_head, unsigned int mode,
>  		unsigned flags = curr->flags;
>  		int ret;
> 
> +		if ((flags & WQ_FLAG_POLL_EXCLUSIVE) && poll_woken)
> +			continue;
>  		ret = curr->func(curr, mode, wake_flags, key);
>  		if (ret < 0)
>  			break;
> -		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> +		if (!ret)
> +			continue;
> +		if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> +			poll_woken = nr_exclusive > 0;
> +		else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
>  			break;

I obviously like this change, but note that wake_up_all*() helpers
use nr_exclusive == 0, so

		poll_woken = nr_exclusive > 0;

doesn't look correct. I think this patch should also change them to
use nr_exclusive = -1.

Oleg.

