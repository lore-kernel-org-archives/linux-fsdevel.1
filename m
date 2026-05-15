Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2438839E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873180; cv=pass; b=rjiX7undIMSvTEBuwqlVsM5NQMun38ADdnQJL5i+h3khEaH/AoHgvQrNIVYlH0SUqtGeUQIi6jNaOmI4sQum3LlkXhzrcXTZDOTgRIZhywfrKUpg4RlzPd3FtbrS4pmm9Fc8ljJvPKOjGfeXDxdq/5Jx3TL0FnV2M67K0q3WM3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873180; c=relaxed/simple;
	bh=Jtgk4bHY8pKuFBHiUXn1hiwti3fQNpoFd2aLiayn518=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pys1t+esIjp3IGbRnXcEz2liHDhemIurDRuwlWDHqpYwN9FSZ8d+d9k2Ww5L6lpN4x49vx5Zsx50qtmBmcIZeoSee8CPzihzkxu+/37CQvBovDMenUppGUeYMILuiu+/frLRaQk/kq+YQogHclZFWl3fjSbjNDeY5TAqDpOm41E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNEOZhV3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNEOZhV3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so418234a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 12:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778873177; cv=none;
        d=google.com; s=arc-20240605;
        b=iFeW66GmRCY/czfnawSKpHrdNA+6EVhaGxymy4OgsCyVbSogi83PNak4T6C/77T0Ir
         sbmCK6Elk4iOPLRbJciRORrarKeo/3BkMZvxUNuRQ7/ctQy2TiB6sHn4ggV5kBX2RZgX
         2JKdh75Nk4vVI2ZZxJAvMF6Iq441ijDyLFCJh26n4IRhNsQyWctnMYACbsCOjn5bmEsL
         yXAWUbyaqWtIO0JJnL023/1Q34E63XsFipdvJzgL6YgITwo0pMWEb0zuktJKSXoheGOT
         /R/Orlj8Zdo1fm90XUjYl2Otl+qPUAMvwO4mFQwuQ/Yy6PaWnC4ioUY+44pMQTb269pG
         Wf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jiIo+3Wea/nIZVC1zA+sluKhGCgnPapnZDBPldsE1Bg=;
        fh=Qo30unysIL8qyL2ZV7iV8N5KWG9++QQCiE2rakQ2DJw=;
        b=irTvWtQ5EEAeySbXJKT1GfMD1hDwfJQOx1E8+WyhD9R9wsELrCZqqp3Vt8E5ubfzif
         xkQt1vn+8iQEV5l6BqZyidfagFfHQzhr0cp++tmPYrNZiBHu79Fcs6zybbPyJ6UQIbFs
         OXoHcFHjgCxG3qNCMUPBZ2mgdCIo379NV5owu+7Kc5FIpn/+0qMVZHnLtrVoUd/HEiCY
         cNpSY077Zg/nrzi6uWJHApL/ehBrYi7/qxoTYpQCclpb1rIXIbQoK2YurvdqHDMfFO0b
         ZXnzTa1My1KakOa8Ur91w+ZzDlKS6EeMKnGW1Y6x9NqYnAvZKmEhKuc9Ak8maP8N9yGZ
         zKgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778873177; x=1779477977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiIo+3Wea/nIZVC1zA+sluKhGCgnPapnZDBPldsE1Bg=;
        b=KNEOZhV3vckTHGPSL3T0pkLMJmzkD4dwVdJjEGhZJXUiWmF/94ElGUFyWobYFZFy5E
         Qc3jh92SoocE5UJLywIeNzVcOoUsedHIVN0jGYzPi4aCgD1hZ934FIC7IY4bJqsDRhVj
         jHrgGhWnAyUoFqzYEDTPlg3FcKep4Zi8SGL7cczwtd4YgYWPQiApcqVscJxYCC8EkZkR
         Jn3DzLZXZFUITVBLdvgthrTNZtHC6qXWDUIxaE8azwPOzJze23NBJAji5rbjtgQsa9Nt
         UNbwz2wm3yFsDQqO60rc877ln7IyRkZ9BWaqL16Ezp/N8n+9US/zmkYZ6Bhcus3kCeaZ
         VsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873177; x=1779477977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiIo+3Wea/nIZVC1zA+sluKhGCgnPapnZDBPldsE1Bg=;
        b=ih8Nb/1tnCDr2E8QrfeIfSrLNR9ouOdj8g5IuTNcznfEYoNrqu8oaBA4wTS70lkFjG
         TRWmNXaLZoUxz27DaRfEw8O1db20eQkTwBx+Agt3oKJnvuXM8MEU7r1MElaMN3AgxaOF
         pLyssc4PGG5ZZW2RreTks87dTgTR0pOnlW/pwg1ytrGJcVN5OBaymbUM9LWGOSgCbXj7
         DIHexzBzTN7PeebwkNGRwq+1YbnVXwXYDfDGcM1I2JajV99iXJKyacmpLxJcc/+IYNlP
         ybOncF9vYDGr3KFjNxR8f95jamfk5nVZWqtI+d/7yMpUeRyMtolEk3+HE6ej1APF7gy4
         O/+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9+lKMFOpvECrjiasFLXR6eDH/j/rR8OjjjeREAbNr4Tr60QLUbt/4xrVvyUfLNnT/7KDru0R1TTJnpt7YM@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl3/DhWu/XRscSfR8ld1x0KEXR2i6V6mh1OfY9LVfsTJ7Ltpi
	iY3N9LPF+TrrYOJSxQhCWxcRp/3B9NhL6lPvn0LEdHk+p3upaJ1to5gFDU+WRLI3gAUaNrCWgje
	PcOD2A5yMRCt1P5z7lFutu0ZYTCkgAos=
