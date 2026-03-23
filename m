Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97138229D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304670; cv=pass; b=JFCj3ZBHJxhGeL2jpOg4cvz1kMCiAJBhqW5L61q0vmErvORdgaJCKoLWppQVtiH8Q6ETPPiV2O2RmGq9J55XDyrnDjz5y5qhw/HhFeFNiepl9ipUj7nHMrHfz0Q3x1Am4mPiApLqAqJvgXGqACnsFs20f1K2Oxj4IGZiZ+sYpGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304670; c=relaxed/simple;
	bh=rke4pL28RFRiJ7o595i6TrcKO0a5BaWAX/D0JGGsMSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRCx6kSEqeSDYgS+u1XMeR2gig9iXvpRJyeq1V5uAzJm4OsC7K/iQ4CeGhS+bkagizHJnGFOD3gCLmHvzUi9AaETcLJxeaqDSIcpclQz0+m/a5wQPFZT+Mw+Eurwl2Wu0rFGCU+dbXdhvaQMyw+UcpdsuaxFY7V3y+3tETHeATo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoN/aVsr; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoN/aVsr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4870206f73bso18590615e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 15:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774304667; cv=none;
        d=google.com; s=arc-20240605;
        b=HxbWBXger8yIi23HO8VYyOcNTOFLcpy5xIR2Yn04/UBjWrnWtnP7HV83WWCSufpD9P
         +/Pg0npAiW4iwaUZOjOohkj/9r/xGou0IcTLJfJcVEBriLIYvxIKaJ7w29MxxYz8J1qq
         xs+3JRQa7NMHm2B2rpikOtt3TeLOXkD3SlBSWHKmAEFB2dqoG/6Yt4l/69Wowa5h+SNV
         1Pka1n11ztgtDvQboTo0lZWVNrlVX/ozi40/pT1hgL9TXz1URrmHeMTpgvqsVRLxkOFS
         YWL4S6QsXfK7L/F1AGrjbc0xyc7YO3wvtUQY8AawnG3imFLksac0yvIdSIOetECTkmbj
         t3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rke4pL28RFRiJ7o595i6TrcKO0a5BaWAX/D0JGGsMSA=;
        fh=hKyZjERvn5ijQRSXkw9PQNIpZl+EChpFN0dSA7fAqA4=;
        b=BUTk63hBL8Pc4BSkYgU6wtv9/eB2FqAYvLQvnblGjndtHv2t1heULj//XWFYFb/jw8
         EIl41Zzg4xtCBXwMFmbLRKrj1G7nwHaucWBbODrACdnRNsYuN24YaTkE0bevZ5ov/GPp
         sc0dXiF38ub62s489vQEvNrE6FVEfFOB6icuDnRFYkmk0vCq9+qiRk8sz/WOpaCiZFmw
         dxF+GQUQlznDfZqtqwRd4diiP6GEnpbyVhfsjZCKJURrkC3FQ6mKd9wJA5RJB/jP74Rv
         dRqUnC3nJ8c+e24YTEHwkMiyOYU3nTV46FfBWpINejBZGVP1vT/vpzVZ+OodLDJIZWjG
         gJVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304667; x=1774909467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rke4pL28RFRiJ7o595i6TrcKO0a5BaWAX/D0JGGsMSA=;
        b=RoN/aVsrfvypgeS3KjPfXwPcVhrBSNhyqJvWsy6s/6soJP0CRiVtbz8KiOCaNtnXLF
         EBL/ahSeNGM7EX8Ja5K+ZlZjga4j1Qn9kOICFaDPzO/PiYaw0lJFwtiRYA9kC8vyC6a3
         eEL2wlxKEkO0bXidvMfFLXn2K5ZpwGs4LULFVv1dHxRTOcvYAbLFbGtTnETdnD4TrNBh
         4rfMouoM2mkFrNC0OGS6flgF7qVULTZshjrM5yWqj4gQy0l4odX+88LLcHbgM/Yk+RZj
         FNpibxH51VvqUwXnzx0B9z2nB071vqOL9Sl5y73Gigkzog99uZMWunQsW08cfISL0t/z
         4SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304667; x=1774909467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rke4pL28RFRiJ7o595i6TrcKO0a5BaWAX/D0JGGsMSA=;
        b=HhgVw6Hw3Ocb3Bl9f++611+6maC6ZoPpvQUReMbaofSA0aUbEN6XSfhOiwoDbIKYI+
         wsM7JTcjyl6IhK5E4dEI4IfTFfi7LpZD3z4tda3yEp/1nrP2JFsAcMs22qGLwi+QuU4T
         2aGYgE0ks/MPOfp5XynsFkMoy05BlMiNUWJUdZnQRxTgfHk99qiixRP/GBTui4DvfDSG
         xC0bINFaKo1fgOMQpsfazeIWrbH3nBKajkmXuY7QB3Jn3/PeOA9+/uA31+EMz+4gFZ74
         wONYLA+qP3KqCGbOYhKrezwuMcwAMolJuvNSKoLxxT/YBifvwT/s6DEUOwYZkS/PnDyH
         0+wg==
