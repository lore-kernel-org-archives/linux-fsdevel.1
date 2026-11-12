Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459835;
	b=MWuSpOivz4CQV9tj40OWkfMCZNJNeIqu6KcJMWNdtc5FOqxAulqMpp34ozN/hH1Myop5
	 xxodWtQkALfrmxvLVHNYpFFqPoWg2AoH8vCe39WDDkkYowPAr7qQUDmZcKWcKIEf/ttxD
	 aundDYKaBgF5FKDn48FUbV/TGpajDSETM63GI+bsJogVgBXFQel6t6AvIp2eXSBFujoE5
	 47JNZ3Ld/+QKfPyOqX3m3hPQgPL1bTH5BStz4+pXChrVQF2jOyr1suVJlfggCVgu1Vs4x
	 PVtlzqG6UGdHlGPM0vbKHznWzRdj7/BvOMuUZp56mVZecJsY3SJNfBcEZtnyESygfFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459835;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UeYgHF/Xeg3r8CXbaHvO3Eio1vrbMNMFQ0Df4D/SalA=;
	b=BbZxlZ4IwE+4ShH3ZtLDTJe9IxcIxHuofhcZIBCNlLPU3okwUodONC9eJuUvve4fEF3x
	 lO0c+AIGRq7u6oCVcB7yIglOvo4llAKXFXxi9wD67JBC/Vyp+zEUhVmzmUl2LRa8DDYBt
	 qm65wS0PIW14WnxuAe7vXwydO6pMUf2+H55L7LqirLpmDR8/rqx2mybj+RySc/3eTJxK5
	 NQn+6QKU+e5N59OddPJWOVkeVp6S7erF9GuN6NHCaWBoo1EiSxHWURqR1HMZdw3Zlu5M2
	 oaLTpOv8IjB9HsZPPi3uyqzpNyIU6r0Iq85K3gZ3GzMvvcR1uQLSkGHE08ZjU0rQeQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=4dhdHupb;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Odx1hnCu;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1644606A324;
	Thu, 12 Nov 2026 05:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1644606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=4dhdHupb;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Odx1hnCu
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E1B6B209655C;
	Thu, 12 Nov 2026 14:03:45 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794459826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UeYgHF/Xeg3r8CXbaHvO3Eio1vrbMNMFQ0Df4D/SalA=;
	b=4dhdHupb8d/Bbw+Baa27sPaHkm6oYMaJSgkfNoE1Xmcro86fYetO02NJORyQy7AQd/7iKf
	kFIMyB5lCz4mn2NpfdYPfAVnoZx+Uzy4SX7RgUc1zEC+JEvo2zqCmvYQEN6xMhk8py/nSA
	5c8c93LxKwZf/z/eGB45LeaEiYvdvLyfh1Zjsy0KIVWSlcwRMg07h0sMNDIcv98BCCNgZZ
	5icqSih6lUMVSfzErqUMw0EVlpQtu8L7//CIKOrzrMbDACCqqPQyGXrB2M3P5yhN0nE6Yj
	fvHiUTRCmheyzgKJ8tK6kLUJ9qiJM4R+GBYyNVZGKpd2kAS6ChoIQjWiIhM1Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794459826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UeYgHF/Xeg3r8CXbaHvO3Eio1vrbMNMFQ0Df4D/SalA=;
	b=Odx1hnCug/PpuvSnako3AbfmfMkVnFcqSeZh8X5DXh671TkJx8VhO0FjBJQTtfmwqRi5+S
	UGxf4eS/kf2W+dAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 6C6A6E0098A;
	Thu, 12 Nov 2026 14:03:45 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 646942200263; Thu, 12 Nov 2026 14:03:45 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] fat: support FIEMAP
In-Reply-To: <avU3IRmswObU2pH6@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
	<87tslrtlyu.fsf@mail.parknet.co.jp>
	<avU3IRmswObU2pH6@DESKTOP-PJTTJ93.localdomain>
Date: Thu, 12 Nov 2026 14:03:45 +0900
Message-ID: <87cxsaabf2.fsf@mail.parknet.co.jp>
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

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:


[...]

>>>  	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
>>> -		/*
>>> -		 * dummy, always not contiguous
>>> -		 * This is reinitialized by cache_init(), later.
>>> -		 */
>>> -		cache_init(&cid, -1, -1);
>>> +		/* Cache the contiguous prefix from the known first cluster. */
>>> +		cache_init(&cid, 0, *dclus);
>>
>>Doesn't this add a needless cache? 0 is cached in the inode itself,
>>isn't it? (and can be waste small fatent cache slots?)
>>
>
> This is mostly for caching the number of contiguous clusters starting
> from 0. i_start only really tells us the first cluster of the file. I'm
> not exactly sure of the best way to approach this, though. I guess we
> can skip caching when its a one cluster range in this case?
>
> What do you think?

Ah, sure. I think because it is fat_cache_lookup() and stuff are
implemented for nr_cont == 1. So I think better way would be supporting
the range lookup in whole cache stuff. (however, it can be relatively
complex)

Thanks.

>>>  	}
>>>  
>>> +	fcluster = *fclus;
>>> +	dcluster = *dclus;
>>>  	fatent_init(&fatent);
>>> -	while (*fclus < cluster) {
>>> +	while (fcluster < last) {
>>> +		if (nr_cont && fcluster == cluster && cid.fcluster != -1) {
>>
>>cid.fcluster == -1 is possible with this patch?
>>
>
> Good catch.
>
>>> +			fcluster = min(last, cid.fcluster + cid.nr_contig);
>>> +			dcluster = cid.dcluster + fcluster - cid.fcluster;
>>> +			if (fcluster == last)
>>> +				break;
>>> +		}
>>> +
>
> Thanks,
> Matheus

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
