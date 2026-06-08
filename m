Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2043BED1F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933514; cv=pass; b=H7l7m4moyKs5i4q7nwjcxQKQ1NNGqQBwsCo5J428HPWtEiCYWFNpnhXfEvct5wDW5pZZ6cRWR1nMP2yXjFWmB3vZPqgUafnm2vvqnlrxF/DsDNUS0xqi2bbHHC/lE3BPHViZs9uZ77y1pDe+o/FXhwRGh7dq3lQqoB0e+5zy0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933514; c=relaxed/simple;
	bh=J+aIFgkJHczJNgL4kcgnE8wdjpuzfAatRFTenorL55A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1wKWoqwCBF0r9v6X8koZz2k0vrpftwKaYLI07QBP6Nh5OlBPzMqjCOSeyehkC5P9fClqOMNDgw2O9RUcjlCoWe8NEhFutu5LFRBw61wdH2vREaMzgQCBFN/y1fxUWqfD1uyIYaZK1AmVXRmFF96js4G9PR5aeXx4ExwEy1NZTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbVV+UMA; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbVV+UMA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso30505a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933511; cv=none;
        d=google.com; s=arc-20240605;
        b=asgQdlufGLh3qlhVaUBwtNtz0n8Ta4IJm4Gct0esZI1Np3xdVz90AU4BVZ4ncz90gr
         VF8Pj46jdUyEwqAwrjeoDW8MoKKNEEzUbaw5U4s5L473salFDGh9SPWUepNbq4d6O4bV
         0C9FOxORnYf+/1ulwVnHrQIXte3jW6vMIZxsOT4CQzjsg+lHCw051RH6fmk08neGD6BC
         UFJ1lcZXpAaO4uSXBYWQ4/KSwLGGCPhdSeion5+k4q8SGQ+wrNF6JC94mxZ0TzF5pekN
         hsR0PE4wr/xWRSCGl0fDfZBteLKkpBMhH6lQBArKgC1Xn9kSQbN/jH5sxnT21sfsn6NH
         hMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J+aIFgkJHczJNgL4kcgnE8wdjpuzfAatRFTenorL55A=;
        fh=QIeyzNnCsLg6Jf8h+gIbnaoMndksVmyHyvIVxLlV53M=;
        b=DsVjGnmPcqbW/KJfSK1tMyvQX2G+c9JTZO4C2W7Cc9rxilJFazQ4ocvxuFrNYCgV+d
         obN8n+PVDf1rXvzt9ChOEGUpGszIYK0Wyt0pTDHH6+2IlSu0qNiIMAE/cLBzpX6RPgM/
         mtvpRC2PqY2v60b0BQijP2Dk0HidcaboT7U3Scrc+D+Tux002ytYg2tVzz4d9MYLyR4X
         hbUMEYWQkI6qWYS2DCNfsPGUyIEBO5+sVfsN1I3ijI8LOEqv7IfYTfi+rVQ/tN44NWBH
         j7RB2Sn3sqVrcGVe35kiLoe8NkdzNl5PFea82roJYy2eTJVQLt/Ed2vPq1hah5DxCe3l
         SGlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780933511; x=1781538311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+aIFgkJHczJNgL4kcgnE8wdjpuzfAatRFTenorL55A=;
        b=kbVV+UMAVUI9HUmMAVR9BTO3pjtmXqd3jukWxPqFgD/giJjjtraO1Kn4jnLDGMKtab
         OL03tzkCnCiggrzRIh0430vUFHNw+7pOnLsf2Go7T4D3wTNrq7eUcCcpuaiZQq/JVeFE
         OnIu3C2BB5e8VXl5yK6jbCdO/d/Zxl1NDVnf2PmlwUbmlQCBn3IOOPVqqI9gOJ6wmD4i
         Gs7BZ7vKHBPrWaPQR5WHb/WT+uK7Da1A8nsRPU4NPLY5w34RnSJSGdh51RHcjWRZBDKd
         csnc9TVI385Yc6Rp2obYzjSD3xjFtxOITB6Gdamisqlsb3l3zCHU370/OCqjSWutZhLx
         JuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933511; x=1781538311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+aIFgkJHczJNgL4kcgnE8wdjpuzfAatRFTenorL55A=;
        b=heB841yGH/62i5Zb9dwBK3f3kTDes2fNlyXxCzXetyXA82yJVmvhwwi+OfFS7/IAiB
         07SYYn1cc0CZ8dZh7l7unE83FLfp//pj9snaOeeHUogDPdiVQZm5v/K0sXjEOZVHGc5O
         fkk4a3tYaDS+Y3RrWRJ0caxleTwYjdokHmAqx2YJFvu3Ok2ETUmOK/rXWzIpC5oA9i3G
         3ILweeT5ebR6dAVjTHUZLZmnl/tdWsjrWgS4Lkthw4yP2cGdhiSahXLhxCu/KtXhdDVd
         ztFpWjxNIkKtvN/mXWs+JtD349NogkHTXJxdP3x0/PrAxgGrPTnPpdMJgmlLdPKeXpRt
         fsZg==
