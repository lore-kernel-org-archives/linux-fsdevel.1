Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344B3BB678
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718466; cv=none; b=FEpKVhs+bhJTBTF0EqbzQcomtobcO8xtS5bH5w9fYaZcuqdCv5Y2Zey0xM5NcQovHvmumAQkbQpw8VrnORo1C2QvC3ZAqmTbXK69SqAnCZHsysD41NCPR18I+JUifDw7IDAizV0LCDVonlHGKwyhoaU4p4g9s+2bX6vgOG2y+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718466; c=relaxed/simple;
	bh=OrArmp546t2joLiGKmZojGNI2jG19j2P4RpxQaXcMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojuJzwsAU+8rdR06/zURgCElEyDP1iqul0jHlz1Xmtoz3QT3V+3AcbC0LoFIaTA2SKpD1ooDFhvIqjDuwowhZKn8hE64pZ8pmtVo5tF1D776qAun2RN4KErLVUMgdqBMTnm2+OXlsx64KTyUSQn2iw1MWWc07fYPwxcbGHfhxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WrsZLakZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WrsZLakZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfb91795eso9176241cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718463; x=1784323263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=WrsZLakZJT/5oETG2Se79/v9kdjkpEQDr7Yp+OGw79X3NAKPcDAh1QSIBTgD1APIk9
         PcNtWnmXjzVyA/ekAuc9J1Ldf1520O+Ezw0w/Ib2rmg9zLzxvlAdRLVhZhEA8PmWUNiK
         TQNQjHvefwSfVxq1+ZCz986aNPT/4H/tI61eQYAsQJpO4szsu8Cjyex71k+0GpxpujLy
         wBnlnlMi5HipUbm2ZzOkDOrRTbcr6VJAyIpY72aJ/E32HuOp1s4SJDdzj0BVE5V3xg8/
         VUpFjW6w8Fy4sl1gdFaDfoPbhesiNrFc9fyD8+l3IKOSNiiupFoFQbmh3CqhrxND/l+7
         UddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718463; x=1784323263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=bHLKNXjPVv7G6KgZreu3/e2O1cXE7M7TJoj5dJK6ufYsloE0d0pgCsgQknrePTQxfm
         bqbGnp0PXl4Xm7Os8LPx6XV0f/YznO+wxJVSdfRyMGSxEiluinO4zSmdVSl4UE22475V
         +cnoMPzN0HmiM2CZbVOZaIEwn0eHhFk4WaTpFcx/8y9GcZ6N/MtcXAWSamO8jmU+u1AC
         2Qae3mRXeFX4NJwr5oBF6T9lpYb+Ro2rPt3YZ1PPj4pg4yVFnqi93Cnc41I0RYgsfZ0j
         uxXiVkedIluskvJUVvN8XZ4ms1KnyD19Kmd3VkIMmhaXDHulf4tUq7c4n8qKPrBI5Xgj
         XSEg==
X-Forwarded-Encrypted: i=1; AHgh+Rpayyfeq522neRzJRz2SHawu09h6CQOhw7hbrJF+NCUeW493JmcwBFi0qC85uLtOF5q738YNORGk4Mb5+Ww@vger.kernel.org
X-Gm-Message-State: AOJu0YwfP+H5Muqa4DUdO9HMjmrNje41kpNO7GlX5Zwp6kXv638+Dh1S
	hSPBUtJ0ZzYuF2gxPy/0feF6ULzzk9ZksQO8sjDHjm0vgjnTsKDI8YZyPvdg4519Ccg=
X-Gm-Gg: AfdE7ckco2bLS18InXl9oOZ+53KQoGL+NwKXcTJcXq/SmQQ3b0APQewSVTgsCRRssVZ
	DgorScwRHVpf0U9DQaLFlpahZ9u3MJ6ig7HiSotMriKWHBbuRPcqWMjZhNOUKcuCagkeqdzJS+6
	/JBHONgnKCUG/IdxVe2BasJjexWjmFLcjEzQqJFWUuEDPw6T7gTRKDo4swY6vv5GzWNz9E3okdC
	D5cf3zvZVxzEjnEzeJdMlWPvOqajpuxwSo9zk+nwys2QHFyb5nzS1T88mBCjFshFqIzbXMsotJm
	qvLUUBSCoUaa+Bfl4S5VyRRgdv1bB5SImvHoMSGvxL4LWq467Dj3D2yQYeqqWgQjTCdKJtRWNHD
	jOD3gAfEMpMsM0mW25MdEb+PUferOVfChvxFrhEB8Oj7xTJM7lAYR3tQdEhLD7N5f8DahDF8cnw
	x2nf1eX8dTlrMLIPhwti/TYacFBFKFwemdLGW/xLxTs3lV4FX1+nfJCap2FIeg03KMi01w
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047;
        Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
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
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

