Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C02BA34
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713830; cv=none; b=k5TvBctCVLJqLhnqQpuUAyulr+4U3U4PmNHw/N3OXAZXuOjtq3nCLUW9f5Gn2V9n5Fq6jRsYtsZacEAg+R2eMxfeHs9xYCB7lV9NTr/GAAfKjZW+0ArlzcM0XbEhrkDcchERpom0z9LE/wxGd3kMN81d3ipzOtkEC4eQQpdJfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713830; c=relaxed/simple;
	bh=Ak4wpDCzkbJrQyr2wvshqvtR0Lx5Si7HS9Nv4ke99Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlJxJEc9vAbSAKG6+ToBd0hJ53dsAcBP3l1i/KD+Cfu2OZ7uAnqU0qeX0dI/1LJr+jsDXdHb9JNxyTs93oCAS0Mr8oQUQeNCkT2/ZZ7D1JH3d+BGntO/YLJQHdncpeTlWlu/fUbbRKdBb7vxc98eiSIIMplAfVBwryHSwM2thuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbbxve3m; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbbxve3m"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba545100a13so477037466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777713828; x=1778318628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyZ8dCn5F1nvhXv6vPKVMlMZuatDqCQkqJxKXsd03uM=;
        b=rbbxve3m5scLKhPn3vfnZLfZiK+98JVlx4xdR6f2sX18STRkGWumhFKG5mPJg2e4+z
         uBIyEaA4OBOLyIsNyX9/e4j/dEhfyDxa8oyVoXFdBOOpM8GAdrKEGYCa3dMtDp05p/ru
         S0UzRE5Gztcj/W0qM+IU7MPrklbkwRODKGhGu6pId6UAlysZwB6L+O6TpqRAjL6NkJTA
         eX9WccTN1VWJcX46QqKOOrVoUuv6tgN65m90yuuUQtp/hqPRbNdYj0kSs61vk6YmPS1B
         1ZbqV44AcKObkIZa4SNC1c0jVQQFzPZdytzv6TGptfdR87d422xGlFMjCH3qn19vTWLB
         fKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777713828; x=1778318628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyZ8dCn5F1nvhXv6vPKVMlMZuatDqCQkqJxKXsd03uM=;
        b=RS1mom2keKQcC5BnClfYBaEvJLBdVj4soBI7Jwl89P0QSSy3r9UTNcH/zrFt7Qwzpr
         M8Y3256ScEIOjeH+DYk5kbPnr3R3hmyBWesNdFt8nkJbVdgvF4TGY5Lk22F9El4XY4wU
         ToGWQEoOrIz1XFUgk0aRRCTdr0usMHK0pFgOKd+oUK8pQtkHNf+leL1NKHKryMH6bokm
         zvsV3VzwbzHW/Zp+R1huryuUm+vIRIk2p5VzSr/F1BdwEevGX/Hm9zX8ZNo9djYFm1EW
         d0ZbvqhOYMUD9zr8sCwBh1AoIJK3/shMsSAuQM5uZyG9BDXD6ELx7xtlcKuPp6tbX7zC
         LLgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DC8mBpIsco13VJs9u1rcNHvhcvSm5z6Y07ZPV/ntvMP17B9FJA9m5UPAAQ+K6Md6xBq2CTwFT2HklJRLz@vger.kernel.org
X-Gm-Message-State: AOJu0YwgalrdmV57ngYo+pLojY+1XWTGcCWKu9cwfUUot/UGVzLHiXku
	SbzXSrCO0RakW4C6EGO+pt5GsjGU+y1OWVyK8pPdCaAUSDmgN0EDIJeu/qTuH8vK
X-Gm-Gg: AeBDies9XS/V+TvVs7UBfpH2FMcVwRKEqXlo+uInHCOC6furFAllGywxzynP1CtmTUZ
	3PeeR4aUcuhc3/RpqHW+ZMg9W223MzNKR+3GAQ6ihJ4Q5mjIYUjAvHOVjseOu6HtN/VwVeKN+i5
	cly1XrSgETQCgmtJ1eL5B6H53AGajf+paeYL+bmZuJQN99rsCKDQ2C8LwoiKmxuxERBij2ons2y
	gb0pQAijmvhMEHxOOSMDuXCVkXw3D0mBlAhohbsB25BnslE4c5Pg9Sg9FOR7ydugXXclrL1Wcn/
	abLv8nQK1pK9Urq3aLIMCe/mm2TDU7UmeQnG67sAtCP9xlel7rBnLoY7TIoqhByWej5HerZ+71m
	uFJx3zVRnZQWrzDvlg+VV/vZyK1hLZpLSeWCioPWP2ctNj3D8IIzFJ4Zt2xQd8gh4WTv2i9dQie
	kk5Iddke9KiBXDUlJaMn/tx9up9GJh2sY+IrXBXvI=
