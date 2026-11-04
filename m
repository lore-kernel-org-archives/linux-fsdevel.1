Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828878;
	b=ZTtfu2KsipbnhIP0qb9gjnSLdh9+RxJPl3kuUmlwE3NsSgiY17670yrpYWVHkthjnMHE
	 DMS7M3HTrJMrHbR28r81/fBZ1XyVyQh7f7kp/ItZrQdz3cgRDPZyMWrZdI9o/crCkfVYt
	 K3MsEO2VPAOrpmOftqKzDFepb4U44zu8qqn01JOH7fCLCtmqsWCQrQuZly2v6Vwq/ftxg
	 zt07iu9kbDX5aGfAA3dRuSWcDcu+/TEZW0a9PNhx43/IQnFUycPgkZItOkzDH2m+9JDpq
	 N2FbYYoWMSYxHS/PxBa6VX1Fizv3/w4dw63pIj8/UEXxkro1vOusnmgSyCfWgR/0sjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+31zDwDEoLs4QM7Pb7x038H+Xf6pdgj780CAMYuu12s=;
	b=fBZKGaUiOimRjonEet/9XyxTurQIb9obvRueYnlZNcDXe0OwiuknrQjXU4WYmY7ct24B
	 xMbAQclEqk74AU1RCdQp3NddDmH1rVpZB8+UHNmDaio5PsbY+EUKO9pRaYPXoa7efl0sU
	 9r4HmgT/8wqMsfKVvxX1/ojuyaWcVAoVsXVyVhrAssunQdA4xpEgTtA5APaRgTh/RvB0H
	 L3ZaXF4e77y4CnCRsmP3MgTrfDVmgEz6p4lYOhhI+lJG830jG86OmHSw4mkKOYt/H2hpM
	 2NVVx59d7PToQabfGmfrPaHQIMc+tSf+2bUQPYqqazZE4YluLeq1Ht23aAXnzMwF3uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LqsN7H3k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE46071AC2
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFE46071AC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LqsN7H3k
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so17535ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828877; cv=none;
        d=google.com; s=arc-20260327;
        b=VLM5hqxXEiFHPAjr3jG2nJWd1kxsUcQDh0U48F5pCPKm1OGe8zPAFdZZPkmbERqbwB
         hxwCgvlGX51rBm9u98gZNMLBONgYgn/AaKceJj4cQR3Qaiwty5XwgGE85YKqbscj+/GM
         WbesJvc+x39KyW2SNLCHANBQkZDnBuuDHzDePYed18UgFQLCO8Ou+GHaqj4suQZX39Dw
         k40E4JKwmo7+yAMaGtckYUQkHytiMRIx4Taxv8syRJe/PQ9wu4qiB8gCjwAXbGcWUS4s
         fZuVzB9y8/Rq9lgpGSZiJLpxlULN69aavtt6JPXDKC2nS4vIan2tsd9Yio1ZZuAP+TqU
         VF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+31zDwDEoLs4QM7Pb7x038H+Xf6pdgj780CAMYuu12s=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=Jx5Bmm8VgwCeeSQ38bjrJgWvvxzeZb2ZyxAfTNYynF+TEwpIxiqSo5nWL/WTmWWhiJ
         bGTtYdJI3vQiQv2oNYTyvIcBkFM2TWRFYcDZo4x66RssvuQi4tbZQYluvYkwpk2XjRuM
         RiyOKQQHweJ5ID8kku1F7sznTWjcANcdRSGCs3rfgWV5h/ww9OlA4ZnEdZXnBtkIXJyQ
         drjRvDlUNKSUQTTJ+tZbeqEX+4DllvkBOZztBFBPhjkkI2S5Y0Nty23uAueuaUasxhAj
         sx0Ub8CnbyyJVNaJkHXia/tX7Wk6HhK8KQmU3AzGCuGVfmM1In7KJrc9BUotilLA3tRU
         fzmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828877; x=1794433677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+31zDwDEoLs4QM7Pb7x038H+Xf6pdgj780CAMYuu12s=;
        b=LqsN7H3kz82QkFSv2j7+VEhQoVmsXuq50miMRUq85EzNxfujUvhUwhp8Tb7OtcZxuq
         KsID5LCknRfBXAC1i0Z1o/gxAjUd/cQPt9yfRAEXWcUu69v4fBpFt355hTDKUZaG620C
         KREqYFwyNxaXdLQ1zpDTw3rR5olnq/RCRQ9ChtjiKtYcAHD67Qb7BI4i5REzLI9lX6G2
         ps00IPai8BnX/ZRnMxp+o1H+V2axFZHiirOTgMLLb8GXbWZQ0qVeCHgtpVwlSW5klkrA
         3GYKDkw3fKMorPYpJdgUc+/6+Yy9Xw4PGV+e0+Lzs7K8rx+Q6aFW3LTSJ3mp3pJtyCOC
         ecSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828877; x=1794433677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+31zDwDEoLs4QM7Pb7x038H+Xf6pdgj780CAMYuu12s=;
        b=FZpV68URtmdZkhss9OTqzSRANXwgAJfV/4a9R9xCHyK0b10RX/NB+6YRaMMVzWCmPa
         LR7oSYY+4DAUrTRIXg2X/mmZvPII47hiaWpZSTNpEA/dgba8GC21S0IkyjI8poH/bOOs
         rg025iDcEa/KEqZ5748efEg0pXeqBG9totG4QrmhzFBc7wZ8u4uWexCZnL2XlfspIdRC
         Yvo9MvjLg64EqWXP7NEEV4xKaVBgA3QkvLlr+gQ1bXjYi+7FhzdMaXxyr8fZD+wMUJEQ
         K2jKJ9D9Mac5A+G0zA28OrTstYWY9q2IKLvvstEungxDh2fxfKSNSqHUUugAUEHwz8yt
         P4AA==
