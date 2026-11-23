Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414286;
	b=m74MXK5U/Ii/cF5P1/MK0zWND4oW10C5AzXzjIm0iRmwxZoMTpkzBQrFrdn4h9bCQKc4
	 KCnBm2zLToBqicbDbweiPOabdWBEm6Vd6MMC13F83h5syngC2hiyoqwau2c7hiN26rfGg
	 zMG2VfiPZOBZxZ+UhLhF77VFe8MoK91VX5d8lj6NDo/kc1q7mNZxqXV0cxDIMNTkeuxrX
	 zQA+RsiCdyffwVdyZUpVa6Z5wOtdxtU0oJKfXbQfeKolA9tUbfm2bMWC2ZsTmFbZWDChj
	 2RbCJvqASulogEiJqUvVyRJe5afdD1I3j+3W8C8HY5JF95wjd9HQ7vpWvLFw0YkY5Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=GwvMLEpH06q7oweFh5LKZ8RQkrZMsU7+3f+WbZdQx1g=;
	b=DETkVyKDY6GPBrh6SO3jKkWYTPa/AExYB1en/GMRZGLB02GGPSZ8szhNBCIYLEtLKAL4
	 9IwMxtDz4pVNfnpETrEo0Y9c1kACWydBexUQdw/JB5YfgEeO87KxHh0iyKkRc7gkCXFme
	 +p3jQ2ahVmFEHkxBOHC39ffhCr7Y1EDtGIejl8BjzVm7OiMhAPW41FE18U1hJS88qo8ps
	 vWKeLWPJUeSCxSQ7Cl9ht6w/52Oe86AVx4wXPRq62zZDibh5U8PYoXbSC9udFty8Jll8x
	 avZWaaD7vgxR87RjgyYshUg04rJnRpw20ISyU+04XG/7bo3WQJdMRGPcuktLA0P443Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=AuJUjnTC;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F334606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F334606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=AuJUjnTC
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67da564d9f2so3821802d50.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795414285; x=1796019085; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwvMLEpH06q7oweFh5LKZ8RQkrZMsU7+3f+WbZdQx1g=;
        b=AuJUjnTCDQjW0sRwRqkQGsiRz50XnJQVN/9h3eRtAnqxV0IaqTgeMpJuWE3mreXHZ0
         u2Dw7h3nBX3Ar9XXtj4bp43M36cLvvdQYcjsAAxJFTaMuMtU3M4puk/LB+8kTFQZupyX
         eyIfE+2JhjPpcsCBYSMq4yMW+VCdu3YJiCIcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795414285; x=1796019085;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwvMLEpH06q7oweFh5LKZ8RQkrZMsU7+3f+WbZdQx1g=;
        b=vBF6sdsJB3WcrKOx0sg/VipugHlOo+a2+UaVkzOH3RDxwTQ/d1pSMi+9iMw8nqwLyl
         sIaiTN7CkSTtPCjsC4WsQW3A5RTCZfc5HpBV4Isx83Exjvsz3fVpCFVPUoDJEu35p7K6
         CRWSNYRZ/ZfBAnmoaS5F4YT3SmXJsuV69l/Uz/cq4p42oeZbx+Z27GpvHOT8Nad3J9Lc
         Um8cBySxnrzoDVAqk6Szbvieusg+NSdHhiHeYuA2HmQea/0bUCzWsjnVbGxIIm26he0g
         Z/46aTl0rZqF0QuJxOHECB/MMLMGs7IWv8CdO+hfPmGDUhWOGII05ZcXcrCVfq42A/9G
         /crQ==
X-Forwarded-Encrypted: i=1; AL+hErHo268yrbpNBmtf9pan2D7XqwkLXiRWQR7GH5Tp8V4iS2cQBlz4u6N9x5aft8BoX2mTDUbtIjD64T6Xrxyy@vger.kernel.org
X-Gm-Message-State: APuU4Z92R7AWjxfpKQNOlNlZxAPhoMRepOrooW9joXltv6byKx03JJ2z
	0JIIuf+O7kBcpre0MgwGg8/HveCnp9qtsCsPztn/Wrs03s56H5jRpT68OBhIgECHYPs=
