Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7B3DB31A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329021; cv=none; b=Gnh79mjDrf5D5aO5o4xyia/IFihpkDq+PH8KNKDRGlCpRI7D3UxK2U+2VlCxJmi8jt+1fPdlnP94brdU6gwn/N9n7mIms/Y1cCuSakTJgHSO4Fjz1EjYOXIAmknx/NjQLNdkt+2vX//v72RUJXSC3y3EVJzaDRqxcDIrk6TXPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329021; c=relaxed/simple;
	bh=nTXW1aszJ7vJwM4JLdG9/UwnGyXjFaGyj9QAS58OX2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6/BrwXaHnO9zhVGNWLqysVHO+steowLitjwLVDomUavaT5Sm2Q48iZry1xSqai+Pok3aMkle468NrnFB8fTSC0BVjzH9rlDCvuS9eW7IY4d3qnhstJtKhViWLXE8imPCoHmSrNawWnNyyzYh3AwYhaC6Gb4hrjVPhvBNahZmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E9tVlTuA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E9tVlTuA"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bdf8add254dso951811366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780329018; x=1780933818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=E9tVlTuAE1Qu0NRW0F9TDROoWDp1okR7x4nUNIAsJlGAgO2TTKBd0WGsMEm4IzYfG7
         yb/6ImLaBlGXqt9oN2SyOg5TqWwYF6e0MV8PTHndZYo+hgjbL+/6asruA9gpN3suM2P3
         xpPMuiyf0tMMtckRIyItHLobxpv3+uMW/eBYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329018; x=1780933818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=CkZeBuI7SGWhNmEKOzaKeE5hVMx9i1p3L7LtiV7/TVHzuXPufs9JOHS55tdWn0b50g
         iFx+tjaI+eXcRfMZcS8z+gS+zl3A2vlRsIV6+XGggx1udbYr09WhQO7Vtq05XkE/wmcN
         4j/sYD56eI+TkxuSL8Zm7hepJh4Yvq2Gfv7kigzfuLfscieTQ2IHR5fyHwvKxYo0o/SN
         ZwjKXGb2/hQ5+EBOIleTl5Tqs7fruchvu8K8Dqxr/n1GoQRxktj5Sm6xbWKqG3fjk/PM
         hPVUPjinmrUogx7feuYwtgkCghky9xD+F91qgAhOzSWY9LtR6U9fuUSxPlzYUhNXgkbf
         yiiA==
X-Forwarded-Encrypted: i=1; AFNElJ/5hx2/Ziv9mMVRaLufrU3xba00PfPzanC1pCKbpcvcH31xa0dk0kTeFAiBWvu6elNvELZ2ZUMu6jPBQWSH@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPfHO5uuLY+/NTTB3ufhWozPHM2zNbLvw0r+gGncFlN2gDOdI
	fuL8Q9TA9o94eykgQbRPdOaolQMRnTS+HD7a6g2Dua2IrOcUcS1oGCR8zvCoJGsAcSeH/Yje0VR
	Fbh2Y90M=
X-Gm-Gg: Acq92OFdd/Vz+FEU0pUjY8bxwGb01vpFDqBE2C07oja+HlnOWBvO9/ZtembS7Wp7ikc
	U2Pzzi26s9jc/PVP/29pRBxpO3xbCcn/e1J2QlMMuW5V0vLSSJTDNttGg1vTLEX/udd6/jYzFb+
	X8+uRtvITGmPKmrpMDvbRSIOssefLt2qbctEipXuoc1WyfZYgb3ee2OxM7ky6EXk6dZqTsjgHgM
	mNDtKE7TrDUNOoTPmr2vxU9tPttj6C/s3y8vs2jwOmc2Lm2arL1WqpgeHXTUxKpOojoifV0eJDy
	qZ8BQzhGd09ociv7NiOLC9A21EWZ1HbE57D4EKJv4MYO4zK+jt3q26FS+I/qT7sFn8xXI0xNoe5
	pXy8NaJWnk8mzS9nxh4rKX9d589uUynbzgwfAh5tBmY08aKehe4vibonDkYye8vXOH9OjiUY8n9
	NXk8LE8+eGdYH7k22P21FjiLnE+hsUIrid1ZpDORqk0obkAYhkZNWXbbC0H3aXBY/MGIvZ+PWay
	VcddIzfxSU=
X-Received: by 2002:a17:907:a2c5:b0:bed:9a7:5ed1 with SMTP id a640c23a62f3a-bed09a768a4mr348516266b.5.1780329017907;
        Mon, 01 Jun 2026 08:50:17 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bec4639cd2dsm193306266b.37.2026.06.01.08.50.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:50:17 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bdf8add254dso951808466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:50:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zcDkT7iMTwCvy1B0IYBJe6gREtQnQzMjs2z4D7pceit7jkm414fDNjaue8o+Q7aUbcmDK5SoNJCwxsnSx@vger.kernel.org
X-Received: by 2002:a17:906:2929:b0:bec:203f:7466 with SMTP id
 a640c23a62f3a-bec203f7742mr316403166b.8.1780329017245; Mon, 01 Jun 2026
 08:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com> <ah2nBAdsE5vVJ2PL@casper.infradead.org>
In-Reply-To: <ah2nBAdsE5vVJ2PL@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 08:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
X-Gm-Features: AVHnY4JDfRzuLw7CK_4gSBHmXbq5FWvfpfspaVnl7J1jkuJC1SncFOzqHbctZiE
Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 08:36, Matthew Wilcox <willy@infradead.org> wrote:
>
> Can we review this series properly?

Well, since it pretty much is what I suggested a few years ago, I
certainly won't NAK it.

And the patches looked very straightforward to me. Just the final
diffstat is worth quoting again because that certainly doesn't look
problematic:

  7 files changed, 33 insertions(+), 204 deletions(-)

and it removes that GIFT flag that was truly disgusting.

So I'm certainly ok with it from a "looking at the patch" standpoint.
I didn't _test_ it. I don't have any workload that might remotely
care.

I did a quick scan on debian code search for vmsplice, and after ten
pages of entries that weren't actually *using* it but had lists of
system calls, I grew bored. So there are likely users, but I don't
know what they are and how much they care. It *might* be a big
performance issue somewhere. Unlikely, but...

         Linus