X-Received: by 2002:a17:907:cf46:b0:bad:dfe1:6a56 with SMTP id a640c23a62f3a-bbffb955fc4mr118122166b.30.1777713827158;
        Sat, 02 May 2026 02:23:47 -0700 (PDT)
Received: from localhost ([89.205.144.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d06e23asm187721066b.36.2026.05.02.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:23:46 -0700 (PDT)
Date: Sat, 2 May 2026 11:23:44 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Colin Walters <walters@verbum.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Message-ID: <afXCoGk2Bu9rBKvJ@amir-ThinkPad-T480>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>

On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
> Hi Christoph & Eric,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174
> 
> There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.
> 
> From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
> From: Colin Walters <walters@verbum.org>
> Date: Fri, 1 May 2026 09:45:58 -0400
> Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay
> 
> Reproduces the regression reported at:
> https://github.com/bootc-dev/bootc/issues/2174
> 
> A recent change in how fsverity state was cached in memory
> I think caused inodes not in cache to appear to have
> missing verity=require for overlayfs.
> 
> This test catches that.
> 
> Generated-by: OpenCode (Claude Sonnet 4.5)
> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tests/overlay/118     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/118.out |  1 +


Please use free test numbers below 100

Is there a kernel fix for this? please mention it.

Thanks,
Amir.

>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/overlay/118
>  create mode 100644 tests/overlay/118.out
> 
> diff --git a/tests/overlay/118 b/tests/overlay/118
> new file mode 100755
> index 00000000..ca21e076
> --- /dev/null
> +++ b/tests/overlay/118
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 118
> +#
> +# Regression test for the overlayfs lazy fsverity load path.
> +#
> +# See also overlay/080 which builds a metacopy midlayer over a
> +# verity-enabled data lower layer (the composefs architecture).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metacopy redirect verity
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/verity
> +
> +# We use non-default scratch underlying overlay dirs, we need to check
> +# them explicitly after the test.
> +_require_scratch_nocheck
> +_require_scratch_overlay_features redirect_dir metacopy
> +_require_scratch_overlay_verity
> +
> +# remove all files from previous tests
> +_scratch_mkfs
> +
> +testfile="verityfile"
> +lowerdir=$OVL_BASE_SCRATCH_MNT/lower
> +midlayer=$OVL_BASE_SCRATCH_MNT/midlayer
> +upperdir=$OVL_BASE_SCRATCH_MNT/upper
> +workdir=$OVL_BASE_SCRATCH_MNT/workdir
> +workdir2=$OVL_BASE_SCRATCH_MNT/workdir2
> +
> +mkdir -p $lowerdir $midlayer $upperdir $workdir $workdir2
> +
> +# Create a verity-enabled file on the lower (data) layer.
> +echo -n "overlay verity lazy load test" > $lowerdir/$testfile
> +chmod 600 $lowerdir/$testfile
> +_fsv_enable $lowerdir/$testfile >> $seqres.full 2>&1 \
> +	|| _fail "failed to enable fsverity on $lowerdir/$testfile"
> +
> +# This is the same structure composefs creates at install time.
> +_overlay_scratch_mount_dirs $lowerdir $midlayer $workdir2 \
> +	-o redirect_dir=on,index=on,metacopy=on,verity=on
> +chmod 400 $SCRATCH_MNT/$testfile
> +$UMOUNT_PROG $SCRATCH_MNT
> +
> +# Drop all caches to reproduce the bug.
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +# Remount and verify we can read.
> +_overlay_scratch_mount_dirs "$midlayer:$lowerdir" $upperdir $workdir \
> +	-o redirect_dir=on,index=on,metacopy=on,verity=require
> +cat $SCRATCH_MNT/$testfile > /dev/null 2>>$seqres.full \
> +	|| echo "verity file read failed through overlay (regression)"
> +
> +$UMOUNT_PROG $SCRATCH_MNT
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/118.out b/tests/overlay/118.out
> new file mode 100644
> index 00000000..881d8dcd
> --- /dev/null
> +++ b/tests/overlay/118.out
> @@ -0,0 +1 @@
> +QA output created by 118
> -- 
> 2.52.0
> 
> 
