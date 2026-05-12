Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511B1A267
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592726; cv=pass; b=TGgWloeaLxdGdTK+NOSukNQijGzAobZWldSsZ4BR1S3KOoJzJg541aFN10PB4Tjp23qp7FwcT8Ec0jLiYxa+olnqa5QwoG/++kPs3rSqfmYLA1FI7IRmeOt80SCSsp74zNOpOfmYth042WNTiBRThW7AN4zBdgGwQCAYYli6APc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592726; c=relaxed/simple;
	bh=49jW8ZapXANMFie0lrwx7RkYd4uYDwwdGjS4FnYv9zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3GZwNQHHJh+Vse8g+XvNlSTMoBBjGR3D36GejnOeqJ4pYDuG/LxN+N8wCHPqBRNbtIJiXJbI4PVN4OBMTC8rWjVzoB4mN9hon0tXg5sUbqDDLWqDYQJws4O92UXxUmV/x4IinFeJm82w8k0bS5DHH3wrIPLsB4deglHGcrY8is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6nbj3ar; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6nbj3ar"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b941cd869cso34535505ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592724; cv=none;
        d=google.com; s=arc-20240605;
        b=ZdD4GWH7eCWDx/B9EsBjA3V88DBdDwbM3Td9kx4+x84LBWOv7SDjslAQ3PIps8pOrH
         Gj9hMPQguAt865IrJX89yiWz09gzEXR5NQbksyWXBplhw9OCs9z5LxdUX6nm7+qjEuGN
         wmuUVSnkxEzzegdBeKHEBzh54xBjbvWpzmluMJxi+u+b6xnEnzmd9vkaAjuWXih8MnAe
         FvqIyQglk4KtXmcU+KFXQItrqzTk61DgorMn//YVecHF74AtTfsKkifjcljcLHuCTGq6
         Fb224fvGTahEnORpboVbYa1+5f5W5IyKpq0N0LH67JXWMnfjAAbNSQ5LHFAx+78/Gj2Q
         5X+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        fh=jKDMOlH0x9yCgRZE1hKpyqRvRWYt+CLomWTeAT0LtK4=;
        b=OptTaurAd/Y/EA2qvQKG5mCnkH1nuFGyJEuPdGoWhaNsrVSTgU6zJUVnbX46zWRCl1
         uEYPClfYqR3WPkMNbCPh2K7ES//hhN2UQfsWrjGugT+dr5BEdhyB9aMyL5bmBuVd12ur
         6BIC5zpmQkYl8pGfd7vo0BfEFR2Lp5sI++8wwaNMPKmfMqtr/i4ky0Es1uspsPy+FLvv
         KdZgRwt/XMfcI7xxBVA9rsel+vYVmObVRAzrCQqVqFOfuzaJ1d1lgDW2tGdY1pW81kIb
         kPE7SELpfivF0d6/mVkqFZOpZLCD0YkMcxhQHr+qk3CQX651ma3aU99QzrUl/apwVZCB
         lsbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778592724; x=1779197524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=Q6nbj3arsrs1ZogqprDPGpNBOPMkhELFsB3N5YCHDF263py0coD/cKJ4XAI81ReJlX
         hytSGWtxCzD5JSBLPFhUzBDXKv8AJYSj2XG64j5syFspKgTb1Ycoqvvv9Ihd/X6Ie959
         GYGKadZ7tViP+6Zl3jwlzsw5bxSvkyAqwyAbbUD7iy2EpowVW81E0hkB/d/0K0FlW415
         7ssdDaVxrIlhxx7qoQ4FCVI/ApRussIxmNJDYg1wIK2vNm33UxbmZh0DK/sd93Dk/Sot
         7vmX+VbX0aCoznwEVklpf0uVXJZylcZ7k23sysAzIBdDS4Nx0Xl2/JYNQmpVxXVnxoRD
         a3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592724; x=1779197524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=UcZxREMCy3YFlQKtajQ/i1dIySCZISDRkAaiEHa9LtIe22CpHYTuLCQEMY8ygTdHLP
         XSVe3TBfnn0npq/h2Rn/ASO/t5JUFuxY/3zHUQxzjzT3iWahhZhXukMG+jKQ8eof1vZ/
         9MNGaoXLs7d0ZJEROL0vrNSm0ojt8wXzq6CtGfe4AuNiyottZS/PahTEFZAD4Z0CijR0
         AJZfuXvLL/ivgavP/PLwz5GDyFULYwQfpk/B2xXxh28i5C2e+Q9KrKQoGIBB8BKbsShQ
         0zhysM78BHeZdAcCUa14YRIWGjScjvXiHACk7RJC+FBqJfPFW8KBGOzUZXvAwfLaasck
         UKfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8A1wmGJZCdTDaLTdGK7m+F7/JGhYBN1S/e86ctyvVcJaHZ5By6DMYHhrtMcLBNwNoipG0POYtNd1VR+Es8@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0t0Dpf9KSjuDys4XYKdXUyftXY26d9cq2qMjBc84FIRE5jzt
	A597pc0fZvepvUVsj5uwxEXhz3sDlqS9bw5o6YWeYtO0YV/r2IoroNwSRdPqOIDzmvmeSylTjCF
	AM0zxjcMgqAB9Jimn2ll8CZTvsAUtPmoenmhn5kSw
X-Gm-Gg: Acq92OGro8P6hc4SMf48VXOwVlDz77o1mPGh2wdHEaH5G5UIuP8hGMoR++ZconIVnum
	O86ZM0hIQsk9D4OK59ALj79qB2+YqD5uvJ0M0j0A39g4pEDG6SxmQP0OtJy0/NcMpOhu+GBCqsS
	dFfpyTQxbu4qvTIlj0A1V/N4td17xFyXjVXpM4v7Ryic0moiTt6N5G0qBm3rhGzDAVkhBB4k7zJ
	8EOBI4Bw2schACB5BKA9hH097QP+yM8idcQkCCpQbkLAr7p4dr9nvu985HbHNriHtEK9qCPKKsG
	mvabXDNVl6+3mxutgg==
X-Received: by 2002:a17:902:f805:b0:2bc:dc0b:ab1a with SMTP id
 d9443c01a7336-2bcdc0bad76mr55621515ad.35.1778592724418; Tue, 12 May 2026
 06:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-1-song@kernel.org> <20260509015208.3853132-7-song@kernel.org>
 <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
In-Reply-To: <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 09:31:52 -0400
X-Gm-Features: AVHnY4IPU0C4Y8X9_dcIUSlLPhJJAw5e4I09h5zch8q_eb3KJ5_1mBDuZ4l2gH4
Message-ID: <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, herton@canonical.com, kernel-team@meta.com, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:03=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/05/09 10:52, Song Liu wrote:
> > Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> > reconstructs the MS_* flags expected by tomoyo_mount_permission()
> > using the original flags parameter where available.
>
> Please fold below diff into this patch. Then,
>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)

Thanks Tetsuo.

Song, assuming you have no objections to the comment blocks, please
fold in Tetsuo's additions in your next version and add his ACK to
this patch.

--=20
paul-moore.com
