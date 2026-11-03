Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793739492;
	b=wp+tq/Fc5sE2v2dHv7yXRqR6hCgtKkgKRqEiVvm+wdTeCWAPKrsPO3wzUkhHvFXLft1G
	 g7JMTxx3Fz3XVGd4ioGf2Pb5Aoabw9kAItLnWsMIr4/ttiJzocSu7bqeBCzxpCJZN3cXi
	 f2DdK3flPVYuvrojyANdxZCF8kxcP1gl9PkLID6OOsN5KIH+vq9+VD4EwaPbjpBCpOgqN
	 Vp+OW9F8tCSGth+ZcvOZRzfnzCBoDkvfd/0e3DuIfnuFZYKm/QeR+IUqCnUv4nztvaZch
	 ILqdZ1Lbq/u9OajP4j608KGaPNJgLP0wmkQ8tKZ7flv+XBjHBRGN/vMJVKDhbNTrfrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
	b=H1ItKVAr3YBC5HzKFsINepfaWaF0OgrLXMKsHpYUq7/P8XS6a3h2sQKn46xnBkkcGVsh
	 MQnYh6ssE6w+NsskIDtzU3XIyqyUrGPvOHPKFFnGy8UdkUo3xzNTfRLXzarqajziXaHpz
	 3Py/WoG6Niti9eOtx0WJJgXTaqes+u9MnftkGXdLKWYMyhbGnmhNOP4OPO0f9qEUMAkEg
	 ak/7lz9lX5HutdyQ807Py+SMnF81wwO+2fkN0AjvlcFLBQBLzPmmE8XSutcGsjHwuMmwd
	 wACdZOWSmGYYEumF31mFnxCN8CAIvrelSy/grDFmPDc+WzWCuq+/Xfvf/3Jf4SVIHiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7;
	arc=fail smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A8606A326
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d1114320so36642235ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 12:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739491; cv=none;
        d=google.com; s=arc-20260327;
        b=hO2Lp92SSICuYUFEhW2+07JdIGKT1Xdo4eUEe3sr1XNUyY8G/t3FIsh6cvCUO/UL68
         BY41Bjte8cMqm2PjG04WPPJOi8BmviV3gcs8mKi4QXNSaQ/IG62vSb6Xm70uk8voJnT8
         GZLMEDJYoDJW8hqc9r82FMq0V9vXKWtlU6a8gcwkhPPioJP0hZM/al6xbjsP3Jom0xny
         5kRimb4GPacHwrzmviFXsdIOmmW4HxmsN0vEZ3Sxe4XIiihi/UK7YwVog/07ZFWg+Dn7
         ahssBXJotJzorbsR+FOnE0vTRJ3WYsOjxbg/sFAwAzNa/N3k1POzm3qKCqEPO9ntB6YM
         6Hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        fh=LNrw+lc4wIgMVJiATF9uquGLcbiqd6r0C1zSsRn7ZHA=;
        b=Wf1r1Y0M7CMRk7v7yzO22hJBfdzbvtG94JpQcZG9Ak4bSleJoFYWfCtAFfCq5l8MU1
         M39VatMppdZIxEZKkxhNJ4kAPjsVKL3nQUEsq9SX6WWsGESmiC3gVFVTQZYVVQVb/7Kz
         gQaTrc4BQVC1f6EgbA3ETbnUZKURfbf9hsLNkb/hYstdIAQ2XPKPPM+l3ZbfjCDLhEKF
         7jh9ca9Aec2O+ayPg/a/ymjivj2eMbEbsyJtRzv/3D/Gi4s1BGZlALNj8xX933Vl7Mr5
         7+veMVZxJYfhVxUZavsGnthJcdilTa/4kLxgKf0pgw+l/w6tq1MlBxFCM7/YLewYeLJb
         RRuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793739491; x=1794344291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=gNjU0kU7sM8uH5XC2H7b99i0TvtIF03FfKAOB0NH5+8azPBEMvKw0LopoHo9aDtdiz
         VDyjVtVrUAN//DSQQ5olLEEOAjJMZhga8ZmFPcbKfD2Ft577yKe7V/QcHq6FX9oHF/yn
         3bCew/1NgBdXPqXDNjd/pB+bgpfklJXpLzQeRdEu1INssd8arH3ktroB3iBaNXq5+ufX
         l8KdXY9cOuOdz7Ack0IyhbVI7+narclszD/zONZH/1ebAaSxDxVSg3gNl50MRCwl0e2m
         B4k3pyP+iT+yfzugI1Wl73+2lNHj1HV2Ub4A50Y+lzMd9mZvMR/+dyBS5pq+lnHK5qZV
         pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739491; x=1794344291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=ykMSTrZ66GkCETcRDTGBD2k4scmJ0sdrntms2hj3wnqS7DG+4VPP9QFktmcOOpC8WG
         mKpFA06tOUzr8MXYiT8NZ25/riOEqhhesf0R6wUlq+mgSexm7y1hOEiYIp9GJEdAXfgK
         gu/nYJl45rryxGE7Akt+8rE4TvgiwghGpQhKYwoDwQN3ShRJ2Ehkd5vD6ZaFQIXpRqF6
         q8Nogmczn9NwPixPaHk0pwfwO9ycKRdSe/J+sV2MqQ1hhFkt6Z5T/R8RDRqjheARyoiA
         6y/gt2FC0aK4qdSrRCoSsC2PTnPMts53p2bDNtrMVOyJPeM0OjMv5xTS1WWpNgWzmL0i
         j78A==
