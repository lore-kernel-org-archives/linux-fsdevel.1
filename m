Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D269387566
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432881; cv=pass; b=QaoTRRvfj3NJXig9mEbzKltXiBTzKKQ9c9zlKh1ReUgM0H60+Hc4ft+IZX+xc68phdlFYS4229hIhbPcs/JtToMmR2TPbgTNExCbGqa90/AToStOXPcVZDFX9ZbSEZm53EGN8fpUjY88e7eUbqlTCcrM0YwmEHqyn0X6y78cfnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432881; c=relaxed/simple;
	bh=D/PG0O7im4ffUb/epjeq+lDDmxyUxbAM6aLOuJ0HsLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfZZ+e2uNE5C/x8+0B49r+aZbFi2poS4RhAzRqGbpcCLyea12do82jh9hteiwQaUy5RXd1xuT8N+UcjuMqya7IuVoYfcGdoL7D6O8yt1uzI2npndXH2nr8RmgReOJvxY4GXiyZYP/3zlFENN/81RBoC6ZyJvUk6kLpx8aln+1FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGWVAEdy; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGWVAEdy"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e43f3d1fdso647189666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 21:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791432878; cv=none;
        d=google.com; s=arc-20260327;
        b=c5aIrc0WaHzaQLw1dmIfwh3RQqQ8pDDj8Rk12RhW37LExUwItpH/c8kvYMKlbX4zTS
         xydQm5r4I6ujn7EzGB0gcIAFxgcb1p9o+vOYZ3vrjzu+B+Sqxi3/LC2p5dTcdwwrAggl
         2u9xRRnu8x96nr9+05sgQlT+fEQp3TmRrOxBauVX8u0qRnrB9CJJZJBdhoC0OPcW0hDu
         3IZB5yoJrkog21d8mN+F4oc7ZVL3mfJJlMhoQoMwyLSYNdXQ7V4LLsaPii/oMwNOFPm/
         wadA7Qwq9lLmkIW5H7JUYT/jDujvCL2/J3jToEPF8GflwQK0HBAk0eyWPk9jjrpBn9My
         oV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D/PG0O7im4ffUb/epjeq+lDDmxyUxbAM6aLOuJ0HsLE=;
        fh=ACi5fLUEMzK+j3wMVJdPPCK+WLy+0SciiGYvSZn4vmY=;
        b=HHuRUHFnHEkeQuKSOPIiVNkqpH8pbTN8fSoUliftXfX3U2pJX8PThpi4k8jRldnQub
         51m6IKRiyxSkmPFCXTFXDDUevGfUZTt1QZFeyYZERrTSekGAaVAEI11szJat/kd0Kvoj
         Z+1NMBWvtjcxdkBZYPLke7IaCq46HSQh0pQFiXqx6zIHptGMfJNcy8LFgTcTR8zVucdf
         6UMIQZ6ervS3u8PQ040EFhrQ4hypwuQCTeIye1yE7HIeC4u7NT3BpxqRFAFjBqCnADL/
         jE4bAMnQsiNUEe600a5hUl+t1/1wpv0VSmKNLfQylpdYEtTuJpED7q/pnEmgPBK2z01+
         ik8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791432878; x=1792037678; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/PG0O7im4ffUb/epjeq+lDDmxyUxbAM6aLOuJ0HsLE=;
        b=MGWVAEdy2P/D5fw5RyVmWLyzlg047+oEBe5b7YXifvCgA88LNYV154T+/gbdcF0JlB
         hcsgAsKoXPk1HNmkEjpm8VMhFsd79dIM/bB9vW6jHXswbqF/43gyEqT/SwiengEDoYs8
         z+01EZR+Ar28wfuMpNZz78dJNBgwlabiwKaSsZjXxdeJuQxYFHRELgC029S+0zpwUh/g
         opBXywui++KxpBn8SEsTVBGoiB9Q/njWqNllxtZl7FX06yFE4p0UtMbpn4Bt/HlXBe+T
         lLB+0XPK+dK6INvhO8M/3f1xx09H4YSqrNQEl3bsSTUilFmrFBOzRyfCewFpCfpVq52n
         KjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432878; x=1792037678;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D/PG0O7im4ffUb/epjeq+lDDmxyUxbAM6aLOuJ0HsLE=;
        b=JrzLaMqOAw5zBQwF/6vWL5U9YPGyYEi2q+MiTYvwK/DmYZIkaZTOo9Y3/TfE4lT1Xs
         b+O17dCw4XKkR/g1dqALVvUSLatkNAxsYspJ8eQk57W3GT9VpoHWcVwSezx3O0bdhgBg
         fNGeMpS3bpTJU6TDuaWEtna3bFxqsez45BCgtuzDZRnN7NZaPMyyMRXMWCoQSzbGsV8T
         Ts27TUGO2gm7pKRbzL6nVy7KSfTyczOmzHfIZCkBC8dMAs+Ki5gOxupxcIRG5dmIW4ho
         BWehYklwvdphl/Sqo8FHVot0gDpwC35VrBZXTNyvBN3E0/sy5liXM1dr4xnM0jm3j6Gy
         lP/A==
