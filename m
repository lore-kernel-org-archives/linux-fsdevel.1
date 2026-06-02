Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678A3E075C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412779; cv=pass; b=Kwxw53ySIahSm4zFGaRA1g8zZBdEihtabn2cLNf8+q8dY5jq/3v1Hps+sbvAX4P46kLZZv7xB/BlQm+CuEnGZyP7b39LSzubpbsV4E/KCu0P2hjxyaatphVMe1VmHjvaTEGBjOxcQYvL7I6GyDbMAnU/cI5jjc3+bHp9BYNtWv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412779; c=relaxed/simple;
	bh=VLK021kWAqky9h71XMeJyeCqSdyro7e0ThnQW0ZO/3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My++afXZXFSY6sKNMRMDWQ7omR9Sar6tZiH+paaaTEReZGRM2DxSjKVv06plaDs8f/CT0Q0KTSOo4OK3ODp7veN9dJi/WFncxY8lHRD0n7mEOFVPvFljzHBzOfTBvxwyj4Abfg6xESX+GblSiKJ88zC/5Ka1hGQEUj8/i4CfQ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx4392p7; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx4392p7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so130a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 08:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412776; cv=none;
        d=google.com; s=arc-20240605;
        b=YCqLVT8TzKpdJMkh7FyrWQkFryEL0TlECff0g1xjTAmmhUwHwfuSeYjK2anPU4POjP
         iY+B+0HLW3mxRQh4/IX68QMlpCSLPBiFNgS8vuiKNqaxPVwYqKDbHRvIehapmN4vDnCk
         7WlItMBOwR5pkP1N+UmdePo/9nad/T1pcAYWAQwj98t+GLbcmEbf+HOuKX0YIWjC0vYr
         O0zXKwo+BDEs3WE3bY9WRFv05sBB3oxE6U9gGlUtQe556goRaWDgWtPX5Am2CeVHUW98
         4b3m8Tre1kcyCkJiwmy3bYsi/tRGKGhoC7K8mPQtjyKt+mMvl7ItsczD7EkWEqDB2kDH
         N21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLK021kWAqky9h71XMeJyeCqSdyro7e0ThnQW0ZO/3A=;
        fh=rAZsklico3sKrpD/D0WAD5tpzQ+EmutFDIA9okt+ZUg=;
        b=XemUYajHoEmd9nVtTV7YNNrchzCJ4S4612w0qDomK6f/iScec70vD7mw1Yv/OiCrvP
         kBmQBEp1SD2Nzpg7RlitWMwL9mRldXAvXb4I8wH/n7gXDjgfuP2x9FAZVXiMeoro2Lsd
         nLpzNW/l3sCjhmy22CJncqHeZ6PMhk47HN6p6Wb4glkwPBOc+gSw8dUhdQex1S55sMzM
         ikQgqtuMQjOs2Ba5i89QC8wlTL13JS36ozuKgpvbECJpfLRGEytNE3eS0NIYyUOn9RMG
         PrXGQdku4UoNWhVBmNvw834QorU4ylL33RoMt9JK0AGyk0jzcEoXnZAGgdgvB545g8Qs
         2lgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780412776; x=1781017576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLK021kWAqky9h71XMeJyeCqSdyro7e0ThnQW0ZO/3A=;
        b=gx4392p7/lho1sDrIYAtKgS+edsYg42bpaXj1ZHwUjFP6UxAEHcBJP4YljooIlmO9M
         ePXB9NtbxWCIAHSzH7u7DCmMMSFdD7z4rJwz3AnkY0bg9cCVQR5ivtvyiQrW4jMkskJl
         C9YSJ7NjVz57KpfsHgMF+6trhB0Pz1Q3qF5mQjiGdyfZusK5cPFgd0yzuwW6uNVk1Ew9
         sfQkqU4mwlCQZesHIL1XCNwY1D/pGwnMayuDbDevYp8/vqsaHZBtQ09kqptEjyaLVFJp
         /pLwiSOrJifhiFXIeWdshA0qnNZXd8b1eiBEOEmCQv3j/lvqBLbS918R6WhRTWChzBOW
         rpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412776; x=1781017576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLK021kWAqky9h71XMeJyeCqSdyro7e0ThnQW0ZO/3A=;
        b=NBhMFqocNcILSuLe39GYL10h+57v7ERQAZ///ij/pvk7ABFE7COElfo8JBPqzU505Y
         lPtC4m5AQo8aJnSszcMz86Ti7PvK6Gnk17uZfJyDbNA/2jIoYbuz7X5gyZI7orHLFh0k
         sOAqmAKWqj8ktP/vCPjLtbGY87Rc8OnxH847BEqQ9g1zXgCJr667opU8UtjkORN4vqzr
         vLigg2JKTG59AFGcz/8HLELwCZaX5Pfig2DcHlzisQiOFWeSP8hb7QvOT1U8rU9cKxBb
         7Ku7ewIwy9mU/2x964/oHAipLq/EiddtWpggBCJmtzeCIO4qPgcE1mDiNk/CaFPinF2g
         7ATQ==
