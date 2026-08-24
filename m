Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341E374721
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563624; cv=pass; b=GCYupiNcXfP9UNQTtW6eU/4/lTP7DtesGrK6jMp8AkwCyBF17fBsgdCS4pX201ArHvriafh7wILNITn2zSRhAkO1SlGdPqUx0f05JhGGKYMBIRmYcTR2ao8czYzAClicCSsyKrRJp1dw0TmdJ3AlErGa2XRXt89mbG7A8l1mSNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563624; c=relaxed/simple;
	bh=OA04IjLa+28PYYqa4JgI0QmWP8EUE5rmOrjI2n0Gy+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M146mSf+f1Mt6weNhByb9ncFhEl/dr02ZdeEsJbE4Kxi7I9IPGoyqy/Yt8D25y4c3rJM0aFCxEKsl6kT2R88+YgryZmkLMQ/jekIoBF0OHJMZopu9OZRuVZLFlosDE1ikyMuK4dm9WIcRbYlgOZiUF+CQEl5ttJ6EC2FkXZJW50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+jDk0MJ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+jDk0MJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so4484060a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787563621; cv=none;
        d=google.com; s=arc-20260327;
        b=F2NfJk+Z2fA174dJrPt1F+gEQCO9JIpb8fGaDGxzY6H+mvhMQdGDiIOnnjgpb67jjO
         AW5N8fDUDGsLp6W/qRzUv4q3P6mk9F8ImghtY+Xf9EQlCJDunbXkzXprpavXkm3X9K+3
         TDm5uc9hv6FXLmxogCd5+IvEUUGWeT4jnl80vYYnnFJVl2XfCpvfQe50eOB8BGcw87yI
         JWDhGzQE0CcvefwZ18QnBA/YDKrzpkEWBhOLpRn7o7rOpv1mvAQPBJws3k4/fa1uCtWv
         lCgAZxPmJH1a7mIdia3bvKQaQQqRPDP4+/fTJKHV4BXwjbzvu+HCJf8vCEK4vAQcHnCz
         RaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bwjgExHYS2/aeZboO9F4uG83NTdpCfevjwOgza4abU=;
        fh=UVQUVJEx3yrdmhhdtCQo7+QHEQoojQNvDc4T+A08A+U=;
        b=XpyomGUhLUUOqiO8JKT3puPl6mxohryp4yQ6BCMu5TgQOs4cKSJ7Ez3BKrWNyp+FYm
         WT2k3yaVH6k1wSxfezj5e4jQuIoqa5kRdAbPf7DQG1prza2FA0y++Hc+26fwCLhns2yG
         8F3DxyPrCRSjfzPWx0wMLoi5ZSndb0mVFG7QOULGqTee7HtEhO+50nV5ciuVMwxcpf7c
         EnSW9zpdgh8JheDUGtcALF9uG3Ju7+R76HHnRXx7IimkVkexp0TOk1kErA9cJQLJRItZ
         0u58N5uD1yfksy01CIDpTto4376Z94+9mZKDoa16b3V0/mTPyprCJroKk78FcaQXd+dN
         +Gxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563621; x=1788168421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bwjgExHYS2/aeZboO9F4uG83NTdpCfevjwOgza4abU=;
        b=G+jDk0MJtLEka+MH0eIbFpAn5RvZUQaB90zqk3z8E2nH9kNb/kLyqWQbMnsZ2YYhee
         HU+KTrM5kYgrT9HjADyk/6vWX0olzo7EXk202Xrw7SNYZq5gBp8qkCdOM9lQzSziwXqD
         abQ+/yQHYFswj9zZLyefhPpOkSM5j81F1lF3z0GQGpz/RWn6JQtFTIQ2eFeX9Tz0PyOF
         Kwdy/uk/ERAGo/FTaQm1inxLaN8mB69uMPE72B4aHgaqPHL0BsEjVVYAp26Kl/cz9GHR
         K0Ks77UJQnTNtFdv30FV3cPyGpaefVTvy6oBXit6Crgz6NQKLmxL5jvtWyQmYQl8iH+H
         wubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563621; x=1788168421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bwjgExHYS2/aeZboO9F4uG83NTdpCfevjwOgza4abU=;
        b=Widkf5lbMMc2yzyn4fSG2ykbBsrSqSJ00I8Qg/nqniPZwp5IGe3CYk94GmCrcJadVh
         jRfKTZTRc3jsjM/JtkvkN3ye8hBQLX++CY0m5zAgI056kmAGIdoVpR31WOecMf7aaID3
         0DBVn72YDc8hITAtZQn56I/ukicMgUJvwzTu/a8sZD+ypP8TIU6olcqY5wYvRbYrq/x4
         4/ggV12wVoJeJcofo9jxWmQJPPjmO75EHFZLdGc12UpfwC5xdBMV7wcMtMAqCTJnUw6r
         8V9y5Y0kcdGh0z4ua5RdTkQLNvjOx0tag1qGti7NhmqnQb10Qyj8ANy6U5c+vPCV282k
         4vGg==
