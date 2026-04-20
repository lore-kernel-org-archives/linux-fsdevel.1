Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD863859E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679150; cv=pass; b=rrocQsZu6rXDVbY5wCH6s3x2ZWn9Vy6rshawN/gXXEN6GFrMGU82xooneVuz6icxrSzV4SDzXraFlmB5vBPULeY3VPJ4GfOFF0oDx63/HOn/TtIAAnG9tnkvi6DUSylYBZQ+aoaywX/esywhiFvcLLj8eoZEK+28W7W1VJOyRBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679150; c=relaxed/simple;
	bh=A+0ZYRI4bhrzd4DznVs14BK30lBCNe0iSlUNS3kYy5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENhrT9fvTO99jo7TC4kBa8Z+PcSZ3siY9Va0k+6xLCMxfoFB4lf6jn+OoZWsr0NvSrE928dkgYwM5vKmJ1QMtf2NjaVuuRq/pIPxalUPUatHILmTpcZnZIS5Iv2JxYHtuc1hHdNReFcfoe6juJ8pdZtV8kE2xK4QsdxUD69+1u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRgXejzR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1DLN7dz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRgXejzR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1DLN7dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776679147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+0ZYRI4bhrzd4DznVs14BK30lBCNe0iSlUNS3kYy5w=;
	b=IRgXejzRILjE7lR6Qs5ufQpZwEqQmPLUWts14wvPtv6GrReWjdbfJEs/2k8mvoRpIkZmV/
	LcDs3NBSdqPSN0gJF6cI+2siEpyPAfP11Jy4zj92YA3B7V5zMRDOxtXxBGvN1rakBDQNue
	Z6fw2f3tdUooluQ4vw6cb5ropZymRGc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-zrsy7RNiPCacqMNsBIlIHA-1; Mon, 20 Apr 2026 05:59:06 -0400
X-MC-Unique: zrsy7RNiPCacqMNsBIlIHA-1
X-Mimecast-MFC-AGG-ID: zrsy7RNiPCacqMNsBIlIHA_1776679145
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ba3de9b3ca7so283638466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 02:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776679145; cv=none;
        d=google.com; s=arc-20240605;
        b=HAPs/6Or+58Al3RExP59Bpuk0mGYN8s/QSZ4Vq6jya9qEHS3TvR3ivRvp2OPDjc5Cx
         J1YMM86qSKRIvWlXlukGfO/z/JoK1bd1HfAWw5uoogE0uJJvY3+VcrD6A7x6id1Z/jwR
         AHtO5WBRds0/dUX3+EIMeQGRiYUUcTT3T0oPN5kdgdAipoESqrxV6CYI4XCrl3qJ7CDM
         GhMVWJCDV+Qzp/8gLGSSECQS3UqrxBeQYLhzxMmOMIpxQn7mys+u7/WTN+WpqOavZS5H
         L6CV423SmoMv3K1HFlokh5EwQqoEwphPCto8Q03EPFs7YhnXBfThL2F6kJO/Z3TVNNT/
         7JnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+0ZYRI4bhrzd4DznVs14BK30lBCNe0iSlUNS3kYy5w=;
        fh=AiTsa8AJeMx9oPflL43xQh4r7i0Nhf2eb7mFIx2tblk=;
        b=biHqW972pqmJfeShNewa38n2QFf24Apl7l4REhdpB498B68hRD9WRQ3nq/PuSjSF10
         Yi/0BfnX84X2zg34c0RvDovGiuOGa+AxDnv8OMkQTLsI09vSPHCFGD1PY0IxYVuRdw0X
         1elUOz/mNNihBQ2k3X3RFEz4dKECU5t+4mylwmvcHVwYMO7rASoqfcNzIjk5YWQ9KL+D
         c40EwiSMYE/q53NJO2kfYfDPJ5ehv6E4hpTzPf4zKqP7NeEwCQUzEVorHxQXe197q7A1
         p4ZcVO06q+0DUB2Ac77wE7JWKDz8hE3853gDGypett5BYWrpc0jh6GbTn9e+RtYeGR4m
         m+QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776679145; x=1777283945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+0ZYRI4bhrzd4DznVs14BK30lBCNe0iSlUNS3kYy5w=;
        b=M1DLN7dzmjiktBGpxl/tG6WDF7kt6aERi6JJuBhhwyb6CFl4gK7YVivznkGd4gsUwn
         4wnQYAnkeW48q21WCzwAAX2K5f90pV0hOFp8BZqmb2G1NSGBiKjGLGc294UXvHVM44I3
         j+YQCE3yHLfNnw2qpgkNJjMdLHPMhU7ETC9RXm96A1JVgiPMtdbNAx/DftbHq3msl2kf
         TMzlK5w6HiPx/+eZKR+v/pt9h/Or3isiM2lvW2a2zUI4lnmmYeiUEQiH2Gp302d900/e
         w3diz/urhEiD+sgevp8KPJ/BcHIKg/b6atAQmSCKAsI7DAuDEYOEwtFxpwIsjKfruY5u
         H/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679145; x=1777283945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+0ZYRI4bhrzd4DznVs14BK30lBCNe0iSlUNS3kYy5w=;
        b=EZAHjNf/4DhXjGa380HdzleO/x8VFeKnDv814VZ6qHuCp+yoK0E6Di40ZBv67QtNDU
         XU6oS51KolOq5WzFRHiB10yU0uVWIUPYgFvnc0oYh+pWbsSjnLJRiGilQwZfTJDDziOF
         fEmAiSnxbJrAmQSq9ObBmamYZC8VP8T1yU7zuDN+L9UunZxLL+omF06rMiCerEXecsUh
         YFAWkHP5tzoPEi+GcZv8Utw5g8kKGN3QaNCNyB9jctP9xOqWGSkcazL6rKZYsyNshnUN
         mkpChU5epC4asFKZO0IQdrCfRHjjzwkUbZXAUL7OABEzHO+FQ+pH1fQw6hAupCrrTQNW
         O1kA==
