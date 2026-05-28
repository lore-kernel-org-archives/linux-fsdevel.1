Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946343B5847
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963397; cv=none; b=TBJjO1x2wnq1nLjNWoJsEwwCLZFFMGArL9wIJe87e0oF6dF9PtbdT4SQr8Ifs6T1pki6uAoBpQkL5B1rbLq9JX6D7PIvf150PipGt2mVWWvpg7hg8OcoohEf8RBG7ZjjzvAMgf4Cll9328V2Y1RFfodvabo4h64myAZazZxJFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963397; c=relaxed/simple;
	bh=Lr/YjWDvGgBFbEBlYPymrD+XjkxkQz+LWkYn+5VndMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsnXPDXpFqEuDaimEmRRI8254D1mArvRFGPaVAHk6UFuesK8ZBnBTtnY4PXh3zh0tBMYJ1vhbRWPK+DGUcPnKJ4NwGkh8eyQ7sjYdpWmAy/SZhq7lkmBLOaFlRqolRQEJZ+DSYrTmZ7xtu5viJEu27SoCrVQkt603N7tT+myzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/IQfAO6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/IQfAO6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so8860257f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779963394; x=1780568194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIEooZHkjKBETROJKYvqdiZB14+v5GneQckYETBk2po=;
        b=e/IQfAO6EN5tNlKIMnKXqxwuo3oMUQp9Ymghx1yO1siazdNXwEKVeGKk8b8mtofk5g
         hsGTJFroouk2Su5E6rD+LzuhDv1HvRHY/MMxpjhCR7DEGjJrxU9QjhzqvF47boi2gGWE
         DbUiH+LOualsBOlCaIg0ti0SZfZ7uWPa3HnH9/gI3RczLwetcwv5ZZ8VhIp+Ws5MaUNF
         Qw1sxW1qeo4a5kky6tKBat6JxTcz9Zj+PYoJQ7beMJNMfKKvarjbx5KaMFBW4lQgiqEw
         wcW/FH4Ikc/KXxWbgODkAGrxPSQblOuZJjBfTVlB1CAEJOrQ6biR8A73HN7F5g522a//
         jknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779963394; x=1780568194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIEooZHkjKBETROJKYvqdiZB14+v5GneQckYETBk2po=;
        b=m6EBKi1wCD1NBkiEZuOIz9jBEcspaGFGczWxgy4ycM+fYeWnFgkF094l3bLLZQTv29
         abOnDAaXGsncIly9IzriBOiSoE/uUgb9sglaAxtz2T4z0NFagzZac7ci29UfVgEXixMn
         cpO/kSf9NSy1hSGOgWjNL3ZqxY5pKnV3Svubd4i4Ka9XpYiUvk4IQwpVxVnF+VQrGUiL
         pQfp5qK/2IbUb7Y21DcvFLm6FgcnRHANw7TC7pVYtuHNfUUEq1k014JaT7y4b3kHKjoy
         by0lBVxYPb/S0tuJRb0PhnyaX5scNAp4MuJpSBQ3gCR0tEjFVrA8y0Alf6/qZxZspeIh
         KDLQ==
X-Forwarded-Encrypted: i=1; AFNElJ968Y5QMIIBq3IWXDU11IcIJWtOtXQqSQ9ZuGUIfnEhwDGxYgPOPYLs6io1yBqMwZfQn7Apc/kiDlMshzI3@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2Ax73ybQ2tSFjUDUoc+xSI2vfGBH30c4GGBiX9jq9oo1ombi
	RPvjJte6xtJIgMhzEvPRvf3r7fSjWYCCMf1Ltv+FufMKDObtGlVCJQwQhbg1DR9fNQQ=
X-Gm-Gg: Acq92OEaJnzcU2OSICkwrdfBOLOQ83dPLMyzo9H2ltceUhuvmKhtexSH3F9b6uAsTpY
	4TCeuPHG1Dm+ZOGKSMPPW/VZxuEqMsGGhbTY0tqd+JupDtx3w7i6SrJmOKOnwv8+Eld5bIK3HQf
	P/wMwWaw7KvzTwZvBc+7lEKzDOXObgCnHuoiQ6T8XNfZO1dAGHLnq8CQQ7oYPLIQj2m9Aad13yc
	7Y5q13WlLJ7kHsOSb4qW/sdWtf4FcKRNzEYDKTjDDgKaJL3EUOG66i2WTbIcwFgSpu5ncfD9WDS
	ASgeMHTQqCpA5Emz9bTpWj5+aoAweo79gzInXkqqmMI2EwUGMbF8xhydqfh/BArjokDDtEtb0YC
	xAsHCiAMU16QOjGXQFg4lHeUaZJWqRbPLuRaBSfiGzrGqvLS3SJqEPusPQjVckk+y958XFwfmN7
	2OQZNp659i6XF35J9kgDYe4Bfw+s6/c1q29Hcwb64sRbHjdsBmY1UFv9padDtRa8hNB+xSsQUiq
	J+vkG0nTXMzB84gFXu0QLrAfst0SgH1OeS8Wyilaw+TIdAUcQIwbUD4MMdLuX/qRTZW
X-Received: by 2002:a05:600c:3f19:b0:490:5443:620e with SMTP id 5b1f17b1804b1-490947bfb8bmr18930275e9.15.1779963393921;
        Thu, 28 May 2026 03:16:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c856399e12bsm1145095a12.32.2026.05.28.03.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:16:32 -0700 (PDT)
Message-ID: <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
Date: Thu, 28 May 2026 19:46:24 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>,
 linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora>
 <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora>
 <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
 <ahZeYQ0cLE1i8TGs@fedora>
 <fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp>
 <ab5492b6-a053-4e3b-8c59-2e836ae85bc4@kernel.org>
 <20260528083848.GA7694@lst.de>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20260528083848.GA7694@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/28 18:08, Christoph Hellwig 写道:
> On Thu, May 28, 2026 at 03:11:05AM +0900, Damien Le Moal wrote:
>> It sounds like the VFS unmount call needs to have something that waits for
>> sync() to complete. Though, it really feels very strange that an FS can complete
> 
> I don't think this is the VFS-controlled VFS file data writeback, which
> we wait on, but some kind of fs controlled metadata.  And yes, it looks
> like those file systems are buggy in that area.  We definitively had
> such bugs in XFS before and fixed them.
> 
> e.g. 9c7504aa72b6 ("xfs: track and serialize in-flight async buffers against
> unmount")
Considering the xfs fix is pretty old, it's before the fix hint thus no 
such mention in fstests.

Do you happen to know which test case is for that fix?
I'd like to adapt it for btrfs as a reproducer.

This syzbot report doesn't provide a reproducer.


Another thing is, if it's some btrfs bios on-the-fly after 
close_ctree(), the most common symptom should be NULL pointer 
dereference inside various btrfs endio functions.
As all those end_bbio_*() functions are referring to either fs_info or 
inode/eb, thus if the fs is unmounted before the bio finished, they 
should all cause use-after-free.

The only exception is discard, which is using blkdev_issue_discard() 
thus has no such reference to btrfs internal structure, but that's out 
of my understanding.

Thanks,
Qu
