Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8B3655F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906188; cv=none; b=UCRWYuXnRUOBUqW4EON0DMKIEi5T5LfJzbGclpwPUOBdLmzi4nI2d5q+0xp7wojTZJtWdSxU9B1s1YaxOBfFfZzU8q1//hwLAtj4I9lBnitbace6k4W29dvD9NwKMSy9gZE9U6Kil5DbGuygz5LuAGGAOAUDzJ2g4nw8l+lTCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906188; c=relaxed/simple;
	bh=DONY1m1MOqXdIXxaI3VW6vUwwDHvLeEs+Kz0gorx0jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CdB5UKkAuBMyDnVRuerfbG83X0/Oa+5nngdc6Im7s7YdZnkauf4wqfz8slot0oSsekkr9fQ7Vd9OLUQzJIS0bfrhgq7C/4nU6oKrtylk8pNREzUdSRjC/kvu84s6Dls6AI21uZf0AaURvdIvoS9lb+aTrNBAJPgLXHVujBjPicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upu4uzx1; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upu4uzx1"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so849962b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784906186; x=1785510986; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7tZ6rxVHVxA9k8QZg3mxz8r9NteqReZr++aWJKr0sY=;
        b=upu4uzx1Ah45VrdPE2u6f+ZTk55Y918o+35LGTgf+R4c3KUfTOSVwXdD6kq1DkHl9Q
         AdYxR/xOhK9UwCbQD6E8/tC8nN3/pO8L7h2o2HrdWvAoWoetLkNSQ8rrFR7Rp+EvTbEU
         Mm5IOLWsV8qmxF3TKI3U3aAQZX/KqaxdadUIf6BKBsDiCVFCC3joprumO8nc9X/SJufF
         nAw1rkkrZE9zcbrXa/fBEIFMZPFMq/agoURkaCl64dB0mQ7XEurSg8ue0wt/NIN5UcpC
         A63viR01VPWKy1rLKyoRAz8or8j0+BG+aFCq6qBNkhJ96GWaWvzbiT909e/S0CSEehKb
         LMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906186; x=1785510986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7tZ6rxVHVxA9k8QZg3mxz8r9NteqReZr++aWJKr0sY=;
        b=tEobbwhI5BYEdAGLQUIOwHDBUWZ5wgrTqGmhTc7zR4VWQwlTXqYHo82L6O+SHi3QrA
         kE4gyDQNPECRX0xZ0RN2XtfCCMAMAWAc2hJdUAnpgS/c5TvezRhJCet5yZuLJC9+WCRg
         vJ+Kt+4eIAvufu13quULqoPDKqvVlutPamGV9r2RiqGXv0o/a69GnvtD6vqM01wjggR2
         A5LyyGe8Rx0eUArjYfgyoQ1a79s5Wlg/7N9OQddnJGpGmw0JKanb5D3M5eGVD7UOUj5X
         G1bMuDALPe4KfQgy2LxQK/uL/1tZH0ufzsh0ppNZyKou1edV9MkFMmlOzu2KFFUPl5W3
         k0TA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/EV9LI/1YhmFpLlPx6r7rbQAokTopaam/vWUF4eCjvKJJgRUA+T/SGVNDpYgZ3M65wUS5T6vByO1FnIlO@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtdYWuUhDGsTcQknnjEgt6cl490uZsFehsRHIpXhVd057CczP
	wgLby1+s7TzamGQF681+FMPTjeiT4mRCOsG8LGFthK4ea7STwFg4dpdIceItRCA2AFe51iV9llG
	AwNAYZg==
X-Received: from pgkg14.prod.google.com ([2002:a63:fa4e:0:b0:c86:5f41:8c94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4211:b0:845:d274:bf8d
 with SMTP id d2e1a72fcca58-84e2bba4cf2mr8891334b3a.54.1784906186191; Fri, 24
 Jul 2026 08:16:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:16:25 -0700
In-Reply-To: <amNeKcDZ66VrQ5PL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723143034.175661-1-willy@infradead.org> <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org>
Message-ID: <amOByZH4oWzmO3Zj@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
From: Sean Christopherson <seanjc@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 24, 2026, Matthew Wilcox wrote:
> Sashiko review:
> > --- Patch [5]: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page() ---
> > commit b4db4098463261fdf87a2e92b28ce2b4c9445e74
> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > guest_memfd: Use folio_has_hwpoisoned_page()
> > 
> > This commit changes guest_memfd to use folio_has_hwpoisoned_page() instead of
> > folio_test_hwpoison() to correctly detect poisoned pages on all large folios,
> > not just hugetlb folios.
> > 
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index db57c5766ab60..94eedcc7f1a9e 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
> > >  	if (IS_ERR(folio))
> > >  		return folio;
> > >
> > > -	if (folio_test_hwpoison(folio)) {
> > > +	if (folio_has_hwpoisoned_page(folio)) {
> > >  		folio_unlock(folio);
> > >  		folio_put(folio);
> > >  		return ERR_PTR(-EHWPOISON);
> > 
> > This is a pre-existing issue, but while looking at hwpoison
> > checks in guest_memfd.c, I noticed a missing check in
> > kvm_gmem_fault_user_mapping() that might trigger a host kernel MCE panic.
> > 
> > If a guest_memfd folio is allocated (e.g. via fallocate) but not zeroed, it
> > remains in the page cache without the uptodate flag. If a memory failure
> > occurs on this page, it is marked hwpoisoned.
> > 
> > Later, a fault could trigger kvm_gmem_fault_user_mapping() which executes:
> > 
> >     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> >     ...
> >     if (!folio_test_uptodate(folio)) {
> >         clear_highpage(folio_page(folio, 0));
> >         folio_mark_uptodate(folio);
> >     }
> > 
> > Because there is no folio_has_hwpoisoned_page() check before clearing the
> > page, could the kernel-mode write in clear_highpage() to the uninitialized,
> > poisoned page trigger an unrecoverable MCE panic?
> > 
> > Should kvm_gmem_fault_user_mapping() include the same HWPoison check as
> > __kvm_gmem_get_pfn() and return VM_FAULT_HWPOISON if the page is poisoned?
> 
> I have no idea, but the purpose of this patch is to stop kvm from using
> the wrong API.  This is definitely scope creep beyond my level of interest
> and the aims of this patch series.  I've added the KVM people to the cc
> here, but I'm not going to do anything more with this review.

Heh, you don't want to sign up for a week or two of onion peeling?

In the future, please Cc at least kvm@ on any guest_memfd changes, both to avoid
unexpected conflicts (the code is under heavy development), and because us KVM
people are still learning how the hell do filesystems stuff, and can use all the
help and knowledge sharing we can get.

Thanks!
