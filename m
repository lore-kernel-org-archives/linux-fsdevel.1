Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56F469839
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344875; cv=none; b=cQxE8KDSk8W+ahxQkv31jBXXlwkZI/2wA1b5GbJ2OZi0JMuI+83D9i+Q+/JF9kEpU6cZA9YHwCfHhdc3QY7zpB5b2PxrM7bAnMg+mA3XsRxQT4HS6gwtIuTZtc3UxgkhP63/d4RLsdcymjHoaik5HJ9ooKhS2N4SJUqgJme9UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344875; c=relaxed/simple;
	bh=bb14VU+mzqH5lBzRhhTvKjHyh5XA6yPZdb7hGKFeL+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbstyjKuc2aCdkNHgHpMNCjVInxPL4RDXVGDvZ/UsywHzt0AakpDxRZP0xrxKxdkY6c2Vp44GotyL6TGHOKIiMuXEw6hPpHoloAhS/pC0SFBpIMvmrFPRCW+Z9c2xkZDsctOTu282YVbesXkF6Z1XFaqmjO4wBBS/is+ajpzz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG5gBZCV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG5gBZCV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f707e5d75so883499f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344873; x=1785949673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/vni40zmOCZ2HqBZcbw7mWmT4z7vqgKQwHadXTDKns=;
        b=jG5gBZCVg9YZMIvvBVKJAS+fsmbzR4fWs0xG/oV0Z1s3GGiXEra3QIJSEqRBBnfqWV
         VzlwGNlvQ3ZQL9qW0jJ4gumBXkwnnC1l+E56/dCnn+ckSSsg2uZ9GMRV+u+lypXoEGJR
         IUPx2pJUEM2kFE2iyTGEqn2nO44y5wMgdBnYa5gbjCvoLWPJVKDsK/CHAaD8Z4TyIuo5
         +61u3hiBCBC7sCvR/m5ewZe/YNO6I8tjAheDrYMzv1izbKWv4A0UJTbCfNwXenhy3CHs
         hgRXz4D6KFvG+6Ap6A9ouFeSCB2ASZ4iiFq9ECMS+23VJeZf3nj7+CiPn48QVbQ+wlOj
         alcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344873; x=1785949673;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/vni40zmOCZ2HqBZcbw7mWmT4z7vqgKQwHadXTDKns=;
        b=By70W72WZ43MtIBIswoOpxXwMVaVWjTTYhiXnlEbRrv+sPqL23YpoPiQlPS6+ybWxm
         eP8kIyPPo04+8KHurLwDYtyNRcnJISb8uMEqjYZ9MNts88JbAzO5klg7HIaMZd00OmYN
         FzP20JIVrveQLC0u2p8lHlaJ+Z/kHkl4ag3VabUQea94D7FBCaUbSTUq7jb6oOUeaoDl
         oL4cBZNKX5R6bflqITuVHIyRqjLjqjhqVdXS7/ZQPB3n6PEQ8QCPyVc/G1vbIGaD8mxY
         GLigghl5dCmh0BMZvtOWAc2lKjwblfDoEDp1kOmfJiJyENr/U+b7xum6AuTAN6S10iO7
         B39g==
X-Forwarded-Encrypted: i=1; AHgh+RqzonR3PME6I//J1XM1c9hSXjbEZNmHzvXib2OfhmDE+oLro0jUPtzRVJ3wjhMAmjgTffWABTD8iQshidCC@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5EM/nfZc4qC7jKTvFOdwgkyXr6QZwrJmNZTfTt8aRnJyiKRO
	X2qRf72soJPy+4MqqvGD6WtuZsKI2YeYJGH0jhLSE0N8aJ0FBADXv6WD
