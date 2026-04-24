Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA644214813
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015985; cv=none; b=TIXqJVBOSMsJl+g7VGx4mr9v7AeMYCKguktk6XLmNGfM2Bd9jZH04NByrT/Ux3coBZqvTjdKvBFSnwPZnMFOceGawAKkYzkgF3Vs3S3SDDdPgV079rtdk+ZY1gVK1/b4kTSaDJ7MvqsxYP3JerHJKP3Co5y/VD6OFf80b9pB4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015985; c=relaxed/simple;
	bh=OwiB5xL70HUG2XBD1Qstzuk6LTv1Ph8boI/7kSdoh18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNcQNFrKhryKWOooFZxbsjmALlj1B7XeUqdrJvqzpGDaDJwPC18SoXZTsmc3OH/KPld1m640uoFgGxguzoO/95AgQub5gTxG/fppKNYILh/e41VdLSyZzkesQ9bGhWy8dO9ZiuflwPdo41BUyhVm5U0hYUNvmX0tOgYe5pvOTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso4607234241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015983; x=1777620783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtsbXOcyL1ibQALxU6C+oQAYrNmZZMuQ00aeNmrTt40=;
        b=HrDwPd0GiYHNu1km3QOBIEWF7tC50E0ql13LJlEHRYCtjHhR0xfUoWfDMgSvTq4vXI
         TVph3M5YvwVGxSewtdtpIBliBXkubCB1pDHVl8UFC+iwLSmabo7+lj11oyAr1vZXwYQy
         wHm31ZETuf4Y82hxuGCRXfHqR6MoyKCHjohsVxeEaNs17PIjfK0oCVRLa7K0V3UbwBj5
         CKz3iEFSnNHfcl9EWwHNSWdnJPMFUs65fEH2+0+9q5iUyWmBkPtZdirxdmdFxrGqPzrs
         NidR8ldXBTHCT9NHXwIJldXFkS9w2AktHMsUK6VNc+PExP4OIp/lFo/w2kL1yrdSK9sX
         HT7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+SCVsGt5HJP/DD9r6Ly/pOTGRVkr4o6bDVGP6kW8DRYDB53BsOHWYWaoO6YALsfSIEGeRCivE+ZflG4nk7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4Pkf0fJ1ntR9cUshCyxRokQVaI3hhEaVRTq2WpAp4HH6otzp
	hbHsYbka7PciXxO0pzb1pp9LKPGYByprepB1TfbJCSApwiiyUiNEcQI/J3V/2V1MLMw=
X-Gm-Gg: AeBDietUZGSkJj/s5ylY8CywYnUDjD7LrfkZMkLfd18VbV4Uqojp70qWWSWtc3+Ifkj
	Y+JInULYotHw08MzdyYJUnXBA66hfsemp+D0w8yF36kaSJ/Wu2wmccsQozUnmlhr9JxazRt/TOC
	1Tp9EmlBj2fh5ZzsHcn2Dl2+ex+TKDefq0lv/FsBhisV30HKoTAw6sU4t4CaOdQOGTIaizamX4P
	eGXleEmHyD4iemWHn9Xh2QnWEX++irk3/a8B9e6RZ9Jp/cKry9PZe1RSgpYraE48FahjZZBA5SW
	wt/x0npW2xmL62v4GFdAx9N254P3Dfj/K6ylXRnk0bWvGB1wYg8NfkHWLcTJf4umJu3v5OzWBZd
	2AsJE1O2heuo3iq4cSMA0TbT7vaz0R1SmZx6JlmQ7r2/PniGGSJ6VnJpZKG0bLedE/1TMowzdcR
	RPeJ+HKcdw/bo4W4TPQA0SfftYKxUJUZ5T1bXR+tX8X3Rahm8HS/kAOhpdwoVmRmAs2KLuQFw=
X-Received: by 2002:a05:6102:c47:b0:602:ba51:5235 with SMTP id ada2fe7eead31-616f7c4b540mr15975614137.29.1777015983006;
        Fri, 24 Apr 2026 00:33:03 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6174272f752sm11002420137.0.2026.04.24.00.32.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 00:33:00 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso4350803241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iQklv9ZRMrlPYi8n7eSyD7vrnNNJFMLXeZ/MGgX4TMNKtCbr9y9Wzx4dpXuNBZwKCmHxJHNNdKVozXglv@vger.kernel.org
X-Received: by 2002:a05:6102:5801:b0:614:bef5:637c with SMTP id
 ada2fe7eead31-616f142f347mr16348590137.0.1777015979297; Fri, 24 Apr 2026
 00:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
 <20260415144722.GB74178@macsyma-wired.lan> <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
In-Reply-To: <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 09:32:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVouMXAvV-7xqSyCGYGjecoXp0dbZJc71ydTk1ZVjQFAw@mail.gmail.com>
X-Gm-Features: AQROBzCmvllIMxekOPEHB5GfKFLONKLmj3_0tjYr_UBw_DXckSWhX6-rJTkq5-Y
Message-ID: <CAMuHMdVouMXAvV-7xqSyCGYGjecoXp0dbZJc71ydTk1ZVjQFAw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
To: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>
Cc: Theodore Tso <tytso@mit.edu>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-m68k <linux-m68k@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kolbj=C3=B8rn,

On Fri, 24 Apr 2026 at 08:46, Kolbj=C3=B8rn Barmen <linux-m68k@kolla.no> wr=
ote:
> On Wed, 15 Apr 2026, Theodore Tso wrote:
> > Like Debian, the Linux kernel development community is very much a
> > do-ocracy --- only more so.  If the 32-bit community really cares about
> > Linux support, they need to be providing volunteer labor to kernel
> > development, instead of demanding that everyone else pay the overhead
> > tax of supporting 32-bit platforms which are rapidly disappearing.
>
> This tells me that it is time for "the 32-bit community" (wtf) to either
> look elsewhere, or start thinking of forking the Linux kernel perhaps
> sooner rather than later, so we don't bother "the 64-bit community" so
> much.
>
> > I will note that Debian itself has made the decision to stop supporting
> > the Debian Installer for i386 and the 32-bit armel platform in Debian T=
rixie.

Note "armel", not "armhf".

> Which is why (for example) Raspberry Pi is maintaining their own Raspberr=
y Pi OS,
> as they have 32-bit systems that aren't EOL for another 3-4 years.

https://lwn.net/Articles/1051010/:
"In 204x, support for the last 32-bit architectures would be removed."

However, by then they will have all run out of memory.
E.g. we recently got 64 (128 on 64-bit) KiB of "gaps", cfr.
https://lore.kernel.org/all/20260415190454.2632348-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
