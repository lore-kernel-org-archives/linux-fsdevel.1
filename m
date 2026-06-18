Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADF31ED7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764470; cv=pass; b=qFfrBSj00/qBImLrGBHOa9wxRR7FGm6ENJWfAY328dgT/iRZes/w0gQnmatAp56tjLhoBiSPI5uG/+FwH2mQ1WA7yJ+WCTyY7bYNXO8CEh2PKxvmL79fHZW2VYuFvjmsnzfIYKdtTWphX8A8Z29Y6+zmwQ56F5OA89lLUmo4o7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764470; c=relaxed/simple;
	bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcHxRixwyq857pr4H+sFTpNg2r5yFLBFQ3Nhr40Y4U7pNCia1uDWS1O+ls10TDafwuq+RaLB9gA6paKilSzxYlWnfcC5Ap24iAojoBPD3RICk5xvOXhgesQ3q2P0wAkRLhmUSyuAP5RZvMezTJZm1IByDrsKo2YHsgyFP1D3KD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUsKF5G9; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUsKF5G9"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e701435806so493684a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 23:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781764468; cv=none;
        d=google.com; s=arc-20240605;
        b=O8KXQv0jbasThRMnN/EpEvSwz3jVXkZ5dMA/mdszBBHas2YMOZPm5Lkp0FxKvRbQtE
         sQXcrLHsyoVRwE2Fnwd+3G18pKqIh/fNKtHxQifV/zKA8K+any+h8RURNLxRBAA2TYG+
         Kk1QJsCPV3v/W6yfVqC6swPM6RYnaf/htInIO5mAQxsSuN18HO+OKC2AmT/dsVkVZZZN
         unyUPEaqDaVTAdFo2BwqsMEg3rpMH6l1VEfSo2r2BbKwug/6iW3/hpTob9D7mwn4yzR2
         rlqTq1jTlc26pwAUUfiq79WYBdKCxQZatBX8zrcUKdSDnLUT6Z9RarDmlW/3m2QzG88B
         MUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        fh=sA80Ob23v9dO89uv+RHVyK+FymbhcMPHHbVD3gtbLZ0=;
        b=VibNVUkyeuVKjI8OIoCf9dhubFfLbvyKn83BwXmWcltvLpFFTnRf2EWk57sv+Um+Xl
         1UKyTHpcTen1c103ve9xHhviPMqcGj+NqwVudGZGekMEXMgw9oZXIIIqMeYWg4fUdPUf
         0ZeVcNi+jZiq70sTqCYBmBfSKlA12O+TBGdgMWahihd0CLA8TCmw2CfZVWiHc3MgTLUe
         ksCUWpHavZ/dUsK1pfYjkVCMcUdPULmLlcpmJAKYY2i/6jCZ8xO8HNLZ18S+Fj+xdb9h
         QjuqHq89esfmZZ+N8lYYoRdsH95E1N1qQURs3MDDJl6MyjQwbgHxF94cBP6hF58DQ4/5
         famg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781764468; x=1782369268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        b=CUsKF5G9oxQ61j1d6rsf70C4V+CwzfyiYvwAeL7GvJIC7AbqTHLHcKrFrSuqEAV2QA
         pzLF5bqljizbBWys6o8ZhgwJf0RJDM7jP3f8kZoLpYGbee7Gt2XcAmZRDLMlg79qdelJ
         uzna51+fErCL+0y6TBoDa++Ujd4tjKdHjmygqFxYzjaqFC0j6+nR+zuxGnINsMlAvIDB
         owbPXox3hQuPUyUM7JLSnsNAxiCfR5GF0/ojif5kaHmYQz6SArEeg+bQd016pBcQoDy1
         L5pblt0ttzAUyKFnUmUtTKE8bBKbtfj8xjYZ0RX/98iMtUW8y7hFawh8TJoPxft5ew46
         /lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764468; x=1782369268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        b=tAWxPT4Fi/juBO3MgT+edc7RYaSzH8IAN1bMy/9NRPjQiB5Ar/0jfIjztYr9/7raht
         9uk0WhSqvddX9Twh3ORpvITgLFQ3BHWXYcq3FsaJMtNpWJbv6xIMZa/1mEbTCmWAanRb
         p5jPyy1p+hhpLLwXf7vQi5CS4CpwSy7doQseA0+N6G3jJQJu87cbhl3T8L9ockymEfrZ
         TU4HYAmv2T/vfWqoTfil6VfYacOeOFzXmdlDAw1o+uUfrs+fx1SUfpVRZ/rwWm6V2xFR
         LMTveMCxfpRNIbTalshtoFcj/xWloV6cp7HrSCCrju37EELRSN8UYpEyu1GXX6odIwzb
         5EFA==
