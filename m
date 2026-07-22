Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CED34BA42
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728140; cv=none; b=KXZGNPpKPKGC5AYc6Ixrm2yMxsSWZjhsU93mmYF9ApPGdDnmX3BzO83iTUcyVNGqoGEUJOY3pQdcT9benwfNQ1ZGhy9WKGdmKzq8nVsDRl1ShFU06mIT6c0tlInW5A213xVOzCDbk/8PWMjeUwxlp451Gn6tGikRhYvWMYxHj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728140; c=relaxed/simple;
	bh=JAIqzpQM3gUx7M+gDSziic1KcB43W58VAXiVvJF0/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8WhNMcrrXhxMnHNi7OoZD+2QanmRLHgbQ4E/qoU3ZjI5BxA6WnPKF9SACXANb7dwXNjZlaIHtTl6NLnma6DMm3kp/YqlYrxRmTOBb3YP2161Jf6ycx7RyKKFdwaRnQ/9e8vVhNN5bk5bjaBbw5vK0QmFH46G8+tiJsz8c3o9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GfLa6fHj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GfLa6fHj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c08df8513so63176531cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784728136; x=1785332936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=GfLa6fHjBw5k5Cgmz1whJ5nETVeelFxMT26tNktv/o76lhNb8g352TR5NSgzxj0xK/
         l99ZU3otNIqIWf5NPRZOUByX/rsuPiQ11f/76fJZU6VdndYf/hECk1QXXGmtm6zxg/D+
         Jp3L7vWik0zmayA89l50HzOSWyCZrphTG1lt1EZnBbJQbWY5rLr8WS00j1qAY7moV6C6
         lTJ7XSZYNDD8dlO/MPxVy2EEZD8SCjSLPMCaZCsQD7e37hasV8TP4a+NhorAAbZ0Ohhs
         6nlqtYbIICyZZQkN6OqTZwVx6r17L7v2FbkjPkZ0Eqhsumnot7b9+N7Dj0SpPbVDkztD
         g8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728136; x=1785332936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=bVP4HtnDnIE67wbpGmdL1QuJKzYTa6qN6Y6qdy1LCyyAlGvvF40vmeyoJyE7BTYxQh
         7hpwRhyy70Oj3TyK0IcYATGb2ONsahY21gtXs25c7hCNxQj26BJJ8iWTJzFjc5axKf0U
         k+15yjyM0QlRQc6gHu8wvyfxJ5sgfm6/C9jXh6oZCChfMRjO48nUBzmQkFcnF9B19leG
         njhWe819CxfVfE2Ql8uNO2/h229eG04h9Y1cLVc4WkikQqIxCc4gqffipFamLJuQ4NP3
         J8S/WamIew1dZPwl2Psv3sjV3Lh923zSSUcA6SFBdHZqy3NjtZcTm7naCZBQEhuurbEY
         nT0w==
X-Forwarded-Encrypted: i=1; AHgh+RqGCjgHfxzFHARfKR5I45ZZmQCjAL6bCD/1T2Z+39sovnXiw5o7Jf/cIT3GcTI6lQGScCyAW7BdKZnJcsfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5uqcu6E3NVsW4ZPerSr4++zgAeSv0TPZdBtaqz4a4d0d2V1H
	MY6Sx8vBYKYXp40MqdCjmKBuCKyBk0xaUEf45krr+krJL/oFii4hpEehuQTqcMY17pA=
X-Gm-Gg: AR+sD10flBsuwdqmemz62RqB/qi8TzjvIoijaJClH507ui6+KDXDaEC7AxEJ4i8KLgS
	OsaCOmy+w+4POJWuUxp/nuLDjG/PFh3urwVrZgpM3UPeUdGvtVf1cZnVTpWF6Wwm4mF/b+ymOOG
	xJDUMXyDVoGU2vw9AqdGMEfnKKBV7VNhajpzMyUzcdPUMO308Dznn/UCdAU3WeaW+RiGBveP4CD
	EBYslJWAVciDTNaPL8Dy9FVX+MiXsc5Q72R0fv9xd4rFHduSQiUc+pEP9xD5xbb4fATRWDZEGRy
	xE3N95RpYXkTkfJNEOXRcnSs3SGTVCV0cyIWhqGCeFM7uX3Kdch7VKkjbe56rLO5eibX+1vUhJM
	GvmQlK1qwGhLTGxqmwqyvgIh9PkJTiwtPLx84Nl9GxS4w1VvEkqVoaXyfpKMg7XRQzKhQi6B5gU
	eVtOw1Zi5oOQwYlohnXHvON/4X22v2QFjN1k32NTMLNq4AQ4nOUmhF118bGA==
X-Received: by 2002:a05:622a:350:b0:51c:555:7dea with SMTP id d75a77b69052e-5213cbd667cmr215415981cf.30.1784728136109;
        Wed, 22 Jul 2026 06:48:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8e2581sm21393266d6.19.2026.07.22.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:48:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:48:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
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
Subject: Re: [PATCH v5 26/36] mm: add NODE_PRIVATE_CAP_RECLAIM for opted-in
 private node reclaim
Message-ID: <amDJEbu3aQO8J8f4@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-27-gourry@gourry.net>
 <amDGXU94trqlXUgR@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDGXU94trqlXUgR@MWDK4CY14F>

On Wed, Jul 22, 2026 at 09:36:14PM +0800, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 03:34:20PM +0800, Gregory Price wrote:
> > +static struct zonelist *memcg_reclaim_zonelist(int nid, gfp_t gfp_mask)
> > +{
> > +	unsigned int aflags = ALLOC_DEFAULT;
> > +
> > +	if (unlikely(!nodes_empty(node_states[N_MEMORY_PRIVATE])))
> > +		aflags = ALLOC_ZONELIST_PRIVATE;
> > +
> > +	return select_zonelist(nid, gfp_mask, aflags);
> > +}
> 
> 
> I applied this code change and notice in mem_cgroup_shrink_node(), it calls
> shrink_lruvec() directly and never passes through shrink_node().
> 
> This patch makes private nodes reachable through memcg reclaim zonelist, but
> what prevents the direct per-node memcg path from reclaiming a private node
> that has not set NODE_PRIVATE_CAP_RECLAIM ?
> 

I legitimately missed this.

Sashiko also picked it up on the filter patch:
https://sashiko.dev/#/message/20260721183528.B4B9C1F00A3A%40smtp.kernel.org

If nothing else - implementing this feature has taught me some
sub-components of mm/ have very well centralized logic, and others (like
vmscan.c) have 3 or 4 different paths in with a lot of strange quirks
carved out.

I think some of the vmscan paths can be improved to simplify this
interaction, but i will fix this particular miss in v6 and come back
around to see whether we can clean up these different paths as a general
improvement.

~Gregory
