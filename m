Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE7366054
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378438; cv=none; b=D5agAIUsddieixtVBuroZpr9ewhficMj++wGY/Qn59nmP31C50f6ioo6cNuU+KJOGZEhcZt6aX6s8y3vv+g9kxY1tTES4ECaYDHhiCT4H3lUTzWZtw5eaFvu0qX6JngcUqLsJkjW+BEDmniaCresqEfCj7p2Spdk09wZwERpZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378438; c=relaxed/simple;
	bh=9sieAvGfiYhJohor+xl5LUjdDcgb1gdJ02VmCNMJQjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa8OBL0vOiqLdbuqs2qoU/p2JH1glr4yMGI4X6ZEawFA024SfIDk8TbEuIesJ6EkMD6aTK2GgmMkh2OoaV8lAOE7nRkY4q362gnuNy9kW5cGuzXiWVnUVxpl+MNGBdLMwzACRmFtJH+jAQQIuAXjpvIuxkuu057ADkUmsB/grj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mrztRsuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKhSidOD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mrztRsuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKhSidOD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 36B56EC019C;
	Thu, 21 May 2026 11:47:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 11:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779378436;
	 x=1779464836; bh=JsuZBPHcrrw7tRXH8rx7yBoCDbJ2YtUCtxhb3cU1wQ4=; b=
	mrztRsuY/+Ede2heD6QRTYroAOcpTKjorTtczCYs1slNdsRN+CCaqJjLtkSqbcxQ
	g6YrEZvBOphOwSZuQJ+0CX8iSrT7KSRMhi2YP4iCd/LTMujTz5dya51QCOGWNLFB
	AS/Iq5W7f4zdCf7an6ubca6MSLvRPt8rgAMhe+vBc1ZoSVT1f55Fl1k1Ypx+/bN9
	hjQl9SlRUrL0q6FSvS0RYlUD7OoIHXHDJvUxYKqCRvuhVC+mUTvTGb/pCEb/7o++
	HAuV+vMXA51hnlF5UMMLWhtEcukD4Y3Q+2m0O6wv34NJIuKQzcW8BHj7dydomDF5
	wpImMDYosPy3VWQ97dDskw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779378436; x=
	1779464836; bh=JsuZBPHcrrw7tRXH8rx7yBoCDbJ2YtUCtxhb3cU1wQ4=; b=O
	KhSidODxrQBWwV4g9nRyeShxtoyefHoLLiJIUB1D543+vttjsOsxsAaC/TPTtoiW
	0CRz7JGAvH0byvp9U1IkoKG59RzgfWfW869wT6yUiD5HRK05xAAcE1MtWlrVSulz
	02TJSY8UzXiLuYKnHSpdcSU/O+GSpK9lFQYUg8tdNov1YDlJgrwpMauGSI0QJnwB
	2qcP+1mzKrHk89p6GyB1J6w15nT9oJevXYwA7HDpP8B1EFrjcyb+TorF0Xymv4Yi
	+gi1RnucHwGu8AVcYLZAOKBCKXxY257V1Tkk+JmVvR/1rfq94CQv79Qw8iNjq50m
	/4ilLdScA7Z6FEY6nc5Lw==
X-ME-Sender: <xms:AykPaovSo34ah2Z01xgjoenW9rI4iWBVvs8ZU-O9BzVSiBc7h00psQ>
    <xme:AykPauz2-qCQptqVLFPLPkwaFbIIRQskG5sCyRZd4UwLuE8pyGqQjziqq5YD6jN32
    zZjAxCzp2eYLER_uEy-d_zhthTqpY6JDmEQ0FR-oPobsS4s5no>
X-ME-Received: <xmr:AykParD5uLT9c6hR5DH4HoovmF9yV7bfyGvVR9hZ17cyGYVv4GcUtWgiMT1nmD6e9I9Uw4S4TdWBtNWXZaxIPJDnAd3b4amJCjZnIKFKRu7MZdrItg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuh
    igrdguvghv
X-ME-Proxy: <xmx:AykPaseOhoD08Y2gbVqVraQmYvrVn_JFcHrJovNDGihMrmhRU_X9Ew>
    <xmx:AykPalkLDt01rYE-hAcYvJEf2GzCk9x9gSySiw_CJ_UFcGyqWRrjZQ>
    <xmx:AykPajHPBmDWlNHbAS1t13EkFSh8ERQzCbux6_ToQ0UHXqPROMi5vQ>
    <xmx:AykPat4ZfGs9GAcp3ZE7kWhsHH_-towsi-L5DaDMEYyoEgcaLPFrKA>
    <xmx:BCkPauW1MOMNKFjRcZxuD9E2IEIIcTihqu9KtRBZOxb0cljmsqhBkfxh>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 11:47:14 -0400 (EDT)
Message-ID: <cf4e5b0f-eee2-442d-9e91-3df516b84d2c@bsbernd.com>
Date: Thu, 21 May 2026 17:47:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] fuse_service: fix uninitialized variable
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241518.3536631.717770834444587345.stgit@frogsfrogsfrogs>
 <9954c0ab-3d5e-4318-9b04-4d636520d6ce@bsbernd.com>
 <20260521143116.GP9568@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260521143116.GP9568@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 16:31, Darrick J. Wong wrote:
> On Thu, May 21, 2026 at 11:15:38AM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/21/26 05:07, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Initialize the sockaddr_un variable so that subsequent comparisons won't
>>> fail in weird ways if getsockname doesn't fill out the object.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  lib/fuse_service.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>
>>> diff --git a/lib/fuse_service.c b/lib/fuse_service.c
>>> index d14aced29e8268..4340304eaf57b9 100644
>>> --- a/lib/fuse_service.c
>>> +++ b/lib/fuse_service.c
>>> @@ -388,7 +388,7 @@ static int check_sendbuf_size(int sockfd)
>>>  static int find_socket_fd(int nr_fds)
>>>  {
>>>  	struct stat stbuf;
>>> -	struct sockaddr_un urk;
>>> +	struct sockaddr_un urk = { };
>>>  	socklen_t urklen = sizeof(urk);
>>>  	int ret;
>>>  
>>>
>>>
>>
>> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
>>
>> And hmm, we kind of have a test issue - they passed. Uninitialized
>> memory is the only reason why there is still valgrind.
> 
> In theory it's unnecessary because accept() will initialize the relevant
> fields, but it's easier to add the explicit initializer than to spelunk
> every C library in existence to make sure it actually does.
> 
> I wonder, do we want -ftrivial-auto-var-init=zero ?
> 
> Downside: only gcc>=12 and clang>=16 support it, and it adds overhead.


I don't like initialization to 0 too much because it is often not right.
Simple example is "int fd".


Thanks,
Bernd
