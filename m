Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6744238150
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784604003; cv=none; b=Wl8mF8mSdPy0N3MK0/+yvGR0RICGDENMX9S/2Erv+WuYlTz1dce0uqbnpbE9l4O4K2M6xwNAF5HLt8VBcDd/y35hGOCFzepZP6Wu1mZhoMG7z0Ix3P3F5Frx+efTjZBqaztF/taxgG5fKuSCNDHxpdwpWgSNANftUcMx6vZjUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784604003; c=relaxed/simple;
	bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IDiv6LNsjKEtL0CoZWLZdiUdHAHh103mkzxf9CU9os7RxT8KFRXBocekjzoLZiHsU903VOKaKhuW3PBwAQs9a551Lq+wvqGZC14n/i7qN82QC6zEiy0JfkTx3qkUKtmOy4HG54kEEKDw8j8CAp7q2epLFWLYPQhII1TMhQiVoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/3w1V3a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/3w1V3a"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so4852943a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784604001; x=1785208801; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
        b=F/3w1V3aUddUPI6uPEHJ9+Cyn8B5U3EJ76jHNz2D34aITrFNWHX6/2BPAxjo9rW/JO
         rxv1So5A5k+jdLH/hkZ03fdUvFz0m+VNhncspfBF1+iITFiLN6MiryC1f0RCc6zISpMR
         JzKjPjsfXdMipUsEUz79amwFWRvKctqCjGSZyFFwpCrdDV23PIlyjI3Bbc4qV55tTROy
         2VA0tbX57mrPiCVOuZQQiKd3YQ2gw043pwMd5P162rc1IfvOL9p26oAyfACuFWqyCrKF
         tJ/7L2LfeaYNKwu+LurqUzex6FctTV7cFDNd/GiLJB+qUVuttvDoEsK2fyACvt7ZvwXa
         co7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784604001; x=1785208801;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
        b=qfjQQ5mSXG0NKB3YgEF0VU2ehxKVv7hmKfisVlfVvSYVls+N2v+GwKrNZvqPX6uiYY
         MyG/+RT+VukuWifOH6h1ism8/UW8Kpo0LyleojPE/J7R4wGS9F5rHuZ6bYoqVXK0WQ9B
         8XhB2NUKzBvaxE5GTCEz4rL+tgWjRckT/f618Rx+bI5Otvj2Ohmy9q9kBgoCpRFFuX17
         pBivB8liJ8s0Go6EyGBhHCSbvYSb5kkBC7RzUuCnF4pEbDYUK9gF8TYaPLBolayLRt9v
         XfOQILZNVw+ZthcJOvOJB336MijsX8hSny8naQYpCCWtTx2nxbOYN+RST2nlywgBcofE
         5WDw==
X-Forwarded-Encrypted: i=1; AHgh+RoCN4B/FbD++oGw4dxTD1pdgWs5yW0lOqER/HxiUGua2mHl3TarnKRn6ZRXdG0wijtbFxltavTwVe+Hr2Fq@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTT/VBBSC5gFtJkymxKSNnykUJXeCRjgP8y3+wIKlKYI6i7K/
	hP8mR2qz4W+ER9U/n/p6i4EZ+g64li43SkezcsxOI6GbYqCzOVXmmi63
X-Gm-Gg: AfdE7clq+h54CbcGI1pHsB9ZTqo3DjIB0O1gFGQOFqm2J4TNSm0e19dkjqZSzzbDRX6
	aAyy7hYFvj8KmSlk8JhhjRZ2ZSZDOiG0mp4jFgdbo8EDMvBvcvMOmHbqfhgAOdb+5WOny0uP+Gw
	zK+s40QtDNLqYdYah1FBro04SGdUq/TEyBTLUvBzu9p4ckPzHGkTV2riLHtzKkfGcg4oW19jfwJ
	3V5S58uSQjsHpYstgIVOlNiXp9bu4BjqrNkl310YMSgodMBpqBbhYAEWNIA3rbDUu0dnQ3moBun
	ao6tjy2Mdu9FmP7ejeLUcQfPxRkEZgmqu+wEiyW31hxkvjBNAmRIAztKmFtwfDJGm5f+4Wm8zvE
	TFf6heEEZqKsUa1xZfKeoqxmhzkAUlzGpFO20jzVb3zOF0FcgRQFrohRKfVIdANie93oKNKwhy5
	aTtyh1cF8KHbOXKw==
X-Received: by 2002:a05:6a21:114c:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3c3ad80c23dmr17180509637.33.1784604001242;
        Mon, 20 Jul 2026 20:20:01 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm42087052eec.23.2026.07.20.20.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 20:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:19:58 -0700
Message-Id: <DK3XBITGHXVO.245WLO7AFGP4M@gmail.com>
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kees Cook" <kees@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <jannh@google.com>, <mail@johnericson.me>
X-Mailer: aerc 0.21.0
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
 <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
 <DJZK7IJ53B5J.141W232JLWL44@gmail.com>
 <20260716-surfen-erzfeind-aerodynamik-5dc96c3f136d@brauner>
In-Reply-To: <20260716-surfen-erzfeind-aerodynamik-5dc96c3f136d@brauner>

On Thu Jul 16, 2026 at 2:42 AM PDT, Christian Brauner wrote:
>> Should I continue to add Reviewed-By trailers to the other patches?
>
> Review them, please where you can.
>
>> (I have limited knowledge on some of the mutex stuff but the agent
>> review in b4 was helpful in understanding it enough to give a review.)
>>=20
>> Sorry if it's obvious. I've never contributed to a patch this far
>> along or substantial to the point of having to understand the
>> merging/acceptance process in Linux.
>
> I plan on getting this into -next in the near future.

Sorry I have not reviewed them yet.
I got a little distracted preparing myself for some talks at DEFCON34
for the Nix village [1]

I plan to take a look at the remaining patches and add my Reviewed-By
trailers to them in the next few days.

I also just saw the transparent execution patch and will review it as
well (as much as I can).

One of the talks I plan on giving at DEFCON34 is about the idea to
support relocatable binaries in Nix. I did a short self-summary of it if
you are interested in reading it [2].


[1] https://nix.vegas
[2] https://fzakaria.com/2026/07/20/linux-kernel-will-support-origin-sort-o=
f
