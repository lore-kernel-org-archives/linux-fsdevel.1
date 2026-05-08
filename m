Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE392282F38
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265282; cv=none; b=jt9k0PB0kf4Zm7Jp4seC0r2kbQ8E1hU5fX2FCoWE14ppc082JNxDgp5k+0MbiSWHDqQM5WW9Xr5a0oXtTthcyaJADeoHpfMtuuYvNzxDnMSpTL88VpE9udWu7hnazs9V4vaT5BbT5EfovZT3Is+URwoKBgg3yg8Cui7DIpbPLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265282; c=relaxed/simple;
	bh=Az3Abzg9R9ixrk3fY4KPoOpV0NHjSjdIGPubJ5jAWhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GywIT/sGUEfmQKjQ3E8VZsVCM7GLli8WPJ6AJzYLoNrW13WJ9Xs4WUE59m6dfYvNHwDh4N+j7S12BxX+TPBSeG5j/AK69swqlChMxbUftrKQm/trwhAh6znhPkczP92fKHQjlkEs4GTLbfFd8N4W/iP8kOyzpkY2L4wlmr2AC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl4oFOpp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kIOed2y8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl4oFOpp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kIOed2y8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778265279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvnRK4XNgcB63eQHvn6GGJzkZT1HVPdz91PsqehdImw=;
	b=cl4oFOppJDZ5VTpfCm4lqNMmMplvsWplEX3lD2ysHDkhQDokqexePLjMG7bnW6SpdIhyHV
	1Tjy8v7VzpCr/dCEVNHKobswhABb/s3G7Fcv5GYMkF4KMkfMPvKxG/reUJopNFga8NP76m
	bPWkR3ctTg8KBk2CPJtwO1v70+ZR23Y=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-YpnRls7UN8WAFR64_KkEYg-1; Fri, 08 May 2026 14:34:38 -0400
X-MC-Unique: YpnRls7UN8WAFR64_KkEYg-1
X-Mimecast-MFC-AGG-ID: YpnRls7UN8WAFR64_KkEYg_1778265278
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd726a9569so49442857b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778265278; x=1778870078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvnRK4XNgcB63eQHvn6GGJzkZT1HVPdz91PsqehdImw=;
        b=kIOed2y8Ix2sr4EKtmoGIPd/sSVpPb8TfNAS9bGAmkuLrnGfPoJwuc07KTUIxD3tTF
         Tt8GTs6yaLxYcsYWtznWp9LWRD2Cebi4zI8YJM6PlWVbxyA3OG5oTqe/vb2kT4CV0f0u
         kfL9o6yKbVQEbEmKcpWxPZEJmW+00R7VLk9hrKtxE5vpMUv1wcDxStCaUA80RXxbks7Q
         jB9ogQT6mQTcJle6F4j5cpwxeGjbTpa0Ht/eO+ingALwP6rQT9qTo4i/mF+Uk4+XxHBo
         /rNkZKlG53TbOmmOcAdOt51Q668wamrQJOsqfqCQV6C2GXA5DX1nr3/DVcTHweS8fvsj
         JMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778265278; x=1778870078;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvnRK4XNgcB63eQHvn6GGJzkZT1HVPdz91PsqehdImw=;
        b=cmTgxwgSlZXY78L2FAn0tdLCa6SjP8VHeFa6XzJ2IogktDc2c8BvZhFXEfQvguaEtk
         0lMmS6RdttHEuFLUjJ1F4+cEnBNNpCY7zVSXQebzDHW8i30vbq/JrY1jGJPpuG24hKVb
         11peB4ZIBOfQWuOE7P9x1LSrDvjFdzHeG3j/mPVYNHeal8AxANHtLMZalo58WNEfYcos
         EKsGDSrzU85PsuAnt00Imfs+GyLU9h7p4SgGALRy9/LSwjjoKESmCM8rdgcVm6oplR7Y
         J8VQs/8wU/2F3miWOakxBNKUJaM1fxhItN93KisGtgui8w+H2C5eDkbMDlbGBf/iua92
         a3ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tGlhYShyqcIty0xWjnwSteVcYBUxM/kZE1OamlKU8P97/fqgZMCZH6C521dSKd7y7NZf4G3StlXLx03+O@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRIDX2H1v4aZf2j/IlhrI49OHWqz+qp3rpKwlqEmdyYYSEyEq
	lpftC6rBuz0tkGx8DQZBIIe3/XIdJv6W+NQCDi9udaCdqzN4pmS5SeIMArJidZmolVrmNcun8qX
	xcVGujcwPBNFtyir1bgqgK3rLUFgrIGoYyg8WHN13F7Hi+Ze01sLn7kNAMQDaOYcfdWk=
X-Gm-Gg: Acq92OGBS7YLFS2Jh4d+2MSbNqQc0VgpEcOKZMwV31Mih+cDSJuN6UlhTU+zxkyUlGu
	mzO6gGCFoFJoSidqGotbUdQxwtYJNZWl+s5PTWylH/jQHzFcat0EtHxKMMDznGN8h6teNoblxK1
	VqKio4f5vyF7HmcTnBYhiDI3Rn5Afi1+Z4H1EUfY/NRkqcUWrq0Bb2yKEdD/m3k/QnARZZIXw0/
	iRBG3iguVdbdpkBw6SssCcKWiDaPRewKGqIsa4seP4fRW2IxRLIn3y6LhB5v6y8o43XOxxBbtDT
	dNTGKOVHj3AxhfAuHn4tXfg8hVgaQwxuB3XWDZVv8M/er8o5+VOzo9CS/z+qcoaKUcKcmN1rxt9
	otZf8lYfsKmDgN9prlaOuwj23yBM8I89ucv5dJVO0hGDC21tXsCXp7P1yagdSSD0=
X-Received: by 2002:a05:690c:6b01:b0:79a:2f38:9a8c with SMTP id 00721157ae682-7bdf5dd0bcfmr143719387b3.15.1778265277976;
        Fri, 08 May 2026 11:34:37 -0700 (PDT)
X-Received: by 2002:a05:690c:6b01:b0:79a:2f38:9a8c with SMTP id 00721157ae682-7bdf5dd0bcfmr143718937b3.15.1778265277406;
        Fri, 08 May 2026 11:34:37 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6656d218sm108668767b3.22.2026.05.08.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:34:36 -0700 (PDT)
Message-ID: <8e19e180b64f366b25293bbb1b0f6dfeba506bae.camel@redhat.com>
Subject: Re: [RFC PATCH 3/6] hfsplus: Move long delayed work on
 system_dfl_long_wq
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz	
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 08 May 2026 11:34:34 -0700
In-Reply-To: <20260508134541.282073-4-marco.crivellari@suse.com>
References: <20260508134541.282073-1-marco.crivellari@suse.com>
	 <20260508134541.282073-4-marco.crivellari@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 15:45 +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>=20
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
>=20
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
>=20
> Recently, a new unbound workqueue specific for long running work has
> been added:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0c116737e972e ("workqueue: Add system_dfl_long_wq =
for long unbound works")
>=20
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
>=20
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  fs/hfsplus/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 40a0feda716b..12ba672e13bc 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -314,7 +314,7 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
>  	spin_lock(&sbi->work_lock);
>  	if (!sbi->work_queued) {
>  		delay =3D msecs_to_jiffies(dirty_writeback_interval * 10);
> -		queue_delayed_work(system_long_wq, &sbi->sync_work, delay);
> +		queue_delayed_work(system_dfl_long_wq, &sbi->sync_work, delay);
>  		sbi->work_queued =3D 1;
>  	}
>  	spin_unlock(&sbi->work_lock);

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

