Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4003D3334
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497744; cv=none; b=LMUsJZTUoyxVDyqaPYRe8Lh7DaQt6MRxeVG1O80enU9nNQn4fMoODpIJIQsKus15QlB7kysW2TPVeVr5GIgHk6goqMk3bAACY2611fPYD3Mt2KAbN4jRL/mD8XUixDMjoTowGlQtumgRA/OR6aecYD9nWcN8pyt/9SstiPR3glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497744; c=relaxed/simple;
	bh=OwudPr73DAJCjxaxsN+DSJi0a641ZpHc6NY2gugeNqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmnk2Cxnkafve/ef/6bx5IPZy4ZSNHKWTquyRK0VjeJ+A3Y74NchZPqL864EOMMqIpu/D9Q8Bka9k2plYwTlyyvlcX/SN1TgYsh5inSm9PE4krOkgc3zAcqRnBZCT/JmJ3Ukd4hXiJkscK6cj7rmqjfYRnB0r8wKwrYL2QmnNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfhVZSRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfhVZSRL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 822391F00893;
	Wed,  3 Jun 2026 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497743;
	bh=RrQSqnhiluvTyE9cfRyuPBjsEWdn+UhTghU3Y2uFfww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NfhVZSRLzvC9Ceg3M719Jp71oF16DhuSj4L1zc7lXwLcNU4sOhoQaiJBqxORRw2eY
	 v8Gvz2Bz/e02Gf9wamgqdaWRk+jL8IZOUHRpjfX+Mht6exYQ4l5NVaMmNJ19E0NEJN
	 zW01oBqKqbN1PUI24ehR5yIa1WbyZURZatujgaeKkIxkB6sH6HS6ot6ZuuU9e9rOmk
	 MGkYSbXtbAeiV6wd+15FpgXdEZbTFk7oqQnG4XdNH3yQh52S7KP/qkyrUDATkMNTiO
	 9gdrX0yjO1Lfg6SQslKoucyhknPsIbYYZVWPVOuPU5zUDp+5iHPra3b9xIR0Nrmb2B
	 AEjL4TXFnyAVQ==
Date: Wed, 3 Jun 2026 07:42:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings
Message-ID: <20260603144222.GC6095@frogsfrogsfrogs>
References: <20260603144031.7370-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603144031.7370-1-linkinjeon@kernel.org>

On Wed, Jun 03, 2026 at 11:40:31PM +0900, Namjae Jeon wrote:
> Add IOMAP_F_ZERO_TAIL to the flag string mapping in iomap trace
> events. This allows the new flag to be properly displayed in
> ftrace output when iomap operations use it.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/trace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 097773c6db80..93b3fa12de17 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -118,7 +118,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
>  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
>  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> -	{ IOMAP_F_STALE,	"STALE" }
> +	{ IOMAP_F_STALE,	"STALE" }, \
> +	{ IOMAP_F_ZERO_TAIL,	"ZERO TAIL" }
>  
>  
>  #define IOMAP_DIO_STRINGS \
> -- 
> 2.34.1
> 
