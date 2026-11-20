Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795176133;
	b=L17FjuO4fE8jqk6uuef6gzucEpGLJsDTjM1aSjxT75pkXcN1UMxnlvr1A/Mt7nqW1MHb
	 VkzrknD4jwReIZAPNoBGAVOyKgfSwenwYYtI+W3VLI/5KY+AacHRupi79WLbIxwnb+NPD
	 oSkoIb3dsrt1h3nNdT+llJOFLVHuxMP1YW/Eroc9aMhsxSz/4ziwIg4X0sTNdqXvjK551
	 z2uzDqRTrDh8Ojy+Tta6q4C/kLc8sDtrTBLpINi29QKpRKvsBxOLhYCp1OPihP1OwJ0Qu
	 CwR/yh3cgeJnGCTJ12yFMZZUVDGBS3DEVYDQUK+6EXWkTi57XUxpvcl+tLUXn5OSeJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M0GVSOJEv4Fg5tAe9BmtD544Iu6fdkKfVtmzI5e60Pc=;
	b=koCtVGz2nYjpduCaA7ISKE5ytm2YYVgTrpgKFxLGo1c82kFkn9sNboQX5QRskT/jrmC3
	 u6d8sHgdPTJg0Ig/Lm3SLdF3yDhIhX4HAlHOauFCOCjEb9SqBxot7GVsY9R44ztbV6WGf
	 7UlMHDRaJ+eeLewBP9WWU1MyCzr1sTZGg3Ec6xCYq2jIcR7nz9c5Z085JHHrGsQ/xs5KP
	 kjedKfn2h9qo4V3vlqa5TJZuBerruY5l6ztUzEb6dp6jMrS6dFMO6Ljd4YwU2ma2BOxvI
	 FoBIiBr7KGlt9L3ajorMKxJvadeNF+tbuJ9/8+4SzZjS7bcLZ1mihzMQkt4dKVUSPIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elnT9W+K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BE606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9BE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elnT9W+K
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c511cdd5a82so102807666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 04:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795176131; cv=none;
        d=google.com; s=arc-20260327;
        b=hkrojatF4zYCogPNggbQv/D2YEseU+ibplcIusU7lPKajTh3ijNLwLSAX0tZi20c/V
         kf8n9665OEHI6Jh0beO1jXa90gXrZusvzeFZGcSREAqX6op3/fzJjXgmW9XTTPKOLpzL
         PL9MlbC2kLHs0z9UatzuYMsKGN9JaVC2ndmASp1dJE2PJ9BAHLxjS2syuo7E4rdhdjbG
         V8bcNgmY6IS5xGQ0coEStRuLEzlfpKNLH24G2HYn5CzgYaTcKsYIHry+8OF3sclG8GRD
         R5LJ8EtRNpzFb/vijWdrNHWo4Jj1TebCCvgbfaArp4Qt/6UYnabWUHJd1hD8WIwKclsT
         tGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0GVSOJEv4Fg5tAe9BmtD544Iu6fdkKfVtmzI5e60Pc=;
        fh=m5U4vNqpiKX7dcTOiGGw2cRLhqoYIzX5G7ndZoSL0qg=;
        b=WWV6StrFt6O8WUTOG0A/CcLFOWB8NY5+WVBpovyrpbHwpcibgVAkNxvSaPjr//YS2Q
         cnczVt3OZ8g1y/i9onnbiKHipNxYdlbB74W0BlPiV7oEWxeU314sGgE2ZReoLetGS4gy
         tU1TkHJBVBCmppYD7HAH8or2Dh54cdMCYCcNZKIlsEGo57aiccOUVjLokIx7N4dhHC7z
         PIGJBUYwFKIuqqjYj/lDgveizFOfFcytuBbgYsf9pg3XFxg6QXWyhOwUdctFyY2RIJOB
         pXJp7llLlmmwpNzBxBTYZNXHVWfxAH6ZpwJHZE0gI2v5ks98IxaAtr59zAP/hTwq8bFS
         qRBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795176131; x=1795780931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M0GVSOJEv4Fg5tAe9BmtD544Iu6fdkKfVtmzI5e60Pc=;
        b=elnT9W+K/n8i6yiUeG/vwm+AuWZDS7DoUKbFQYRBMAXKO57CxAdbGuvEp7yGT/ng4A
         xJpGl84wP3dz5FzRKXe1mxeZZWeFygWYXwT6EcOzt3WuouvhCpt8slCtE+Rm50c3bBbG
         jZD32of3vcH4juNQdSqKW5qUD7leYDJAhDOQxBXy6f4E1VVwgUGsrWFBgn5AWyIRQSc6
         JcQ6v7aum1SoOt22UQcGQfTxneDcBIs/uwdywGcQfTLz0l74MV/l6wVVpNUg2sG+iumT
         sirvXsRGU3I3K+iqC1yO/eBQ8zKNZV/FNXSNl9BBJxM7mKFqWRkVuWq/6Wfdj9Uc+XEP
         6KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176131; x=1795780931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0GVSOJEv4Fg5tAe9BmtD544Iu6fdkKfVtmzI5e60Pc=;
        b=WZea3OLhEhDho+39uVCe9QHrsEYu0n4V6RRr2Il+Gy3obm4SvyIF4Y0ZQj0t4Oyjx3
         y9jSZ6TeAsaMKqbUXynaePLHCbitVoBx472C9E/fnMWRKy2BItEO4FqNMRnu3c4l1/Wi
         PJZjqpAeC+u+SeHi76JVM4yjmJX1i6lRS7yHI5s+59WlQCmoAQprypE0iwYBGF0rNFJ6
         f+2GRtlPaX86uvhpaFRlCOqDSUphyPny4LD/fQOUT592w+9C8RwG6KytTMVsQE0qICRK
         U0uigfBdHSzNLjBIv75HGmiBylW1EzNwDjRjmKex0r0ICR3FENlEwOMId6/HKpdiwS3A
         scAA==
