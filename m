Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA14183C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545183; cv=none; b=tR4w0mhRxuRrifUL/JnR9KrgEwTJstgernH9gvzI/AFp2xCjyFxOe6fO2oaa27spQF3Q1NSjPpUwTg8gO2rL0y38y523DUb7NuwLMh6uTnV0XrjvYAS7Y68T/fhlBBglcPi95DZ0L6Di6qv0G7cAtTsLilxeaRXIsg+FX0eOpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545183; c=relaxed/simple;
	bh=R3Ew4UG09Tlztc6dINQgLDygyhYIKiJlxV2UJACXXFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVWiVtz99QuaAcREpiBPW+CIUuVM2w2Bo0n1oGDb/PpQvHgVWexKGwUM8wdHKdZHkv/usBH+7BqEKcE1TEXb2FqufP0BmDtVFQeNLw1TH/cj9EnXVh883oEseUvfFvoquXygYegNd2rPkwUlzwbi4cPtDU3lR/S9AHAuWdgphiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qyj6Ikc/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qyj6Ikc/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842208d5b0eso2977128b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545181; x=1782149981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zt0anKDYS0gqDu93ubQsMfBghI6qH1md1eoQ9mMVUKo=;
        b=Qyj6Ikc/P175iZr7A3e9uPRusC3iyGEcnwbNOabEdBMby653PGwTTMzaCJA1eCnHVo
         8bEr0ql6WwV726XfhH3q39ugNyhu5MeoD5lNZ7CWUeojXfnHIJSylW7I/nY4gcyiMkYy
         snXcckzTWP3NPGd7O5eCW6Vldw/J9jyJGa+ETKkQ3NUrKMlbq5tWFIYgUo2gQeudOyzl
         6BzZJaa9jvNHAaYN1/581a/Zazf5msOfdE88ACFdjxAi2S2tQpskGWpHCYyjiOSh6EVk
         gmTKwKYZOq/zrWy0NCBVNZtN5ovRdqI/X4aJpUHTIo0XBZhefTN+La0+hLTV4QlsiT2I
         3G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545181; x=1782149981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt0anKDYS0gqDu93ubQsMfBghI6qH1md1eoQ9mMVUKo=;
        b=etZFlABu5RlfMX93JyZaUMW+GQv8eLWsZyuHBiVgqXVUd0TQ4roG9uuGDByzuM9yrE
         PevT0cLYj13c9NjW2rUof0oTlCIyFMU/TMDFj9xQB6YJmOZK+78MxYVSMLRRM+ajo86S
         j4aetOCVQFZAQD4MArLGRLIw37eGYzlxqNXa3LPUU4sgiq3jpfnOkjBUt9h7H2wViz2k
         ji5NCVbq3j08lq8AdgnnFUosDULP9Ls4qzUyOb/y37M1grvlllVHKsIIesgLQxzUl46F
         8XqY6+XMQI4/e+oeK274NSNpm+fs81vX+SQraVo7QFpmnXIYHid/qBo+XmVYq0wPT4jl
         wYjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E4UvTAQ4O6+Kw8bljc8G4FdW8T6VhhW6tsTyIFdzBdr9yE7E1748N6K8i2PXvqBBGblUlJDtojoW7loQ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2KbHfTUZrz1jJtXO/OUTqC4UN7CO7zXIvJJE9lEse9Vlti0U
	m019Y37QvWTbDqNWXbj1SMxgr0ph2IB+svFQPal35R6GfwDoJRUiLIBi1MrlPQKiYpG3fgzIjwl
	C/Lx7Hw==
X-Received: from pfbmy22-n1.prod.google.com ([2002:a05:6a00:6d56:10b0:842:6be9:dfa5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac01:b0:842:6c02:2fa1
 with SMTP id d2e1a72fcca58-8434cec1cd2mr16474936b3a.39.1781545180989; Mon, 15
 Jun 2026 10:39:40 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:39:27 -0700
In-Reply-To: <ai_aczmeH2IA6JaB@raptor>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <ai_XK__RTXMCEcCG@raptor> <ai_aczmeH2IA6JaB@raptor>
Message-ID: <ajA4z_Wkb93cTW4m@google.com>
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Shivank Garg <shivankg@amd.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Ackerley Tng <ackerleytng@google.com>, 
	Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@linux.dev>, 
	Pratik Sampat <prsampat@amd.com>, Ashish Kalra <Ashish.Kalra@amd.com>, linux-fsdevel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Alexandru Elisei wrote:
> Hi,
> 
> On Mon, Jun 15, 2026 at 11:43:14AM +0100, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Thu, Jun 11, 2026 at 01:05:07PM +0000, Shivank Garg wrote:
> > > guest_memfd folios are currently marked unmovable, so the kernel cannot
> > > perform NUMA-balancing, memory compaction, etc. This is unavoidable for
> > > confidential VMs (SEV-SNP, TDX), since memory is encrypted and copying it
> > > needs firmware assistance. However, for non-confidential VMs (like
> > > Firecracker), we can migrate the folios.
> > > 
> > > This series enables folio migration for non-confidential guest_memfd and
> > > also lays the groundwork for migrating confidential guest_memfd later.
> > > Once firmware-assisted copying support is available, those VMs can be
> > > made movable, the confidential folio content can be copied separately,
> > > and the destination folio marked with FOLIO_CONTENT_COPIED so
> > > __migrate_folio() skips the host-side folio_mc_copy().
> > 
> > I always thought that one of the nice things about using guest_memfd as a
> > memory backend, as opposed to host userspace mappings, is that the host
> > cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
> > collapse, compaction, etc, acting on the host userspace mapping of the
> > VM memory, and outside of the VMM's or KVM's control.

+1000.  It's not just "nice to have", it's a core design principle of guest_memfd.

> > I think it would be useful to preserve this behaviour, even in the absence
> > of confidential VMs (i.e, guest_memfd file descriptor created with
> > GUEST_MEMFD_FLAG_MMAP).
> 
> Just to be clear, I was thinking that it might be useful for both
> behaviours to exist (migratable and non-migratable) for non-confidential
> VMs, and allow KVM or userspace to decide which they prefer for a
> guest_memfd.

For the purposes of this discussion, we should separate the physical act of
migrating pages from the features that trigger migration.  As I said in last week's
guest-memfd call, I am a-ok with supporting page migration as a mechanism, but I
am dead set against supporting NUMA balancing, KSM, LRU-based swap/reclaim, and
anything else that goes against the goal of guest-first memory.

If userspace wants mm/ functionality, then use anon, memfd, hugetlb, shmem, etc.

Shivank, what's the immediate motivation for this series?
