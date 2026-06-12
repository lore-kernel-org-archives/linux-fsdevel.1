Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60171375AD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241870; cv=none; b=M1TTo08ULnHd2ERalCrILpQf6BpHMqY+OVAQJ2yg0qglgIVAUGaDGxeuPks7Lbveu/AzFHxAu5IEUlrwfULlcBuxIfATLfgDc4ctu0nYNNxl2tTQp5Ijszz70cMjQe+yMVXvSVdcnNbWHr7P542w7k7uJLfwE2PsYtyesk24npg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241870; c=relaxed/simple;
	bh=oBRQIp5mD+KYwRJ0IxD247fQdd97JK+yVjvu6IUmu4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=NthDQNDW7U9rwT2/ZBkMbF3NZwuvx9gwwOUopRvekIW+SqoXANEcLTJXZtuEXYWb59pYuxPbxaok5tc4qbJWJEU7yo90URLVdFuw0N15/3fLqejZLGVtAycSUMm3KHSdnFN19mXdrji3cNV0STftKAux/oS8nf+ssbwj/z2OTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VHDqTq9I; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VHDqTq9I"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so5531125e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 22:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781241868; x=1781846668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mY8Ko1A+P6AJEypWSmExtdmu6Mefh9vM6dtIhppSYs=;
        b=VHDqTq9IVXGDHXipbwIh1Zst3XocX0THTtSAW21C5r8Ay3Is+S3LnaXRKHuwnha6sw
         BadJTHKu7gSHqYSmq6f72XOgyhRrzkxVZ4z1+KVIzfDPoqDiCgBBlTn1Kop2QFYADxCQ
         90OchwTYC1zeOSkbS8PrB/qxdeQlfcZAnN8jx6I5GkOftVHSXlzbQoTxVfKBCpYOM+Bz
         GSzK60dkUQGU8m8TN0UNthgt4JFPpz5YYpgeUWdU83bjP6O39q8nGHNwevA9oI/ArAvr
         fmXmFX+DYEq0Kevs/KrB4e1c0dJlVy1uOCOqwVx+uCtwrcMQDFPLxYw5+l3gYQ+8vb/t
         kcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781241868; x=1781846668;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mY8Ko1A+P6AJEypWSmExtdmu6Mefh9vM6dtIhppSYs=;
        b=MzhP37gEVj69rON6rYtIdPeDeBYC9g1nr4W/fcG7e/XNJFd/JtYT2Ic1PWUWSgiVuk
         sSeSEhcszB40vXQGtv6Z4PWIGFiZ1g8hEENGAOPP/hvsF35GOCi6RhBX5DHVwE4qoJi/
         fuE02gguwFp5QuY8k9bfC9rT8HvOZCuCfUShgDlqhFNM0PXyrSi01XY4kfoOUiKlRuBu
         RwyMfY41qgK7/8FQxvtAjTtcav9Fg12MyKF5VWCR+x+TOX4KyTZQdBTXJGoXTJTGvUZr
         fVkAfdUZrSESiH+Wn1WDMSrDr9jRxjl/xwaUBIVFjD7zOyO/Hit6Z3rCMdcCE4BwN1I+
         u6bw==
X-Forwarded-Encrypted: i=1; AFNElJ8Un3Ev7pgS0N2Fgxo56bYnn+T9bZB6UDlNj40tq8cmRfyf+zibNNZINl11QC1em5tbMvaz9Xu9VBeS625F@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxf/w1FI7WyN7bmCohdW5dpf8WOlOkwacj0i7FAenEH3Shv5g
	r4b1Ev1rtnJ6j8Z+fmuj5gwa9z7n64vorgsaD8ffMgafVzegHchwGieLNI/PTKEndlY=
X-Gm-Gg: Acq92OH0XC8abXpWe+gqopCAjRWHAogpL2k00TtvPZRNWAHPkTJVo7cnZv0R7D7I7qE
	LSN8QWn++ApDO76L4pWfkKxqlDxzt8GTqwKsLp2a3jxoMFxMqnamNSsonDhjGp36ZbhvqIJ3riN
	FdEofw/T9U5Otyk3pFKqcJRr1AEETsFe0xIcmcP0iqM+s/oUnSnEgvZA/0OCzm/sAh7336AbYFy
	L7xv9XyyhZTGVXq0alJ40TfjLuEFJS8K4w7di5MgAYkjBaXWdQRkvF/HWiBoPxjUdWa8DUUUeOy
	jYZmqdOEreyse690rQg4VBi2kjonBVToMoiMWZbTkNTh1o0Q6DQwgaguqUeTuxWCOLRF+9rr+UI
	B2CLsMb23+3wFgPeLqijG8yt6FSFX0ZqgTIv9TpPdCHuc8YiLC67AxyYncgAVsz+iOSzTrS6Aab
	vLW+jcN2vHyOO8gEi0Ud6QvnyC9QRF+yyLh35LT+rgxz6z9XtwOHosGQW7qeFOaue8LGpV5w56G
	oOMdkzzmMPINca0cDJjUqMFhqTQFPeRkqrWECysWKEGeQ==
X-Received: by 2002:a05:600c:8b44:b0:490:b65f:8b1 with SMTP id 5b1f17b1804b1-490ec4992b5mr11700415e9.5.1781241867773;
        Thu, 11 Jun 2026 22:24:27 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433557c47sm6928115ad.79.2026.06.11.22.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 22:24:26 -0700 (PDT)
Message-ID: <f1dbdcd6-4e6e-4304-8fa5-59c2c60252ad@suse.com>
Date: Fri, 12 Jun 2026 14:54:22 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct IO page bouncing got some garbage?
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <b866b2e6-292f-4c5e-ae5a-d77e983cfefd@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <b866b2e6-292f-4c5e-ae5a-d77e983cfefd@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/6/12 11:11, Qu Wenruo 写道:
> Hi,
> 
> Recently I'm trying to make btrfs utilize IOMAP_DIO_BOUNCE, however I'm 
> experiencing weird data corruption.
> 
> During test case generic/708, I'm reliably hitting garbage pages at the 
> last 64KiB, the garbage even contains an ELF header.

Added ftrace shows that, since btrfs has to disable page fault to avoid 
certain deadlock, bio_iov_iter_bounced() failed with a short copy.

Initially bio_iov_iter_bounced() got a 1MiB page, but copy_iter_from() 
only copied 64K then failed due to the disabled page fault.

I don't think it's a coincident that the short 64K exactly matches where 
the garbage is (the last 64K).

I guess it's in the error path we didn't properly revert the iov iter?

> 
> In that test case, we mmap a 2MiB sized buffer from another file, and 
> use that 2MiB mmapped memory as buffer for direct IO, write into a 
> different file.
> 
> The source file has dirty page cache for that 2MiB range, and no 
> writeback happened during that direct IO write.
> 
> So it means as long as we fault in all the pages of that 2MiB buffer, we 
> should be able to copy them into the newly allocated folio, and submit a 
> bio using the bounced pages.
> 
> But the last 64KiB is reliably corrupted with some ELF header.
> 
> I'm wondering where the corruption is from, especially it seems btrfs 
> has very little to do, except calling fault_in_iov_readable() to fault 
> in all the pages.
> 
> Thanks,
> Qu

