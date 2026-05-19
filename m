Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FD377EA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217002; cv=pass; b=ICXKj518dFc1/lxNIYK0SvD6VUFRjcdEmjj/gkW/YhRRPhoQ2G1K4uEICEQY87PIAqnTgEJ8n8JGl8TjLqJTE9DeTYC6PL+z9QdyT71iJlhD3dFwSbYrg8rWe/jMwAscRCxmuCVZPHT9WKsmrinLBQBGee5XqPuRGdPteuoLrKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217002; c=relaxed/simple;
	bh=VoJiSYHkyb93U+CpFIcSkKKZJudViTXrBB5J9PwFeQA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjOFLHfXIY9vo1pWTwA94t4bp1I//SrhgLWT5789DZTY9GfPDIrpQPpDEGAwOT5goYpTV1gGWAlpzBTmM//kpGWfRuwMrE3aURAl1OZ0HayluQkME3ba3CPKi/oLuXGjiltoBbfhYjxW57o/pk/vFkgikFqXfB9dRmQBVYmNUWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K58qjznf; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K58qjznf"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5771954bcd0so2749160e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217000; cv=none;
        d=google.com; s=arc-20240605;
        b=b8BSkruSCdc4dTOoFu3cR9aCy/zGU2SIt+v1QA8GKW6HkUep73Ghw5/uMQ/+apG3Tq
         fXgs/GsQiN622cFNy0y6+M43hwvzjv1mVKimKNJSqMDgWvbdDodp5DpUaiZHf7otoKrA
         b9nrGdKH7s04CetTrksx4g5ClBXYK2AEyArBIHU56OWvaUylfV3It+cDE8N+daPjZmia
         dP0o7oCcytQInmLcwDGJqCI5JVaMyZYiDOO67AHXlPj02vzAfRGruC6QVM5wLKyjFx67
         x99m9uDKZ0++8b2ArIleWMFlT9Em0CGgOfR+nLEfjnbqJfpfQeG2S/WFyoTlxSuvw0Du
         Bw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        fh=YikjDWo4kwpRm1bTi4kpoJ+bKspsR6KF7sA5We+U6dg=;
        b=d58tJhoAqJFFc6H+b1LroALwFftyhCT8fF2nWSmU0mkQf8Unx2BpJqxSmsI4otkWfC
         sB6Zx3jY9YmZrGwHWq1C0T3R8ktGWQboaHxmgq58f2mV/RC9GslQfBY1te9OxO+2txTv
         qGjwW8HqhYGk8Mk2dWq2OMZofwg8fCSLaX4jIKV152SeVvN5aBHLsUk9dFiO/lYS+jZ0
         fGa2PMB1xhl/69/h2RHvGjbEylVjBmnCLW/x8xVX1GHdRthihhj4NMZinNGFMT3kqO2G
         qfqcAQLLP4KJvPG1OSF9eX9B6oPwsSNTmgAJVOHcqBtt9DeSixpclAX8PSRjpHN0CQYV
         sp3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217000; x=1779821800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        b=K58qjznfIkYOiC1tPg6QfmGiKQBWgkIc8INR1T4iaB07msA9+eIMYWKbhbpbDPtjJN
         CC4LAkCx9m05s8Tt/JMHarvQRABgBeTu7voCDoZKLB6GlBq83Zq1yF0GgS80R5/RIE7x
         b6lNunUiKHyKEUIDKo9h2CCeMumE+Hxu4Fo2rxRqnIS9l6rWNnmI3iVzBwrEhuuEV5y7
         nYxyF+DJCYVrpIzX9RxLrlMQPtTn3TyYL6D2SZfzpz1/RVRfd7CJycQdkU5EW7ynD9Au
         y+k2U1BP0o4Yv+OcAzP7cjZV0k9jq3lwgNBHUiUSIgmE0aIweyE9QMMGXqA5U478nEPi
         Uokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217000; x=1779821800;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ1om1XG26k9c/pw0fQSTui/sos+jK8LcvkwRi0HW+8=;
        b=mnVKAi5y8X2D8vlANTNhjND7w4556/IIhVXEjMGwP8wg3xF7S+ezyIsKIS1KTG+P5P
         2A6+J03nxi+9vl4YvQzHPrZzUpp4bWBv0CjA13UiO7Mmv0YKlSIPd+mINSnGDFGI7z9Y
         /AmnSjk4vZo6vypc2K5F8mNuZ9dq+ncjJ1u7up4saVXc4TNsmytqaeijP0XVhpck3g20
         5RohulpUXPDDNZo4RtvHmXck+/c6s+ivPJKoCIqc1Fe9A2OoHdHARC4Em0fGcnwhtnGp
         y9H16pi/I4ZHCqKCUpH12IqAb0ebx5aYWj1UotxB+FMiQd+zYGI6rSAjj+0vyXEiLI5G
         LSdg==
