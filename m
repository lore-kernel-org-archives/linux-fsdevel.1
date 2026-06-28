Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94735B62C
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683773; cv=pass; b=fcDfkYs2p0x5/TqZa0QQJiIcPjvLTnYL9ILGDiknVPFAAjwAvcPqmJ61M1ARRhoeV/PqoGuxuXi1unAY51Ds0Fv9lqnTnUhvnITTO99ZgWrfmwboxKYqPYSEMNjTexJpmIIjEalO3hD9/pBLNxzguyQ1UD6Oz8/C4VVOdMdGUL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683773; c=relaxed/simple;
	bh=CXFoWNfHWhfcDkhXqvSvAn9UTsWF1MreqruSLUO5C98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqnWvgUXHMiwnhLqQhw+Uve6RZeErhm80ZrjM9IriRnjrP2qdFjqs1MxzOh80WMaRb/FP5ilVoOiorqELXlN9Km6vfYUb/gCYBk7tK9WJcTkhwIaXQReve0jxwMzSxj0N+JHNpruDeU6m72L5S5zCKdYXTOW+TgTfcfJjLM0mE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Gby6wf; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Gby6wf"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48751bd4abeso1249473b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 14:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782683771; cv=none;
        d=google.com; s=arc-20260327;
        b=pIt8M+vQgMiKzk54C6JtoRltQOcuOCZDU9Rnn7BKzfg6oTOo41H7sV2l3Drv6AYKGJ
         xEjy+JYD3tsyi2ktbF0Du6p7rhpeDTlgUYvH0f8PiKmZaK0ayPVdJcE97dGh+fFSJceG
         sl6PbCjTh65Q/Tm6mBicjkoLgGImfwHkhmX7KvbbgXTYJVlrd1Ki4ARA0OJd86SKG80y
         0VFBmobHSdOk8WEjsk0YG81yeZcBoVbXP0xVWaUVVVnWMr/EYEl7PyFlTiEEL5E3z+bG
         03hxmZFSmrDi4p3pWpXUDlWbP/XJtCkBNxK0MHhx4ZsZ+b0Sdh99DkLFFroiLQIl1hKW
         e+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjMVQ9eVfvQkcKs6Z9YMi7oNqSRVUXcUuwMddRnzZVY=;
        fh=w+OdRSxcA8VMOrYUhXvz1oOvBRl5TmOTOtHMNafirWk=;
        b=jqTWdOgXKm2yz8EjC5+u3UPvzHBdt+VXCMQV8TpIy5uEZ0/o9/9hGtbcsPGdNODDqI
         KoJ8i28T9r92UQsLFwBGRBzwgprnaqT5OuchB1cRrJ8wU7GLYNDSkR/DuNKO/grnxAUA
         Oh+laRBK0U9bpxXnim465n0AOrrUHvJHXtjm6eBw5xhDp/MkPLYPYn1eU8Fa883r5iwF
         SVMjbw5HBjefYYWjsAHhS4xmHpguNN8DnfsUQVs7Zo+AnDWYp3QG+KYmVQsBYzJgT44B
         TYhawO/LfukTuhBg9wxrFyvpJCq4Ax+8VqHZ0/r1SJUn/6xp1MVnOfmxPgdKl842RRfM
         mNvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782683771; x=1783288571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjMVQ9eVfvQkcKs6Z9YMi7oNqSRVUXcUuwMddRnzZVY=;
        b=R6Gby6wfSGzNyoxRDCYeg1r38MNJBOMbLwspi9yki5u5rQ3A5zudP2PdFeJL59iZnB
         7r7hUtOOlWaj8FFhkvnQtQSHY8ECVSVE+6Z8hN3M/Tho1HMjNAjXlPBYt7py/pac3OCz
         ykEoDL41mjL21V02Ei5MHE/4Xadm0zc6jLJE2NDZgEqT0+S0t2s8pBCciLYVCt07Qaik
         N59mR8GBnzeH7Uuz7CLJvq0TBCYHVYSEMLM72JNtOLG5Bijh6HOGuHZeozKtqPGtg/do
         M4wuVufpO26w7YxGG+BoloG8AsbC1UfRAgP6Ro9MztpV13XMF3Rz8T0CPTjSoDlyCN0K
         715Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683771; x=1783288571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjMVQ9eVfvQkcKs6Z9YMi7oNqSRVUXcUuwMddRnzZVY=;
        b=Ak0iqHPA0/ppmS/WSycsaKPOwcne3fUcTvDUR/RvaZm1JSEbtLeqW6uTBPDtDu0MVC
         fOQG+5p274lmLcD0E4nN4/LdoJXX0N1++M6n7xUBBGZceG+/x9NhDbuxRKtW7DLNbsWh
         5xu7/+YsRqufea+vVltm+qMYke6X49J+NoQJb6uSx1OM/L+UWIxhscEwoMIZ4f1cJCxD
         7AYk+dihcJMxtyRJ5v4EGmzWcSLO4nhrDmOx+0pOzJwitKpyeaV9Rl4YA8zMvyGUCg+D
         0JdTR8YrUtXLKwj3npyPP6U91+Qt9VqdyR3MopDWwjYNO+3Q0wBoyEiyIMyml9vlBR14
         jleA==
