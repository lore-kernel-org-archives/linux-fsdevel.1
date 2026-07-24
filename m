Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F58435509
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911885; cv=pass; b=JiPe7/M5YJLb7LZAcQg8x9PCMpxfzWG/Yaj2V8Vz5nk5s0Y0av/BK3/Z31oSdd3YFIHmUG+Ylby7corIqOLRoybh83irfURxoY7fJnkeIHS+wOFSwrQ+JSCB30c/qb2KTl5pn003BsKUO0YMqUh97ir85rOqzHWmv4WcJCU5qjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911885; c=relaxed/simple;
	bh=06ezevvS+8MzQnAuRUEIb+ISnP6vqqmbhMKf32l5Yvo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPgxHXFGWzOpFtHE4FEDrZIxFmsWamyDKXMqmmGrafQoK73eBVSwylfwCk1suVliFhRE09hpC3V14R8iYkyHTSvrXAAV4dfrFEpqbLch1VN4veM9d8hRLccA/gwaOJkwZNe++RxfEOUK9N8rvl26U2a5SaO/vscdwWiA9ifVqWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2bvXKA+; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2bvXKA+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so640475a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 09:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784911879; cv=none;
        d=google.com; s=arc-20260327;
        b=exiAdk61Q4wu1SKN/VR/g/Z7ekyM1r4bdqx5nX1ohjvgRGii+l9T4GDDHEnhLyekEn
         xsvtz7DTzEKKEMzMzNia9wkgro+93OjC44uA29VvHIn3OuTFK2filuhDWY28qFhcTvlt
         6wvWNd309MWOJrM6d6CPyr5I8fP1yQZ9yfm7EDXp9r3TF9snBd1Iy1tS7atRl7QWgtPh
         htlESjSK/eTc/i24QZekbvKr+csmyzsRRnpIupZ+9Xhl9ugfYyirZudbYxfPapOhzDXH
         RKWGRTEyCNgvxaNACK7hqnZJjU0v6J2W6X+Z4uRB1+EVu+z14GVz7oxIycoGhQU5v3c3
         6GyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        fh=UTjB1hn/Yx5csTrRAkLbedxqSX5Ar0TYD0kkmBLwrbY=;
        b=r895DFAbXuGgzmwjaKcuCYgizJIkWuLGljduMZJ2aQDdClRr3errRE4S7NV0BnmqD6
         6AEbe0W7UU15ymghgnoLk2uBvPfGiRZrmM28O8eN7XafkpsRCzqVAK1nbj5GbLavIv1x
         iRZ4PXL5d9Y5xKrbPqdQfIjL+zu3nUIYA2tbVEFCO8MaNHU0PxtKZyidcIi90wYt72kh
         aXVf/9WibJxQwaRvi8JgrI5T0UA7nzMle0D8FYQBrA9lkplCxK2xLbaYlGRrO6XAOO6G
         QMhmec+I7ET0wiHNONCPBp5H3NTiuKnt5CUHn+KfPTESP3viKC7eeRvDZtgBH8ppOucb
         fn1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784911879; x=1785516679; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        b=A2bvXKA+j6bl+q/IydKaPWUyE7WvWH26dknyCUPGHPs77/hxLCjCzQlFZskk3AZWfv
         JoM/G4pJPTMRWrunqO75JJQ/24hq0JNKac+sIlXj5Gs2LLHJQhqhaoYjI7HwEloU0i15
         yIO37/dS5sjGyyTiYCSXIslkQQcgnIzhjgpH+QWXTnSRiMSpFvQWFnUvnHl7Dlrf1GjZ
         EpyhRLWjPko8FdbY5ngVEfBOQovlAXYzMM4OSiXnlfcLESsH9obAte7KEvAzMnkF8TeX
         It7ZKfZaRaq5daeeZahsLX9EqGl1rqyfXhmoaWqrsdakXff+FNko17Ix7Mjn8yKjC1y3
         /hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911879; x=1785516679;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        b=W+4JjKnXmOdwYujsus39RTrT8tEmAI3LbM0RIR6+kEAee7lddeva2vqExzgH+mUm/q
         47sram2E2532BATXq0XrrTAm9ruJlrVkIposnLOcVbgU5Qhkeu/YTvvrQU5grH11sfG5
         r1sUtT4DDslzp9eSw0pbrJHImg/Z4H3yfpb4ctYbPM6T/a7KY3yQ6dY/44BHRJvaZue8
         7/9+RWAa4CG0yYQYo1kgeVgh4iZLfU4BKU3HVgkU7DHX2BJrvhdAMRkD3gE7HMGqWP6i
         9qIkBWnwKeyZG6blvSjctbC+sHXL73pECQ/antE/KBAPT3IN6mnaipdhblzCtc8JWKVZ
         NMXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZWRWkHj2iokZDbn/fizmk+73i68iT8vFloUzu0BB/45wUylL1irzJ3AiGcSkfipXbrLFGOYg1brLT+emX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nezZaxDzCkNzsz4HdkQaM7AvcNKjojDUbAbr0FwoyOPvocF1
	SFBBQnaAR2snidSGTFklic8iq6WxDiLbm9Z5n8g7rKma31Z1Nki5/2oLkD4OJ3M7kyqi6x59Yb/
	sSvI/lw820Zh1QeiPhdNHFDj54RUmXzWxiTFBU9zO