X-Gm-Gg: AZFdTZeYVQiUmGPK7VM0YZ7eUElA9g+Jq1nhkBKtKjTuIdvy2xYUOJ4Zzu74O5J9d8+
	E+DbSlbJUeZCI/zWW1Y81nVnY7GTytW61wUTSc/rbYHsQ0zMehmJihhJj5mDZ/DWDWPd6OP9Gfm
	QuZQlYDNex2NX1Vgp/t5vwt0VLzDhGD+cXWFGz6v5H1WHB67Iu0uVuDMq4ZaGNr3uCYVMCTT0rl
	PVEZPCShOFLNqcqkiPoFbkUTzFnLskHiMvajreI3hHf0yzSzGmUbiX42eTMdTMw4dgEJc4Li3an
	PHe3Dlx3MwsSjz/lz7Fg/x0IdKfyhvNG382rb4fXCBsY77MfQ6D7imJB2VDDDIXBIoSu5GriPtA
	NTTEMUAd08qI+IaxKgoDRZNlN9+vIa2u9u7KSV9kVEV0t5nClbIlGMbFwD4EeDY4NjUc16KcS4O
	cU8pGFH5SUnDGNOlwGOxG6cGngXxL/8GM9k0Pg9vkoOEZll7r0+S4Q6ybTeDOClBEP0ZbZJz+yi
	TNBkFcKzaf5wxdi5kJcADfOguFo+41CqpO2h3hjgxU7gxp9PpZKgSDmEgzkAyYhTmy0JUfBmGDv
	Bmqj9TEhy+OFG2Xzk6L1St9x974mIo6JBqpZEFGqQWbIR6boVQxxVmkKhb02qtzyen90sbbeI05
	BEmliSMon1z2FVqhQ6CQQuAROTuJ2qxHVwz/PYpbTKAlyk3ZLt1jNn/SEJihNxn2o/gu1lv253L
	0QvbQEeoR9aImHx+HFmUvGiORjhiBA/YRZDe4b/aq2cDfnWTwUkmP3JiVutQ2fBS/Luzoacn/Z1
	Gwpmm1JBSE2ks6nUiokuAOUXic1CGzANxPyvH8a4X9H
X-Received: by 2002:a05:690e:4012:b0:67d:c046:4f71 with SMTP id 956f58d0204a3-67df43d2bb2mr4679580d50.23.1795414285477;
        Sun, 22 Nov 2026 22:11:25 -0800 (PST)
Received: from [172.20.0.3] (static-host-74-205-137-217.epbinternet.com. [74.205.137.217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bc515sm43136087b3.19.2026.11.22.22.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:11:24 -0800 (PST)
Date: Sun, 22 Nov 2026 22:11:21 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] proc/kcore: allow disabling /proc/kcore at boot
In-Reply-To: <20261118-masken-disput-miesmacher-27d6baaae6a8@brauner>
References: <7c10f2e01b6f19229c83e81d887a87f5d1151841.1794904698.git.chris@chrisdown.name>
	<20261118-masken-disput-miesmacher-27d6baaae6a8@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <awPZCeNqLKVpnbKj@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Thanks for picking this up!

Christian Brauner writes:
>Iow, it would be nicer if someone took the time and came up with some
>boot setting that is a list of memory protection settings instead of
>spraying ever more kernel command line switches that nobody can
>reasonably remember or use.

Hmm, I agree that would be nicer, but I don't see a good way to do it. How
would you suggest going about it?

In my mind, the model one would have for a list like that is mitigations=,
but it didn't replace the specific switches, right? For example, retbleed=
and mds= have nevertheless stayed. In that case, the list sets their
defaults, but more specific switches win out over it.

These are the problems I see with a list like that:

1. I don't know where the list would live. A list of memory protection
    settings in procfs would cover two switches today (that is, kcore= and
    proc_mem.force_override=). Anything wider crosses into mm and security
    (I have similar switches out for slab hardening and mseal, for example),
    and it isn't clear to me who would own that or decide what goes on it.

2. Lockdown already has a list of what gives access to kernel memory,
    with entries for /proc/kcore, /dev/mem, kprobes and so on (although
    not for FOLL_FORCE), but lockdown= only takes the two levels.
    Selecting individual entries was proposed last year, and the lockdown
    maintainers turned it down because most entries can be bypassed when
    they are used on their own [1]. So a wider list would have to be a
    second one next to lockdown's.

Did you have something specific in mind in terms of a design and what it
would encompass?

Chris

[1] https://lore.kernel.org/r/2vldrnqs6fbljqqp6vbwmkushx6dxcpephgb6svmu5i64lijpy@lg37aflddv3b
