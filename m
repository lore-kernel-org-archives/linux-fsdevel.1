Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB320ED
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261088; cv=none; b=FFojZ0D/i0NEWizK4kDXVHjaaVy82NluzvpsjRyju8n77V47NBiA4Sx2paY8zBRVtEubePte5+zObAWeOpsNHnVzy7oMx725vzdiy/NFLDWe327pluzRXAmaZoqjW8Jw5Re/mjbRWDh6Td7RkYdg9El8iDECgN8TMKz/NX1qm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261088; c=relaxed/simple;
	bh=abBgUu1t4J4veYZlRqxdlmPpZRqPePsqk929xRFzokk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqGWAZvqx6rCiQeRUxdu7GuBoV9T5GOjUnpOl7gkyuFvBdj46qR+AMvMHCGygVdBUuPjvZgZyTZCnpmBJlbakpcEgQpWPFdn+J8KONvVdo8qUVWoRReenoXniv8C7mab02IOyorgiiRoH4a6EdYbpMqDAkUBQxzLx6b8abEMf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AUlJ336w; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AUlJ336w"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so4197511a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775261085; x=1775865885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bzrb0aXe9cCD4/G6pShxBDVdZFSzIWBkBHOS03ZAgM=;
        b=AUlJ336wwATWz4Yjv1RJGnqposLsslP70bWnbufSwtVPaLLNrNbUDPtbeDKpkTfCOd
         VSrJ+QSlwpEe0nHJP+fzsWJgXBs4D82r81MXx+Eu1XrNLAIm2EoHujPCUOLgGbrHb4Jg
         MXkiYIzAW21s7l5uuq2v7o9ybkhsQ93oTn3nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261085; x=1775865885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bzrb0aXe9cCD4/G6pShxBDVdZFSzIWBkBHOS03ZAgM=;
        b=CUZltnZyZ+EqctO9eQFJrLIpd6eAp2XfHpozfHvZ/vo2htGA3r5+TQwLxBaP5JcQeE
         QKPbw8GXOsW+z+PHFnoy5YkC+vB9YWRidYr2GmxmLLQvlZvKxBTObxO0q2L+Nhg4dgjI
         /FZPFMrpN7y144Yfe4++bsb5SjABzb9u4ckZSo0rPTTI5as1poOGvCFuW9k0efvIIQi8
         jiFzr+qYoZaVGgjHUlnSef5nUhhiP0uHGDJwgbP11hwDTdJmIPWT1penKJkpcjIIJlWj
         gXhc2lq8+KjUrhyWMMWmVjA54VJl6u5mNl8VinbxtkUWRzMHCNaVyvEt4VZx9zbbSl8w
         4KbQ==
X-Gm-Message-State: AOJu0YyxRlt2vUIC/N9w4j0H4ysVD4MjGSAI5ei3pIohFvzQndlw4JQy
	RDLdYkZqyApyCt5q24QzJOu5Ju5DFD21LemVLT0/EfS4THNJVweWIPDwE4pYZ3Z4HekqaY0X97Y
	jDq7/fy8=
X-Gm-Gg: AeBDiesuRDY/jc3j55n+7Sf0HdEd21U9vSNvPJudeVDuFoC95FhPSWOm74iI1wLwbHn
	8qIz09sY2Qc4fCncfVPoocoQJgCDO2d/Uo4szIw8aizo0iMoCp08MqctBAc5Yl38JsF2D4BDuyc
	uXnBZEs7BF8YTPjt8ic39NVpTiOHOfeu0tPN8Oi2QDu3sS5BQLRziCPCYgM1vHKWYUJTtptsRTm
	iUeRCcKM4cFN/EzIa5LtCgN+YZJpsENE+i+IbKoqAyPtD1bg6zhAR4QUZbQ/brYzL9yiS2bUyWU
	ykqhH2fKS5LNY7aEGYE2wJgVxJJ36jPprz+6zn0nN+czIsc/Kjv1uwfPQe1xIIrxJhVv+hw60Wo
	zvgFm2k0WKXv8OKOHJJvs4N1BpVQAPP/wxlm+srYoqcJa42CFG4TcjC5M0rTMgPpnsTsQIw/azy
	JnEXRZejiKiFAtxj6rd2sYOzQsmPGNZaBCo3G7yRmuTnu1EEfVUT9U7hU4ejwXr9bazQtiWNUO
X-Received: by 2002:a17:907:60d0:b0:b9c:9349:7614 with SMTP id a640c23a62f3a-b9c93498157mr45814766b.37.1775261084774;
        Fri, 03 Apr 2026 17:04:44 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec5dsm248727066b.15.2026.04.03.17.04.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 17:04:44 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so4197493a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 17:04:43 -0700 (PDT)
X-Received: by 2002:a05:6402:34c3:b0:669:cc03:334a with SMTP id
 4fb4d7f45d1cf-66e3f3e011amr2164881a12.11.1775261083673; Fri, 03 Apr 2026
 17:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk> <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV> <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV> <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
 <20260403021522.GK3836593@ZenIV> <20260404000200.GO3836593@ZenIV>
In-Reply-To: <20260404000200.GO3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Apr 2026 17:04:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com>
X-Gm-Features: AQROBzC5A7pMlpDWHLKyjv9i_tI2jT0P4eU2NH_nsyQkKy4cAqM2UzzgEPDVnl8
Message-ID: <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Apr 2026 at 16:58, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I wonder if we would be better off with something like
>
> struct completion_list {
>         struct completion completion;
>         struct completion_list *next;
> };
>
> embedded into select_data, with dentry->waiters being a pointer
> to that.  It's just that dragging struct select_data into that,
> even as an opaque pointer, tastes wrong ;-/
>
> Preferences?

I have no strong preferences in this area.

The opaque pointer is fine by me, because it's type-safe without
exposing internal implementation or having people being able to much
around with the fields.

But if you prefer a completion list, i don't see that being a problem
either. So entirely up to you.

          Linus
