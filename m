Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E03FFAD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542354; cv=none; b=eOA9fy5cXqMn7bQHp05uihjauMCe1XRwblGwTRa+AdMRfZGCZsNRoc/39NPWQBpC4wn6dTcMFyFARXRC+ceSBRxPtw6Z/PkbewWrzzAQsCkrU7FFcxTZpYf8oIUvpuwa1SvSYFoZcZ6Qw38Q2rc1S8unerCLER0MaXtgHKPi2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542354; c=relaxed/simple;
	bh=fPl7EXzoCCjFr1L/5UtjQ8xCMCNGzIid3G5/lD6EeR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST3dCuh4TGCFtasQTPgKiq4D54hLUVMk/NWtfWDv35BZH0ZAGbIX1lmEx1jD+DvgJgsg0Mm19DwWOYlQ2LununpZPBoYq5Zn9fIaYvnwz25gEEyqtQ9NGMl9W2NUZ/I2ThlB2QfRvbywM19+m/nFsQ37pBXiI5OC/tL4W61jxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 0E2771D459;
	Thu, 30 Apr 2026 09:45:49 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id LvPbKs0k82nu4gUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 30 Apr 2026 09:45:49 +0000
Message-ID: <79b70927-e766-4487-bbda-2481288a0f31@dev.snart.me>
Date: Thu, 30 Apr 2026 18:45:48 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-3-dxdt@dev.snart.me>
 <PUZPR04MB6316657C9EB764F8A3A119AB81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB6316657C9EB764F8A3A119AB81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/26 16:58, Yuezhang.Mo@sony.com wrote:
>> +static inline __u16 exfat_lookup_upcase_ptable(const struct exfat_upcase_ptable *ptbl,
>> +             const __u16 index)
>> +{
>> +     const size_t page_idx = index / EXFAT_UPTBL_PAGESIZE;
>> +     const size_t idx_in_page = index % EXFAT_UPTBL_PAGESIZE;
>> +
>> +     return ptbl->pages[page_idx] == NULL ? 0 : ptbl->pages[page_idx][idx_in_page];
>  
> How about this? Then we won't need to check it again in exfat_toupper().
>  
> return ptbl->pages[page_idx] == NULL ? index : ptbl->pages[page_idx][idx_in_page]; 

Zero(invalid character in exFAT spec) is used as identity within the
kernel. We'll have to be a bit careful. I'd have to change this logic in
exfat_load_upcase_table()

                ret = exfat_set_upcase_ptable(upcase_table, index, uni);
                if (ret) {
                    brelse(bh);
                    goto err;
                }

                def_upcase =
exfat_lookup_upcase_ptable(&default_upcase_table,
                                    index);
                is_default &= def_upcase == uni;

Some OOB data check will be ignored:

 - the character is "skipped": zero
 - the character is not skipped or specified as identity: non-zero

Subtle difference. If we change exfat_lookup_upcase_ptable() to return
identity on non-existent mapping, that information is lost, I think. But
again, the resulting contents would be the same regardless so I think
there isn't really a side effect.

>> +}
>> +
>> +void exfat_free_upcase_ptable(struct exfat_upcase_ptable *ptbl);
>> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,
>> +             const struct exfat_upcase_range_info *ri,
>> +             const size_t cnt);
>> +
>>  /* exfat/tables.c */
>>  /* Upcase table macro */
>> -#define EXFAT_NUM_UPCASE     (2918)
>> -#define EXFAT_UTBL_COUNT     (0x10000)
>> +#define EXFAT_DEF_UTBL_RI_COUNT      (112)
>> +#define EXFAT_DEF_UTBL_CHKSUM        (0xE619D30D)
>>  
>> -extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];
>> +extern const struct exfat_upcase_range_info exfat_def_utbl_ri[EXFAT_DEF_UTBL_RI_COUNT];
>  
> Is there a way to reduce the size of `exfat_def_utbl_ri` so that we
> can put it on the stack of `exfat_init_default_upcase_ptable()`?
>  
> If not, add `__initconst` for `exfat_def_utbl_ri`.
>  
Nah. It's as packed as it could get without breaking the alignment. We
could pack it down to 784 bytes, but that's still a lot of stack usage IMO.

>> +int exfat_init_default_upcase_ptable(void)
>  
> Add __init.
>  
>> +void exfat_free_default_upcase_ptable(void)
>  
> Add __exit.
Thanks.

>> @@ -896,6 +896,12 @@ static int __init init_exfat_fs(void)
>>  {
>>       int err;
>>  
>> +     err = exfat_init_default_upcase_ptable();
>> +     if (err) {
>> +             WARN_ON(err == -EINVAL);
>> +             return err;
>> +     }
>> +
>>       err = exfat_cache_init();
>>       if (err)
>>               return err;
>  
> Please add error handling to release default_upcase_ptable.
>  
>> +
>> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,
>> +             const struct exfat_upcase_range_info *ri,
>> +             const size_t cnt)
>                                                                                                                                                                                         
> This function is only called by exfat_init_default_upcase_ptable(),
> how about merge this function to it?
>  
default_upcase_ptable is already freed up before returning from
exfat_init_default_upcase_ptable() upon error. I made
exfat_populate_upcase_ptable() as a separate function to use it on my
test cases. The compiler inlines the function anyway(although
appropriate attributes are missing in the original patch, my bad) so
there's no ELF overhead either. I'd like to leave it as it is, if that's
okay.

