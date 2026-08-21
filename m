Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6513E867A
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288457; cv=none; b=PfQ64pxa8MV36ylIyRnLAxdw0ft602sqcaTUiv1uU2q7ALFgSXZGwsPFaitokyrFhn/Wgb0cEn0mFIAjSY2RuYchrp7cLt+FuH+oW42EzkkJOwu8TdASwxzPDMCxeX/HBdPAB6SS99/iKdnouLn4tU/6LZv6r4yV3TqI9hlHDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288457; c=relaxed/simple;
	bh=mbtqjPyqdDJgi+dyk90qGcI7mTbejVityy4LaZFHOLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpk1ip3qeDVTE+f9IJam7XTSsU1fx+6amEsW4BhVO+uRYOW9uvqSXB01ppnGahcZwdVxQn8olQBt6Su3Ey7cHD47Mx2s/k95QzJPXBNICHT87LwKkeLZ/2g0dLJH6wrFZek1gohQG86JE3BCOysnh7fgZXBMYgUD+q+uiY50WYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0vI4Yhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0vI4Yhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311441F01565
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787288456;
	bh=nHRy2iP+9SLgpqCJ/zjLL+H5ITom1p/PnhbqOOo0/eo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A0vI4YhxCJXait7bXbMqLgXISUS7OjbtowYNEN0cVN516Ts9ehMgigm/30pn3WHd+
	 Ht14SFdIufr6ib76q2naTnnDqlh0oX0N4EqEqyNm1EPqn239AGQKkLzYSApQDOs5By
	 0mL2fyofe050NU1cfCue4jWB7ca14z595EcORuIJ7kuD6UokA5Aye+k4w0S/dhL25Z
	 UcoVotXxe1Zd7CPrFRhEdosZN/fO8WjT0cy6b3z07TDAh7RAzG9VNNSEgJEK8ex8Hm
	 LJPWVnMtjxPPUKOBxNnWGF6lcpg026iS2XyoOEQPAlfRkP9UW2504A1ac6bSc98L89
	 BmrO7npgXdkSg==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e6a434cabso30981785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 22:00:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro+OMAmTxoHPz3y6CKQEv+m9K/VPxRfkthxITECo6FEKZHFCc+5nK0RBvljdwnWFPL3jwTSoH4HivLqz/oK@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdClkkYeqIfDick9opdmvqj9Nq6zCWpC5W9REnipggsw5mh1R
	0/s7zFPRr9TCFzc5aucO9UWSayTWcGA7g2SSA0JKTR54XkAASqf7/43ooOnNt4Q4B59xEEiHutt
	c+WUcBtMyufsMrcRDlD0ctyOxGBuZACs=
X-Received: by 2002:a05:620a:2092:b0:915:b852:4361 with SMTP id
 af79cd13be357-93739555290mr250944085a.20.1787288455444; Thu, 20 Aug 2026
 22:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-1-alex@ghiti.fr> <20260818163221.589352-3-alex@ghiti.fr>
 <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com> <aocfZSYFRvP7_vEG@casper.infradead.org>
In-Reply-To: <aocfZSYFRvP7_vEG@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 21 Aug 2026 13:00:42 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yb_5803vALp9YMHXRsTcqkDuXfGFLMcxpNDQXoqnsPWw@mail.gmail.com>
X-Gm-Features: AcwNN1Vr1I9MP1ETL3deT9CVHH3_gOH9X6-A-RjDwJmZICKRamiVldVSaOWVKyw
Message-ID: <CAGsJ_4yb_5803vALp9YMHXRsTcqkDuXfGFLMcxpNDQXoqnsPWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:38=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Aug 20, 2026 at 07:36:42PM +0800, Barry Song wrote:
> > > +void swap_writeback_dropbehind_folio(struct folio *folio)
> > > +{
> > > +       llist_add((struct llist_node *)&folio->lru,
> > > +                 raw_cpu_ptr(&swap_dropbehind_llist));
> > > +       queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
> > > +}
> > > +
> >
> > This is good. For file dropbehind, I see both F2FS [1] and block
> > devices [2] reinventing workqueues in their own filesystems or
> > drivers, while folio_end_dropbehind() simply benefits from its safe,
> > sleepable context. This seems a bit odd.
> >
> > So I'm really curious whether this could be extended to file-backed
> > folios as well, so that those filesystems and device drivers don't
> > have to deal with this themselves.
>
> You should probably both be aware of Tal's series:
>
> https://lore.kernel.org/linux-mm/20260730-blk-dontcache-v7-0-3e8e6850068d=
@columbia.edu/

Yes, thanks. I even asked a question there, but nobody has answered it yet.=
 :-)

https://lore.kernel.org/linux-mm/CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-ap=
SaO5tXp0A@mail.gmail.com/

>
> In fact, I'd base this series on Tal's.  It would be considerably
> easier.

I assume there are two things which might be helpful?
1.  bio_in_atomic() helper
2.  bio_set_flag(bio, BIO_COMPLETE_IN_TASK);

Then, if this flag is set, we move the bio completion to a workqueue.
Right now,  Alexandre's approach is moving the folio dropbehind to workqueu=
e
but not moving bio completion to workqueue.

+ if (swap_dropbehind) {
+     swap_writeback_dropbehind_folio(folio);
+     return;
+ }

Not sure which approach is better, but moving bio completion to a
workqueue seems to have less coupling with the LRU and related code.

Maybe we can reuse Tal's code, for example, bio_complete_in_task()?