X-Forwarded-Encrypted: i=1; AKwUvByuoy47e+DQoQne0qcTW+JJ2COoUpuR2/D38OVBJynC6W0jT0wLoQTWXvRPXZ4j9iFT74b5qlztBylVSYII@vger.kernel.org
X-Gm-Message-State: APuU4Z8dMa/a1fgqIPw1Rf571g3v3VfCmA9TW3bSdukR5jEuHJLWgCLm
	+cgDfJiCHS8tGzcnaXDaUq7KkmUzmlBqSzOBCxqS0uFUnxDxaUpqUw2FB+xOy0UsMjC7UVZ6Gg+
	gUZc8tehhQt5eUKpcDJLXCMUUeiByqRwhQznBYTuV
X-Gm-Gg: AYBFou06DJy3l+rDbUPIXtGafr/1aJiP3VWPi/huyXboRIipJENJ5Jiq/j7zr+osHn9
	o+ywVUKRkxjhNwY4d9pyo3kQLN6K96o1cEagLdj6ggk6hZ3k97Hu2/In8li76+PsSKSiaxCsrRS
	cNJ9a8OjBgxoy5FoRPAuk6ImZcLY1KuXAKrEHMe5RfulY/74jwE0SC7D9oSQEh9D7DcveXeqlAS
	6R/pfBJ5mQJnPuUw00LBztJkoAvxaLz8pIL1pB+QpS2M20Pr1DqvkdOCyV4JgurXn1A0mzHbF3R
	eBYWXljN187vosQ5m5YNx2dly0wsID6cXVk2mGRYXEBzOFpqcp+n1nD/i6jm50dor5tx6jRK7MB
	LcAOpt0BgsOKXvFdAASASyFBnEs3lx5JepN3ykkIQM/fY2EEH9DWeLRvMVsGwnrs66tJr
X-Received: by 2002:a17:902:ce81:b0:2e5:cb1f:898c with SMTP id
 d9443c01a7336-2eb364ed0f9mr139787525ad.46.1793739491564; Tue, 03 Nov 2026
 12:58:11 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com> <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
In-Reply-To: <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 15:57:59 -0500
X-Gm-Features: AclHuK_j1m1BaQJmY5Z4xSDq4UylbUple31snnL4So3-rHmuEym2QzQD59EuRAE
Message-ID: <CAHC9VhQzeCgCx9mi6pvbQKLH=P8b-o6JuxeUo0QfyebVGPdXGQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
To: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com, neganhat@gmail.com, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:18=E2=80=AFPM DRIF ABDELMALEK MOHAMED SAID
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> Hello,
> Just following up on this patch to see if anyone has had a chance to
> review it or if any changes are needed since we're at 7.4-rc1.
> Thanks,
> Drif Abdelmalek Mohamed Said

[CC'ing the audit list]

Not yet, but it is in my queue.  Regardless, thank you for the report
and the patch!

--=20
paul-moore.com