X-Forwarded-Encrypted: i=1; AJvYcCVhAjpmeZbAzCEwLd9RN76wbmsbn2CWQSN+uf1rFKjXCcZEew1yHSLg30llR000mnv5upbazcaj+bI3ifh+@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdlbiMn0jphiytahdDC5U9VLv5uZjRt4dtlkU9Qe1DqR+UhX8
	f4e5UhsSCuDkVTbSe9Z/f5qQ/j+o6eh+7X/D8KiKDD9U7jE4SbDL5VGSIgaU69q12BgI3xf/frN
	4sngCsrleca9QZLGiLcmqdPi/QNWkJVMn0r57JkE=
X-Gm-Gg: ATEYQzyNxZ9DmK0HOeT1bsCb+piJMaYBSgomdgauCpFp3osElhbE4sbQVlqPRBdAhHb
	3tPI5xo0CU8R19MbBJ6yowPmtd5eqmh1s52cyq8PhVgVfeGQzpLDUZ5vNwKKb+whgAFbUUZurpO
	wHoaAIHK/3S8VRA7FKMfBgDhffPi3JolkA5c5hBC0t679OvjuNnbUPSL8MmKstTL+38IPfx8b4C
	rrUZZ5oNt7yuSre/+y3tvJ7b2/svHB4Ayv9Pu97DALDqJ8VLmbwMcEvB5rG3dXtxlykgKljAbFt
	xT+jjw==
X-Received: by 2002:a05:600c:348c:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-486fee1af1cmr166395205e9.25.1774304667138; Mon, 23 Mar 2026
 15:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAJnrk1YWd9HvVLTtZDEM=XyOaPvkuSF8O5uOu9k=m=tUREsw-A@mail.gmail.com> <CAL=UVf7eMk0E5w9bMsBYCtTg=AQ4z_R5U=4HmOt=ohb_78CU2A@mail.gmail.com>
In-Reply-To: <CAL=UVf7eMk0E5w9bMsBYCtTg=AQ4z_R5U=4HmOt=ohb_78CU2A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Mar 2026 15:24:15 -0700
X-Gm-Features: AQROBzBYJsRdRbTWlER1i1b_Mtk1u5Gb8HVg903U7T73LeBrxpsf19ehPqi9YhY
Message-ID: <CAJnrk1aiomHF_iO=vgdR38QnOBFtQtD=pbAX5Mjf68DrsNW6Ew@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:08=E2=80=AFAM Paul Lawrence <paullawrence@google=
.com> wrote:
>
> Unfortunately we will not be continuing with this work - those of us
> who were working on fuse have moved to other projects. It would be
> great to see someone complete this work though, Android would still
> benefit strongly from this feature once it is upstreamed.
>
> Paul
>
No worries, thanks for letting me know. I'll pick up this work from
where it's left off and send out a v2 building on your patches. I'll
make sure to credit your original work.

Thanks,
Joanne
