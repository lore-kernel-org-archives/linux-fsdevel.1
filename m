Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899A3A875F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616251; cv=none; b=SrCq6VpBR6nMYGoCXffjTeIPp9dPhlUx3xyBqIPc/u4CchLYm/zfen5sDPyEPVUuQUFgmnas0en0vT3q0N2rkxXsvCxSeCO8hC4RA6q9LcYOz01Ndr88JfpXWwD/6oW4fqn43AcPYRO8/V4cm6So6Qs3V5LBESkFRmTBaVEkJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616251; c=relaxed/simple;
	bh=/hkOjn/leKAClt06K1k8dcGw0kKl6JVqrw3E17jd8L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuQ+e54XuQPEVETLbA6LeJ/XaTQjYqCKeWVsWIOB30rcdHtl4TXD8BWo5iGple9gEbIdgJjprMSE4H9+3D6izcpo9BtWuqmp1Kj/rKQeJGv7QRoHGErsLKvw9IguBJilrMjFD4dVLA7Au5kHjNpvTDzGXqufHuQ6sNwngj+mOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bPAZrPur; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bPAZrPur"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43587e63a8eso2043013fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778616249; x=1779221049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAPMktyvOhiuLY9Ol3xDpLg5ZIMwHSxD+pTIiS+Dfmk=;
        b=bPAZrPurMHnOmtjadFeQ3/bHrBK988B2OrvfeqFKxR2pvgAJLkQhqs9x5NnSloudCD
         3bTU+Xjmkgv7EpsY4rMUoA8nOJZqdIWLDf5/IDkwJ+M7PMp/YpuEkVT9HwsMYJ/GfOpA
         n8Dge7Xs2iPHVQo5e0nwvXDpb5HLYlMsDO8xOwuhvkmpNZlxbCT1Uu+MuMy/L3PzvQD5
         ooCZPYlIJ+/XxxZdeR41HM3A4UrLGsVZvW7WxDwnlXpLZzq7fXpnbk9ZIJCX8OOXqtxY
         K5FLjsID8uVOygDiC2Qjla16eRBjgC7asD7KiBdCLRE0K4X6bZ51UK1vgGhJYM7G0mm/
         wQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616249; x=1779221049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAPMktyvOhiuLY9Ol3xDpLg5ZIMwHSxD+pTIiS+Dfmk=;
        b=LWQSQXkdD7Uu7L+aR+8lKYkpGRiNlu26adLq0bgN9H/wCQyX7qebLJ7B+Bf72MWrvs
         +hIiqKB/xGG1nbRZdVUMLyF+P98pvBxnKGUO5F6JRZtYDvMEt28/r5xQworoMQejpta5
         Ass1A+Z9VzC6JClSzVLwEvS/0+GBiOlt5264QMY9hPkLJ3MYTrJwAbqVogrInAcHJcmZ
         nPzRSrBboB4CmtrgFwTlQPkkN2vGjSJABIrJJugn8EYIqhSDEGacJUKAoDhhgzY15EQN
         6WPBX1kHcjud35HRVRlMkOazO6sEoVwWFqg6Rwa3mcSvDoabxbVObWA27B11t6AqFlNY
         cD6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ePEKd70q0tEz6N1Z6VmJZjkEeNzjNo3dWq+WjyT9hQSexl6C/Frn0fkow5vOZ4CuD0xQ1DBuhenSJRwhk@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSuzSAxFfj27ZcjdmifA5RZAsEDdHFCQfqcI8KzXnf4UCR4OA
	dkHHtG2y/PdPpMbunfC9CdnxmO697cHIjjy+qXQHfk+J5vGba2QtcdQZbpgKwJyG8TA=
X-Gm-Gg: Acq92OGHyK84agj7o0+s85YvpP8gRYszjQwgOXatJ7J8IjgwW/lRnlcqaQg0wewCrMq
	jw925HwvfKyr2Dx+e9JlZhOgKjp5qJ8IQQa8ZNo1A9xHLkRyQ/1kdrv7qGOyvHPWjqtVmZkP9RL
	n2bmCEjC33r+R3He0syGYNQUCZFPFtr2yDJ5qfwmgoFFl0RYg+g7oLkAvy47a7iq0gUm11/bdb5
	V49BfDwqxHf3q2K7d4hdedFC6nqXHK4tWmxQVmnVfj2M+Q0P5/jw2t5LqZAsjxDmlBMfU06gTGD
	dm/NgbSCljwSK/L7RddgIHNE3U4KZd6i1fuiROEHcuUBii//rMyS/86DeO7QwkPbIHO7l9BdZJn
	kyvj80181GyH6x3khLL6ziNQ7xmeTs4qciI73b/eJ141uftskUL2REEQon05sluyj0h+2LRNfZx
	QFEsSuR7vMPsSkYa50i/2EWMcAxLBkSBhB/N3+ZzHnk2SdU9XGdANRrwvn6w7qP5dKl+/R+Q1kn
	jGd26ddryT+s5BgJZlW
X-Received: by 2002:a05:6870:d623:b0:423:9219:4c6 with SMTP id 586e51a60fabf-439ce12fb66mr120125fac.13.1778616249058;
        Tue, 12 May 2026 13:04:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439c1e0b5easm816013fac.3.2026.05.12.13.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:04:08 -0700 (PDT)
Message-ID: <dbd67425-5bd4-4d14-9b44-bc5252c1dbab@kernel.dk>
Date: Tue, 12 May 2026 14:04:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] io_uring/epoll: disallow adding an epoll file to an
 epoll context
To: Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260503085101.112698-1-axboe@kernel.dk>
 <20260503085101.112698-6-axboe@kernel.dk>
 <177861542131.846060.10743549776459529700.b4-review@b4>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <177861542131.846060.10743549776459529700.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 1:50 PM, Christian Brauner wrote:
> On Sun, 03 May 2026 02:49:16 -0600, Jens Axboe <axboe@kernel.dk> wrote:
>> diff --git a/io_uring/epoll.c b/io_uring/epoll.c
>> index 59cd4f009648..42057aab9124 100644
>> --- a/io_uring/epoll.c
>> +++ b/io_uring/epoll.c
>> @@ -62,6 +62,9 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
>>  	CLASS(fd, tf)(ie->fd);
>>  	if (fd_empty(tf))
>>  		return -EBADF;
>> +	/* disallow adding an epoll context to another epoll context */
>> +	if (ie->op == EPOLL_CTL_ADD && is_file_epoll(fd_file(tf)))
>> +		return -EINVAL;
> 
> This is the same pattern in epoll itself.
> Might be worth also adding a tiny helper for this that both codepaths
> can reuse.\

My preference would be to just open-code it, then it's immediately
obviously what it does. Unless you feel strongly about it?


-- 
Jens Axboe

