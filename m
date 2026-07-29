Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BA4749D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324399; cv=none; b=Kl7F3JaDosrq0+zaBH59+QxSHueILafWnqlLPorhot5CKtgj82GozT1o/IFT9SU9bNk/XR3QTonlF1ffyK7or7gUOMaLr6qnBa3MYBZG5Yyj85Lxxi91cqtFGDLhNHOIhPCcD0q8rVY1NTA/w8qDuz3u4KuF8E4sgbLY0x3+hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324399; c=relaxed/simple;
	bh=gwr6BzC6RMHa6KAJkjwkRDT0HgMxUqH4X2MzNjTQaeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5r+b5X0lc3v260E4+ToUgoKj6leVxC8t+sINAW8KugNCWt/yhxQzhbp3tJKu8qt/lk8kaUVzUzmUQtrPnWBgcWvHPPrYQOpk2CvkZdiCGyjGP2UpvaSlftW2nJDRBnVkNYDjyXt301c/LS9nvuooaYeA9W+0mN5wEfCwPRwqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDiAuZau; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDiAuZau"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15c42a45adso272740566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785324396; x=1785929196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3beJ2GytxEAA4qj5aJAKvYN6Cy9RqXIA2ZrgLyYpb0=;
        b=nDiAuZaudZ23Yypsa+rG82HC08SxGc44N0v6UrDA+H5K9DXdIhU+PkTBUkmJzzNfkR
         VKxTMYrqhVVh3k6csoifMjZftXTicm9g7gAu7nHurE3XLAM1/hAI6u6FHcLFdEj1ZUHO
         uYXfW6SnbtxhxoTtyFvwBS5zg3590PPl+ssqtgrSKvipXZf1/WuQ8KGHdE0+XR68NvCG
         sSVcxsxSIuP+mEBI4rgTlGIa9V8fB55e9QK6rZQejD4qHar/HZJ9XKZx0QpO+2/GD6Eq
         iEtQohT8zgmjI640nZwaxzgSfmXR1eMDP+0MULuJ7KvG/aqEroyaGDs2mk8JPU4qZIlx
         eq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324396; x=1785929196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3beJ2GytxEAA4qj5aJAKvYN6Cy9RqXIA2ZrgLyYpb0=;
        b=tHFeQwR/w+MH8IvaAAySuTKHHXKiDf+XgPnnbE8khNzSBtbmxR7J2zdgpwFQzsCAbw
         1oVulj1f0mW9giNGohoSa3kQ6w+WtLHQcaZtQE1DK4JReK1X2/GHc/ue5+IL1wlAq5bN
         Zg4/0FuafJyERKnzWtqfEEVRn2tpXkGwrF2Jtp1t4TVJxVaCTZZFTJUkzDFgTh9D0JqR
         sTmZihR7nFfQZKZSjPB2t2pgXBc531v5mS3dvPTgFqW7d0RRDvrhnDxRLiebtQA0/r4a
         3kV99WVGbwjHDWVGNRrkMMyGveg3u0KWGj4x+s1wfaanl5UalKDbuVV64TkCILzc0SyY
         KxqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rot3EQBkx8MK3GF8xih0gJHfWfLDV0pCQ2LRp2T8k3rfbUvTkeREB1Ywxv+Bx2LQgD8wc3inlKIESXwZhKo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsdumr8fnTdHhlE08gO7lhRPvpHJfvJxJyX1X7/DlFg7wGxC45
	Qe4/Y5jQIdFBB4FvM+5oYSrFWa5kY54zJw0NMSjoAy2/dfjSU3MB5aeV