X-Gm-Message-State: APuU4Z/MruHDVB0LL6UQPH+TRONgiapEeH1qaJ53kDMRNbv+zjmkcVXH
	oTuPoWtCoxhYJqF6ykJCENjEuus6QwO8PqlDSG9UjabG7cSgLlk7AhUwcXvC2nRilHTgC/dlzMl
	MSFU7GV6nswkC8TQQLUIwQT0N5T8NvroMOvp2GeDd
X-Gm-Gg: AYBFou2nKEtqUn7PhZZ+u2CvxSncPzGiZ++r1PBcFaFiQvC3w3DEvd37OcqAKF8zAU2
	6W1d9UL6eguZu2w5ZWr0wNg9S/RI98QybBfeN9wdkHlMUSFTpS3SlMNihV05gdjDsLGGURHtEan
	eBpK9gtuh4R1sU/b/nBWp+pCuwhulQpU8t8LKG4o5LFANVPJgvaZ4bR6QiJ4vQGoSWekyd193Q8
	rj+7vwbVz/OV4IPOSdHRKJh6oSqEA/zmL4B81dZON629Vy0XnD12xoQQJjgNUpEtQUBZd6pAZPh
	C2+lg84oOsiDg92cACmtxH93H2iIitWfz+dc+6AsfXq9Gf8MpQKK/MPT+EKlNlrDGuGnUbqCb6M
	RwXXqAN4A+OCoeGHWhgQ9cOAeVMD4EgnFN7i5kqM9s0f2GlrBDjlKgpxi62V48i/FJ0dakFoGzW
	cPZxGX4AddZTLphUlE12jyELNXMyIC/WoY5fDQW4h8LZ0=
X-Received: by 2002:a17:903:32d0:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2ed25b46b2fmr1284195ad.1.1793828876060; Wed, 04 Nov 2026
 13:47:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-2-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-2-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:18 +0100
X-Gm-Features: AclHuK8OoZ-U7dOb9grdzCYOCDBZBZzqqHG5Adn8etCWJNP9SSN1JAx-Rjqax2A
Message-ID: <CAG48ez1F4uJLLUJsOOf_wchiLsKoEQ0udv2m+K8_joGHW-4h-Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] proc: add helpers for files that outlive an execve()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Some files in /proc/<pid> check access to the task when they are opened
> but look at the task whenever they are read. Such a file keeps working
> after the task has executed a set-user-ID program and then shows the
> state of a program that its opener has no access to.
>
> Checking again with the credentials of the reader on every read would
> break readers for which nothing changed, e.g. a reader that dropped its
> privileges after it opened the file or that got the file from a more
> privileged process. And it turns a privileged reader into a confused
> deputy. An unprivileged opener hands the file to a set-user-ID program,
> e.g. as stdin, and that program reads what its opener isn't allowed to
> see.
>
> So go by the opener and only once the program has changed:
>
> - proc_exec_id_open() remembers the task's ->self_exec_id when the file
>   is opened. The permission check of the open may have seen the previous
>   program so it's repeated with exec_update_lock held.
>
> - proc_exec_id_lock() takes exec_update_lock for reading and compares.
>   If the task executed another program since, the file only keeps
>   working if its opener would be allowed to open it now. If so, the file
>   is as good as opened again and we remember the new program.
>
> The task's own threads take no lock. de_thread() waits until all threads
> but the one that calls execve() are gone before exec_update_lock is
> taken so they can't see the program change. That's /proc/self, i.e.
> nearly all users.
>
> No user yet.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

This makes sense to me. Accessing tasks through procfs will probably
always be at least a bit icky, but I think this is pretty good.

(You could change `if (!same_thread_group(task, current))` to `if
(IS_ENABLED(CONFIG_PROVE_LOCKING) || !same_thread_group(task,
current))` to increase lockdep's chances of potentially finding
deadlocks involving exec_update_lock, but I'm not sure if that would
make sense.)

Reviewed-by: Jann Horn <jannh@google.com>
