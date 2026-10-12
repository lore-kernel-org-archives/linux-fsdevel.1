Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C248F856
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816075; cv=pass; b=dBHJQypyg55siHS0I3IEmKoUfPM5RFxeJCV2kTkF4HqoAfDXfDmXwwVipwgZZYKXr9JMzMh9LG4al89Gb65h0BQlC9MAqHJ+qWaJddEJr017AYCbSyBRESlKD6fPL52NmKJ86UyXKgFStPZMY3NDoJVkQ+H0IjwNcy920bkK4QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816075; c=relaxed/simple;
	bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRhQoRmGuFxTydAAMDtAR7+OitjUqECX6babRDr+n7u24ftOntxfNPTqjTeTCNY07j9hyDMLxUJNYOlKs3TgPRqufBXQtrfqPHKG7F2kT7+2YnOweKfnhTlUL5F3YhwLaOGlouYjOaVNqYrCt16wg+qnqtKfO01mmknyLI36GwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVqBC87U; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVqBC87U"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so189804785a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 07:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816072; cv=none;
        d=google.com; s=arc-20260327;
        b=mZQm2aDjHYINDdGOD6lDCzyu+EO+QS3T0yHv9EJI40XQHfMBtYAEX2RHaJ0YNZ9rWf
         /bhe+lnq5lcJ/MbsNm3v3QTblEkTIEpaQvn9lmfU4BJa/ieI7kL8qEPxUDETBcdU5bz0
         JCacRDUTEZf8VyW7hValp2v6SWkM4d0PvZ70xGTMkSmTU7rK6C0/rQLuZ9fQwpzhziBq
         VaG1wEjOGCs+H2XLBZswcUG1ivMyHeKsV2cW6wbfhOJs5qzv/iIEz7LYxxGyVofcBdWW
         Zkkex2vOxIpVgZdNhjD+UmLq1BilMpGmHLxc/Tr79QgTzjmuvYWfPkHmTzma97B8gqvm
         W+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        fh=k7JPcRGARZsZ7BU1xFHl+KgEnZljRloCyDf2Vp2YBiE=;
        b=j0vOOhTkMb6WRsCsjqOTWDqxw9Bcp+P8XlEsvwyxrf4HYS0NbThJR7iUUnoSoe0Soy
         82gwvyhWlz87EhsR1DH/yTMLE27uUVn+t4+xHX16IuhtPRfpzQgHnAqpdGH6C5JOwwpQ
         IWrMJlPcO/PMTKeH/xKy+FAV5bZZbXHMLyXSZjtZ1odXZe7xjDVXELomvlPwMe8SApSs
         b3WKUlIzMeWK4FV7VMRj26NQfvnjY0mAF/UiOlm4RaUxkJqxUIOG1CanjSR3K/hUd+FM
         mzJStVqr1hynW8gzIkE6kYxoNUXIJAv9JA9we/dwezilf0qxb+ArDK7I51T3teL3ZGWw
         OX4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791816072; x=1792420872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        b=iVqBC87UfhKVwxBFCemVBEoZNcx+72U9iRuM3Y+2FvFaXZrsRzUhhimRf0MAJXuLoO
         HY/iuZOLKTnZlj4U+dZ7bcv60RgWFS0WPBNPuYggdUKgzQaGQb96jSTNV5n6CiWXf2U5
         6AY2jSZ9hAqyAWvNnQMIF/i7duHFbweXKMf4H/MrOxPHrO5udePbp1QZvTFxKCtHCmRZ
         XfSW608QD2EBGdfzJTKL6pYtCBg6R2yjjjV1we5PVKp4iyb+x4lpDjpazmnpdOTCgduf
         6S9vyarSOoF8aopr5ycGGZzYL23HceO1xHpV6LH6CanG25KDc8M7Kul11p8kXZK/hjcy
         VOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816072; x=1792420872;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        b=tl0wy0Jdn7kyYQSl+qlUA392s8/s0DtImy/8Owd+giCDkAdDKwgGP9uYYF8QALVcjp
         717hW2uxe1uoKAWb2/tWZHBJJCSwTAHhe56mM2HhmsBLXZ7MSEjuyFUH4KEWQpwNMeQE
         lcmpt4snjDr0p0hsnXHq31j4QEgJ6UGDE7maQreQ1PQ7bXwVS0GNDgondKw8zT+gjKov
         74/lEB+6G9AWloj2cEH+x/xCpj5RZKEfHWbW/KxpK8J7YmeAxPWZ8qRJN4FeE131hVVg
         JAJL67KS76dy/MPC/6PZRelOCy5e9hiDGOfQApyCPUhXK5C7EGnsI5f+tmycyxANAI3P
         Kh7A==
X-Forwarded-Encrypted: i=1; AKwUvBzZ9BaSaSVbhst/EcXtnXznh+u3tlH7KD0aRbmPYQNb/64cPpoQaXNSoen62XhZEDH59blJ7Kv4/XC4QnkE@vger.kernel.org
X-Gm-Message-State: AFq9FYLwHsS8Z6/QjianGcf6jz6R79t4r35HZr0ZE3iri2i7EwOltr3t
	Ln+rGqzSRjfrrQkSa3+yw43s7yOiEA9ALl1pQYxZ2Qn/4wQVUE4SoflPp4113PmV0znjpJeeF7M
	t9bmW+e2ndto3ArkhafmTCVS9wh82PyKHk4wmx4KQ
