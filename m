Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8293B993B
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511884; cv=pass; b=R3phJhz28pzcSYRk0xxBoONFCKaq6QebIxFyd47n86sCWlgNhNB85ON5lUXLysiOdhPi0o83XdidHKT7NFW9QpaAYngDNdsK9VLect/sUt31N39TThFvRRFKPjYHpcgArJ+/Hukv9TrXf3X1xHstKzVA6lRHxWrYUQ4ExDTl72M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511884; c=relaxed/simple;
	bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlXCibOlLfJvy/A/O+olzbUZfpcW5KKROHzYZLlCsA1zLoBUYPDp0iKkCpv1z0enbI4LWk8cB1snxpBgrG0dKf1khSD6VSrGQpronrqL1Xpf37MD3B7qMq4pjbTAcRhUHeSJIXUI8b/Y1js8v7EUGHQDnLDxMtY+y5g5j59PY0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsDTFALD; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsDTFALD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66e64e6e3fbso673853d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 01:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511882; cv=none;
        d=google.com; s=arc-20260327;
        b=ixbHW7ku+AmpI4+xSH28oEM2UUAeN9Tu4gCKr22OB2nTNoHGGD58Ej1MWeqNERelU9
         8aKBkjkntS9gljGJqCSerhHJj5Yf04jZ9xbscWTbwxDbMzlLSS5Z9K5F91G02V9S/2U1
         6yajaf/3pcPUstw7YanBaSFLGJNKuSmjFTEzAnXM7P0kiBm//uMX9Xyp2/Laz8/P8gI9
         M3kmbaQ0JJuux+CaI2Ll8faysktCYceT7KUUZBrAcbitZIgE67KrA6nXKP1hrd5eAafP
         mUCI2N0RVNaCkDl8fI4IxS0SpqsNKYlJ6J91zAPEGGCtuN/ZFdd/5jt92CudtrWPt8dU
         aYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        fh=PFsrP8zC8vmCGDR0h47tWMh3SpWEvWNw32ca5cWVrrE=;
        b=dUODrpJi+DF2rPhMsfNN/W9kmI2HTjIbpuDy5PZB9/dlfwkYOmXwM4kvaI/esdTidc
         RickcSsDJg4FO1t6pR77Awq36C4LfezhtAburvtSEI2e/Zjvyj1V/KrwuEISLnztw7RB
         2WL/Em9bA4RwTICEttmFAJhGSYQtQBsfQT47wHtkn3AhX6FvJMOzArpAhCmG3PBq8vEi
         YNYfuv+5dnkFF34LUpYKfGcVcm4PA/dk4fYm0ltGglhbAx+eyLjKlFSzbnDcpbNtHEVN
         VkbyeX2wB0h7PYTOhX8xPLnDbW24RUO7um9LVeCjTdvxREMp2Iy+ksvnVXFF8EAntFIt
         Rp1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511882; x=1789116682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        b=TsDTFALDw4vsg1GN3g+UztVq9bUfuAKY8SIzq703SuedfYigVlMSf6jeA7JQqnvzo6
         H+bdIZiYYT2Id0IFRDBzF/pSegUpkX04c+5X/MDwrFyoNXITvDHTLSrW8BHC+m+KsTlh
         zyhiLtSj0nxFg/pCbyTDpM19NkKthyd2RAUgxwJ+4Bn8Q4cbn/9BlnxDwHjEWADhCtes
         V7MilISWIICAkfPebCopcNudegdQLPQg/C0wmTUwg9kYGcEuRq2m9nCL1uSYkLAMXp/N
         7hnYtLDQ/9EAXev+7dGUqNFxr0t81siXFKzxiiwpRat81kwxvqT1JpGLX/MXFOcCE7xL
         TSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511882; x=1789116682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        b=pBsHcUOY5xSmHq2LjAgQoPuCqPXeZl3fI7txzMuAhHakLUuYOHlsUzSEOjLZZMrQ3+
         z4RxFdzkqiqrJ/3LdhFJUsbaq1ONAw8WNFqc9FODjTMSBlMN5Y4MxRDlFYGsrDKiPUPJ
         W9YTAiZ8XWF5Sldd0Y3GB7WNysIGAAr47jk49Vudb6XJsmdjAwuLI8X51r7cqXkD/lA9
         clzwh4kT33JEPx72QCoxmWClHzYDIbmwGlyuphLUF4Z5HXiBfVbuMgToqlRmm1T5E2AH
         hLTIkLz/50/k0Iki0TsfZ0rfx75zSPI829H0oDdVd6vx2t0fzZ6A6HrDEFiDaNKtCW7z
         FzOA==
