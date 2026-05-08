Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61571CA45
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265307; cv=none; b=CBT3b0BvI0iE2hf5DiX+SlKm8KcH/4EXkMr/CKc+6iYANti4cHFDAg9LVaPbk3+LZzdCLhX8bFy5YgHnxvjK2YCslwq+n63X2dxHMC+Sqru3VX+/kbtSE8oVR3fvtehPLlrzjF/mETKp+esqaim1WYaX1R9ULYDg0Dpahkf/NGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265307; c=relaxed/simple;
	bh=OUZacp45w98YJHGKOLJGm4HOGdhWjF41MDKyrUuBm2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPxuIXe+6xdaj8jyjZNPdc+lh3V3gvKD9ogxTG/R1DT7n0ByX6pwv7TLe84m3e2aXsKQpnddP6CddP90XkXANYFeKKmWnZnjEHiCpsjYfBgC4UjzxsyFgfE4yxdEXXnEK7mtC3ZGCisUjuxAgSMCfLE6tLCHW53B3DFBKCsl9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu7SFHAE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3mn86Rq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu7SFHAE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3mn86Rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778265305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqLA6ZONkIM63m2uDBENIVcECW9JDyPbQRxmMotUYzw=;
	b=Pu7SFHAEF577Fc0iEEta00js2uLk0yuNIFFm5Izr+gj0pG0oJnEZj5RB/tj3YyWev1TvJP
	z+9YsUC/9ZgaPDU08i90AnrFpzhVYAH8gUYitEbg9AuxMMPeosR+0/Epm82nX/8x7uAq5a
	C+aBW3nNv78OpwZXlgbwmCToLTMWp1c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4cGEP2IlNb2iNSZcxplArg-1; Fri, 08 May 2026 14:35:03 -0400
X-MC-Unique: 4cGEP2IlNb2iNSZcxplArg-1
X-Mimecast-MFC-AGG-ID: 4cGEP2IlNb2iNSZcxplArg_1778265303
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bf14e33f72so35071707b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778265303; x=1778870103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qqLA6ZONkIM63m2uDBENIVcECW9JDyPbQRxmMotUYzw=;
        b=K3mn86RqncAhDxQpBNUWcvaWU8IA1kbtU72wEF+V85zR6SoULJt7/iPBFKQeFo4i/T
         Ok30yidMEQ41a9cQMh1tFpNnYrqvq2uYXIhi79djc5KzUd2iFOLgtEhBVPSWKigsCK+F
         3GRIu+uP03m30zWc+shatrJcjm5fkp1sL9onfmtDud6QB9ZcCwH47ElRA+SYvNd7MGNw
         xJ6sBU/zjRbyd7/EPujNLWzWx01k3Z7pLTW9ZOP8ajuNW6mETFcCpzsJqvaIo+fNJxTo
         /UoPxL6ezzoXhNjAbFL7KWlmCEM4lkKctrLPS0/nUIxFYYc9QTYH8sxsViilf1PdjcxH
         0pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778265303; x=1778870103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqLA6ZONkIM63m2uDBENIVcECW9JDyPbQRxmMotUYzw=;
        b=FFV9pBD7RfzW7QrvbJsw0w0dvlR1miaNL3Po7JfDnb1vRhrTCgLcdjARsBFIRYiunj
         4NquCm9O0yxkSNT+sIJ8J29SRJeO2NKEz3kd8hXFQQQ8UMcxTsguN1aiDBuJXxXbOK3h
         jZ9UjTJzW83jZjVIme0Lp/d1xyrxQUleim8xIerj40IwczAhNK+E5PyfpBlJZn2UuOms
         u2z/vnYn+8hD735+SzcZpEp/oTvtf+i99avuBR8PsJTseJpynE2TSifUc4ptGLlqY7OZ
         Om2WVGhOu8EoyWrV2YmiiNShNlu3fe0Rr0+MqVMU8luZ9ihHa8TvZVx0e5Idm6GWBO4d
         v/Ug==
X-Forwarded-Encrypted: i=1; AFNElJ+KotVPSY0gyoQkY1eRlbVwAwvawEpac67oQceGIf5AwBDsnph2eyC2+Vtda1M3pBeeh6wuWLe0hhdc7eJz@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXXh/YiG2MSxOV98eE9QKxqyK1n4A/eEakqmO5RyBKa2NlMzv
	MBdTTZ+bRz6KWqjixP0tPKuK2RVSKV4pDhf8SSRQRhv2Cl5cv7jllx2b5O1drI98xQstmsrxYVR
	N992nDf/s7ZYzkqTEwfpTodV7c2BEZk50d3bGIt9tod6aGnHDU+xhEPbGePt01L4Nl40=
X-Gm-Gg: Acq92OFhC4zjUthOiWeDJTWZbsLnpUYPO0ttSGh5d0epoEV1Al8s8xwgYJDgC7GUjHJ
	nEVOF3aCxUdMA/Sv8mf3b5K+4Gyv4kXn7pb8ucUU4xp7/+mgNi5+Pf9rlJJuTE8B2O1IgFoIbo9
	c76sDvCJLZlf9kdDBzV5U64pLdGuyV62DhJH28aX9XDfomtdE5EGlhFP5JDdAVD6NG/FddDMXji
	IsmxNk/X1Yg/GqC56jqwPjfPciDWcIEYFCYZse8owckvc9qV2MgEc8O+e0znIHQ0M4YN/AttbB8
	MeO1vIbnW7Lb4e8Mfn+HYiydjsXDII6l22HwDwe739/rzBbDOOOIBxPtu2JMcJzCZ1725jOHSi9
	4L/HMT0SEiMcqDWfJjlHD607/sUwU1BGNxc5sO/3CxEp/vjhocwqP
X-Received: by 2002:a05:690c:399:b0:7bf:245:9295 with SMTP id 00721157ae682-7bfb9e909edmr32826277b3.40.1778265302968;
        Fri, 08 May 2026 11:35:02 -0700 (PDT)
X-Received: by 2002:a05:690c:399:b0:7bf:245:9295 with SMTP id 00721157ae682-7bfb9e909edmr32825957b3.40.1778265302471;
        Fri, 08 May 2026 11:35:02 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm110617857b3.11.2026.05.08.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:35:01 -0700 (PDT)
Message-ID: <fb80f5422bfddf6397bc2db660ca0849f67c42d5.camel@redhat.com>
Subject: Re: [RFC PATCH 4/6] hfs: Move long delayed work on
 system_dfl_long_wq
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 08 May 2026 11:34:59 -0700
In-Reply-To: <20260508134541.282073-5-marco.crivellari@suse.com>
References: <20260508134541.282073-1-marco.crivellari@suse.com>
	 <20260508134541.282073-5-marco.crivellari@suse.com>
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
> Cc: John Paul Adrian Glaubitz
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  fs/hfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a4f2a2bfa6d3..cf4e7a6112e7 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -82,7 +82,7 @@ void hfs_mark_mdb_dirty(struct super_block *sb)
>  	spin_lock(&sbi->work_lock);
>  	if (!sbi->work_queued) {
>  		delay =3D msecs_to_jiffies(dirty_writeback_interval * 10);
> -		queue_delayed_work(system_long_wq, &sbi->mdb_work, delay);
> +		queue_delayed_work(system_dfl_long_wq, &sbi->mdb_work, delay);
>  		sbi->work_queued =3D 1;
>  	}
>  	spin_unlock(&sbi->work_lock);

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

