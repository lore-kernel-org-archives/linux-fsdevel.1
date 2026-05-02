Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F133F399
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777736997; cv=none; b=t1C0UiHdbYBD7Q9l2ualBuj6gebrKWHWFMFxbe/jc0NlAr7pg/T8wiJghZDf1d4HJVm8yytEEjwpLy+KiogCkMn/70EFfDTRdjWKyzCVuCEYpld1bcdqyR1Wy8hvFUxtGP1yKFLB0SDSUYJ0Zr6Tm1G67dQjmNQ+f4WW0F1647g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777736997; c=relaxed/simple;
	bh=lmh9xa77UeoBboQtlimFqgSsWS9H+IBmINlK2bhP/Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO6a6tuSbzl8yWNtXTCVu47TfC6xkGB5cwm/DpuMiTP7cQp+/thevm8E5vcIaXTaqa3IazRW9Ns/FTm9FoBg6kUAFiXip13iLnJ3eeB6W8f0/NyiTaheVP6KSOmfO5Lq9s+Q/u82M6xdg86WwQ291B6pUOOLgcWXqnLJZ/W1ZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LVnxmC3c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LVnxmC3c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso32730825e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777736994; x=1778341794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVqOlMyjv782QwH3r0yX+YLQuP1ZcJqdDcRKQWrk33I=;
        b=LVnxmC3cDnAhhgvnekxNcrP0gsGLU1re74TSec3oY2GDVpn3BJKl/Gokwil1mF6Wlb
         vGip11NLElW3a3PEOQncqt0kXHm8CjvT6eGs1p72kh3s6q7uw8bB3EgdLPzmt5staSrb
         1WTMG9TY4t1uNzVGu9w0B8O87RV9TH7X1KE1kesXSHXio1eOGqv+uxmrqMMWzMwIgqTr
         5Kbdd+k9doDJ+poGquQAr2nizCPKdvHkwAn5mj2idK0UlvJWAXYsAAyqrGZL83nPVlOU
         GMCf7j/1Y8ajVhnS/6x7N33G6VnXb11lCFegW6auf/W0K1dXsh+gCh0K9fN6O1jIMawl
         8F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777736994; x=1778341794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVqOlMyjv782QwH3r0yX+YLQuP1ZcJqdDcRKQWrk33I=;
        b=T5xgKK/rftPpwvLVp7Jpe6IVGewj9klup46OrhbBXZ2N9Ib8b0XadpwHsXzLkaIeCu
         MKJ4hg8X3JEjoH72N/3srGC8bgTvsD6se8T2pjezvf2OvWIcw77XWJKmVqT9A+SoeXJJ
         BxcDuBcIela5AOe/BxFtDtAo/ZW5bg6n4gDzrOwpVWkBRn1WSLwzJT6qACEHQFmpqZQa
         DgWNkIIsqc2Q2hhHvrA495mz62xKqdWTLtdIqkYjdGhKvKMOIX7Lwsxf/BhWBJnAcwQr
         pVkLQu0EvOwYxBaBMuayJA1RSv91esB5upmgzkH2NCGEV8Fm2MyTrCXTVl7iZimVQxEF
         t4Mw==
X-Forwarded-Encrypted: i=1; AFNElJ/oXUGpH2h/+/X9L7/wltgino9Af7oXrq4GWVvB8CCo1lXVRNuU+RKzYYThbN3sIEqcd4irK0zMN7ZPeUje@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzn+wAAscJi2iME0glYCT8uyj2XLed/hCIMqXxLnoYx/Nf2TB
	ndN7l1nANkRZPeMl8yDq+rkdjQBGBf6s+oBzHCR1yYyDhr49/TL0Q8XFCRZ9Ge5oSH8=
X-Gm-Gg: AeBDiet4wHF1A/MamMyktGkGV9UhoFTxEJZVUh/YalDfpghgmKv4YnrUu579ugZnydH
	6A9WLyU6OKRnpRIi+Ot2oSbooh8zT2tEMl9EQx2Xnc1LwzbPGjhzQxHQg5zWaZpSVBl1l1XARZ8
	/5djSa05K6UPBeCg+ORyn66pKOllKTj9xLbfuA2fXx/IxczsRiMk+oFazfc25AdSZ1NetWw7mXo
	6ZZ7afWzOHEBmXP/uCEvlf2X6LAMUsJE4fbKHiXtkio7P8kpWR7P+XftuXYTgxZsLHpbJH68j0F
	xTsfBmk3oYCtkdV/iTEL0NWeQ3ap+5pKw0MAV6YHOzAAfdV9ByxIgls3SKX5aCtpUH/aLeIqqMu
	XMQFStVB/utcbljWpr2NlUsjDHx8hmOuBJFGvaGoihrjvNAVILdNiwGda8EaX+ehaNly9vu+gaq
	LiVtObbe0NLNFQ33VoC1BPe2wd2wYD+iCvyicz6E75Knbh
X-Received: by 2002:a05:600c:c0c5:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48a9865f865mr38957905e9.17.1777736994019;
        Sat, 02 May 2026 08:49:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.122.39.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm190089655e9.5.2026.05.02.08.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 08:49:53 -0700 (PDT)
Date: Sat, 2 May 2026 16:49:51 +0100
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache
 Pages
Message-ID: <afYdH4Alu9QA18CO@gourry-fedora-PF4VCD3F>
References: <h5ossmwe.ritesh.list@gmail.com>
 <afNV5wbhsFQJLzxi@casper.infradead.org>
 <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>

On Sat, May 02, 2026 at 03:57:19PM +0100, Gregory Price wrote:
> On Thu, Apr 30, 2026 at 02:15:19PM +0100, Matthew Wilcox wrote:
> 
> fd = open()
> buf = mmap(fd, ...)
> mbind(buf, device_node)
> /* fault file pages directly onto device memory */
>

maybe more explicitly, something like this

fcntl(fd, F_SET_FILE_NUMA_NODE, gpu_nid); /* pref node */
mbind(addr, size, MPOL_BIND, ..., MOVE_ALL); /* move existing */
madvise(addr, size, MADV_POPULATE_READ); /* fault the rest */
