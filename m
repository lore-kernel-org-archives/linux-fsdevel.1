Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000F3EAC82
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969080; cv=none; b=i9FciZc2jQ2r6GYPdxwGw27e1R0tFQzxNOr5MKsvXjVGC/Ui2KazCojqvmR2bVe/PWDdo8ZMtcd2gnubMd1jaoYVDzHSAEuli5CIcIiz3N/Px7bE586kwLJ+Z45N/IxauGdokKscm8uPGiKSDgGsimSuh/DSp5gqZtpeXIjRWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969080; c=relaxed/simple;
	bh=FLeP3R0wxUYPX2i2I8xsmPuz7nUB+cvC8EdEkIrSGVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=csPNETaHL6DpDh03bA/EYKjknQsYwMhvt5VKJpqPFmYAB1OKXewyPlFOohkUdjjJeHrVGwXIoH1tV5nTkZA8JJTJvwKjCmoGeRpo23ryS0IRMTLlxElA/5XqrOPHlKb5B5rKpHfBzGpInhcc4QYHosZA5MKlKrye37BJdljoCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=kPUX1jSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=USuYm0lj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="kPUX1jSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USuYm0lj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 317DD140003E;
	Tue,  5 May 2026 04:17:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 May 2026 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777969078;
	 x=1778055478; bh=g+tNfC/v4bnva0UsPQrDhLCVfzIbJpsDyk1y282O4Wo=; b=
	kPUX1jSD0jK9e0SNemeTEmKVLvoDZVRhm3Ju2ldre/wtwgcZvinBb4agdyAJ0+cR
	/GRPFeyUj6feEWXhvLASMcxow9acggw6/TyxhGLODomFoTM1yjl+18uL8/0ccM1Y
	nmGQwbJngOjaAoSuRywbpWAzg90SF1UCxFKd22up9vDkwnSJj6YU3YoZSela9OLO
	e07D9JjW5KWrujklH55XqVut5d1lWUE7yqCvE/GpKhMiyJn/RG6eBquPHOy6XJIN
	EX9wovT1UkIt+g+bMPzKDxG0SqIEPj6wG/WBhH2RF714s0hWAQBekr1RRCP8cyRt
	yZO/PyMU4yCvzOeDVkN5Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777969078; x=
	1778055478; bh=g+tNfC/v4bnva0UsPQrDhLCVfzIbJpsDyk1y282O4Wo=; b=U
	SuYm0lj4Js+3Rd66f4c+DmPvpHx0lYgnMk8gDQh6deazDz/vJZxWBtQ5ZBlIEH33
	GZbGni70hHcxzXQhpnOpEGSHbqlxB62wC+eReGHj67DLYe4r2nn4jld9pqeWhH1X
	1hvF0sLOLkZ4V/jPHkBcwJkzmYa8CHgWYa0imtu5xL1ciPNyLfZlHhB8YwW/WkCX
	KacrR+c27QTgzryQ0ALPUcAuPr8ih7WJdXPjUuUJP6ZHNVss0U5scCBwvvjLf2Av
	1OcUsxynwqr7gxhvVjMLhnV/LXI3H6FsHViII4u0ErJnCBQ7vUyVvgCQ//iTjTG8
	M5vFH0LdoBZVE8GVpRgug==
X-ME-Sender: <xms:taf5acntgh0DMOq8xgsTecqy1mglc3vy4Yh-dUfryBAAjsjgok_Suw>
    <xme:taf5aVJEm5ngYkHQ-lawayfICkFIeQ4rMPb3L-01xC3qX7ruPbFwzoeHlpndNTuu8
    P450YngSsbae1UWjx8WXz75Qe-7M6K-1D7A6dcbjY_SgyQ-G-g>
X-ME-Received: <xmr:taf5aR6Si2RW8pWrSM3KB9irStjIQtm7tUZL_3klCbAS6qm9EfKw21iuTTYc8-8hvck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeelleegudduueffuddvteegffehudeuieffledtudehkeehffegteegfeeh
    vedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhu
X-ME-Proxy: <xmx:taf5aZ1JjHui1DhwMR4gMAtXEEQsaToRIpTVWwbmYlDHh2bIedNEug>
    <xmx:taf5aXfcorXkJUEL-NKjlZwm0l1Ho2tjxxJM7-qb9Vdk1I-Ha14ClQ>
    <xmx:taf5affM7BZVwbxdf0OmHHoDs90jBFOyctQmy8MzamfAZMQ86timqA>
    <xmx:taf5aSwL8ZMywLyKLz9yhtXCisZqDPExCJr3yJ8OSlQ4qKokLb2MFg>
    <xmx:tqf5aW1OGk7bJb4MFuzRsbS6vEYMX9-mZTYUiUACS4IyrfC1rxROwzzn>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 04:17:56 -0400 (EDT)
Message-ID: <52bf2b08-49e6-4484-8222-b0ef8473b912@bsbernd.com>
Date: Tue, 5 May 2026 10:17:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] libfuse: don't use SYNC_INIT unless asked for
From: Bernd Schubert <bernd@bsbernd.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
 <b023fe55-c8a5-40ed-be37-a21e1682b509@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <b023fe55-c8a5-40ed-be37-a21e1682b509@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 09:30, Bernd Schubert wrote:
> 
> 
> On 5/5/26 07:23, Darrick J. Wong wrote:
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
>> maintain compatibility with older fuse servers that only support
>> asynchronous FUSE_INIT.
>>
>> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> ---
>>  lib/fuse_lowlevel.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index 0e16845d2f14ff..0a801132590079 100644
>> --- a/lib/fuse_lowlevel.c
>> +++ b/lib/fuse_lowlevel.c
>> @@ -4475,9 +4475,9 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
>>  {
>>  	int err, res;
>>  
>> -	if (!se->want_sync_init &&
>> -		(se->uring.enable && !fuse_daemonize_is_used())) {
>> -		if (se->debug)
>> +	if (!se->want_sync_init) {
>> +		/* SYNC_INIT is required for io_uring(?) */
>> +		if ((se->uring.enable && !fuse_daemonize_is_used()) || se->debug)
>>  			fuse_log(FUSE_LOG_DEBUG,
>>  					"fuse: sync init not enabled\n");
>>  		return 0;
>>
> 
> Hmm, but mounting is kind of a libuse internal part? If this is really
> needed the commit message should mention the exact reason - what is the
> issue with old fuse servers and sync init?
> 

One reason I can think off is if the ->init() method starts new threads.
In that case we could still do allow the new mount API when the new
daemonize API is used.


