Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227851FCA1;
	Mon,  7 Sep 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799437; cv=none; b=HMOJOCpgHZOzr2XftH9GB3Ryy+4+0DyLj4y8pq1UhCdnWUl1CS9OifIhzthekFYow45IVxi+48E4a2Nyjf2n3jXhSinhfAlW+GHlSqh06cakP9Yg6mnBxwP+NvaRItKwP0ndJcCRQNjSI7uCU4Xxm3HDvKHAsVmpQN62DWt14fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799437; c=relaxed/simple;
	bh=IfHy69F3LNBHuqhe6lfIEmqVttTdL9xWfYuaxgoZJ5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlCsnxXti7e4Gqtx+UzY3qyoAu7ly9Vge9ldvhk+wpw7B371E7SNaLeHmdr0ZfT7BMCBZAIUiXF+MRM/Kp921DjRlgLbkxzMzXzfTO+TQHMoHmpUmaXaM3BGn5jTgPCowPfOpQxyvX+BPBtKe0G6ZrteqhSBiskPFXeQh5XGLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=j2vLVAu8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="j2vLVAu8"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A072408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788799435; bh=K1QoYSkh0C9sSQm+kvMmLkOqIVg1cx7vAvkOyyyUjv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j2vLVAu8BUfrPUfw0IoMLttB9KWrQwcIEceYhLSk9uQ5Z0ckEPVfOfscBHEcW87ni
	 hmLInIrqLiwmZau8RpCopP0torx5zxcmYmnd8yNCifCDJ9w29pnYUhYWaLbp0pcmmI
	 K2EpC+wXJqbVWmqIDrNUlyN7cb+dQaEa6MBWRXOQDvNzkMu2svKs+2K1aRQnRpKccs
	 Bbt88ebw4fXNUuc5uDyjITojN/i8rhtRuLeabCSaYLpQLF1zP4BoWQ4u58OIZ/tQRo
	 JVnPV0O3/+B5SOZ8lZUwSg+I+zq3l/9klm1cKAo6XqVrn/6ohtHCdsYDF3+NSB07BI
	 bj19j/y/E5ZhA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6A072408FF;
	Mon,  7 Sep 2026 16:43:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebnerli@mailbox.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: locking: Fix bracket
In-Reply-To: <20260902143936.703665-4-manuelebnerli@mailbox.org>
References: <20260902143936.703665-4-manuelebnerli@mailbox.org>
Date: Mon, 07 Sep 2026 10:43:54 -0600
Message-ID: <87cxupovud.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebnerli@mailbox.org> writes:

> Remove needless '(' from code block.
>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> Should I also replace ')(' with ') (' as it is in the second code block?
> It would improve readability in my opinion.
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 844d65eb4..1598cf555 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -27,7 +27,7 @@ prototypes::
>  	int (*d_init)(struct dentry *);
>  	void (*d_release)(struct dentry *);
>  	void (*d_iput)(struct dentry *, struct inode *);
> -	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
> +	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
>  	struct vfsmount *(*d_automount)(struct path *path);

Applied, thanks.

jon
