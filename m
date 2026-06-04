Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C648A2BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582652; cv=none; b=dMNM3ymYsrfTwKvjMAI8Usu7mVALwNkf/QsQ9713kvYAVWm/ljp+rwR11062uu+HMp13Nko79FBZGBQNZ6dZsMO6+pgKQZM08vfZo6qE5RLhXbBVII2HE8ffobfqtUZCTbCuoqQaUgWlIqKAIUuQj1YqrbPGN2GVx3R6c3+BUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582652; c=relaxed/simple;
	bh=Ecbl/t5OYeJ4mb+vVa4qoGM4jTXP3pkfic84pGx71kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oveXSjstIRfwDYTgqqSDV1bQ3fEF37Z9uD8zsQFOQ0JDYPJ/GDWvNT8LBOcw/u7Z2kbwvSeJdtjZP15Nv/NcncrqUsEsiXl+qUMLwGaB0RRdmXKPi60oYe30/IgNZuRAW6Adr4NbTAa8r+vKooiDh/i4668PQo6D/j3v94jPw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZR+ZY+zx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZR+ZY+zx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec49f7e35eso103364266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780582650; x=1781187450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=ZR+ZY+zxTUtSjTgKJrSRxVrz3rvMxODOqoLzntz8AyaivpSiF9Ae0cUUL1v2fn92JM
         mP0EmeWr0glHhCIMv003wgJXiqSSF1ydf3s0btixbT6zhlnR1vlFX17/ktdoUUKPeYAM
         qOE29EmVDyCyr2Cva84XWK8PabOa4wWDm7/xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582650; x=1781187450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=QAUqAtK/qBdfUX3LWyIqOqZWNJoWu8BqbebWiwqv+iPaJTxiajiJ0/ZAOJLWbfyKHy
         a+uqbogvmbE8tWtMEL8A3m9FBn3/xJSw3jepcyEOAFC93JafU5AuHjZFl4ysve5HqF3v
         xXuKLmMbI0bsnnJ2d8cXr3TJWAJ9vuVszPyFjU5tRwJflql0Rhlxo6eZzv/o77svYogn
         EYqb0LAzJDylFnZSXc4gZIAoNqUXMnMF2eqrvA2SwughJOpK/Rs8Uz510yEz2AkOWaKE
         Cut2Qm2htZnHEDld6WYDIiVgFHjmYhNfAdEV892d+MTQyG2cbFdoYFcyX66FXGviEiyt
         zRkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lhG6hQdDHaQu6nDqGEdtRJIZ3zYNX9l6Hgcmx46cdG6gbD/ogHXypTUjP/+yVxkCySJy87IUTIuG4xnIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlx+7XEBqnWIwOZHT+qvf+YVkKcJmX6clhVManAfyOl5ymfx1
	JBaJwI35hKfs6+21UWre9Ahbf6q0m7Y/AO8TC2AmN44eeNoXmSo/klN2RNSwvyzuMG20wylaQA9
	doZMh405HNQ==
X-Gm-Gg: Acq92OFglT44/7sEGmNrztSg6j8G0yOR1xLDz0uHkhMNLN5mdc0cXjDF4zTbzlmUCuj
	AT+0UZxZxBpohzyBpBxPEKEOMYbXph7fdzlkCc9jV48GwJkhAwtvEM9n27kZVpKNiIuCSUzbQRr
	fhGxfmF4b6P3zQdvyiMi/hgtByXdie+RNsiAQe1gy/WyWVSYosySIq55lkXxaRuHB0srtnUFf2y
	FydluQYND8W6lH1Lc1tfRkktoEFCpAuivtnxgXTSsqymjdwOo72S+ujLE/cVakbeBjV9K9ofSL2
	9AK2mTE+Qwz2GNJpEcBep6pcsqbLSsZ8zP4ZXcTGt4xk4zlToDEsuxno8/bGDVCHu6TeuLeYj2r
	ptCM5jQdk10iUvJBGABuXzXmIiWpipU0aN7yHawTJWkrOhLNpKb7Cr9x7UYja7mC+sGZIrQHxok
	B9n+1+Ahq99LfGQApg1ZCE1GvnDCA7UQDkVW+Qg6hIwCPiIK4hlD+7AuNm61I+MhL+WPmk5npAw
	BHZYR2RaMY=
X-Received: by 2002:a17:907:c282:b0:bec:5234:af7d with SMTP id a640c23a62f3a-bf0ac20eee8mr442279166b.6.1780582649670;
        Thu, 04 Jun 2026 07:17:29 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65851fa2sm2465184a12.18.2026.06.04.07.17.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:17:28 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso1059210a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uzCPx2wO2lBzbahRH9S0W7KKP/ihqDDdMMvbybKCu9VhJ8rK4G6yp30WvBM1IPxaT+VNHxD1giHFnwNsQ@vger.kernel.org
X-Received: by 2002:a05:6402:5296:b0:670:8add:2b8d with SMTP id
 4fb4d7f45d1cf-68e72739555mr4177743a12.24.1780582648047; Thu, 04 Jun 2026
 07:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260604100609.6b37f500@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
X-Gm-Features: AVVi8CcQ0yaowxPCFqM7JCGZCz4oCGBQaQ6sAmWXnRpVnXINniRqjS3Vb3FRVpM
Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> Something needs to ensure that the high 32bits of the fd get masked off
> on 64bit systems.

That something already exists: CLASS(fd, f)(fd);

It ignores the top bits, because 'fdget()' takes an 'unsigned int'.

We have been a bit random in how we declare the system calls in
general, and we mix 'unsigned int' and 'int' and 'unsigned long'
pretty much randomly when it comes to file descriptor arguments to
system calls.

fs/read_write.c in particular uses all three cases with no real logic to it all:

  SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
  SYSCALL_DEFINE3(readv, unsigned long, fd, ..
  SYSCALL_DEFINE4(sendfile, int, out_fd, ..

but then anything that uses fdget() (through one of the helper classes
or not) will simply not care.

Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

                  Linus
