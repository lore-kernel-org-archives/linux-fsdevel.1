Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EC25B085
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779634109; cv=pass; b=rEGQNX6n7CHPAFrEsHslLX1vjB+bFNJ3IsmowzcXmdcJP3JANM4KA7nPaCBOEnWBbKt8pYIr2DYc7+Gv1kLXjxzhlgdGwxFs04eepQ9tJ2ONLbcveStjD0wIGcFMDtIyQ1sfNz/fckeZyMvIWP1cN+eqXeeJFaeApMhS+oY/pQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779634109; c=relaxed/simple;
	bh=x9qJm+avegIUJI6SAL7wt0w/pqHUEP/qvv8/0tXHV6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzgxU1nqttHrqLxWRcSpPs2d/HTHRXL2L/gXjcsG/4hEDB+uol3+uIUfHCdd3e+qxO6VADIzEx+cXvUPy+Qu5/fr1g5xsEYfBTJpKUNfe+fy9/y4hBkpS5ZXHFfelIxLIzpUZiXWhjk0ektSCMCiUBQCVDfVZFg1FxOsgYx0UIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONRMy6ec; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONRMy6ec"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so5550486a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 07:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779634107; cv=none;
        d=google.com; s=arc-20240605;
        b=JaQjTl0VdWgLq+IXPsmv4qtO3dP1IJGFmAPFzNCTNIpO5dA1nb3LJMrGkCNDO7Oibz
         xFhnknqoB1YdDojE4boWbnQy9KWQuj/LOsmzPSBGICxGCVZyBFaxA+yEU1ZYULVagAnp
         3E9hew1tXamJfdxko4gpu+dzTpgTUzj7He8q6IOGakWS8vnN1owvMkH4Xx/O7amewIvz
         Trq8D41rA/Sl0bEi81ciAnL5LsKZM/4FUIr7WbLJEgMxdntwyYTOrUxiIG31cIpXHQWH
         p12e/RSo4fD+55AEb630QYuojg/bnOMh/yYIvxemzVg8olL5J+6kyOThcZRIE4bwTNe9
         cEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiaxFrOd0FXB1269UrWJLsrAPCN4GiKOHlkHSLubSMc=;
        fh=tF42FDTuTn8TNRYGDhpEyfDuPVn/+oOxZmOPbXGxZkQ=;
        b=WTEPH+oI5atYHylyzFUfI/j6IYYWlqVXw5l/dRFQrbj8YtjCMkAPMsAY1I99iOOD/F
         arE81FI9/OE+Fh3EB97IKo8GBfNAEMrvzXVx4CvmQacUJEYd8QwHRcVXSSpRPN0AQzAf
         M6Y5U2Kg8l4hxF+42l2lqNhWlTTTFGDC2OmcwKbVVEs6xyuzJjMMi8C5w6wf5dcnJsT+
         5Mucl4iSd7IeMfwpsRrta+bzKWYJ4x+LRcbfNvbq/7N/oOjVx2MfpCeINpcRED81G0uJ
         +zHYyhNueVeHp4THGesRE7PoqpqesDgweeBQ12KV4r7mv9aJAdTrEJOegE+Ovq1N1Dol
         k40A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779634107; x=1780238907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiaxFrOd0FXB1269UrWJLsrAPCN4GiKOHlkHSLubSMc=;
        b=ONRMy6ecWHXZXRJsgjq8ahYjHBJ760pbARgrY7xuuJUud68kptUiflPU/DlFWAzNZA
         hwJEYBGxfUE2g4tR1qCVSMOl9iXayive5Ilm+Na4ukqzG8un45dghVucHtXNOVZIYogu
         1totdA3ZseEmIvw0ZKX/Ko78pYazUc+EKG5Eij02QHGijMbLxcM/g2lN52hMKrC/3Vf1
         j/JrZ/IRcR8T73V+5TlKn4BsuyVtFN2+fp2fWzN/HktRUcyejCM24w4Lv0H1VV3p5uga
         gGWxztuHGR8v319y7I7WXlE7aRbju9QJjE8PDyiZdBhF0n2ErewtmoA/WRQ+/H/Rgriz
         QaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779634107; x=1780238907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiaxFrOd0FXB1269UrWJLsrAPCN4GiKOHlkHSLubSMc=;
        b=S4YGtM3ZwXZjbV36D6pWdOdbZCVRhO2a/6B738wza9Y4WZAd3x/qoYPEF6G31BABH4
         QrrMRYpKp/mV5O03sowU0s0aTCUeoCuwPKtYOSHZaty/o9nGITkddvEnSGM4N/utm07y
         ccsqhBUFM2hx1KiyKFo0ZV4CiPsZYcF326Wk0rgUzEHaubGQiOGbqdcSHFEFgnpgMggg
         eoNA0cFl2yOC/2di3w+w8GFvoeepAvGn5q1mmk3UBZXpdJMpq4uBew0e/iMQfCngqC9X
         f8TTu35xUmoYa+lwlJDVC3a9irMmMP207x6d7ye7+S27D4ZEthrUYRVjzjmT34yOuN3Q
         tdAw==
