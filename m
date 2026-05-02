Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72822126D
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777733852; cv=none; b=DNU1N6D8oAzfcLkEWkvkGzilxuBalg8bCW7QjwX597WX50luILDS7iSMmQed3QxCJDwVBUoUeUGL7I8OySlsfo/7Nr6c5PGoxCOyRM2Mb3l00ojWn8LDNAjsrv0rDW9wu9Jn/gDA636txXgBq7IH7dv6cWyQLPRtaXQX+EV4Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777733852; c=relaxed/simple;
	bh=HfJ1Xmbz7Gix5hLVrKLMKcaymMlgLKHM+yeSJoke1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoNq2C0gtYsMZRfl3gJ4+CvZg3P21g0suPua3li/F5XoGyDBoRSaonM5YxQ2sc9FAfh12cK3jSO2zlKdFkyNHZVtBNmIk4alQAjWxcHtWSmtCkMJKbsoISV5KK5WMkiiRhQCeNxIB9mNbcWHjM/H0FvGcoZ+KavL/ksBs0nILCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m/Qn+zUZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m/Qn+zUZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso23882815e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777733849; x=1778338649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYA14pq+CY0U9Sxh6f6UsYdGKim8qygJpX+jtNAVFy0=;
        b=m/Qn+zUZcx71UtOuDSU9tvXWHcPYZInuaYvj0B1ScCTIojpk+ePgIo9e6hFEiwqbmI
         bEEHQHlqZpAjpv6yufgcpCQzx8remwojba7yQHXYMay8pxW58u1toFWNR7wXipAzETa1
         /oHLMItKcN47Ei5E4uk4jSyctlJEj8+icVjAYgBw98nyKE5dLwghKUyM7/GnR1SpEn7K
         fiDZdDLbpPNIwhoNH+o896lCoifY5/aOmqWreuQUoINPkgRR1HuoL86+wiYZxknsAxPs
         VYusZImk2e7zr06axCkP9KoZmvkcYZs33ih04vPaj3qcrW9MhHNNIZHsmHby3/K1oOg7
         eJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777733849; x=1778338649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYA14pq+CY0U9Sxh6f6UsYdGKim8qygJpX+jtNAVFy0=;
        b=Qw2xoCg9FZ781pEnpCV2MsEI/A7diB0oVXdl6jdwHc2TYy1i+nuUUmh0NAXPPSbIXD
         4bH7sUzL0m9xwrGOaNWA+8uObM7eCuxP921pZOA1herCjGyNsbWpQlX6IrV6BlK86b1Z
         qsrPmV2xmWRX9CMHS6CCpDnyVL64Pgf9qx8hS7vZTzZbGRYUg2qLJutNH/xVzVpVTZGG
         iDTbpTk8xRz96YUibtmMsK8Bz+LyH4I8EIJh83+2nyuRSKE3Qm0aSvAv9IMJn3qB2peA
         OyPdF2mpfve1DG4/VCukOybfbfo98euTSAeS+BKxaUwGLj8cPEyCkux3jRJ9bHKZLfge
         sHvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/20Tc+qzaU8DX6dQMlW6/KvwRq+uBYRAqUa2ZJzl1IOZWRvXqqdS1sz/QNLZbgelqnIV8pMImgoxZ06GKM@vger.kernel.org
X-Gm-Message-State: AOJu0YzaerFrEixbAnUcyxsdGZeJ+zvCKPQvL2SheRk2lEpUKuPoeGsI
	GrhmO8QK5DrzIsspaWMb3vrZHSTKkLivBBboXihlmAWBk7MiE/OyVQ6gvF0+5Cuz3E8=
X-Gm-Gg: AeBDieuis+JPP00XYiqxTDn/3lumTwVbdUUT1iSd1Hdiz78OGfrLyqNxus9JYcYXQHb
	/bDujyd0EtK5/JTVPA+DJO/vtV0JRpFyI4OzZcgrYWyy24nvyYNvY0lWN8vm4mZyfvb8WdWaL9k
	k99B/V54wTlp3reQ9rIDkiaYDKqapxgfWSoLP+uPLNofOzcD7w/t7XBFKgu3AZ2b3QoZkWkC4bK
	L6UWFfnMQvVATRIp5ZofISVqLPrdO4o4FQdOquigcsfM+cYkxiLfBOVjDdLkMjqOM8q3+hvNHjv
	a48KaffG+CxL1lutBEuU6TTzRdKUnBghhkk2KH4iKuGV2z/6NP4QkWJNUZvSruZdV5deq16ERmb
	JP6qhsUSmpqZNayaC+0BxVN0KnDmn9tBhsxR3DOJCIwJgjSLJXatdfCXhQ+r13+KVphpC1fMIIf
	1an/g9Tb8tYKACZG6ZC2GcpSd8+x06ojYDzJJQRRrWSeWq
X-Received: by 2002:a05:600c:c170:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48a9852e515mr48090795e9.3.1777733849035;
        Sat, 02 May 2026 07:57:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.122.39.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm222039835e9.3.2026.05.02.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:57:28 -0700 (PDT)
Date: Sat, 2 May 2026 15:57:19 +0100
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
Message-ID: <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>
References: <h5ossmwe.ritesh.list@gmail.com>
 <afNV5wbhsFQJLzxi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afNV5wbhsFQJLzxi@casper.infradead.org>

On Thu, Apr 30, 2026 at 02:15:19PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 30, 2026 at 05:03:37PM +0530, Ritesh Harjani (IBM) wrote:
> > Linux already supports memory tiers and there are ongoing discussions around
> > promotion of unmapped page cache pages, which lets kernel do the right thing
> > for userspace page cache pages on a tiered system.
> 
> Well, you know my opinion of that idea ...
> 
> > So the question is:
> > Do we need a userspace interface for the placement policy of page cache pages on a per file basis?
> 
> What do we do if two tasks both "know" the right NUMA placement for the
> inode's data, and they disagree?
> 
> > 1. Is there a need for an interface that allows userspace to do per-fd page
> >    placement and maybe per-fd page migration?
> 
> Ideally, no, the kernel should observe the task and get it right.
> 

Out of curiosity, a use case i've been exploring is something like

fd = open()
buf = mmap(fd, ...)
mbind(buf, device_node)
/* fault file pages directly onto device memory */

this obviously breaks if there are concurrent accessors of said file
with read() (filemap will just fault onto the local node - clear race).

Do you think there's a world where we can hang a mempolicy off the
address_space via an fctrl() call with CAP_SYS_NICE?

I haven't quite worked through the full lifetime, since there's a
possibility the mempolicy ends up with stale nodes (hotplug, etc)
without plumbing for that.   But it did seem like a somewhat clean
abstraction that isn't specifically a tiering use case.

(not interested in this for anything other than single node placement
policy or tiering, so no interleave or migration support or anything)

~Gregory
