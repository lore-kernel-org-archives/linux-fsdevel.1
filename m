Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896042;
	b=IXvtx/5tqVz/Y+JUVaJjlbZe89vIePgzgcX4/WY01pKmZIs0ZiOhz0GbLQ8WjocH1oTq
	 7ayaSZDj2HcHZkJk0sBWG7GItSD/TTIZ+HttF2tj6m553mJziZyP5+8dlEXVlRpeX36Mt
	 BxHnbLWjtG+JZ6WDDdkvml4Ypfw+ZpyX8Yyj9kxKj7TOhgy1KXLYfwrfT2+hEta9CaU+f
	 jv4Bb1Rd0zxxNoKt5jGOnJcnXcHIYRvd1amXozbxSUMzaDzS5Q40vVXTcFeX2kyuaCjKi
	 GPCIk0rl2Z7G4CqBF89P7Y6ZXsDJwtpUsI5/3TI5K9vsmvmRz82aP37w1smpRIMxVlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
	b=w7cU2hnrt6jFOTECyLCpDScqm+QP7PkNHYkgGM0uImlj7Kl78rxpwvLRjXJCeCk5TKEk
	 iITDNbuJoDJY6JQSX5iD/M1vZClGobcz8R8r/zZ995Ac4ckC0r6I5+21drcUkDSESyf5K
	 gwR4/wMYLcZp67Me4Ylg1JfdXpdHIyBZxiUnb7ufEgua05eYuRElnuCMFhDmyf8oQwkyn
	 Q/PmgYr7raenwI0JtzNu8l7GIw3q0NmGPv5ZKjVe6vt3lqoI+HZfl8Qipu34Q+EteOIr/
	 j1gpC3IdxZ5Pun5RtFh3ZcqFFEIFeMHO0oN5ylYNcoq4nmPLEoHJFfVquuSzq5fhQqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAdWmD8J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F3606D821
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 16:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3F3606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAdWmD8J
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9f6a16afcso68545ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 08:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793896041; cv=none;
        d=google.com; s=arc-20260327;
        b=UpLI57/3qTwQ3unhUGyB7os36nKI/PvgtwwzBGfm7U6CnVgRYC3gGVsGRvUOW3+1Cf
         MWRIlnSuUM17ZSjhoAE+FhTNOYDRg0eUZZwc1QlB3an9r7gibeqC5Hl6/2Oc2shOOvJF
         Ir64ZRvnIlvQ2RieVqBKyYvL5OCmy3+M5yswEEnXgM4zdmr/0u8rz8wbL/NVgRIMzFF+
         4QvWDihmCsyFb5Z8xqA0ZkeREdB/nQ8NIqyQA/LRyGQT3NnPazfOw2Nvmn/2Gqqhfl+Z
         OEPJa9AQsPGDoGZI53pfTdrKjJVI4cOFGUDatGGN2O3S39hS38ceQtYvvOfNxmchWGaj
         M9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        fh=cRg4/2t1+Fy6pbZy1WLWvfYihWv0HDVdv0kzuVVsh5w=;
        b=mk85eJTjxI3pwqKaHEElth0tRWHvRk5wnvKpYc8Vnwx9aAOMgrJnxceTfwbSUsEZtl
         sXWYT7P8ZzTPSG6+NsKvzJonDBNv3m+mnJLljbck1meTqL86IIzlH1Xj5Jluww7YvRTD
         qLwXSI82g4jYGHU3NrcczreXJdY7QK7rxmtblWoZTbrWE/MJB0GFZQOiRVzqHn0nSaHa
         GrQqg6w6I6AFu1kskeq+ddCTUNSjJMYHsIV2cNTCj8+o6smzGYtcGbVZLZdi//vzh1AK
         aDzq39PDCn88KywQn0frIGk4nHJQmZ4wwGUnw8GvspmBuPls+C8Ff3FDKiuvH8gMDO5P
         eMjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793896041; x=1794500841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        b=IAdWmD8JNPkb8+BPDqxGVrDthrcfZlPbVpLTWVrjVrtFSpMlJnimBTQk4/nuq9rXDp
         ppHgIt4hqBFXBeHjd867j/CAsSVgjXkfq6GXp16mkT5K/sYhCf74FuAWiOgi51Xl23YP
         p/7zABbNgjIH5SYUiZdfmFPGbIW4FfN3p+2pIa6VhaHQDutr8itsY0X2nagXClXkWHMm
         FhEWL0xZD3vJItk2osFuhRXByiPR+eFiUTfqLZPdBdt1KrA68k2W2Gzf67boy/FaF5IP
         8Q3yBF7aWMnb64lG4ghdiuQNiOK05BhTUgghwfBU4bgLRDPisn0zlxqVkKmr32WkWXNs
         aokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896041; x=1794500841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        b=ewovfyXmyk4qmAPXkJNu6Ll5LbAh07Rq2aQhOlsajMJqS7GruClh5YToM07qAjXdl5
         Vskr2FPm3BJt/SIexJQyDYsvrxwyLZteS/KU4KMMl1+SXSu2AcLormRF7Hyvu9+0HmYJ
         DeZakjbjIPDlKj2ypiekRZiSgWxfPglSwfxvE8s6loyB81+RbyGj0d7FT5k7inYplLIx
         GfgQM6enxtACc17/tlhCkunQa5dDlyQ/Bt/C3u6B/WDi3xi7mAhWDnIwx4kFHmJZJQbs
         /Cz+yh2VzjIMpBYiXCsQfioiopbmoOtpbo87Bt743+JWGZGXFgcBU0wpiLunDFMG34ls
         J5Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxiiror3CgqVJbjNQMsGha0L6lCFZ+m++GZVHfcRwuw75LibP92C2t0zI3HFMRSp437ui/HzelSLpaif8hu@vger.kernel.org
