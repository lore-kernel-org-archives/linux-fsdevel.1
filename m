Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72437C90D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383449; cv=pass; b=DGUfH1ed1GO4T5/ngrJtcVT3t3DkA2S0IieymkGmtJLnj6JGyw3T2PmAEmI9kyXYmReZsHCf8ODuU96cF9Y/+VhVn7ajGwHVIUaSTdj0jPMf7tKFzAo7Z437YwCtrBd+u+zvDrRINRGX0rwNnQSBetk6U+0S4hegYWdT2m+bFrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383449; c=relaxed/simple;
	bh=kuOC8uviiel0ku7NLm2HmzNftnSPFIHhwmn6rM5qaL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1zwMW+07UMYEGbxZpd57xNN64VeFs10Z2AgbngfAg1fhQ/kMWCV5QJmjJ51oKxgnq3inSXd0oTsgVP44VPBR0pcfI2iSbLTE+Nr8ES2wEgtPcYINd0sY1Fs1uHZAEmon8MPNVBzYOuR11RB3B1B2GlbdO4+UStmflj9ONYJakc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYBnA45v; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYBnA45v"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6870a365c77so4819374a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383446; cv=none;
        d=google.com; s=arc-20240605;
        b=CaXWvE1jjNjcpNYC5JPWix4A3W3TJCzShCWGJVQhJo92Iq4W3m+aOb6Zw/mD7QjoHf
         Fo0mq5qqZRWrbVHpFbQdVAEzI+PQZb38BOC8awDmIpFgfxNDcDUiQZhpKxJxj/HfAOPj
         btOy8Tf1z+pnr0R49+4UWR/ARNMa7T8/eKRwRMCPxRCDJyaru47cihMEm5ht0QOQlusO
         QoNHTRXChAzQ+s1nAeYA4iCzhwqszdgXRumnfwNS4fOoFbGnMqDYFdYfh8EcO0FAA4So
         mlgV/fuKD7pHFYoGuTClXDbX+QbFjiK3R2Sb9Hh3JWbIFcHdilrIv1bjUF9QFGcc+DiH
         N1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eqBz1KGet6OjgMlU1JIe9FWKGT/cDQ5mC9+7atZ5u+g=;
        fh=1lgozltiTLAC0tUuTBffm3RnH9InvQRxd8MjdZbaX5I=;
        b=MsxrnlPEjPeg7NpI3mWiSbl2XPKVr/TecvJ6WsTlpioloI3SF/4ZrBCc8mw4zl98q0
         ADpNfVvwVrxNy2xJAJ0hmNFb50kqC6AqDfbdlO5Uy0OsnZ+u2qllF2xswk0tLauain76
         u0lnpv4URWZ+76fftpAL5hseBCQ4MmgnuatgiKBQqsk86fgQJmdum1wivtSB6x7sPEDU
         dPOSm1w0Fq/udmMTyDMTp1eJE6A5khLhmeKc2NT1NxQ9Z91xQ48YRcc1ZZHDYa2YqUam
         x9ZRIkEOtgxRxGuUy3dCSWLiqnJeQFYgL+dtRKxroApM3gtDHAcDfsSu6TMycFwJd4uO
         8CRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383446; x=1779988246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqBz1KGet6OjgMlU1JIe9FWKGT/cDQ5mC9+7atZ5u+g=;
        b=cYBnA45vp8NEe4/0TQQUGS0mK+vjW/gKydrOnSKRSdJUNwLl7eszV2viOW+A4OHa+W
         +4Q+/n6J5T1q1tlDb017xLEj7PBIdcFeGICRL8xlFpe9HGKmG/pEaTbqkqfcjbOaGqyl
         boJxQ907tq5JjM8eUEhixY6BsOh+XAFN7z3FmyxihQ8I0kme8NabS4+MXrGvUOwR4C7N
         q4sPhTtHvULtsxAr4/bPszffuL0JNz9l3DM6hG+Eqc4259vPSG7jdeM06/WldZTSzA4J
         YcuojHHlK6QqvVgbYWCvpc0k50MJ40nmXiknroBoF2SfCrA1x4MQZ0wIkEINZSvq2WPd
         hGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383446; x=1779988246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqBz1KGet6OjgMlU1JIe9FWKGT/cDQ5mC9+7atZ5u+g=;
        b=nif7H6YN5Qx/G3w35XamC+2eleWbDsTQsBA8KV/GJpHoCDjpryqsRa8ogXY/V3e8df
         9RhAfQoO+vb3jipf8a7E9nsa/QDmHAgtr/aPscn3goVOBf6hb/rhxs8Dsfq4Dy1dPAbx
         bsWT99sedCHKgjXhYB0ACXkGsmQhbm/vaJ3MZMlzeestFPGDuEcOx1twkUnB3ly1DiON
         wvbzET1XSPJk73RuU1Ximlv5XKDBBSr3X2zZC5mMr2ZeIZNDeqsdMH9xKQEQG+nix7lq
         QPDbnXFH7h1s98J46ajl6SxMqz39Q4+p/2KoQn3+kjg71IuARJFM5cqZdlW3nssiqE0K
         ptuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2NZLZOa6RMKm2jGj14z1czs9IR/l370yetZNO4U0kE5o7q3OHgSlCdHQ94FHobcl5zhfR8uVFs8rgAkp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm43M90Oz7+F+dJscWyPOOcdHMVEXrRcU3ncxigRhWmSKwYySY
	tgoexS49TYSyJZnJfKlrsxlGrHU/YqlwZx0lCF1775spEoIuC0bjxlvaI3qwIGQJ2iFxpJYKvT6
	smNVQLewoJLoLWEQFrREjDIX4l0xwPrg=
