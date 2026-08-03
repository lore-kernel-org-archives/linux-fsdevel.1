Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D641D223
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764701; cv=pass; b=lxq68aVRbMYfHXP00n4tYmJglgro2MEBdFdGRuzSA+H7Xx13M4UzJtqCon418ZepH39lTtkADBGYMus9k+fFgN9fJjpIkhQ9dWfSb6RuRI9ArKr+8hkBES1ivjpTgmSZW2NHYPxFy6ohoXzeNV2Evo36CekZ11IWQO0QCtBcFvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764701; c=relaxed/simple;
	bh=/hpeuRssaa6XcAvdK1eK6+2E+wNiDC4goF4wBMKm+6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxPKV/3UliuK9QnvTU/P5xkr1imfFVjyhk+G1SwD2/lEsAFzocTL9gzuYfON5T/YrQ0qf1ZlM60AYHecT+yYmFXU5bF+z4kUpKJNN6/jQLwy8Z8aGdZAFfD00nYzWy6AVHZsMhVSGJiVEpzChCpFpJhmMYxTdSDfQoQ59i6HJ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTUg4rKl; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTUg4rKl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso133565ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 06:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764699; cv=none;
        d=google.com; s=arc-20260327;
        b=pwZvCao5bhreySr2i2z2KVdEeOcP56FKZ1woSEmfTHWEwkbqYRRGaevplb07/+g5dZ
         rOnO8un5my/LK91IUNiQgDs7KGQhtHxp9lobuMbaMukTDSem7dvwafjJuc4ytdFlgnEW
         kEN3n+A/FdX6CWdxYlxm9xdEhyjVHDm1RbPvqbX2z0Ws+x7Mr1gDHz8P5pIkf1k2079a
         mB/hRPKUJNoc7Y+cch8FquvBtemSOOnZHUwH6CTcV1NcZB1tPLuEJR9x1dSESJMyEdgE
         uyylUeuk7wMmSlZKs9MnjXAHCpVQFCa3iEVNNYSz63j8MqSv9vFeaVZA07MuoH7pbdEJ
         NzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        fh=ZzU+MGwtyYpvwtOBemBs49fZ7KXECOIW5lDFgDGIADE=;
        b=H/pqzUJ7yJev+6X+vma2sxz5jzQfY7w/ZxPrFGiJ1aM0hHpSQKwiuVvxr2hIYl2Rst
         up8legXvbD5+8f+mEmx/s1JdLkvtaTK0N24BAVGUT28r4IuRJmpNrAQBGDmECBRHq02e
         8uirOQ8mXlHIV0SP4WpWAS5iP2LOpEeN1lN+7+7NZrFBeNs2So7oydaKQrd0zE88kJxX
         gl9DBcTIlySXm2jk7auMBO4g9Q5CwpyPXkPIwMUik3gn8H9KAdlr6k26VGHVAMNO3sOf
         Ug4dhUj+Bg31mkk/WcHfPV538cLU/CfunrMKSK6LE8wsUwUI/6tAIMC01/m/zvIqi3Jq
         Gclg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785764699; x=1786369499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        b=MTUg4rKlUUL8Nu7o+/d0PeSTI1dnlJUcV3Byah4LTBrTotyXmQweamfNFl+3SIfDCr
         ng01Np5Mq0xloHVmINFBFGdquGx1OE1ovhKZHLmVoi+zg8x1fxrzYeoZH8M7yGI8E0L0
         ZuO5mC7WcaPb03GMQ1r+iPwCb/2/vkh/QIyYlQA1F22wiIppKv6Uc0l++a6wfd8n1G17
         Csl/X4H06JruwFzE9LpjIG1eYOx7Ge2I3GsFY3mh2JsMAqlQsWBjUANNNUgBNG8ys752
         QF4Y8PhVFgDQ1v6Wcyjm0VwCuV5Eey004tFKFZlLsUFXeTonmuIcIxKwGFdjO94JqfM4
         YmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764699; x=1786369499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        b=ocOo4pXdKx+VEc8fgeNa2FMnPcyLq+R8MUxJGUEZxpeHpawK0yoi+fhYvX12EENiUu
         2fhIfcqXkHxkattiXdO9temCDAFJFv4BMzbQgQdtk99k73RmQpIj0fDbvZm9BhivAr8J
         BWs1IwWyh4BwIS+d3X0/NQsBQIMK7f8e6IMOc9fuZxmPZiD4l4mbC7MMVOy/SXmRrDli
         z2T6dHPorbyYup7q+uKcX7s8b+XzeS9U+/23kS5Nub1rZuIiYIkDjXfJrGO2vRXiSZFI
         TPccfabqwUgPbaYe/ojCFOhwXznH8hz9i7A7RRFlFImxtqmnFnEn2fY9yKdhp6UjckIj
         o8OQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+t1WYTMqIsie4yr0iJ7Czvuze58souMd4gT3y5bXyz48oHfVx8hsUwx88WYxoVB0jAKfxrzIYwB8k7eK+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IgpvBzIvtLBTF5g5L3c+HX1ZZ7bqX7X72A53Qei07O5uuEkm
	OwBu8CE5ILxJwOC6Dz9dT6+CxaGZTNdbXxQgmTvAueDDxswhDqMS1jSbVbLtKnF5RnOAZ8liABX
	wVwYAtxQ0bQg9gzdlJoPgSc/eXlXLsWjC2SLSVev2
