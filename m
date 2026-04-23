Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE8282F1A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955102; cv=pass; b=WEMVrUZeudF2kLn/NAJFk0a6cKwZ031LdkyeAfB7YY3p9cp0b73NH45PAB4Cu+AL91DTmpYUZC9nCq58UYBInXAyH0oQv6tj2Nmv4uquIF2kPYom+fmLJh9QR+dz85JCPeYFNQhmKbfKd3usd9BX+uVT0zBtGKviQDhQ+eZo5A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955102; c=relaxed/simple;
	bh=rYjPCodUuOI/9cri9nYziAaN04kQGjcZ20Eif0kUGYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVchL39pSFcRQHdIKcNeoI8Q9HO4/z6d49Z5A6pJyQo+pgnJJcqfY1V1yPIDE5MDMfwT15AzHed0UdCyqaLtSC1qEuIz/7tXui0mIhTfbNUMub5Nsrg7hFj+eBIDbw1VpeXPlflZf6Pe0o9ypiOItBkSxMvTwR2zq8g3EUyHXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPTFNckn; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPTFNckn"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so12148456a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776955099; cv=none;
        d=google.com; s=arc-20240605;
        b=bPqieD+66/r0sXp4ng7FWpqYI+JFz8WiD99OXvxmequE6eR0nE6lkxpqCpHbGEHcKD
         Jp5GVA7PrIq51bhFhG3p6JaPY6vjR2cMIz2ffi4MeMtI7EjmToXN+OLD7hN3nAlQ0N++
         WDGq6xfWH2enrMAWkr+J1L6W9dMErg6/c9chRGv7SlNL7WJZ/ovIicFA4SemxtTbE3RW
         NUeUvTBU7Tfl99Eko0MEhMUKnRjyuitEkAuLbI6+zJzzzsjEICoHapodujcKRfz1EHbG
         s/2HnM9ZIErJrWg2W9Cr8gGTPzpHWCdyNL71+YGHjAhIHpz9VcdUQFhFc57YBJ8XMlJR
         37Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nk2kFAVcxIGY/oGLYhiEenRIHXjGexgeV774WscgMbo=;
        fh=DhtAXPlQ1rxYtGTX4WLC4RgjfaaypugIrWYypC/ugOg=;
        b=TjeW2UHQTgp72azLD2KEMv68f1JCJ+vjruVXmFqiukrle5A2prE+jj4RZFc5+PSVsK
         gUy0Od79wrR3fV4/HNxBpWzu36bzRVejlOtxvUt/GZ2sfDdV2I8+UxGw+Sv6d9V3IB60
         s9hOgkt14Qx+sZ/h1nmFGQ4cFXzcg+6M/Ivl9QCfsntBaWvl1YjXVUPk56ce27aVn6zd
         uyuW+0YmLy+0wWIasm+7kOG0nGc2XTbatqC94foKnzWGrl0A+L9F3yfY0C46VqkcOBzK
         YXV5Iv3Hoyu6LP3tceZyHq+DdOYjTSnu8s6/nsZIPPC/mNLpDR3k2vdTbs//8NkNKYdp
         OAFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776955099; x=1777559899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk2kFAVcxIGY/oGLYhiEenRIHXjGexgeV774WscgMbo=;
        b=aPTFNcknfKMAkJWBtWQ+0MNyXgrIE7sJWQ/jNuUlUHBT/jUagIw0CGmMpp8Ai39YS/
         tL7NsS9okeoGHj3gqaQTK+mq0Z2n/IYI1Q3iOdgrTf3NkyzOz2+ln4V9KJ+fXIENd9iC
         F1iFti5yR1NInkZyufXylrsBpPQqTK292h45LB1bMpiqNZXk+YdV/BIewU02th2PcBA+
         jXVpmGfzFDHWV8sSDlx3GBitDhanSu8vTlB5xbyk8I6o+cvYFygCinD1ysbDCrCy0wDc
         KkkS3vUei894iwfsAcVWBYdBBqPsTsUCE7OVGpTrebxWj/uJGHobfsCextIo+xZiHJJ3
         1cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776955099; x=1777559899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nk2kFAVcxIGY/oGLYhiEenRIHXjGexgeV774WscgMbo=;
        b=kv+dmQGiPgHnSzwVBD8e/rhu6PgVg/p1j0aQ2ewlq1W7dQuwmmy0HwhpUd94QidMVP
         JiBAvruydOmoB76raxGu+5mO81XZyaAU0V/SBEmR3PK2VXiuJfNKBoFrLMCVuPHlOTMr
         dPygMMw9Fz3xtlqG9kONBoyMwv2djSxyK25VkI+v2brWDQUyU1hZKJvJUk49MxpC3q+9
         0TSVqFx+2d0KKliNclG6NOEnK9W60IhKxSdvQ0WMv2KMBcNtZdd8E622q/PcS85PFssQ
         tZeIXCAE60a9ccsg4DEq3g7A0ljDPS4PdNDCOkrFO9VXJl4P5yw8JZtmO/uRhDJoPl4w
         JRTA==
