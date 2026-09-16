Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4E4BF92A
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600585; cv=pass; b=cI70fWC8DgVX+VPlkJ1RCbym1YJTJgAJxdhReLukD5ilstT7AmP/2u2rIhOMazm5Tl7D9CM/mXmlNx0lrimfTnwJjBHD4uB8mBMGBXsmuNG1xeZky+S94rmyMlHbicMsmqJdpiBFiyBk4Xx5X6yK8GF98/x69ssgAjgsVTxTLHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600585; c=relaxed/simple;
	bh=PGqCNKVZCKuQE7jwiEPuuSZ/IDgGiFbjWnBb1wGsCq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b55ocFl9ouFjlXfEJyyU4qNd1HRuI1eZ24umkqiKOXLjvJsngEvJXRcxW8EvsVfxXKvTef/TCl6FaaB8qZvG3m1F54g5gx0rTFK3zWMIquFTo6UvwMndAtTaHj/X5UmZVgy77+G35Vj+J6WCzImopP5dv7oIdg741AXciQIf44Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=UNsMKJo2; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="UNsMKJo2"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59fa3112cso2413711fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 16:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789600581; cv=none;
        d=google.com; s=arc-20260327;
        b=bRToW9NABUisR+Yj4ohvmnby1QmD4EjziCTGsAd+EVIzwp0yzgN7mIAQ9JYqLacGCw
         tInnyIUiC0/mx6hCl52W4Uv+52/eEPpxS6wLdsV8E7JupCWsruanlyr8Q/jTSiEo6NOl
         AO68vCjHtuMvlMA0shHTmMX9GStWlJpzTrlKOBGI6lWd+tCa3VsAwbJbesEHY24X6onk
         SYfIoSbJ2SPKhmZgXyHkD0hXDN0y3Qa0ZCYSZfUCSvz0tKeLtNj8B1fPQnaGXjIu9Mrc
         kFQ0nxwCeNNRb/WisR9TnHPQYTVOe3ohw5LK3Bu9lpm6ryxh890oPDBvzb/fKhAIbXAC
         IAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XuO1Ijt2sJ14x5nHlyhOYgW7+udniPE80quffc8DQvg=;
        fh=b6H1OgoLgKq7w2wDRWdV4++rKqAmwx7MnQcbq+mIoSs=;
        b=R85Q/xW7/tVYiOyDB4kI97ToEw8NFqS/Q3Ejk1rpkoRK60CEinIdBL3412GMpNM/rn
         ETAxZAEcf/Yu+9RPtV4skqZlatj8zxghI83tkcD/Xhm43bNdanYOswAQuiaIXNlXYzAX
         clRO2v9ukPev+Sc67TzJx+uqFXqWm9GeI0OLTCmUWXcQm6r1UwYBUDcJOmERdhtvFyWl
         oPMXkS+4YIzbHcWzbY0DYv9iQ4qwrtLiuY+AGOfibLlvYpXvDXklBxGhSs/jG1AoXmRc
         GCYOisrccH4Ly7iIiuU+guld2OuGVun+l7L6sTNMadkKKhyXaeAmUlI4ZqZQ5Qf4bkxW
         PAhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1789600581; x=1790205381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XuO1Ijt2sJ14x5nHlyhOYgW7+udniPE80quffc8DQvg=;
        b=UNsMKJo2T6wCVhfzR26gvQPxMH2MFDhqPuI/hzcovTS5zs6CWJ+2olJEkH57SFtFCf
         zWTufsKEyJSmXcNom+NICA6udCi/cb6EsKlWZe5IH8uEJkMIWsASwxE/u8dk1qB395Vp
         O6r3li8izs13s3JHUW5DyGOwh1qssoK5icXYBlWJ86W3FyuOvi79ZxLw2qbw75a5hHTs
         22bvvOfGSRs/aUIaMEuwfjYbO7vHKzOxF2dcy7k9baG8XFnC0ON6gi383zGpQ9WYaZxK
         BLW3thCFFj3D8q0pRX68Rr5xvKK7/Ws6dIzEQyJVqtSFpvZ/ZcmS2CgJY6PYlmtlWZD3
         ODsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789600581; x=1790205381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuO1Ijt2sJ14x5nHlyhOYgW7+udniPE80quffc8DQvg=;
        b=HPhd+LQ4ZnWlBoZcbE+ZFeNN5E20ivAOR64OBM+1hs1D8+YfNxogkNsTbWnsbR+D1Z
         /9jFyHuIAM3vo/AE0lu0MkyrhNFeRasg3a63lp0JfOr2GBCW6RwjjXJC+EL1OeZCKgYb
         VfoZAtPllAgeNDO/Sz3QozAiuEyYGoNREAK+50esgWjRyk+PlZ/nJZ+57839DwxvwGqL
         feE7n8Y0pCNy7Kb8h3XB8+GD4oYlhPxsoWAqCRv7cDcICjT2Q7ps2ml/6GpumbSN0obg
         fa540Yiauht0pQI88rwaGV7dwFL8tM6mB/f8ZZVf1zkkqiweE2r8L3TIw4+oSsKrpuif
         Kalw==
