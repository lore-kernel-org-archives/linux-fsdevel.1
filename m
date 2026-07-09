Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EE42DA2A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612566; cv=none; b=ZL+OG9sb6+rlY4LR/6i6L1AgKB8zJU0NNOl68qk8FvhQaPCyfVpBWO0kW/OnF7Gyi7iKWS5M/bDgx9i+Q9y4Qzz0irNRSgQfSIkik8gVpgZw9XC4HKnTE+yjP+yRkblITWK9U7T+yMWzwIa+PbUeVt2mIlhpwZYVJEn8E0ApvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612566; c=relaxed/simple;
	bh=GOt99IJ7fgZPI8QmxyNzz1MEgzG9KnOmLnnihrfLrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUfpaigWMm6kggv4BrzcO/Rpy3XkNZMTkZDLaQdOxErgGb3oQmH1xPxkElwHJezHWX6AMEfMABHuoVBLsCokSvySwhDBnAcPp0gr+52G14qN8VP4MBZnFIHyUxnSLcJYxj5oPG24pUliSl6NmEn4LVaJEF1Z49CGV34M4uguEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sMpYtpBL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sMpYtpBL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c1805b8a7so20092971cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612560; x=1784217360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=sMpYtpBLCayfT80R4wzbFZw9l7ecn/vectK5E5n8YBo3056+zypO+Cc5p+yKRJvgIH
         D/H6T9Xrdz6iMSYSYJvVieLq3byHbILjhri9t9JTeNg3KDdjrBUV59FOiPGxnwtT9VLy
         HF1d3IK7IocXO7FJq05gOC0dLYoa87K4H1Npkig9QMat1/arxBuPsjrF4STTmp+4SQnQ
         Vd1Ce49g4dasiNP2aD+fvBhZQJshbx6AC4CXzbMk76CVDp6xBP46+fI2JhSkG6d84zie
         Pt83KOr106cJz+pCklgtC47DW1rTZUKmoVq5ykQpYsi9pRg2A/xacQcZB/ubsxgpernK
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612560; x=1784217360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=kE0JyCbl3uOH1ktydg2t/YOmY+hOrpWS6k7Clduha7968OTv9EhQPQRe15xUvlyqIh
         1V14fQ5td20TBgHDCJLlvw3gH3IdN88kJkZ9y2pXOqAoXJpwhX91NmN7J6VI4aAl/tox
         NvDPbJZutfkmt9bHXW+QMK97YN1L/qBFvsxa1YbkX80J+NUg/jCUmuBQrqL98/mIYWI/
         zOBqerRX+3CZr8QHsVS4mELl2qhf4k8li544uOk8MbQC70DlmFqorgHeA0BGP6xkHEyC
         5/+HH245TH8CaHu12ZuG+Uk34vd/0btXX2ajEvEO3Hx3UPE0/0Dqf18fKLMsbGKk/XMt
         09SA==
X-Forwarded-Encrypted: i=1; AHgh+RqJipHFKLBXzyBe2UWM81k2KfaHWsC3+/PzkT6gLti3uOO0SJmk6ztgYaeiWZU9RnDAns016fcRS+fkOxQe@vger.kernel.org
X-Gm-Message-State: AOJu0YwL40Kqwxp7zxT2PmBEOK8JXhsxBYeyhSke10+BBIOIKhwYclWU
	F3HEYaGgw6usPv4Gu1Td6UDOteeHHbPx4sOvPJEAQlyEQfQ7I0/4Lz3ML9//N3kA2Jg=
X-Gm-Gg: AfdE7ckKRV89DVtsOXVFUvwqwCfolveemN+i7aC1z2mKwaMqo3QW+uy27ql8D2YhPqS
	x5Yfk+RTykjiccNN2wXJ50iTVut85yJtI+OVYqPhtzuZwtb0pVARqaYWG3XORadURYSjj3AteUf
	7b6GDXJIMKmsPVAc/XxD9YlOVZ0ayCgLsXXN0a47Zy+mjWUZrdb1f2TDr8UvRpEKskLrVf4AihX
	lU33kUbpY/XfNodftFTYSrQqGumTIJxCwVHdls0q4DcS6tDELidu6tfavPGRjwC1KZ+uew2QxsZ
	6Y9CE7so45ZA+jfdXGe2Mlin6kyn6rCJr8TsZj9Cu91p8IUHQceOl1lx1NWhTO7p05bzprFpTJm
	72PztDkbQ0MDlo1B1JIdj+xEXp7tZiTas1ykLMe9f1L9ZT9cNvgjjPZTj77fqQSQzZKWj4sb5k6
	xRPenYtMhZk1ErLNT0/mhC0noWO4sQSziu9fvamMN6Aa8zyRd2f/9SSstbIdQ66vXUXsV7
X-Received: by 2002:a05:622a:311:b0:51c:185b:29e0 with SMTP id d75a77b69052e-51c8b2ae67bmr82998651cf.10.1783612559586;
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm169684691cf.17.2026.07.09.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:55:54 -0400
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
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> There are a number of places where we open code what linear_page_index()
> and linear_page_delta() calculate.
> 
> Replace this code with the appropriate functions for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

one nit

Reviewed-by: Gregory Price <gourry@gourry.net>

...
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c09bbe04be6c..536c25d8dcee 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs.h>
>  #include <linux/comedi/comedidev.h>
>  #include <linux/cdev.h>
> +#include <linux/pagemap.h>
>  
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	struct comedi_buf_map *bm = vma->vm_private_data;
>  	unsigned long offset =
> -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
>  

Obviously correct, but was this intended for a different patch?

~Gregory
