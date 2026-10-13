Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6D410D3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888269; cv=pass; b=he1hMdn0tPJ4J3KsOrOnkuoXyJ0OYvddqdKOY8xTw0mpAy9BFDNCueR9DZyqMt4bY9crgcTHXwdCWF6TfIEVwu4NMnOzq0CBUNTRFMC9VxNqFhTPMqAPTCXvvFa5DfNvTkhdx2hUKUgAvbWy2s8fx1PZueSh3PpniY2d/mruQvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888269; c=relaxed/simple;
	bh=PelTeFwd5ud7mnoUu0LqIyINYO9v9og7hyCKjE+gurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/w+13uW3lFLJXX84XJk4qrX8SULLeG3kupk+IjcW1AbCufXH84o5JmBKQfsVUElzbJuLBlvywa6plxxQAQBD4UcfLPUwAJWBAtVZG1DhFUBHN4Hn+OgQ/b6DWbGwocl7x/aLfyXXoXxh8JMGh01Wcd98kjdqsv0UMg/2DWdwnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=Ef83ps0A; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="Ef83ps0A"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2533d83e3bso444132966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 03:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888265; cv=none;
        d=google.com; s=arc-20260327;
        b=MICG94Wz4trWY3ORlqQuWfGx52h7bqe17I4m8vZd+xXB7niTIhliNCjivxj4e/rU8P
         osH8AId2FtElbgHPr/yLJHnlEcAXHT2EHBDZEzBhjwfSymrg9VWgQBxvve4kMWrPTQiC
         f2td0OFQGFLGCUUiWkdafVAV58Q/roE64OQev9/o5mtJhIBkOn26+scF3HJaWtCQNeDU
         LAAHrLkc+ZYVc3NwkxEOvxD9v/vVXKwIVUqSvBBMbwiL+bfa/k8Qm9eD50jC6P65nc13
         4w4NI1ArrQdWxXQzAfXloALCO9Ccn+gx0Bm/+Ybnqwf7h5QLw3IlhyMMfSy8OMOOTF5r
         YCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        fh=s3wZSqlTci070pDQvk0bbue/oIgWBOxzaZebSBpfSdk=;
        b=hKpoX60T0ICulAmOjg5veM3oMS4JflKRYstY9dabHWDNhsBzXv5voNc1bjuT60Eb8b
         p8+qnoHND9AQC+pK0Y0BFu4+OcMTrd/awBFbi/2CBF5vgEhID6ZS9EAiLOyzLvpuwfJy
         jo1PSBtBEr71dLkIOhILKfDEfFrEAbQEfH29LgvdgMuS3q77LqtV+HnRGMogWHntRp/m
         aWUhJooM8t6YNuKkOW17tK/kqmiUjbzqaBvp+QvEJ5QrRjAh1VfzN0wtvyTPiX7Pk5Fr
         Pjf1c6nIE6hqi0gzz7u65N5SkytRw3tUT03WLe3WPS59Y/XR45DfAoSGQDy7HHePelKc
         CjBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1791888265; x=1792493065; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=Ef83ps0A9eB61HeKmj9MUPxwLvkKuGBdnGyjMmBDDoXZjqVmkpB7JCCbSFTIMU1O81
         Dt2gd1bz3npeQth6eFHSfT/q0/lcqN1GJJE3DnDjEq0/cvZBkUK6wAFTScbN/oHdREgc
         xxYa8SNV5St5nC5kr3Fp5jK5dufkEVUoceR18VwZmk5fG1w+QUq/Iu8Ec+zgN1flsa25
         vJv3PEL3sgdlxRosCI5xubiuUTYMwGm8IYng6uryuhgWasTC15RSAyBIx/o/wEVxr5Z9
         yIr09MV+vGY6KlRSzFGqnohq8URD3COQew7Jr2eAfbxbnZUJzR1smMmq4XU2+avHa7y+
         nlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888265; x=1792493065;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=NgG1NtoPG9tsYHSVjr/JdIMb0N376ghTqdi+H57DVGBRGricI/6qs0yt7eQdhdNeHA
         cHxM2fEyte5bhU0RpmplozbEP2jVZjkXmrmxZMCw/brtCOWyNVqvBlK8fU9uS1tWhQb6
         kz3q+txcG85BALuCQgEoqDpPDCkwGO9fWoNTrPKTP2PJJxbXubdeYbGB8yxeqLNErZFR
         rDWvmX4TDwgXlOFh4wdY6Fd82ISkMetB7laHyXZYFMxCKw5DnmkkWFrwoDSZiR5nVEb9
         Pd9iSrKtMWxq7lzi5E/dlSlAM84V9TKtIdgfhFHqIkIoRBzZtbTx+1HHZ7H20tnjtEmW
         cxdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKw+7ElCmXzUZG/iT3kjKBVe+IiFTVzbm9HvchtGhscHWMVm00ifD4YwCE/nFuOqZte0pFVvJ55PXK3Dhe@vger.kernel.org
X-Gm-Message-State: AFq9FYLE+KTW18L/wsOta0E4O3VyRPbFO1d1LuvFnsY0EMZt0ct92k+M
	BcW8vF6aQ7GxpXpzYxh9zE4PDuuo93WmVcFsHTCjSLFe23nGt4bTKs+YFimPceT2AR6wpS+tPzm
	Q5MqQQ+yoRxvP2L3GkYpkhxftIVtCDujG/osNnyNZUg==