X-Forwarded-Encrypted: i=1; AFNElJ+VBkI9XIuH5nBR7ktoa3qWMZPVQ38J2i+ksdI2ngCh5LlfYsh+Hdd3V5Kz/I8ydgpq64idpR9khzePaXoP@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIRF+nxyGBVXDE8RKP4ty2YFX654CEX3Evu1Ha611RiQefqdm
	NHDZ2Gk/AJqjV8mDpCvmxkIRjiYhZzr2NUMLouq4buB85f3BMh0Z1vVdxWajMSPrMP8gZ1BbJOC
	ZQUxmTdkazEMbsIn9m4bUPrDWE9vEno0pu995C9Y7
X-Gm-Gg: Acq92OFYAR1m4LGmCt+NUufs6/Git7XIc2vG1XLCz4A4KkiVIFKAYhwcJyz4W5YOnE+
	35qb9xpezFbSq9RvXaXRSeNy9eNxnoM/NvcJ34sAl+Xf+N7aeKwQIgLnDpE0Yb+LoI8ArYI8mWy
	dbEjlewOQzLLNgUPhI32j1k2SU3fRdmfvUd6rka4F+K5FBW1PDA+1ZgH43hJFzUhYjuKg78X3cr
	HanbMF5K2kUYz8mCawSTrNrfZ0zsoHCobJ7+6OuWTfvOMYb6mMDWd637yc403MldDjKCGBeOGhJ
	hD+ykjg0oa7ZLvpxCXgR7dC/3KWai82Rn6ZvKJF5JL0CLqr/efmJJW/Nhg+pNw4PKJJ2ZIYElbV
	9fw3t
X-Received: by 2002:a05:6122:d86:b0:575:3b1b:ef01 with SMTP id
 71dfb90a1353d-5760c0a6a7bmr12548926e0c.9.1779216999523; Tue, 19 May 2026
 11:56:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:56:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:56:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <agt5wTK5I-FvlB57@google.com>
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com> <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
 <agt5wTK5I-FvlB57@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 11:56:38 -0700
X-Gm-Features: AVHnY4LPzDj9g5FV4_YaYz9tvR_M1MnLgRQGl6BwcjJkV-QhnQjrw8WLfhjN4fQ
Message-ID: <CAEvNRgE+xXRTWHzAetYhQN-OeTHipspbfvYNzaExe89E_sRkBw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
To: Sean Christopherson <seanjc@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, tarunsahu@google.com, patelsvishal@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, May 15, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >> +#ifdef CONFIG_USERFAULTFD
>> >> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>> >> +{
>> >> +	struct inode *inode = file_inode(vma->vm_file);
>> >> +
>> >> +	/*
>> >> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
>> >> +	 * This ensures the memory can be mapped to userspace.
>> >> +	 */
>>
>> Is the principle here that any memory that is allowed to be mapped to
>> userspace can be userfault-ed?
>
> Yes?  It's more the opposite though: memory that can't be SHARED and thus can't
> be mapped into userspace can't possibly support userfaultfd.  Six of one, half
> dozen of the other, but I think it's important to highlight that there's no
> judgment call being made, i.e. we aren't deciding to support only SHARED just
> because we're lazy, it's a hard requirement.

I guess this series is only intended to support some kinds of UFFD, but
IIUC technically UFFDIO_CONTINUE can be used after the private memory is
inserted (e.g. for TDX live migration).
