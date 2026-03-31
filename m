Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7923FF8A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969213; cv=none; b=Y0xJwDzk2GCgjhC41squVtt6IVe5CLE7oJKGltYCBAhBuio8kj8f9TbWcxstdSxS+km+lJAgP1K7EgRHq30rlfEQFaUwoEEKSChPCDhy18E4qyzljV+Te283zw1eK1ztT4Js/qaMBAnAvuw/K42IAuJMJdLaNvfvHZ90MXIqKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969213; c=relaxed/simple;
	bh=CXL+zqhka1epdOHuE915GA/t4kRdJ5N1vb4vwf7jFYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqDg6tGdZWK5I9JA30hS2uzpwzq/pNhxWtmE7c6t37faYVKtT3GdM5hKMcCpKYC/iG8oifeeJpCMPBA3ZQW1epbAYiP8wSMeiIJrr/l2qF3sHoJ3nXgFj0kgSMt4dkLSSrshB6EeUvqi6civPhHvG5dAAqj/FrU4FBpVZ2MRjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5e53yYE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5e53yYE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b9675d36so48345095e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774969211; x=1775574011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFYG7qGkW/D4S3Gn/vuH5dcuXZP+K/fZSbYVBvamaXU=;
        b=c5e53yYEWNxa2hWXXsShnHQYuJ9IJbhAvFqdzOLuJw3rOGK+0U9alw7ruhFjD2YjHH
         HEMeFw88U38hWjyH3nbGnDUvPTddTR+71WdxgjRpMaWEOOVRAoBLUcnIoXw1ON9cPh/S
         bXbssbGYYJmfZ6Jqw2Bct10F3bXtrgzxUThuw072Z4b4WLBSP24cIERMK1W//tjvcVj5
         UdJEHNGLPTIxylJY5uQQ+1gaxjf0j3gJydr7E7Lu10lrazarbzeYMH3mVlMrptyCltxZ
         zUUJFoMCayWUux4zK8Hh/cGVv/bwdW6Qe9QaNxJpnw2RDi9aAnDblFhMyTu5GgpDU8V/
         mgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969211; x=1775574011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFYG7qGkW/D4S3Gn/vuH5dcuXZP+K/fZSbYVBvamaXU=;
        b=BY8Li32B51reB1C0MTTRqAw0zItIuwbuc0ss9M+1/IuV7yjQtjivsp2CkYqyVftRwN
         ypuNUQDB0WlDpEFWn6wvtPfGtkWg2NiMJRNAEJ9Tp6n4bRuz00jCFGxXoWP47moJIBEI
         rqErtFpQs/Cy17tZIWARnHaG1S9BSnmyWx/uWQ1XvhLSR2EUxOxHsh6hYbO+yXQIvE9I
         mos+iCmzI09D0Y+W3yx2nRdtNIbJvc8n47mUwm9BMLMKZdjB/hqtH5bNcX7OLIfDtxoC
         MvmOqpEa6XMogkClJ/ESbLGVlJyjkUG0etzgyU6T+gAC02ycoDBq+2tukjoU6GdrMMFx
         If8A==
X-Forwarded-Encrypted: i=1; AJvYcCVCcDVZWC35RXDkrenK9kGWkC/PetBBF0mEzh2Fd/89T4SVXbjbEVcng01vNxK122iPcSfgdfKzSuPb9S9T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxydoqgaqr8Ya5sXVGj16anmG9QtT3msD4MSc9JPT1qfY6+tJu
	oj0xzjk6ng5dnfZLDl5joe04yqHUw7v7awRLBbVhaKOfGIzzQGfeuT5U