X-Gm-Gg: AYBFou1DcMvRmSpVdx1sslQSROwCzyQ/9BaYvDFuRwurfiGX9N1pJeUBTGEB5XZAEju
	sHifPa5Q0pZ65+O/mb5Ijz76iV497/DN0aFPW57jMHLCq/Az2kQwyS2bhfrJACEH5uyTC181Cc4
	M+6Md1+exDM7npgBOL0W2WBekaYKUHh45e+ZxVHsIBbGEJBQnT74YKu9H+aPdPTp5Zm3D2bLnNu
	d9BD6QiSbQdX1x/fG6EIjRilIPXSN/GjNuv6h9BucTI75vNhO2PxaU7ZAUFI5jNIpGd6EwJ6V5R
	b6wKa9XIMqrPn414eOVLxJvgqK6RchKLC5+1deFCwMDvOWnWjXrOLjuClC16GpTR31JNkEg789Z
	GITADHcLzoLQ=
X-Received: by 2002:a17:907:e158:b0:c34:e9fe:82ed with SMTP id
 a640c23a62f3a-c34e9fe8db4mr344907066b.28.1791888264638; Tue, 13 Oct 2026
 03:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910220242.2165023-1-dhowells@redhat.com> <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
 <1655915.1791879248@warthog.procyon.org.uk>
In-Reply-To: <1655915.1791879248@warthog.procyon.org.uk>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 13 Oct 2026 11:43:48 +0100
X-Gm-Features: AclHuK_oVCRmnPd9NH08Wt-JPyd6g1EMor68YJAilUyzKCf7DPZ-awFW_Pr3mM8
Message-ID: <CAPt2mGPPYTv=mBo=ysFt49t9=6AVh=P4uvHh4EwZ4Xh=ZULo=Q@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily
 occupancy tracking-related
To: David Howells <dhowells@redhat.com>
Cc: Petr Chmelar <petr.chmelar@innovatrics.com>, Christian Brauner <christian@brauner.io>, 
	Paulo Alcantara <pc@manguebit.org>, Matthew Wilcox <willy@infradead.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I don't know if it's particularly useful (or relevant), but we set an
extent hint size of 8MB on the backing XFS filesystem for
fscache/cachefiles.

For our workloads (mostly larger files), this seems to work quite well
in keeping down the extent counts on the cachefiles objects. It's
perhaps not very space efficient at first, but it seems to improve
over time as more data is cached.

Also, compared to XFS, ext4 seems to do a better job of keeping the
extent counts lower even without an extent hint.

In terms of granularity, I think we'd be fine with something like 256k
(as we are with 8MB). But we would still want to be able to cache a
wide range of file sizes (4k -> TBs).

We also have a particularly horrible random IO 4k workload where the
files are MBs on disk but get read in random 4k chunks over a few
hours. We specifically detect these reads and have a (readahead)
daemon that goes and reads the entire file into cache rather than
waiting for it to grow organically (in 4k chunks).

Daire


On Tue, 13 Oct 2026 at 09:28, David Howells <dhowells@redhat.com> wrote:
>
> Petr Chmelar <petr.chmelar@innovatrics.com> wrote:
>
> > The cover letter leaves non-contiguous objects, which still use
> > SEEK_DATA/SEEK_HOLE, for a later series.  We hit that case badly in
> > production, so here are numbers in case they help with its priority.
>
> I know.  But it's a tricky problem to solve as I need to store a map of the
> content somewhere.  xattrs are painful as I can only read or write them
> atomically and as whole blobs - and also I'm not sure if I need to limit the
> size of any given xattr to 512 bytes.  Further, the xattr wangling interface
> inside the kernel assumes a flat virtual buffer rather than taking an I/O
> iterator.
>
> I have patches that store a bitmap in an xattr, with 1 bit per 256K block of
> cachefile, for a 512 byte xattr able to map up to 1G of file size.  I need to
> revisit this at some point soon.  It may be better to switch to storing an
> extent list, but:
>
> > On our NFS clients (Ubuntu, v6.8, cache on XFS), a sequential read of a
> > fully cached 184 GB object with 1,080,732 extents ran at 0.4 MB/s.
>
> Trying to store a million+ extent records in a single xattr would kind of
> suck.  Now, it might be possible to collapse that somewhat if a lot of the
> extents are virtually sequential within the file, since I don't care about
> physical sequentiality.
>
> Also, can you tell if you have a preferred cache granularity?  Would a 256K
> granularity, say, use too much space?
>
> > I expect the right fix is for cachefiles to track what it has written
> > itself, as CONTENT_ALL now does for contiguous files, rather than
> > something like the above.
>
> Indeed - as mentioned above.
>
> > I can send the workaround if it's useful as a reference,
>
> If you could, that would be great!
>
> > and I'm happy to test whatever you plan for this case on our workload.
>
> Thanks.  Now I just need to reproduce your bug.  Note that I posted another
> cachefiles patch that Christian hasn't picked up yet:
>
> https://lore.kernel.org/linux-fsdevel/1091807.1791483394@warthog.procyon.org.uk/T/#u
>
> David
>
>