X-Gm-Message-State: AOJu0YxrCmv0a2y2zhS7wDH+ALW3EC6AbEg1F0gcVaiIO1TF23Sd48/O
	5lbCCmKHvm5LUCtUDR70qIGHDrk4ytQ2xB6882zowVKQOy7+RdbuL4u/r3hVIZiU8W8PGN2BD8C
	DX4S2B6r7/mAXUEPv6GbghbreLVKkQldvzHv7
X-Gm-Gg: AfdE7cnSoMEkxb6jKs30bnA5JuPJvN9ievgIbY2GCMx81bLyqQtwM8+lCUdgEZYiwdp
	1LJb3xnGF+hVielIwABXkvXll0/saWgdwOqGoDq7h7GB0IzFAbeCWA3WJG9aX7PYlD/P+tk105m
	ranT6x0A4LHblwIWmFKPJgL2wPaq/VF27C9FjnfVnxqfvfc96TiKG1iH6wVAjRKVfmzwrsAweUY
	rbbekkeaH2Qbrq9QAWw92SA/X2AcaHoUFPvd9Ek25iIatPhISBlN7TZLGOF71F1i6EQ3QPl3rmj
	3VpCmRE=
X-Received: by 2002:a05:6808:c08a:b0:492:b433:a3ea with SMTP id
 5614622812f47-492b433a61dmr7966885b6e.6.1782683770795; Sun, 28 Jun 2026
 14:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782422707.git.jbingham@gmail.com> <253660638c14057720cdcafe7d1ca2828457caa1.1782422707.git.jbingham@gmail.com>
 <tencent_B01B45AE0C90D7229905B906710F6EBBF105@qq.com>
In-Reply-To: <tencent_B01B45AE0C90D7229905B906710F6EBBF105@qq.com>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Sun, 28 Jun 2026 14:55:59 -0700
X-Gm-Features: AVVi8CcUYRsTBG7MQUpU1RpXyPFC8_Ft5MGBbVUUC-9JDnV4tPTUPuvaEzZijTY
Message-ID: <CAMyBmMBtZuARA_=3u78a_SK82xb0og-Lpx49zYRRyF4o1es9LA@mail.gmail.com>
Subject: Re: [PATCH 2/3] minix: convert address space operations to iomap
To: XIAO WU <xiaowu.417@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings, Xiao.

On Sun, Jun 28, 2026 at 11:48=E2=80=AFAM XIAO WU <xiaowu.417@qq.com> wrote:
>
> Hi Jeremy,
>
> I came across the Sashiko AI review of this patch series and reproduced
> one of the issues it flagged -- a NULL pointer dereference when creating
> a symlink on a mounted minix filesystem. The crash is deterministic and
> triggers on the first symlink() call.
>
> The Sashiko review page is at:
> https://sashiko.dev/#/patchset/cover.1782422707.git.jbingham@gmail.com

Thank you for bringing the Sashiko AI review to my attention. I had already
seen the syzbot failure report and was aware of the failure, but I apprecia=
te
learning about other automated testing things out there. I was able to dupl=
icate
the bug locally with "ln -s" as well.

> I see you already have test patches via the syzbot test infrastructure
> that add write_begin/write_end back to minix_aops -- great!  This PoC
> can serve as a concrete reproducer to verify the fix.

Yes, and I recently sent out a v2 patch series that fixed the issues that s=
zybot
found. Unfortunately syzbot found a couple more bugs that I need to
investigate, but at least they're new. I'm setting things up locally
to (hopefully)
ensure that there will not be a need for a v4 round of patches for this, un=
less
someone finds a broader issue that needs to be addressed.

> Thanks,
> Xiao

Thank you, good person.

-j
