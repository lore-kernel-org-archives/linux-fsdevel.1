Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982832;
	b=OyiZ/3X79vnfcVDnk3b3kip1KQcccrQpwUyubDI7tKC8m9u8VnWTJKWY51qrBZmI4Klm
	 QkNkPGK7k9/eiVXVnb2Q4asSN6Q3UX9iP/Ul8X9P+1TFj76t9Q7vyiu5cPAfyODTJYanw
	 S9p7BEKPcxoAqVYC/41RHs6LbTPm1LUbjt2aMJyTXJU3Jp6IpozEPRMPbsJqQn4rjv43S
	 Ri8TyVrIMPtgjUqAKx617+2FK+Lfpk0a5zng5IM/+sGDgvHjeOPe+pb/O7CKs5z/wwtjW
	 5nXi1oJ4v4OCb3cCmNZhGm8l7qoiXzP4ez+qT+jvzbrcWqJab0zsWR08ZdCxtn5Ra8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982832;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=3FWvqrwUnd07WEOtSjed6AormaQ9P6ck1uP67T2QHyg=;
	b=BEGdVRstz8GE4FyWjZLSNK8iacToEXAQq0GQxtP8g5g1or/e28F5rB4IflrIx4fmQxTv
	 B+2iVN2UQQSGtKyFnnNWezJjWGa2gDZBxKuW+EMa+8R6U0cksUXMIQGC+VK8PBVF6dyST
	 A9UX8CjCqlegC/Hqm2PkG+NRfoSz8d/9G8vqU6QtOMGtB+WlhjWLFSgr4TeoSK0bVUaTw
	 PYx9WFgrDWW2YEWMb9UvQm6FRUknb5ZtFicPNC4tyNusqzbZXEHUY7Ke2c/7opN+aodzM
	 Q6LY/kY4oT0tIkYbYaOrUVVhTMb5x4KKmj6pwGBpJSRognTS89oH+LETcmk7OrD90UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=c5XcGtxQ;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA793606A89B;
	Wed, 18 Nov 2026 06:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA793606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=c5XcGtxQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3FWvqrwUnd07WEOtSjed6AormaQ9P6ck1uP67T2QHyg=; b=c5XcGtxQp2V1R0iEAitc0IZF6M
	9FRVdb8Uaf4Wp/vZiCAxYPn+Li8wAaabse5LGj4g0b+grr6exRUfB9oQD+GiZMnXmtvlv0skK4pqx
	suOUBtLfSPX7YX3mF9m9O4tTq1kQen1EMq+1FWtQFEJePqa+p51b5kjjkEnNN/HMpksXFoeeac4VT
	d+p9gBr69DOFrQbaIJd8T+2lcfqBBPVpdUOJkS8iKkeUOjkdV6Dx2JHcSKIgjOrW5ig8qBDUZc3Vh
	kBghJsZYk/dLdGsCln7hB9KW/v+g9PqOVi2bTvNwPjrLiJHw5yTqcUqCGcvHKkPHbiewYibt+qKr+
	OvXKDSYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZ1w-0000000FaS1-3AA4;
	Wed, 18 Nov 2026 06:20:28 +0000
Date: Wed, 18 Nov 2026 06:20:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: mdshahid03@gmail.com
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: sync: fix overflow check in sync_file_range()
Message-ID: <20261118062028.GS989762@ZenIV>
References: <20261118023452.48090-1-mdshahid03@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118023452.48090-1-mdshahid03@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 18, 2026 at 08:04:52AM +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> The addition of offset and nbytes can overflow before the result
> is checked.
> 
> Use check_add_overflow() to detect the overflow safely during
> addition.

"Safely" as in "doesn't rely upon the -fno-strict-overflow we
have in CFLAGS"?

> @@ -233,11 +234,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  	if (flags & ~VALID_FLAGS)
>  		goto out;
>  
> -	endbyte = offset + nbytes;
> +	if (offset < 0)
> +		goto out;
>  
> -	if ((s64)offset < 0)
> +	if (check_add_overflow(offset, nbytes, &endbyte))
>  		goto out;
> -	if ((s64)endbyte < 0)
> +
> +	if (endbyte < 0)
>  		goto out;
>  	if (endbyte < offset)
>  		goto out;

Why do you keep the old overflow check after having added that thing?
If sum of two non-negative long long values does *not* wrap around,
it will never be below either of summands; that's what the last check
had always been about.  I'm not saying that it's worse off with
the use of check_add_overflow(), but mixing it with the old overflow
check is very confusing...
