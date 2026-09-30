Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34450C2A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777700; cv=pass; b=EIVmbx9VZ93XzSsVtquDePoCKRWCKbYFgzsNICc+I2TscR2QpG0aX3ELcVumLXFEMz10dAKhDbANkzkqClA4BG/V1DSPpp3kqtBZpNBKaXJFsEia0diAWVaLnTafa6AT49AKHznjyaJqWDA8m8RVWzW/mebLogxIHdXFxhgyIgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777700; c=relaxed/simple;
	bh=yWUA/YODHxMjqJx73askjMcOKak0s3NIoiuAVvUzH0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNpv8yLCfB0ivlSFILZSnl8dfHgzSRANnGA3V2bLn6CYgdnsGlS0ksXKmYULMgBjdS2Icf6RXx9LULX6bIG2nzusFafNd4+yG/wio2PjvOBd5HU9a22woHGVjwgHXkNi/KxgE4+jGpTLT9TR5xddcQQiyPrgQIpCAbbiaC1q/k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhCXzL3u; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhCXzL3u"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-533245fd18dso35541001cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790777683; cv=none;
        d=google.com; s=arc-20260327;
        b=pqSXz1wFrsbhKRwMNo/GLN+Km5Rm4cuR9p0N9PfwO/KfCRmcVJVSIZzA6xAvKF18Rx
         159t6vJzsKxRJ6zAbqBI02lrxNczigiWw0qjv8jeJVWMPITapFC9WC2rioPmQLig/Gyu
         l67vd9YrxKA1NgH6kEJhBAik8g+sUHYzZyhOX+BAuW1shX1EfpaoOnSUJUJ3Y3QVAMq3
         XGUx7L/Y2iDKYgCw5wzj7eySDYgmFUOe7M21Gm7Toi3SUbTPpfy0Soy7cvcMzz5SMQcO
         jS32E9lJTzOwtLVwrnXD/IWjVPKIJZ6cpc9r5GC2mtPkCloqq2R3C+LUxe9c6IyN/6HT
         9Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84hi0KLemhvCKROz+CWHoR2XWSCpwJ13uJIUk3gWxUE=;
        fh=UiWvcvI+fHaQimgzOqJDTyoKooyMKPMJHMgTHUEOfwE=;
        b=jDCKI4Pvb3M0VjrF3YFz8VSAO3cZOldF7HgfBFPtajHs4KEfVHh7iEEBriH789LfyM
         jxtFXih865HMlsTb9awop6nWPubq2OLHFcwSBRBT+Q/r0s2+qnEf/A2DScFOzzZSCmXW
         mnRAMLQbXV+EWjgwl2VCuscvkZwKJgrvZaqupdO9P1+5menlI1WZPuAbmHpSSLC9ni9k
         LYHn9p2i9EK/sEvUQKWSAYKSh+t1xAs8lgBMJhvU/iUOhgUuN2NAjCYSq9JjXx5gdLw4
         NDn3DVg8rlpweOJCpcKd98QZrtSIHVFyczcl7yf8Wj/mT4QUvDWIKCdtzHRB/5wAL8Jg
         UFGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777683; x=1791382483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=84hi0KLemhvCKROz+CWHoR2XWSCpwJ13uJIUk3gWxUE=;
        b=RhCXzL3ubex5iSkapg09ZBdz8ne3p4FbIvM5Q/dv0n3ppS1c1FzLphn5mnEmovtWph
         OhKYv4TMsjX/Jv/vvcfCf0W1M1NC0WXg81vX1AWcsRso6bqEu/bICi1wyR0Km5JJ9HfM
         vaMirnylnKsfJ84Zj3Hm8PLN0oX+ti5RrSlkAMELmdfU0WLOFvciPg9qHjGD7rBdoPbN
         mlqGiD64T2Z5aG6KTcVlUKQXXvuk9AecLTUDO+jIIoXcAt6w0jKh+R831+qmC11eGMG6
         OydjfNYasysAXz7Rwt7JHl59w3CqKrCtWBPxj7aleHKll9rHerAvVQpQUhnIT8DjeyDy
         1dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777683; x=1791382483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84hi0KLemhvCKROz+CWHoR2XWSCpwJ13uJIUk3gWxUE=;
        b=mVPglrfZbQZKd5ok6HPbNKVcboK+oFVZjX97biRNqs7ukz6wRV9xTRoT5zT9F9L6Ax
         EgUtBSSjHZj6o4V5RfuOyi6JDjrNpiduRmQt4dg2h9LIJjiKJu1BkVg+n+zg1tsyvSyU
         9TBVGA2WJ/oT1S1h491zGaFofvE2/3eodLvp5n1RFF0Tc42O/101Ha4jFq7UrIs4Y8yr
         mOQspp6hjxNePiQk/27HyyI0CxUOjQRDbsgEX1a6qoSspr5oTHB84iVSSu1ZFmYjRRXC
         /B+lpx7zSPjCGKQUcOwtp7FfSlye11Afb68hEZeHAQKoS+tYsn421DnrzuXuDkE9787T
         LmdA==
