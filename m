Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33B399352
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714808; cv=none; b=I7zBNyED0V0iprsdFlPH5RX5qoyhNHAjXYK1K1NRTgTFpTeqHMWRtQsUr09VNLzpWoVJDS0AkRLxZXA+KM1rJSLSH9sUMC0WDt3s2vfWzAw31vgzZgRG+MXcKYtu4Og+lKaMsYaqsOhTwuO+owpg43WG7lXxMDXym4iQQg9ao04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714808; c=relaxed/simple;
	bh=hY0ihDWAncS8x5azfJXUc95BFne8Ovg7UFiz7I6gZN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojNfny8YadmDfSF0noer+Yd/Tk+6bFMORgklzq457wMrhtQt+9rndo5EgfPAsEZyUWUFl4vtWqIcD7JhnG7il/N18X6Iqe0m9xrmVj8EzfmVr9aXwP9AFSlR4MPMMKXnaJtlXj0K8xNxj6PRsPhAkTgtJ9/nhUG3uvNBUBTwN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X3mYeLKC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X3mYeLKC"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2cce930cso13412501cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783714804; x=1784319604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=X3mYeLKCTjrKKg7CrKhhtCpJiHPHVx9i7wyXOXHXJaNZNTkaIVryh75DoorULOx84m
         TM+OwWO82Wa5PBzq/bp3fBMco7tSum+uO7dHKjgCrcAOtrj2ZcQoqjcMRdW+2pjSQB+w
         tlu3tni9BW495YqGesm+7e+WSEHEYWpHM5hPATAn+CpKpWPA/cUG+5VCwhc5PCHe0PUS
         MFkXf6cktWK5db+chO1jL7u4Y/QBBpOwl8MiEg45GxqUmoLXqyMpkCjPR69yebLQ4Enu
         QCcQoXAuwRIe5dPzaJOvDluq2JLNeIY5o4vGwaqPBzmc1kC+TmHXnJkELSBsdLoTg8vE
         umKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714804; x=1784319604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=JPrOKxUWDklmv84uZqbspyBmUWmqypST9xOvu2ATk2DzDMROopfFJlOf04TKmb8q64
         U9RQ9637uYTgvgA2vGgdWjpcdU3hfgGPcDRRG7E0vaJDI0axcQhz0x0rJyZNFL+U2QcB
         EHgCkEaLC6bE6T6qfM/eksR5zscWG1evBV0tpF4GXMFukqGZrpFxLDO1ybpu5WfLl8he
         90yzo3xS0MPqudqHQ6Ex5CrT3c9x2LaMCDo51P/0lDd1i8Jd5Ej2xq27FhE+boScDhJj
         obfv33Lzbbwlmh3eo+zzORXY5ctDpWBYWK9yoRyNMcCmQUrBqAgTvWMTLYwSAbgfM4FV
         MPQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6IIcEz6MfAUXvzQMAjilva3NZ4AxjiV1mPIvVW5u5s0D+/mGyF2F69/LfJl4aPiaLIzG5Fygs9oKlyu37@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ow3tJs8xpJagqrH6vzWZNlIWi+Xl7GTSrqpbpnuI1r26/8zW
	QQmdiHC7LqzMuu/o5aTydYSRyEctdzWQELYte/tvwCXo3EVbrseS71pDdBp+G+EKXLg=
X-Gm-Gg: AfdE7ckE/YscqlxWSpSgKr1gSVl9totsUSLTS4GBwprCd7mkkm3CiYWYT84Yyd5o+bF
	PGT77fnWFs+VsSNCUDc3PMQz5adkazxOUU923cUPqTQ4ClzbvoDACsEbX80zqXIy2NoZm3DtbhG
	q8/+z9kg7TLVQ3oruruXrjavJ8Tl4lTm4jyOlNETLBPFWBV+MruA30Tde/CFXp2uQD5oz6jpJ+8
	Kz1UuudKPLUp5Q/l4vN19kf+HSnehIsIMe9EN193f9R+NNTgtdyuE2QjIVVZcebeMWDUDeo0hwx
	AArjq5saxRlxVZAAJKcujAv/CMGYknoSGTuhDPh/q3RDPyjp0o8Z+3zvmlQ0HEVHb5HW7LgOkOi
	GPoNCgDBbQAfLLPzY9ExXWjgnccwRbJxPfIxnduSQw8IaBtw8O3UAYwRIVeCk4TDOQPoc5kfr1M
	wUaK34ZF948CPUE1wqjrvG8blYjAlswk56oJAU7ny0yIjAdXBCwf2mE5xDx0bCOQEVO2iL
X-Received: by 2002:ac8:7c56:0:b0:51c:1291:911c with SMTP id d75a77b69052e-51cbf0e0649mr5096251cf.14.1783714804352;
        Fri, 10 Jul 2026 13:20:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10f4sm49427896d6.1.2026.07.10.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:20:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:19:58 -0400
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
Subject: Re: [PATCH 29/30] tools/testing/vma: default VMA flag bits to 64-bit
Message-ID: <alFT7lx8F04rN01D@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:40PM +0100, Lorenzo Stoakes wrote:
> With all of the sanitisers turned on, setting the VMA flag bits depth to
> 128 by default results in overly long build times.
> 
> Reduce this to 64 - we can always manipulate these later for testing of
> larger bitmaps as needed.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Seems like this causes instrumented inlining to go crazy.

static inline void bitmap_or(...) {
	if (small_const_nbits(nbits))
		*dst = *src1 | *src2;
	else
		__bitmap_or(dst, src1, src2, nbits);
	        ^^^^ this branch is being hit ^^^^
}

tl;dr: __bitmap_or() gets emitted and then the sanitizers have to
instrument a ton of inlined functions instead of the compiler simply
injecting a couple 'or' instructions.

if you wanted to keep the coverage you could do something like

# These can be varied to test different sizes.
NUM_VMA_FLAG_BITS ?= 64
NUM_MM_FLAG_BITS  ?= 64
CFLAGS += -DNUM_VMA_FLAG_BITS=$(NUM_VMA_FLAG_BITS) -DNUM_MM_FLAG_BITS=$(NUM_MM_FLAG_BITS)

w/ 

make NUM_VMA_FLAG_BITS=128

would let you still test the branch but not by default.

anyway:

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
