Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200755;
	b=CFPM5yPyTLKsmIkJOc1+citJ0eXG2FWhK+9crDJq4RqvnUa1/3uQjydGJHZPwaKTZ+Fg
	 xNrpWuxP+so3vYP9pfYK7ynvOgfSG+kxc8wmBM8hs88JA+Lwev0+AEpBMh42EizcUL+a6
	 6nTjo9pNP5KKNzCloeGR19i1VLGii6g56FKPw9aTvmoPUy+uGJPY/TsTHEqs2Fa1CaO2R
	 h5YFcLF0DcyDENrgjYFiNt8ObjfDxWI++m6Vrr71JugVYb6ukhja1wZnuQ+m8Qhl053WK
	 Orq+H/yAb7Dx7EA8zJaycGWroQEIGrnaJMBxUJFyrmIrzw6wQVmtyhqj7kgCNFkkYqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
	b=uRT/OIh7AqYEHp1MntYA8U3pEhA5LkWklrFgOk5HkcZRJeks+0NZcMnN2VZjoD8EyiKF
	 t95lu/+CMH+cUCvADbbSIsNsK2yAUlBjxgNQ4xCxjQguFYfxlNFUdVVbfw06ffmFWwvuC
	 G0HimFoYQqjptQib6zBOuWIVbuMj2kc5tNJ85a0kG919dQ06uSQHldwgBnn5fy0gY40mD
	 yRaS2LcdpZf4+bTbT/tLcdarJ5y51kdu2fDsdA8QxPbWM0Tn1rwNETyK0kqrXwB9ccFGQ
	 qdlcT0evZdWo3AltOBSgUsWgQkZG+t/5Jqy9ohwAgATRNBPU6jeNhoNkNXycCkaz+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nhK8cGaG;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE0606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FE0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nhK8cGaG
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-676804a3a22so1147720d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793200748; x=1793805548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
        b=nhK8cGaGFswEzQzn6jxV8d7rWrcdufVj9AiZWeEMEA/Wupaev46NciUKgGJUUt3ByL
         uao2VGURsbYEidWyayLH3DVOhUbQRhSYSuzIu28/fAoxmcIG0WedVAvdu5647p5yknP8
         kWlj+kneMmtUzA/yOYN4x6liHGLFt1vXF82qlxKhaZtv3f+2egWqfsBb2ENt6uJ2RXAK
         NM3tLDc6FE8jxJ7UEeKozD6X9whokC1ta0k/a68oKBzaoD7h1PjK5rMScjVHyC+rtG+2
         yJm2ktJusv8LTxfcvqDJq5ure6P22NbWO1Uf2DYmUx2A/mXHzlRtHpSXAc+UmBBZ4N7H
         mldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200748; x=1793805548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
        b=KOgDdxwmgVJk0vMRcWV0VmecWv3rqLlFZJbVHY9vdOSoFoNhWxq3nJuwOLWvnx/L40
         UsK5JNs5T0HRXm5VSAew+sO4JwM1g/z1HsOwvoBxtjWM2qnGpDBRSc26BeTZvl3N1iIQ
         M+vBtfnIBFH3lW45Ji8TPHS8nWpo0ilmwzMqiqS7H0FdZnefBNh5bQTDCddFQ5pkSmGX
         1A51vnWBw12HZcUeic3bK3yFM5D10YE78oPHzEaqqg+SiINCHUuJXGfZs6Ssctfw2oDf
         DGjt/ntC67wneFQSjbaZ99ZRAcuCPX1ta4HEcQdVV04iCVzmWbi8k5LbswzHgavYs1RH
         qweA==
X-Forwarded-Encrypted: i=1; AKwUvBzPeHHFZWVBzJX5BHTXry6qv0eBRO4V7CW8d0dQX2eRIMk0GIHHCdr7uOXeuPEmMj/wQRS4SsL4SuR0sxpv@vger.kernel.org
X-Gm-Message-State: AFq9FYJW/ZAI0YBgr3nyS3GyNX7Rfh4x4REp1UW+5UN6NtA4f4ofJndH
	ODXMtRosuSBUsLnkxtvnjjg/7E7qlGGHrdfLCbTyUajCIiYTgTe35wmVZrAUSMotXoc=
X-Gm-Gg: AYBFou1xQqWU0G/3dMVaTKdc4EZGMi1bJR77x64NoiYZ2v79ezGLyx0vcLg4RUJ8dnB
	2LpdOuxlQfafDOEvXf2fESHSVPQtnKW3FH6GJSoWAHOqcSUmAvmZWxZMDsyQ6RMAx7iuyqwW8j+
	Hf8QMNB0yeiylxyavuyWeldjk7CWYSvvLu4FXA6ozaDtFFjEiOru/MMbMfn/iqrRXgeX/FrqF4m
	v2RWLTdoAnyJwMb76mgKR5qhlIyvIfHdoW5AmJGUnQMet5FiR74pOBqqFyyJQM6NoBcoJlF0GmO
	0/zAqhneB4tYw3cCoCXIdELbL4wVgPElikmxoE1OYnecqT+MdC800v/z1rHqXAhrHVdTXlYPZf6
	AsVTzcKSwrLjChXDAGHZhQnA1YjaKPBXmVD2rB5/1sOMpRHYWQ+ww3+UJwxmGgmSiZlsjy/ms6M
	hqdBI0GceEqtF+RT/DCyDus4l6Ccgo9HOOCbh94bdywTe46rZ9o5KRHaMZ6LlO/nOtfrMY2uCh4
	TntAq1vqlUD7sYqzXDwD9Gzqq+/aomhQu4NaFyNsFHw+isn0rLtqqBpWQXrqiBtScxqepPlb3hc
	OgpcyShJA/Hy9qLbKL3qBRv7QT2L
X-Received: by 2002:a05:690e:438e:b0:671:4cca:b8ce with SMTP id 956f58d0204a3-67a7bcdc2f1mr1541191d50.61.1793200748154;
        Wed, 28 Oct 2026 08:19:08 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a19ac69sm1870050d50.21.2026.10.28.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:19:07 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:19:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org, brendan.jackman@linux.dev,
	david@redhat.com, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, hch@infradead.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	matt@readmodwrite.com, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking
 requests reserve access
Message-ID: <auISZ5w318zwUZuc@cmpxchg.org>
References: <arFBr22V60BMmVpl@cmpxchg.org>
 <20261027150002.318916-1-dipiets@amazon.it>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027150002.318916-1-dipiets@amazon.it>

On Tue, Oct 27, 2026 at 03:00:02PM +0000, Salvatore Dipietro wrote:
> 
> Hi Johannes,
> 
> Vlastimil asked that v6 of my page_alloc patch [1] not go to mainline
> before these two patches land, so Andrew parked v6 at the tail of
> mm-unstable and dropped its Cc: stable until then.
> 
> Are you still planning to work on 1/2 and 2/2, and if so, do you have
> a rough ETA? Or would you rather post them as a separate series as
> they are? If anything is needed on my side to move them forward, I'm
> happy to help.
> 
> For what it's worth, I ran both stacked under v6 on v7.3-rc1 and saw
> no performance difference on my benchmark with or without them.
> 
> [1] https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/

I'll work on this today, will have patches before EOD. Sorry for
dropping this.
