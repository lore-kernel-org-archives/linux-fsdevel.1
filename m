Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A992EA151
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802954; cv=pass; b=ABMZjGnhXYOrYdNaKXg+1tat5WGA/yDOmEwbRg6fwHC7zNuxKntFAwsce22Hhog8rj9I3mGuVm+FoSuh6n8zqI7bw/KbomewYgfUmDBuy4vWpMmkEsKspyIhgTVEKSd9EErn1BLtCON9u4XZxp4UDfP5UBt2XWEt9hS4UX8RQgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802954; c=relaxed/simple;
	bh=UQ7L1Rk77tjEH/uDPvn+IeX8EXJ53bqIIpQXR6yRnww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEbdblSjeCac12UDWIoHId16h8tBwEd4HNReVo+loWja4gfRtapzlCYU+/W0K4eeKdtb1/a3JS6uXtAIWfWHFxwN5yumQfbjlxzx7D9cRkS/dKPg8cCbfEdX8P50Az+Urwd7KxkN7Q2Dp2wrbGIEeN86/n4kuZojC1obPMQAGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZayOBSr; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZayOBSr"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso6017295a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 13:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776802952; cv=none;
        d=google.com; s=arc-20240605;
        b=iar+GBE2YamvmXQwnfkpM7Zmi7Eu2lthKJ68la3MqY6ytLUWRatGDOoM4wAnosZPVf
         0r+mtUCVzXYGTiWQvuxRW2tqw48lKsQfGU3q2AuNP8WrFtyjFwYYJVUB0oXDG/qk2Ssk
         4VcFGupDSgOOMX49WPUMDa47jhKuIIjhHjJD0W7btGaxFOhwAUx5B0Utnan/pkNMjJJz
         oiKzYpAo4+mjJazBdsBYDAi/7WIi0q3NIo2S5PEjg2AIgSJHBxEdHgFC8j0WrpSeVM70
         KVWugKUeXJNfoYziBRmBTJ+vqeHMd+hzANQiCdl3acA6f3+7/HsgT0L1AQkkUrzynNsd
         6cTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4kI3OMko1R6Z9dulYzeN5NP3wrCV7OEUGufKljgQDfw=;
        fh=Uan/BLrTdvPxkFoAwy4GvUYp5fdPwvwS8G6mc2/cxTE=;
        b=cNttM4WF12mAbY7Pi/XQ6JK0w1nfoAUV5m8VeGi2qVgD/+9ahEf082a9N0yCNPuZLw
         T5M8birX0NyD1+ZwVzFfCpEIw1nmIdlxbDobPNhpkLf10SidBrUhVAHhp1g6t02+7MbH
         PsTSYLgXSygWQRbePIZyO+/QEndYYOyxr6Gu2F3Lu9F0DGXjsNr4DwY5j50brTki/0Ns
         kWehfPeUDtUELh0LwCQw+MhIGqRfUkDubYtz5xBPEkwgKsu2Jkqvu3o5e7nZ/dKqEXaK
         J5XgBjtuwbORdNBoqN0/7UeCL7fVrmb3UpBsvUXtVsMC8/VtDaPPNaj8uzVKjgclkQ6V
         +8tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776802952; x=1777407752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kI3OMko1R6Z9dulYzeN5NP3wrCV7OEUGufKljgQDfw=;
        b=pZayOBSrseeQOinr2rnnKFAnHfxfWkbHWd5d5dJLHvy/QYB93yj9zPjYdfgJfNjvSz
         wnExgdPHjEKT3Iec5yIzjl0CdoivfiekFOl1fJtWK4cbmzX1tImX1nTt0Wo3F1cVDC6U
         zi7Zw0vl/bqUIOoXiU0J75kNMH8h5A69/5rIlxmeRo4Y+MV5NWPesaYOt1HInT5foiBf
         hKoRKT+pjrN8WWGXPiv40CPQCPJwjViaqsRBZO7Ic93xx1itxygWIC/+leh1UBF/9Ojo
         LGDT9m3tH+f4E3UJiWqYVygn5EoLRf2HyEwC7vEHtV+C5ASAaFAPGtkZG7dWO9umHBAn
         lFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802952; x=1777407752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kI3OMko1R6Z9dulYzeN5NP3wrCV7OEUGufKljgQDfw=;
        b=sPXrau3Aw172oRHi5l70h1Kx1OFEEPpWuG32nsB99NfVi6PgN+fztCBZQTwUzXtSZZ
         bY164rAsd1PtG2W1ZOg2Pk+QFLTxG0+yrtcmKysbP0bvSxmAJTl9Gbwe0jT5jo6dwOir
         U/X+OOvWVeY4kjSupzP+dksVRp90bavoPABUPHGRdUQerutnrumL/Eb5deaLPVlJQAL4
         w+L6kWDWcHtCS+xaAHhU51qaZoR7PqF5Y4qc2pFh/dVq8G19lVQGPqiPghnXN8wu9g3q
         ZBPY3QEdMDmN9+VBTFa4I5vNEEBWS4X16febFkQD4yBB8l/O5okGV3u8uC6Pr+RIL8pb
         5tZg==