X-Forwarded-Encrypted: i=1; AFNElJ8aTN63tsiF6GilSlmJLPulgkjbjnC2Snt43ReJoligduBY213CHjYFxd8QHeTo1cJEsJv3aDlkeKZx8Ybp@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcFYYl9x4xB8u528XgaK0PToAUATuq0L+YQdqhqpc28/rTJhi
	508XDOh+htglVW/x1TaXrxoPHBzzy9aSDKyQnOjLoRT+RG8d1asyAaakSI7JyLeloRRVDxZW2za
	orOaqxSDTycj3E45tkUBhsnPlT+ecNxY=
X-Gm-Gg: AeBDiet84fGxo45ZrHNqoFKXJueQehlliGswxlA8v3S2TDA2QpsJ4377ITPmsS0h50O
	10lP3bTtLWkt/QG3R1TlZbX0goAtHOk22OHeHQNuOH5/EKIOeel94q2uAMpP8h3T5Enz6mtFEl1
	mdo5t778qTqCOzXDrIpCDuMueIfHgY/tLb9XCksGWm7/AeUHJ9N1HgkUD2PhPHCnAcZTLfQjlTP
	zP0MOPf5JJnNk7NPy+Ikrixzx4WnI5TPImBTxTPYqH3JkagUDmLegcrrR1VMSn2qzxpV/1zettJ
	WJN/i5ZXmF5Ar7p9fx4SK8HL5Qw3iU4RxT25RCu/KMQUtQqEnw==
X-Received: by 2002:a05:6402:14c2:b0:66c:304d:bf12 with SMTP id
 4fb4d7f45d1cf-672bfdd8a3fmr8524590a12.19.1776955098975; Thu, 23 Apr 2026
 07:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422181711.1340269-1-mjguzik@gmail.com> <20260423-flohmarkt-immun-9aedcbd5b60f@brauner>
In-Reply-To: <20260423-flohmarkt-immun-9aedcbd5b60f@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 23 Apr 2026 16:38:05 +0200
X-Gm-Features: AQROBzCbxMR_lNreWZAqxGriFk2xKcP3XquhrY3kbNte3SmnkKFZCGYzmOJ1hj0
Message-ID: <CAGudoHHRLXeG=PncKcCLwi1iaN=pqLJWDQXMz2jQEJOgNTp0Vw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: cache the string generated by reading /proc/filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 3:36=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Apr 22, 2026 at 08:17:11PM +0200, Mateusz Guzik wrote:
> > It is being read surprisingly often (e.g., by mkdir, ls and even sed!).
> >
> > This is lock-protected pointer chasing over a linked list to pay for
> > sprintf for every fs (32 on my boxen).
> >
> > Instead cache the result.
> >
> > open+read+close cycle single-threaded (ops/s):
> > before:       442732
> > after:        1063462 (+140%)
> >
> > Here the main bottleneck is memcg.
> >
> > Scalability-wise problems are avoidable lockref trip on open and ref
> > management for the file on procfs side.
> >
> > The file looks like a sterotypical C from the 90s, right down to an
> > open-coded and slightly obfuscated linked list. I intentionally did not
> > clean up any of it -- I think the file will be best served by a Rust
> > rewrite when the time comes.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
> Ugh, can't we at least also get rid of the rwlock stuff?
> Something like the appended two (completely untested) patches.

The procfs thing got protest last time, see
https://lore.kernel.org/all/CACVxJT_eXRNjp-2sEfuxYmzTMPvu7U1R2bsKYjadVfR-W6=
91og@mail.gmail.com/

Alexey wrote his own variant and put my name on it:
https://lore.kernel.org/linux-fsdevel/c58291cd-0775-4c90-8443-ba71897b5cbb@=
p183/
. I'm not going to protest the patch, but I'm not signing off on the
thing. Perhaps you can pull it while removing my credit? The author
cc'ed.

The wtf list handling cleanup + rwlock removal should certainly be
their own commit. applying all of this on top of my patch should be a
matter of few shell commands, alternatively I can massage this the
other way around.

I did not go for the other changes because a big chunk of the file is
the suspicious sysv syscall marked for removal and which I have 0
intentions of testing.

Finallly, a review did not like the BUG_ON (which you replaced with
WARN_ON_ONCE) and the new failure mode of ENOMEM. Both bogus
calculation and ENOMEM can be handled with a fallback to iterating the
list like it is done now.

I can do the massaging if it sounds like a plan.
