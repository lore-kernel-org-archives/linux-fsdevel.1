Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24893596F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863426; cv=none; b=RS1OLtCXZdW8YIx6IZl5Xw2EbJJsas3d8BEtlNj0fme961IPH0tA7BfDqGW41O3uNZdUyda+2wxLw5mxncLkmO30qrT06ZgphXeLGwyySNRfVVtsPZylO/w/IH9Yjknfwic25KY+/aef2w2jdPpBjpf4ccBKrqdNocXyPcbnCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863426; c=relaxed/simple;
	bh=4E2+mgnoT/O7gf1R4+xQjIqP6j0a3Jp5OE1RFcWGio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooTxCL7MNd5ZfdmijSrj7M+pPagAzoSfSOXF7FkEvu+txI55ORWnjMMe8f7Yox08ErcRN1Uh0/Mke5k1iSrj4TagiaUzdXRDQDh8tHvoLZRc0MrqRZkaWFxlbkxW496ISqgdN4JSkBgsJMA3YVVZ5OIxQ6k7BEBAReu71jTpSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz+2XbqE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz+2XbqE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so265641a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773863425; x=1774468225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Resi8n+oQ1vXGyEjFOBn4ZBz6ktHZ1vnUrgtEXoKXe8=;
        b=Dz+2XbqESJyUtSPtOhEVpUmtjfikkbMatpzTDEcTGQCm0jFZjQspE5oFsi790c7YPe
         hvocUm01ymkyYUl1xjbaxPLAcsHGNjZL1KzEuUq9V2Q+I3eEVXmbtvSOEood8Hy4lEUH
         z1JZqCoakAwWLvCwJF5svLSU7TcyZ8XLIzVMnyxyBjefJ0otnBQKtvvzdQrcYDbbrmr5
         FjOGqXW+tkwDsHwRgRrLZO2Iaphrlh9rn3SdcKqh/iSJRaC96yWuaGiVnILH8ey6x/5v
         U67cySGOHXJerhYeemq9lBTgnW9rc3f0IbpVu5yJvGPTFpRxTs/HWrzZzoy0n1wmvkuH
         HjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863425; x=1774468225;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Resi8n+oQ1vXGyEjFOBn4ZBz6ktHZ1vnUrgtEXoKXe8=;
        b=YMD1FZCsOEI0x55dgRv1rDZVEccUhjAb20J5bha+FugP03L2K777hIjH6Q9iWdu4xv
         Rzxpi2flBq6aIsKeFdGPP/Jmzs0JeqdOmytBpRvNAN7Tc5ih0s9CdTzWLeC0w/IKj+8C
         iwmplIc5tLFHuB6Aolo0ggh/Q58rFzM08mWQY5MaMSkxot60CqEGEjWwSCwGBG+fIOMq
         XnCFsVRegnwFS+behhUtDruYZASKiIXZfZQ0LODvACZfOga/DtodCPehE3qCLBEtnQ/o
         km00KpcKmuOb5ElTcDGFxULkACGNMelnRZXmKK7+km38dG8PjE2s6Z4YGc795GRxI6JU
         KnVw==
X-Forwarded-Encrypted: i=1; AJvYcCXIMdyeR1gJb4H6TzX7tfz7/TlgPj/aGuJQz2RgQ5bjTzLQw3Q3UmSc2hTnzyIQUOViiFnnFqwKXT8pY/fe@vger.kernel.org
X-Gm-Message-State: AOJu0YxUT3+h/VkNvMwv9pp+7EeaLzvIsdGu4/1nnokFikyJ0ew0gikG
	wb1VXa1fLouUaQ1DmbGREDlOJ1GccKy7qui9zxbHwgikURzyzjBr7q3K
X-Gm-Gg: ATEYQzyTYF2ch91fIGfI0ZChUlQL9LLcX30x1cEVzUtgWyEiUBS1vIGtXWVx0jMmimu
	5R+QN9KKRtBjkvxfs9dCVCao+BGSRRlYak6O0rmJnCVziaPuaL6SIlt3X4dynWosBcnTcZEy4VZ
	Utnny0MayormcWSjKjiCGi9GWjLSQyiqVGuBF1mv3vA7JgkQWUTEcEYoS388CmjSyl8GJKZdWIi
	73N3tNx3UzIxcwRF56hhGQko07YyqKqpwx0tt68UapXrBsS+c4ewyoO2KR7mWS1EZQme7Y/lFv3
	ibrL6KxRglwve+dCeE4SNFi7P5EesIQoXIjDJTunMS7NUN2ls9cBddklIPUC2AGtR+cE/oBcnMh
	DN+mE5h88LLqzuU8U8m+6WGzzdNkQLchD0svsB/Ai6K1iZBRJnWzQNcYUOJF1sQ+Pywfla5c+jO
	G01ZUiijjFyAVX7/kbyvGRULcQlUY9nI9tM+GuQOC4UgZZpKlJeYsRJ/pcpph81qyAdRGF7IfE1
	sn7kjyv/b0=
X-Received: by 2002:a17:90a:d604:b0:359:ff8a:ee5a with SMTP id 98e67ed59e1d1-35bb9e51090mr4450775a91.12.1773863424940;
        Wed, 18 Mar 2026 12:50:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc618be0fsm409804a91.0.2026.03.18.12.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 12:50:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cce7a4aa-0786-4c55-afcd-4816f977806a@roeck-us.net>
Date: Wed, 18 Mar 2026 12:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Justin Stitt <justinstitt@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-1-keescook@chromium.org>
 <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>
 <202603181132.507C829A9@keescook>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <202603181132.507C829A9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 11:33, Kees Cook wrote:
> On Mon, Mar 16, 2026 at 12:16:58PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sun, May 19, 2024 at 07:16:11PM -0700, Kees Cook wrote:
>>> Since bprm_stack_limits() operates with very limited side-effects, add
>>> it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
>>> file to include it.
>>>
>>> Tested on 64-bit UML:
>>> $ tools/testing/kunit/kunit.py run exec
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>> Cc: Justin Stitt <justinstitt@google.com>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> ---
>> ...
>>> +++ b/fs/exec.c
>> ...
>>> +	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
>>> +	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
>>                                                                     ^^^^^^
>>
>> Google's experimental AI review agent tagged the above change as syntactically wrong.
>> How does this even compile ?
> 
> Wow. I have no idea how this ever built either. I will get it fixed.
> 
I ended up writing a test program.

#define TESTVAL 10
...
long int x = TESTVAL / 4 * + sizeof(void *);

does build, as does

long int x = TESTVAL / 4 * - sizeof(void *);

or even

long int x = TESTVAL / 4 * 3 - - sizeof(void *);

long int x = TESTVAL / 4 * - - sizeof(void *);

It doesn't even have problems with

long int x = TESTVAL / 4 * - - + - + - sizeof(void *);

Weird. Looks like the compiler takes the "+" or "-" as sign value,
not as operator, and once can have as many of those as one desires.

Guenter

