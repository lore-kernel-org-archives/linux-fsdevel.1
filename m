Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107D36A377
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723339; cv=none; b=TR9I90zZ3tAs+waJek15E1ko0su1oSRJwixJ2UgXqbOCTLHGQ8nutUQc7mSQ4wNY0Cq723Vcj3uUNNuQgMIJQxs9a8BBMltSHaxR0Qp72v9oj6eOFNxF11OAJCcba/A/vPIzinLKXBZHT441hmSplBBCfd4//myaHL2KwwMql4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723339; c=relaxed/simple;
	bh=iQpjr5fJ0FGJnIGe3ONTjxP/7vJYxnkvS87QkOPQeac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1jVRmO8dkF3LjiANxEKAgW7rTGOiAYnPFsnCxZSGX7iG39PK49+8EP1i2NCYCCwF80GqWQKQZSs/7mcoUMhK/109IBXenWlqsMOqzjLKrOz1dXI6/p3afuHKExqoT6xETB10Wy+LRfKXhKhlfQ//3P1XVW9UYHbP0xKtARASjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l0IvwqsM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l0IvwqsM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0c68aa31so91138601cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784723335; x=1785328135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIVz1DID8CeKWsK6GdOZ3gM4R5/BpOF1rbBDSWQ/gXQ=;
        b=l0IvwqsM6zlM7NkEgYXDzeGbn6uOx1oqhRhYMdNJCeynL7xP69Zoq2WDhy/+9575uV
         GvrY/ubHPcryeLmgg4oLIe3VCLLynP9wz4toMy89OkfW8FI6crAKbGIbnfMXCvqMHIVY
         dcj2JUzLCI3Oz3712KvA1Dayhf8UwqMYWl915SLcQTK52TLIUtQ0ejLswXfYZ0Mp6ku0
         FyZu2DsnTjLVxHKHI+NtM3TaGCYWXLkjnODgNmg2bQJCnVQP56n5qdeGTyEmoKKKo439
         kwQOfJoqzLvuwXCn58xKmZlz0wI6AlItNlAyZPYt9zavEvBTzo1UNTXFhaWJUw52we74
         TS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723335; x=1785328135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIVz1DID8CeKWsK6GdOZ3gM4R5/BpOF1rbBDSWQ/gXQ=;
        b=PbrkToS/aYVUVM+F2B+DyiPW9IvSx+lT4mPZhrbTYHdEIinXOvi0+nnOfj8Vj5zbO8
         bt1WNRRt6g9XjxvlzwFnSM1rnACseRuH759IUwFDPkqnyr8QgSmjv0x6uC1zGZBv2ENI
         QAov+le+63p67EzfVlT/UktqQkys0+oFUsbhtPr5c4ZkwEJ1EWp6OSVHWHrQXIbpFSRW
         H5OPmwcXqXPsRh2Fzm/UWXkl7Dw0LcMjnqyuzSdQSmIN6iJQf5tQNarHliyyzez8gMtt
         WrcIrsp13N6TDOvHyj5XY0kW1LDVgJP5PBL29LFfP2z4/AUyzQV1zd1hPvVu3BZF8gPY
         Jypw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7Ancx/UuDzPJMK+bi7sLsasZfT4qK/AHNt7Qu5jXdwkSLIjNAarTALPCJ2O9UuYh0E23kRc/7Joy6zN2p@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxLaf5ppCX6NpKNg7VKGdf67Eg1K4bNPzXaVI4QBZySD/gjTi
	N20sGU9wNqlS6kPtKAaAbk+3sU+NsdwW8if6XUKfp0Hd4v4cdIF5HSHMjHJiwZwgWGg=