X-Gm-Gg: Acq92OFwnkG8sQaW6jz7vg/0Z00/h/o3BM10oWZkl5VQhsHaRhu5JZpCbuCW5i7sY0R
	JNQBvlB2BOc95Z9BGGVJS6VfjTs0TNjoqj2CZJjT5nHs2mwLDgYlWqgFHj/a0sO0H6rInCNSMxv
	/m2zzMwSqfFSvDG/rDBbXRYM0nb9DzLeKfMCkOQzLJkPCgRVpH/ONS6sH4C5tjWzQpmFuMt9wGx
	WfdCS7CXewbpmfiFdwSagfIBQbe1M/m638tnLK6m3uyJZpKJKIa0ZIzRhpoFknn0nygByXpN/gN
	YLXE3JWzJjSZAtaudHqBsP/bIDaY0IXHkDiJWH12uRCvyJ5doT8IGWUzSyusq+I=
X-Received: by 2002:a05:6402:4307:b0:683:ac2c:c9d4 with SMTP id
 4fb4d7f45d1cf-683bc1baaffmr3088704a12.5.1778873177226; Fri, 15 May 2026
 12:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200129.94862-1-amir73il@gmail.com> <20260515193010.056ef472@pumpkin>
In-Reply-To: <20260515193010.056ef472@pumpkin>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 21:26:04 +0200
X-Gm-Features: AVHnY4KfupsRDCYO_GrvkrSFtkgr4LmPQOfCXSSMuhckYtDQtaSoNxEd8px8-G8
Message-ID: <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
To: David Laight <david.laight.linux@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 14 May 2026 22:01:29 +0200
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Code using ERR_PTR() is almost certainly intending to produce a value
> > which qualified as IS_ERR_OR_NULL(), but this is not the case when
> > code calls ERR_PTR(err) with positive or large negative err.
> >
> > Introduce a fortified variant of ERR_PTR() whose return value is
> > guaranteed to qualify as IS_ERR_OR_NULL().
> >
> > We add this in a new header file err_ptr.h which includes bug.h
> > for the build/run time assertions.
> >
> > Subsystems may opt-in for fortified ERR_PTR() for specific call sites
> > or by #define ERR_PTR(err) ERR_PTR_SAFE(err).
> >
> > Link: https://lore.kernel.org/r/CAOQ4uxg=3DgONUh5QEW5KJcyXLDF15HbLnc9Ea=
7RKPcgtyfPasTA@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Guys,
> >
> > Please follow the Link to see the sneaky bug that Nirmoy tracked down.
> > syzbot has complained about this a while ago, but neither me nor my AI
> > helpers were able to track it down from code analysis.
> >
> > Honestly, with AI review, this class of bugs (return a stale err value)
> > should not be happening anymore, but it annoyed me that ERR_PTR() can
> > return a value which is not an IS_ERR(). It messes with code flow
> > analysis.
> >
> > What do you think about this macro?
> >
> > I intend to #define ERR_PTR(err) ERR_PTR_SAFE(err) in overlayfs.h
> > to fortify all of the ERR_PTR() in overlayfs code.
> >
> > What do you think about this opt-in method?
> > Any reason to make this more widespread by default?
> >
> > Thanks,
> > Amir.
> >
> >
> >  include/linux/err_ptr.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 include/linux/err_ptr.h
> >
> > diff --git a/include/linux/err_ptr.h b/include/linux/err_ptr.h
> > new file mode 100644
> > index 0000000000000..829ec5f771528
> > --- /dev/null
> > +++ b/include/linux/err_ptr.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_ERR_PTR_H
> > +#define _LINUX_ERR_PTR_H
> > +
> > +#include <linux/err.h>
> > +#include <linux/bug.h>
> > +
> > +/**
> > + * ERR_PTR_SAFE - Create an error pointer, with validation.
> > + * @error: An error code to encode as an error pointer.
> > + *
> > + * Like ERR_PTR(), but validates @error:
> > + * - For constant @error: fails the build if the value is not a valid =
errno
> > + *   (zero is allowed, producing NULL).
> > + * - For variable @error: warns and clamps to -MAX_ERRNO if out of ran=
ge.
> > + *
> > + * Subsystems may opt in for all ERR_PTR() call sites by adding after =
includes:
> > + *   #undef ERR_PTR
> > + *   #define ERR_PTR(err) ERR_PTR_SAFE(err)
> > + */
> > +#define ERR_PTR_SAFE(error) ({                                        =
       \
> > +     long __e =3D (error);                                            =
 \
> > +     if (__builtin_constant_p(__e))                                  \
> > +             BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));                \
> > +     __builtin_constant_p(__e) ? (void *)__e :                       \
> > +             (void *)(WARN_ON(__e && !IS_ERR_VALUE(__e)) ? -MAX_ERRNO =
: __e);\
>
> The object code bloat would be noticeable if this were used everywhere.
> But you could make it a bit simpler:
>         if (__builtin_constant_p(__e))
>                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
>         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
>                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop and other=
 boundary errors
>         (void *)__e;

Yeh that's nicer thanks.

>
> The check for constants may be fairly pointless.
> One of the static checkers may already detect the obvious fubar ERR_PTR(E=
INVAL).

True, but I figured it didn't add much overhead if we are placing
the runtime assertions anyway?

Thanks,
Amir.
