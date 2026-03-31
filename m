Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D236DA00
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970111; cv=none; b=HzhYY6Lb9innjqtQBH2dNbtzTu1Nm9f2uDTsf7Rdv5R5kLtBTbWCrxNS0nD8gNHhU7+1/Q9G+YqPVlQmcF2IQ/2ErgeCOcD9krgr3ADcdvUhWZt2cO0ZwKjDOXOGut7QXBvt0u0+Hxlvch8C8VfpAgQFNaVd094OeO6Io/RNfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970111; c=relaxed/simple;
	bh=0yXvBWHq43dtfBdz6S9QOEeNHyCE5HNgmXpZE9F+wfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3+abuKvezxcv9Wm3O0mo8RMaq8ZH0amuxBi5FXRIQFaLXWBNVIpr3Wgs/by9eXLHXQXvrpG3mHfjH7cWO0r41jLrVXLhtdOi881glxZRjFSkHNj05L9v+8LFt3R7GTZsg+WAE9Rv8t/dlXfHGvLZk/J3QKtsqFn7GzQXAgOzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ePWJyPKI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ePWJyPKI"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7653db148so3145213a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774970109; x=1775574909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PruSnKTPY/OhI7fw68fclrLaOE6FaNrTFnXsBVLrYM=;
        b=ePWJyPKI57qE+Jw3kpqjcvLhwfCWxMrm+YBweCfgFN8IG2zVOd718/7EwlDYqkkvxy
         tbIO3mEAWjr/I/VLDCeIbKCtRIDsTC5ncjEm1lJoXGyHEaJPyVypkkL9lV8exaZMB5C/
         K8csw/4fAmcFkfA3qeMoLujCTeFXe2IZsfCoIB0yZjrW+q4bKeoVpazKsjmU5u5nZfQc
         GyuotXHGhHIp70eCD+8ybgwsXxl+xogJdDskyChS5vXgcZ1MUdQWJc+hOWS9xcd7HSTb
         RjKZNc/BrgeBOnHHEAcxebGVudeh9zR2Zu2FByqWwrT/CWU4jpWtLHzEcA9/y8+zYeuC
         FNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970109; x=1775574909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PruSnKTPY/OhI7fw68fclrLaOE6FaNrTFnXsBVLrYM=;
        b=SSLDDSSrst7FcwSgia1rhHEx6mVkWWjvaDFLgP4HbhDDlMd0b/Cxk8JBhIyfrROx4f
         UaT5rO64M9z5lK2RXMzZA595rI1Bk3mWX536c2HNUrafIM1bZ+fHm+BLQffrsWvwRZQT
         2p3zVCSCbajPWrhQXltv5yv7ncuhwVhOmuIyeO/UT4Ferqw+VfQxVMkHlBQ/exCZuBcs
         98Wy+Dmcot6pj3Z/sLRGCrNwgA1EvZq0rKUYp8e49I0hTimX24YAL1nRObfRQmaJ01sT
         TKYiP1mH/51siYs8wwXqb2ouw1YIdcekLyvvr5gDfwhZYxjUPZ73AwAC53Ibiao4Sews
         o5jA==
X-Forwarded-Encrypted: i=1; AJvYcCUnTO7L2jOTRGaKUY3LnHGDJF/2w+HhNWpmjZ6ssSbiifQV7d6nwstZdDMyncpVGEcsG8h5x9sFQB04nJDj@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWwH4QHhilcW3/9RqhbufJilpNaSdCjLO+v83A+/TOStlzfrb
	aNN9WtL8OdIa3Xb3JgeQU+SVBXv/QCtnyMOjng+Ee4XIYjt7t+4DOxWfMnBmqDMMJkQ=
X-Gm-Gg: ATEYQzwjWU3LAjq90QGHsNHLASEbMy4TbnPL8RafnqhnaojQZ+COd2HRHUlyLffusCG
	CUREELJId64Sgzugxpoq4OXTWjtmv/3qocTgNSlWCeDdVsHQR22ekZ5rZra+7cTraB1gU4RdK1o
	QHnXYnGkjct3f+kjOuaCuV8IgQVpdT21Udcak9q/v3c2FjmniPAAS7sIzweAgiuae1BeLVamElh
	eZ6fbN+0jhfw5EdgSgQfkEH+x4FJ7t1HPN+DT8q70Cbs6a5gte1qXpndeTuBZO9XB7B3N8n8q7D
	0tnL9hfyqPIUY3UbAK2aXUShC8J8+3KAXo6MrQ/MZL6m8IDpA3qxv0r6BmBStzBV9dQMH789+Of
	kIVxKCbdRqcSnmJeDaO7VcEm3+gYmP0ZzmOKWTuSjnGSTqvUfCbIsUn85Bb7L0GV4AqSl7IHlon
	RxO0UmzipjES1IUL/DdynXGWr5XUwDUx/YgZREn1wV0SYgc+VjR/vrYt80LG+VjrN7Y7GCTWqxF
	tBucTRPGQ==
X-Received: by 2002:a05:6830:2a8b:b0:7d7:ef4a:5ba3 with SMTP id 46e09a7af769-7db9924e0b2mr8769a34.11.1774970108851;
        Tue, 31 Mar 2026 08:15:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da3356d8c5sm2767632a34.14.2026.03.31.08.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 08:15:08 -0700 (PDT)
Message-ID: <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
Date: Tue, 31 Mar 2026 09:15:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: Christoph Hellwig <hch@infradead.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acvkAuq4_cWmegC7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 9:10 AM, Christoph Hellwig wrote:
> On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
>> Fix this by checking if the input and output files share the
>> same inode before proceeding, returning -EINVAL if they do.
>> This mirrors the existing check in do_splice() for the
>> pipe-to-pipe case where ipipe == opipe.
> 
> While restricting splice to be between difference inodes sounds like a
> nice simplification, I'm not sure we can add it 20 years after the
> syscall was added.

Well if we could break splice all over with:

36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

then surely this one would be OK too?

-- 
Jens Axboe