X-Forwarded-Encrypted: i=1; AKwUvByE8my+Vo44/0KbcKhW4apO9gKsyH1OnBbEH9j/9lMPai67laIsg96aueOcLlUcVn0VRGxdHehJKwDgJHql@vger.kernel.org
X-Gm-Message-State: AFuF++k3Ml3WaQofY9nM5mmi8E1JFBD+xy6RD5ls9KF2TPwQnK6pJg6c
	0UwLAI1ffeSloeVPvtOXBs2RKOiQyW2JYDqAoG0CkJWh1QxomIEPBMKxkJFMgnaRIjSwVXrOJ/H
	CIpF5nVPKqKclvwZf7O+nPAl5tsvmojqTjXTzLImt
X-Gm-Gg: AYBFou2/CHJwcwG5HnSnSkdFasRJimxkg4NSP0HqnyPx4HbCkp3pdJr51FtQsiY1OaP
	QD9lDX3ZSqDwfrAFgJ4LW42bCuIBtGaZsevwMg57n7sfYQQUx7429sv0ICGqrU4j9fOSKkvbV7a
	DOv7eP9zgMRp350YTK+LK5zR/pAcRhM9IwEDBKFqFX3HOXifu80FRKaZd/LQ2jBqABFR6+F8aWg
	YLKgfElx6UydN1ZMpwTZsqT9RE+qLAt/LF6BX48F6lB07fJq/47cMsgI4HvixmT6oOoupgglZRs
	sBkgDFLCBGFztIcYWqW00hfCchFZb77oJ/xbIBMqfSdGo/B/oDFJ
X-Received: by 2002:a05:6512:1192:b0:5b6:1a7c:59cb with SMTP id
 2adb3069b0e04-5b8b6643a3amr1205595e87.37.1789600581075; Wed, 16 Sep 2026
 16:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913193815.2862366-1-mikko.rantalainen@peda.net>
 <aqcmz5uI7PgN5CT7@casper.infradead.org> <20260913235145.GY25906@brightrain.aerifal.cx>
 <eeb50cae-87af-4a40-b9c6-f4fa9981425e@peda.net>
In-Reply-To: <eeb50cae-87af-4a40-b9c6-f4fa9981425e@peda.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 16 Sep 2026 16:16:09 -0700
X-Gm-Features: AcwNN1XX9temToosIZFGFf0_oya4M6aRcGTN4rFbjsWI4-f9wQoGiIGursSmD04
Message-ID: <CALCETrUgLj4Dz0s6PMofViJwausRWCvNvJphxWHUeWCCaRBtQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] close(): stop exposing non-retryable EINTR
To: Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc: Rich Felker <dalias@libc.org>, Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, alx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:44=E2=80=AFAM Mikko Rantalainen
<mikko.rantalainen@peda.net> wrote:

> NFS and devices make the question more interesting, though. Some
> implementations put meaningful state transitions into their close path.
> Tape devices are an obvious historical example: depending on the
> device/mode, close may write filemarks, flush tape buffers, rewind, etc.
> Those operations are not necessarily replaceable by fsync() before
> close().

I realize this would be complex and maybe a can of worms, but maybe we
should have a new improved syscall here.  close() is indeed deeply
problematic.

On the one hand, we have the actual task of closing an fd in the sense
of removing it from the table.  This should really be doable without
blocking or without side effects (except possibly for zapping
old-style POSIX locks -- it doesn't really make sense to be able to
close all fds to a file while still keeping it locked, especially
since we report the pid of the lock-holding process).

On the other hand, close has actual *meaningful* effects, many of
which you've mentioned in your email.  IMO it would be really nice to
be able to explicitly *do* those effects separately from closing the
fd, maybe even asynchronously via io_uring.

Would it be so bad to have a new operation to do (possibly with
moderately fine control) the close work and another one to just
release fd- and process-associated locks and drop the fd?

(Hmm, for OFD locks, it really does make sense to unlock when the OFD
goes away.  For old-style locks, maybe we want a way to release an fd
without dropping the lock if it's not the last reference to the
underlying file in the process.  But maybe specifying and implementing
that would be a nightmare.)

--Andy