X-Gm-Gg: ATEYQzy/Ccdte8+3aTd/Jrwm/hjlJGwbRvj6xQ1JzBRHjkQkzTb+U4o1CgI06H7S7l0
	awivJaG8eDhd7LrXURtB7lJNDSF2JJLYQN9wRUayQGccH8exDkPim2A1FkEHQ8GLJwwaoLQ3r09
	5KntwH+ACrrAHtte0u/G3LkUnMCGTwMx6CCbf+8W09onNpHRK/RSujZmMaOLvejeHk5SCdz3QU9
	RpcVxw09J/Pai1xmeJWluXnqoaS4wEvu3r9KKgek+HUl7MTOrW3rRtGxYCvNDq2LiD3T7yeHSKP
	gwehvIJDnBk775BQ3uIa7To9cWhcY2wZBzQbIKTKuY7ETJ1Dl7VSSd8bfP8PCd6BTvmmd/knlbM
	XwbBEG2M9V3chIxeF3Z/Kr1SgI4w+kQFiB8xT28Tf2VawUZIcmBr48+BH74Dj3t+641GayzWdfo
	nkdWHCyi5shTKvG4UVqqgOSCVV9h8fOh621cFroBLXGSqReKbPlJR/nb93IGMkrp5+hd7OltY=
X-Received: by 2002:a05:600c:1d15:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48727edf4f5mr276415735e9.26.1774969210296;
        Tue, 31 Mar 2026 08:00:10 -0700 (PDT)
Received: from f (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2a7asm30742821f8f.7.2026.03.31.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:00:09 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:59:53 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>, 
	Jay Shin <jaeshin@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Yafang Shao <laoar.shao@gmail.com>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
Message-ID: <6qfk57jj64a2t2mwjsldtvne6ooctpnfhpwisexctlntqa5mpq@s2lumil5gddf>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>

On Tue, Mar 31, 2026 at 05:54:01PM +0800, Gao Xiang wrote:
> JFYI, another issue we once observed on user workloads is that
> 
> `d_lockref.count` can exceed `int` on very very large
> directories in reality (also combined with cached
> negative dentries).
> 
> It can be a real overflow, this commit can help but it
> doesn't strictly resolve this, anyway.


Another way to contribute to the problem is to mass open the same file,
which results in one ref per fd.

Or to put it differently, sooner or later the dentry refcount will have
to switch to 64 bits on 64 bit systems.

There are 2 issues with it that I see:
1. no space

struct dentry is 192 bytes in size without any holes so growing is an
eyebrow-raiser.

space can be freed by either lowering the size of shortname_store 40 ->
32 bytes or converting d_hash linkage to be single-linked. The latter
means hash removals turn O(n) from O(1), but that very traversal is
already there to find the dentry during lookup. Thus if it constitutes a
problem, things are already bad in the sizing or hashing department.

2. lockref itself

If one was to implement a lockref variant with an 8 byte count and a 4
byte spinlock, one would need to use 16 byte atomics and that's
atrocious af performance wise.

Perhaps it would be feasible to hack the lock as a bit in the count, but
I don't think that's warranted.

The good news here is that lockref is already a performance problem
because of cmpxchg loops on both sides of ref/unref and AFAICS there is
a perfectly sensible way to move away from it.

Mandatory remark that numerous commonly syscalls can avoid the ref trip
in the common case, but getting there requires a lot of rototoiling in
LSM code.

So the fastest thing would lock xadd on both sides of course, but going
that far from the get go is asking for trouble because of baked in
assumptions about no transitions 0->1 when dlock is held.

Instead, a state which is already way faster than the current thing would
"lock cmpxchg" to grab the ref and "lock xadd" to release it, with a
dedicated bit spent to temporarily block lockless operation on ref side
(any place which wants to keep the ref at 0 would have to issue an
atomic to freeze it and then the current guarantee is provided).

There is no significant difficulty here as far as complexity goes, but
there is a lot of prerequisite churn to go through -- lockref use is
open-coded all over and the count access is inconsistently either doing
a raw load or going through d_count().

I had a WIP patch to do it, but other churn-ey changes in dcache mean it
needs to be redone from scratch.

Maybe I'll get around to doing it.
