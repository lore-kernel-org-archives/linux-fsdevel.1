Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A55343D72
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588984; cv=none; b=MXUp7nzl71TkF4mKvFeXAEC9a5xPwzjOU9ob235bUNjLv9pNzGzRTBsUgwt9B777KH3RdpoleHNOeHZs8nUG6GjhtMFMo0ZIix3LVhFglnOwXanPb8BQKAGWOxIUwf7ON/9bFftNZoYlQrUk6lQQhImXjAphs6RtnGRv8x5syOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588984; c=relaxed/simple;
	bh=KldhMZJZglDuCvaQF5GEkH50DSqInNOA7+rOoUyEhuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcR1tNBKh8JeJGncNJc6mjcNWhC/OtQPyfTdRTl1J4/PGREJKRGGP6Ms++eLATbiCC1Oh87Qg9ATB3zM3PzXNwxaRx5WDQq0deMkO1Bfv89mg4XHj91uX0h8IICyge9ZfIn13Em85eerK+dP2islzV7xDDXNL3OHAgfLmwEAXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zj6P5ThT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9Gn2Fhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj6P5ThT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9Gn2Fhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775588981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cY6j8JJKi4rsyye8WonH9NWpu6ArSs2Zh6DxQ27AuU=;
	b=Zj6P5ThToLKOjEv/QrqSJXLZu7NhAd/33eP2gGOHauhsIbX0Ta1hpHJ3icBksjL3T4WGH6
	rH9qKbdkSQoEOHeIHp234eelxYoV+S1SklZeZL+7IiIBTq4MltvqbUy4D8q+0RNxHU/WkE
	ww+AW7qmDMIN0rDvezVbOhJnk2NAcmk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Y_lQdl8SO5iNFm1TgRqM-g-1; Tue, 07 Apr 2026 15:09:39 -0400
X-MC-Unique: Y_lQdl8SO5iNFm1TgRqM-g-1
X-Mimecast-MFC-AGG-ID: Y_lQdl8SO5iNFm1TgRqM-g_1775588978
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794b240c0d3so9473027b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775588978; x=1776193778; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5cY6j8JJKi4rsyye8WonH9NWpu6ArSs2Zh6DxQ27AuU=;
        b=R9Gn2Fhbbvprp1CefbluttIADJGLtYDmUvbY/Cf6t23Qcm0NvF+k7R0s+htWpcEPJE
         0i5Df4S960ShE7YMcgPqFb3dbkU78IqYuslJ8iGT1edQtg1mj6ltwNq5x6qWWxQsB6G3
         7X6JJEWtP8e0Z5Ane1FAylHxeFJvnnTGxkbHzOXAbTm9MSiaKVYlvSRtaElhykcWYGRi
         SgIiRJt/6H+MWDP/Kw3HnR16plsa2NlrUlYkAa75fSC/jhQckD7QChR6UYtIoZN+mDtb
         N3lTPEli18Mco5Uppo7qjuNyT3FrctnRnUWq3xOPVMJJgYrn8v8wOiqCi0R6uewLOy+o
         A+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588978; x=1776193778;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cY6j8JJKi4rsyye8WonH9NWpu6ArSs2Zh6DxQ27AuU=;
        b=eyLBPybsXLiVGNWZeqA4p0K6ZY2zDBrQS014tEaMihvM3+WW5EVB7AjXFQtEX077hA
         yGezmjXZjy7akB6Vhrwwuc1ZPOwZ71IJIlYKwm5xcSyMYfRS7Q75iJ4fEu0g4Q+NmShP
         lCO4BzH/VUHXiNJWjIO866ggF3drGRmnTHVKACYOzqNOnoTTSno5lThULOc9xLguDR9/
         QFPu5wtEY1eSnOnQIkWonk7GwlpYQKSpl1kS7stEC01/1Y0J8qfDqNtnwm3ItpAm57lL
         7uzyoAYR0uB9Nr1a4M+/gb7grCg2bodUEraFkvZnDAY6+CsD331i4WXUmm6A/fKVgsz7
         3vAw==
