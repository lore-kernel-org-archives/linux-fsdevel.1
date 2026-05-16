Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF4388393
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778975493; cv=pass; b=YYZWc7iiek62BmaCNDgnfq4DkHHR5wcquUAIvxrzrx1Wwwnq2K2OS4MeKeNBUWOk6iXbg4HFRlOEMCU4otkbz3g/u6FaH7PgYWpIhjfkhNZFve28v1rtrrctxJbPUL9y9VhsEwXg3e3+ItqwGGRaIAqFRAtijmbGGVCrKvGsCsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778975493; c=relaxed/simple;
	bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8a1Rg/HSewgGtMMUcyen25iEfOdGUALB4wTBxkmmQSYqkewZY9aPX6AqOzoGZyXdTWKJgdKX/b/WAKep/ZOVPWRj1fctH39tJy6vZpiCB3WmWT1fDADpvprMN2DYSQyuK5fbH14+plBgMupy2Pv/3hNcIw7CWoOIodqtfcbTH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehaejxoU; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehaejxoU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso2650842a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 16:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778975490; cv=none;
        d=google.com; s=arc-20240605;
        b=UCSsiqPOIwCwgEon8L6AzapMC+6Ruxj6gd/DAelLObzij+L4LQgKUbER759tepBhXV
         ueD5GVEmO1tVlPMW8odAjn+jVsGzNdqXqShRG4Ehdg+UHsdJ23jKkIT7AXz2Or0qD6Vb
         iP3fOmNURyTqS4cwTI7+Ad4lRKjOBx6cv6SwlR/37WLj4xxSwWI8+zj3Hta4ImBIKNTg
         TH9+JnynI13rE5xUf7zI+UgqKkSDk0ZRVnNezgEZvdqgTUZp+tujkZ8wiz62V4EGRzB9
         iJC18dZLrnZHM7Ue5InaTVVF/vymzTpJE/C2z4a3UYUkgax2qwEfnGwLggbLTsONRwrS
         jcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        fh=Tv2bImrLM97rNRQzj9VeAm2Ry6Hbx+STy8fCTyrJNc4=;
        b=ilqnB2MeevHuYR5GdPnDyt7bJwl+fyB3mIYa5TRM/xNdaQy5Cw6p6dn6PeKpTpaUXZ
         ppmiW/H/rjXe/LoY1clLxeCTlxLSZB+xbhUQT6tou4QjuYAhDvJ8DlnlLFPvhyRK4yRK
         o9+wee46/aW2PvkoEi/sjFskARvRqLB2SF3c2cmkJGPCculyG+cBdVjgw8w8uzRxxhiK
         oMEh39Jlkq6qMdZle91U/hTy7XPJfEiVnX2ioBj3U0YZWWlhnccMbKxgLt717kMsWpWO
         sJ8pvaekMYaoV+ZCrb+OyXDLU66JoAI524ZnOz4YuQxgcI1oUca8GkH9/WACWlQiTgEH
         Wspw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778975490; x=1779580290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        b=ehaejxoUwoQpqkf8aiu3PrPncrm3qXhiFGHq5PhObggOH7ycQsIOkmbfYRACfQ47Is
         hV8IJ9iXBy7FE3LqaHrqx6dkZMOm+2kYAjPB0h5ea4RNgCrqim8d9IGnzQC/U/w6kWkd
         hsDho73Skviqukg3/xqweB6E+Wz/ejsZ0Ai8ocMnb0HUBhNjgP6QN1QHfulNqeQhYTff
         ttxI5jPi0kBPaGuDdSw8yK4ETaN0DS10+OnzBCVXFQMEvd3uNp4371U+gPvVU/cPUmEE
         eWNuOPeUdTL41PoqosvRm8jhZJkqlj7fszXkSliavZZ/AFrEjDzC33XLxZ8qfCe0YvC3
         /8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778975490; x=1779580290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        b=jdHczbXwf8r4duT5HrHRtFF6Ql5iHzE0Wq0KCdeUwPuDWn8RWLOPr0WW02nKQmor7g
         QvSjtqUj04JLO8WX8W0/QstFkSpFLJbkNfVgyPG169mEh4nBuMsCdlULx/Pj6QVeT7ch
         nAesShLaDmulPwU+fjUpx6A9e7yQyyAHtSzcXJqNZlDPA5ZoN2Reeg7IAWZY4HsPwCOy
         2b+bZ7h9wlpJgHBk2mq/7ncNl7l6UXwevHlVz8IVvE/e7r9mE+aPlpoLbc88Bir+luvV
         BKuC+QIsNd+33KPQgryVJqMIIlma9aJTFFGrdu2WtOmFM47VFAhDBC+ETP8PbkIXvxOT
         Jokg==
