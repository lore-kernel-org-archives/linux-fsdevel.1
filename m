Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA036923B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139518; cv=pass; b=NjaDolq0NrjLzXpDTqyi/Yo3r06Yr5lE0Es9plOLBuu41xWOBRom9PHuhZQA5NRP1J+/zBQsXk6brZXiLn3AdyXBANizBAdRHZp43YliJ53CV8cBIZ7P4YkGxOixy0Om3H/he2SomY+8WhWCATWeXPYmyhACYP+h9lD2mb2YN7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139518; c=relaxed/simple;
	bh=a1WAq8z6Lr5iIEubA1slcVW5P1heZAnFuDZolrmXxz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBZQmRV1WN0pjTevxCXgDAByaR4/M+hyLTUfobfsdSw9cToFtKRJo0gztVu/K4bf6CQZZ70j7fA3ZQun/sdRJNDHJ3dLWE7WlIJKOkp9OHf5zFz/Xc2xeoGQerFWQlhhB9kRATGkrnPsyxdipvg3ThxGDOhSwzSqnoX4OZKi3TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKuu6Wdd; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKuu6Wdd"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db425c9050so4455ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789139516; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfPiCkiQCiBN488g1QI5Z6rxdn+VzlUvvO6ZXhA/9g9BwMKM+mawWYtwijk/T5qOX+
         MA2KMTP80g+G0b6DvQFoxucYEghUhjC75DzAK017hEvPiEv9A58yfjbxJHCrMDmoGjPj
         wuHLrDaDGACMAvtbWIhBizn5vrh+FFx7SH5/934TqZdI2ZnGLAipjyuSvO7GTuzYmLT1
         hSbIIiBXHTotAn2XclIZESD+MEpMHJXcRjyaIfnmjG314mcptiKb2JxiNJDTP8iTbw0L
         kyEbSlDutUqOJ78kUCuRBl8RewIQdcWx43g1oTdKtTp2wnyOHycHHJ4kc+vuQPPwB1TY
         jlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        fh=rFXj6HI0KOe4Myr3apJDpodZoWQ4ipq7qEy68c73mpc=;
        b=qqBaQidrrA99LUr2LG4tkF6A1h4nbhIcCrd51g7L8xdNKpMtvrJfjJ206fzFPPRfx7
         2FMUpGH9KC7xvERA9j6z4421frLCrMYnam6yMiaX5BWpqaMO5Epi2bDgePQ5AJjsyRq1
         kFm1wlPfanjH7ksT2xmcMBGsXk1MLmUu+5JxtXiMe8c+w2lL7ybafRasuwm7THEOWze+
         k7+bnL96+DOMbqqUOXyX50MuZLHGlUJc9WkMV/tibTR+qIiskKfqlXCUrvg4IROsLRyD
         trPd7JJ+2PHGdh2NK3GnE7ffTMFgoo2Qeh0I69NxM3NjiVOmsnWRifGXAtTCTbEOVlLe
         p3zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789139516; x=1789744316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        b=BKuu6WddAtNn13Ezu/myWUrl8wRcirs7lJnORviTmc1pNq3zz8wrOYdnDa7K2cWUjn
         7qIuHQT7YQoVpdZfvYe5Hts8v0BvUZWf2y8Ncz6k/bzDPLJHpU5tPCS6kgo6K1KxYfsP
         RM1s3g2ne7RHDHhc4E3ULstmP4N+Kjg+OgnrmS1AT/+/AARhli0F8jDgJ6QWLfe9beuU
         24obPTwjhfvBcjcNQqwnl6G84hD6UML3GjvxMb9kFRnqQudyKTvO/xMmBgONinhnrLa8
         7oqzOdmbLt8giRI9tnl4yNW2z8EbiYjD1vlBjw2CMS+3WSgOY8iZeZvIZnr6AXfv76CO
         ffZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139516; x=1789744316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        b=AxgXyl06+nP/QpXNhpEE7cFxcGc7yvOE9xH0K05c32UiGwSTkM62FxK65qwGkIDhFz
         NaB/yEOpCJfz8bVf6v1c09RZkNIifRv/Z50FC+MLkxgtVbrWyyxq1UZoYJEJoebfjm6M
         CvfaHdHkFtajXsN3ZMPkpp16ClR1uisvNqumKAWJDgG+U6g3n7U1mC68E4JZnvukJW9w
         uKBWkBCEbbpBU4VbWSJ8Z4PYIodhAac8gv78Dhs/YGXyF04CO04L59DE2sebLlJevhyM
         IsuBmci6Dradi7YorkpTvC5GNBmmhcWKiSxYynarNOOqEKf0FgINqzAQB30TlqYMWxiI
         BJEA==
X-Forwarded-Encrypted: i=1; AKwUvBx569NPBzolkITlYcQiJiSxoX0uxVZfCCVXddz5/0MRhs1ACO96K4xczHSbFAQAWaLT1junSxdKow+AvtxV@vger.kernel.org
X-Gm-Message-State: AFuF++mNVQFhWmHcR+VCuCZR23I9nditdQyJvVGP1swbaWK328XPyNT4
	ydUrSftwBCAHyV2BUAoRqZ9EYxwlSSQErHGNpvgTRJnTRFtNs0qEnGlr9D8niHVqmFHDEQ1gfDL
	JWs3A//wSzAkjLX6RM9/bfSbzaUoNdNzxHF9h26io
X-Gm-Gg: AYBFou0Qe1xBokoBGpxfdOizAaexE1MGV3H6CtzWe5MAqXPXL7NOW6nODqqUvqJudVG
	bchXBM7xIjKAnazZnU6yN1PdhWwI6uu/6uVcED/weoWkQpQHq+EQwKUCAKURr631yiH+CUeYPDl
	FVCdRh/qZ21lsh3VkctVZQC0A2TBQMc79lNe7fiy43LSbTH1fv838bO829FUhZfoURg1dJadh8r
	qBR5lVyGaOw8jkXDPbCg31ck+Sc03+3L4rRtRAsiPikBP2EUy8aCQTuHBBRYGNiPPapIEkkGDqA
	25WFXXzgQJrHoX2aRJMovRYJw95on0KW+vgXGynQJF2ZvZdv73sOFm2eyw7KYUwdRpAIjhuvUNR
	zPISIYYupbuYsz8L+aeT3jjWQDNT4CGO9CPeT49tg7g==
X-Received: by 2002:a17:902:dacb:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2dd2bf06220mr7129715ad.0.1789139515742; Fri, 11 Sep 2026
 08:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
 <87qzj09gau.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87qzj09gau.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Sep 2026 17:11:18 +0200
X-Gm-Features: AcwNN1UfWUuTxT6T6m2fFK9oBs0vwCiHpncLk9iQ0jXOn-ma2wM-nV7MC9jABfg
Message-ID: <CAG48ez3f=-Ydf6rQWRxgeD1jz40LTup3MUmNJgqAaUAgAekDuQ@mail.gmail.com>
Subject: Re: [PATCH] exec: do_close_on_exec() before taking exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Benjamin Peterson <benjamin@locrian.net>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 1:30=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> It has always been a requirement that in exec_update_lock not be held
> for writing over any userspace accesses.  Which is why it is taken in
> right after exec_mmap is done updating userspace.
>
> In the original version I missed that do_close_on_exec calls flush
> which can block waiting on userspace (Is that just a fuse thing?).

It's particularly egregious in FUSE, but I think network filesystems
can also block on network I/O in there.

> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks for the review!