X-Gm-Gg: AR+sD11o74/qEKQIy4R5z6Gv3GtX9z7Q8MvCs/zE3kV61xztFpLP385uc3zIK6yDn4z
	obedZk6NhL4L6Iks50CwBiQujlDJXwWZyFk+xHdHGhsWuZWNcH36fX3G3iRUKzhin0rzjPkbeg9
	74AiVcRaDyey5UG3NfkQH0NVB7Sp/fzNMjpjUU4dF1tuxZ2WD7t8d1ZEuy6Jgeg2fkz5nqII8fE
	wZpFKy2hbiMpGdLtEVqWzcshbcqng/4JWKoLP6ckOYDCBNDvrTGJA8lDdB2ndLMaqHsJezUORfI
	6ZJrneCcabKvUyYnZ2olAR++o1VakRDAhtz0CE10xhnw4Ok+6QA8EKkGtdlW4F/b2HY9+OOHZ0Z
	FemsCeURoPxfgBjEhQdef3LX/Eytq5wzvINmhfR/KFSc=
X-Received: by 2002:a17:903:3c63:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2d0547fc556mr15355195ad.12.1785764698053; Mon, 03 Aug 2026
 06:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
In-Reply-To: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
From: Jann Horn <jannh@google.com>
Date: Mon, 3 Aug 2026 15:44:21 +0200
X-Gm-Features: AUfX_mzMs8LPMGeaw0QXamLvi3sESQh9nHboIA3NCYUg_jtF9QZJiqeYlNr2lt0
Message-ID: <CAG48ez2YssN-F9DHHskmiWORTnaBPUUyixqufD-L5VkW96Uv4Q@mail.gmail.com>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
To: me@black-desk.cn, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:50=E2=80=AFPM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
> The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
> credentials ptrace access check before handing out a namespace file
> descriptor.  The accompanying comment states that the code "mirrors nsfs
> behavior", but, unlike the corresponding procfs paths, it does so without
> holding the target task's exec_update_lock.
>
> proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock for
> reading around the ptrace check and the namespace lookup, so that the
> credentials used for the access decision match those of the task when its
> namespace is read.  Without it, a caller can pass the check against the
> target's old credentials and then read the namespace after the target has
> execve()'d a setuid binary and committed new credentials -- accessing
> namespace information it should have been denied.
>
> Hold exec_update_lock for reading around the ptrace check and the
> namespace lookup so that pidfd truly mirrors nsfs behavior, as the commen=
t
> already claims.  open_namespace() itself runs outside the lock: once a
> namespace reference is obtained it carries its own refcount and is opened
> with the caller's own credentials, so a concurrent execve() on the target
> can no longer affect the outcome.

I think this makes sense.

Given that the rest of this function is written with scope-based
cleanup (https://docs.kernel.org/core-api/cleanup.html), I wonder if
this patch would look cleaner if it also used scope-based cleanup...
that documentation also says:

"Lastly, given that the benefit of cleanup helpers is removal of
=E2=80=9Cgoto=E2=80=9D, and that the =E2=80=9Cgoto=E2=80=9D statement can j=
ump between scopes, the
expectation is that usage of =E2=80=9Cgoto=E2=80=9D and cleanup helpers is =
never mixed
in the same function."

But we probably shouldn't be holding the exec_update_lock across the
open_namespace() call... so I guess this will require either
refactoring this function into two, or indenting most of the function
body, or some explicit "drop this guard" operation.

@Christian, do you have an opinion on this?