X-Forwarded-Encrypted: i=1; AFNElJ/TzzWzNqwVOroF0CtsMApqa9XNvF/2cFhsn3vboNsUT3zDUpNmuiwDV2deRxKMvPvdTfc5kpR5me3AbinA@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJGfA4kFOLFRFc2O4vvLOawlxxSikRT/ioQaNz+Bp7V/z7ojT
	zXCwnmDSlpmHkS//0Cw9LZyTst7H1SVyHuBOlZJrN7AWh3ORBwSC0Q8Gw12EqHPWB6FgoZEb2nW
	n6eoNR9KAB28HxZ3xTQ1S6qezI+T0kEucam7WbJl8XuiqxeibAxJS9FWn
X-Gm-Gg: Acq92OGC5Wa1ZDLtVqrTEtvutEJK4Q3tS571aMppu1YJtSpKqtEEVQGkXWqAkSbKWFF
	A4N0AxRS/FlocbmrN6A058sQOhOJqYvqxk5OI2j7Y6rOwWQuVszMPjfXIBofGV3w4mJOr+3Z1ww
	lSiiO5LLOGlvSUUZnFrcn+n2PfQpliDXfLNTE5eCf2ygmzvuiMGl+0jf14VAtGCE2fRo0NnswqK
	7JEsx3ChLHrPq9cQHt7Kl4IIW3pkYaMiF5jecWW1/Ooq8VhJLuYtZ2+V1pPoBpOipY+wLwc7sVq
	YNKng+s0beo0GF4A
X-Received: by 2002:a05:6402:33d4:b0:68f:d45f:e496 with SMTP id
 4fb4d7f45d1cf-68ff191c24bmr172212a12.13.1780933510801; Mon, 08 Jun 2026
 08:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aiPWD6xZLg6g4DTO@lucifer> <CAJuCfpH74gRmgm2tgwB7SHzL9DrU3Yc4LyS8XLa0tR7fJqaw_A@mail.gmail.com>
 <aiZ5qFTc6XDMsqB9@lucifer> <13f428df-7922-4870-85bc-90039453f247@kernel.org>
In-Reply-To: <13f428df-7922-4870-85bc-90039453f247@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Jun 2026 08:44:57 -0700
X-Gm-Features: AVVi8Cfxi7NgQqGh1zDMQIjBR9NRT8lg0XNTPpig62vSCMjknBDjB80v_CdcxnE
Message-ID: <CAJuCfpEGncKHsp5K8fzxWfCZC=bH+UG7n4CNzzXhwYcvT7rfHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:32=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/8/26 10:14, Lorenzo Stoakes wrote:
> > On Sun, Jun 07, 2026 at 12:45:23PM -0700, Suren Baghdasaryan wrote:
> >> On Sat, Jun 6, 2026 at 1:12=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> >>>
> >>> (Will review separately)
> >>>
> >>> Sorry to be a pain :) and I know it's a petty thing, but even for a 2=
 patch
> >>> series it's easier to handle if sent with patches in-reply-to a cover
> >>> letter :>) also makes it easier to track overall updates in cover let=
ter
> >>> changelog.
> >>
> >> Yeah but the first patch is a simple cleanup of about 10 lines, and
> >> writing a cover-letter for a single patch seemed excessive. Andrew
> >> would have folded it in with this patch anyway, I think.
> >
> > Makes sense, sorry to nag but I want to be consistent in nagging everyb=
ody
> > the same :P no matter how well I know them or otherwise ;)
>
> I mean, it always looks like there is something missing in my inbox (e.g.=
,
> people CCing on patches but not on the cover letter). So then I dig for a
> missing cover letter and find ... nothing.

Ok, I'm convinced. I will add a cover letter if I get to respin this
patchset. Thanks!

>
> --
> Cheers,
>
> David