X-Forwarded-Encrypted: i=1; AHgh+RoyloAzt3vAXzng6YR5zsbsglGdNARbagMkT9viY4HeWs3UNn50YaTzslf1Gth87F0FCbPwlKrbWJXKc0ii@vger.kernel.org
X-Gm-Message-State: AFuF++n5w7sy3buNClT8bjkcHYwP0w1DdWA1IuMWK5zopcfSyv4s+iY8
	HjXhwcXirC6URNNo/iMeFm1rKELFkghiQ5/DliY2zZ51l5ThRhSwvJRybhRVmZos/KCR4/LWmnI
	toPYAUBXdYQMFByN/Xt7F0n3zzgatefQ=
X-Gm-Gg: AR+sD13t5wn/fFY3ep/YGbIrpmPjtwJjmwsnMaA5+i2ZTr5j1rqRQ/nSt3DAVH6tXRg
	w/cZCfNog6asSSEGiUXzIKHrBWErrVdUwF3mOd8uNcOjR3jLF6+ksZ20y8veppr69uEc9K6pziW
	Z8P1gz+W8U/XDeov+BkBEJ5PMAtx/R3T82CnQAhug/8/wXQu0BD+EElDi63oVzqiri7wtVvCVsu
	UstJSAK+mWW58zPJKanzUGz0TkfoI/uKEue1yuuyBKpzUerK2eRexGuJ2IIljgMVoishYbOvkWl
	RCt4K+eRhLR7Oy3g7I4mwhqTBZ/HRMLui2dM9hfQoiSLgg==
X-Received: by 2002:a05:6402:505b:b0:698:af31:5a9b with SMTP id
 4fb4d7f45d1cf-6a42f1e08c0mr27512621a12.9.1787563621344; Mon, 24 Aug 2026
 02:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818225715.572140-1-ameer.hamza@truenas.com>
 <aoVHBkmPNSRakbYW@infradead.org> <9ad95194-983d-427d-9a07-c9eb0891d1a0@app.fastmail.com>
 <CAOQ4uxgUOqFv6pVmdT_+4DjA0KQoQDCzN2Xz=xm1FyumewHZXg@mail.gmail.com> <aovPSDE_IGKggzyN@infradead.org>
In-Reply-To: <aovPSDE_IGKggzyN@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Aug 2026 11:26:50 +0200
X-Gm-Features: AcwNN1Ww_-DMhoMsd0BRmy2xbNr7HMtb_CXoB5tNe2ML2jWxM6NYnZnZX0RCcds
Message-ID: <CAOQ4uxgok6Yk0yp3DcxfD9Cp0ZoFJ7G6a7KasLyhHn6wGuTRyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix duplicate fsnotify access events for
 iterator READs
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, Ameer Hamza <ameer.hamza@truenas.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:57=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Aug 22, 2026 at 12:21:12PM +0200, Amir Goldstein wrote:
> > (1) In this series
> > https://lore.kernel.org/linux-fsdevel/20231122122715.2561213-1-amir73il=
@gmail.com/
> > we intentionally moved the permission hook outside
> > of the splice iterators because we wanted to avoid calling them
> > with freeze protection held and also there were some duplicate calls
> > for this work.
>
> This got me into a little rathole of looking into the other
> do_splice_direct_actor callers.  And I still don't understand why
> taking file_start_write outside the main splice machinery is fine
> for splice_file_range callers, but not for do_splice_direct callers,
> and what consideration exists for potential new callers.

Tough question.
If I can retrace my steps:
The main consideration in the "Tidy up file permission hooks"
work was to move permission hooks outside of sb_start_write()
to avoid "first order deadlocks" from pre-content events (and LSMs),
but I think we also tried best effort to avoid holding
file_start_write(out) while
performing read on file in, to avoid "second order deadlocks" with
weird setups like:
https://lore.kernel.org/linux-fsdevel/5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5u=
vlflfxc5lq4rr@thr4hrkw67d2/

For the first order deadlocks, both flavors are fine:
1. permission + file_start_write() in ceph_copy_file_range() +
    splice_file_range()
2. permission + do_splice_direct() in vfs_copy_file_range()

->copy_file_range() are called from vfs_copy_file_range() with
file_start_write() held so ceph_copy_file_range() needs to use
the first flavor.

But at least it's holding file_start_write() on ceph fs while reading
a file from cephfs (maybe not the same sb though).

The use cases of do_splice_direct() from ovl copy up
nfsd/ksmbd copy_file_range (*) have more potential of hitting the
second order deadlocks, so they try to avoid them with more
granular file_start_write().

TBH, I don't think that we proved to what extent this helps avoid
the second order deadlocks because obviously, those deadlocks
are still possible.

(*) In the past copy_file_range(2) across different fs was also
a use case, but we stopped supporting that use case.

Anyway, there could definitely be other reasons for the
do_splice_direct/splice_file_range split which I do not remember,
but hey, at least the kerneldoc for these helpers is pretty clear...

Thanks,
Amir.