X-Forwarded-Encrypted: i=1; AFNElJ8QqomwoFgdKS2M7HIrLV0qQa+esO0rSMkGlFVZIM1ZqRwraSkBvwVRga4bkALdCGvbyjRYAR2nrN6aFCvi@vger.kernel.org
X-Gm-Message-State: AOJu0YxPo1v0S+4qls3t/AfS1eiFWuwKZwagvuPJi/37GD1TAgcvzbPU
	/pDHqT6KxwJwcDuDjPvlmipC/bWvHkpe/gfaV4vS+OorjQDQopyXP0oMCryzNsVS5OYBqhLyMNe
	6sbxaP8o4QcarbyH3RcO0XCMsuaFEKLk=
X-Gm-Gg: AeBDieuTaE4xhNuT6y1ZPX48BYiJMiRmJ45vGl/exTgXSriSZBMSoQIcZeUgF46vDs/
	atciGLVVEG8wUu9m2FzWa9hrFCw9KNMKVOshL003sgEmAWZLjtD4ihMhMCfZOTSM308L+jmS0Ud
	QCmklgx5HoReDZFqM6WNa5j9zvhs9G37BdPvlLANqTULLlg0U4XlYhKpZ1gqwEVjWUdMNcF5hgK
	Jx+OYgl9kCGjaPzheteF+QvuRTyXmS9UhMs+d6muNeYy3Dkgkhl72NN6M/J5XQFIAxJkDHYEd3D
	pdZcNiy6mPL2CAdmcPU9YevKQihQheYdytS0VyKLUh0rz9Xk7q6D
X-Received: by 2002:a17:907:789:b0:ba7:d65f:3b59 with SMTP id
 a640c23a62f3a-ba7d65f48a8mr484047766b.6.1776802951314; Tue, 21 Apr 2026
 13:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
 <20260421181026.GG7765@frogsfrogsfrogs> <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
 <20260421201502.GH7765@frogsfrogsfrogs>
In-Reply-To: <20260421201502.GH7765@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2026 22:22:19 +0200
X-Gm-Features: AQROBzAU0m207U2ZQWQAAweH3LTzj9CSrhT--_-V5SrsaTKsprf9RTsloamgE5Q
Message-ID: <CAOQ4uxg4S=1jBGusNSHDH20+AHdFucFfWie9wqBU9V=LUWqwUg@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:15=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Apr 21, 2026 at 09:42:23PM +0200, Amir Goldstein wrote:
> > On Tue, Apr 21, 2026 at 8:10=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 02:08:13PM +0200, Jan Kara wrote:
> > > > On Tue 21-04-26 13:17:34, Amir Goldstein wrote:
> > > > > On Tue, Apr 21, 2026 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> =
wrote:
> > > > > > I definitely want to keep a clause like this. Maybe I'd just re=
formulate it
> > > > > > like:
> > > > > >
> > > > > >   - Handle security issues promptly.  Both those reported by or=
dinary users
> > > > > >     as well as those reported by fuzzing tools. Expect that you=
r filesystem
> > > > > >     will be subject to syscall fuzzing as well as filesystem im=
age fuzzing.
> > > > > >     Dealing with maliciously corrupted filesystem images is not=
 generally
> > > > > >     considered a high severity security issue but still it is c=
onsidered a
> > > > > >     quality-of-implementation issue that should be fixed.
> > > > > >
> > > > >
> > > > > I can take this version, but tbh feels like debating this clause =
misses
> > > > > the main goal of the doc, so I'd rather go with something a lot s=
horter:
> > > > >
> > > > > - Handle security issues and regression promptly.  Both those rep=
orted
> > > > >   by ordinary users as well as those reported by test bots.
> > > > >
> > > > > IMO, getting into more details doesn't really add much value to t=
he
> > > > > prospect reader of the doc before submitting a new filesystem nor=
 to
> > > > > the filesystem reviewer.
> > > >
> > > > Agreed. Your shorter version conveys the idea and the details aren'=
t that
> > > > useful. So the short version is fine.
> > >
> > > I still want
> > >
> > > "The filesystem must handle corrupted input gracefully without hangin=
g
> > > or crashing the kernel."
> > >
> > > to be part of this.  Not screwing over a running system is important,
> > > The guidelines ought to make that explicit.
> >
> > Agree.
> >
> >  - Handle security issues and regression promptly.  Both those reported
> >    by ordinary users and those reported by test bots and fuzzing tools.
> >    The filesystem must handle corrupted input gracefully without hangin=
g
> >    or crashing the kernel.
>
> How about
> "...without corrupting memory, hanging, or crashing the kernel."
>

Sure. works for me.

Thanks,
Amir.
