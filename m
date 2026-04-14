Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F629CE9
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203618; cv=none; b=d0BS7yj1iDYRqAZ9p2M9+BP8Iph+Aa0Vz0TYYyD/1HNXqYbNl9/4on0B1bP9dFyU6fQm/jfoWd9/g955OIIwIk4RDnwm7F55X0fVhU4E3iyIe6u6fnf+UDtSaAPSJ5lv+Gq/v4yRjoBY2fTLl6ss6ovtwTM4vWOrviN6UBHLOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203618; c=relaxed/simple;
	bh=R5ggkSeqR6AH2+fVgqNMgj7I6U5KWytdXcdguc6IZr4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M3oIinCU8xubhorqenu5Lkg/MGJ7SEt8EgC0L2MkBcVT9pJjnnelAo1qgWSPNOxQs3JHlPqiq/YAr8U3xX2PIADAC0yUnpH+7m4XNbW8Bn6WXhf1y6fOSyuq3zj6FHebNSX+uHxx9oycG4wqjdUp8kkUUgTBDgf+g9IU/YR2bNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 1D66F1D45A;
	Tue, 14 Apr 2026 21:53:34 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id JNyIMF633mnGCgAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 14 Apr 2026 21:53:34 +0000
Message-ID: <a6fe6a13-f46f-453c-a56a-925dffaec825@dev.snart.me>
Date: Wed, 15 Apr 2026 06:53:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH v0 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20260414055643.1833401-1-dxdt@dev.snart.me>
 <20260414055643.1833401-3-dxdt@dev.snart.me>
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
In-Reply-To: <20260414055643.1833401-3-dxdt@dev.snart.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just self-reviewed the patches I submitted with a cool head and found
some obvious mistakes I made along with some comments I'd like to add.

On 4/14/26 14:56, David Timber wrote:
> @@ -301,48 +321,32 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  		brelse(bh);
>  	}
>  
> -	if (index >= 0xFFFF && utbl_checksum == chksum)
> +	if (index >= 0xFFFF && utbl_checksum == chksum) {
> +		/*
> +		 * is_default being set does not necessarily mean the contents are exact same as the
> +		 * upcase table loaded from the volume may be missing some entries. The checksum
> +		 * matching should be enough to cover that case.
> +		 */
> +		if (is_default && utbl_checksum == EXFAT_DEF_UTBL_CHKSUM) {
> +			exfat_free_upcase_ptable(upcase_table);
> +			kvfree(upcase_table);
> +		} else {
> +			sbi->vol_utbl = sbi->vol_utbl_own = upcase_table;
> +			exfat_info(sb, "using non-default upcase table (chksum: 0x%08x, entries: %u, memsize: %zu+)",
> +				   chksum, entries, upcase_table->cnt * EXFAT_UPTBL_PAGESIZE);
> +		}
> +
>  		return 0;
> +	}
>  
>  	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
>  		  index, chksum, utbl_checksum);
I think exfat_fs_error() should be used here so that the volume
continues to operate in rw mode to prevent further the damage. That's
what other implementations(FUSE and MS Windows) do. I just didn't dare
to change the behaviour without consulting the maintainers first.

>  int exfat_create_upcase_table(struct super_block *sb)
> @@ -357,6 +361,9 @@ int exfat_create_upcase_table(struct super_block *sb)
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct buffer_head *bh;
>  
> +	/* fallback to the default table on error */
> +	sbi->vol_utbl = &default_upcase_table;
> +
>  	clu.dir = sbi->root_dir;
>  	clu.flags = ALLOC_FAT_CHAIN;
>  
> @@ -384,20 +391,13 @@ int exfat_create_upcase_table(struct super_block *sb)
>  				num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
>  				ret = exfat_load_upcase_table(sb, sector, num_sectors,
>  					le32_to_cpu(ep->dentry.upcase.checksum));
> -			} else {
> +			} else
>  				exfat_fs_error(sb,
>  					       "bad upcase table size (0 bytes). Please run fsck");
> -				ret = -EINVAL;
ret goes uninitialised. Not sure why I removed that. Will reroll if the
patches get any attention. Again, exfat_fs_error() is used here so it
makes sense to set ret to zero so that the mouting process won't fail.

> +__u16 exfat_lookup_upcase_ptable(const struct exfat_upcase_ptable *ptbl,
> +		const __u16 index)
> +{
> +	const size_t page_idx = index / EXFAT_UPTBL_PAGESIZE;
> +	const size_t idx_in_page = index % EXFAT_UPTBL_PAGESIZE;
> +
> +	return ptbl->pages[page_idx] == NULL ? 0 : ptbl->pages[page_idx][idx_in_page];
> +}
I have a feeling that this function should be inline.

Regards,
Davo

