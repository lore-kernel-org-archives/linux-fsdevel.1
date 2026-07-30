Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D9390986
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428602; cv=none; b=fISwislO+wAwt7w3gb7WaiD6fxcnZ7M3rPhtKkbwZPuvOyWoaixqG/LHZNGRSlK9O/5t2dHtQHdvGUVPQfT5nasVwgFkYFitWxWI+MCr/KB7Aj6sLVW3nA1gVZrUWDcS6/jr4RK46MgINhUYLWEi0o/dM1CN7Lx9oOIq+biQYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428602; c=relaxed/simple;
	bh=JBBl12W5jAO3f1NQO9V6kLXpVGsPmJIXGnmgZPy1WWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhGqGPDj9d0uTCT1XLVmONVf7pPAqwSYIbGh788HNeG/Fur2Mp3Lk4agVi832ZgSJ2lTA1+Pi+OiqNCPf8Z0g4jqKwz1Z0lQz40tDnBERbDcSOUWPuVgHwmCXSZngY/rwSxZJMp9jagwj7BRdpRrRTAetBlp4zOs6MaUwMEBw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bqGngMzM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bqGngMzM"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4560d6f82edso33860fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785428600; x=1786033400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2vuxkBUmVJ6H+F0FBU1KBLH+mojm8weuh8i8FR4JAI=;
        b=bqGngMzMyUQ/OuVng4Q+ZppdAfvq4yIOa2Vtd2msMFGVwTRmrVgMEEuFzcNudDjhBb
         XMZ9rnpN/ffA8Pi4JIASt4OQQ26UVlLSr5Nf6trhNRA4oKZzv5dT2XtfJrHf1NqwvKD7
         c6tvBzKrS0kWwOAjAAzaog8WAIlrhYO2eZd1Noa2VbTslRtkQisrS37haeVKX1vZT1KE
         oqUS1okTWt2sZo+nJfH+vVVPPF3o4bH+KQ4Ztb7+rt5SewWXJJ2+j9uz+z3I0SA+QItO
         gCW0nAfOcQf32HbrLJ+Dt1am4uYXbR7+IqIRjukw+3LGxmSubCGYjwghuOhdEOZgxjJN
         MRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428600; x=1786033400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2vuxkBUmVJ6H+F0FBU1KBLH+mojm8weuh8i8FR4JAI=;
        b=rRNp6xn9jmtKCwbJSK+8yaD/FZTExHXrmeyBBHISM2ovnGgDnOzQr9+wmVrd/drcPG
         /fuc+k8oq288uq8dwCeHCZ4jsKuvkOnHDhwCEg/0CX6+T0v+Uk5wUH3WFfYIc0Ft7olW
         k0eNUX445+0J9BmhlyCV0Lkxs6ZM5CfY8t24TUPAGDUBhbvvIpQuBaH7BStHiEWgeeZD
         d5RB4N6pve5P197JbXWJ2GHs9JeO7pTVjS/keUrZQDsih8N3Jzq4ULVkyhvshh1hQ02I
         DVRlEWHh9erMVCfGB/IJvhkSSALoGICZrdluedzeRymjWf9bBcKLMHeUUzfjn3vMrees
         J5jw==
X-Forwarded-Encrypted: i=1; AHgh+RoSRgMq9mkVIxcF+nk5KwnExBChm+0VSPgfReoY/2zMCcEtZhv0TSRl5hDwlnbqKqR8S6DeoGy5oXTPdAqM@vger.kernel.org
X-Gm-Message-State: AOJu0YwOABdfr6nQWSRfZXezistUWqmGa7kn/9M4wKZaTlBmKvXhqpt3
	bL20R8+YagoB43Cyan1ppl5c4PvAXyUniCRFuXvQH0tz/cebNp71Pa/5EQeK/OmnndI=
X-Gm-Gg: AR+sD11/3I/Csn+JlQW4GEQKnWzUEKACfV1aMQeYLmJGMh8RGsA7Th3o7sJz5UDkGT6
	2IOUSwkltPzxtGeooMtK4l3GDPqceVArh0/aSDdV4Yzd1HdL0ZmTxV+83zdMpcUJJi089cscqor
	ZTwKLj/lCNXnF1SInFwXzvTZFHv8J/BDX1HiqOupKl53HvtNztLbRcm7u8xXjoPj1W/i1lbXhy1
	Kn3h9Ea9nTPwLX0+wW7x4XpVesze1r5aDaEkECOyvJr4UA05UpmZx/u1TgfLWZPQ7z8NUAXdYL/
	t66mg/ECpK5h+lVSffA+JIQGbaS6eIeqJRmvjRTKi8CYzN/ab8q5ttcmo7RSb9xpM7q5se9g9Sy
	tZRFW6JcNl2o859mQn5eBbC2W9Ltra+kz4FHgXc8fyWsTNqT9SIbEVVGQCua3tWSBo1tVcL+nO0
	Qa1TFO2m69uOuC6KFqqrMej1Abfd6GRLnAjI0v9x99wPVFVLcfVEITZutFVtpbbvwqJITowa/dg
	GvG0+FgzFHvBuE7PwcS/+wRqBvyXSlsW/3voWac0onvHw==
X-Received: by 2002:a05:6808:1246:b0:4a4:e11c:7b56 with SMTP id 5614622812f47-4ad87782f6amr2123750b6e.8.1785428599570;
        Thu, 30 Jul 2026 09:23:19 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ef595cfsm4494333b6e.10.2026.07.30.09.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:23:18 -0700 (PDT)
Message-ID: <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
Date: Thu, 30 Jul 2026 10:23:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org,
 djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev,
 torvalds@linux-foundation.org
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
 <ampce7mxSmxAwAiu@kbusch-mbp> <20260730112626.GA24827@lst.de>
 <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 7:25 AM, Thorsten Leemhuis wrote:
> On 7/30/26 13:26, Christoph Hellwig wrote:
>> On Wed, Jul 29, 2026 at 02:03:07PM -0600, Keith Busch wrote:
>>>>> Hi Jens, have you had a chance to look at this one yet? This addresses
>>>>> previous issues with certain device mappers under direct io.
>>>>
>>>> I they look fine, but at this point we should toss them into 7.3. Yes
>>>> I know there are regressions around this, but from 6.1x days. And the
>>>> series doesn't apply to the current block-7.2 anyway.
>>>
>>> This series is kind of old at this point, but yes, it's not fixing a new
>>> regression either. I'm okay if this goes to the next window, and I will
>>> handle the stable follow-up.
>>
>> Honestly, I think that'a a reall bad idea.  This is a regression in 6.18,
>> and while it took a while for people to hit this with their a little
>> more complicated lvm/md setups, it has stopped real systems from being
>> used.  We need to fix this ASAP.
> Thx for this, as I had been thinking along the same lines already and
> was still considering if I wanted to speak up.
> 
> 6.18 still qualifies as recent in my book, but YMMV. And it's not like
> people "took forever to notice"[1], as they reported this for a while
> now -- and there were a few attempts to fix this; it just took us some
> time to see the full problem (@Keith: many thx for that and the fixes
> for them). And some of the linked reports are quite recent, so people
> really hit this.
> 
> Sure, as always there is the risk that this will cause other, bigger
> regressions. Maybe that's why it's one of those situations where the
> right approach is "submit this separately to Linus and let him decide",
> unless of course he speaks up here.

Sorry that's nonsense, because how is Linus going to make that call if
we can't. It's on us/me to make that call. We're not first-timers around
here, we've been around and know how to make the call that we can stand
by.

-- 
Jens Axboe
