Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53C4C10CB;
	Wed, 30 Sep 2026 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806409; cv=none; b=RejzxbDAeWGA7+d9Pe3am0HoHrBhModekqyGsVoJGm4QaYWyfU03IWyB1qv0xfuqbArsH0rW26qmmGXtROJsEu6GBVKdVrVWcC4qAW4vfQnzp0LJ6FHMul6SUUwRM6Ge6zYkJ2I47pAfE7GG/nBQukdz9YfzxCQDyYl/wvfULCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806409; c=relaxed/simple;
	bh=H5MoRmHSaLRsXC52UU2mD+TatThdxATNiPuEY65udqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFlLyfz0ZtoEJbsS+IerKOZ1/kAUpSR8RHFu9+AO9jzi+fTfDE/7pdGPTotoEory63Ni61iJsWX/yE8G1UdgD05ObgzzyTmjfDNns7i2TakvJ0WE4EqdFg0iIdON1MY5CvR9YVsBfX/J6ctrI94AlsgrdPCwKqEZFuvp3YTcc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dBhcHm3F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dBhcHm3F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BdbVuBvMWSI8KSpMOh9N2WUjj/r1xBVOXwSfE7M3KZc=; b=dBhcHm3Fb+xsCTSctXBQ22A3zV
	AnXwqFRZjHb5/nHev99oNrmzMr9BndC4uElCnkBkhC3S4I5EN2fipQnGUw2fUWhLSPMIvVQ1V6JmK
	H5z3/1xfJ+sHvXRiJZ2s1cnBJPHppqyiL7bTfIfmzEI/gWcdUh1f4hPn5DlpDr+Y6WPbJwrZchdw+
	1uy3kvNaGAJDnAR22LjyO4PhUgoSq31vzRXhokF7LFJmNY5jZ6CwIvESClyPrXfkI++wnKKEqpp1/
	XBKAe6Gzkx/lXVQ4DQcFx7BwBo2rMUb1uQkgtZpu3Jku/fcrl4otXcHmt68V0frA6na6CSVqV+3Dj
	S5tGvk4g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC2YG-00000007Lsl-329O;
	Wed, 30 Sep 2026 22:13:24 +0000
Message-ID: <2643a46a-d23c-4d47-a1f8-1fe8cd641b88@infradead.org>
Date: Wed, 30 Sep 2026 15:13:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VFS: d_duplicate: repair comments to avoid kernel-doc
 warnings
To: linux-kernel@vger.kernel.org
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20260928211000.1539250-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260928211000.1539250-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I need to send a v2 of this patch...
Please do not apply this one.

On 9/28/26 2:10 PM, Randy Dunlap wrote:
> Use a typical list style for comments to prevent kernel-doc warnings:
> 
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Also, modify the spelling of "whiteout" to match all other uses in
> the kernel source tree and to be consistent on the same line.
> 
> Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: NeilBrown <neil@brown.name>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> 
>  fs/dcache.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- linux-next-20260928.orig/fs/dcache.c
> +++ linux-next-20260928/fs/dcache.c
> @@ -2025,10 +2025,11 @@ EXPORT_SYMBOL(d_alloc);
>   * @dentry: the dentry to duplicate
>   *
>   * Some rename operations need to be combined with another operation
> - * inside the filesystem.
> - * 1/ A cluster filesystem when renaming to an in-use file might need to
> + * inside the filesystem::
> + *
> + * 1. A cluster filesystem when renaming to an in-use file might need to
>   *   first "silly-rename" that target out of the way before the main rename
> - * 2/ A filesystem that supports white-out might want to create a whiteout
> + * 2. A filesystem that supports whiteout might want to create a whiteout
>   *   in place of the file being moved.
>   *
>   * For this they need two dentries which temporarily have the same name,

-- 
~Randy

