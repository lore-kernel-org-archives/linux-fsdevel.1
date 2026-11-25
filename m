Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629915;
	b=ayBm/1AfqbbxrrELYGB02ci6ZCZa4xaFk84rnX0KWYntktDMpXAm5y3QhHlXrPoM2dyj
	 rFHYRLgZL7ZiB2w53AwzwVTo2Hu0ghLJ5Xhh0JTIG6KAC9pcdMUxF9/h5B1KoVppo1NCV
	 Pfp9yH1qg6RadF8NsuIcKnLtZrLt8dGB2sjdqMz/GdTqlz51jW/UC73oK6FVFQNbQKoYH
	 6h3PYWGVEBA8/rkBmAN8LQttpv1G8i6ExoOQDOmO3CWBd1f+o3X5jZywn60wBcIhF4pn0
	 Bh63PPF2eWMJff6Ovfh9gJzwQDkWkeuz5SoTvt+MXGbG7AFDViq9bv2I7MU/Nia+M3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629915;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=1rpx+3hZ3i6ycHmkkGcDthqhxWJ6L8BnBo1hR3Q2eKE=;
	b=JuqOtasGQ3JN8bD7bveJp4zo3s/VuZO8L/GGJrGnW70Or6gYaXh1n2h6QSHwt40xzicL
	 UmexozR/jbEnWoWUuBR2D95JpnO67ukxqPmR2wuAxTGx8L1zy3Eqt+1EFtSWNBtdCGl37
	 6XnLNEISrM8wjD5DXbtTGtqE4562Ah9mE2RatBpR+DfquECFuPtitdmKCDUigDjhysMeT
	 SNGv+blosRmsU3D+zAOqOgZ4M4BWYRHABpDdf74f4+fgDJ07iDCgeQa6AlFQwyEBXRkkr
	 mSZA1Rpsc+zf+pwp0BB5DZ9381KWn81h4VSJiFj17uwREDNLHSyVgDyzCoJLfvIjzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="CZ/2aukY";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC6606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCDC6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZ/2aukY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795629913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rpx+3hZ3i6ycHmkkGcDthqhxWJ6L8BnBo1hR3Q2eKE=;
	b=CZ/2aukYquyaXWlSdHW4pRUVxlJyVp8AFYLWYPgvu4LgrOMI8CVhkKvhA2CbAllREvz390
	fIqdc2DxutD/c8VVwblAXl26H19BRF6E/5Utl7RTI5glW17+iAf3vhCNdQD/xVLpr3GAwM
	nZ/mLdkxeuDHgt1DBievtOMKyISrQF0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-RNGMqG3IPIexq9Xse4ufjA-1; Wed,
 25 Nov 2026 18:05:06 +0000
X-MC-Unique: RNGMqG3IPIexq9Xse4ufjA-1
X-Mimecast-MFC-AGG-ID: RNGMqG3IPIexq9Xse4ufjA_1795629902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C595E1955EA2;
	Wed, 25 Nov 2026 18:05:01 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C993E18004FC;
	Wed, 25 Nov 2026 18:04:58 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 19:05:01 +0100 (CET)
Date: Wed, 25 Nov 2026 19:04:57 +0100
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
Message-ID: <awcjSc-84AgPPdj8@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
 <awbJz9stwx_JzZFX@redhat.com>
 <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
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
In-Reply-To: <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/25, Linus Torvalds wrote:
>
> On Wed, 25 Nov 2026 at 03:43, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 11/24, Linus Torvalds wrote:
> > >
> > > +             if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> > > +                     poll_woken = nr_exclusive > 0;
> > > +             else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> > >                       break;
> >
> > I obviously like this change, but note that wake_up_all*() helpers
> > use nr_exclusive == 0, so
> >
> >                 poll_woken = nr_exclusive > 0;
> >
> > doesn't look correct.
>
> No, I think it is correct.

It is, sorry for the noise.

> The logic in the new code is that WQ_FLAG_POLL_EXCLUSIVE should only
> wakes up one of the entries that have it, *except* if it's a wake-all.

Yes, yes, this is clear,

> For wake_all, the poll_woken is never triggered.

Yes. I can't explain it, but somehow I thought that that nr_exclusive is
"unsigned". Damn, the only excuse is that I could not really read the code
today ;)

Thanks,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

