Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1E35C193
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044821; cv=none; b=O4AkcpY2fQe4VHsDFG6TuFpzw2E0e8DJ0XoGPUJoJ3KJzVZyEaeupZOKPODqwhGse0PeMuKlNlNRwPJAkirJW6vgf+F1obOVibbtDWQt1kP0xLTZKKjnERDudmXeV1j0NJh6hRiB1FuEuNiwzZ9rbW8Fv0FO+QYZKm4sJ4xGcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044821; c=relaxed/simple;
	bh=YSls/4bMilLyxxUS/HHOqwN2sBSItdfwGTMWbs0bUsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cua2t9qxiciS4TBYXeDbXSp+owLSSkFQzbi3z+5WzH607Ri07P3WcoeqyLxKFNWNGAYX+mbJNGo342hkmuKPkxrtekx5y34FOFeS9Xn/O3hwKHxDe0uhOO76zE6K1ksdbX5DPsNKA6mpm7IHkB9vI7a0IJRnNg0LGrzAfE1oAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NfyIlCML; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NfyIlCML"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so1948930a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777044817; x=1777649617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AmiErQsVk1e6fpD2xX9oOQUHl6njl1E0LEGfINGuz9M=;
        b=NfyIlCMLAYdo4iX1SVi1ejSh35D8Ded7hTJP8dDFbZBFh+Js+uaiX8XP3i440obAqP
         dsyvCMgYUyDBe5vASSsom0fQ9rcPGo5G+B1V+9GxUnIdZ0LSFGLcZD0GqAqlKQbhYdCG
         PrLseZ8uO4NxMXmRL7a1TwwkTisswwSTGx3Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777044817; x=1777649617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmiErQsVk1e6fpD2xX9oOQUHl6njl1E0LEGfINGuz9M=;
        b=aBbcwcurnd510TNKBId5gT8dGiuH0ag+1SJ0wkAx/3lNK6/cXOTLpSh2PBj6CWIaPr
         KwJzFpmbwk+PvRp7XiSRvJNSOGEFj+U4lUdEb23D8XwICERGs0HJput4PDgS609Kh3Op
         6HWYjf+R54cWRDLOafw471CVDIkRYkZXlNq22RDnnVkRf8rUM0KbtY5OhM1M/XFIP6WG
         I1c7FL3BrI+lZ6nBBPZ1GyZCDNMKZS72ohbR2vnmEkVOUF9dEGiZxfXESsquq+JYT/IL
         gB6Y4sohWyubnpajTF/Wtwrhf3gS6+QqFouvGvF6PRdsHb/aeBcs+mUUMO/J5spneeR4
         6uQA==
X-Gm-Message-State: AOJu0YxJePaxC9+vBueAiitpslUGHw3nndp9qR9hZCuo5KLUvBxgSRRP
	se6207yWD8nOBN/uZeJGuamzxT1fA2A/kNrE4jJtv0OUqXCEIrWtRv+hf/8cMwbQxEPtXqZXxS9
	HYTc05pYA3Q==
X-Gm-Gg: AeBDiesvFLRrps2mPYAZuTxdMlukoHvsAU9zmWPgC7N3hXnP5CZugU/ywDQgOQo/bSC
	i65y1sYYCxRzVgCHIPHXALI/NmCBqL1ot9naAWrviUnzTP1s0zR1aRkbX1gVQlLMiDP8EHodg2X
	uadPxEW5t27SbkZowIIHS8GPIWl3W0cJ2TxVxilGmWZbsVVyxDwAmjcbDT3gBVVzQhvJWDUCnX3
	q0asuXPGsVxcmjUvhlWH6/VtAKywFHk1PBeq7+wOSLHVtjrxpNH0qukQj8yVX9MJ8h7Q27JggMD
	oiZeRDKQYt3EIdJdsQHk41D/0MZskVRlmAgkopd/pYEDs168hofktQ7V2eLGBq0AlNrGLSuf4nK
	3k7nnyRVNb8J7mnWme2QONZ3ogigZlgW/Km6ku0zEeR8N5+0WI26geRDEXvLgki5vb3E97UCtLS
	ITDH/cvymaJ2vT+GkfNiPDVTqUadvTeWij5S4Qub954CgDxCWzRs/0uWrNcwmBxGxz/HJ18RnjP
	eSZsM2VDV0=
X-Received: by 2002:a05:6402:24d7:b0:672:c664:38d8 with SMTP id 4fb4d7f45d1cf-672c6643c80mr9118119a12.2.1777044817532;
        Fri, 24 Apr 2026 08:33:37 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e18esm4959645a12.10.2026.04.24.08.33.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:33:36 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c745e18a0so1372156866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 08:33:36 -0700 (PDT)
X-Received: by 2002:a17:907:86aa:b0:ba6:74bc:5604 with SMTP id
 a640c23a62f3a-ba674cb9c38mr1266147866b.26.1777044816304; Fri, 24 Apr 2026
 08:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Apr 2026 08:33:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw=H4R3dEZXvx9rCfnE_1FgskFXtHf+5aHOZTKOuwtMg@mail.gmail.com>
X-Gm-Features: AQROBzCfYKCMyGDsL3cmgFfaGDHYvvb6ah93FWIZ-z0UUEzkUw9Sjh1AV3vZqWY
Message-ID: <CAHk-=wjw=H4R3dEZXvx9rCfnE_1FgskFXtHf+5aHOZTKOuwtMg@mail.gmail.com>
Subject: Re: [PATCH 00/17] eventpoll: clarity refactor
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026 at 06:46, Christian Brauner <brauner@kernel.org> wrote:
>
> This adds a bunch of documentation (a bunch of swearwords were removed
> by having an llm go over it) and refactors.

I like it. Since we're probably stuck with this forever, and my
fever-dream of some day getting rid of it is just that, maybe the
right path forward is to just decrapify this whole thing.

And this all looks sane to me. I'll comment on some things individually.

              Linus