X-Forwarded-Encrypted: i=1; AFNElJ9FVrIfxmjQh5b2Q3PtfeHIxo43pGc5+dIxllOZ3j9F9ujF/Y6ufIldy4k6UJ2I0nD45F9MztYZhpt6KJ02@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvxLRoYBEPoK0Ih7NzfOgteA3KBokAUtEvZhUSx54ZhRxATF1
	lpQImTeqOIbIFEtFA4L4ZGH846Sc5fTziYbMaf8C4lmZfgUtBVzc+KnKowQeeIi4FynRKsuUg52
	sSxrCcYJF9TKr5tza3fc0nKB87YX7+OOnjlECn0k=
X-Gm-Gg: Acq92OEUTdErLdlX01YIJ6x+FehR+eIvonUxFyLg71Bi9bpp8/046fkdxM4V7NwAZPQ
	pvprI3+3kkGz766AAVg2oZ+ibiZghKPtryyD/JPPMVxo6iv65e59OrBiq5U0HAnThaDnhjncLJ3
	uH2BUo23nGKRaGfIIjUZtpLkP4Us/45bwpPi2mcbdPINM9CM6NtAxkv+3+3o/wZnXsSly64Voyr
	l9n8o42fP1aGFlXyjF8J9Fm042qpmG2o5nvW97EMeUexQvhmsInJjKHXW3YjrpRjkr3P/Y=
X-Received: by 2002:a05:6830:6d50:b0:7dc:2f4f:17b4 with SMTP id
 46e09a7af769-7e90b3dd22emr6348498a34.21.1781764468073; Wed, 17 Jun 2026
 23:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
 <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
 <20260617-attest-gewechselt-tragik-7ed473860051@brauner> <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
In-Reply-To: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jun 2026 23:34:16 -0700
X-Gm-Features: AVVi8CdkTtlsRp3whjFCRdKN_CHwplubM07nLp2T3ItfxHiU3lLc-EI912kwpts
Message-ID: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Val Packett <val@packett.cool>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	Bernd Schubert <bernd@bsbernd.com>, Aleksandr Mikhalitsyn <alexander@mihalicyn.com>, 
	"criu@lists.linux.dev" <criu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:57=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wr=
ote:
>
> On Wed, Jun 17, 2026 at 4:08=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > > After this patch, step b) is a straight copy which means step d)'s
> > > fixup doesn't modify what's in the pipe. This could be fixed up in
> > > libfuse to not depend on modify-after-vmsplice, but I don't think thi=
s
> > > helps for applications using already-released libfuse versions. I
> > > think this patch needs to be reverted.
> >
> > Note, nothing was merged. I deliberately kept in -next though for a lon=
g
> > time to see how quickly we'd see regressions.
>
> The bait worked. CRIU wins a prize in this lottery.
>
> The CRIU fifo test fails with this change. The problem is that vmsplice
> with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.

Actually, this change introduces a performance and functional
regression for CRIU.

Here is a brief overview of how CRIU currently dumps memory pages:

CRIU injects a parasite code blob into the target process's address
space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
pin physical pages directly inside a pipe without copying them. The main
CRIU process then takes over from outside the target context, calling
splice() on the other end of the pipe to stream the data directly into
checkpoint image files or a remote network socket.

I ran a simple test that creates an anonymous mapping and touches every
page within it:
Without this patch, CRIU takes 9 seconds to dump the test process.
With this patch, It takes 18 seconds...

Plus, it obviously introduces some memory overhead.

If these changes are merged, we will need to completely rework the
memory dumping mechanism in CRIU. Using vmsplice() in this proposed form
no longer makes any sense for our architecture...

Thanks,
Andrei