X-Gm-Gg: AR+sD11R4cIstb5+He7iVKoZL+H9UK7p1srMvlfHuI913a93f1EDFjslyi3wGRiIvn0
	4TttsPy4j0ZF9ZhFcaHZIs0Sssxk0XWEchrs8jmoxllIodmT2BYQdj2CWolHelCjV38V8ya6RQf
	uYyKHdWRDfJsEPuz9YHQlU792dHqyn0pso2FqM3Wrfgx1Epgi8ycmilQL98Iacx2cY0Lo8PivnP
	aSw8J2WtqjovhopU4ZHeECaLkEbiRuHrgZjWtRjMMumr3tR/sb2zYQ5njKf3fjqlxnSYL/puztl
	g/Y4vZHHPqoMLgp9CvJawzR3zjtrRFPeDLyY2hZ3e2A/TrLt5fZDftxPVmknwyusuQKHgVXIDmX
	/cp4PneRBkdej2JLlUwua4qL5Gnb7vcKYYlzDyOa0tc39aOiGjB4iENILkQZ3+Tb2GYnOXq/GAn
	5Bj3zioRJnbWT9kZY7EIRiIkszbn4SlX6Vp95rsXg4d2kTqywYhH2EB8qv/w==
X-Received: by 2002:ac8:5ad6:0:b0:51b:efbb:fbf with SMTP id d75a77b69052e-5213aa6e321mr250430031cf.18.1784723334838;
        Wed, 22 Jul 2026 05:28:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm13968621cf.27.2026.07.22.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:28:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 08:28:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	brendan.jackman@linux.dev, yuzenghui@huawei.com, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <amC0vzXEEnZaWim0@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>
 <al-2D_7NcwMxqmsM@gourry-fedora-PF4VCD3F>
 <1d8b6857-de1e-4807-8201-4f6a49a3b8f7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8b6857-de1e-4807-8201-4f6a49a3b8f7@nvidia.com>

On Wed, Jul 22, 2026 at 06:29:53PM +1000, Balbir Singh wrote:
> On 7/22/26 4:16 AM, Gregory Price wrote:
> > 
> > User-numa
> > 
> >    Some devices don't want the user to have control over placement.
> >    I have been working on compressed memory, for example, which only
> >    ever wants to be used as a reclaim-demotion target.
> >    
> >    (The reasoning for this is another thread, i plan on publishing
> >     my research on this this year)
> > 
> 
> I don't fully understand, how do we allocate memory on these devices then? Is
> the driver expected to allocate and map via vm_insert_page()?
>

It depends on your use case, but yes that's one possibility.

In another use case, you could enable (CAP_RECLAIM | CAP_DEMOTION) and
pages are allocated via alloc_demotion_target() in the reclaim path.

For general "device hosted memory", you can do a variety of things:

Direct alloc 
    ioctl(...) ->  explicit alloc call
    mmap(/dev/my_device) + mm_fault handler

Or a kernel-internal mempolicy
    ioctl(...) ->  set kernel-internal mempolicy on a vma
    mmap(/dev/my_device) + kernel-internal only mempolicy on the vma

The KVM guest_memfd patch included at the end of the series uses the
kernel-internal mempolicy mechanism:
https://lore.kernel.org/linux-mm/al-pkvmgIxGu3LzM@gourry-fedora-PF4VCD3F/T/#me04a7e3556677babd82bfe3947b1a83b7f0017e1

This pattern is needed because the memory is never mapped into userland,
so userland actually *can't* set a mempolicy on this memory itself.

and then of course: CAP_USER_NUMA + mbind/set_mempolicy directly

This is kind of the point - the source of the memory has some control
over how it can be used.

> > Hot-unplug:
> > 
> >    Some devices can't necessarily handle unexpected migration, and
> >    hot-unplug is fundamentally a migration.  So the HOTUNPLUG cap
> >    actually means "hot-unplug can execute migrations".
> > 
> >    If the entire device has pre-drained the memory (all memory is free)
> >    then unplug works - it's just not very hot (no migrations) :]
> > 
> >    Maybe a naming issue?
> > 
> 
> Yes, I would prefer MIGRATION in the name, HOTUNPLUG made me wonder how these
> devices come online and because it is a device, it can go offline while the
> system is still online
> 

There's a difference between device hotplug and memory hotplug.  The
kernel's memory hotunplug system can at best be described as "best
effort", and if hotplugged as ZONE_NORMAL (on a non-private node) you're
unlikely to ever be able to hotunplug.

It's possible that this CAP bit should just go away and if the device
doesn't want its memory to be run migratable then it needs to hold extra
references on the folios.  That's probably reasonable and looks a lot
like a long term pin.

(note: I have to respin for Sashiko fixes, i'm likely going to drop most
of the CAP bits except USER_NUMA in v6 and have them come in with
specific use cases).

~Gregory
