Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9A4AAC74
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822190; cv=none; b=ZFIkKbbKWoaSr32wGeI2ej8ms651q17R3SvDO7z98A4VBqZlUxarMWHghFxLp2C1XEpLhCGFny+YMRpuHMnFBn7QCHKOr6M8D+GQkWfFQnVKvM/Va/TuwP6aZCeE9gu1+vMmpTdJ2Pv5JmTGogmz7PBQOR7ry/wHnRVq1jQMLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822190; c=relaxed/simple;
	bh=yvBSXzc3XaLRc3YUflgT+bJ2cxmcz8/jCGl9ajVXqLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM+BhE6YEhKKLdzrElFlonUx0SAIa71+d3xoXOSuxQQswNfuBP3d8EHlB1k43RG2hPEr5Y1kG6lIQYuw4++LJIWvjCKu23Ub+fftO1ymmtAHHi5p4oDFG0Ov7w2W8dIlfguRkY4YvAocsVmB6V3hUSpiZ115TLHV85DCEU8S8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoQezf1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoQezf1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C380F1F0089B;
	Mon, 12 Oct 2026 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822188;
	bh=+NrO4pBu2qGs0CONcNp7yNgWTs73KFTjj5ZvduOqD98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aoQezf1+3FH5asE+xZdilwRBZggDGInsRkIPQGUSwmGuccTxoynGxGJ+j4GddumFE
	 wWwITSa0usmVpYVq10j52i2/tvAerVpn2oaJUkpVbKUtsIVdYNVjwZCItnbWXrxw9x
	 NhVNGaTJGEevbN1mUon/l9/yxmDn+rwzryrXadU/IKIcb6bsGdqS4atebLgUgaL5eI
	 RMKL5iarBHdUocCuiqAEbeLHXt6qoo82sE2TUW+yhT8IfckburG+pBjUnzziSmdMK8
	 TpLvQV+wdv0roC1ivuyjlQTl5sv5xPGa30zUi2TWiOjqIvRfLIc0fTxkFqHdsRGf4D
	 wPX2jeUeBWE8w==
Date: Mon, 12 Oct 2026 18:23:00 +0200
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	hch@infradead.org
Subject: Re: [PATCH v7 2/2] erofs: reuse superblock for file-backed mounts
Message-ID: <as0JZCSfTBo0e3Lq@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	hch@infradead.org
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
 <20261002163225.1258203-3-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002163225.1258203-3-giuseppe@scrivano.org>

On Fri, Oct 02, 2026 at 06:31:44PM +0200, Giuseppe Scrivano wrote:
> When the same file-backed image is mounted multiple times (via path or
> fd) with the superblock_share mount option, reuse the existing
> superblock instead of creating a new one.  This allows multiple mounts
> of the same image to share in-kernel data structures more efficiently.
> 
> The backing file is identified by its inode and fsoffset.  If mount
> options conflict or extra devices are used, a separate superblock
> is created transparently as a fallback.  Remount is not allowed on
> shared superblocks.
> 
> Tested by mounting a 177M Fedora EROFS image 20 times with full
> traversal:
> 
>   #!/bin/sh
>   IMG=${1:-/root/fedora.erofs}
>   OPTS=${2:+-o $2}
>   N=20
>   DIR=$(mktemp -d)
>   trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
> 
>   sync; echo 3 > /proc/sys/vm/drop_caches
>   INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
>   MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
> 
>   for i in $(seq 1 $N); do
>       mkdir $DIR/m$i
>       mount -t erofs $OPTS "$IMG" $DIR/m$i
>       find $DIR/m$i > /dev/null
>   done
> 
>   echo "Superblocks: $(grep $DIR /proc/self/mountinfo | \
>       awk '{print $3}' | sort -u | wc -l)"
>   echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | \
>       awk '{print $2}') - INODES_BEFORE ))"
>   echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | \
>       awk '{print $2}') - MEM_BEFORE )) kB"
> 
> without superblock_share:
> 
>   # time ./test.sh /root/fedora.erofs
>   Superblocks: 20
>   erofs_inode delta: +45864
>   Slab delta: +37448 kB
>   real	0m2.311s
>   user	0m0.222s
>   sys	0m1.998s
> 
> with superblock_share:
> 
>   # time ./test.sh /root/fedora.erofs superblock_share
>   Superblocks: 1
>   erofs_inode delta: +2044
>   Slab delta: +284 kB
>   real	0m0.679s
>   user	0m0.157s
>   sys	0m0.469s
> 
> The time difference shows that sharing the superblock also benefits
> the page cache and inode cache, as subsequent mounts of the same image
> avoid re-reading the backing file.  This is particularly useful for
> container hosts running multiple containers from the same base image.
> 
> Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>

Reviewed-by: Gao Xiang <xiang@kernel.org>

And applied to -next.

Thanks,
Gao Xiang
