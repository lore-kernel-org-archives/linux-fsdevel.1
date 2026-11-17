Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942743;
	b=vZIvYBfuLbIO4wyG6Rm6BBd2C9tAo4nD0QTr84zYjHVNDtLf6EqC9PHePQEaYCEokDiB
	 5P1o1kYDb3QgY1vUqIDWC9eDoUgVJmpNiIWTozNjAetp4s4c6Yhd34og4vLAFH9mXQTcO
	 pO5uGR3mA7blHhKksTOjVxGl2qSCZ6hnDhnOqJPOB4t2BmtDefyvjXATgn0Tc6eMuvHeE
	 j4U0qXfRxRgsdRUcaDgd7RdmSyLS6UmNGGpCP26WVm38cpamd2TwrgGdrEIRg+4uoHD+P
	 Yrrpf6rZ++O41J9/qeaHwgamGlMd/c6fRKfZOc9Xpu4/fIY+qOqrkqymkoeXnoAcNeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
	b=Fd2s3wn9fkdxYBLo4b3QY1vKA4r+nRxn+52esIeRG9e1rKfqD39t54WxdABg4qPcSMEG
	 KATRtBad8PMSTZH1xZO6P4D1bsn1vt62+yy1LOiw9VpKU9ZG6kgQti4q3IvoN4I3SwwG8
	 G+zpI6pFC9dBGiHyKJA5st9PwBaRuFbNcWDTAHAZNb7Ab3VzD61jquQd4OyQSbLiuzLxa
	 tjwH55fbndbC7b345SbYtST/PY3OaQerDrpVOIJZB9Cq56GScZd9/Sf/q8d1X7azaz3+2
	 4FPmp3zLZ8m5Je3kXnxufrf0CWdN9ehQAqYMmQb/p6DFTWWHQNHDKXI5w6g6Cb7cMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=C3aPZAG2;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259D606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 19:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F259D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=C3aPZAG2
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c505186727fso6344966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794942740; x=1795547540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
        b=C3aPZAG2dTLoBFYlxxrQq6KwJnmdhms1ucgWVIjZ02zpCV2jhSVlbpMpZ1cXxKCqhP
         WScDxiriOBEoyPYHx660SiQKdRU4kGvMXXUAu4XFNCq+UNP512t5U5F5yJ6kyE9HvpSS
         uYa7IUMAAemFHtwZGl6efYIAsTzlkFqhu7geE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942740; x=1795547540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
        b=Hak8+6G0KqZI6Bm/+Uz3RkO8i2jrm9S68vvhHCt7L+c2KUSt+RbehKoTlFV2P8gYMq
         eo4shfiKRU0JVRERgF73zTD6/grvwbevpwX8+6supblaB0BDrrIsx4B/V3lltA41sAaa
         WJmAG3KDyIImPD95n02Ly7z58sKIwhshwhp25hc07jIyee8eOW7AD6MDGVdvXLa97bqX
         JXGKOlgzCY3DdSJNIXRzQ/60RbvOXMl/S4I5Tul8709camlARH/3Om1a9QpzmoFq3spN
         omAjMOMyV2D6LiqkODq1Re/AFTY5fvbWXVCuL5dh/jMT3yDbPSvta/cyfWXdf5zwxQPc
         VVrA==
X-Forwarded-Encrypted: i=1; AL+hErHVn7Q9Gw0OfOh3ROEfrx6eEk74JzZw7Fn7mBrOHCy0pwa/o9DR9frX5Ps1SvA7qE0zWZZbkJkAcxp+mDjk@vger.kernel.org
X-Gm-Message-State: APuU4Z/NOgNmkzJ4MXtnq96P6kxzzZ8rJzm6NFshegE8dd2SX5NWUAx9
	Rbi8tMx4UGrFUKpbED3RAXX16pFRpy+PV2Svs+ZSUuthZnD8ApTDG8ZDwEGY+NoVjuKIBVy9utb
	kAuld8H/xpg==
X-Gm-Gg: AYBFou1pdaumLaDIK7Tf2EDnFmC6ro64mxfEmck6bz5wnP0mA4Mkz8A9RxBPld9kXQ/
	1nM3N1TgR0JVXPUMdLKNNEN2VRX4C9WjiXAx3cwLCtNXU+3T/8Nwk4OGZdwZsP3xCh4m+yxI64b
	BDpU3vp0mynn/Asr6QM47TBR62mhJ45QIuYCOqj3ZzjoKZQ83l/Wgxp9wc0hQ13N0KiPZFrDtMk
	VAIb7Bi3OaTqdEWQBmrafUaPMTbvvkx56mDJIUh168BHmF2kITxPYVOaXfeWH+M6n4S2+JEzCcs
	DwYinZOLRCuxgn02T2aNUUURoDI+8IGrv3BJ/5KVzSqzQA9MAsIINzOU4P+5fgFVZzWtaUbMuDG
	Kz7PCEZC2FID0IinbSGOO3nPx9Xgmf/EZn3kjxjMHaD3sTs+qvbDtOlJQxKdJZZJ2bPRWlLn+UO
	3P1bg8B7dB9Mr4olLeSJsRrkS+1J1MoJ5+oF36Mp7iCa5hBaNSTPiGIRPfBqqcY7z6ZzKENrPdd
	iach5EKwFBZQfOO9XFmbD/bkWZVBLkI7I5ZjFeypEYY/FRRAWGndX7DfZFiD5znyQyLU39rKuAd
	nVDl+WYad1wqXYGE78IQtueBPzIBxAeCf3ImCh/o7u9Qq9nlZtd9DdfCGhskbQoV0sRjvZ6iBla
	KFaOL
X-Received: by 2002:a17:907:3e1a:b0:c2e:856:2a08 with SMTP id a640c23a62f3a-c510deb7f30mr25000066b.1.1794942740197;
        Tue, 17 Nov 2026 11:12:20 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510ca631d5sm13124066b.39.2026.11.17.11.12.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 11:12:19 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50abd5b4fcso6468566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEeSxw3RdvaD6gNj5T/SQ4paQE7rC08PSpjCk8GoT5/QXoAZMxaPhn6i8sS7ZjtUdSiLz+tk7j6KfSRgq7C@vger.kernel.org
X-Received: by 2002:a17:907:d409:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c510e162740mr19765066b.10.1794942739071; Tue, 17 Nov 2026
 11:12:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
In-Reply-To: <avyVwg-5ef-pXZkG@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 11:12:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
X-Gm-Features: AclHuK9dpUSJoar-8-Rd_ibx448sJ7TbrjnfHX7r-45ghAgtBLw1mawjEAbP-so
Message-ID: <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 09:58, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/17, Linus Torvalds wrote:
> >
> > So what we could do is to just make the pipe code open-code its own
> > wait event logic, and add its waiters at the head.
>
> perhaps... and we already have WQ_FLAG_PRIORITY, but we can't re-use it
> without more changes...

Ok, I looked at this, and it gets ugly, and I'd worry about the
unfairness. Yes, the unfairness probably helps throughput, but every
time we've doen that, it ends up being a starvation issue for some
case.

I think "ignore it - bad epoll actors get to use both broken pieces"
issue unless somebody comes up with something nicer.

             Linus
