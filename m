Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC13D16F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440229; cv=pass; b=JtRLQPUx81vJKEYkzX+0I4JPGZKFYv3XR9CSxRREE1B6wXIaOtRAhGy4DggJtwDBkF5wK1i/VW6ZANX/HWWtqSSe+ar0UlxQdPoAF/caHGF6HbYWw7GFUfqQ2UBXKxAZi9xYo476DafsReGXJd9hJ80t9z2GpDRoi5vmVt45Gfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440229; c=relaxed/simple;
	bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5TgjClvi/pvELrZKkfvwc20lk0GtgD4LSRth2bKV/vdSoCjRiOyL3TI8WjZ+xtXzCi0S1xZa5HJcBs2tkfIpV+2J5kAs8JMzcqeFUbNMIbmlWmtozKroXUuPd3qhl6S0S1P4JxNI17b4rUOCMDOjBeQ2DJ2tCNG2HMNBvDuuXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQYTgU3o; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQYTgU3o"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso8565320a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 05:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774440226; cv=none;
        d=google.com; s=arc-20240605;
        b=g8cdUtjTGNBwgriVWq7laEMsx0s7u4Z/+PdcPcPhJB1ScGaYfZcQrnIb5TDtmomycF
         2GR4Y6MA52d/aalpV0lvM9zPHSYkpIIsIiG3OYJL52/B2ZweJFfHnJWc/xGkmCT7YbDB
         4sdLxFIaiA0IR9/0zCxb/4xkY14oKGc6uqIFM5gmGCLIWNSAvy98U3r4b+8KTRRNnlkf
         hd0ddCssm3T3ITYnV/KIurIMGol7qGrByPfsNqNh0eJFalgo80YKmQqtZdfYaMmC55L8
         pL74siBGOI/azqdGrnFLF78ZV46B/4fJlE11hqJGxc9ikbEkleKolSVvLKvve+i7cFP5
         a3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        fh=g+wl9cZxN061fWhH6OA11DAIewXUyP24vWsmi+/msF0=;
        b=H5iXqX6Bi5/gzC4zt3hlqBNpC48XzboEKcLkXU92Dif+rwywhJli8SiNvr0DWdq29Q
         SAaI3hcfU9tBtqO/4XwlLAx/r/kjxA108WYjZMjmQtM+j0B/JwiCNF9CNuT6NlmhnYwH
         esdGDIryvokxVBIH0iTzEqM+LnY+5EWdEBP88jpQP0LqEmaXvYRX1XrqpJQte7v+h2ZZ
         uEuRLQ0ZXdKqafnIavmyFFDwVNjJphpcVhT4H9buJJaRX3OJJAA7EmD43OC/yPUj1hcQ
         uwoFkQ+kHvvqIDXaWsn34f7UvbQCPTNKd/9IJ0/Zh1PLErxciS0x1EMjfQDLvLzOf86z
         +g5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440226; x=1775045026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        b=QQYTgU3oqQkkuA3YhoETSzobfKrhfbQutworh0GWHJzNSUEQp4IIw8hk1RnWf/sWY/
         jFpSW502ikRTJW0UXmYbQtp3hH08zM+qsk0pLGfDPnxUY+c8Xo+6DsssuGnJZXlN6nQL
         XEeg+fXMsug+TQx6DcAbHqL9VNYMpfW+7qT4oj+Er60ErVHnJ0wb5hvsMwv24cewZGP7
         oPLLJTAZ3JscWgATaEzi/hBTuZdYTdFH9cOYqT8D/f1DvQZiGKNzTxs3Mh7QTNPsRbQk
         KxDQPF9J88sleBn0kW34Z6DYf4LH3pZMtrgAkZW5N7FWsJh9afPjZhnT0oWLonhph9th
         IESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440226; x=1775045026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        b=V+vJzGaAWV821g0N+LnjHE7oxtj65XCs6wkBE+PjcDpQEH1Uahm+VrbV993gbadNLT
         5fQ/GDLcBZOWt+tRqvq3lrQppoDzWEENrR31SS2Giu0gTr5CBws8XuVxjLZUER1gTnLI
         Ng14tjgZ0CQQtbyOJqYlQl5ygkbVsZClBoX5yAEpvHjuT60gkNnL5jvNgBS7v0/uijV5
         IDYSFlUCe2jLSjYCat8eQThU46/Z3NmKOrGPovMFPodbczwc0RKI9xLqvTrOBjDsuR5i
         P+vRu+syZhWYggH60v9XMzV7QBjaQ2bBu2WIyJHZwdsWd7w/1aquJ6cNzNt9vapl79or
         ZULA==