X-Gm-Gg: AR+sD10z4/6jYT/lIpircJahg2WgmkT/N5jb3rEMCCBYWrBJ7H4ZemWrYW+g66LhpVq
	GaGiJU/+bEIQdaJ/cpRHjK0afNG2Ug9ga979mGCeUzHWneN0QsLEhOKieuyIT7POTFtBPMvIjx+
	ExAYuXqj0mARFCZ07nPd2Wm4Q2Wlsun4WJh7Kbgnu9Zc4nVpq6RVLp/XxceCZ/dNS1pbAKBYzb7
	xwhD9G8pl6W3TQdC0+go3H9ltnJDr8jAWHDCHpa40Lkf3Fe3YCIjEbrGbNyxblNxcx7G2wfLyR4
	qeJlu7MbCGbRbnMEf/zPsOHGeI07yoYJrX+6DCvvuHEf6194OQM1hPFPLbihITRfLareG5rLU11
	KhWtkrInR95ej0by68zPh10NaJLzV5On6y1lbO6qMIaPsBsUkHKQjN716o7PawKd81Egf0SBGsm
	TGyQyzKNsB+4Y54qc8z/BABK7g/IrcodyWvVHHA0aciY/xk/Xfknbv0mljnKPoAnWbEoL1nGbDe
	K41B8zJBAxa+93aQOMdRabbLpCLexDoaQu6vIjtTJnXAhAN/tiRxHMxQSCu4Ypr9qUO8C0WjP4a
	TnVXqIS4oEQe8UQuWNWib1MlbcoyEA==
X-Received: by 2002:a17:907:3d09:b0:c15:ee17:47a with SMTP id a640c23a62f3a-c1f8cdf4176mr118542066b.15.1785324395784;
        Wed, 29 Jul 2026 04:26:35 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8401a6cesm101864166b.58.2026.07.29.04.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:26:35 -0700 (PDT)
Message-ID: <4877b1e6-f4d2-4522-b318-29b49c66b117@gmail.com>
Date: Wed, 29 Jul 2026 12:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
To: Oleg Nesterov <oleg@redhat.com>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <amIqfCo25rLtM2U0@redhat.com> <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com> <amTT60nc1QNIyPfL@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <amTT60nc1QNIyPfL@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 16:19, Oleg Nesterov wrote:
> On 07/24, Oleg Nesterov wrote:
>>
>> On 07/23, Oleg Nesterov wrote:
>>>
>>> OK, sashiko has some concerns
>>>
>>> 	https://sashiko.dev/#/patchset/amIqmbbZx3NlzUsX%40redhat.com
>>
>> Let me quote:
>>
>> 	Does skipping this wakeup for non-epoll consumers break io_uring?
>>
>> 	Applications polling pipes via io_uring do not attach an eventpoll context,
>> 	so pipe->epoll_usage will be false. If a writer writes to an empty pipe,
>> 	io_uring receives the wakeup.
>>
>> 	If the writer then writes a second chunk before the first is drained,
>> 	anon_pipe_write() observes was_empty == false and
>> 	pipe_get_epoll_usage() == false, skipping the waitqueue wakeup.
>>
>> 	Could this cause io_uring to miss events and hang permanently, waiting
>> 	for a CQE that will never be emitted for the new data?
>>
>> and I am starting to think sashiko is right (damn as always ;) and this
>> patch does affect/break io_uring.
>>
>> Jens, could you confirm? If yes, we need to update the comments in pipe.c
>> (I've attached 1/1 at the end, so that you can see what this patch does)
> ...
>> It seems that IORING_OP_POLL_ADD / IORING_POLL_ADD_MULTI is edge-triggered
>> by default! Like EPOLL_CTL_ADD / EPOLLET.
> 
> Yes, sashiko is right. With some help from AI I wrote the simple test-case

https://github.com/axboe/liburing/blob/master/man/io_uring_enter.2#L400

Seems like it's even documented, which is a shame because I deem
IORING_OP_POLL_ADD + IORING_POLL_ADD_MULTI to be a half broken API that
should be deprecated after investigating lxc problems with it some years
back. Makes me wonder, likely it wouldn't even break anything if shifts
from strict edge definition for pipes. It's a stream, and the user doesn't
generally know the number of bytes sitting there.

-- 
Pavel Begunkov

