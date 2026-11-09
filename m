Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247664;
	b=tZ+JCz7Pm24Fl+9EWyZs36ixFeXTfdPxG9zQeBZgUg7hGFPlQrfq4bYaJ58x1K50umNU
	 z/grqPs80dEsa0o/1GxjNiDuECts0MqLyc46xUxpzi16vt/pPS24yx4Mh6zo4M410zvbV
	 HpevHKHEPO1D88VdCon/8HNOuUY9WJ9bKR3BQXT6f5bOdvx/66AtUxi2axLMNSQMQ6Gmq
	 bsS/ijmJ43PoNAJxaIjDb4UttrZ3DH7b775Z45eU7go0S38xziqL+SaJvq7oEhhB9jK42
	 wmDDVnyVVJ9mioY7VDwjOf6HvF0pDCLGmzotPxCps563ZaHOqGrIMmFiuEoO4aDKCdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Gt4VMnvmrWa2nAQLESYVbnrfaPMYEizAsDM6TBhtRVk=;
	b=BnPxuTjiTOT1KHkN7QFIvcnju3HM0JusetzKzPpZ8Iy5ey5qUWxfODMcZSP8o8lbyf6B
	 l1xgww+EhO40PgmdOsowiAxeAPyHrhUtY3qD/Bzf5lHvWwKCMqKDX59H1p7FDcG1jSIw+
	 FuZqtJKOLtP51XhX4NgGTFxeVm4vIFXmpkuqVvx2iXt1AL9phGTNQ5GTlyr7MeSS9R7lo
	 Z+uk0CV1KzpBKAhYCUD+62eB/Lgl2jZGSWCi6ViqO2XAQCpzURXO+wcKOmee9+Py9xdoA
	 Wvr3p5dCs4jzsVlugdqce12riR840othCAiet2lRH3K9aPTrUMxe7gYkO5OvlUHQtwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HAyoziJz;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E7606A321
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 18:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B4E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HAyoziJz
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so157838066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794247661; x=1794852461; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gt4VMnvmrWa2nAQLESYVbnrfaPMYEizAsDM6TBhtRVk=;
        b=HAyoziJzIzj0lai961YA2jSswQoaZHbMNsq5P4ILARLdsSsljoEHZuSFxuu9qE0MgH
         01lWziuL0PBlVTZMcWrtGaO+In5eBkBy7x2PGkq4Uik5APY3G7Bdr6nwVklasxWq+lsI
         xDN5oLKYWBtjJx7Z3Xdcwn0bBQIzYnLiHCy/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247661; x=1794852461;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gt4VMnvmrWa2nAQLESYVbnrfaPMYEizAsDM6TBhtRVk=;
        b=UC2Wv6lCq32ERtuSGcUoQcJEMrSkZ8cmGP8lfgHtKtkrYlGcjZ0A3dn9nvWc6jvB1y
         ZRX31m+w4NxM26Epp4MuRY4ABA5osjg8tD22u8q24z7yMxzLAKUIxBztRL09CEKtWzsg
         lpH29trA5m80B9n9ScEroPpHLxgqK5K3AnYBgkPzgmnqFMZaPLeoJ8J2URFRSznTA3KR
         xjfg76fkK2XqhiqNU2rqiIudDpkXmLNtXgiYuOnoLt8fSJhYUPxY8hFNPBdPuDnCJULr
         +0p5hnHOa1OX0yBMZVXFZ1vJBNjRM2SyitbCUAL+b/vp1zKGcwkEvdbcZhHoMdTJw3fR
         qmiA==
X-Forwarded-Encrypted: i=1; AL+hErG9WK0tXYMKpwNkRUFVRSI/aOVlf83/43ybgZkwnfAJcSD+aAmq/ksGfM6fDQCF04k0p7YO8VfRw25VucU8@vger.kernel.org
X-Gm-Message-State: APuU4Z8aC2BFUDY6tUAYWcpD+mJCkN+eJ5gzHPrIVwZnf8VRYxFYEaJe
	iQA9sO+i/pKDWxmFpzYrmfm2hme4mPVE6W40H4Pxt4hxLg96Z1Qq8r0nojuI2I11DgfHALtlpry
	T+7z3Mms8IQ==
