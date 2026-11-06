Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964971;
	b=Wyo3KpmciYXtfxxDvFrAN5Qchxrz2dyia37Hs0cf6G/tIViSL3OYtmKi60MCSyyvx7Pa
	 w2rVnBeor7AUrEhUS2IBnlarLB3W3bjJ93crT45p9EoqRLNItZn3O9bP4JbWReYu04556
	 uCHOKJ/CX426uFYuEUhA4xj8qJvMPmhOjvtVmhZ+Cvs8TPWvwGnUPJSUnkcrgqG5cqb4M
	 2QtM2vmQiCUrD8zGkcmRC+vWKEr5AVzWp1fBoikcZjJ5RHE6M/pKXwqmnIeDULxbZCrQA
	 NXB7rnS1+TzM/DdECq9wIABZDTvl5lddL9EEPmy9Jpeq0HbTrCxvUpeJ7UGbryjqFcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
	b=ElGCxDDrxumRVE2gL6rz8uwYLu6whKs4fM/deGkwiZZNRkL6SlwaISaPpkUprM7J7ZTv
	 OdfDLLpzDtIB1yNd4XKEpmy8zOhyn5/oW/0RW4+y/E4BZFF4U9OuK0OHbDEoVoQK4bJw4
	 +ixWyE3xtXDUln/2wm2cTte/Ix9jacgaYuEw7qxbWsS6hgJB0bi37nXsR3fL3patHifuV
	 JPkURj4xZ4MIO6kVpDmk3azXLsENpPhKMkacZvR0PxiU7ZS/ruMi3OkcRd2CHKtGDxGJf
	 L2rzij0v//9GR0Vjp6+jAsD/nkFPkl/4bGOAApVw5EdBJbtagNhxcPeGYl2nOEHKZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXeWgUVX;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A960A260B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998A960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXeWgUVX
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so748415a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964969; x=1794569769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
        b=vXeWgUVXCX1z83xkLBImjwxeEZ+/oy0hXtB4qBbyT7TOupGYjBIgrWZf3XE7Ew8xnS
         LTWciAqFhcO0hL+ROYEyXVlla17tgmlwpzOpKEOnTsN82RRR9scxap6V2dq/wbNh6Nas
         HXKHUavdKTnwj4OSUMGUtUDCa2qlIl2WfVZCG3QuL2ou2l9hBwXqnofxflCKqnEpBwCs
         +V4Huv+kLbW2cNzr1wl+hSlV9oLoXFhhEdeyInEfnXlttSY9k1ioMOQNOAdm7AFZn5IE
         Z1zZeCB30LRA+q90OOBgYtNBSW1Ahzgl55PNW064pKRsiwm87kBbvoU5PlRx5AZc53Tu
         Z9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964969; x=1794569769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
        b=ZpFBVQLtY7QKzE7aCBkl/1ev9AZzrON4woPqTb6bNjTFkS97GHT4IDU5FTrdzrEvWU
         riRh/Nop5t/G3QkUjNZV6jxKCUl1mAzec8EBiiBxhCq96ZU9Raj9+OXWPcrtdiy/cckz
         oatvvKVHTWHeiIyj7Fq8H24U0xURgwPYGTQ0aYS3FATTW8KFI/paysf6h7Z8cqwULaOc
         QhB9QZK4N/MDWhPVT4B4m4A9tr45Si4tFs5k3WtpasWt+uwR4bcHebAbzFhr9Be5hDEu
         Gg2O96ye+mitaLHZjGrHrF0FFfFT1mIbnhGZ/K6f7VmvdwsyQ2v6GYCgNSKKxgDjGsOm
         4sgA==
X-Forwarded-Encrypted: i=1; AKwUvBz2cWw7t2dGMJJOPSs0DO7N8b167m2KMiLAaUq9XPUKYxtZ5RvAAtYbqNXQu8cxGSKVGeMKLvpB6q3A7K8E@vger.kernel.org
X-Gm-Message-State: APuU4Z9q6o5ojMX2cjafl7kDzHA0zGu34Lt5TAA0MwYYx5jB7DW6qSSs
	LHKDLiBz2tC0oEJFvNsQYCk/l0xKKWgKoozg653IYBN0zuIwUmJj7SOV8BSFOxzzx01FdLFb
