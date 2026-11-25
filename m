Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609491;
	b=Vpd1NBZap8sDq99S6jRdhqDPBCMPSi6HCvqlf5h1h/5HE8C6MVodIhoGYca8Q3P55OI7
	 6ql9ibGfAiaVB0hElNAZMwX2qX3CW5NDgPJP4VcMCFcj1PpI82SC37hnhv9mNm77CXjkN
	 0z8ZRolfiK2q/2p4HfyX5RkIm+2SBIEHpGkzi6z8jdu1lDkgs1ZLCVpZ5d2dNoRlZx9pm
	 88szU7x2x8VN3Bg+rf4X8DanqBu5gN3FJGcXMwEKR1x9M/lFZ2iKqTH3ERx+dRB9jQ5ie
	 cxqaAW7+KXrXaTMv+K4ac2Tnkn7P5OAy9YPZ2vC3QB5xDhZwb2jGOWU7SNvyciH8R8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609491;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=qtbzDgU/qebMP+x5NyFuhtZ0/3d3A7w4k6ADwt9eAp4=;
	b=kFbUACnR1YLBbGYq+N9bSwnqIFn7/rggePCYN7V40Sxf9kutP5w2bBjc8lkIExTTkAyW
	 YGT5z4PSAkbrEH+B98hswH11Ss0gnCRhzzWMYaOq8CumlY49hgBpO0KBpMnH3Ns2VpAG7
	 BAA9Bka9Zcx8PEql2o2D1Oh9VgC2G/GDX4SbccPd3cBI0dIltdsRVbBVbJGCJkLeIiGEO
	 RoQc/IQ6iuAuAKPAqR5VirS6AyowaVHEII95dKflwGHdP23mwnY1nxfEYnv1wKyVDF5aH
	 2q63VFl4wcM3zk+Ev0nZL59xDncQcYheJYm1VxtfRA2nn50kXgdz/lp6zS8WGdsyTDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKq9NjqF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479D606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1479D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKq9NjqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795609490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtbzDgU/qebMP+x5NyFuhtZ0/3d3A7w4k6ADwt9eAp4=;
	b=QKq9NjqFQ8XdADZIX7+WtKfEsVyagl4Zunrg2mSP6PVzkeArbo5Zgs8oaAZjjSBhkLi+Ul
	2UU+3SzO/bYCf8RykmHhVrKAmwpmwdmITXTLBDjnCuIXPEytfyRTjrzS1yer3evVQVqqlA
	qaKi5tSyrITiY5qWLsEGe+ETpr4OYxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-wdSzzG7COGOE8xbfhlyMYw-1; Wed,
 25 Nov 2026 12:24:42 +0000
X-MC-Unique: wdSzzG7COGOE8xbfhlyMYw-1
X-Mimecast-MFC-AGG-ID: wdSzzG7COGOE8xbfhlyMYw_1795609481
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03672180059B;
	Wed, 25 Nov 2026 12:24:41 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0914B342;
	Wed, 25 Nov 2026 12:24:37 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 13:24:40 +0100 (CET)
Date: Wed, 25 Nov 2026 13:24:36 +0100
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
Subject: Re: [PATCH 5/7] sched/wait: always queue new waiters at the tail
Message-ID: <awbThHt5dm3UKBL0@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/24, Linus Torvalds wrote:
>
> So just queue everyone in FIFO order.  LIFO might be better for
> throughput, but every time we've ever tried that optimization in real
> life, it has caused fairness issues, so let's just do the obvious thing
> and add new waiters at the end of the list.

I am still worried about the "ret < 0" case in __wake_up_common().

wake_page_function() does

	if (flags & WQ_FLAG_EXCLUSIVE) {
		if (test_bit(key->bit_nr, &key->folio->flags.f))
			return -1;
		if (flags & WQ_FLAG_CUSTOM) {
			if (test_and_set_bit(key->bit_nr, &key->folio->flags.f))
				return -1;
			flags |= WQ_FLAG_DONE;
		}
	}

Before this patch, all non-exclusive waiters are already woken when
wake_page_function() returns -1.


Perhaps this change in behaviour is fine... I'll try to carefully read
your series later.

Oleg.

