Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647452DC765
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696154; cv=none; b=GEhB8qkizvzyghET7bkshWan23oAigzIu8IN+w2t/QeFShgTzO34DiDArz7po64RwVsKtXSyBYOuzI/RO9lUrliHxX9kLMHgr4g4OxT5m1TVV0zeE7hoC6TX7ocII+CZSDJE8WWEbcmIeW4YKKEtgPkqq4Hvxn72K3ahlFKRM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696154; c=relaxed/simple;
	bh=EYnEp1we9gIclXQGcrALFhmvzaRn2auF8TgNETsfUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUCUyC1tIaiQbuB2MLef5FCGJ/K5iG54+1PSVQpnADDz8jFI39YBtIt0dv0+gqfGH8eGYOn30DdyT7cd9/z7tX8HIgk96enzbgzVBY/ZGy3XkOkHDFOHHl5TfxaRg2/hDHXcc8ncxXSPrPnCQiyTe0Of0jMZsP8td/7ggWFmPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=epDIsSux; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="epDIsSux"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e54f8c051so49299085a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783696148; x=1784300948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=epDIsSux+DHr+R7+57IO63qplyq/xvKvyvsaSnGocrnSVyB35pBz9FidDdZuFiqUU2
         DEI7utoVBOJd+hL2ZkNUbyTbx0Y08lPoRNUQRQXYseSYf0HdXLcShSbznwu1JXATey+M
         Bfk6ZHvdiTBAFpvVxcbsiTVK8ykyQWYr0zJzGUXLadwAyHssLBd8x6Jgo4u8W9tN5Z29
         wZIU9h14ifKZhs1PuK4WQDrSK0h/xCBwcAKQTquQdjn/ua+BQ95nOwYBKbmQUv4a91i5
         CGGuHWdgt++oNXzXs7BjBuahelgwoIdMTKYwabA9Lt3yQQk3+oU99uqBMe2SlqdHUwLf
         9Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696148; x=1784300948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=aIPp+xoabwbYnRWuJmjvlCI3ZTq9vKEphx+GrPupiDN3qdDuJ78Wok9IZOwzAiWk0e
         0UefRDzaSRzZSHO+cDlxBmBN2hf2/ZeVhinjOUbkDZORbX/jdicc3AFzKLdfHxO+bkIM
         D84o+N95qVHqk/3PEJLW2zBpiAjz8o2LhKwE7Fppbgo88t07Z72JOha0sBzXBlBhGvTz
         v+NAcP60AuHmoZYz3v1iGEDmKmduBaGKGdoEGv6H2QTNOZHJQyBkfX+u6GreOtWgxuSK
         u3BETp6eIsCTIgsHBhqAEkfD9LLEuFCglNMnX4GI8njy1dTluUBo7Hh8j6sfvJ/RUM8L
         3yXg==
X-Forwarded-Encrypted: i=1; AHgh+RoeTvzlIW0BGg0pGOUoivMcLbbXZyyUwvQmRebBw08ajr10XZSrBf+dqwcFVEZ3wi1TI0jFojNEHsDSVBzs@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUF3ReIPj+/IDGlzLQzWYH/+1gaKvYAz3z/HmPow+F3x/1Y8D
	n0SNwJUpvCs9MFAt08yvtNKfTfSnWLvs/0Pe0dMl8BUYxn/tVINWvc22oI7aC2Rk2qk=
X-Gm-Gg: AfdE7cmpzR926n68oVCTdLpAf39kI2Cz/zwzlo5UqgLB0vZtEPGrhlVFVM0HtSIj5MR
	W/zhKhnfO6QybqMZrdDq2nsr98ewS41fbpqJga24OCs7QglcIx736xju0Zke80txYkV1pf6Nz3i
	f4BJNyRNdljgWzAji8eUY3vbCCLnhoo3v7RIJmFm1fWIJ+071Uzu/P4FjRbFjb3/OxK3CnNmleg
	dTylEKE49RIi6k3ldLum2HK79vyGvWFb2ogWeV6PaW62WptJ+v9J3N1pFWiRKhMhxQ1R45mJoJz
	GRcdSWR7STgkg8cSRi5HRa4nrtyeWrYPT8o8dOm91Iz4uy5Z19IiKHvtbslgpZcJIbN5IyVKE5C
	UVCl4pswp9wCswICAqXTOM5A8KGvGw/LHCAtAkVWUl6NYQ0EoLA8anpEc9BAN+KeEUWbF8mgl/G
	1MvydZu68xeDw2xvuqJsghLBhOJL9EmXex5uDZ7pPO6sgdGUqIDMwLR/wbA0+jKTG+20E0
X-Received: by 2002:a05:620a:4414:b0:92e:7d53:8e8d with SMTP id af79cd13be357-92ecf55964cmr1359477885a.27.1783696148308;
        Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d34f76sm213283985a.35.2026.07.10.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:09:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <alELDgm258nhjk3b@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan>
 <akZGqclqQ6gS12Vv@lucifer>
 <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
 <alEHy1raICek7imv@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEHy1raICek7imv@lucifer>

On Fri, Jul 10, 2026 at 03:56:33PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 11:49:18AM -0400, Gregory Price wrote:
> >
> > Silly question:
> 
> There's no such thing :)
>

All my questions are silly.  That's my secret :]

> >
> >    What's the purpose of retaining tags in a non-address value?
> 
> Well if you want to reconstitute an address from it later then that'd be the
> intent, but I'm being hand wavey here for sure.
> 
> Main thing is to retain stuff under the page mask
> 

Right, which ... 

vvvvvv
> > That sounds like there's fragility just waiting to be broken.

If that's an actual issue, then our relationship with tags is painful :[

~Gregory
