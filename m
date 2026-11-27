Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815676;
	b=xcCEOuMab1NvYcn6ANALGL5XKrLfzd3v13xKA7YlgbmYfobYEMvTxff1qpKxaZXynKUA
	 VP5jibTlmEslpnIkGve3JCUBKNutAfe5HDyJdCmIFJXXW9WrqI/DhpV8J5Y6z+5nV7f2/
	 9citlTqOTtnL7gU6vKOne4JQzui7h47e3wLfIVZlDx6YpBvXRjn7N0dhlHGdhUx+EHYCk
	 aRqwbSAwGX8DayQY9fbNJ0NzgCyfwy/blWbc7xsIHsL+TSd+n3VbGhlOwaWDE4W0wLVwY
	 Fy7WmyMN6NLkbn+rEAyXDOcFptF2mzvIJENj2C6LhmOs46hYc9B38xJQUr8GRkoHDVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
	b=yxk+6M9QB5rfYEN2SwcRVoGb+e0x4wwTQwLw9PQTROp8uikiWl9zpYb+pAYQlsArlJr6
	 tHhrwGwNRSVLtUolZZMdX4YzvzKGoFjcOq/fe5mX2fNzWdbLaYYwDpRUK3Lbi81DE4ytt
	 B8dnzphCKnJnalTp6JgGU47ctyGT97pZD3HawLAVqX3u+4V0ywc6P8LaJrlBvw5s+1BBo
	 nGJMCzNmKzP25q9xcs+GLJ9J9SR53oYYcXVklU3fUQywpABB2YsnD5Jk4Bo0ylmgiiAJj
	 tMt2tBoEI1t1y1ZbokJvSg5ZkbpDZWfhvjCq0UJG/KBYNzYFNt4VWfwa8oSJuoF8Fhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD07606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD07606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so109121095e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815674; x=1796420474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=rlJzjc+LyIk9Bk0QS6P/I8TDEexyuBC3YqrMNuS8l9ecZxXqzecIXHrsa2+jjLCIkd
         AvdgA+lDcovhfWDGGXxDDTraLo/z7WixYN6CS0WFtDPjvWLKrdb2LmuL8SVsyVcmcUAE
         w7uKvqNGQ6fgCtW1/YqXftDsvKWqzLc/etNTUBIImSolgJ458EFpxfvonhxlMSH2he0w
         gpZYXR2cdjzW3qoLBTUFALao2MhHDceARIdwR8T5fNHKRhO5CZKehhou/RRtD33QzCTW
         J9VxQgQTSkBjmppRZyAfVgxgVnOD9jDbF3HW5K6gfIlLPnr/76nWxRQFxdk3GCbefAfK
         3+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815674; x=1796420474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=m9veHP2rDtVoHcCI83Joj2ZsVk/JuCsA/Fprp+JZFZfF8HujyvQn+RqylHN+wAU1PK
         HS8RN9aeID8wBce39XZL9V+5GQ+ks5KTmw/JSxbm6FaX4/+JL/sseNc4RS5gSV3/8VB0
         m7TShmEowhps2hpDv6rtIbpWWWtPgWXAawKWP6C3NKUwb5BiDSAbGPu5JcEqX8uK3/Uv
         2VGo38Y648R1k5/qfASxhUiYs32mX4tqgxAKmvxykBQ+MOLPktu276BWrJDGrf2UIEIi
         n3YJYDKZnLg4Gu5Lvzjsb35wdSpwySb8OavaI96T8fKorh5of3Y6k9lVcOO/G6RVyMMl
         giFw==
X-Forwarded-Encrypted: i=1; AL+hErHkrWbcakT5na8wQb76lTPoTbaTj3GDlAJU8lu5Ilz2cwzkwpXVC+852go2JTOqm7floNJHur0T03lrFkEW@vger.kernel.org
X-Gm-Message-State: APuU4Z88jZnM2crrwfAW/geuTnXFiq8NzymFajLJ03eDotiZuaIGZWmu
	SFJDkPw9OfxJz5PuskUT2dBhZ/1oDeTQu7iB3lIT6kP4HkLGpaWIYYQN
X-Gm-Gg: AZFdTZdM5IAHoxUVJ2vfos/aMX6EvO4dEzOQXwcl5hNkW86Z/7nWgoguA1LjnpyUjqK
	nBC7pmUYSbdrSnduUpT7b4hB0pt8KzIbM74SYHIhqT4Q8eQcR/OFbdYhegp8dEyMTs3+ePtODpZ
	buZGqulCOoJrA2EPVdkfRt3c7x7Yapp681lUiE+llZqu5tDvblMSRX9oqnUax/XA7dzc2Trd4Kv
	dLyzSIScrRhc7eQqH1FGnOJTYQKKQ3bVbFWTClKaY5N+r4U+XzRKMsGaiQSrGiA2+ZR5dgwcnw5
	8gH80tOLTlrehw01cuR9EG8a/w89VuIn/O5qrUZlAAhrAOiArJDLwjlm1jGLls83To+3RoSLeSW
	WlF9cjdQ0tnfh7kNNENWBospe0DFe/IlfrVCxA+qJVf3qtr3uVGDOnuY43RUKFzyBLPhUYEq5Pd
	A8OZpnIjQ0ppHE5zHYHufJLNIWAUzxClDga0fZw2XRVBSAgToqLm+PYgXmuwsI3/b4ObxmYxINy
	90qS1Tq8i2j55Bk1VurJ1UnZfqJj2f+ma+89lnTBpChU9yoQ1Y/zjI+E3tALIA1QEIz9vA7AiFS
	WTYuyMEoQIEn/11jNbVji8qEtg==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr518939935e9.11.1795815674386;
        Fri, 27 Nov 2026 13:41:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bbb97e5356sm37714445e9.4.2026.11.27.13.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 13:41:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	alexei.starovoitov@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 00:41:03 +0300
Message-ID: <20261127214103.542291-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awOQDOel_72Xwjm7@kernel.org>
References: <awOQDOel_72Xwjm7@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> I personally think that "getting in" should not be a goal in the first
> place. I care more about that whaever gets in has a high bar of
> quality enough. It can be something different than this but
> when I read the LWN article about Cells I was alarmed enough
> so that I had to do this and prove my point.

I think that Bacik's patchset has better chances than yours.
I think so, because (as Bacik said) it was tested in Anthropic, and also
because Brauner reacted positively:
https://lore.kernel.org/all/20261021-zeitig-niemals-clubmitglieder-b3973fcebd38@brauner/ .

So I suggest reading Bacik's patchset and say what you don't like about it.
You will have chance to influence Bacik's proposal before it will be merged.

(Note: I am not kernel developer.)

-- 
Askar Safin