X-Forwarded-Encrypted: i=1; AFNElJ9vzC2dx0L7fI//EaxDs4++uiaQnBNkmV56QohTvl3x/mkK60PwMLBkBS5iMOWoPnxZlfMEo+nY68E74IZT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hv+uK2MvuVL1cV3o1E8DeXQr5ks+Wg92ddh7J7MCtPzb0g4f
	3bHGa79DZqhS9TkaSGfCnuZSfJalj1PedQrkI6PFmcfw1qiIhU/m9WLT4be/XN4OSCbn90LTLmN
	6ltOaPgTuwKIPLbdSEcIk7N1pUYFCMiewew==
X-Gm-Gg: Acq92OER/QXTVqWqIVQQvG2tcP5F2V0Gp8itjg21o9QLS8fqEwmWamvSlT09sJusZGn
	yKDCdG3ES2eJKCbYE7HzbZEKHLqqlpxevaAJAqu70QoMK15lAMvPwfh8iq0X/zrZCfa4BaeZO0U
	8pu5IPwSEl2vzCcYUiE9FQ6AXRPHd50JzI87/1wgb3z1oONYHiSHjaZrAHUR9+ILPPtPOznllfW
	xJl6KtSqj6otua4GDpjIcEiXkPVrzV1fvsgjeEe/D60kaPr9m+RRyyG6kAXHsknD4NIg/ZV03a+
	/I1SZcWEflF+OSmd0gbAMln4YRRi6hgl9w3CERM=
X-Received: by 2002:a17:906:31cb:b0:bdf:b95e:98df with SMTP id
 a640c23a62f3a-bdfb95ea97dmr133789466b.7.1779634106434; Sun, 24 May 2026
 07:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org> <ahHVM9hCP65hH82S@redhat.com>
 <ahMK_mWcooqrd9Hc@gmail.com>
In-Reply-To: <ahMK_mWcooqrd9Hc@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 24 May 2026 16:48:14 +0200
X-Gm-Features: AVHnY4Kjj4ieWodc5RzfU3uO7T_bRVuRnlBRZFMlo083AArFEgI-h98qjZJFV5s
Message-ID: <CAGudoHEPj-aOxqBsh5y4JFfONLnZfzgw_UUs5hqK6BpBcgHO5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
To: Breno Leitao <leitao@debian.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
	axboe@kernel.dk, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 4:30=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Sat, May 23, 2026 at 06:26:27PM +0200, Oleg Nesterov wrote:
> > > @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_it=
er *from)
> > >              * after waiting we need to re-check whether the pipe
> > >              * become empty while we dropped the lock.
> > >              */
> > > +           anon_pipe_refill_tmp_pages(pipe, &prealloc);
> > >             mutex_unlock(&pipe->mutex);
> > > +           anon_pipe_free_pages(&prealloc);
> >
> > Do we really want to call anon_pipe_free_pages() at this point?
> >
> > The main loop will continue when pipe_writable() becomes true again...
>
> I went back and forth on this. The argument for freeing was that
> wait_event_interruptible_exclusive() can sleep arbitrarily long (slow or
> stopped reader), and holding up the prealloc pages felt antisocial --
> especially under the memory pressure this series targets, where those pag=
es are
> more useful on the freelists than parked on a sleeping task.
>
> On the other side, on wakeup the loop is guaranteed to want pages again, =
and
> re-entering the allocator under the mutex puts us back in the contended s=
tate
> the patch removes. For any write() large enough to wait mid-syscall (whic=
h is
> the workload patch 2/2 measures), keeping them strictly wins on throughpu=
t /
> p99.
>

You can still prealloc after wakeup for whatever reminder you got
though, but I can agree dropping these frees is a sensible way out and
it is easier and I'm not going to insist on one way or the other.

However, I think it would be prudent to add a tracepoint to some
machines on your fleet to find out how often they allocate pages under
the mutex (and for what i/o size). Initial alloc for the first write <
PAGE_SIZE definitely happens under the mutex which is probably not a
problem, but for anything later? The tracepoint can have a trivial
indicator if this is the first write if that matters. One can
speculate all day, nothing beats checking what happens.
