Received: from mail-qv2-f1.google.com (mail-qv2-f1.google.com [74.125.230.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC59472552
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322475; cv=none; b=PK5ogqwesYixSfryJ0uy7TH60y9rxfFcisrS4wkCIgZW6K6AIogrSiHx7+7QkCHXKq/6gWqIL+HWyw4pk7py5NoL6BWMoHUaNahfd9mrNrwCWAlYljO7EtR2Ivzhp9ahgtEu7fENAedufzU+ZkJsl2A/dZGZhiYoeB9ZC/JvNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322475; c=relaxed/simple;
	bh=5dZNZBYM5Zqvq5VYC89w2dXp5JVZGlmW/vvBEC/V4gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9nx27fajZRUwNsHR3hZ34AzxYRd1Wq00gNdyxFkZAYtZCPO25qJkWed7z/GSagpqzWH7RWBjA8R0Q0KcFNmJk/6I/LU3aJHXZogkOJJfOjPuMCl/iNuwyfoEkA0l9qi4xoBrr+Cg1pxzRpCDHkAFcvL0Fz0xtdBn68JVGk663A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vykiBsBC; arc=none smtp.client-ip=74.125.230.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vykiBsBC"
Received: by mail-qv2-f1.google.com with SMTP id 6a1803df08f44-8f3f86931afso2009176d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785322464; x=1785927264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=we7VYo6UQ9yJKk9ndegAj5yb3VOXk2NTtu8lueNDwdU=;
        b=vykiBsBCA5DrxJj7IHBiKwEFbr5f7D6Uv7EgGk89UQjyxCGVnwAEDJKX5NvaD0/CC4
         ss5GHA2znC35EOVjSZchGijSTt6AO2Vkbtqu8OrJjcPhHvdSNea1ls5/xV2vit8yK/z6
         AlipbAtNIoWoZgtL3dp2TCRhrSI2vJZtFB2kgvuPThmctwgidWo6zJhwPqVuq8aWfPeB
         LyFqf4IJZvcmwGek32krwKjKvVzgUjCcgkt/AaiQMNxBZju/EGzT9Xg3c0B94NcaL7ud
         GEy3W1f3avT/eHnkh0bc47n+HXM3Q9E3pFm+bFSEVGqhyMX5VV+zZEWjtVvxr62ZGzYa
         3Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322464; x=1785927264;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=we7VYo6UQ9yJKk9ndegAj5yb3VOXk2NTtu8lueNDwdU=;
        b=EGK6I2hhV17A/G82Cj891Y1gsgSQ6AqaH81oHBbyfd5t+UssazmX+H7pOAot1s5meH
         5yTVgvPKBIIFXz9dW3ptHmlBiUrtzLjmqStevRDRXikQ5iPSLzUL2e6KuoUUBbS7jQaN
         Y6EQIMpWpW27LDkjmYjr0GrhCjoGo52Z2BLNLiRftJZ07UffKFlhRSnY3LcGL/w1XyLt
         26V4wH7AAGxV1DSySd7k1M2bx4JrOcTVqg00aNhtNF/omgYCrD+Q2emNHZCpx2uZFKMl
         a6fBx3GHe6yi5uCb0rwDL3Zw3zWw6FBjHsjw9o6htgHTrtEYJT4Lif15z2fhMU8M+saM
         g3+g==
X-Gm-Message-State: AOJu0YxgO3iQ0m0vtr/u3JKwwvsoywgytdtOY+9w0gfCzsd61YyBMZ++
	y9cd0GtG+DxI1fTRXqQPYEUYFIBUnNRBD03PcjFZytA7x836w23kaTD/piyqWihgFdujCxUX3n1
	ZkGOkecJUCXgC
X-Gm-Gg: AR+sD10nHoipBft1cHa3SniIIEGuR4UoP1GsutzytO7dhk46Wvh1EcETkcSQdwKN3dc
	WIDmK0xlH7R4NEzpFmfO5kXLDDGcS2msQya7uVu/S/59+EaCpJyEQdbYgVZZTRDaO8emWcMW3li
	nqc+FEL3G+aWHq6rLlC3+Asv3+yfgD/GUCHqVtqPesiyBHQqxdXxkXfAVzqnLZlenNaP/Cm/kvu
	4WwmQriQVVVjGB3hbpGgkULlXBLIWDYFjmk0xw/0tJNZMDJH1o5oqKUijMEe7Y3Qeg8hDznpUSk
	KH/05ymboPpzhkFNpkBhHctuCcPw8qfcXDt6VFac7/6PbEK5AiXAhCHujcfYoSpX7ERse9ALt2z
	u9vKFzMFvWvtoXqVkGLaafCf+O4Yv4/02YoBOUy8j0kOb5hB5gaK+0izV2dIjC+weslxWrWNF62
	xi9sfuQGIYO25kxb0xqE9FBMLhyVUSr5U5CnYQz7LqJcaIl3omkFOLCq7HouwZR7Mu5bBahIV7F
	Q/HVUufqKwY6deIjqZlb0U7Urrvfhn2uFSKrT06vbPq66c=
X-Received: by 2002:a05:620a:6016:b0:930:8e2e:f3dc with SMTP id af79cd13be357-9330267968cmr533651685a.68.1785322464252;
        Wed, 29 Jul 2026 03:54:24 -0700 (PDT)
Received: from [172.20.6.160] ([50.234.234.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7366979sm140029785a.45.2026.07.29.03.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:54:23 -0700 (PDT)
Message-ID: <427b15c8-c168-4e2a-ac38-b00dc00400d3@kernel.dk>
Date: Wed, 29 Jul 2026 04:54:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an
 epoll context
To: Xi Ruoyao <xry111@xry111.site>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Juan_Jos=C3=A9?= <soyjuanarbol@gmail.com>
References: <20260514140817.623026-1-axboe@kernel.dk>
 <20260514140817.623026-7-axboe@kernel.dk>
 <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 7:29 PM, Xi Ruoyao wrote:
> On Thu, 2026-05-14 at 08:07 -0600, Jens Axboe wrote:
>> One of the nastier things about epoll is how it allows adding epoll
>> files to epoll contexts. This leads to all sorts of loop detection
>> code, and has been a source of issues in the past.
>>
>> Arguably adding IORING_EPOLL_CTL is a historical mistake on the
>> io_uring side, but we're kind of stuck with it now as it does seem
>> to be in use according to code searches. But we can at least minimize
>> the damage a bit and just disallow this part of epoll, where nesting
>> issues can arise.
> 
> libuv uses this ... thing and there's even a test case against
> exercising the code path adding an epoll file:
> 
> - https://github.com/libuv/libuv/commit/3b6a1a14caee
> - https://github.com/libuv/libuv/blob/09591002d38e/test/test-poll.c#L690
> 
> And the test triggers an abort on the EINVAL at
> https://github.com/libuv/libuv/blob/09591002d38e/src/unix/linux.c#L1360

Thanks, I'll take a look.

> I'm unsure what to do here.

I think it's pretty simple - if libuv is using nesting already, then
we will have to revert this single commit before 7.2 release.

-- 
Jens Axboe

