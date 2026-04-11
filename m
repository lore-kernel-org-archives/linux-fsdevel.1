Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4F213E7A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775950321; cv=none; b=WveR90JuDDMs/OYFDSP4WEdkvkFqBi9ly/iFi+UxThj9jgWi9RBP10EJWCTX+grV/RGaW9cer7mexpOyvUJX77ViYVgVsKP0leOU700cmQjznS+/hmwaeFpMJ67mu9baLBP2wRsljCWckgoN23qdo71FjjgXy7U0H0W/uq3efvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775950321; c=relaxed/simple;
	bh=OPENuhZKF4FqOkb4xugYCYMzr7FRkAvcGXkaRDIrZdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Al0ZQxcBoRQze+3oHaok1Vv0qW1YhiprH4RAIZELav0MD0YB3BvZ8L1bNTO/veFL6SzOW2W2e3epHW3R5YvDudaoehH/mjXdmJvwTZeLy5BF4HRh8wvPuocd5l09pYOLil6+WQ/rgnPJFQz6DpdgdDvKqFbzjrIt0/Xxq/4WPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id D1A14302F1;
	Sat, 11 Apr 2026 23:31:57 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id +r65IO3Z2mm5MgcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 11 Apr 2026 23:31:57 +0000
Message-ID: <445f5f1d-5468-472c-94e6-d0e52c32be7c@dev.snart.me>
Date: Sun, 12 Apr 2026 08:31:53 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: fix integer overflow in
 exfat_create_upcase_table()
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20260411224947.296754-1-dxdt@dev.snart.me>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260411224947.296754-1-dxdt@dev.snart.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On the second thought,

Most implementations also reject volumes with no upcase table at all and
fsck attempts to fix this. Linux kernel should do the same. Will reroll.

On 4/12/26 07:49, David Timber wrote:
> When the size of the upcase table is set to zero in the dentry for any
> reason(e.g. corrupted media or misbehaving device), an integer overflow
> causes the module to loop indefinitely.
>
> If the size of the upcase table is read zero, do not attempt to load the
> table. Instead, fallback to loading the default upcase table and raise
> exfat_fs_error() to mark the volume read-only. This is also the
> behaviour of MS Windows.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  fs/exfat/nls.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 57db08a5271c..fe5230cae377 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -769,13 +769,18 @@ int exfat_create_upcase_table(struct super_block *sb)
>  
>  			tbl_clu  = le32_to_cpu(ep->dentry.upcase.start_clu);
>  			tbl_size = le64_to_cpu(ep->dentry.upcase.size);
> -
> -			sector = exfat_cluster_to_sector(sbi, tbl_clu);
> -			num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
> -			ret = exfat_load_upcase_table(sb, sector, num_sectors,
> -				le32_to_cpu(ep->dentry.upcase.checksum));
> -
> +			if (tbl_size) {
> +				sector = exfat_cluster_to_sector(sbi, tbl_clu);
> +				num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
> +				ret = exfat_load_upcase_table(sb, sector, num_sectors,
> +					le32_to_cpu(ep->dentry.upcase.checksum));
> +			} else {
> +				exfat_fs_error(sb,
> +					       "bad upcase table size (0 bytes). Please run fsck");
> +				ret = -EINVAL;
> +			}
>  			brelse(bh);
> +
>  			if (ret && ret != -EIO) {
>  				/* free memory from exfat_load_upcase_table call */
>  				exfat_free_upcase_table(sbi);

