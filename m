Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2164;
	Mon, 13 Jul 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941106; cv=none; b=OHH6RadnZtBMfnmF4nklSN03GC8rNjdUgb80Vza7hEWtJAfwEtpU99rxuRCaoWMgIylXN8L2UOLkgT6pP+82oQc7Pv/u8pl7OrwL4VSH27oF22lDMh8JVxDRCYZtDj2T3n0mIiDnpS2mDot5r+mIOfUkhEEriPvXRtVNN9beip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941106; c=relaxed/simple;
	bh=2uY/bifyVIWG6RzypKO8iNlG5iP6R6rPqAUQC+Ip1YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRPRGP0M4+yH6FyeTBXLbpby1uxG9Xu8grd5BTLVc3oVVUYY6DylM+suf+rRu7Rl/+B3D+CGzKb34y3Obkxx4CbujR+HcB+JjJozFyEKL8VR8rnZOWVolN2cOFisthZ/JOFQ5FUDqIQIVvsdW5rCy2x/sOyAH7k2v/RCjppsrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uirGvzJa; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uirGvzJa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783941094; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=W+vXYTjP4H8eRjjP/emOufHi0JWx5TVft1dc44xReZw=;
	b=uirGvzJayhPLcHRXlYccCU6wzrqEY6h6h+rLCUJd1hTM+mzQCbaMsao09DqEHf6D4PzEcyNl+8hG9e0K4oOR5x1LpRVYjzj/o0gA6cm+N04wkWzJXbT7XstDvo+40y3QlR7/aPq+iSUdBUAOc5VIjntbXVynKNadnDpQrPi3haU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X6ygMa9_1783941063;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X6ygMa9_1783941063 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 19:11:32 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-team@meta.com,
  willy@infradead.org,  jack@suse.cz,  akpm@linux-foundation.org,
  david@kernel.org,  ziy@nvidia.com,  matthew.brost@intel.com,
  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,  byungchul@sk.com,
  apopple@nvidia.com,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/2] mm: don't apply task mempolicy to unmovable kernel
 allocations
In-Reply-To: <ak_bIlYWJsEWx1P1@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Thu, 9 Jul 2026 13:32:18 -0400")
References: <20260701222112.2820098-1-gourry@gourry.net>
	<87echco1w6.fsf@DESKTOP-5N7EMDA>
	<ak_bIlYWJsEWx1P1@gourry-fedora-PF4VCD3F>
Date: Mon, 13 Jul 2026 19:11:02 +0800
Message-ID: <874ii36t6h.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Thu, Jul 09, 2026 at 07:09:29PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > The unmovable unaccounted kernel allocations stop following the
>> > task policy and place node-local. With no policy set, both place
>> > node-local as before.
>> 
>> Personally, I think this should be the right thing to do theoretically.
>> However, you may need to find some practical issues that this resolves.
>> 
>
> I don't entirely disagree, but there is at least one scenario where this
> is an obvious improvement:
>
>   BIOS-configured CXL memory brought up in ZONE_NORMAL. 

Per my understanding, kernel configured CXL memory can be in ZONE_NORMAL
and BIOS-configured one can be in ZONE_MOVABLE.  Right?

> An task interleave policy on such a system will end up with unaccounted
> kernel allocations landing on the remote node, which is just not
> preferable at all (and uncorrectable).

Anyway, some number will be good IMHO.

> It's not a complete fix (fallbacks can still occur under pressure), but
> it's one piece of the puzzle.
>
> Forward looking:  This patch makes private-node's with ZONE_NORMAL
> reliably hot-un-pluggable.  But that improvement is obviously predicated
> on work that isn't upstream (yet :] ).
>
> I need to send a v2 of this with SLAB_ACCOUNT fixed up, and some numbers
> to justify dropping the pagecache fix.  But I will probably sandbag this
> a bit until i finally send out v5 of private nodes.

---
Best Regards,
Huang, Ying
