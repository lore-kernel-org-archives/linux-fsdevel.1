Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7453B27F9
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491891; cv=none; b=hcdMkVnu5f+2yq/HClzgIPkqNKHdr36gL3brIQ7m3EVzpUdCYn5+sFDVXejfsj90ivxKim4V4ORbTxleIlP7ZTqtc0CG9t6Y1kKpYYeYNcPp49DUojVkWq2BLLkQXvol2Lz0WzJHcU0GHMIECrLGmnSoqwDVG+V/zC8kweoli7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491891; c=relaxed/simple;
	bh=AIU6NGTW/RpZfTt6y2cuypcAmkoFDaCDqNNZTCJi0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxSNw9dx7k+NrW5r/p8EYarm+82yUx2hEhZMX/ZMBuFICVnY/FCIb50XO6qg3uOtWAx0Z3/xhiP5bR21hv+Y52PiSGgzSI5+JSB24SQjkfTHrVJtAOZoK3oIlpde4nRDBqqAgVHhcFWYAFUMFuUDEL1eQYnEGseFpKrBwD2KYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XXnf1qrk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XXnf1qrk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5303932c4f3so3554591cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788491887; x=1789096687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=XXnf1qrkElo3aCzA7QExaOWSdNxP/unmoxpQ7Nl14LSqP+OXLeyp+7TwEx+/0vPFXS
         mbXWBII3WXz82rpc/mRXs5oQAafMXv/lR9i6NSNTO7vI6fbUQ9Lm/H+/70dUKyPYID/D
         rINud0bXIB6JWQRfob5+wo6/7GzlrBSpoLZZyO4V6Mq1y4oT1jQb28+99bKN5jmlVfq7
         XLGDbXv6L3DciY+gWrXNu3RIZDTtpgb+GehzhnXRXGRkpYwMGg9GSc7zeFG53wLU+gCx
         flGxyi214iKlFdnetOf0+RVR7gjNDakGPu1348MlAGrbuEUQ+hjaFC/oLLirlUZ3Lv2L
         lQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491887; x=1789096687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=ZX34NEtD/j5CG45EE0MxjSe0LIWwO062SAOqn5DaYTDzDvjXyrMk2yA32cSRdaxt4E
         6eog5Ru/XyU47Y0nqAN0Hk7ZD+2zEp+Cw8SGQhmvymPb7KZBZ3oru2Za/s9LyHXkmbXl
         Y3jNy4/FivZsEVlrkyUk0XX6GanQXJ8vafAYC4meRuftuReuIRSnMlb4uTo9bc6HM8eY
         FKHK3M/is9O2j2hT95hrJXg+SD58OpYulqM04I0bY0See2bSj+hE5qttHbGE3WoYYnWl
         FlbitGawxw09PS6p+WN17dyvSDY3hZpO975bt1DdiDc/FEN0EW5X1bBdY+CPuLYttakH
         eF4g==
X-Forwarded-Encrypted: i=1; AKwUvBwZ0tw7LEMR32eAaKAjQqfwKDCwtqJCVFAL2eT6seQrda1Bn903DL2EGoKASO3ZEUNHWjdbZqndBQGeowMs@vger.kernel.org
X-Gm-Message-State: AFuF++lyhg14VzUQHNo+4hMmRuq1kHV6H5kRpWPa80FC/TMyPIZPbFIt
	tnfqSyg5xnJ3jx18WzKCLPA+SANN52vOHYVe1uVmZZkq2NrE5DljGNy9DjjjH75VENU=
X-Gm-Gg: AYBFou1hvTekIShvzd0ITbJRD7AP2watpJ7/LW42thkXLzRenG8QDdZ6vtF8nNwP/X7
	CpcpHA42Qc4ayMa46bHNhZswHwLOMG6zSniY5ju1B0u1r2+gTaJsCoJaeZUZS7rT6K3GNoil8TC
	NG1GRhGJqc1repXy+tR7cmS6co/TTZCelCDV+OCYZXG9rIRVyexBshHB2p4BJt0fjcuTKCh6Qfw
	7uQGUKmAHtmtu6/SrcuN8sMzRMuj+Gd3Nt4/FlB7xBaDtK/667I64EYW+Ah2bNGGjnm/u8vvPzQ
	amNvRGPg+BFXd2zqId9BsMWpZDPJXPyuF1PoJCBMj6dBBkCmM9EBNAgi1areKtIVxN6/QedzpCU
	ZlexUK6oqADQfGbq8k+x3hWAru5i/K94vqNONWfZCBrPZmgK5078rsfud1sHSfmrNgG97cNtwrw
	bknTxoimLDUBEUoJJVW+apCDRwvq6Gh2IZn/fqm/ZWfPpIVCn0fdtdrV1PyKAURWjHAX86eSOQU
	SBFWroRQcROOldvNtub8oEWLyQwIRO3/2cpWm8hfALICjMvmSqPU8I=
X-Received: by 2002:a05:622a:1c18:b0:52d:4f43:d5b0 with SMTP id d75a77b69052e-530548bc5e0mr43078621cf.22.1788491887027;
        Thu, 03 Sep 2026 20:18:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a7b7sm11260161cf.3.2026.09.03.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 20:18:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 23:18:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Qiqi Li <liqiqi23@huawei.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
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
Subject: Re: [PATCH v5 25/36] mm/memory_hotplug: support N_MEMORY_PRIVATE
 node hotplug
Message-ID: <apo3bZab6qtCosQM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-26-gourry@gourry.net>
 <6840c720-8cb7-46bb-a652-040c130a4427@huawei.com>
 <aoJaaYp30LnKLj1w@gourry-fedora-PF4VCD3F>
 <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>

On Fri, Sep 04, 2026 at 09:05:39AM +0800, Qiqi Li wrote:
> On 8/17/2026 8:49 AM, Gregory Price wrote:
> > It would need to be reserved, and you could use numa emulation but
> > that's clunky.  I have an RFC for exactly this issue - though i haven't
> > pushed it further yet.
> > 
> > https://lore.kernel.org/all/20260610014517.253609-1-gourry@gourry.net/
> 
> Hi Gregory,
> 
> Sorry for the late reply.
> 
> I took a look at the exclusive-node RFC. The approach looks useful for
> device-backed private memory without a firmware-described NUMA node.
> Thanks for the pointer.
> 
> We are currently looking into the private-node and CRAM design as a
> whole. I noticed that CRAM was not included with the v5 series, and saw
> that others were also interested in a v5 version.
> 
> If you already have a CRAM branch or patches based on v5, even if they
> are still work in progress, would you mind sharing them? It would be
> very helpful for us to continue testing the overall design.
>

I dropped it off because it was starting to become unwieldly, but i am
continuing to maintain a branch on my github:

https://github.com/gourryinverse/linux/commits/scratch/gourry/cramtest/cram_72/

I have not posted a new version in some time and it has been reworked
significantly in the past few months - but I plan to talk about this
particular branch and the tests I've run with it at the device memory
LPC micro-conference.

I validated this branch against most in-tree (relevant) filesystems for
the page-cache extension, but I imagine the anon-only version subset is
the more immediately interesting for upstream development.

I may include the anon-only version in v6, but I've been a bit busy
shoring up the base private memory node core and implementing kernel
selftests and LTP tests to ensure there's no userland api regressions.

I hope to get something out later this month.

~Gregory