X-Gm-Gg: AYBFou3A6K9VkgXHNR7QRC3E4GedNUXnFOSAYL/uS23hfWy7mUu5/D8XeGYoKJA03jo
	bMn6V/VZHMjdhC4enJTmovh5m6bNSs6c+U+ljNlF6ZG8Ng/w42F9hG0f0Ws8xlq0WMO+8BSAa3p
	KgBOEzYmdpIMqbV4hiYfNoZjVBtl/6u+TInvCYz9EIRDru6KLS/qyj1Fvp2SgwUe8nF47V6dRto
	rODHrAL/DwaaXH+v6Zpw1x7qitat9stsURsqOKI6qm0miFDU9OnlJwKu3cyDjousRfYtaCFhUm4
	G3WlZ4h1wKSaunEW9x19Z8bsvlFByUZKuCgXxG/Le3dv76unN2j5PflNi0kKmODgVefaECXfbfG
	8fBPhX9KtRvFXNXau7EPA
X-Received: by 2002:a05:620a:2993:b0:93e:9508:8360 with SMTP id
 af79cd13be357-93ebd1dd868mr1604359685a.27.1791816071132; Mon, 12 Oct 2026
 07:41:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:41:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:41:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261012095800.50250-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
 <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 07:41:10 -0700
X-Gm-Features: AclHuK-nc_uqkVW8eVTYkrPq_RPqOo6SBs5ABhlJBuD_rVj9OrJECoL16jCBpAc
Message-ID: <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, tarunsahu@google.com
Cc: David Woodhouse <dwmw2@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> On Sat, Oct 10, 2026, Aneesh Kumar K.V wrote:
>> I have been working on something similar for confidential computing use
>> cases. There is likely some overlap between this series and what I posted
>> at [1].
>>
>> I have not reviewed this series in detail yet, but I will compare the two
>> approaches and identify what can be shared between the use cases. Please
>> let me know how you would like to proceed.
>>
>> [1] https://lore.kernel.org/all/20261010072504.536230-1-aneesh.kumar@kernel.org/
>
> Thanks for the pointer. I read your series, and Ackerley's resource fd
> RFC that it builds on. The use cases differ, but the interfaces overlap,
> and it would be good to agree on the common parts.
>
> All three series add a flag and an fd to KVM_CREATE_GUEST_MEMFD. I
> think one resource_fd is enough, with guest_memfd picking the backend
> from the kind of file it gets. I am happy to drop provider_fd for
> Ackerley's flag and field. We also find the provider from the file in
> three different ways; I would like us to pick one, preferably without
> a registry.
>

David brought up many good points at the LPC discussion, I need to wrap
my head around your model. I'll look closely at Fred and David's
versions this week.

These thoughts are just from reading this email, hope to get more
clarification :)

> The main constraint on our side is that the provider stays the authority
> on which frame backs which page:

Wait, is there some magic done to make struct pages represent different
frames, as in PFNs? In your model, the struct page <=> PFN mapping
doesn't stay constant?

> it moves pages between VMs

Do multiple VMs map the same physical memory at the same time, or is it
a move like below?

I'm thinking that if guest_memfd wraps your provider, then your provider
can issue a revocation to guest_memfd (ctrl-f for
kvm_gmem_provider_revoke in [1]) on the move source guest_memfd inode,
then wait for an allocation request from the move target guest_memfd
inode.

[1] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf

> and has to
> survive a live update.

guest_memfd is going to support preservation [2]. Tarun's series just
preserves memory from guest_memfd's default provider (buddy allocator)
now. For your provider, I imagine the preservation flow would preserve
whatever metadata in guest_memfd (like the attributes in the maple tree)
and then go on to notify the provider to preserve some range of PFNs (or
folios). Your provider would then basically do nothing, since those PFNs
already survive a live update.

[2] https://lore.kernel.org/all/20260728121138.1103610-1-tarunsahu@google.com/

> What would not work for us is guest_memfd
> becoming the primary manager of PFN memory, as Ackerley suggests. Your
> get_pfn() leaves VFIO as the authority for the BAR, so I think we agree
> there.
>
> You refuse dma-buf exports while guest_memfd is attached. That is
> roughly what the memory provider interface is for: one owner, several
> users, and one revoke that reaches all of them. A BAR exposed as a
> provider file could be mapped by both guest_memfd and iommufd.
>

Will read the rest of this series and reply again :)

> I plan to change the revoke anyway, because iommufd must not leave the
> device with a hole: it should replace mappings in place instead of
> unmapping and remapping. Would that fit your case? I suspect it depends
> on locking, for example whether you have to revoke while holding
> memory_lock.
>
> Shared/private state and the conversion hooks would stay in
> guest_memfd and the arch code, as in your series.
>
> Does that sound reasonable? Ackerley, David, any thoughts?
>
> Thanks,
> Fred
