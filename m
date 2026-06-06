Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179624071C3
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737386; cv=none; b=rbofN8tsyrYPc0D7Oo6AQtDgd/lUItPZ089Y4FrAs3kRbI/P7fM+oJ9MVYLv+UN+dhPDrG5oBxTL+8C2lw94UIfr/G80c9DlmzLdO/Em23j3gFklFWvrtoa7iwgAym/Lbvm/qmdFBeJ7Eo2Twfx8Zupp6ndp+314PdPaDmGBGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737386; c=relaxed/simple;
	bh=CpQdRBzECz1cjWSW+VoW6/cj4i4cip2V9Z6XLkYrqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHmVkhWxzyXf81NiOkrW9UlnIsGPMlmxB6wuhYdR+i9BTXuV6cmk2HlsKU/DtWj0V/5Ftnl9XZLjQi7nOL0+UC+x65zRBBiZW2Gr6gvzW29nfIEpNHGgkbs8O+rLoo5IUFDLWqw0mh46fJxbqQHJwnChhSo0WtBCMi1mREKuX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir9xp+Rf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir9xp+Rf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b64c8311so30649525e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780737383; x=1781342183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SxOH3sBqh56WyqC7iKaRtAkj2hv0SNo09/WoL7JuhE=;
        b=Ir9xp+RfW7zEfhlmHWN4cKq4EtLbS6jnYjUT+aoOTb4FcEuqF5HOl85ypGKR1nXorh
         Sps2ILrf5DTgYLbvMPtc72+zJ5YzSLcJhI7qiQVRN8au+vPQVPJtO7cqqxDBES9Pq2C3
         zJXYBsd06ojJkLJ2bZRiFV+BIssT9CvlIGPnjE74nfj1gV/Bvo1BfHZL5vPNBaPCI5RE
         GcuTqEqf9pFd+z2tDdK/Dpy5iV0eqG1q6SjyWiWQoleNeVnpMbPU8fnqrAFfGhoCegZc
         S9JvwNEGltkYKAdUu86r+XJK9bR4+ra4xPdJewTmDRDKYaHgcIPpjsAcV8WQ4lPKWg/Q
         KNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737383; x=1781342183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SxOH3sBqh56WyqC7iKaRtAkj2hv0SNo09/WoL7JuhE=;
        b=YSef5Bw2r2/WRfXKeyJbf/xlF/DCFS2l0Q+kuqQco/BDZKbO79frf6Knx3iAmCK2UG
         /SFM3RngAWakd7LX36v8lx1SdRKM8Mtvs/aEZmCqCK7ks3oCoFB3qgUN66TNqXPBmf+E
         W+uOIKtP66TtX4LvHIcViUO26Ifc7jbW+4UuTkcAg3+e5ZObUCfxnKwRmdJaL0Vwy73S
         5dUfdltU710EsBDNH8q54N//MwTKWVUpruE4od9EyId9P3UhG4Pp1IGI1KVzC8Ukg/2U
         q27tG5/oyjn+0bLXzFh2E5SJjpmw4+CfReFVJr18CHezb+Xxj7IJqZZpup7+XT9b2D4Q
         ix5w==
X-Forwarded-Encrypted: i=1; AFNElJ/04zEC6jtfJlhlIuD/8UUFtUBEzjqnoVEPPwNNxZ1PNsw+Lrf2SbVf3dEqVCzKGlDqbb/j2xacr8n2TBAz@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfIHA0Zk0d/TpjZC1BaGuN0+W6LKSd43Vz3Wkcp3jxOhKIKUK
	kJ9v2ROLC5jj+XMfmgH1qiiaaABIJhRoPvK+cR3NPl1GhhaXiQDIrkxr
X-Gm-Gg: Acq92OH02eXBbdWNvg8NBLCfSOErtZVU251MDrWyn/3hjojavbhDME++TEp5RNqsfFa
	PENjbKjYufJnVWKezaMYtY/V0Nzkhf8YomV1PNX6W3s04iV0ppEB/lbQibEwT8Uz88ZVJtHz0PP
	9kc9WaaMS0MNhK0N6JYZpvYAk6eIspFUrZoRrCEzHHcvuQxxT/PXNgD+VrnwH7woaxaBXD1M9Fz
	fzFAdogtCbYJ34EYkzNsutbfn7eqZc6tzyEdxUm3jGTIWbez5SAfh8b7ss5JY2y2okTOVV0/DaE
	HKerGbVQ+wzEZ2A4TESgH6oR+6t2WbzY8MJedQ9sqXfQSNIGHBUyYF2HcAMOycJiXMwIadPo28o
	0EQS8Egoh5BXuJQKUhMlazjXY59p8v/rXw4gBYXVLAJvBxzXto3i6MEqA4dMR+Lql+jttndFFEG
	RxbblW6IgnFQ2ZEx998u8nPPCND3jhfCJ1k6ZUDHE+lDk/Cdp923yZW34ABASBFLV44fopa0A=
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490c25a21a9mr135656445e9.9.1780737383320;
        Sat, 06 Jun 2026 02:16:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm247272215e9.10.2026.06.06.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:16:23 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:16:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, Askar Safin <safinaskar@gmail.com>,
 metze@samba.org, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260606101620.602ed92d@pumpkin>
In-Reply-To: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
	<87se71jps4.fsf@oldenburg.str.redhat.com>
	<CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
	<87wlwdhrvr.fsf@oldenburg.str.redhat.com>
	<CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 10:12:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 5 Jun 2026 at 09:30, Florian Weimer <fweimer@redhat.com> wrote:
> >  
> > > Uhhuh. But that is only specific to 'bool', right?  
> >
> > Also char and short.  
> 
> That sounds like a complete ABI violation as far as I can tell.
> 
> Scary. Because I would not be surprised if we have code that assumes otherwise.
> 
> Now, the kernel *seldom* uses char/short types, and since compilers
> are typically at least self-consistent in those cases and we don't
> interact directly with untrusted sources.

There are plenty of places where char/short are used for function call
parameters/results (and not for single characters or similar).

I'm sure some people (even some who should really know better) think
the smaller type will save space.

I've always worried about whether the calling or called code is responsible
for ensuring the unused bits are zero (or maybe the sign extension of a
signed value).
Clearly the compiler should obey its own rules - so mostly it is just
extra instruction to do the masking.
But for interactions with asm code, and possibly code that gets mixed
between gcc and clang (maybe for out of tree modules) it does matter.

You also don't really want to be doing maths of char/short (and there
are quite a of of those as well). I think it is only m86 and m68k that
actually have 8/16 bits maths instructions (is s390 old enough?)
everywhere else the compiler has to explicitly mask the high bits.

Maybe it is time to 'nuke' all the 'short' locals/parameters/results
(eg from htons()) as well as all the 'long' for values than aren't
dependant on 32/64 bit builds.

-- David