X-Forwarded-Encrypted: i=1; AKwUvBwmtjlno05u8r1Xidm6AigbxAClffr8Iw4PbK2Hy4zye4pjJYoDr9LhtKlxsWtGs1HZ5tzUd3QeLI5/l2Lc@vger.kernel.org
X-Gm-Message-State: AFuF++keJ5yh0wpjQvIJ92Qau4brgGOQVuHuTlrtZgw8UPkTR+H5/Kgh
	FN4kA4ErQCXmIXiQAk9nlz0rLXv4EsHfga+mPZC0533koIYWASE8zUQo21F4ZRYY9XaNaqDyRi1
	Lu0tnARt/KN30UXsCuKbM6q18u/Xtfts=
X-Gm-Gg: AYBFou2gtqusnFbJXUl44yl2gf17F1GZN1UUGO/aXkq5R+Ok1359AYGyTdfm1J748OJ
	BDFP8UYf5Bt9767ZlZmHtnXk+WC7FFQ8s/VZrXbGP6ClIHkB51Wir19vCvCVrluvjF8hu8kwRkF
	vhYM2JK+Jlcss8d3zSRifTOTT5CuERUwgig1uIrz1nTD/m2cbXkHIWnZqLIba5pl7jLVIDHa59o
	oeaUJka6VZECPPVvz23z3GTfC7lfDYt9rjkhTYH3Gb6cMmWGQNilJocMOpSB8GbC5QCQuZIxPzh
	auc6cJ0i8ePjiE6g/OIDaW73Z3AtviQlAWrwT4dkO31gqCn861FuFCwXXXbe5KmTsQHxeBGmXPk
	Js1XZr+jHUjNJjoBVG7EdE9YzHqR75orjBBqcJw==
X-Received: by 2002:a05:622a:4084:b0:533:33c6:e635 with SMTP id
 d75a77b69052e-53373c75c75mr24641151cf.8.1790777683553; Wed, 30 Sep 2026
 07:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org> <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org> <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin> <arz8Plu6J4YOTi0a@gremlin>
In-Reply-To: <arz8Plu6J4YOTi0a@gremlin>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Wed, 30 Sep 2026 22:14:27 +0800
X-Gm-Features: AclHuK8Ad_V1HG48hhMePSFTDZvGvOl3qgp-ofJZKWzRhJ4s6nwOTixAv4dxy9k
Message-ID: <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Lorenzo,

We currently work around this issue by setting the global
vm.dirty_expire_centisecs to 60000.

We have also developed a kernel module as another option. It exposes an
ioctl that takes a file descriptor. For an already-dirty inode, it updates
dirtied_when to the current jiffies and moves the inode to the newest end
of the writeback dirty list, postponing its selection by periodic
writeback. It leaves the dirty state intact and does not remove an inode
from an already-queued flush.

To keep postponing periodic writeback, the application must call this
ioctl continuously at intervals shorter than vm.dirty_expire_centisecs,
expressed in centiseconds. Once the calls stop, the normal expiration
interval applies from the last call.

The key code, with checks and locking omitted, is:

    inode->dirtied_when =3D jiffies;
    if (!(inode->i_state & I_SYNC_QUEUED))
        list_move(&inode->i_io_list, &wb->b_dirty);

However, neither changing a global setting nor maintaining a separate
kernel module is as elegant as having this supported directly in the
kernel.

Thanks,
Peng

Lorenzo Stoakes (ARM) <ljs@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 20:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2026 at 01:08:33PM +0100, Lorenzo Stoakes (ARM) wrote:
> > I'd say in general the shape of the solution would be something
> > cgroups-ish, but since all of this is global stuff and the knobs are al=
l
> > global I think you need to think about your design a little more.
>
> (Sorry to be clear, this is - if we accepted that this was a kernel issue=
 that
> truly needed something like this - which I do not. The solution here is t=
o use
> shared memory as per below.)
>
> > And in general we've seen a pattern of 'writes to MAP_SHARED, experienc=
es
> > problems' before.
> >
> > And the solution is generally - use something like memfd, have a proces=
s
> > that does writebacks manually for you as you need.
> >
> > So I strongly suggest you do that! :)
> >
> > --
> > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
