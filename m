Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706944C4F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428541; cv=none; b=rVB1tAtTYG4/EblZkkNQ9tl0NB8QHK0cNBg1FP9CMdS5YfvDrb2UtBC4JXWKqRbIZEqJ0cow2/dPxBOQE2nNW0Hy5ghi7g6Ea2rcjiaMVikHF9pG77LrjfKxj16scRi7oLp33X+SQSw3xFbdfFptMmbpeDTt7mnLjmVHMZfjprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428541; c=relaxed/simple;
	bh=LzrA83SNg0xwZHckZyesHpd9prkk7E8+AsPKLw0gsqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD8xttqtWhlDzYmk8V3i+0sJpPU1UvVmcKpAPgihbXpD5Glrbi8GEBOsPz2Qg7UtQYQSLp81OdlAHXmo72aIOKmrv09VIr0GCdTAxN5srTU1YWP/HG+BYrM3iAt5Otyv4Xre8kcmmJHAMDSezSKIoH9K01JwYCRrEFvyfSzRPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BGH7Flfc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BGH7Flfc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-458de93b53fso31251fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785428538; x=1786033338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TO7rhJEb0t2mz700nvgDIByTqbVS2Yz6f37I4sh7O8=;
        b=BGH7FlfcbOvegIPbdSDyqXgjaiAYZcJO2cLiIFkujKg3lO2MakP06pbodxSiu9wx9w
         UeglvZjGhS4N7TOOaWh78vcYzMVwYpdBdYBlnL+syvrSMoYJHjAFpPHML+b5+siBHggR
         38wgCNPwuNNZj1Y31bUuVb2SBuNir6tbslxyLcKDaWcWtmzhPwq6FYluSO7TNAWH5LVU
         4osnY03JcoBYxasXIfKk1c1/GdUdlK6ka7kfqCkS0k4XElSy2ZO+FL3P6M+afFiHllc7
         /9iJf6qpy1MGmhiDonE/OIfhgO7NGlQn6Uo+UV2a3y6gNm2VBpceBVTVPG3Ge5lw6NOD
         TeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428538; x=1786033338;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TO7rhJEb0t2mz700nvgDIByTqbVS2Yz6f37I4sh7O8=;
        b=CdLplykwsaoPKGPYAa5uzUXFMwznP7xMiWYQ3cBQrsvjAU4TQ1pESu3NZ1pG7RIo4u
         6iVfKHhd2jpW0kHsANNyF1hfbSIKbsrQwVYiARg++R7xN/iM5cJUOYke0Y89psJPLnil
         PsnlHfP+aGG0Dhqdy9W0xIrIBejloFYILY1krunIYq9VgrQS2keYEvfPclOx7tZko5Wp
         RCOkH3rJhPbXUGKLEeJEGo0bCjx5mpD5Tshdgs0bBV4QxTmRieLEIYbnk2MZHXBzlSmY
         v3T2j2IDuxEwX7/LZZgQqUA1Azd5gUp5UHAD3dGhEXdStS/8B2M+4/hRcxPIxfA60aYA
         Nzow==
X-Forwarded-Encrypted: i=1; AHgh+RodbEaPk9s+UyUvhULvYLFbDoaFqkqUr5daTDiPx20hx6OuwLvv0kfwn8zeZs1hBREXoNRvuDAU+s/tO2Cb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MQaP1kVkirEUYSv9uUQW8+tbNNtpF/6fndY2f+TavluTcQnf
	nC4b4zkuZZl4uS5LGp1FZu2QCeVJiVEICqU3iwCuo7FhRHlxrapO4ZiG9+At+SmhOV8=
X-Gm-Gg: AR+sD11Qa1KG52ku3AqxGIu2DoTLaXEp6cCNg6ICEGyX1zpbsD8hAjLCZhCAbDahLk6
	ht/pMXVPUT7mJxu0fTXpHddD3cuaIct5CrQmeSvI1mbOhcY6dG1y3gDzL+/JKH0YS6wFLP+XtF6
	QnIjokOB0e/9LHzkD0wH/+mIVporcIzUXSvkQUYcrBoDevXwqUqK6NfWLObifD5NyE1BRiapvOq
	q/l6h1SCGvwRmgNrihqCclGDnyELaodhG7itoAkBvsuHTY+tTwhQln0sqPVjYgW2iewB8l5luR1
	oEgWfFx47jg+TtgAEzGkaSqs4MNxJADs/MaTc9J7IeEwMGYbuAotbaTb5RTNz5XCI17vbgDZgCY
	Dt7EFoJfNeorbY4TCSmR5KeQyA+/+6rAmpnm6B6+y//MUqzsAp2FiFgQrTqONxuEV2i8kDTLlws
	O988nBegmAfqitUrWhkMwUUXOzrk5Lf3XtDGAJbJMw4NGSe53jYGXKOHwRbEmoSwSLFxUdATV+Y
	Lx+gNb9l7y+d1hVI+FfD0l9Z9jd0s7Ag4VX36avtwh0h0zdWDCqJXW2
X-Received: by 2002:a05:6870:d361:b0:456:4c3f:7e03 with SMTP id 586e51a60fabf-458c0e12897mr2206023fac.18.1785428537794;
        Thu, 30 Jul 2026 09:22:17 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c257c4d0sm2482546fac.2.2026.07.30.09.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:22:17 -0700 (PDT)
Message-ID: <e85ec957-d648-4d6a-bcfe-09dd2d21d090@kernel.dk>
Date: Thu, 30 Jul 2026 10:22:15 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org,
 djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev,
 torvalds@linux-foundation.org
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
 <ampce7mxSmxAwAiu@kbusch-mbp> <20260730112626.GA24827@lst.de>
 <amtJDCtczVyX1baB@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <amtJDCtczVyX1baB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 6:52 AM, Keith Busch wrote:
> On Thu, Jul 30, 2026 at 01:26:26PM +0200, Christoph Hellwig wrote:
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
> 
> This should have gone in several weeks ago, IMO. You can most readily
> hit a problem running qemu against one of those lvm setups. We're just
> so late in this release cycle that I'm not pushing hard for 7.2, but I
> would support that choice too.

Exactly, it's been floating for a bit, and the last week is surely on
me. But merging at the time it was posted would've been late for fairly
substantial changes.

Hence why I think 7.3 is just the better choice. We're talking weeks in
difference on when it gets to stable anyway, which is what matters.

-- 
Jens Axboe
