Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BC6BFCE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090446; cv=none; b=p0/nFj6wIvMg/mJ7H7bWrYQRAbA/1GrfacQK9ZBEAtoBmMYPwMXPzWN5sJxqfOg5JyvQKu1mmZjH5OrT1GACHjwNDADITBmTqKitF/zM4fbIL0SYLxC5R/V6gWVjl8PDfH/crMJ3BrbWqW/jPkQ094xzYmjEsQL+PbJofAYx860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090446; c=relaxed/simple;
	bh=nQiBa+LXrtmrw9NOUvUwDaiuDikfheuJ/pFICknAXqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ7JPJQweS9L7sWydHfxVZLRFfNhlwY+/rDmaGDbdFK1maLJlU/ORP6VSCw5vRkbgEDBSINy/Fq0X/p39WGMHJQOG3T9JEOmpUCngKuVcNVUG94S3ilUleyyZGaZOFPgjuYAPtfcO/wJcNK7p94owP12csc9A/4usXECSS2i6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=M76yKBBB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvaAFxHs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="M76yKBBB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvaAFxHs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9573C1D00211;
	Mon, 13 Apr 2026 10:27:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 10:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776090443; x=1776176843; bh=NJJRWB+Vp7
	NdNFnujWNcq3w0KC699ttcKfh7rKo++0M=; b=M76yKBBBEzkYT181myI+JgTnV/
	USbz+2kxDtSzFTY7UGwt2pJRBFDN1RbSbDAdcCE+6tL4hhNXuLezS4bOnpocUL9p
	XhgAc5iQoXCBxts+7dALLcqGMWErqZH+EXu38u/HiZcSPZNUSq4QnQFCAQhoLkCi
	7curkHDEK3/qGyV1kBWDpwfztiSW6uE/mHJ52mhUdd8NbC+jtPuTNwGH6/9Lp7Ui
	VpUQ2yz/S8dVUPbNzwRm/TYbWxfvii70xvGo78CLZjcuOkgRsJM/DUMpE3FV48uA
	C/VGd42VKlChE7S9c3rYltam7JYDFOdbTfqr7ADZHfoGS9uv603SuU527+LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776090443; x=1776176843; bh=NJJRWB+Vp7NdNFnujWNcq3w0KC699ttcKfh
	7rKo++0M=; b=jvaAFxHsJZ6kDJtyya8LU+yoKwDy5qXeqpjX3TetzjVHvHgkiVj
	l/X19ZEdkYASoK7UX6cErXbHmJIynze/UXUCl/j56vThpbEAdLDc+lcw4ROR2siA
	uhVGFFOem1YNzqdMWtoEWpAsVij0n0vWDFUeF852RdgB/XtqXJejtbMT24hMWupW
	5MObivVeLyL3Z4JJOFBneEWOSEoDGkQnwiYm/K3nDHaQT5BeSd1FtXyvrQaVCU1F
	hpzOYSNMf4eBjKEeoRejByffE2s95bOPLJh51VsviHA0jrSd67KWspcAW5asy13F
	B17b9wQywuyuBguJRqM9T1haE8My4hh/Fmw==
X-ME-Sender: <xms:S_3caSiI-826JmUEAXjkqXsf7ZoqwPlfcWB-oKM8NnPtvGHwbChhpA>
    <xme:S_3cacVYOskfiQtqlXAIH6jIZlpuDeGM-IojtMbP8KybsQuvjO4jUVKIrF3pUwM6j
    DE16OQRC4jufko1C16gZcQJyzKbl-l-Uld3yB1mrMHRhHeGdQ>
X-ME-Received: <xmr:S_3caRWZqisTcbo2Rnpb71u_zb9hlcwtWPS5WkOgp3cGmapROYL3VEq6-pmitpwRV8gmqznKlCV4fynvOLkotXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtd
    eufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsvggsrghsjhhoshhuvgekgeesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshgvtghurhhithihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S_3cacgquMH7gOCXr-hOxpBmhh4HSyVhNgOP4mdv2zCnxyj0FY-HRA>
    <xmx:S_3cacZdQuBeVvCdlbmDnbN2tayEhKjEBz391szLtB1KirkmOwR3tg>
    <xmx:S_3caZrV10Fa8cARFj2kNZy93Kh6R-9LDKJM9FGzV1xiplAApD3Ggw>
    <xmx:S_3caZMqClQzfgqCYnWWUXZgv4odPBv12vIheDjt03qRnYt2DPYjGw>
    <xmx:S_3caV5vZHGWlAbfPdUvr4pVDJJ02dwDHQINGh5Ck5VbKhY-oaGU8A-5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 10:27:22 -0400 (EDT)
Date: Mon, 13 Apr 2026 16:27:21 +0200
From: Greg KH <greg@kroah.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] jfs: fix missing bounds check in __jfs_setxattr()
Message-ID: <2026041358-enslave-childcare-695a@gregkh>
References: <20260413140328.173446-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413140328.173446-1-sebasjosue84@gmail.com>

On Mon, Apr 13, 2026 at 08:03:28AM -0600, Sebastian Alba Vives wrote:
> The loop in __jfs_setxattr() iterates over EA entries without validating
> that NEXT_EA(ea) stays within the ealist buffer. A crafted filesystem
> image with a manipulated EA valuelen field can cause NEXT_EA() to land
> inside the buffer but past the last valid entry, leading to out-of-bounds
> reads in the subsequent memcmp() call.
> 
> Fix this by adding the same bounds check already present in
> __jfs_getxattr() and jfs_listxattr().
> 
> Reported-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  fs/jfs/xattr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index 11d7f74d2..320659bb8 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -688,8 +688,14 @@ int __jfs_setxattr(tid_t tid, struct inode *inode, const char *name,
>  	new_size = sizeof (struct jfs_ea_list);
>  
>  	if (xattr_size) {
> -		for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist);
> +		struct jfs_ea *ealist_end = END_EALIST(ealist);
> +		for (ea = FIRST_EA(ealist); ea < ealist_end;
>  		     ea = NEXT_EA(ea)) {
> +			if (unlikely(ea + 1 > ealist_end) ||
> +			    unlikely(NEXT_EA(ea) > ealist_end)) {
> +				rc = -EUCLEAN;
> +				goto release;
> +			}
>  			if ((namelen == ea->namelen) &&
>  			    (memcmp(name, ea->name, namelen) == 0)) {
>  				found = 1;
> -- 
> 2.43.0
> 

Does the userspace fsck program catch this first?  That would prevent
this check from having to always be here, slowing down this operation.

thanks,

greg k-h
