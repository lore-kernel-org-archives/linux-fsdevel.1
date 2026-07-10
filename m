Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D63B4EA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718276; cv=none; b=ehULRdz080nWciHgd5T/u8UapGvlmQII+dQyOV8tmURMBSEY3VCfV3MFcjvPdPH3q2kmRytDdX1WrRcNfYVxnWRPNttdRo91BOT7l7VBMs6Po48vL3oHco0aeMwSMs/HUEySB/Ws3THKaM4Nw+Lz6c9+0obkbv70w8MYatjPSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718276; c=relaxed/simple;
	bh=SIhLOUaxsH6uNqg5w5fr4DNuZv6zf1h5UML6naETP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwt4qT2Ek8RHHgsfs+c2L+rEObT5W3Qhwzgt7DWLZJJwuj480SyRDlLmQshh9+azWDj0f/Crux7tENETh54OcxLewF97Q/orlZVyyruQGw8REAUF5JZPLLpK4NbgYlE2XMBsRfAl+1tnKe2GRWseGkQDfXgyaKLN0xt7z8lNXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CvN7OG/F; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CvN7OG/F"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e855da580so110946485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718273; x=1784323073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=CvN7OG/FV2U8owqDLkbFEu+JlFbw/jALBKLEqg00J9vBKiOJUwOO5Ox3CRbB6cjfje
         X4+aFu9El3LP9J3RZYm+1QSfPZ4g6pgmkAADgA3EDw8if/ltT86NG/j8JgMNPEapVWgy
         wSI0adUBkeZkA/pKwkllA+vz3PZ5UcvrJJ6VepRHvHpnXSrp9bRktgH4lVCItKHzV2CX
         WMjyrUyLBcuMQNcQN1gura1zBKey/qRJ5XunEXS+7ByArzrbUtMpXucxyLXWVHaWrnUw
         yvD530b4It7Z5igK2KJSTuxrpCne+mLWa6R5U7fjZP5kNWq8ptfMcMf20GocA1+26rFn
         IfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718273; x=1784323073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=iKD0PRT3wl2bDqzrKQinTfpVH5lXsbknhw2rrU4alcgMCu8a8pS6jROoJ0cO7i86X+
         11gNCgJrg9LzNJBjwmomUe+a6pCgf49NvQ1o6AplvwDo6oWYay2dl+LuVklnI8uzhExA
         0vrpnvnq/0t4QQCJfhE0xMtXQBcW+c1nD87rvMYHsib3WHwWRIuGVdaDSsCrZsDU6Mdy
         8GiuQmcjCjt3zZhNn9GtrqhxOCfwkvKa4TiCdbSdb4K42CWcUhXfAbqrWTr42Q6qI0pp
         b1OoxnnQkEaMkcbjhvob1m20sGWFLYWdqEVPin/P86qBO3TRX/2zTUEfsMwdaEvjhf1f
         nx0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpjr1W8w0TfOESyj2pahH255pluuhzxE2616JBTHVTOQlqzqUBPe76ALsdI+vmHaTvEB8otwxVUuWtoy+a8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwydj22yxUNf4+1KQ0H8TU8vtl0htYB3R2c5Ez2nxfmHkW77MW
	iNc/4RlQZ7G+WlkZtkRHGrrqp5++KOUOL8LrTPICk/zGcOuoY0Zp2H5sQMHUeyT0rN8=
X-Gm-Gg: AfdE7ckSqyVQ63pZHtqeed8H/ONw8xFE40SfXc2wsUanYfkLt3vmj+vkD0WGM01RcBb
	HxcP400oAnuKdpgaB9w86B40s/EnGuSgYq6Jq2vXGARpo6yBzxNIq4zHUUFL0fHx0e1AkH0jwRi
	sliZxkMsmLdBkDM9T+HwaaRTDVU33lrau4Kwnyo68KnTRKHOkfZto0Hs6thmPqWDNnKalUpDCzE
	tB+naOKt0Oz7IRA1unyVbm9jxfEyID7EzEOsoCks4y72JtXrroAkmu//PnuEg5TMDHQrNS1WO0E
	le7b1hgpUw1fQ36DiNSvHf11U5xghBigTfDGUilCUzFv757IywaR/3vUMcj3uUXcpcxnZQn8DjL
	CwM5HwOEIS95cS2oZV+LR3mHOKjz94u8baR+AhQFLW/I7SFW1YKJuq7NV/Trja1veXkrViqqry7
	abSF8JVsQ6gT2NtJ7sjc0UTeZxuNBUcG4sJEXVE8E/UY+e2WwAGKL+AnBqF0LUFc8CB25RI41Sx
	wldghg=
X-Received: by 2002:a05:620a:40d3:b0:92e:7afc:93ed with SMTP id af79cd13be357-92ef2d03c09mr108964985a.71.1783718273295;
        Fri, 10 Jul 2026 14:17:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm292932185a.2.2026.07.10.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:17:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:17:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 23/33] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFheaAGWCIAjom-@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:04PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carrying over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
