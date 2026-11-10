Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322304;
	b=PCLX2euoFXFy9ivRU4suD75hHditfp+9D0QdWKwQfNzUtcPk7weVwCqhXDD0XNpy9XQz
	 AIViYxJZSqXxTJQWeB6XAEkKPFVO1FKZ90DvKWdGaGQLg7Eb+eDiVcYHe+s78o7VbYR9G
	 JCUxBMQHxMGpySJWsAsf4yb6f1IX18HK+X9MlsDnPigrEJppV9jXnUJaeKGFYpBESmcAi
	 3X5/MPImjTMT88nlagQJOMqB9IwQYNbRJLxWn9C2e7J7MJfkQCMbCE6pOWSnEpMwolIn4
	 yBKjD2n3XdUpEC7++DHjK0j8B1gQuuUAnXePoK454svgqEOEhvDHBK/CCW8ACIBa2yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
	b=LK4nfax+Hg9WEwNXQEnyfsYFzl9FbCjiro5v0sQgP16uBHM2EhRdt0Gfqu//j4xrvRHc
	 rP4agIL2jL5rDGAmrZRnuj/edfdC5ZMf1hqYYNtCyKFuuP51mM62m67UZEcz2W/zkdK50
	 zprgTEZwOmRaeFNi8fHsBvYq4dwD6HGJFnizYs/C7arp3BTpwY4+MPqum0hx81U3gEXdX
	 9fiyFw24qrGmOoMoWDuHKTxGUJD2DbxADb+rgD906QSn5T6RjUQnnmoumCTKXlcNZ0iwj
	 GZ9TXNtlSC+Y66JvXQKsLqa8vcuSUcSY5EBfJ5FH6J/m9BhJW5cw7DavWzciYt4n8aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85E606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E85E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso1101959a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794322303; cv=none;
        d=google.com; s=arc-20260327;
        b=aofhI22weVIBntVKQlpdDiZEXXd+c04hCrf+WfLoMPV1hH/HJ24mG2+DfUxJWRTnYG
         qse5qtLx6DlKZ7PCVbfDYQOHpbEaEChL8Je2Q8znLuQ9nOLfcJbkAyrE6dV73nBGUp2H
         r4j/s2AgBvxDIY3QXiChnYif7xTkNjoxZdNPq81Hc+/BemHfonOVEn+K+T5ZVO4Nisk/
         1l3BQh5lgo93SFZw1C2VBH6pC7rAYJLRosWMti2f3cyeGIDaca758+NNwBhi6hkvgAtp
         ZkY6CavPOeijh1I5OG/WNy5U1F3g4HTf2qMxr04GB2OXVwmtGWWrVW8tdk74NtQHWcy1
         NaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        fh=uTpibHH/rTUkKZD8f0UYpFQjGpfXp/g9E/adUZbYDpU=;
        b=hoJ0MKVDeY7r7R/VAU/8J3i+w69vt8kq/irQd4eEjvBEqcCh/p+chJ8FAdsNRIq332
         7Nz/uyAq6KpKyRc6oNJ8i+Dgxrohxj4Prw9fjMbJJ7gM97Jw8zRt71QGb8PM/FnhSwo4
         1VAbQaLXn2itf0ol3svZtFOvEhbPxys3f8VzxTdFUFoC6IwARbax3RAcWBE1b20DXx0d
         CQ10ymGPljIhZT5sgtC0lqhj+q2mkC0Y3u8yg0FUs/bgva0pNB0j9+gak02k3zKopJNw
         TtUcSYYiOrnouqustzU9iMlDCbGhyKUCQ/ufFIzItb/g+uz9JkHDE3uAmi26J6RTt32w
         8b0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794322303; x=1794927103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=IL+8xDhWvbsY97lbmrxhet0Jxm/GEejFE1wA+kHdDdoy3r2HY0qfy9+Zo5tDyA1HCU
         92dTAWSC18xJKt+nqY3o9ZEOwugPfnvfyKVxgXTJccL+yGQZq3uA5w6FcKOdBgNjQCVS
         07UkwU1Ush9oWU9aQSyczjXfKDIKK13bz1vvPKKKZnAAbDJNUxO90oBj9mzTVwalm6uJ
         MzZxNoOFc+uElONJCp/htKG7NEjYziL9FbA761f4NJZqOMyMijk6azV7Si9VVAUAXV+J
         Tep1WbavDGNkRYBusn+me12VrKAKvlJoaba+qozCGl1bDCWa2Ghni1rfY8UzwuCjm2U4
         /4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322303; x=1794927103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=d/6TelXuH2vZgHMBnU9G8DSeslTiIxd6llVxKIOJzEQzNeQVJ4QiolkYlXZznlmucJ
         ywG8nTLWEH56EvS6n1dni7DUWJYcw7OkPqGuso9BP6z3bSgsD5zT7AwXXjjg51fcnr/h
         ah1IX/OB0lUTj8QX3KfWGcT7asDqT7JMhh+Ekkucqp3pzEzE12zJFs4jNPN8zPgB7b08
         BYSMOB2FJC38cJFwm3ZHHxkiclE9gE9JRAiwhUC/SF2tNjI6eMElFclpnSRxPqOjm4S1
         htNAzF2yiUykJIuGxdtNq/+tckJz3Kfkv2nhNHon0FZDRFk89MPVcrNRYoxL5/p24AhT
         oiRA==
