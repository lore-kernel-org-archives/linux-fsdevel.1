Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869229AB1A
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777852127; cv=none; b=j676ZQ5mZvmm0OW9lhJFZK4sRw0DE1caQbQ0iei1T++AqVYyxId1FWKxhQ6RWX/V6/4tCnn13eERhLr+AzvonX9AHF8sLuTlfVwUW2l7NZepGQj2g6+EveBhfDst45InlV8ikS4fmxpgIPRGdF/c4wKnpC3PAI65dK4czhxCuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777852127; c=relaxed/simple;
	bh=xqE1hSyTiDQoyIi8D9pquLYIz86AF741bgLVew78RJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4PRbdoEfOZaxhjHScFMw2lby5Uzku87M84wWOMq8+fwLE6yl6z9Z/ZMfCR+I/7wd31N6hcXs805rq9NfRJzsjNhTdGWdWOhwG4DFgEDIrg0V9F4z7bJQv/MDPGM3c++KBXZzWoan8DOlFdREcITJWP46/yx9BQ3eQGuDoL1yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jarPhI49; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jarPhI49"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso24945415e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777852124; x=1778456924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjKx1UUmYJM1XTKV4r5selbBf51cM32x98mvuA7LrRQ=;
        b=jarPhI49hsCB1Q0ahPxSdW0yZKstuYfukFlL3vHHPNwWi2o2QxfweN3nZj17K9irck
         /tKfKFqpqnLUYEwrH/lOa25Red3lel/VLHdKZQhrTxD88rjbPep3kx26nxVWaLHhhv8/
         URB2FRWR9kw/ZmtbsZcrRK1GDIET+NNCMLQwfFlNONS9wzJQ8RjLwUvNx1bHiyt8Ece+
         9rj+OibzYtFkt7WPcu1OdmGu+hjKuzqv5dsnpikD+fyOWNS/nkJRND0gsZMBaWeqrtm2
         YucdTem5wJ92FJf23RzNVl+pVDutip9oIvMtJ1HD72xNkzp8IWQSqqWYjKt9xVsNbI/p
         qPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777852124; x=1778456924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjKx1UUmYJM1XTKV4r5selbBf51cM32x98mvuA7LrRQ=;
        b=GEkgxI0Qh55tEK5uUZsHQ1TPQmVxbhGwc5XXz1YpXdH3RkeX19M/Vv56PhNcHMQ8wR
         cLLXeRgtgIfBMYg1reEd/OhzFIbDQJ/rOfktRMP2hLrIA7/hTjiimSIeJRYVF0cDoiBP
         OlCHITRZILVg9WonMamjALLENzG+pzv6hokXy4xvjHLe4Ie9buGA+VyRFnDXLKeSD54v
         vpiLjewuLSuKqWhUomc9Rrd/bMO0BgS+DnjOwfXQ/QntgB1qvvsPpe4yZ8tpQ9fqiz80
         uMzetHknSOq66OoswIu3/cl3teLCJFIJ5y8VF75YZwT2da1AUtJSIKZddjA7gEP/LjfT
         HlPA==
X-Forwarded-Encrypted: i=1; AFNElJ/XBdJZTjkEQlW0LohcN0RVqXlc6YJddqQN4940fJUSif1DRvkUF/9mJRITKIhYLRqRv7XKuHmQ2L74tXhH@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQJirVdoEkrDouWxO0tRTl+VQNoLhBbWA1GZQNEzSyI8iZ65a
	GVFD5nfeLnt4NRl/sLJK2xlU0gyvjjgPrFD8104cigRwcfd06VnurRt2nxAuNismkzc=
X-Gm-Gg: AeBDietKBNMHbPAALZ6uAOoyeFAHC0Csu55+3Ko5RmBXu7lSOmBaHREepb9jQKmgRnF
	Wp6mVNPdhuxJI/WQ36ZJrUaoW/xsjO+j0cBdxTSWHHVaU09bOI47P4mBSSFShPbD4c7Nxvmur3u
	77Pej7G8cv6ts9aL8VkJMkZx8BQmEdLDmH36R8tNZpMu/Xy29A/MXq2/eZ01QUDYXlN40+bxyfL
	8WpiFSYFKvWI+l6dX1ioQYqQdZWNWBfCZfPkwbkCmQMtx2zH3OlsfQqM+3KklICzvH0H75CyZdr
	za8/4g6KwJuRiQuAzC3m4esx6wDmH+Mn2HsxbFyalr4RReRzrPvvhtjH/cxIaC5VUW7u4YcCsTP
	whTgVjIoHSjG/C3sDzedq+qkMyYevQiK4iDtEkZ8dOJTAr9Q91r77gLXzSzYCOzZm/ga0Ddir1A
	tZpbJq8RAl4g/j6xB9fx+fERwbrEpPzbOlhnklSc5Ci/s7CfkC5Ti4d0c=
X-Received: by 2002:a05:600c:c082:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48a9887190fmr83740685e9.8.1777852123715;
        Sun, 03 May 2026 16:48:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fed8ea0sm105655245e9.5.2026.05.03.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 16:48:42 -0700 (PDT)
Date: Mon, 4 May 2026 00:48:39 +0100
From: Gregory Price <gourry@gourry.net>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache
 Pages
Message-ID: <affe1wM7A8hWxgUW@gourry-fedora-PF4VCD3F>
References: <h5ossmwe.ritesh.list@gmail.com>
 <afNV5wbhsFQJLzxi@casper.infradead.org>
 <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>
 <afYdH4Alu9QA18CO@gourry-fedora-PF4VCD3F>
 <8qa0sc06.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8qa0sc06.ritesh.list@gmail.com>

On Sun, May 03, 2026 at 09:48:01PM +0530, Ritesh Harjani wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> MADV_POPULATE_READ_NOIO should ensure that only the cached folios
> belonging to that file are mapped into the process address space w/o
> doing any extra disk I/Os. The subsequent mbind call with MPOL_MF_MOVE,
> will then ensure that all the existing mapped folios are migrated into the
> chosen numa node. And also that any new pages which gets faulted in will
> get allocated onto the chose numa node because of MPOL_BIND policy. 
> 

This all gets rather racy with buffered I/O, I'm not sure we can make
this work the way either one of us want.  I need to chew on this.

> I believe there might be existing applications which might be facing
> this problem today. This can happen, for instance, when there is a
> workload which can run multiple times and may run across different NUMA
> nodes. Our internal test team once reported a similar performance
> regression with llama-bench on subsequent runs when running it across
> different NUMA nodes. The reason this happened was that the existing
> page cache folios of model weight file (from the previous run on a
> separate NUMA node) were not getting migrated (because they were not
> calling MADV_POPULATE_READ since it can cause a read of a large model
> weight file into the page cache all at once).
> 

There's a long standing issue of unmapped page cache files getting
trapped on lower-tier memory, i think that's an orthoganol issue to the
discussion here.

IIRC DAMON can migrate them, i think, and vmscan.c will happily demote
these folios.  So at a minimum we know they're "migratable".

> With that in mind, do we think having something like
> MADV_POPULATE_READ_NOIO make sense to address such problems? Do we have
> any other usecases of this too?
> Or do we see any problems with this, due to which it never existed?
> 
> (Note that I haven't yet given a thought for how it should behave for
> anon memory).
>

I'm not sure why this would apply to anon?  Unless the issue is
specifically anon MAP_SHARED.

~Gregory
