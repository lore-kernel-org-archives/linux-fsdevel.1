Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57774D17B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664632; cv=pass; b=DjRHg2r6p5/w6IBoNBwNL5gA+l+ZVRtUdXG3XTWQBC/vr55y+YjQq5ruaGtZbvug8yUk+FjHTYow33YVH5vcrRa3cS4Wf49x63mlfci7Zw5+fTCZDhttJXG2v0SP/56GNPqjY4SZgT7t8Syw5Qb+0CZtYYy5sKDrgp8ataRs4Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664632; c=relaxed/simple;
	bh=dWqrfywKjEtr5wtVAxc0WKSejhs/grxWyCMDV7MugWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu37rGIoyeZfkZKV1yvCKeNAh6MwusNtGNx+ozkba2qvEq+/x/KfjupdzDKVMharMjSSJ2oK+EQRK+C28roju6+F/P5itr2PyrIcfpDSKHBTWkBtXU1ttOCL9iQg5TmR+v9r+haWnBPvtitve1RR063zPAVNMtBU1q/7mSv2pe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=AEQcnPwo; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="AEQcnPwo"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1e428so323556e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 10:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789664628; cv=none;
        d=google.com; s=arc-20260327;
        b=J3pWVCXeaK1mLzyLRlngf5im/B3+VToQw/zji5+JyFxT5aWEAAvszOuoWjaI2GNXud
         hHUFxBlk0/UBewYg9lHtx0kwqfyzS336DO5OAIMn5TTzGpd9S/zohMDrRTZIp6KgpX5l
         m5yOMqmJJMqVPfrbhlCXkRcnEOSOxPEBvfg/j3gLw4v08SUiiAPDS0/zUbxj0JiVzhfe
         aRJMu88jUddxw3rqhKq3tRzJhjAJoVJleZ0W/lnb+dwtnMwSKoPwzxVc25K1MM2r4HoB
         +sFB+bVXnQPd434G6NW5FZD6ThN88OwdAUH7slK/vLmXDo+57mBCc+ma+9q6N1G4vG/9
         TwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HzeMyhC6Hs8/MFNRkyNR3mA2RoNAqfMyU39GFmQO9Xo=;
        fh=AZsILFc+RVPxkpt5yqjZav5i9YuJkh9q00VFvQMUvp4=;
        b=KUf868GPgUUR8or++0lrqbI86QyUOHjc88TpJkGTuHjfAXI9itRg2XZujmY/Ur6AVs
         rW/Iy0e7FgUZIJfc0HDdx5GXhnPDNDgTNCX8IfyeQ1nSGzoVN3BCskqWg/6L/gPcf9gQ
         41irTl93Z9qFU4mfGkgYIc1HNR5sgjWSJbg466O0isDW8ebq9xYlqQPxgxLLfwCpAumY
         CT8daDaOgeVTV54vjZE6jDb89vekswP0Bk92w2obBh4DUYEXudqkWGWrD0eHQJ+AeV7/
         oZKaTsehn3eYFznujVfASjGjkWckYPu4EHRKFmrGrDDY+1x4v5X7JbxL2OVsQmzOY5cO
         HqZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1789664628; x=1790269428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzeMyhC6Hs8/MFNRkyNR3mA2RoNAqfMyU39GFmQO9Xo=;
        b=AEQcnPwoyXxDxi2G8HTMRz15+ecoMBo5bPl7J5kGmkKH9WfbT/LeHTAUBaptEqfNZI
         3Ms/Veu1OHZhbSQLHqnPoVtcLq7cmGp8H24HP7/zwWbI+1ZglS5gfgkEAg0R8cWEb+wz
         L2SWReCxRPh4U0Umk5XPEIBJDpCfDnEIBf+FymifgNEI5tD2/wWNHHIzM5ThWBZZOiTA
         Ve68G0CmbyHZxDBhMEl5UA09CBE4QCSyLbo6aQnQzR0WWnVzY5LREuNFAHXiwXFkLJwl
         +kT1uEinEXc+M+g95MQyLXJ1RQDHLJ/Adl4ej1K5Z01vB03TxXBnkdbJGF+LJJ/ltAoW
         wnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664628; x=1790269428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzeMyhC6Hs8/MFNRkyNR3mA2RoNAqfMyU39GFmQO9Xo=;
        b=KXzLtxDfc9qwh/bXehlEA43gcKpRTjbuXar3baQ3iqUW36yDsv4YHP3sQfuphogO3l
         d39uTOi8FfHfqU/vmoAZ6QGqqKWqps8n6QzKufgvVJoIfIi4b/5nY3Nl8KKDr0Rfp24b
         fIq2yqEegCacDYg5Z8R4gCwQwN2BUjOnzVEJdZW3PeTTAHWIzWLLfrORxpzoFP9vH2Bd
         b1K8ZyAJA2aa9yR9552rmhcV5heaV5BG/3Ctl2nSKimGrRSOsxARkei9zbLUO8E4wgHE
         pCEpGOyAaUc3+mGWBAmI2E+kbOdIvYG7LC2vpU78eJioRoPSmwf6RMKHqBiebjoyYzlP
         9JYQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2ZNv6z0OdlmPKE+5gFyTo2KRAQjmG//DbJWP6QpwHcY0pBMhA2v/IsDbcI5LPopNFu+rYOujxtfuj9Vob@vger.kernel.org