X-Forwarded-Encrypted: i=1; AKwUvBxvzJ3xo/p7yj0KhQdLJJQVI5fLBZ8nM1e9s9uMElJ8XOJ+Tgdx/UHtyjN3CD0m78tIJyOquasa/+pMjsPo@vger.kernel.org
X-Gm-Message-State: AFq9FYJGXOF6hfNW4HImvW46rk/1gSarLeCdVpWFUBzEzlqxYiQGatGr
	82/D/HsWP5tWd9qyZkeTpaDOqndPcX/VX3jdxKfv6tK9YPlI2ikCDWMXVUgP33SsTqbulIEp8Hj
	RIDYZ/1rAIDI/7FUOY1f/CrQu8yx1eeFKDtqoiRO+
X-Gm-Gg: AYBFou2tJiG7M2Iy4AsgSHft5YTzeWMsM9KLeWilEl7ZqmeZNMk4fTtfnEL2DPYCkVi
	eiQAB5sNsUX56bYCHvv5A6fcdW6FMkU3eBV6Mmzu6XZ0g024CxxbwcABn0LCcWFHeq0xaV+RNDF
	uldOiQ4+Zs7qxZLtlMhaZtO6m6DRh56g4TKPH040Ao7KkKhBoq7gzFzz/FYRi6CaSPqeL01p6lh
	Q1HBBOcMUTF9oC4E3zIQMzFtQnODj6fXiuEF2ECxJqwuKJVakNQhQ2HX79C2/RiAa1xsEHckidt
	urG4ajGIXS2CSTHz4DP5aTU4dbdSQUzEaCvrSsq0dWl7MMHwRRjOlNDDhFA22TQAm0dWQRKMyFW
	HD3JPvxK3HFUyPYNAB/dp7N3x1Wm7fC7GBMfk
X-Received: by 2002:a17:907:2da9:b0:c2d:c8be:4e71 with SMTP id
 a640c23a62f3a-c317bdbd04dmr375584066b.19.1791432877158; Wed, 07 Oct 2026
 21:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909232351.1533034-1-shayba@google.com> <20260910184424.156341-1-shayba@google.com>
 <CABdmKX0B7zVfLY9Rov37U+gOTEXYSCMUe6=xFddOrKDVneiBGA@mail.gmail.com>
In-Reply-To: <CABdmKX0B7zVfLY9Rov37U+gOTEXYSCMUe6=xFddOrKDVneiBGA@mail.gmail.com>
From: Shai Barack <shayba@google.com>
Date: Wed, 7 Oct 2026 21:14:23 -0700
X-Gm-Features: AclHuK-Lj8Qjx6iM6hIILhXX7x1mxm-dHonA0g9RenLn6IaehjKV4XivMAFo11E
Message-ID: <CAK0PkCGgq=jP5h3uOGRaoKzwkXewbq5Lzmj=vTk58CeqM0h35g@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Forward vfs_fadvise to backing_file in
 passthrough mode
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Bernd Schubert <bschubert@ddn.com>, Sandeep Dhavale <dhavale@google.com>, 
	Akilesh Kailash <akailash@google.com>, Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Miklos,

Gentle ping on this v2 patch when you have a chance. It has
Reviewed-by tags from Amir and T.J.

Cheers!


On Thu, Sep 24, 2026 at 5:01 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> On Thu, Sep 10, 2026 at 11:45 AM Shai Barack <shayba@google.com> wrote:
> >
> > When an application invokes posix_fadvise(..., POSIX_FADV_DONTNEED) or
> > other fadvise advice on a FUSE passthrough file descriptor, the VFS
> > currently only executes generic_fadvise() on the upper FUSE inode
> > mapping.
> >
> > Because FUSE passthrough does not forward fadvise operations to the
> > underlying backing file, pages residing in the lower filesystem's
> > pagecache remain resident in memory.
> >
> > During media-heavy workloads (such as image thumbnail generation or
> > streaming), single-access file data accumulates in the inactive pagecache
> > of the lower filesystem. Under memory pressure, the kernel retains these
> > stale media pages and instead evicts active executable pages from
> > running processes, leading to severe direct reclaim latency spikes.
> >
> > Architecturally, Linux VFS supports filesystem-specific fadvise
> > delegation via the .fadvise hook in struct file_operations. Implement
> > fuse_file_fadvise() in fs/fuse/file.c and register it in
> > fuse_file_operations. When passthrough is active on a fuse_file,
> > fuse_file_fadvise() forwards the vfs_fadvise() call to the lower
> > backing_file under the opened credentials, allowing POSIX_FADV_DONTNEED
> > to cleanly invalidate the physical backing filesystem pagecache.
> >
> > Signed-off-by: Shai Barack <shayba@google.com>
>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
