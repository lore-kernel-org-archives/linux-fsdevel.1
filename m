Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712700;
	b=sGPxR6VoRM1opDaDKZ/F/oZPoH2ZJvvG/pADF4hqp/7uGR2logJawKQXWYFnriTg8SBy
	 BekNWfzpThkC89EWWcCgAIcz2de3mfc0khmXXJpug9LNHL13pk0i/3rYhrImGagTR5bRR
	 2OQcUUROTZ+F8OuwEsx/AYsY/GalkPWJ56SdKRkCLRbDst6zNk5EqbcBFjd/6DG6HiZko
	 49Mi6ef1+wWIa8qZNdk6RsTxuDag2rwxgnRP/tljWUBvIMcSXALkhH4PoE1cGWyhtN1it
	 nMpx7rR32+ncqt2qmK35gPLqcCxFeRnLqE0i3wc33Snk0MPa3aciSn3b1jQd7HH9bEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kcT+zGUVm9NECrDFd7+fwJkTsjEygvZ1aBy/ZV3pq+8=;
	b=tuCetbdBJHtDryfGiWOlmDHnUxThiRVP0g+8qoxN1FwtoNp86EwS0xrhnbgzQ9SXvf+p
	 OQLqpbQPsCdPNZ6zRbI6CJzNo2upex7/AJyVlSksSXsqX8V28fgixu2vaq+DBy/ilvcAO
	 aTcBEBF0oIPRUqNkPMq67b0+6QdPY0/OCdE1eQ/5Pya4dq1IXiQWY0w26Yqp9mPNF0FBS
	 n8vVuIzUgf1JzGUWkRRVVHpBGHR2542A1B3BQpRyZqTclL33PBTUSGu5xcSRTHf1bYaMD
	 D1ro2cAA/bQcDWXom+7TpY2kKvkCLdnf08y8mXdZFYadj2LjiZTqww2zINFgeRV+A3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BxxC9JGq;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B53606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 17:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B53606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BxxC9JGq
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso10367435a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795712698; x=1796317498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcT+zGUVm9NECrDFd7+fwJkTsjEygvZ1aBy/ZV3pq+8=;
        b=BxxC9JGqbobynwHNYvWHQIqUv+WiHWeiwVCXL7RrUV4ugYMypy626gTal19sGaLgDo
         +eHY95uW+A5VkxxyqLvRkeYN5r30SfcfLx4fsplgc2Km+SLKFjthIer2q1Cu5Btkuhf+
         gzZ+35QulPAXACbFUn+TQHEmU6RdS5M9MZb3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712698; x=1796317498;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kcT+zGUVm9NECrDFd7+fwJkTsjEygvZ1aBy/ZV3pq+8=;
        b=k22Tcz7YWZjp9sX+kOSmdn/qD4It+uV+hGYkSGyUyzjju+MHTNAy61lmWDLWTzP7g+
         VChqYzIvUOOAZURVVN1UkmtG9pu3wdldSbaFbUJccLdprFkGl+rSfkpRqQ8VRYy6p460
         j6HjMopF7V1YfXhri5fjIBhFymssupG5zpRG4JlxwaB9d8O/mm72Oq3yuyTTBLMjZ5Fw
         j1hU2ISetLlfGGOf6eO8t5GtQVwzvcYhSCCaQ9EJZI9FQWEgcIqcVm2No4wU6K+QP4Ma
         wflKf6tzm8Z6xzw94wV8VxoaunCq/pJ9APJpkGgVdeC3YKcs87oI3uoGh0TGjxHBGIBP
         bqzw==
X-Forwarded-Encrypted: i=1; AL+hErG+7PU6V6HhiT77g6xvYjKUFcMl7G9Aad+RTbyahClX4YrZZb6RD3qORlujGtDOAkPq/tWHqh6XFSf5wOXU@vger.kernel.org
X-Gm-Message-State: APuU4Z9YNJRwwntmXzfAZLf4sCLJY5j1hcPK3TtSa1jyH0FjzttQE9zy
	+KdszItUXbYuDUgfHVdkhgnx1eVB8gRpdLipUyHTvfVc83DZv6Jc0zmPuHfVC1pQI9SccUYeCYs
	48VJjeL0=