X-Gm-Message-State: AFuF++kztMjoFN4drsk0DVmimWkOF1fzPnRbhWQkUE92bbIuLvKI0tba
	Ilg0qgvsWyCmm9QlOxVeVc/mm0Qh/evgWGMyfOv9MOK/N4j9HOdBtA1wEcmPMLWlnQZHiPopWDM
	GgzsWPJ4wejFz03MGuTBt76J5y9+RoZcp4kDLNOS0D9zWNU34nYw=
X-Gm-Gg: AYBFou27GVJ1TkNeBLPxr2r9jMXkEX8eyasvsyU8ukHCLSbKjCro3JxCSVaw9trqxRy
	HNx6ydPoeb0VAv66Jj3dszrF+bsL2ON/p3uScjgAg0kmQH0I8wiqc5sW8peyCNawic094Uq4ZMy
	rhAaSFuX7wiNOvZZz8UI7KIx2WwejHXvRA4UYLHSQmDeAsSLaTQmWPMgZhLdZt3iLmdXBJYl9w/
	zftSFl8Q3f4s7xsvzDS1g0N1HlkyEQpEC0eIOqjJAr3zQYpq/4JjDcaIDaTiqwDQKskZxtV1zjH
	9ynNhJvq2xTWAOJCgX45NfFH6E9JBNLxWYHmRaF8FUSDl0PHSCLonD7A4bBGSQyx
X-Received: by 2002:a05:6512:2205:b0:5b6:10bc:b86b with SMTP id
 2adb3069b0e04-5b8ba70ed39mr1313029e87.25.1789664628461; Thu, 17 Sep 2026
 10:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913193815.2862366-1-mikko.rantalainen@peda.net>
 <aqcmz5uI7PgN5CT7@casper.infradead.org> <20260913235145.GY25906@brightrain.aerifal.cx>
 <eeb50cae-87af-4a40-b9c6-f4fa9981425e@peda.net> <CALCETrUgLj4Dz0s6PMofViJwausRWCvNvJphxWHUeWCCaRBtQg@mail.gmail.com>
 <f61886ed-3026-4db7-ae22-b882264141bd@peda.net>
In-Reply-To: <f61886ed-3026-4db7-ae22-b882264141bd@peda.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 17 Sep 2026 10:03:36 -0700
X-Gm-Features: AcwNN1Weixzr00PWb42k0GJpV9JCtwN__AI5EcYFAoTJRpSFfr7ruhHRECy9F1k
Message-ID: <CALCETrVnE2unnjHokG=bGLEXAeC0U8QRx_wb8fQDh-Fe5O6PBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] close(): stop exposing non-retryable EINTR
To: Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc: Rich Felker <dalias@libc.org>, Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, alx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:37=E2=80=AFAM Mikko Rantalainen
<mikko.rantalainen@peda.net> wrote:
>
> On 9/17/26 02:16, Andy Lutomirski wrote:
> > On Mon, Sep 14, 2026 at 2:44=E2=80=AFAM Mikko Rantalainen
> > <mikko.rantalainen@peda.net> wrote:
> >
> >> NFS and devices make the question more interesting, though. Some
> >> implementations put meaningful state transitions into their close path=
.
> >> Tape devices are an obvious historical example: depending on the
> >> device/mode, close may write filemarks, flush tape buffers, rewind, et=
c.
> >> Those operations are not necessarily replaceable by fsync() before
> >> close().
> >
> > I realize this would be complex and maybe a can of worms, but maybe we
> > should have a new improved syscall here.  close() is indeed deeply
> > problematic.
> >
> > On the one hand, we have the actual task of closing an fd in the sense
> > of removing it from the table.  This should really be doable without
> > blocking or without side effects (except possibly for zapping
> > old-style POSIX locks -- it doesn't really make sense to be able to
> > close all fds to a file while still keeping it locked, especially
> > since we report the pid of the lock-holding process).
> >
> > On the other hand, close has actual *meaningful* effects, many of
> > which you've mentioned in your email.  IMO it would be really nice to
> > be able to explicitly *do* those effects separately from closing the
> > fd, maybe even asynchronously via io_uring.
> >
> > Would it be so bad to have a new operation to do (possibly with
> > moderately fine control) the close work and another one to just
> > release fd- and process-associated locks and drop the fd?
>
> I think introducing yet another syscall would be bad replacement
> for the *inability to decide the exact semantics* we want to use for
> the current syscalls, especially close().
>
> It's pretty clear that close() is poorly defined right now. The only
> thing that we know for sure is that it releases the file descriptor
> and in case of Linux, this happens for sure unless EBADF is returned.

I think I mostly agree with your analysis except that I really don't
like the ENOSPC.  The kernel actually has the ability to commit to
having space for pending writes on an fd *without syncing*, then I
think that capability should be expose to userspace.  fsync is a
pretty poor alternative for code that just wants to make sure that, in
the absence of a bug, crash or physical failure, the data won't be
lost.
