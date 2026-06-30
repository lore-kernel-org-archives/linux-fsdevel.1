Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00E3976B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833462; cv=none; b=hP5tyV8iMYpj2NOufbNL+5IM4J3BRsLGt36IvyakZSmbxch0xifLd3grpxiSBlmxDiWxwGnl10wHFw6l5acCJSUShDrl5bFxMHX8WaqJo4bsxL6UW0MQ9LJSwhToW6TLUwhXhluvHo6hl/UCBycreU6VExCdYdabQ4En7tQMlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833462; c=relaxed/simple;
	bh=dsxaVzZxmHO2gtIU2TvsbwgiexrCHtWtBKWF+qAkz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufv+aV/6D+T6n3OaDSzmpteMN4guO2DkxdxuAhig5qfAmFGieOvWSc/ymuS/5MNO3mKbiblF5jvcmh4smjqzIHpdQK84db2VxRp0bNjtzGGsvGyHx7/RGgdiaBNOr+zZVh2m6+kFSGUdp+fab1yKz07iZBeijyUisDzGaco7FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=psJiMuwN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="psJiMuwN"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80e4455b9a3so25122917b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782833461; x=1783438261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=psJiMuwNe+wsnUKX7JHCC2bk1zBbH6TKDOkVBQ66qIshRB/HhIKhiSrjGwt1s7N7VC
         tOi5rem+fSHxGzpb3kuOMD6hh875dR7NBTCiw/2BXknMBRbL6KWT4294gx3TdIf059Of
         Z5vcIfRCC/NTqtq0kzExToplBIxc9T/yI2Jp2uAfbuoXNoElsI2IhIGC9Q+cJ7GkimQH
         Yol7MsahNFki7nOoT2pIRwagOA2RApVYKCCBC4kdPMvrlV5P0magpXSJr8EmEVmU6VaD
         JCn+0NFPnynd6/LJAzVsjJH33Y/ZCb5XU0qkOPyw5gvpPx66+U1NVRBwzQ8/RaSOVzrW
         R6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833461; x=1783438261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=fkZAJCu3oKK5Iw9SgdQ/5T3sNiVLBYirKvw2SGzsocSsjo3KSywN4hmJ9nWyB4knAj
         94rpocHn3ThqXH3jJTazibwWnxWGgRgAS5Qhj3YS2/LCbAQhv+K6AD251NCsgi7NxBTf
         tZLOw3MKuD26bZ6fAuCC+4FUdmCFqMjTRTgFYrrKq5fVzuT+znt8kD5AtO5XmXbnIAnE
         Wu7ZlwO/jcUS8o8CEuAXnLfYQxuVHv7zHf2xs+xVghF3eI5p/yM1praFxf2WMbqdhTWO
         5PAsDwq/BdVFPQuJ4FgWsbnM7Ixjq61nI0u7IbXn4e/7kLbzgjg2zhiozvEgn2cunF07
         6aqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEopDRUgNyT/TFc4B6VRmkpE8tLpVdKdLa2q2G0yK6N96G/PlMApC19jOw6BYVtMza0ED7/u/EXMGjt7qI@vger.kernel.org
X-Gm-Message-State: AOJu0YzCc3xw40zKo4JMa+zo+6Fzau0VyefrNOa6pJJNOELxLR+xas1r
	zAK7hMgDaSIWn/ozJAg5taQzm2+E5MFNeWFkcCEAW/aze+JrdZdprvCBMWskTDfThOA=
X-Gm-Gg: AfdE7clVyhEAzxa+kpZyEACZti+ZjTd/dRQP/tUwD5goYUeewt1vmrqrvlLvcBm+pkZ
	GblLPv3ZxRJ4WkBGbi+gCzFgod+z5/cgso0qPF8GEyLBtPMZkF8RV/fat1so51+vk5ngzDnjxM7
	uYMFazsmq23AN7FYL5CKldQvk6cH107aVS02tCXUk93xXG2bfZpPXUoCIpNear+l+CzVSrW0MDQ
	3vj1xwIuT3UdGvRklyi+eTrd3iv46Yd2ZFrEbRHelS/yEcB3rDfU4LBdtuSfLUGZULc3T/soAAi
	5PrALUxgDajcQc04/nguc7bWVQR0IbO6lLWeY/61yj04CCjJ6Lx/C1TcrhelkZvqEapXpB4PpuL
	Kex2Sggd2bwrCUzWzt0VjdMcVvRcdLbwg9slsUmWYv00RS6P+SXdphUJ8Nof8BaRuKhigzxFbvl
	XA/0C+P/Xn0lE07raL5BiCRaxX4FCecbEHw8qtVzrK074m4WTuB4Iw63IjiSGP3PdTnOaG
X-Received: by 2002:a05:690c:6112:b0:80e:bd63:1780 with SMTP id 00721157ae682-810d7eb0bd6mr46000317b3.2.1782833460437;
        Tue, 30 Jun 2026 08:31:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a783d9d7sm25574106d6.41.2026.06.30.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:30:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:30:54 -0400
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
Subject: Re: [PATCH 07/30] mm/rmap: elide unnecessary static inline's in
 interval_tree.c
Message-ID: <akPhLlv66ZqQ-jrw@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:18PM +0100, Lorenzo Stoakes wrote:
> It's not necessary to declare these functions static inline as they are
> contained within a single compilation unit.
> 
> This makes the anonymous interval tree code consistent with the newly
> updated file-backed interval tree code.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