X-Forwarded-Encrypted: i=1; AJvYcCXcBjsv7lf5I59iA+MSUc/U11H5Q7pdyjojiYgEXlidpUo1r+H6FlI7/u2wIAXc9R4aA3Bf7VE3eB8t1kxS@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjStePIKfeUN7KIMY8IS6sqEsvI/ytNbllGO4L63kigAM9fGY
	nJS48WrSZJH1KIVyPVJVhtp+X44ZqsgLC6AblKSSPzkuLyNUS1UfXDrZVs57u1jMOoMIEHiUEvC
	aE05UEuWqbTuvP+Z5DNaXR+Z5xFWdrssO6+wwcxa3dGwo56MHPn3/dNoBiEhcMPB4VLQ=
X-Gm-Gg: AeBDievP0SvvIaD22u4irML/KGNdNalxmc4WWSTiTcwefo7R9b2RWHT3JRjoeC4HsCR
	empPNvW+5NWQ7v5D76eTVNKH9lFcxqRmIQ4rVEj59LnZNAAcFDP/gZ6819Ps9lSn8GptHb6Yrys
	+4nlC6hW/lb1yzzt60DaPXf5dUE2Dxf4iraRFAqt1IeqvrlUlqmbL7FOfVbgspdlJx2sqEJH5ZN
	nxBWhMr+ARdOCnPhnGb4/g1hg34yNaMxJuXZXQAqkGm37yKzsN7/yb0AyMy+CeLhfNUQ+hDRsgd
	/jjONLbAJgKIec59Y5Fajm6LvpW1rzNFUjpeNUXe0OFqohHkhcJTj/u3ieKWxnimAheEZbrsL6N
	2jPp2V5ghOsa+8exQg9NjzWfEE0Ah1Fzmly5dn1tXIOIBkRqoLPEQ
X-Received: by 2002:a05:690c:d8d:b0:7a2:ce0e:8650 with SMTP id 00721157ae682-7a4e0e714a5mr135175687b3.14.1775588978535;
        Tue, 07 Apr 2026 12:09:38 -0700 (PDT)
X-Received: by 2002:a05:690c:d8d:b0:7a2:ce0e:8650 with SMTP id 00721157ae682-7a4e0e714a5mr135175327b3.14.1775588978059;
        Tue, 07 Apr 2026 12:09:38 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370901513sm74323227b3.29.2026.04.07.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:09:37 -0700 (PDT)
Message-ID: <3ff1e4325290afb15443b7542508f58716f9c821.camel@redhat.com>
Subject: Re: [PATCH 0/1] hfsplus: optimize b-tree node allocation with
 next-fit strategy
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Tue, 07 Apr 2026 12:09:36 -0700
In-Reply-To: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
References: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-06 at 11:00 +0530, Kalpan Jani wrote:
> Hi all,
>=20
> This is a follow-up to the b-tree allocator corruption fix series [1],
> implementing the allocator optimization discussed during v4 review [2].
>=20
> Currently, hfs_bmap_alloc() performs a first-fit linear scan starting
> from bit 0 on every call, rescanning already-used regions at the front
> of the bitmap. This patch converts it to a next-fit allocator by caching
> the last successful allocation position in an in-core alloc_hint field.
>=20
> Key changes:
> - Allocation starts from alloc_hint and wraps around if needed.
> - The seek to the target map node uses the hfs_bmap_get_map_page() API
>   introduced in [1] for node-type validation and offset checking.
> - Map chain extension (hfs_bmap_new_bmap) is checked before wrap-around,
>   so nodes reserved by hfs_bmap_reserve() are always reachable.
> - hfs_bmap_free() pulls alloc_hint back when a freed node is below the
>   current hint.
> - No on-disk format changes.
>=20
> Based on the for-next branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
>=20
> Testing:
> - Custom stress tests covering sequential allocation, interleaved
>   alloc/free, ENOSPC on small images, and remount reset
> - No HFS+ warnings or errors in kernel logs
>=20
> [1] https://lore.kernel.org/all/20260318073834.462702-1-shardul.b@mpirics=
oftware.com/
> [2] https://lore.kernel.org/all/7194aa49efdb85c7cfc9578f1460aaa9a1c67095.=
camel@mpiricsoftware.com/
>=20
> Kalpan Jani (1):
>   hfsplus: switch hfs_bmap_alloc() to next-fit allocation using
>     alloc_hint
>=20
>  fs/hfsplus/btree.c      | 114 +++++++++++++++++++++++++++++++++++-----
>  fs/hfsplus/hfsplus_fs.h |   1 +
>  2 files changed, 101 insertions(+), 14 deletions(-)
>=20
> --
> 2.34.1
>=20

If it's only one patch, then cover letter is not really necessary.

Thanks,
Slava.

