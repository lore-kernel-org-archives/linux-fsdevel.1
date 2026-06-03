Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9031D759
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513746; cv=pass; b=YXA52KaEduDDItdDu5QjDsD546FkRw0O7piyhi7bXEkIAW5BTGwODFu0qCNrpwYMJLxjJw8y/5/9TbzijQDks+QoIANCmAnxZ7mJxBt52IL/U6/i/DYFl8RPvT8SmJEg2pGKdD2gHhhc4CHajq8X0KA8v7Gn4HgCo19R9aT2URE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513746; c=relaxed/simple;
	bh=KoIqLl9ia/cQ3vvTGufqzPvmoTqJlnriFaNn4bzxdYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrHbZHv1e3S937J4AisFB5mLoEcI8pjd6tw2Tw6AvUX6tZzmVRoLXT5BC154OS40KVtrIxcL+5FSW0C8i6gkVmE052+oJaI2yCpRgcAXgI8ReDOcFSU8Mz0KA6/yV07FRFW/lpbp4ZMRlvl0U0eM88rF6CtpHoT2b7Qt4IAwUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euU2EJvP; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euU2EJvP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so2150a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 12:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780513744; cv=none;
        d=google.com; s=arc-20240605;
        b=bVH8nMqau+T0eCzndqjoUCTV0tVi9H1B+TevQt+BhiewsU5Nd38vRTu4wsXYlIJaTV
         HEERZ4eMzP31hgqvQtvdudslcyjJ8BremNDZ2TcxpceUAwQGwk3JqUGK2bbntOy7VdV6
         aMti9ISOlaV3W6SVuE47lJIsoxDC0Sk9fr2zfnqkxT0G18eZOzs2xtkNUSV2Dwep6jLT
         5cmc4zAGWKkFGYWxgxwSIT0shkBQvKJQkMb+H8+CaPAy4UnTb0ekG4z8XAT5cVCn6OTE
         dh1fPtU0q5m1nLhwdQFScPoNs4wbiaK9zgv+poJRNiE80hXIF5PJg8SmeVnBHBndcMts
         LWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        fh=pedh/VCCQZbyC/juD2qjVlpdk7xjRHlw8riF1bkXhEE=;
        b=DqqrTZO58M7rdE5mFMAKAhZOdZQG7/Px4shss5kJeXRdo3S3ASAi+bn5/9YeBrgEyu
         aWkV0AjyyF8ZYoTFMMwT04GeFIDIddLmHIQ4GCiiuKmzyZz3ygkMi2l7pZBgi4Nr4vbL
         XlAZLS95Rijzm7F1jAJ/ake70icwLk3NAK69en/SUr+ItLQD/jtTVSSJw0QU0Xup9cSZ
         +dVvlkReh7hEe/DgXTfe4gE2nvfwlJDCSzn0l/XzyQgGvrAwkLUEL02XM11tptmvbhrA
         Lrg+8geORn3eVaHsnEh39nIJdYSM3Dj/S4XIPYKMyw16ijK/L24GNumiyI4xt9s5rG3n
         5OIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780513744; x=1781118544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=euU2EJvPIcSobslZIDTlm+KwhLhzm6mgfDMMta+3eb2yKyjbYfepdHd3kR0Ot4BcFy
         eIxT3OepTnUat/zOspR105lTPURT1d8qChCGwOIoQ1EH1ZJlcRoudFcpnZmbGS+Uz5dv
         5ieFUy7zCxM82v9AeayWk8mi4nvDz2Z8WD19zdeNAWnFBR2uM5k5JbG5ApBUfcs2za+J
         6pfGO0Q/TNMQyak3vLNzXEM0/5jx2JWmj2nP3Bc/xZAZVbl14PnI3xuZmwNsCC0O1C78
         lGouqM0Ex6saVn7EPFJc78vZBzffYCLOCyGAhuCtQutiQG7/AqvOO/KK+crCM+GO69X/
         YTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513744; x=1781118544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=RW9V4m8f1uvdLGORjF6UQYpyHxaEtDbgZcUiAi7sRy5o+9Gb7QQsFtFxx94hZayZBa
         Ge2irONlV4jST80Nj8NnSBl4OXXuQ43s5GlOfxfYtL2bexKbxCj+4IrGnkebRFSbTWXs
         N1fbHd+0L1xjAOkQEI0RkgBYMfR+obEpfFVSKLRFv+tUVoDdFRlCEwgRpbuYCTdVfet9
         K26OuWJE+MDbkVdiNSxGGnAoZeNgV8MkAPeDlYyJlgdX3petSvENB7xiG6rdDrPnFz2D
         3OmWcm9EAxXL1zmz68runmd2IMb5nxpK42zFxGST8DXchS//PIl4wSTcvZEGzD19w3jc
         Q9Gg==