X-Forwarded-Encrypted: i=1; AL+hErHnM7kUw8huWYf8Gu5Zk4qTohPn0uuoz8QbKYaegb5/8P8nrqzRLBagFOnoPmgT+X+mYLAKyqY1SupgjzTF@vger.kernel.org
X-Gm-Message-State: APuU4Z+ayvopL5dINPzlwDfQPt/SyN8lzAave1tZOl5tSXLbd6C2or8X
	XyWopvSWJDdSrkvp8JNdnmupIzxgNtZY7FuB2kkawqGasuTVz0wOAhTYwuofg/8u0fb7cY65p2T
	dCz6ZH6VvAkynFVYkHJufQDC6tsKDIcPsbOGpkIRH
X-Gm-Gg: AYBFou2ookAPJ1w4R88taqDE7TNbKI3RnSPH5+t29Q5uzqOszZFboIA2JvQ7BcdSNfe
	Q1e/Z4CGQ0fSMZJVSpEWWbht8OW0TvX6SIjAIeH0iMszJXS00Xi/GXRXt7t5+jap2blZ0ejzxTz
	TsHIzuZijh4dgH+SA7nX8Jlo6Y8vGeltMcqXGkXEz9MnxzUUppJLUAOknHZwGPsBMziDJf/5xmN
	WYl1K359Na2x4af2nQYMDaLIvoK/fg5Pwqk4rcdVyF0eqB/fpAXbCjmEz66KBuJQg4W9wAtHUhN
	dJV+nSdv0xufsXVylVllRvVxjM991wuz73MBZdiwfuRcxuH99WfA6b0g2X20SAqiKcGhRSjuIYE
	GcyOyu+SDwWbW+4esgqTR3hGzvgokZt8ehxI1OKO4lYp5hCXhP9bj+YSchX5xGqdxqxyf
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3b166cd4924mr2650628a91.19.1794322302909; Tue, 10 Nov 2026
 06:51:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144205.2404088-1-mic@digikod.net>
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Nov 2026 09:51:31 -0500
X-Gm-Features: AclHuK9azAwCWCYb7rf35P_Qkz1YTwRFSpYVlH2tFTGhGa4I1jRp_1554UKlQOk
Message-ID: <CAHC9VhQ7xMe8J+wRYK98Lw-Ff8dg=wJNEWgJp-MOqFixeZkiZQ@mail.gmail.com>
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
>
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
>
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
>
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> This is independent from Josef Bacik's series, which reworks this code
> to close other ways around the CAP_SETFCAP rule:
> https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@tox=
icpanda.com
>
> That series still computes the creator's CAP_SETFCAP with cap_capable()
> and cap_raised() in cap_setfcap_level(), so it would need the same
> change.
> ---
>  include/linux/user_namespace.h | 5 +++--
>  kernel/user_namespace.c        | 8 +++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Looks reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
