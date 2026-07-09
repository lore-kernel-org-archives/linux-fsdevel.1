Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90A367290
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610455; cv=none; b=W/3sDKqqyYtL+6VauShLuuwzbQVIR5DFF7lP3rkDjTVVmQYG5K/IZ2aNADEnxVtXHLbmH2g8DDNsCczX7CN/iY+cX7d+c74UoF8LW/aLa8wvrxRhEYhipTMG8o5gAc2cLPZaGJSo6K00RHvIHt8OAl+ASCcKAVyvkdpZ+Z4dgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610455; c=relaxed/simple;
	bh=bI1J+cBiMa2SCkpHmKrJG+azHdWZ7mPEOFo5aU/4c1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpZflH4UuqgbxRsCqStEjWw9ZPCjHjR+5kLHa2EPRP+np4RHScJSys4LcczxCvhQASiJW0X5NMfSWD4Ctf+L4r1rrVs5yL15q2H3e+CN2TTIWzaqCujBJ0x/oUmN4cMZMu9KprZfFeTl2SeEh+8faommwUBUp3FIyF/6l6gX+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RcHNg+Ts; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RcHNg+Ts"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e65e18969so79762185a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610452; x=1784215252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=RcHNg+TswvftK0rg4pdx5hqB/98t8hg3+kCvMaP3Wvj32IUEgQZ9DN6uIqXYkrZSWA
         1Eu5dZ6dcjNig8HJNvE+HrO3uN3YkcDCXU37P3fJdj3k9VCdvMTFR7yu9VDftTB5iRqA
         K8SDg1lchFzNdcbcs3f9FNQDV5/hxAjH8ASDXRrDVmRioSlH/e6Cr/Z6a8I4QbteOIIC
         HvDkHSwlINZylnxe4+hrpcd6PFlecb7POo21Ozhg6IB09pfT0HXX7rLljq1wRn9Pbbcd
         1U2ZSUGtyb2krIIqADL9WnNTQZIShhSl1bsfu2qXF5pL0rNCLyyOu7Cy0nkMjbppGyxx
         /9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610452; x=1784215252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=WYfjK7Tw1l6ZWj4SiMQ9eHpjjxAs3J59FHLBxLeQqiK+0lalq2Dv5J9F8bXhQmuEe3
         eTpBIOU5hoRTR17uNBZ2RD8LzV8fOnytsB/zyewqR9E4GpglXN+nmYZzj8mHlHlqTFGF
         8IKTgiNTdqD3sGd9RwZkOhnUzEuQOjliAtoKa1uW0LmAPUoUAIVDbwOJwo2qP2j5B7cs
         AWV0LZRzL1pDCHdYgQlx3jqLZGsDIlb0yx/pyQxB1Vs7L3HbAd59gSzQ+WHZ8NMcZo0u
         g7fjXLlmXNz4q72t0gbdc6NrfRUym/sFtg6rJQx+XnPCmeFx6EQEZIa7lSWbVDZoVuux
         /jRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5M7AcuePSUJpu7GWXBjzPl1sJQPl5Rn4EOI9xWRKQ78pj3PBmcB2Hot6gwVg4FP009u4xyOSzbY5ymggj@vger.kernel.org
X-Gm-Message-State: AOJu0YyqdAsAOhN4bb5DZIJzOtzLy3AY5Jl9x0uMJtY2y+Wdukhbb3tp
	1Flt3UfnC6fISamOinC/+BKivooh/5pv83/LMP1BNZ7z18iU9xtqljH2pUwF4+J4L1E=
X-Gm-Gg: AfdE7clpduYw4pq5H6+eXV6ZcyKwGupKbX5VHqPzVKRMD2fv/Mn9TTcDlDvEYHQg8Yh
	ocNINIpTQw6cxi9DnEd+4fv1cw8vSSOI9bk+0H1OY1yvtxLdh+CAFoKNSMpumX4tpquLT3CQCD7
	+h6v0bqL6eAoxGgmVX4SrvQElilFQKVal9pk9Yd+5oPN7ejRf9+W7JWDpGhrp9iQ2FwdyU8tPhw
	qRm41bhk+iMMPKOuY4kOfD4civ2e6dNEGVwo/2hbzpBYHgIz2vENR3Gxv7igt9I9/OW0EWBnqnE
	Tl6HRRkDMwWp7FvCTMIBN8LuM/MbLrks8Di6rul46/XXva1biBG86M9PQNLwT5mBc5ZOcaoAjth
	cc1vt9fSXy7aZ2eIYHAh/ySVbjJtcvxsqif1Ol5QzToCy4NpfBctwQWQjd9XouCceKGZXsWlZeb
	hOtLl4h//03KCEf7MjKi2TDAipXrFJk2DdLF/FYKkQN3EYzRC23B1u7qIts4RJ6P/zjCfb
X-Received: by 2002:a05:620a:179e:b0:92a:f74f:904 with SMTP id af79cd13be357-92edab23ef2mr337298385a.1.1783610451142;
        Thu, 09 Jul 2026 08:20:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca90a5sm1652288685a.32.2026.07.09.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:20:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:20:44 -0400
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
Subject: Re: [PATCH 14/30] mm/vma: minor cleanup of expand_[upwards,
 downwards]()
Message-ID: <ak-8TKDC1GBOeMOM@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:25PM +0100, Lorenzo Stoakes wrote:
> Adjust the stack expansion functions expand_upwards() and
> expand_downwards() such that they are expressed in terms of named constant
> values, and make use of vma_start_pgoff().
> 
> This clearly documents that we are referencing the page offset of the start
> of the VMA.
> 
> Additionally this cleans up the overflow check in expand_upwards().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