X-Forwarded-Encrypted: i=1; AKwUvBy4vKL+l3ovx3Y6NViYOPNFNwJ53/hTwys46aBcbQcWyNE56guvIMKw5OCjLKG7lpu2+cCw7nRalAXQTzGh@vger.kernel.org
X-Gm-Message-State: AFuF++nWo45KXufQFeaRdaZE43hoZqvqDcAj/uUulzjuvMf2U5lkIaSm
	pRERMm2oxMu1PHkX43FC3/eS70K/w4EJr7oIH+Om+Ta6bXRuZZEmMsZR8kC6a5lXIoapV64u9xH
	YPzVhdy46AtF3GxqGQkbPu2HbXtKj4+Q=
X-Gm-Gg: AYBFou3+HcrqJqdNh8z3zP2wM5wY84ipJoWoIcysWYkblmsaHkRW+stmpdRuA/KWEUl
	p36U7rzgIJRdz5ULd/1/mJ8L/6cEmFEVVH7hRy6x6WUQfIeDBM2jpmz0Vukjfo+iPGKgg1/9mwu
	vPSUc46dwBzEAzJESq7d5yuOmWrIccz0F41QXuGkqMsREGfbErEYvG3fH0+RqP6CaSHaBfNgUPf
	0reseNwrgWn8lQxiAD8O0mFFtVFyV53ZoNJMVoyocU5fWFr38At1Gbd7BWJ3Rv8Feb8pcfd+a1Q
	T//wHtT37PpZVTNZyZ6INyMZnGeLnIletSethDQIpIeFHOmMl8qzs+bdFgecPTAruQYUAbyCpuR
	j0eu4ZvIQa2MgKe4EIC2/VF+X
X-Received: by 2002:a05:690e:e25:b0:66d:2c09:fb70 with SMTP id
 956f58d0204a3-66fb575c665mr1287497d50.0.1788511882074; Fri, 04 Sep 2026
 01:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
In-Reply-To: <20260904082954.48738-1-enelsonmoore@gmail.com>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 4 Sep 2026 09:51:10 +0100
X-Gm-Features: AcwNN1US813RpOVK53IyVszIyhGZqjM2-hVqjP58I9fP7PqngduJcqRbNBYYNbU
Message-ID: <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
Subject: Re: [PATCH] bfs: remove the filesystem
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"Theodore Ts'o" <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

On Fri, 4 Sept 2026 at 09:30, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
>
> BFS (not to be confused with BeFS, the BeOS filesystem) is the
> filesystem UnixWare uses for its boot partition. It has extremely
> limited functionality, only supporting contiguous files and no
> subdirectories. Even though the bfs driver is very small and is
> unlikely to cause future maintenance problems, given that the only type
> of data stored on such a partition is likely to be kernels and
> bootloader settings, there is very little reason anyone would want to
> access it from Linux. Other old Unix filesystems (efs, freevxfs) have
> been removed recently, and bfs is highly unlikely to have any users, so
> remove it as well. Retain the UAPI header to be safe.
>

You are right that probably no one would want to use BFS for storing
the actual data today.
But some things have didactical value, rather than mere pragmatic
usage. It is the didactic
value of MINIX (and its limitations wrt making use of the wonderful
capabilities of i386) that
has originally triggered the creation of Linux. But back to BFS: it is
actually used in Steve Pate's
book "Linux Filesystems" (2024, unfinished yet), which is a sequel to
his excellent classic
"UNIX Filesystems" (2003), as an illustration of a particularly simple
filesystem implementation.

I remember when Linus accepted my patch with BFS on 28 October 1999
into 2.3.25 his comment
was: "this appears to be a particularly simple one".

Kind regards,
Tigran