X-Forwarded-Encrypted: i=1; AFNElJ88tszmV43A7F820rsl/GpiTV8NaduxjgzddhKkNIppHXcfhtHWPXvFG++jrIEDH8OeSpzXl+WyV+D0EbXk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5i5ySIemC9xIFyuMhDtpqJN6klxLIGPlJsQfU5KnHMV0nIjid
	wrNCyxgJhoh3CIihM3YA1N7uEUIiR6cBoHMIPnO7/5SmK5LhOYUZQ0tMeKOWs5YWs+5kbb1fTYA
	5phpRLgO5i8J0GawkvouNCAgb4gZahJVa6+KOXtfhkDinmu3nJ9P0fxVn
X-Gm-Gg: Acq92OGmKaDhuUzR0UkGUZO01pIALw1K7Ioo0jds9/e+qEmT6yF+3NDYRSB3iR6AwIi
	GkmrrpT6QOkgNtTzHLNqwi51xpu6u6AP14snKpRFQxU0pO/eQ4TuZdaArdRGsRUBuaZWOX+d7MH
	/wRzUJ1F75c01u1IJhpFtGMYtomsa5Dq/BPMcecWPIF44PaPISVXFGrsSwHb3YGy5Nh+4OEGwX4
	5sxEz2AAWVIb6kwW0NsnuSsW1JrbAb3tfJno8QSiwfhCB9DByzfgfW319iKlVyeULrkzjmaJlGH
	Ngl6vQrPABMR/CQ9hp09/dSJ/ZEhieG0mHtZLuCr1Epdpvi8
X-Received: by 2002:aa7:c459:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-68de164b055mr108132a12.0.1780412775914; Tue, 02 Jun 2026
 08:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com> <20260602-rudel-zerstochen-fahrdienst-22b9860144b5@brauner>
In-Reply-To: <20260602-rudel-zerstochen-fahrdienst-22b9860144b5@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 2 Jun 2026 17:05:39 +0200
X-Gm-Features: AVHnY4JDnJtG5Fd1ekRv2Nc5sFINK4yvd5n-wB4b-_VyXSr-RoA96kmbzXWi1PI
Message-ID: <CAG48ez2dqs39z2UUUOCg8bomhRm4g98ErKXru4-R10m-Snvicw@mail.gmail.com>
Subject: Re: [PATCH] vfs: document locking for mnt_notify_add()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:14=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Fri, May 29, 2026 at 09:38:08PM +0200, Jann Horn wrote:
> > To allow mnt_notify_add() to reference the namespace_sem, move it into
> > fs/namespace.c.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I'm sending this patch because I spent some time staring at this
> > trying to figure out if this was buggy or not.
> >
> > I don't know if this is working as intended or working by accident,
> > and it might be nice if this was cleaned up to have simpler locking;
>
> The locking is rather simple: namespace_sem. But maybe I misunderstand.
> It just piggy-backs on the same logic as mnt_add_to_ns() in that
> mnt_add_to_ns() may be called to add mount into a newly allocated
> namespaces without namespace semaphore held. So the locking context is
> guaranteed by mnt_add_to_ns(). To put another way: if you have quarrels
> with mnt_notify_add() you likely also have quarrels with the contextual
> locking of mnt_add_to_ns().

Ah, okay, thanks for the explanation. Yeah, I guess I just didn't
understand the larger context of what's going on here.
