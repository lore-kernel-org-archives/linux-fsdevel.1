Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AC429825
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748870; cv=none; b=INm+YtLqbeHO56Ypr+2sLL7pICaEluc/ZK9dzZiYB+G5OHdB186KW5i2Z5mBJp4o1UU8hRTD+3eMEeKN5INeFe8Pv7lPNop8tgXei4gJmoCbmoA7yZBonwPy1CtgBhULGqkA00zXOV65nyMzAjvrbsnfIovFF6isujduyYquWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748870; c=relaxed/simple;
	bh=z4dmX8dXcX6a8GqR+YBU+JEoYI0/LpvWh746yKHnt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU+Qqty2jbO041WCOU9soXuii6bojkhUgx5rUArxz0GUQPOc7yHCAqM289ifeOTHEsimSTeoRjqSgrxO+Jvzi+czLx6tjvM9dpT895wgWC+tuseSdP9kjBN/w5kzJhhmJbY7MIfD90+Bks41BwlE4VHPV2VKSvW07/wJIRSy8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WSc3BCtE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WSc3BCtE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664d7863920so1141078d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782748868; x=1783353668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=WSc3BCtE8Cy+JHvUpBDEzKlYlMSsDumRTtNx0pLodh+z91ImCWQKXqvSA3g0StYP9q
         WrorzSWt4Ci3VMAqva60P0tz6Ewj/7E5C1GTM6F39ZZ/ZWHoe35ol9bRRgqmO91Pz31h
         bBjEsr1/d4aJh/ghwBfx971FN2EO+YVXdYERLnCkfp6ZBwMHOcygXzSS4LX1OECMt2TG
         yWmqN6KXAEwQQwW0fMlQSaHo4lqTG47IHQowQvaM2FAK1rjDC87LmhLr7rfqqVICSflr
         D/Fr2uGWOHOzSWVk415eHQ2p49zbKQCfYoi0dGLl/dfgkqDGA2z8qMmM7gO455uFLEKT
         78JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748868; x=1783353668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=Sm6Bj45o1LE9lz2dJ/idzTARKl7wob2NtlAebMLhqMT7EKfM+jzMzmCbt5imrC/fEM
         iMnH4pl+OTVOiHSiHrYF7RGaA5K9c40460A5ihmihj6T30nYtwGWTksOAjrNsR4y4W0P
         4h7zYWLedAwALgGFp+hrN5pYmYSysMnZ52Z4GgoQQNF0M+419ClmgyQK7lbUHYMyLjkm
         rUlqXjMLb6JETJo8AWbk7QLhvBWBcy9hEHYGnQzJ/zb4TNWgcZx3v3SnsdxsLvHhHqc8
         2+yW0/YKdPudEODBem34IjbgnmHwXbb0VsG0Lb1qqGNLvVqVEYp+PCPZcawxy/oDDe+9
         zaqw==
X-Forwarded-Encrypted: i=1; AHgh+RoWQcbfxmWTD6wOgE7bIUQXcfaXfSjrYQ76vByafzVoUt+ntx/4n83gjii733tPEoi097EPaj74NMs3G42B@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFuZ3RkC2xTwwtQGp+yR9lmyZsc1SLef0QaAvvlNkZPnS2lG4
	jQkdPGvl0BsqIZUIPkES1ha7IdFTxnjl0tLP2aKLzextjkC5EJevnoQb96BZNJWv8Y4=
X-Gm-Gg: AfdE7ckZxUsr8TeHWMJgMH5t1ukl5W+zes1cDznXYdVZkspP6Q/3wn920hJVLOmmC41
	Blomyt0SFqQ8CWtb8Abtx+wS6fzgBbfbUq739rpHDN+eflJ3nKPLogvrXqSFcN/IgQy5AqVJ6C0
	mj9JiqlYBRLVSpQNYmoiI9kzZkVxegjPTTxe/GhcGS1bJ89lno+5ntMVmXCqXbaL2f4BDLpmRFb
	bpRjaoQEdqBHo3gS+s5RvTUVnK5MVigz9MitmqdECFGtfcZdKAXisgl7c9ca2EzEzDNxTZEcKwU
	+EPgDTYbyK+eA8+PC00DrRt4mnFcebbpYZUHgqVjG5e5egLjUg4ryEERwy8LTAdsggNUly+wKQk
	vuAWPXcJROuBOYET3jP0yp9oQcxxvKpjxXv0SrLAcBuSxi6UF+n5+8ZwmfePE+Ooxy2opUMtePt
	4fw0QDhcyGb7y5exUpQmf5oGWDi5Fk+xaIVaJ9KQdODDKAWCLfFe+iCLUFL7BQpdf71oQVIbvKz
	Q594C8=
X-Received: by 2002:a05:690e:d8c:b0:664:e66e:f965 with SMTP id 956f58d0204a3-664f974638cmr245066d50.7.1782748868214;
        Mon, 29 Jun 2026 09:01:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a717edc7sm1112836d6.36.2026.06.29.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:01:07 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:02 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> Update the file comment to clarify that both file-backed and anonymous
> interval trees are provided, referencing the relevant data types for
> clarity.
>

Isn't this self-evident by nature of the function definitions?
(one takes a vm_area_struct, the other takes an anon_vma_chain)

> -	VM_BUG_ON_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
> +	VM_WARN_ON_ONCE_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
>  

For my own edification - I know not to add new BUG(), should I be
converting BUG->WARN/something when i find them in areas i happen to be
working in?

~Gregory
