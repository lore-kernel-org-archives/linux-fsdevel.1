Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF2495502
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858728; cv=none; b=pqPtPlYx+Y6F8aC04S4rdvztTWp+O4ZUFQ73JntPJtdka44Q8+ThHC+chAFjRjA2Lphr/8dX7fcGmBh6OwsI3r8Sz0nvTJeWHrQnnNYWmfCgBVzhOuLctJ0pP54a11/v1BMq/jhOq7pXRUTKCdlu2h0IzUSMPvtt6MFGpUwkxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858728; c=relaxed/simple;
	bh=a7Kt/m+0JnX1X8N5L6wTaDKQ2rl+hmTKrV/ONKOETJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjSyXdumGhu9RMw5+ijti7rqW5dxXSYh/zMH8LfJ3swGt6AD+WQ04wfHaWNqot9PMb3oq58jLL+O2z3cAmrpnUHOPYI8v3IXkUOus33Zg+OJJP+AnK7LkrqIWQHLw+OXoOr0B4yzLjbxoizRS/PVZShr+6OVZBVhla3u3hEDuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=hFSvs7Wl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="hFSvs7Wl"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbca22dbfeso5375989a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778858725; x=1779463525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2dd+XUfkYHhyAA0KSTJMQh4TQprRfZ5CcOO5gIxkqo=;
        b=hFSvs7WlB5Jm1Koll8CvH724t7AFd0kYZ+mk+/mV6UfyesI5b6IkLb/6EXGnprosDk
         qKegzWOH5cp4AqKIbVj7CjwV987Yu0E8QT/qtK+roKO6xq+plsv70OdPTPIz/BUC+qlj
         gxsbo1Brdq33ZrLCS0MAH07YqbkKURPkFhjMj94Y/KOduD9jSr0ohcO9G7X1BJLUBBaj
         d1P0EfkrV9mZerMLKluQT/VMQhFn4gBkZwgvyaLyB6NZINZJ+zMCuA5/poq3eITCbx2d
         NCW5afbebSQvnWhsIhTgA8Q22W8tI/Otvu2MYIpbT7qH6QTK0W1xU6LhVEGk8sszgyHD
         7gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858725; x=1779463525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2dd+XUfkYHhyAA0KSTJMQh4TQprRfZ5CcOO5gIxkqo=;
        b=l1My/7h2zLhuPVSkanygXrTJc6UJz4bY9p+ssVwKpxBVthxHUEOPIrNHf2XoBLhnyo
         fVeVW6ekLXY4KQeEvFciAkHqK0gX4mcRGTrDB1rMEP1jxWzF/Cvrnc/Z9dMc0RisUonm
         dz0ovFFfYxuFdEihBzTxzZTOBEhzwoX7Cqe1yAkjTlNSGZVZH2zOTeqPhWDmwSa1IEpI
         nf8Bdr9stm/4faUspSMyM4u35SHhufi0WKnxuMUnjlycKNNxgc/5yRMbypr83MxLvmrI
         DiLaLbSVytBTt/eKKuSbFdDsHk30Y74VOyDqhL7CBSy1LnAqBbNdSHllrb/+YQawVaBi
         MsYg==
X-Gm-Message-State: AOJu0YxXPW1MJMzXwPb1bU6gJpoYOHJzHfGz7XzxG3kMBJMarphvqaH7
	1X/ATqPVfH0hVApEL4zvr/4A39zL6wD7SayLE9MSOhNB9nC8pgI629DjDpeELkNoFbQRZITO/wa
	mxg5b
X-Gm-Gg: Acq92OFx6I/kFG14qiBlDRBI3066SmiL0Vks1P8swBPuaUYgII4TfdWWmG8Rz6rufHG
	2iCu0xB9ad2E+YvK0Tf3K4XNTbjbcPHbmWGiGtrg8M7zRw7mta8Y+wOhyCnRPuUWaQXAIc/nBfj
	yJ3RT6VlKGzqqEcFAcBI7hpbwYwUA1VYI5cucoCfVNFoiiCl13+gBKMxDWIYqUSFS7j/Fi53PBI
	BOHcLBzZjDzXB+OUFVJO1ZAVxOKcbPVPdK5UTRHc5TmGu+S8sQPNILB1rZ96r1bTwkXmooBBiXO
	v/g2hX0aQTJJ+5ZqRowM3j+nY6alPj4Z1AQAAdwQoPNrTUjaTQ2vzn6IB/8lAjJ5HCbMcgR6i6C
	AL45BWQcSrRakd1GCpA8dSpwUGQT16tMYhuW2GFCMUREXVTaF0SndOFVYPqW6MwcYhDQdRw+/zf
	vAIT5rWVzBzcLjkKi3WbbHclvZQ5qqq85xsoTE8aq4g/4FIMwlEhCC7U+/OVWzjLzr+4he5IUw6
	VUlKztd
X-Received: by 2002:a05:6830:6588:b0:7d7:5113:f83a with SMTP id 46e09a7af769-7e4fa090162mr2978796a34.25.1778858725212;
        Fri, 15 May 2026 08:25:25 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4983asm1471700a34.26.2026.05.15.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:25:24 -0700 (PDT)
Message-ID: <b2ecc3cf-12bf-470a-b30c-f89e64301629@kernel.dk>
Date: Fri, 15 May 2026 09:25:24 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCHSET v2 0/6] io_uring related epoll cleanups
To: Christian Brauner <brauner@kernel.org>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <20260514140817.623026-1-axboe@kernel.dk>
 <20260515-lachnummer-havarie-c6e68d7fe5ef@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260515-lachnummer-havarie-c6e68d7fe5ef@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 9:08 AM, Christian Brauner wrote:
> On Thu, 14 May 2026 08:07:16 -0600, Jens Axboe wrote:
>> One of the nastier things about epoll is how it allows nesting contexts
>> inside each other, leading to the necessity of loop detection and the
>> issues that have come with that.
>>
>> I don't believe there's any reason to support nesting on the io_uring
>> side, in fact IORING_OP_EPOLL_CTL is a historical mistake, imho. But
>> let's at least try and contain the damage and disallow nested contexts
>> from our side.
>>
>> [...]
> 
> @Jens, I added the epoll specific change to vfs-7.2.eventpoll. There
> were quite some merge conflicts now that I had to fix up. Please take a
> look and make sure it's sane. Otherwise I'm going to push this and will
> keep the branch stable.

I think your merge commit ended up messing it up, as you have

- static inline bool is_file_epoll(struct file *f)
 -int is_file_epoll(struct file *f)
++bool is_file_epoll(struct file *f)

which now makes it return a bool, and the header has it as an int
still.

-- 
Jens Axboe

