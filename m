Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE48215161
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133929; cv=none; b=tLkJqprVvvWp90xlf47RO0fQi/y73/t2ofaL6MlMwT5HZeELzTwBGCYoTKZZb789tyO2hOlBV24v+sRp/RNUbHgt65sjE297+umoJbJBkfuCarpK6TbQ/epRqabkqqujskdV/798TmHo8sHiVVsJL3m6TJrLuRu5AEznVBv+pLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133929; c=relaxed/simple;
	bh=5SC3HT3+5ycGwWh5KBASibBcRAJzdLO3KnH4sjbmFDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHCOzDlezdBzwFBhBY+cCA1acTH1pFMFM3NrB2WvL3aOfTGMVVP7l+Hp9xtn4zOwv7Mz/KF4QUuqnL3qn9rYzlpOpvZsAKoM/p36LhRmqZIhDOF6RhptTvbOMy1ppShLcAXNyF3coxM2epp+nJveipdfhs2jncWGc2ses71N6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sD9i0EPj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sD9i0EPj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f3ece23165so901109a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789133926; x=1789738726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCKlIYEc3WBtqZTRSmkKr4C+yXpeMrWNJb+k5yI49J0=;
        b=sD9i0EPjj0Ig68IeGg90WglA7IXGd9HwDQFuhbJxnkZjB9Si4yn+4RIQak7mynH8zH
         +1igcCeXsxwsXgponQPQcytQjaWGZlR66ar561qN73PpPOlr9uGsjcgjobCPKB/avnlv
         a6LoshCKEOCyssaM+uYy0Rz5r8mafFkENxpBEAhYYNyTBGSrJ2MW1OIYtHElh1gFbyeS
         25eZHFxVSNu4fZY/OuFp1yh2tYbwRN9s8O9Uj3iLNMsZMMstNEZ+LW7X1oDFuiHn3V1Z
         zR3n/XKfT4kjiRHGzC/hy2wBLC4+VjYpRg05efGSlP9DZfjmhocxWk6aScfTYbWrKgFU
         RHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133926; x=1789738726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCKlIYEc3WBtqZTRSmkKr4C+yXpeMrWNJb+k5yI49J0=;
        b=hU/EbCRTPrFlWcSHACd/cjjZKBp5OG3j0EAReMYK6swVAgKZ+YA3fxBV1FVOj1/0G8
         kBeZFl3jUtqRuShQ91Owt+X3Rlfq5gBSuCA3JThc7BzCxCVqKMijqtBPGPqODm9VhJaV
         CGzdvqMjsteaKY4XOyEnCiXaGc9p8TrG42Up/u6TayI94Jy6RlHgahtjqrZn7dqAIZmv
         gptMql1azc1s4JJKd9TRVVoE4XFXON9BryfhICHfLqA+fxSp+yiq+i0oYm+MJqQDVAa7
         1DwsBWib+bnmq/I6fcpc+lAVpK0dxSaNmDVTTtBjbagDKzFt9lm5JQi6Hr9wRTvMf3lk
         UXPw==
X-Forwarded-Encrypted: i=1; AKwUvBxAYA3ZzCLLab6Fi3FY9JnjHdVhf7H64FkZrAhhqomdhQsMzzumSJDxVNaesZdYlaK97tN4uFGX//DGZ2Iy@vger.kernel.org
X-Gm-Message-State: AFuF++loEk6n+AqP2HaMuBsYLvH75QncixCy2p7e+28V2RoNbcpH2ASi
	N509B/70kqXf3E1F2nBwQU/Wnr0SgEdQf9Dozn5kHhjtM+NjT5rrjWT5TxXSWs0DwYg=
X-Gm-Gg: AYBFou14951RRwvW7SfAUJoOf46VwJ2OWXPzh6ujeucguhE9dUHx+D4gVHypzyAsr+1
	7bzf1TQvPIx3peWjLQ9Pd/KrzRlbewcdWe+pw7kRwABKaKJj0B4G8zkJa497uTewTtIVwVslrK3
	XSBP2b0XqeqbgY7sg34EAtywTY+KXymgT30F9hM5ZJL+8WD2VDGu5br6Wprs7+iqJw52S17E/9L
	9HoSFxRzBqK2hbJJYti8iIeyLUdhadyXv7kEM6zcbvrv/54HQIC1RU+XMxlqsf4+7Kes2FJXz1Q
	Wae/CY+tyQDUmTiwm0QsqZ3FuVyJAlmB8nXm0FUQVLbuR1z+bkiE8tV6QPHzcaNilAH5IqsDJnQ
	G1U14cqp1axfPMrjibIcO0nnPCzifv98QwLRVjAFqdvuExDjgQPYxnJbLWKPLIrgYuK58DGFklZ
	IFSjlQPDfodMbxtvI4L5ae44HxUOtVBd29oiUvkx0emQM29ypmhqv7B+hVdoUgxdXnoQ+aFTRl0
	mlquy1FPzVGN57yTP7FBrshtHtZM4+ze8NiLaY03Tn/u7r21ZS6D5KL
X-Received: by 2002:a05:6830:7314:b0:7ee:19dc:b00 with SMTP id 46e09a7af769-803fd2514b3mr3323405a34.3.1789133925938;
        Fri, 11 Sep 2026 06:38:45 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8051005d845sm206965a34.24.2026.09.11.06.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 06:38:45 -0700 (PDT)
Message-ID: <2325107b-8c45-4304-aaa5-f8c768d619bf@kernel.dk>
Date: Fri, 11 Sep 2026 07:38:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lazy bounce buffering for checksummed reads v3
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260909060924.1102037-1-hch@lst.de>
 <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
 <cff350b3-836f-4953-97f3-d664164746b4@kernel.dk>
 <20260911114438.GA21957@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911114438.GA21957@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 5:44 AM, Christoph Hellwig wrote:
> On Thu, Sep 10, 2026 at 02:51:33PM -0600, Jens Axboe wrote:
>>> It's a little hard to split as you have eg block patches both at the
>>> start and beginning... In the spirit of getting this some runtime, I'm
>>> going to queue it up in a separate branch,
>>> for-7.4/lazy-bounce-buffering for now.
>>
>> On 2nd thought since this already relies on stuff in the XFS tree
>> apparently, you can just add my
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>
>> to the block patches. Would probably make everybody's life easier.
> 
> No, the current series is just on top of mainline with the block
> fixes for Sashiko existing issues comments split out.  Which probably
> was a mistake, as that now lead to a side-discussion and Sashiko can't
> apply it any more because it is too stupid to parse the cover letter.
> 
> I guess I'll do another resend with the two of those that stick
> included, and I'll leave the third on to John, who already has a
> handle on it.

OK, I've got it in for-7.4/lazy-bounce-buffering now.

-- 
Jens Axboe
