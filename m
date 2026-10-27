Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.252.183.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088096;
	b=yHsI6NWqxxxT/qE7M+g4BfA7OCM/9ZeaOzUEXZFAiwlMSff3RgVpsRoWeE7DkHpsASFq
	 xNPyP+1hlqdMiM1KSjkIBGr5CdMLGd1AfNGi/Hi9NKtWejluLg2CV8IbvHiiV5ysx1XCX
	 uT26Fj+h/jOyo0ex5WXRj9R7575oSxDcPC/m1PgCOyNhXZpV3GI0NDJRUCkuCidwb8A/2
	 zyyOrYUa007jnTw+L8eEIjnj/IwGSw09PwGod5o33RZFwzz3+Hua003uALU1dyI85CLjU
	 UuLZ/Sxp/at7CneiekMDdMEhndtdfy0fczSU22QGVMDVi/1CyYIZyYqhO7eZMzwDx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088096;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yEqYGkXZi67x4sSyN+vFHXVMBIT26852rftcWPOZ8mo=;
	b=mPHlnY2DIVofyqM6MCoVK0Gbfb8sgkfLn1fyNymyUQn8Bv8/CDWQ5DqUnuCXxJ7hnd1C
	 eKx2CPRAxFAa3EaJvwhVqHdWdn5+KxmVaoVkX+NHBh4KouEiev0E/EnsrTBG1j7z9UHn/
	 LPMn9CLdm0194zpc+vsZROJAIHwkOlyAmUAP8OPuylhQ7vzEhM5sr7zfzQ6UzWJlHOt7m
	 rg6ArpqaA/kieF5oI51tf/hwabmrZdugvpfcLNqiixDFbYxvn+Eu+pUNudpu7Gn7c0slj
	 Fd9DhlsNGF3/PaznyGPm7qLwJLdN48iy21hZHl7UP2tB259jgMOWl28CZop+qkq9+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.snart.me;
	spf=pass smtp.mailfrom=dev.snart.me;
	dkim=pass header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=QSBVbELm;
	arc=none smtp.remote-ip=54.252.183.203
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A7606A31A;
	Tue, 27 Oct 2026 08:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF7A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=QSBVbELm
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 689041D485;
	Tue, 27 Oct 2026 08:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 689041D485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1793088089; bh=hweRCmgmyMvzsrva+8h8cHB/+12rDDcY42HGJsfnMHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QSBVbELmUEy26YuTnLmcEvcSr8vQKP8wrRT0YpTX3teCBerKlCaBiuuTPNwCEUCrW
	 cM3jfd4pEz9qLOyQaHlujil8LsL6louZXVsM0i9+RYZcaO5ZMhdxg62B6VRGjVQsV3
	 aJROhzAXhPqTI8jyPQkKjOfIoKP7eWK36xp+lPCo=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id l1tEB1ha4GqObwEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 27 Oct 2026 08:01:28 +0000
Message-ID: <99e3060d-10aa-4407-ab1c-43b7200ef76c@dev.snart.me>
Date: Tue, 27 Oct 2026 08:01:26 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: fix upcase table validation to require all entries
 consumed
To: Reid Downing <skibletz@gmail.com>, linkinjeon@kernel.org,
 sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261025122639.1173247-1-skibletz@gmail.com>
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
In-Reply-To: <20261025122639.1173247-1-skibletz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/25/26 12:26, Reid Downing wrote:
> exfat_load_upcase_table() and exfat_load_default_upcase_table()
> accept the table when index >= 0xFFFF, but a correct table must
> process all 0x10000 entries, leaving index at 0x10000.
>
> a crafted filesystem image can use the compressed skip encoding
> to advance index to exactly 0xFFFF without filling the remaining
> entries. the checksum covers only the on-disk bytes so it can be
> made to match. the kernel accepts the table while the unfilled
> entries silently remain zero, causing incorrect uppercase mappings
> for the affected codepoints and breaking case-insensitive filename
> comparison for non-ascii characters.
>
> fix both checks to require index >= UTBL_COUNT.
>
> Fixes: 370e812b3ec1 ("exfat: add nls operations")
> Signed-off-by: Reid Downing <skibletz@gmail.com>
> ---
>  fs/exfat/nls.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 055447edc..7afc86ea2 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -691,7 +691,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  		brelse(bh);
>  	}
>  
> -	if (index >= 0xFFFF && utbl_checksum == chksum)
> +	if (index >= UTBL_COUNT && utbl_checksum == chksum)
>  		return 0;
>  
>  	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
> @@ -728,7 +728,7 @@ static int exfat_load_default_upcase_table(struct super_block *sb)
>  		}
>  	}
>  
> -	if (index >= 0xFFFF)
> +	if (index >= UTBL_COUNT)
>  		return 0;
>  
>  	/* FATAL error: default upcase table has error */
Please see the following unmerged patch:

https://lore.kernel.org/linux-fsdevel/20260414055643.1833401-5-dxdt@dev.snart.me/

How about

    index == UTBL_COUNT

This is more of a compatibility issue than a security issue. A bit rot
in the storage hardware can definitely cause benign corruption. I've
observed that EXFAT.sys(the Windows implementation) strictly expects the
table to end exactly with 0x1000.

Also, expect the size of the table aligned to 2 bytes, as per my
original patch. You're more than welcome to cc me in the commit message.
I was just too busy to get back working on my patches.

Thanks,
Davo
