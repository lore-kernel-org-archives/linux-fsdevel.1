Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFE3002CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939762; cv=pass; b=CxnCRPnhgRH4yOH4L3kkAWwy5HgugdkSBPguaBLb2iK2SFrIbK+S7rqWYCo7FE+bRuyBhXod/rJQhhBJm0xgOA80kTtTuugvuOowfVl7HkyIAehVzsQAzXO1Af9KUfEk+OGglBvfF9pgRstktLsSS7T9j/hSjb3abSXbL0i9o+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939762; c=relaxed/simple;
	bh=+R2Iee7WfzAZH73lmLu87FjjElzRcXq4EwlT3ulxP+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dectvfi37AankRuzzF801TvDd+NI3SlSaPci7BuRj45oboo2TIQEjyevYkL8Z1N2fjbkBYYnOQ1LbQmUF8y+nOWypdCsJyHzuKSdEXcVmRquJoa/GqXnHtf8jPcexKrcO/85yBo1IJknBSGt+0dSawL8cL3P5t2EYqm+4TavSKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqX0oiHE; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqX0oiHE"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5f1d0af69so2036003a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939759; cv=none;
        d=google.com; s=arc-20260327;
        b=QF2QmQBaZXmTe0ij1OayafgjnSimIOSsKHYAoCMEV9wcodwDa3BxUdNgu+UX6hILUc
         zZ0pPsrygZ+AYzpeaakgkbz583u2bJMJRc2YaQ/+WEsxzaKe8RnK8Ry4T+DK855OTMCu
         vF8eHV3kgrtu+kLDlyV+4aucXCSSqNxR8C46i1jIBgP+sFRy0cRjSci0LaaqXVplxrFb
         V9nfrCCajAs4os6b4gJkuV3jnj6+SAmdAuUiUVXbx/di0VZ88rvFoPUuZSyGOHqYgk4a
         idW3wizCVTv01XGxB9A6fYznSHyHKu2+CzDUMtN0NjfbdfV96ksMY4jg83YuaBFX39q8
         tKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+R2Iee7WfzAZH73lmLu87FjjElzRcXq4EwlT3ulxP+4=;
        fh=6O4gX31Em5Q/bdGSD9s0Sbfh9rdSOiPCN0k7tH/mVKE=;
        b=K7EATHXIJNDMaR7H94WlTH6wg36Fgqz/MrQhzaE60q/tviy78sp4YZ0V92qbycrjZP
         pSCX1u3VnFPeonul+bEwIglwq2pvcn809lgiDflByiUJethuxBNjPZJMGzS7TLF3ZnUJ
         4fVDAJ6/N+BmjwrYWlvwTrCNhf8vzRY68xtsn5ptogUUfvzXSp8x4gFb9Q4mFzxr8R+C
         jb/FpeoMQItm0uu586jDFhpz/xvKaqi8wn/jRFIgKZgDCDUIjLVJgaeRLLjIHSwxS69m
         45CGJSfW7CdrFevFlKT3ViFFlrY0eeKNn/imN7Avv3iHvqbmBP0bzGrMJnhIHFIjCvgE
         cIyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787939759; x=1788544559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+R2Iee7WfzAZH73lmLu87FjjElzRcXq4EwlT3ulxP+4=;
        b=NqX0oiHEkOddZmDMoGs8gTJDkjMZhq9bDJP0Q/J1ML06JKbvscyIEvBsVUe8FdVDzz
         2HogW+z4EREGLekWswsweKC7Bbjl4QJ4cG+bGZXBmdwRan3TodHXyTqv4aiNc2tgn+tt
         AXp8wZ+JAZBp6qMBIPZDZxlj2yR3AkAot4pAofyx+M6rKF0FEWOLEe7936HeeD15FKAx
         q9eM74czu6Ll/c/t0Rto65AgCNCT5mYyDMkz3iudj0jurQw84N27dNS90t9imYDS1dLO
         57bzUdvqt9z2Tl2PeWPhCTkt5Re9D20YewUvmLOX6G6uaS8E2ak3I4N0R99TpIOUHkI9
         juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939759; x=1788544559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+R2Iee7WfzAZH73lmLu87FjjElzRcXq4EwlT3ulxP+4=;
        b=MtTTHUCgV2T42zeHyIzK7EoeutV+OQap+iAITzO5OrELLEGkLBsi0nSDiZ7nSKeTIt
         50yTcX+CHXFKvQ9iwsrEptU5mMUZKxsL7hAVR0gftXJCawp3cpWb+BpiqJgOeKWdbXH+
         G/E+Zkm+2hh0ZaBgGxqyLlx/0WjoQMSFQ1cq0utN/ugDsUJbvxWxPV7E7jHi4Ha90JnF
         8jWG5YjdoP5feKoNXtnD+uW0/fyCNIpegdmJD4fNpGhVl+6CcvKI3urTzEvOKnBA8JJQ
         Dj1m5ZJO0zZnHejiVgE5LxXU9tqT1PVwkE5Ut6r7cv4WHP7M4U6E65s/6tAGOanl5oZq
         DnyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq9DlrjA8njNRHqz1v2CjE7Lt16Uz4e8TJ22+HgfDqLym/70xNT5IAH7KjQdRUHp4Fr5cFkcz0hmiETi8s@vger.kernel.org