X-Forwarded-Encrypted: i=1; AFNElJ+GOoSkixWyrUMm9b3tE+uchwEKzojZBH7Zt7xalqyqSdpTg0sR2tJXoKinncEpBk7Dq7pi3VjoCkOKQeb0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3Hyz6zFLiCY0TyqeIqtb8Jj8LOJZeQLbxxHLtrYZDBUxsadD
	RJBi698V4OQeC5lPUT2uZ7lbIlZAWgpRH6Sc+iZVJK7Vblqnmr7vw96zt8tHDxjW5K66ZGNgwob
	5WdfBcN3GU4Az7JJ/fISdA9g8xZGj690oIRAtk1YcPeCC7GWJfP3zT32ioFPArgBMWPvnYYCYYw
	sTgcOPVxjCF84r+QA5gb1Dv8d3IpE/tRyFMxv1fddmCQ==
X-Gm-Gg: AeBDietNmXOC4Q2rSmdlxMjh19CuIFUqRVeCQoYE+NhHTjDeP52juyLPlMvp5m90Kur
	iBAeojEiC75fCLk6QjgrPBtLEv3uILBBoSqOryjmijepgUSsei4xv42qNuQrx9CBTnMBvy7dGwZ
	0/fiIsw9Bl5SPhO3zefqZWaO6sL9y/vF9l/TWnu7fQKhiQTL3xbCQVoOHwuPuentskeIeJazOJH
	DHYx6fvqS+OMoIBgPPusgkVF2v8z0VAmtoZhfOzpmTcstPN
X-Received: by 2002:a17:906:ee8a:b0:b9d:7b9d:df02 with SMTP id a640c23a62f3a-ba421debe8emr542313666b.17.1776679144864;
        Mon, 20 Apr 2026 02:59:04 -0700 (PDT)
X-Received: by 2002:a17:906:ee8a:b0:b9d:7b9d:df02 with SMTP id
 a640c23a62f3a-ba421debe8emr542311766b.17.1776679144298; Mon, 20 Apr 2026
 02:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415071657.23412-1-ravising@redhat.com> <ad88TluB4FIP3yJV@infradead.org>
 <CAF-d4OvKZOsez5589KUYTjRz05PQHCQ-uRkXu-3iaO3tOjcavA@mail.gmail.com> <aeBv_xvDTmuzEhV1@infradead.org>
In-Reply-To: <aeBv_xvDTmuzEhV1@infradead.org>
From: Ravi Singh <ravising@redhat.com>
Date: Mon, 20 Apr 2026 15:28:52 +0530
X-Gm-Features: AQROBzD_UsKC0IhQ4Ae2Ri5WaWay6e3YXdaKJYXBxxPywhXucTckxG6JecxZqFA
Message-ID: <CAF-d4Ose1YMaHy5Jy_QmLwDQvBC7m2Bt5ftzmYnZwheSyhX+EQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: flush delalloc blocks on ENOSPC when creating symlinks
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, dchinner@redhat.com, esandeen@redhat.com, cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:43=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Apr 15, 2026 at 06:54:00PM +0530, Ravi Singh wrote:
> > > While we're at it - do we also want it for tempfiles and scrub?
> > > i.e., should we move this logic into xfs_trans_alloc_icreate,
> > > similar to the quota logic?
> > >
> > tmpfiles and scrub tempfiles are created without
> > directory entries, so they don't need a new directory block
> > allocation and don't hit this ENOSPC path.
>
>
> But we still ned the ialloc space reservation for all these cases.
>

You're right - the ENOSPC comes from xfs_trans_alloc() failing
to reserve blocks via xfs_dec_fdblocks(), which is the same
 global counter for all callers. Even the smaller
XFS_IALLOC_SPACE_RES reservation for tmpfiles can fail there
when delalloc pressure has consumed the available fdblocks.

I did try several runs to reproduce the ENOSPC for tmpfile
creation, but wasn't able to trigger it in practice - the
smaller reservation makes it much harder to hit. That said,
the code path is the same and it makes sense to handle it
centrally rather than leave the gap.

> > As for moving the logic into xfs_trans_alloc_icreate(),
> > xfs_flush_inodes() is a heavier operation (sync_inodes_sb).
> > Pushing it down into xfs_trans_alloc_icreate() would make every
> > caller pay for that flush, including paths that don't need it.
>
> Only if we git enospc and need to restart the underlying
> xfs_trans_alloc call, similar to how it handles quotas.
>
>

v2 moves the xfs_flush_inodes() retry into
xfs_trans_alloc_icreate() and removes the existing caller-level
retry from xfs_create()


Thanks,
Ravi

