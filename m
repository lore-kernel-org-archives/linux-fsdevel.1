Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB82364053
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610330; cv=none; b=s4/TUltb0xKRJOX203ElZfn1wc+M87HeAWWmakCwB3kCXL2IBY1xxVaPF47kEVbW4e6RKlSf4e7mINlWdgZVZS0LhGeOSe0qSQVgqSe4VyRtUJFNFKYVgWGQGI9KcuRyeSMFra+4pzuXqEMEJbGH/OsVAaJDMxR/HyNLA5pv/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610330; c=relaxed/simple;
	bh=EmhDmZEzfDqtz+/wM5OYtSnBNKhNR5z6WmgKAnKqYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1IB/esb2iqQQWF/ewb2aMBEZtuPUryKZSy+rm2ZQX/yjyuoDZRlM76qCgnp+6owr2JHiTTqVIDdM+iDqymP3M7riI66PSXF/cP0Xk8uG48Ilir/bgY2Kxo5kgcw/fv7Behy/CAgL6Qw2N2TkW4QOaEN9w+OOyjtiOmiTy3QZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XYuSc5IC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XYuSc5IC"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c08df8513so11890201cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610327; x=1784215127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=XYuSc5IC+EVJbDWikpVPC9cDKrnWwVwEAM4vxRerghx9T5cLKor0lZn/3xvEy8MYvH
         P4G8QPzYbfEZ/SuD19iQ/Y1IHWEN8FQYvrl4gGGNvM85yYx5CoTWRnrwozvd8buW/yZu
         rTLr0Kl5kFm/eeBRVjl2lZuNMDx5WC8PeGDIx78E6vBCLlaGrNT+PUtAJ/u8INBmJnMf
         RbCmKrzJydlT8MQRk1duN94/X88hvDTJtAhpiVN/Uddledvv9UkLMBn9POBFDX+NJflU
         wUwaXNQ4tD3o84h7GQtBbwvEsPtUxnWPlr1FHKAANE+13sbK/9le7ZhU64POCONVaFwl
         Syjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610327; x=1784215127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=Me4T6TSCglc0FdjvvO3FSh1nuCgu09kxb99f8N8cMxSrQZvFVsPTXRTN593vyL5Ftc
         Kp6Xgd68bdTj81ylfsJSPaKyOP6JNGyJnkA5TWONHBTkeQWit+YY/EKmtTWkONKRZUaE
         edLbyE1meFrgOfYxgoj1HVrB+C1RMPxWdUnnhXfXfRwtSAM487QxLivR8y3bpa/betlA
         CbY9xtaClCBkROSRXUHdbvB/ZyjOjHM55uujK3zXAUzeis5jIeV2qGcImN5nvLeDE8tQ
         uf/3eAeSK1xahc8QWMF57JJm3j7VL5XOoASHFeu9TtC9Yk1/6CBLIJT/x5dOdbcC2YcE
         IwnA==
X-Forwarded-Encrypted: i=1; AHgh+RoSPc4g6uzO73PGHeP6QWUHswaluN7+mVJOEvz5IOF0cSXSqHDdYqfAVI3VgHEuDVw2/XAIO+7nbLcsO/0o@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8k7tAg4eVDMh5QZxEFiJS3rpc+vuAHTS8i9w7DJymMe8qtoM
	VZ2CWrGRkwSxzhYC6jApEBhd/qBoAFSm/mTpIH2qvJx4nhKVi+7SBPyvgIqFuVPsrqM=
X-Gm-Gg: AfdE7cn5tOuPaZgzIrmpERW8x9Sag2VSk+Cb8dgkoJ3J/FuCg6pXhm6sjMJUrPcy9Aa
	hqcYiWgYpJSm84oIVC5HKKxhh3XIUC7mCSDxNefle1sZKDgkOqNITJISsgJ9LofDj+/6Uoou49J
	HhewaXrfixci6oYnkCb7kn59ABuBGmiFYzFHdXE+dKdEmMkExg7pgyya9s+rQFiOkziLIc1zfd3
	6DLv9u8ZQuMYiY+Wsh1EooBxFabwq5EjfSgGZKz4QewuDB1T4NpoSCOmsI6o92dvLryUJlho/8b
	n2d8i3LnoTSafliH+Kr3/u6PXZ06ap/gUjPmEiUA6vSIsjBKSVS7b973HkIPuQTEYPDR4WBGABU
	4t9GE7EaqrsJ/Kl9RnXeAyt4MqbN30UL9IH0cGg1NhYRoTtGeMKyYJEiIpO4QIiPujnSse/lgpY
	U15KnrqDpktSICYeDKt4+CEqKjU9iGW/8G0R/DIRJbRI00LVlTn7QSgohpXbbtv3HjcL6b4ZPhs
	t66kUw=
X-Received: by 2002:ac8:5cd4:0:b0:51c:1c2c:a8c9 with SMTP id d75a77b69052e-51c8b3e2e32mr79753441cf.43.1783610327278;
        Thu, 09 Jul 2026 08:18:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41db4fb5sm158006781cf.25.2026.07.09.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:18:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:18:40 -0400
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
Subject: Re: [PATCH 13/30] mm/vma: refactor vmg_adjust_set_range() for clarity
Message-ID: <ak-70CHGujkI5jJI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:24PM +0100, Lorenzo Stoakes wrote:
> Add comments with ASCII diagrams to describe what we're doing, avoid
> dubious use of PHYS_PFN(), and use vma_start_pgoff().
> 
> The most complicated scenario represented here is vmg->__adjust_next_start
> - when this is set, vmg->[start, end] actually indicate the range to be
> retained, so take special care to describe this accurately.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +		/*
> +		 * vmg->start    vmg->end
> +		 * |             |
> +		 * v    merge    v
> +		 * <------------->
> +		 *         delta
> +		 *        <------>
> +		 * |------|----------------|
> +		 * | prev |    middle      |
> +		 * |------|----------------|
> +		 *        ^
> +		 *        |
> +		 *        middle->vm_start
> +		 */

Even with these diagrams, it's a bit difficult to understand what the
actual intent/result of this chunk is (but that may be a limitation of
me not spending enough time reading the surrounding code, not a comment
of your work here).

~Gregory

> +		/*
> +		 *                Originally:
> +		 *
> +		 *            vmg->start   vmg->end
> +		 *            |            |
> +		 *            v    merge   v
> +		 *            <------------>
> +		 *            .            .
> +		 * merge_existing_range() updates to:
> +		 *            .            .
> +		 * vmg->start vmg->end     .
> +		 * |          |            .
> +		 * v  retain  v            .
> +		 * <---------->            .
> +		 *             delta       .
> +		 *            <----->      .
> +		 * |----------------|------|
> +		 * |    middle      | next |
> +		 * |----------------|------|
> +		 *                  ^
> +		 *                  |
> +		 *                  next->vm_start
> +		 */
