Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24B430CDE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441567; cv=none; b=ktNnXrFyBk2mGUMX0UfMC0I/+KUdSbzsOJx0L6I6m8SkOVSpVb+zx4ntvlqbbuWXwO8bG/MSc1owXzEl7pdcflxt9TMJjJLlZCsviN0R7njyRhGCwC+8cxA282/LxhsX4GLJUfhbi0IS/6ho78/kvGIYYM10XIo386xtct+rkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441567; c=relaxed/simple;
	bh=lrYSArpP0iVuUgDVG3d1222jafWM2daRLlBprnwN79M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJL6dXjBt9TToBUld3SLwL2v7wXP4WeQjuK303F649YmZeKLdLWxv2SfEFWdb1eyEVHWlKVixtMdB0tG1KOmnKp73b1J64IcqfyhWakRgIuFHsMCf+So1OPJAc6VS8GDTQfuYHtSoWln0wGzsN2MbEuObY2fpKyp37x3SBixOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VSYseg+e; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VSYseg+e"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so33290266d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441564; x=1784046364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=VSYseg+exNpfuLKbFDvFmj+FXgMynIyaIJLTmqKE5xqjn4RWfOb4YgC9WUBqaHGIou
         r0dE4B3Y0O2oC3ByyeA1No08p9fHPItCEXg7wn4B2ke+O/DTBtdwANvowyfAejANR7yG
         L/jMUvsK1S0TdEcwUbGCsUiYh0RCVKsFCrEVatCGj6+cv+GvddNIuRa2S05KYdqn1/fb
         Gq8/W4c5zgHkm5jy7FH6iwnVjsl7/l4bphOIL12amaPZEhRct0ugJV7Tm/CESAC+TkJo
         Tra++G1pnsToJV+fPMk8aqsSKixNZz1TiK86GTer9SCvTKiK3hii9NDa6lTPfNFKPCJq
         nMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441564; x=1784046364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=Czy0hON9xjiDic0YNv3U+3nAeHtiZr+bZ2xuZx7FbxnD27ai7Lvdp/5WDNUNoZWeae
         ay0qYPCmh1D6kmZrCu3FUbN2johXfBkFhVE+yPVIUhACnhKr7Ny2FoHG4mHKX+2uX1dq
         7bgq7oVdLXyYzwDzy0qGZs42/70Cm+rndoHxrqIPTTnwPvcRU42R2BsvgnoXqimSs02c
         YczSoT4B7rgYj+qY9w4c/siCWcf/7A6ogw84poMiIdw5hyLRfQvInwQq/44hZOuDYHRf
         YW186LajmL+pJTbmu2+Asztd/whwfEgr1273oUhGme02mUB5raqBCrRIqJCfcA8t/HU6
         W6sA==
X-Forwarded-Encrypted: i=1; AHgh+RqwpB+CDf2DAB4LyTHsSk0mV+ZM+BaW/qR1PUgMcXXtEGwaUlHAFDAcKjZViBKqAgbGdcqNk5v3fgq0ZtEn@vger.kernel.org
X-Gm-Message-State: AOJu0YywveZg/JHZxjNqeGACRxnhjKhy30iMssS54lXESDlZzPIuWdpG
	SmISPBFEld15rWjiHVWFB6YlZBR7SAen0KgEn4E3kMNMsyRrt4c+qsPvWtgVoLDFbTM=
X-Gm-Gg: AfdE7clmnbQ6lfZ1h4idnPLU4v1OqQiNLq67od8/qGm9KP0FzaH5u0sJLWuk750bE8a
	LAj5rVaI6hjPzlX6jz4Apn6SwVKR2XBIL3E98UIo5wyMxOuhjtJBRiobo37/T1jy7znf2YxjMrr
	pynauuCXp7C2RChZKFnTXUMknCrkr3L9rtoG+KzIX0fV8Zx17fBxzb9friRNgaH/78mcmK9tIrU
	ClmvXMNSfucySFFg9tGrxFMzXlxPw9uRWMtmnNikuF4fKZhOYqjpTX7wDJRc63gD2tsy7N9Xa5M
	MqSMG0Lzi0MXsXQQnyQDwvlRo17rUGhW7SAYEhCT6l15A4SWn3112gwrIwXfF6tJ3hevzxKwk6a
	u6WCf+NnjD27kTfzyi70hLOjwKVbZ5lq9ZL//3yHNWs0lox4i6kcNOqICdyet+QhQalViPltuX8
	ZHXugkqjhv6KTrbmwwfidT01nOOeV44Ilrz7zHxz/LWROog4mcN4f8ozFYA0C6spKjFzD41zUrU
	IQwYCs=
X-Received: by 2002:a05:6214:6011:b0:8fd:6de3:bbaa with SMTP id 6a1803df08f44-8fd6de3be6emr28372996d6.64.1783441563961;
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f306123sm181382626d6.20.2026.07.07.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:25:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 11/30] mm/vma: introduce and use vmg_pages(), vmg_[start,
 end]_pgoff()
Message-ID: <ak0olp9zA6ERCXtO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:22PM +0100, Lorenzo Stoakes wrote:
> In the VMA logic we often need to determine the number of pages in the
> specified merge range, as well as the start and end page offsets of that
> range.
> 
> Introduce and use helpers for these purposes.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