X-Gm-Gg: AR+sD13i8Zbz6tHd43w5B62DWMQetu+C5QD6DG9aJjztmh61pJhkQbuyyoZ3CFY6++y
	uAKzW21Zm0xAjnxmZuGRi1TBrEWKWB0GvbNSd0YMqten4ssRTFLKbiIdk5qgE7eLk/Lqkz9XKEh
	po8PkDR0P2A2Q2oPjUTQ3Uix6TEYjEc5GuQrM3p7rnX3aGtpZNzKHIJxr5s/WqL63O+ftReegZd
	+miQp32jqSjMVYxNSiOlxLmoMusBAwFkIfmYGqH7q+lV1GpR4ket8Jz7kshCDfiwk0k0wc6r8Z4
	u0coP2/66/2OjfmCgvBqCBp5VqGLFaAe64j+8X68lkehysFjmLoULqU5OO48rTHKmyd3WDg16U5
	7iis54lLSABE3vEV/iZ+9DY7bRis0J22rNZ8hDlf57TxP3xmvVYzomI40etEQptyb4iMPr4G9Y2
	NKA9XPQg5dB4xX2WH3EG0lzcy3NbKMA0oiNugvH9xzjPFYm9Fbxyj2yTsimivpSXpMhXxO3PAc+
	7TqLHUX8iXFfV0w8rnNnqlNkhccGUAvHQXNurL0pczrhk/mP5p8I70onBsg3uUGDmcoBc7ev5+N
	9bZ44P94pC1EZ9puA9s=
X-Received: by 2002:a05:600c:630d:b0:495:5365:c0d2 with SMTP id 5b1f17b1804b1-496c6558b53mr99358535e9.14.1785344872559;
        Wed, 29 Jul 2026 10:07:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd6d226sm72029155e9.10.2026.07.29.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:07:51 -0700 (PDT)
Message-ID: <bee0e036-3392-4a9f-9eb2-398d99319ac0@gmail.com>
Date: Wed, 29 Jul 2026 18:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] pipe: only enable the extra wake_up(rd_wait)
 for edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <amdNxsTODR4MCl3R@redhat.com> <amdPACI3kw8PobPx@redhat.com>
 <1bd5710b-29c8-4a8c-8f26-72d9e71c2321@gmail.com>
 <amogeROg0Hthp7HD@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <amogeROg0Hthp7HD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Oleg,

On 7/29/26 16:47, Oleg Nesterov wrote:
> Pavel, thanks for taking the look!
> 
> But let me ask a couple of questions to ensure I really understand you.
> 
> On 07/29, Pavel Begunkov wrote:
>>
>> On 7/27/26 13:28, Oleg Nesterov wrote:
>>> pipe_poll() unconditionally sets poll_usage on the first call, forcing
>>> anon_pipe_write() to wake up readers on every write even if the pipe was
>>> not empty. But this is only needed for edge-triggered consumers: epoll
>>> with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
>>> poll() and select() users pay for it for no reason.
>>
>> Sounds good, especially with prep patches you mentioned.
> 
> By prep patches you mean the
> 
> 	With or without this patch we need to update the comments to document
> 	that io_uring depends on ->pipe_usage too. And probably rename it to
> 	(say) ->et_poll.
> 
> note in "v2 0/1" ?

Yep

> If yes, I'll send this change as "v3 1/2", rediff this patch on top of it,
> and make it "v3 2/2".

I should've been clearer, no preference whether it's split into
2 patches or not.

>> The only note your problems are caused by IORING_OP_POLL_ADD, which
>> is not that important comparing to other polled io_uring requests,
>> and they also set EPOLLET while should be fine with level. Not
>> asking to change anything, io_uring should just stop setting EPOLLET
>> for them. And IIUC poll callback implementations don't care about
>> EPOLLET, at least before this patch.
> 
> Sorry, I am a bit confused, could you add more details?

TLDR, io_uring has something to improve internally after this patch
lands.

> In particular, I don't understand the "IUC poll callback implementations
> don't care about EPOLLET, at least before this patch" part.

I was saying that from a quick look I don't see any struct
file_operations::poll implementation checking EPOLLET. And if so,
it makes changing io_uring easier, only need to consider this
patch.

> Although it seems you agree that this patch should not break (change the
> current behaviour of) io_uring, 

Yes

and right now this is my only concern.
> Can you ack/nack my understanding?

You got it all right

-- 
Pavel Begunkov