X-Gm-Gg: AYBFou05vsQvV4BYBx250Wzg9oCw88SrrIb4pqGehjVlsOwkZHANwGeZSQQfkEbg9hu
	91VVVQUpMbaWNwnHWta4UT3TtAuqXwWdemri+1riQ6fq4RQLWDzCbmsUCRIg0M/L3/Z7dqQFCTR
	CnyVRkUtNsoXTZV9t+jeZozWQ1MquXifTH1n5npP9FZuHo7LUEzviGuBW0SOF+kCj/TqxVjywBg
	/SIjwabvf02TRPVoaLHrXwlrk/jRBsPZvXdapEK5ozSs/49ngfJsOPRybHMOfKZVGwf6kGr28yo
	AMF4eGQWu5Dy0TUhF24AIJa08tQ4aJkGfacoGzFfyzLT1D78I2f5pWY9V1FeQDM5Z/auvU7hIUt
	Fab8T/dQhZn4dS2P03Roir4Eaiz6GtCDOuTeLo+ndvFW1xrvLxDYCAB6yaeCHy0E93keKeskW4j
	mal8NrUwJXH/UXFh5Vl3RUPVXpARYy3AqayHLd7+tZG/+tnnXVuEOvjO4FtBBRnMNu428jXVmtt
	Yd3mGMHlgrT+p+S8NsmCS7Ch6gDpVwUuuzirLAFXMJ8kO4+R8bhu2Wmouct7Vcsd9/AkDEI3NR7
	pjIBt3HC6I7fyUNY6xsmyIjfQENfqWdnfoGt0auBWZTHHa33PTC74DrN4av8aFBbnM4l8i4Dj8g
	Te29Kw+krJPj1Mw+baJ48vVLIrYMTIX+x1k/mYBKWOfmmuvgdHCuhyYHmP+9hnl3sES9qIwIcMF
	Mm08E6+XF1gHuRh9vHPWdSG5axK5BRF/Pf0xtnoasJo+LjCPl5Kut08rxyfRFjgsQ=
X-Received: by 2002:a05:6402:2b91:b0:6b4:602d:f1f7 with SMTP id 4fb4d7f45d1cf-6b597816109mr1452325a12.20.1793964968944;
        Fri, 06 Nov 2026 03:36:08 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae5692sm615592a12.17.2026.11.06.03.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:36:08 -0800 (PST)
Message-ID: <4284c2d3-75cb-4e41-aa45-f7311e60ab4a@gmail.com>
Date: Fri, 6 Nov 2026 12:36:05 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
 <20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
 <auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net> <au0GBdGqu6cv5PMy@linux.dev>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <au0GBdGqu6cv5PMy@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 23:43, Jose Fernandez (Anthropic) wrote:
> On Thu, 5 Nov 2026 12:19:13 +0000, Pedro Falcato wrote:
>> Thank you. So, if I'm not mistaken, this is the race:
>> First, you map/see this:
>> 	[folio pgoff 4, length 4]
>> Then, at some point in time, someone punches the hole:
>> 	[no folios here]
>> Then, at some point in time, someone faults another folio in the range:
>> 	[folio pgoff 0, length 8]
>> so you step backwards. Is this correct? Or am I misunderstanding this?
> 
> Not quite. In my test a large folio goes away and a small one comes back
> below where the walk started. If that happens during the walk's first
> lookup, the walk can step back. Krystian's fix doesn't cover that
> lookup.
> 
Right. My patch only covers the case where the walk has already
returned an entry. The first lookup, and every lookup after xas_retry(),
starts in the XAS_RESTART branch. My patch does not change that branch.

There, xas_load() can read the sibling slot of the start index before
a concurrent erase, and the canonical slot after it. In that case it
returns NULL, but xa_offset still points to the canonical slot.
xas_find() then moves on to the slot after the canonical slot. That
slot can be below the start index.

I tested this in the userspace XArray harness. I wrote that state into
a node and called xas_find() from XAS_RESTART. It returned an index
below the start, with and without my patch.

Andrew, Jose's Tested-by for the xarray patch is on the filemap patch
in mm-hotfixes-unstable.
-- 
Krystian Kaniewski