X-Forwarded-Encrypted: i=1; AJvYcCUn29MykrVPNGf4SOLCgJwgOvJgB5J/r+D78yVE/QfEViIfX9jvxM23fS/ctwZrYbJITtUux9HylAVaRtpO@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSxO2sda2Y4L2IxDa24mrTCHh2IWhmaRX98jRa3WEy7N7KrRQ
	YehrxC4DvZjPVO8v0SaEEbIp6XRkqHKJD2Gf+6dXbAegBZFdLCHiFOXXUSHLlgsy7C5IUe5vaBW
	WfKhhlP2fDm5csuWw3GKGn1oNdMEvY2k=
X-Gm-Gg: ATEYQzybCBlIElP+ZnQwso+FjBRd7a6pMCQnEnR+Q6ZlWYWXPiAeKE9cuMq2DqHd/gR
	tocd2tKXEYW+btrThg4njDvfwuKV6+Fwd+UfMgXI0d5Q0J6R3wjlliLNjtlshx4WrLiZD4LlpUK
	I6D8O2Vm4SIS8mXO7bAAooAVqqbPwKH4dD7VxYYiJ/GN1xMXqYxVF1Rz+xYRNnpASuekQorEPNs
	pubGqj1M+5GotgqACCYhg1xs2Zx4DKtvjl57oHsy208CSuxEoch/hT3LnLcWn/K+a7y5FZ0CAWN
	GECCZv2GCGuDWm7DSI2cRuFe9pTOqCg0NhiRWXTanQ==
X-Received: by 2002:a17:907:980e:b0:b8e:796a:fd5c with SMTP id
 a640c23a62f3a-b9a5425bcafmr230697766b.27.1774440226200; Wed, 25 Mar 2026
 05:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
In-Reply-To: <acN457svKhT5TcKI@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Mar 2026 13:03:34 +0100
X-Gm-Features: AQROBzAGy3XNT_kv4MdESc7yjI0imOrkuxyj3QWBiKFezafRk0eZnnUgjwE_k90
Message-ID: <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 6:55=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 03:57:50PM +0100, Amir Goldstein wrote:
> > From: Fei Lv <feilv@asrmicro.com>
> >
> > Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done to
> > fix durability of overlayfs copy up on an upper filesystem which does
> > not enforce ordering on storing of metadata changes (e.g. ubifs).
>
> I'm trying to understand this previous commit more than this one,
> but what 'enforce ordering on storing of metadata changes' does
> overlayfs encode right now?

On copy up or a directory:
1. create a directory in tmpdir
2. copy attributes and xattr from lower directory to this staged
directory copy up
3. move it into place in overlayfs upperdir

Until commit 7d6899fb69d25, there was no fsync before step 2 to 3.
Only when copying a regular file there was fsync after data copy up.

This of course provides no guarantee over the state of the copied up dir
after crash, whether the directory is observed in upperdir with or without
the attributes, but in reality this is how it is since 2014 and for many lo=
cal
filesystems (e.g. xfs), there is little risk in this practice.

It should be noted that overlayfs is quite picky about which filesystems
are allowed as upper filesystems and specifically network filesystems
are not allowed.

> There is no real ordering requirements
> anywhere in the Linux file system API, so it does sounds like ovl
> is making some assumptions by default?

Correct. I would say "making assumptions" I would just say that
overlayfs has never taken this aspect into account.

> Are those documented somewhere?

I guess not, but now that this commit introduces, fsync=3Dordered,strict
and a documentation section about them, it is a good opportunity
to expand on this point. I will add that.

Thanks for pointing this out.

Amir.