X-Gm-Gg: AR+sD13Rx5GiprH0OK1Hw1bg+nE03zyL354FX2h8zVFdA9+bs902hKDNiDhmU4I+NXQ
	SIMyfNX0a7JmA/L3rQbvuVL4zbJQ5OVfqb3+WhJxEGbZiORhryCMNQghhzzW1SCgvDCl8AAL9MD
	6cFRax7ZPPc/gVbHS8hJI1z2PePzBwR/KG2r8dOo76yu+WAM1x8Sh2/oOZCFgVUY1nXP81Ov1+C
	YElhHSEGPLavJxokgqMKqSzfeCoCpn6YaaXo2WZDVyfa/vyCXQHknb6hCQJpPsLm5+bogAZN5n6
	eVFopXeU/GWbiKS4Qd/nL6gokMtvu7qHFp2CjYNF6h6kmfod
X-Received: by 2002:a17:90b:4c0e:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38ec648af5bmr7316123a91.6.1784911878269; Fri, 24 Jul 2026
 09:51:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:51:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:51:17 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amOByZH4oWzmO3Zj@google.com>
References: <20260723143034.175661-1-willy@infradead.org> <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org> <amOByZH4oWzmO3Zj@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 09:51:17 -0700
X-Gm-Features: AUfX_mwyv48CMhJeCiSTsLkrFrJx83-q7QT7s4fVGWdzAx4oC8CARZPYON4lVII
Message-ID: <CAEvNRgGs4Y_A6FAAnyrdUY2icmZ=iVPit31VWo0vxZiHFcyeYQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
To: Sean Christopherson <seanjc@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 24, 2026, Matthew Wilcox wrote:
>> Sashiko review:
>> > --- Patch [5]: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page() ---
>> > commit b4db4098463261fdf87a2e92b28ce2b4c9445e74
>> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> > guest_memfd: Use folio_has_hwpoisoned_page()
>> >
>> > This commit changes guest_memfd to use folio_has_hwpoisoned_page() instead of
>> > folio_test_hwpoison() to correctly detect poisoned pages on all large folios,
>> > not just hugetlb folios.
>> >
>> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > > index db57c5766ab60..94eedcc7f1a9e 100644
>> > > --- a/virt/kvm/guest_memfd.c
>> > > +++ b/virt/kvm/guest_memfd.c
>> > > @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>> > >  	if (IS_ERR(folio))
>> > >  		return folio;
>> > >
>> > > -	if (folio_test_hwpoison(folio)) {
>> > > +	if (folio_has_hwpoisoned_page(folio)) {
>> > >  		folio_unlock(folio);
>> > >  		folio_put(folio);
>> > >  		return ERR_PTR(-EHWPOISON);
>> >
>> > This is a pre-existing issue, but while looking at hwpoison
>> > checks in guest_memfd.c, I noticed a missing check in
>> > kvm_gmem_fault_user_mapping() that might trigger a host kernel MCE panic.
>> >
>> > If a guest_memfd folio is allocated (e.g. via fallocate) but not zeroed, it
>> > remains in the page cache without the uptodate flag. If a memory failure
>> > occurs on this page, it is marked hwpoisoned.
>> >
>> > Later, a fault could trigger kvm_gmem_fault_user_mapping() which executes:
>> >
>> >     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>> >     ...
>> >     if (!folio_test_uptodate(folio)) {
>> >         clear_highpage(folio_page(folio, 0));
>> >         folio_mark_uptodate(folio);
>> >     }
>> >
>> > Because there is no folio_has_hwpoisoned_page() check before clearing the
>> > page, could the kernel-mode write in clear_highpage() to the uninitialized,
>> > poisoned page trigger an unrecoverable MCE panic?
>> >
>> > Should kvm_gmem_fault_user_mapping() include the same HWPoison check as
>> > __kvm_gmem_get_pfn() and return VM_FAULT_HWPOISON if the page is poisoned?
>>
>> I have no idea, but the purpose of this patch is to stop kvm from using
>> the wrong API.  This is definitely scope creep beyond my level of interest
>> and the aims of this patch series.  I've added the KVM people to the cc
>> here, but I'm not going to do anything more with this review.
>
> Heh, you don't want to sign up for a week or two of onion peeling?
>

Looks like Sashiko is right, we should fix this separately.

>
> [...snip...]
>
