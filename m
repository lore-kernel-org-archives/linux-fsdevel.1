Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EB1A3029
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786927770; cv=none; b=R8aGZRdO2Ww081kSJwXRmireL2h9LAVkk4RQy8j0DDx55C+XzX+oTM5S2FtFPX37ItRMfiqr0Z45ZF15cDkF0jcWlT5BjHJ+Nryxtyo4B+Rljwn+IgwbrrZPE/Ppr7XhvWEOuJjG+G3Hj84tqDIcTg67a0L6XJbFJ7Hzgp0OjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786927770; c=relaxed/simple;
	bh=Q2AJHfOQlhxmo4d6xkSdfftND9W8OwOWU4sIuscydGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0r/7J4YdWqgAIhT89XfDBAzzTK9M4mQi8++ntNZt+8vbY2pAETeFMB9Prt2+lN1bU1vZPFyiuH16J+IrtfgoLqfnPa26zv5IiimmQkaokD9S6pzAOX+h/Ur/ViWjij1gGhVfOvS5F93MCfOHGBwtJARk7eWBgcb2LH3s89+9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ckMtfNP/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ckMtfNP/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51a868b6962so29100211cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786927768; x=1787532568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FcQdr0dRPL3xWk5ZJ+WEqnlvhAK6C+Y9UAGkoGf2Ky8=;
        b=ckMtfNP/26mDYWEYvnUuKZj+OlJs4rtBqOCTkvgUC2mso3L1qBV4UevATxAcuXcr59
         t3iNEjatomJQrmfd0qmVsl3BjaW6RqJLwsIjj72/eWYrRlfTWeZnYquwPe7qoSJdQ3uw
         g88uZqv47V0VT2fcXb9InChXDCkM8CDWy83shOxcv+0xTEFY14jjWUHpeLQyJn/Eu1+C
         4ygQiiuxj/3pUiyIOY1sjivSzmhc0YEFbIZMcRYKoMzp9C0LbmrFDK4Fu4Uo2z3EnsYd
         hX7wjASGY+5NqmkbdDYqrOgM1h4IrDlgQi9GwqxPZvEyT20eWdaV+AZ8i2avJDfhnijE
         oOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786927768; x=1787532568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcQdr0dRPL3xWk5ZJ+WEqnlvhAK6C+Y9UAGkoGf2Ky8=;
        b=aoHbTohjoh28GaQ80DtnjQUxsShJv0YxpJAF48wtQMFKMILvv+voE5W1na8eWkV9PJ
         wxCd/MMt0qsPHx859EKlOgG2Zf0VeWpuVEkPFxilmwWS5DiMnS/IzdlvH6AYh2/j43eW
         WYVJScGvNeSEOOlFqyENSpqkEan82eKwbiYfMapYr3rLyyqMglKsSPr5d1s9RRwhHHNz
         7Brn5rgqKvneS38nZtOX5vJQjm+jzytfVlud73SkXv95oUBIopAQMVCmb5PUuYgl/0Kb
         42LQJANvtnUrmnZrgQgtHi7/V5hkhd20a9NQrbu3j6jEIxJOeVo7yG3LLe1nf3ioNIyc
         TXbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1deVybznlyFd+Cmh3EUE9HeM0GbGF1ORWykD9eLh29X2kB8xA2oDx6NTuRNGPFwaoRWQlM010F7DZN/yB@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoAeJq6TJrs4birAjjdQt+xc0FaZGOwN+ptvIEh1zf44lspdN
	WJK3TV/BGwvDpvIBAv5PghkUS6e33R24PMvA/AlaR6oUZUkn1A9Ibr+Wfzuh/sxTHDA=
X-Gm-Gg: AR+sD10KY89yOS8o9k0WFbuTxSrMtZyaHLm02Xn5qrNOlxiKbNqIHS38qiRJH+I0DLx
	NyglK7GVGVsW2cCnROv57Rr7M21apen4hIAptdriZlw0OQC1LZvKFZGU+DGEZFvIPP43c0JOF5a
	uFzmC+BwoXDU8CABpHiBoP5oNjYz96udqZxgQ3Y9rS9LVFi8qE+rSgOgLKya/v3zXMjYc64tLvQ
	Q/weN8KfR3fHGCaGqfYg7FqIqdY3Y172rB1KbLmLNfTdRNHfzJmI5cj+pdv+UQ4zS1tc1looJfc
	vpF8unREqU9ODyukF689u2afnPsqjxxr5fYGoJVNCg1YWlgPxSI/jhD4PK5/ktMxF9khqVNop6B
	vIsoZOxc6phZinbX+EaizyK16+izgzD8c6mkCFGTUoGzwZhEhttKgJuCt+EVBwsDmZVi8KusdjO
	QXddYw/3jvH0rCDxS5mHzCmiainXU8ptnduyhNjxpg2mxlcnc9Czutlr9X5UiAac1jtlaTbgb30
	7yibO+qLbdiZJhtqY6gWVVzmMMOfuaVCmcQ+ofJh7xD
X-Received: by 2002:a05:622a:2b4b:b0:52d:a151:10f5 with SMTP id d75a77b69052e-52da15111admr97787241cf.22.1786927767788;
        Sun, 16 Aug 2026 17:49:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db62764f2sm1152051cf.30.2026.08.16.17.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:49:27 -0700 (PDT)
Date: Sun, 16 Aug 2026 20:49:24 -0400
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
Message-ID: <aoJaaYp30LnKLj1w@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-26-gourry@gourry.net>
 <6840c720-8cb7-46bb-a652-040c130a4427@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6840c720-8cb7-46bb-a652-040c130a4427@huawei.com>

On Thu, Aug 06, 2026 at 11:30:08AM +0800, Qiqi Li wrote:
> Hi Gregory,
> 
> On 7/21/2026 3:34 AM, Gregory Price wrote:
> 
> > Add add_private_memory_driver_managed() to let modules hotplug
> > memory onto an N_MEMORY_PRIVATE node they control.
> 
> I am trying to understand how the nid passed to
> add_private_memory_driver_managed() is expected to be provisioned.
> 
> From what I can see, both node_private_register() and
> __add_memory_resource() require the nid to already be present in
> node_possible_map. My understanding is therefore that this patch
> supports hotplugging private memory onto an existing possible node,
> rather than creating a new possible node ID at runtime.
> 
> For example, in the use case I am looking at, the device's private
> node is not described by firmware. Would its nid need to be reserved
> during early NUMA initialization, or is there another mechanism that
> I may have missed?
> 

It would need to be reserved, and you could use numa emulation but
that's clunky.  I have an RFC for exactly this issue - though i haven't
pushed it further yet.

https://lore.kernel.org/all/20260610014517.253609-1-gourry@gourry.net/

> Also, could you please Cc me on future revisions of this series?
> I would appreciate it and would be happy to follow the work:)
> 
> Thanks,
> Qiqi