X-Gm-Gg: AYBFou2v2l73TB8/Zc1Dj45wu3drII2id/v4BKNor7zPoi7+mNxL0viBUNfVrnZzO7e
	IiEk9Rxymd3ZOVlPYGB+UCSKI5nzGaa/LN4VrVcjx8rJqgT7U3Ou9PrSEtqDyVs8qunUvx+2mMc
	MJYbBVRMJ5lJA4VY2dveye4Hj38S90VHZOCNEzgZ9Nv/MhkIS5HVq884sCJirEGON/d3dgtpBHt
	GVkN234UpuidjFyAsZ3BbhgGYXBVlTZkeHD7dMF6a1qdVf1aj2f2dqJw6lyhP5EtPMCAVZ54q8U
	WolO37pJyZo4UESzU5cs+eWcLZU357q8Tx4DCjo89QFKEKqVP8mWoFsbMH++l4sIlqlZEiNeI8F
	fKC5BmFmr2XSVTvcvM49gX6nR4P+AzJqVlGKV4WHWOJMPX+T3+P+Uz3SUvpQWV71eDWJxsrYbgQ
	vPWzeJlEYPxB04kN93aw8jb7N13qusAKttlnVYKG4wMTKoS6L1ke1doVvqbme8gPgLW617vGakx
	EZ3hhs0F8/lz/na7dLJ9GZmePu0uD+kEDMOSZ0cBpIsxTm55YhX5RMarwmOqY4fpBfbrbp0SPYJ
	SFj+DRVazhM8dc6KLOphny/icKtGx+m2MnpNOZVdwJnzY1vcAN5nmwxSznvNoXvReTUS/pN332+
	konmATUDX56H1CJiKMn34QG8=
X-Received: by 2002:a17:907:1c9b:b0:c46:9e42:2563 with SMTP id a640c23a62f3a-c50496aa16dmr9499366b.39.1794247661307;
        Mon, 09 Nov 2026 10:07:41 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6d65sm679666b.8.2026.11.09.10.07.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:07:41 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5049f267c9so3593166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 10:07:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFb5ljh7vmSFBOFF3E/lcUcqpxTM0Mywn4a99QGhmcUxks7WySGpkeHdRbbNv3LipdXF1WtExbSeAFANSW4@vger.kernel.org
X-Received: by 2002:a17:906:478c:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c504973c481mr7202666b.47.1794247278274; Mon, 09 Nov 2026
 10:01:18 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104130118.2507513-1-kas@kernel.org> <20261104130118.2507513-2-kas@kernel.org>
 <ecad7b3c-7244-425a-9413-04d49f221057@kernel.org> <au2lsbDkyWt-To0C@thinkstation>
 <aa2a1e32-9b1d-4545-b2e0-03d213593023@kernel.org> <CAHk-=whnH5qLJH3Wd3bOxv--Ei6674Jo4iifGD_MqzyJg2Jm4g@mail.gmail.com>
 <8504e28f-faeb-41e3-842e-0cb74d1a25ad@kernel.org>
In-Reply-To: <8504e28f-faeb-41e3-842e-0cb74d1a25ad@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 10:01:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihE=ioLKrwzz=WQSJg6HhB-syu4hqZ2QFwgnwYmmLEgg@mail.gmail.com>
X-Gm-Features: AclHuK-A_qW69_o6tagKDJ1G6Q8E_NGG5rYMm4wqMXtGYWO1MbLxTJtWgkQTGLI
Message-ID: <CAHk-=wihE=ioLKrwzz=WQSJg6HhB-syu4hqZ2QFwgnwYmmLEgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/18] mm: free PG_rcu_free folios only after an
 RCU grace period
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ilya Gladyshev <ilya.gladyshev@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 09:24, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >
> > I think trying to corral it into some special case is the last thing
> > we want to do. It only makes things less potentially useful and more
> > fragile.
> Let me wrap my head around how this would look when we decouple pages from
> folios, where pages might not have a ->lru anymore, or not even a refcount.

So for an example of a place that already does RCU freeing of pages -
*not* folios - look at the TLB shootdown.

It's very round-about and hard to tell, but it's using

  tlb_remove_table_free
    call_rcu(&batch->rcu, tlb_remove_table_rcu);

and that then does

  tlb_remove_table_rcu ->
    __tlb_remove_table_free ->
      __tlb_remove_table ->
        pagetable_dtor_free ->
          pagetable_free ->
            __pagetable_free ->
               __free_pages(page, compound_order(page))

(and I might have messed this up - this really is a rats nest of
nested inline functions).

And in order to do this all, it sets up *another* page just to contain
the batching (which is also RCU-free'd)

Now, the batching is probably a very good thing in that context, so
I'm not actually suggesting this should be converted to some common
RCU-freeing thing.

Rather, I'm pointing out that we have existing hacks in this area that
have grown up over time and would have been a *lot* less hacky if we
had had a proper RCU-freeing page allocator back when that whole TLB
freeing code was written.

So I'm not saying "we should unify this". But I *am* saying "look, RCU
freeing of pages is _already_ a thing, and we have complicated hacky
things in place for it".

And they are complicated not because they necessarily should be
complicated, but because we solved the TLB shootdown after we already
had tons of complex architecture-specific code in place, and we
basically ended up adding that RCU phase on top of that existing
per-architecture complexity and abstraction.

*NOW* it would be actually fairly painful to try to convert the TLB
shootdown to a new order. But originally, it would have been very nice
if we had just had a "Oh, mark this page for RCU freeing".

(In all fairness, we also did it that way because some architectures
don't need the RCU delay simply because they have some other hardware
page walking infrastructure than the actual page tables the kernel
builds up. Not that those architectures *matter* today, but some of
that per-architecture inline function stuff is required to basically
isolate these kinds of decisions from the MM code - that deep inline
function indirection has a reason that is entirely independent of the
freeing side).

                    Linus
