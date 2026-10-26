Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000384;
	b=4rcl6hRNZXi+cL5NbRxL4dZF+VFDMglNJXV3ts80hwxun104YIgI7Pjr8TWY2gWlDj5L
	 /ySJDtxNBWxa9wCSJId0PrgoW75PuTsFQPEIgAGSL6DXUDLAzXGH4k4wGDza9DJpZ2LUM
	 CTsQe4wQciuTb2CqSstIMc+SqoJjKAqL3rfHVgvjEfcctKjSkUFNJTPorcYwLZhYot/O7
	 zcauTyGPSoP9R6RFt8xj2tSyhlzTWD40iFxJjEYuHULhzdxJyaQoNgFKMPMnio8wAlFX0
	 Mft+jmbYJ6rd/no5SdmcAGbiPFnJpcyRB7sbsjPLCmRj1zZOeDrGHNcuIoa/Oq+ZYFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000384;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=y7rMtNEmj8RP/Ie2Tkpn7XyZKLs6qIaLRaODfWpvLLE=;
	b=FWT9AqNU/OpDpQP3eaEG31UE/Gg2bg7DGp/v893Iutit9MsPd3yI0t2wfIlmditaSLXn
	 fvN5b6ENUSYTkla11Au0N1VA5MwyCJctakGePT98oOhQjJ4rCxo31BCLCinCRz6dS4fxQ
	 4dAMFaINizuxiVPCmsf4OQg7+6GNychzs2VSqf0QwcELWVSzLhLlq0Wd5dpi3u1co0KFJ
	 xnca0dC8MZU9mGoOOyEn5kwB6q+qQu5pMTnP35v1ist09hn3CypuTBI0AmqejMbVRP3cJ
	 ktkE7HphZ2+Rgtb5593CUSwMZbmHj4zopBot428qPkfo2aOo5dGJllR1goJh8DNUURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=XAV8to4M;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=e5qLOOEs;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21354606A31A;
	Mon, 26 Oct 2026 07:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21354606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=XAV8to4M;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=e5qLOOEs
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 291AD209655C;
	Mon, 26 Oct 2026 16:39:41 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793000381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7rMtNEmj8RP/Ie2Tkpn7XyZKLs6qIaLRaODfWpvLLE=;
	b=XAV8to4MlASI92ZZ4Y++BsVyass7q/oR8mlDsKzN3w7BRtv/cif5PnITtsj27Z1x8DM8CF
	4BNT7/cylcjj6oRZ6bEeEwwe+qsTvQJNaliDBsxc/HtmSCupRwa5sddBQAw7aeRthJZS9O
	Kux69XAieW7WMecZXsvrRyXZyI2g9W0XIKYC+RIC2Qed9uDElsgMoUVE/zTMGUdDLu3L2O
	KzbfiIb9OyRrt5sBPhaYw09tfNk+G0AjDMiVvxXqYQ1/1BMyEn0FuZO7YIKNM688PZAsHr
	/O+9REUBEBytCH/h6mOZk0Q1W2YZDGYdjs7v+HRByLuhO0VWU8vVAyiQQSi86w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793000381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7rMtNEmj8RP/Ie2Tkpn7XyZKLs6qIaLRaODfWpvLLE=;
	b=e5qLOOEssTVR2M/bd35xKtnR4KShxcL02+wlX2OUAxJJwmKq67NESQmXUrAHMY6taOpBS2
	T6Hfyt65/x0ZCzBw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id AFD4DE000CD;
	Mon, 26 Oct 2026 16:39:40 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 9BA38220019C; Mon, 26 Oct 2026 16:39:40 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fat: batch synchronous mirror writes
In-Reply-To: <87ecdchpzr.fsf@mail.parknet.co.jp>
References: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
	<20261025191006.407209-2-matheus.aalmeida@inf.ufrgs.br>
	<87ecdchpzr.fsf@mail.parknet.co.jp>
Date: Mon, 26 Oct 2026 16:39:40 +0900
Message-ID: <87a4o0hpvn.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
>> index e79762cf1975..f8f89b947baf 100644
>> --- a/fs/fat/misc.c
>> +++ b/fs/fat/misc.c
>> @@ -365,3 +365,9 @@ int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
>>  	}
>>  	return err;
>>  }
>> +
>> +void fat_brelse_array(struct buffer_head *bhs[], int n)
>> +{
>> +	while (--n >= 0)
>> +		brelse(bhs[n]);
>> +}
>
> I'd like this is noop if n == 0, possibly easier to use and safer in future.

Ouch, it works as is.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