X-Forwarded-Encrypted: i=1; AL+hErElSgNNckSSu4nqKci4EKUW37956lhcMwsb9jUo4SkYY8PEyt0DIN6IMs5pbpgHUZSsp3faYP7LLJkUhxyj@vger.kernel.org
X-Gm-Message-State: APuU4Z9foKcwoAX8QDH1pRVOHn2QpK+YylVseZkXAxEbRVNKj/3tzwnC
	gHaGedJLQNS6e0k769P0Ugk5Ql5gGAmYqa5CGISyEXIIBA4JrbMQDPWrUPYF7ZIphNYIvi3dHzH
	Kmd/pqjwoxEJcNZRGKBwD5+dz4EpUepk=
X-Gm-Gg: AZFdTZcgObHtkHY7NjXQ3HA0B5XyMmbiIf+aRzK3LoRiNGeElkX8bXFdK+vVZ533AKq
	l4HkocM2DoSclweReHcx4k70p4aCdXYVcqSJzshr90dlcmlCGsI98aXmfzcYK31UAaCBnM7NCKe
	T8MNC5pULdwAI1iE/xz6AFNY/gqiS776ZduexE0u8ynjWBFbPPHv83O+tynrUESdLZw+rdT42vu
	e8XSdzbWu5JyBvkwGbtzElVHuYgwnui8W8FfSm1gpYOWZAYRjXjWZJM8RWR1PDwQmDTLQPKnw2q
	fSa5pJmyJPtEhxFOZhnXWLUltFVzYa5TIK4LGnMdKhXGAUSwWueBJ606FhuywCkVKE7NjupAyH7
	xWeNMuJd8GNgxY6xcjRLabsF2sKoD6sCXmUWGwR93s4Gllu3RP1ChZVf+WTGeI3E88LRs4w==
X-Received: by 2002:a05:6402:4048:20b0:6b6:e857:19d8 with SMTP id
 4fb4d7f45d1cf-6ba37e69801mr1554757a12.10.1795176130876; Fri, 20 Nov 2026
 04:02:10 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
 <CAOQ4uxhXTeTv_ydiQoq6-dvbw-ttFKkdNVUJanKmF6haSnbFWg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXTeTv_ydiQoq6-dvbw-ttFKkdNVUJanKmF6haSnbFWg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 13:01:58 +0100
X-Gm-Features: Aa3M54rz6j7Tjpjymbfp8C8fSyvFWnIM9Qg1tGNKh3Bsrszg_pg9YMNZMouy94Y
Message-ID: <CAOQ4uxgMO7DQVFwOsK2NTad2bwyktYr4fyeCEFWWVZK5pmqdAA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] ovl: only sync what was written through the overlay
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengguang Xu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Nov 18, 2026 at 6:03=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > v1: https://lore.kernel.org/all/20261027-b4-ovl-containerized-sync-v1-0=
-802e512379a6@toxicpanda.com/
> > v2: https://lore.kernel.org/all/20261029-b4-ovl-containerized-sync-v2-0=
-4e9f08e4a052@toxicpanda.com/
> > v3: https://lore.kernel.org/all/20261104-b4-ovl-containerized-sync-v3-0=
-8daa20144f53@toxicpanda.com/
> > v4: https://lore.kernel.org/all/20261106-b4-ovl-containerized-sync-v4-0=
-6ddde0b7dd8a@toxicpanda.com/
> > v5: https://lore.kernel.org/all/20261107-b4-ovl-containerized-sync-v5-0=
-d34b4ae57fdf@toxicpanda.com/
> > v6: https://lore.kernel.org/all/20261110-b4-ovl-containerized-sync-v6-0=
-43d1be16a4d6@toxicpanda.com/
> >
> > I've completely redesigned this, because there were so many problems
> > that I kept tripping over trying to maintain state between the upper an=
d
> > the lower inode. I'm not in love with this design either, but it's the
> > simplest. I'm hoping somebody spots something obvious and we can do it =
a
> > different way.
>

I assume that you asked your alter ego Claude this question, because it gav=
e me
some tips of how to do it differently.

I guess it depends on how you ask...

I asked for less complexity, easier to review, and keep the requirements
that syncfs duration remains low in the worst case.

I also asked to look at Chengguang's v12 work from 2020 which
I remembered was simpler to review, but had some problems:

https://lore.kernel.org/r/20200506095307.23742-1-cgxu519@mykernel.net/

I got a few suggestions that I liked:

1. Serialize syncfs calls with ovl s_sync_lock and use dirty list as v12 di=
d

One list for the tracked/dirty
local spliced list for syncfs
Which workload would it hurt? anything important?
Certainly won't matter for the unmount case that triggered this patch set.
Holding upper s_umount shared during the walk will remove complexity
around freeze of upper and reduces the 3 states to just one dirty/tracked s=
tate.
Less logic to reason about.

2. Replace inode references and shrinker with reclaim list

Only an evicted tracked an linked ovl_inode needs to be added to the
reclaim list and ihold the upper inode
syncfs synced the tracked list (no extra upper ref) and the reclaim
list (with extra upper ref)
This should get rid of the shrinker hooks

This is not simple but maybe a lesser evil than the shrinkers?
Not sure.

3. Try to gate more ovl_track_inode() in existing helpers

Similar to ovl_copyattr()
Many metadata modification already have to be gated by ovl_drop_write()
or the higher level ovl_{rename,link}_end()
we can add both old new to the rename helper
even make them scoped

I will wait for your feedback before diving into review of v7.

Thanks,
Amir.