X-Gm-Message-State: APuU4Z9/WN+AdY//p/v+/7GJcjj/ST1mJTwm24VWoq1X9ZIKRDjS57ow
	ZipRsPHh9JNfxM2bTrvjuxPyzXq5YzRmof9+mCgTlpPz73HcaZzZq09Iz6H8TQg6Rp2bF9wlBbc
	1uJxWxpjvR6j+FAzjAhtOth9WPfREt68gMkjyY668
X-Gm-Gg: AYBFou1DqtjaS5u/XVyPSpS7H/i17ObtuYnKeAPxSGEpVE1IQK28MHM7K8yV15XjSZl
	EhRxtf3lpopJ2ziGBfinjQMhnx3xyl2ALumSSYascawuYX/jMbM/F7QgZzfLZOGN6kRbm/7jkf8
	lMdsSi730CqfmVULmh7Z4Jesgo5zizX4sljvEKk0tLueNcKGhr883CyDMsAZpdzhjkP2RetX9Hr
	7LG+wELvOnbYSetlO/DgFQZSDkjQhz/5xS2YCe2kX06kYY6siN+fRJH+L17KgE2KqC0ROZ8jZnm
	ZOBKY82x6+1xpfpyD++aqIc9kIGX435WM7KVA7zTRJfYrvP5BL9ZLLVs9GMTCFzwL6t5WtfiPJn
	T0/3cUOJpYlBoJzngEkZiDoYq3LHg8VgD0KxCzxZDqFI/JMOgtgwtpL/j1MUubUaQACeR4goHsd
	f/STveeGDqNbrWZC7Amc/tE1UVJwmwZ61VrSsR7dIKEJi4
X-Received: by 2002:a17:903:f8f:b0:2e2:d665:6ad8 with SMTP id
 d9443c01a7336-2ed261403d9mr4943165ad.4.1793896040053; Thu, 05 Nov 2026
 08:27:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 17:26:43 +0100
X-Gm-Features: AclHuK_t6xWdJYQZJZWrLOUlN89qpMohpKX0x61rzlBSDTuPtx0XhCCr0dC0-vQ
Message-ID: <CAG48ez19KzsgbOQ35FfGO=cVXGvr51WTA-3g3xNWPmUv2iS+8Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the
 last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:27=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_sys_readdir() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is registered or unregistered in between shifts
> everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
> buffer that holds ".", ".." and "all" and registering a device whose
> name sorts before "all" makes the next call return "all" a second time.
> Unregistering one that sorted before the position makes it skip an
> entry instead. So a listing that takes more than one call shows a name
> twice, or not at all. Even the 64k buffer of ls needs a second call to
> find the end of the directory, so a device that comes up right then
> repeats the last entry.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first usable entry after it, like kernfs resumes after
> the node it stopped at. The entry itself can't be pinned across calls,
> unregistering waits for that. If the position was moved by a seek in
> between the listing counts from the start like before, seeking to an
> arbitrary position has never been better than that.
>
> That also takes one walk down the tree to resume instead of a walk over
> every entry in front of the position with a round trip through
> sysctl_lock for each of them.
>
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
