Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF83CD8C8
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817735; cv=none; b=OY/JR3sUweUmSNAJrsc6WbK65gLAL3QUNbyCC/Wef5YFQT8oZHIKQC7ATaGZNWm7kafh++XNuJUIQ16ygmAq+BmFllw27VfLVnwnoddsgZd+N1/+IUorT5YO2xlQfn2JwJZxn0ZZqDmuut6yANKNxvbMMtvP8cTaPyLPiMmvjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817735; c=relaxed/simple;
	bh=75uFtPxapFid+TP3SqIuonzscbWMOB7EIctLrsn84KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mufhVCCDcuNRV+QZOYH1Fh+pRcINCaq5Ot0WXK3oNYyTBLEWWrXb7dKBBAJjDbOekpJPQzHeZ+F/Jw+A8rNEODvMnTxZtJBGGCzuihXDQVXBILFikiizQ7OYoJAVv9ZrrnJ7Fn1RH1RVsb0My1yTR6X8yoVeRgBYLcng88LmPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VyPjQxIu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VyPjQxIu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so30475515e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777817732; x=1778422532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YoLu4/Y6To8vmjRfh7km84wvUeDNcP0Umpn2civnYdM=;
        b=VyPjQxIuf+QVi+SeSvoIerEHupf655XdYNa5uZv4EPQ0Al4G4NVT3gnmaXsvuckOxI
         wDSnNysWTZ1rOPSrk3Y/aCc1MEIu2KXr4TTYz5CI8oalcoP64z7G7aCb4AAjYfU6qkCR
         YsLC1zvMIpC7MpGpY7cJ0SDpqWqv75D7yy4OrJzlqQFA/4JwxG+kcFdzaYh9NHKcpaVG
         WufETHZCkrOAjPbT9hznygqE3YM5dsLBxb7La3yVkjEg293Xv5SrZZD1Dl2qy9JHLZY9
         ILcFLNsDH4IKbzlDrOS7RghPAgBaX5VjtCmKBkihhe4hyTgKERfFqYqKK+Mj3MVoWzxS
         MP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817732; x=1778422532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoLu4/Y6To8vmjRfh7km84wvUeDNcP0Umpn2civnYdM=;
        b=d1opyMZQTIgRR33q2e77aMlD1ZjnCeribwIBR5aSEl3XnspAMzRXl8aC+q8ZZQhD3x
         COhf0FC7tPneY1aSDPqE8CAKc+X1TYjcy8IUuLsZE6zWSk+H49Jd/OF04CLA2q355S4+
         +pzF1XKxUGlYf2E4CcKxJj1dXXd9Q8gTGtxRxFVfg8YgkE/nkrRK4hEtSsxQb2GgL04E
         IL2pm6s1w1HIf/bTFQ82voupvP1fYDi6M5okJAsd8dwGjv9npxMaqVCBST+GK+Ts07Qz
         dQc/eDHVFOiXPWG2yEViJ7Dmp3MRP4xS6OImIYEpyHPbZnZJKFjQ2WMC3UucLWMbeURX
         /thQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FOMaL+nM1syLbflptQa3pPeWBOZr/UKIy4YY8m7LCkQrfsF2Ki1klS4kZycGfBrbWaQgSyWCQcyEWfw4O@vger.kernel.org
X-Gm-Message-State: AOJu0YzBU2IfAsGxyhU7Z7rBHJ1vQWLDbS4oeTqS/x+nWOf/2axBf/wt
	4obxGsON4hEv6mBQsvcVwOGuYMJWDLwcGzRDM13iBWUSzI+l7mf3BflO9AuEXfHWwPU=
X-Gm-Gg: AeBDieszIHUIuMEvh3oLyWkCK+HLke5txqpQSE+ekosKsCnGYHI2BRK9x0KIaEX+lQ5
	A1bBM3L9r5mSftCLsK8uoM8A+2Ro34FYxMkRvL4baie+uV7FzCqnI6H3c6SHBmWrF0M1Rg3hZ1l
	8wvykazwkhXnvCknjifLROJ9aR30PLwXVt3lPzzID50LZ0SzRfRi8+triU3nbVLe1iF2osv+ah/
	BjNxFlR5O5XZKWZeJgowY92oUw+/CrcV1R8iTD4O2c52hwYsWb4dN1LZRHzlQVh4k9QLBRxPAFg
	VsmbL24L50E9QE3JJ+wxlECbc2ko+jsfbcdeW3JxIjX1R0SQxZ8wharUwedlks4tQramiCyX/bS
	UcgeOehnWShlIUV1DpVzJZFF+EiWZciDl4avRSW5roSm0AiuBWDo9WCzG0gmuoXY3HCdmwHZ7Sl
	/YZY9hTa3Z3Hb6VXmEFUuZkdQJjkSIXm98g6pJ+2qh2NnD
X-Received: by 2002:a05:600c:4e0b:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48a98668329mr118389885e9.23.1777817732149;
        Sun, 03 May 2026 07:15:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm208853235e9.7.2026.05.03.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:15:31 -0700 (PDT)
Date: Sun, 3 May 2026 15:15:28 +0100
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
Message-ID: <afdYgG6d9Vrt3miV@gourry-fedora-PF4VCD3F>
References: <h5ossmwe.ritesh.list@gmail.com>
 <afNV5wbhsFQJLzxi@casper.infradead.org>
 <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>
 <afaCICnrkTEJN562@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afaCICnrkTEJN562@casper.infradead.org>

On Sun, May 03, 2026 at 12:00:48AM +0100, Matthew Wilcox wrote:
> On Sat, May 02, 2026 at 03:57:19PM +0100, Gregory Price wrote:
> > On Thu, Apr 30, 2026 at 02:15:19PM +0100, Matthew Wilcox wrote:
> > > Ideally, no, the kernel should observe the task and get it right.
> > 
> > Out of curiosity, a use case i've been exploring is something like
> > 
> > fd = open()
> > buf = mmap(fd, ...)
> > mbind(buf, device_node)
> > /* fault file pages directly onto device memory */
> 
> Could you be explicit what _kind_ of node you're talking about here?
> My initial thought went to something like DAX where the node actually
> contains persistent memory and the fd is a reference to some chunk
> of that storage.  But I don't think that's what you're referring to.
> You might be thinking about a presentation of DRAM over the CXL fabric.
> Or you might be thinking about memory presented by a graphics card
> (perhaps over CXL, perhaps some other way).  The meaning of "device
> memory" has become thoroughly confused (thanks Jerome!) so I sincerely
> don't know what you're talking about.
>

Ah, I can see how the language has moved over time.

But yes a gpu with onboard memory presented as a NUMA node, or some
other accelerator where the kernel is responsible for managing its
memory (rather than a driver).

Probably the use-case needs a bit more consideration before we go
dangling new policies off the page cache - just chewing on ideas.

~Gregory