X-Forwarded-Encrypted: i=1; AFNElJ8nil+fZIKBfIC8Od0vkBZoRt6Lvc8P3Vl9kbQmyKcVi+zMsZzpxayrL7J8IteeLxEEK3VnPHh8ZVBX0soY@vger.kernel.org
X-Gm-Message-State: AOJu0YzKI/EdqO8GBLXlTGqL9SosgMbL7YJunzlfmbxL3ZcNybeBzMZE
	V1zergnuLk2Q4ih7fJMbtxRo+HyAmnNsFCaeplVwuodfLbf5FZzxvi3RxPYT1W61a8RefSAHymd
	gdnhHYaxat7kWlW3XSQidjlU7a+tb4+r4mBSdoAcafLBg1ouiMgV1IEiuaMw=
X-Gm-Gg: Acq92OFc7PBnjgqsx0AnZzq1jCHIIBz9Lavgj1xn/IB0q33uoTpul7iH4gPXlnN95s4
	xzMEIxfM3W1Vh+akEqaQIeLup9XsSkHnxF2rJYeO57mdfGiVPRFOxrlhEs+I+UU6FqMpke1ohdZ
	tD33E7xaYhovBeY4SLm2SFtXKx1RoVz0owAntNkkd57zfepkFTDJNPIMC3YWEvSjnD/0BOWMKlt
	sVMitQwOqIFhXNzTKba46XnnVuBNgTKl+yd7jN/jLNkWLX5AAMwspSz7pWDuEhXlLiinXp1OWah
	f6oBjK9fzUT+FA4XewKcL97PllAUcgXeswucP/MgqvNmwURm
X-Received: by 2002:aa7:d294:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-68f12dc72c7mr5570a12.7.1780513743150; Wed, 03 Jun 2026 12:09:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV>
In-Reply-To: <20260603190225.GB2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:08:26 +0200
X-Gm-Features: AVHnY4IxxlNTB4Lk88aYUMiy55vdsorSgUlDA_6cJFrKOhsQwOKgMzOyo629T00
Message-ID: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 9:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:53:24PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 08:46:07PM +0200, Jann Horn wrote:
> > > On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > > > On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > > > > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > > > >
> > > > > > Fix it by taking rcu_read_lock() around the mount::mnt_ns acces=
s, like
> > > > > > in __prepend_path().
> > > > >
> > > > > > +   /*
> > > > > > +    * Containing namespace.
> > > > > > +    * Normally protected by namespace_sem, but there are also =
lockless
> > > > > > +    * readers (which must use RCU to guard against the namespa=
ce being
> > > > > > +    * freed).
> > > > > > +    */
> > > > > > +   struct mnt_namespace *mnt_ns;
> > > > >
> > > > > Umm...  It's somewhat subtle - at the very least you need to expl=
ain why
> > > > > there will be an RCU delay between umount_tree() clearing that an=
d
> > > > > having the sucker freed.
> > > >
> > > > Something along the lines of "removals from namespace are serialize=
d on
> > > > namespace_sem and guaranteed to happen no later than the active
> > > > refcount on namespace reaches zero; freeing of namespace happens on=
ly
> > > > after the passive refcount hitting zero and there's an RCU delay be=
tween
> > > > dropping the last active ref and dropping the passive one that had =
been
> > > > implicitly held by the fact of having actives", perhaps?  Only in
> > > > more readable form than that, please...
> > >
> > > Hm, like this?
> > >
> > > Containing namespace (active).
> >
> > Umm...  That's actually "active or has _just_ dropped the last active
> > reference and didn't get around to scheduling decrement of passive refc=
ount
> > yet", unfortunately.

Ah, right, I see, because the mounts of non-anonymous namespaces are
only cleared in put_mnt_ns() after the active reference drop.

> > Hell knows - "active or deactivating", perhaps?
>
> Note that "active" in such context is easy to mistake for "active referen=
ce",
> which it definitely isn't - it does not contribute to active refcount.
> Mounts within a namespace do not pin it - it's the other way round; they
> are guaranteed to stay live until they leave the sucker.  Anything that
> hasn't left by the time the active refcount of namespace drops to zero
> will get pushed out (and killed off unless there are other references to
> any such mounts)

(And there's also that weird detail of how, for anonymous namespaces,
the active refcount isn't used and AFAICS never actually drops to
zero...)

So I guess I'll write "Containing namespace (active or deactivating,
non-refcounted)."?