X-Gm-Gg: Acq92OHRdsonI398FlokkZuJkfKxhIpe3vVWSzMFOQxpCWU1nUhh+cgmc/yP6AO0bRM
	Z3SXz2JJDUrfkaLBFeYtOd6DnVHdSYRKx9CnfMVBa8Yr67Jn4eXJySfWeJpmas/H7Xp0FGSbsWu
	YgESCsptjUzz8UbwoF1TyFQCz/Hp4z5oLMtgb6+EZcxgO3sKqzcwaC9/XptRIlM2lCyG5ruVw3R
	TxnyzLzS7Pamy5rM8YrXNaxL3z6JavCq5tP85AJ+6IoLzzpBdaZa5bE5Gb4W2Hfwtx9gO1l3VM6
	KSNwpnHrz5115gHrAIrtvJHbmweA+5XszzjIk6aewA==
X-Received: by 2002:a05:6402:2423:b0:670:62dd:e2f4 with SMTP id
 4fb4d7f45d1cf-6883562a61amr2031975a12.8.1779383446377; Thu, 21 May 2026
 10:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-5-amir73il@gmail.com>
 <a4kh65jinwm2tyk57xhmqemmirbxr756cj3rkjlatlnsef335h@nex47pw2wvt4>
In-Reply-To: <a4kh65jinwm2tyk57xhmqemmirbxr756cj3rkjlatlnsef335h@nex47pw2wvt4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 May 2026 19:10:34 +0200
X-Gm-Features: AVHnY4KuZt9KIovAGrG5z4kQLjYm8OGAF1PNSbJRUtTsgY-PWqV4ntDC1LAzRrA
Message-ID: <CAOQ4uxgj+3pzzaFpBFaJ6FuFPe2bEskixESKX5kqR6KdmRvABg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] fanotify: test event->type instead of event mask
 when possible
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 19:04:57, Amir Goldstein wrote:
> > The fanotify_event already has a type field, so tests like
> > fanotify_is_mnt_event() should check the type and not the mask.
> >
> > In fanotify_alloc_event() determine the mnt and fs_error event
> > types by data_type, which uniquely identifies those events.
> >
> > The helper for classifying an fs permission event is renamed to
> > fanotify_is_fs_perm_event() and takes the group argument to verify
> > that this is a filesystem group type.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ...
> > @@ -845,11 +845,10 @@ static struct fanotify_event *fanotify_alloc_even=
t(
> >       /* Whoever is interested in the event, pays for the allocation. *=
/
> >       old_memcg =3D set_active_memcg(group->memcg);
> >
> > -     if (fanotify_is_perm_event(mask)) {
> > +     if (fanotify_is_fs_perm_event(group, mask)) {
>
> Instead of creating this fanotify_is_fs_perm_event() helper func along wi=
th
> similar fanotify_is_perm_event(), I'd just opencode the mask checks in th=
e
> two places where we don't have the event yet. Things will be IMHO more
> obvious that way. BTW I don't think we need anything besides the mask
> check. fanotify_group_event_mask() check should have taken care of the
> rest...
>

Not sure about this.
They have to be gated with fsnotify_is_fs_watcher(), but anyway
a later patch introduces fanotify_test_fs_watcher_event() helper
and then it will be easy to drop fanotify_is_fs_perm_event() and
open code it as
fanotify_test_fs_watcher_event(group, mask,
                                              FANOTIFY_PERM_EVENTS);

Not sure if that end results addresses your concern.

> > @@ -265,6 +265,7 @@ struct fanotify_event {
> >       struct pid *pid;
> >  };
> >
> > +
>
> Stray empty line.
>

Thanks,
Amir.