X-Gm-Gg: AZFdTZcJv+ARampyxRshrhPzpCZipRYcb89AA7ZFsvPgCKSOnQm52FNqxSkLvb8j4S6
	KQlquRMlfPYyti1cqrkQ1G6vQETPscABBMPGK+1rsswOCEyElXYchYxsVbNz7C6Hb2NdFOq9F3P
	td3PQdiVC3pJ/zUt9VvrRCLfb27KNfgrK77qZBtZ2hFaFzruTdBcSdoc+6Ii4t6X7u/trQu+HLQ
	pWCQtVJxhCupW52NUPh7Jf8dipf01ukzUGUxHFQ8FgCGYt8puDliL2ylFTWJEFSlKKtURqPTXMj
	Mo2GoAjwvFgWaOQ6PhaoCJ2/HsxbQiGxe0V3i1+qWXdpoC9FtVrfd8CeuItZh9Xdw8XyU8Edh7o
	fXyaMHiAFx0yMCeo7crFiNapz4XM/5b/TRkWr6QPDk6RFENUZ+0YeFmZWik7xEjFBNPaVv2XU1V
	esyOSqD/K3hsTV572+vjPfWTNCfZufkykc6eBjUBPqo2D6PpcJKAdwLfVZU0//e5UNn1rvx1O/v
	qezgcN97/SmJMFK6Ezsl+3JZyW7BV/1MXhrmQsQQiqr/4nejpjWrddpiJF8/TYKGpr6pTicdpeF
	c2hFogF/Wt70wIvDUZVp+HZxDSkwDNPSV/9BbQLoYZsw5mp20q/tGn+1J0LB75SaY1a0v52cMW/
	4fMA=
X-Received: by 2002:a05:6402:454d:b0:6ba:139c:47b2 with SMTP id 4fb4d7f45d1cf-6ba37eb1950mr13011204a12.25.1795712698155;
        Thu, 26 Nov 2026 09:04:58 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm2907357a12.26.2026.11.26.09.04.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 09:04:58 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so927004566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:04:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGheCgaC2iG7d1bHj+pSEKO4YWQTcbHjK09JnAChpRJ2UXz7ji6QOjqsuij8eMJoq8OR1CjC/MDaoNjrjuu@vger.kernel.org
X-Received: by 2002:a17:907:ea94:b0:c29:f5d8:9c73 with SMTP id
 a640c23a62f3a-c513a9aa815mr1870553166b.34.1795712696391; Thu, 26 Nov 2026
 09:04:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org> <20261126-lklm-sysctl-ctx-flatarray-v1-1-d7fc9cc9b03e@kernel.org>
In-Reply-To: <20261126-lklm-sysctl-ctx-flatarray-v1-1-d7fc9cc9b03e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Nov 2026 09:04:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wir6u-wFF8+V6DZTqJUsgvRrSpkZ_FV9QcK58G-b1N7bA@mail.gmail.com>
X-Gm-Features: Aa3M54os_jwm08rJOj6LitTJqSmdyD486qskvu_4qaUDpWGX1bG3bIuR7eJcvH4
Message-ID: <CAHk-=wir6u-wFF8+V6DZTqJUsgvRrSpkZ_FV9QcK58G-b1N7bA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] sysctl: Add struct ctl_table_tmpl as a distinct
 template type
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, Wen Yang <wen.yang@linux.dev>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Nov 2026 at 03:47, Joel Granados <joel.granados@kernel.org> wrote:
>
> +/* Template version of struct ctl_table. Used for registering ctl_table templates */
> +struct ctl_table_tmpl {
> +       struct ctl_table t;
> +};

So I really don't like members named 't'.

I see why you are doing it, but maybe you aren't aware that we already
enabled ms-extensions, and you can actually use *unnamed* structs in
templates.

So you can do

    struct ctl_table_tmpl { struct ctl_table; }

and that gives you a new type that you can use without any "t." kind
of thing, but is still distinct from 'struct ctl_table".

Note: being unnamed is very convenient in some situations, less so in
others. If you actually then want to access not the individual fields
(which is very easy), but get from the template to an actual "struct
ctl_table", you'd have to use some explicit helper wrapper, something
like

   static inline struct ctl_table *template_to_inner(struct ctl_table_tmpl *a)
   { return container_of(&a->procname, struct ctl_table, procname); }

or whatever.

Honestly, right now you seem to do something really ugly: you have
that 'template', but then you hardly ever *use* it as anything but a
top-level interface, and you turn it into a 'struct ctl_table *' very
early. And that looks like it's done exactly to avoid the whole
messiness with the 't' member - but it also measn that internally that
"template" has lost almost all meaning, and it looks like a regular
ctl_table.

Maybe that's fine. But it feels like the template is less of a real
template than just a wrapper that is only used at the top-level
wrapper and then never again. That does *not* work well if you were to
add a few extra fields to the template (that is then *not* in the
struct ctl_table. because they are only used to set it up). Hmm?

              Linus
