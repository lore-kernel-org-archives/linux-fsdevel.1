Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2253002C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451747; cv=none; b=TY40Ev1SGKD6QW3TOT0hSPvoSyjj9NP9pzed/F6l/n0BTfZNGo/q+6YlwIJfUw6b7a3IIIHxOnfuCGNU18E3eUfGVwNnATM0NC2hfHhH/SWeM5jkbShXd++IVjGKjI9Ru9WPcG89uBptm6taClnhBDuc8H9stjJtZaMndsberww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451747; c=relaxed/simple;
	bh=jJ29MiwE6oYt074UrJS+WLoi4vAZeVDIjaa8yBio1TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBNJQdd0ekUw93B9LjVIE9xwQ1Q+J/xlsTDd/4BQv85uucW/aQfLEAmiMyMGh4+9c8tWfZ8CtEhhegS8FB+G8Hgl7SrHnX4REARyfGKqMcbFlHo0wh7P9sW1j2lZeAk8/kOmMU8tuuD52ArFLl+nffFzgjo3u5lR4XeRPo7oZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 8FB6F1D490;
	Sun, 10 May 2026 22:22:17 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id o/FeERkFAWrALwMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 10 May 2026 22:22:17 +0000
Message-ID: <258feba8-a4fd-4c31-9553-691ab375858b@dev.snart.me>
Date: Mon, 11 May 2026 07:22:13 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-2-dxdt@dev.snart.me>
 <PUZPR04MB6316AD038BC864209E256243813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB6316AD038BC864209E256243813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 21:03, Yuezhang.Mo@sony.com wrote:
>> + * To maintain interoperability, these errors are not corrected.
>> + */
>> +static const struct exfat_upcase_range_info def_utbl_ri[] __initconst = {
>> +       /* ASCII */
>> +       {
>> +               /* (index = 0, len = 26) */
>> +               .start = 0x0061,
>> +               .end   = 0x007B,
>> +               .value = 0x0041,
>> +               .inc   = 0x0001,
>> +       },
> How about changing to this style? the table looks too long.
>
> /*     start   end     value      inc */
> /* ASCII */
> [0] = {0x0061, 0x007B, 0x0041, 0x0001}, /* 26 characters */
>
> And 'len' in the comments is not very meaningful, the comments indicate
> how many characters need to be converted more appropriately.
Agreed. Will change the procuder program.

>> @@ -896,6 +898,12 @@ static int __init init_exfat_fs(void)
>>  {
>>         int err;
>>
>> +       err = exfat_populate_upcase_ptable(&exfat_def_upcase_ptable);
>> +       if (err) {
>> +               WARN_ON(err == -EINVAL);
>> +               return err;
>> +       }
>> +
>>         err = exfat_cache_init();
>>         if (err)
>>                 return err;
>>
> As I said before, we should call exfat_free_upcase_ptable() if
> exfat_cache_init() return an error.
This is frustrating. Yes, this is skill issues on my end, but it makes
me wonder why we can't just have only two return points(success and bail).

Whilst trying to hunt down the kernel memory corruption error in f2fs,
I've witness the horrors in the fill_super() as well. Why complicate
things by having too many goto labels?

https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions

I think this generally comes from the coding guidelines that mixes up
goto and return statements for clean ups. Sure, it makes sense if this
is the function that gets called millions of times in like skb a
handling callback, where avoiding a couple of no-op calls actually
matters. In this case, I fail to see if doing something like this can
hurt anything as long as we're careful with the order of resources being
freed:

    static int __init init_exfat_fs(void)
    {
    	int err;

    	err = exfat_populate_upcase_ptable(&exfat_def_upcase_ptable);
    	if (err) {
    		WARN_ON(err == -EINVAL);
    		goto bail;
    	}

    	err = exfat_cache_init();
    	if (err)
    		goto bail;

    	exfat_inode_cachep = kmem_cache_create("exfat_inode_cache",
    			sizeof(struct exfat_inode_info),
    			0, SLAB_RECLAIM_ACCOUNT,
    			exfat_inode_init_once);
    	if (!exfat_inode_cachep) {
    		err = -ENOMEM;
    		goto bail;
    	}

    	err = register_filesystem(&exfat_fs_type);
    	if (err)
    		goto bail;

    	return 0;

    bail:
    	kmem_cache_destroy(exfat_inode_cachep);
    	exfat_cache_shutdown();
    	exfat_free_upcase_ptable(&exfat_def_upcase_ptable);

    	return err;
    }

>> @@ -691,53 +330,36 @@ static int exfat_load_upcase_table(struct super_block *sb,
>>                 brelse(bh);
>>         }
>>
>> -       if (index >= 0xFFFF && utbl_checksum == chksum)
>> +       if (index >= 0xFFFF && utbl_checksum == chksum) {
>> +               /*
>> +                * is_default being set does not necessarily mean the contents are exact same as the
>> +                * upcase table loaded from the volume may be missing some entries. The checksum
>> +                * matching should be enough to cover that case.
>> +                */
>> +               if (is_default && utbl_checksum == EXFAT_DEF_UTBL_CHKSUM) {
>> +                       exfat_free_upcase_ptable(upcase_table);
>> +                       kvfree(upcase_table);
>>
> If the default upcase table is used, 874 entries will be set.
>
> We can determine whether the default upcase table is being used, rather
> than checksum, by checking `is_default` and the number of entries.
>
Hmmm.. I can read between the lines. I get what you're saying.

I have to admit, I realise now that the idea of `is_default` was rather
stupid. Even with the algorithm you suggested, I've found that there are
some corner cases that would have been missed.

The look up op will definitely add a few milliseconds to the mounting
process. Let's not do that.

The thing is, we're probably giving too much love to the codepath that
will (probably) never be executed in production. No sane formatter will
ever use non-default table. We can even assume that volumes with
non-default upcase tables are probably with malicious intent. I have no
real-world data, though. If anyone can prove that there is indeed an
exfat formatting util that uses non-default upcase table, I'd like to be
enlightened, please.

Anyway, we're stuck with the specs and so we have to do our best to find
the common ground. How about removing `is_default` and just checking
`utbl_checksum == EXFAT_DEF_UTBL_CHKSUM` for non-default fallback? That
should be more than enough. I don't think other implementations actually
bother to use the upcase table in the first place.

Anyway, my patches will have to wait whilst Jeon is trying hard to get
iomap settled down in the mainline. In the mean time, I will continue to
contribute from userland as much as possible.

Regards,
Davo