X-Gm-Message-State: AFuF++kDzA2Kt1PyE2Kr3ouxaOpdoBcz3igGxynyiv74+tzVoTCkEWtD
	u8oj1ni68+7IdAH5xooEKbA5vpoJ1+/eRQE7b03jLM4BHJI+j64fEUyNwSxLhzx7UltQcyXEc38
	Po45nBMZbIhqLdYe8WOi0vDt8hvRHUJw=
X-Gm-Gg: AR+sD10eyIYGe/4b01Or8Rp7lILJrh5esCl0HabMfaaJgiECRWey9DSqGfqTmw3BcBV
	YNDfsj/sPNmZFlkuL1oA+YBM9HRWANEBUfSIE5+l/RbWajH9kBzKFy5MepvbdSNAa6za0E0X8UR
	uWN8hIXVC5xq3imJN+dDy6UZkCttW3523my+C4eKFubh9Nxo4VAAhHjvc+kkwGA64Trqsh310ii
	+VcsAdOjiB6HM9L2jHK1kOLWDuTdwRWkw+9If8H+LhPTEvkNillvpoBBMoLISo0Igu6tpxOfVuo
	b4x43pufZKdohWHlxo/E/6vmuGHL+n6DIsIkdmd9UBKwVYsaIdsasjOYRJQXMu0Qy0cSozrICo5
	a
X-Received: by 2002:a05:6402:e84:b0:6a3:f63a:4997 with SMTP id
 4fb4d7f45d1cf-6a60d2efafdmr5894148a12.3.1787939758555; Fri, 28 Aug 2026
 10:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
 <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com> <20260826-gastdirigent-nostalgie-matschen-af4915e3d9c9@brauner>
In-Reply-To: <20260826-gastdirigent-nostalgie-matschen-af4915e3d9c9@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 28 Aug 2026 19:55:45 +0200
X-Gm-Features: AcwNN1Ug64jD753ap8K6ZnSKkQx9z27npgyt6ruOcyTaS-rrfufv5xCaoRY6iCc
Message-ID: <CAGudoHGRvxd-EwwDasqoVhk5VbEvhtjjM7kCXBfFyQ8ykeC9CQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:15=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Aug 25, 2026 at 10:54:44PM +0200, Mateusz Guzik wrote:
> > On Mon, Aug 24, 2026 at 5:28=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > We've had quite a few proposal for exiting files before generating th=
e
> > > coredump (see [1]-[8]). The various proposed solution were quite
> > > unacceptable. So I took some time to look what a _remotely_ acceptabl=
e
> > > version of this could look like. Here it is.
> > >
> > > The first patch is somewhat unrelated but without it the code would h=
ave
> > > to become so ugly to the point of being unacceptable so it's a stylis=
tic
> > > prerequisite imho.
> > >
> > > In the first patch we make exit_files() synchronous and stop shunting
> > > all files onto task work only to run task work right after. For tasks
> > > exiting with a very large file descriptor table this means getting ri=
d
> > > of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
> > > this was mentioned in various threads over the years. I found at leas=
t
> > > recent comments by Oleg and Neil.
> > >
> > > So let close_files() close right away. No locks are held, the path
> > > already sleeps, close() does the same thing already. Kernel threads c=
an
> > > just keep deferring. ->flush() and ->release() now run before exit_fs=
()
> > > and disassociate_ctty() which should be fine.
> >
> > I think close on exec handling could use the same treatment.
>
> do_close_on_exec() runs under cred_guard_mutex and would introduce new
> lock ordering. So dropping should move out from under that mutex which
> introduces additional complexity.

This bit should be easy to address from conceptual standpoint, I don't
know about resulting churn. Even if fd table processing can't move,
the linkage in struct file can be used for a local non-atomic list and
which would be drained after the lock is dropped. This would bring
almost all of the benefit.