X-Forwarded-Encrypted: i=1; AFNElJ9L/UlxVs5fwX2BTb7++0I6RVImG8TxhlsNjU24lFXnHQtiYTC2jGLOWTLFtc0wNrGseRWsiqlBNaewdVQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzASaT0HHpBqW7qX1VNEqi/yDwBjoqxZpIdF3WvXj2hwqTCBvG7
	bJth1QkGaczOggZouvssLDbfXMKNlJQzLS1VBE1n2bbR2cUl2xXf3a90YII03iO3Ds/ENvCI/h/
	1/AHi1Ptm92c07h3CVdtp86VoFp7Quxo=
X-Gm-Gg: Acq92OHP4pL6HcNcKVv14J77GOSzkvxAvSCePFqrd3rbmfIhAw3H00beOUHJEd5BFrE
	J061pxFOsSWgVZonWGMvf6ZnvhZJyDkUNwyRx0IYi1f4R+DoOcDzHbk57q+wVJPuX8QOxShF8L+
	sdfPWzCtsNUfwm7uL3aNbs93Dh+SpGbkvOCd4W7VZL8u6eG0zqt5QbuZyEE088CJHtYnqeGarkS
	jydkx7R4sKZVEpO6qQA2GhLzUAG4ELR0PFFXkUDHuHdA/YyJvzIi7mF0FA5CJSAOa8LFWUOIMEg
	HOLHi8swPFVT3YAidXi2G+Qrm113m8M0H9HZ3LBBuZBqrwExrQ==
X-Received: by 2002:a05:6402:11d1:b0:676:67ec:a2cf with SMTP id
 4fb4d7f45d1cf-683bd08fad0mr4189598a12.20.1778975489646; Sat, 16 May 2026
 16:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de>
In-Reply-To: <20260516182126.530498-1-pfalcato@suse.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 17 May 2026 01:51:16 +0200
X-Gm-Features: AVHnY4LQyyzXjVtPQhJb8qVVp3yQjS1Vt78uw12X8MN5Nrm3AJq0RnjAefRlP1U
Message-ID: <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 8:21=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> and Fragnasia, splicing a read-only file is fundamentally unsafe.
>
> As such, as a mitigation, add a way for users to block splice() for
> files they cannot write to. This eliminates this whole class of exploits
> that use splice()+confusion in pipe/net/etc code to gain write-access to
> files they can only read.
>

The patch touches stuff I'm not familiar with, so no comments on that front=
.

The core idea is a half-measure which will at best buy few weeks until
splice bugs dry out and there will be a new attack vector du jour
which people point their LLMs at. Perhaps it is worth it as a bandaid
until a more complete solution shows up.

A full-measure solution would git rm these modules to
fuck^W^W^W^W^W^Wprevent suspicious modules from being usable by
unprivileged users to begin with, at least by default. Of the cases I
had seen so far, your typical machine either does not have the thing
loaded or in the worst case does not have a legitimate reason to
expose them. Someone(tm) would have to figure out a sensible setup
where stuff stops autoloading and there is a whitelist of modules
allowed on the box, and even then the functionality provided is only
usable by select people.

Back in the day I wrote a LSM which learned what kind of socket
options etc. are being used in a given workload and afterwards only
allowed that. The code never escaped $workplace, but the idea might be
a starting point.

All that aside, is someone with access to many tokens(tm) racing the
bad guys vs splice bugs? Realistically one has to assume there are
some more waiting (as suggested by the patch) and chances are decent
nobody has to be caught with their pants down even without the
aforementioned mitigation.
