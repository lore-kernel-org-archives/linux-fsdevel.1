Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE683F6C59;
	Thu, 23 Jul 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844210; cv=none; b=hMAuT7IZ5RdtyKgKs5+eKVSnmLrTrk5OR5LpOXYbkGRrqphRQtNDwVF2In+pSXPFAdmB32vIK9FBlgCNgpK5a6g8zwSum0CzFi3q+dVZbRxfMX1/x0j5Da3bH049vBUy3IBYx74WtUGc+cuJZGpjY+InP54GxwU2uJgO+Z8VL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844210; c=relaxed/simple;
	bh=YPRDrKJtgP82rpWdkVcHSq9fHGvkk6q4/5LwN2gG3MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSp9VG1bvTjtNDRUEtKQOBge/cBji71GP253G/6w8Iu1+ufyaP0oJChhXB1cWvx+1Wp89MwVLOfQarF6ZHyMjUVW4bIfzYpQWUA2DHRyeAFtbLtQOTQNAZfvDgc1MkD069KUA28ZqEQGjIa0hHk72p6NNH7dd7afP4LnvXOZxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJjvekJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJjvekJb"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ABEDB1F00A3D;
	Thu, 23 Jul 2026 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784844207;
	bh=WOg2TYyDG16Axi/FLfzYKBuSpYx6DfioAxyXnTCqXjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LJjvekJbE+KCTelwAKjD91eMJLJle7GSIAdmezP8U5X+X4T5mnGlZn23ww9GYYCt7
	 htFicYpIx64/NmN7soo5gLhlV4600aV5p1CqSiqGSI0jcvaCpc2J1fGoFc1UiotKwG
	 KUB3QsOpQF/jWiEJHTtkBqE5dmGbfp8gdeVs/lVaiowIs+S6VDk3oiOu0R7m+f54Xu
	 NkDEbhnkMWDbhgaFbx2VRCI7czdqrs8f8WXLB6Oev+djniJfcn4liBHuyybAc6Y2K1
	 7cmpsSZXbjuYRm6D0R0sZnCcjfnuS9rt2usbUjwHQOHwVZvGQ1wwSNz3zlhWC4a9FA
	 vmnQjzKiQpHuQ==
Date: Thu, 23 Jul 2026 15:03:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
Message-ID: <20260723220327.GY7398@frogsfrogsfrogs>
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>

On Thu, Jul 23, 2026 at 12:19:36PM -0700, Harshit Mogalapalli wrote:
> exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenever
> IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
> while collecting a swapfile's physical extents, so it treats the
> preallocated tail as unallocated and rejects the file with -EINVAL.
> 
> Allocated space beyond valid_size is not a hole. Keep it as
> IOMAP_UNWRITTEN so iomap consumers that need physical extent identity,
> such as swap activation, can still use it. The iomap seek helpers
> already handle unwritten extents appropriately for SEEK_HOLE and
> SEEK_DATA.
> 
> Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA in llseek")
> Assisted-by: Codex:GPT-5.6
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> pass.
> ---
>  fs/exfat/iomap.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 190fc6471f84..24d93288a432 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>  		 * marks the exact boundary between valid data and
>  		 * holes (or unwritten space).
>  		 *
> -		 * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> -		 * and SEEK_DATA), we return IOMAP_HOLE. This allows
> -		 * iomap_seek_hole_iter() to directly return the
> -		 * precise byte position.
> -		 *
> -		 * For normal I/O paths (without IOMAP_REPORT) we
> -		 * return IOMAP_UNWRITTEN so the write path can
> -		 * distinguish it from a real hole.
> +		 * Allocated space beyond valid_size is not a hole. Report it
> +		 * as IOMAP_UNWRITTEN so iomap consumers that need physical
> +		 * extent identity, such as swap activation, can still use it.
> +		 * The iomap seek helpers already handle unwritten extents
> +		 * appropriately for SEEK_HOLE and SEEK_DATA.
>  		 */
>  		if (offset >= ei->valid_size) {
> -			iomap->type = flags & IOMAP_REPORT ?
> -				IOMAP_HOLE : IOMAP_UNWRITTEN;
> +			iomap->type = IOMAP_UNWRITTEN;

Assuming that the space between valid_size and i_size are allocated to
clusters and simply not yet written to, I think it's perfectly valid to
use IOMAP_UNWRITTEN here.  That's definitely not a hole.

If that assumption is correct then
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  		} else if (offset + iomap->length > ei->valid_size) {
>  			if (flags & IOMAP_REPORT) {
>  				/*
> -- 
> 2.50.1
> 
