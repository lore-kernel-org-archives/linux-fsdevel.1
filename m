Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66D329E79
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895259; cv=pass; b=l0+n2YDwRL699GEyy1BiKktg8zu7wLhwLKuOmEcL8KluyGUyKjDCOL7lF2ey+LnYAeLI6f+0ftQ3oVKVwjIBeEgeZgl0/gO+nYWQptWrjx3WXeyGTdnXSKywEa4jGBO9NBQQy1GacV3sszgleSgKXub0V+dle8+i51HqLKSAL1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895259; c=relaxed/simple;
	bh=+6HbdvXz6pDwyHoZBHfAtbCp8mco+tVTkhaG46/uc+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRgzuUrjmUMfI2zvnPTRyGmyLjRuzXRew1UfsvCuqFZv0Hok4+H5KfVWl2waxKec1he6bH96MyiuXKd8kxtN6l7TRPTXzvJ94bWhYL8CftdQ65Bpn5rq0s6HpEwg0tRHsmzfJ9mV7lQYfgUJIhqzFhOiXnmv40a68KP8ea+210c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX7cpyuY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=afM4UA3+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX7cpyuY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="afM4UA3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791895257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
	b=eX7cpyuYU+800b53xk5/JJvs4mNy3MZpdkXj6YIC+IAX2xZclxRr52d0zQIWVOB3csDtAq
	jzyYNBKJIWLON9EFsiUuUa9+TIQKFWIjpVWfNI+ziU38uW1jBnXAfcLHegG0yVXcUVQy6t
	Kle4h9EUeLii6ZckMl+9rSabH/pkndA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-sZAXWQzxPzWCHlM5ewSi4g-1; Tue, 13 Oct 2026 12:40:56 +0000
X-MC-Unique: sZAXWQzxPzWCHlM5ewSi4g-1
X-Mimecast-MFC-AGG-ID: sZAXWQzxPzWCHlM5ewSi4g_1791895255
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2e71425f87so322309566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 05:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791895255; cv=none;
        d=google.com; s=arc-20260327;
        b=gGUKh9IiYJyNUwW1J77cYxD7A8GEhxFKkdTHRdUq+vnBBU5KR0aPnXQ0hD+JuipJbF
         Mc/yRWLyjUFO4scUejvLjQk7IlfE5Nga2nKdY1mxUvlUi5h1WZ9Ij3XwaLoYsO5fE+xM
         GHfpd1u5Tpl9fe5OaVPaQizRo1mn6YEFWAQtmc8gU6wKwBMxVGVc662QNQk1L9SPmaH5
         lJZQdRgckWELKvpZWxt2YGObVHkCBZdSWKbhj4w+ri+C3qOk7atkT3oiLCPOzulmaLX8
         h+BBWoWjJ0osE93YP941DCyR14AcFvaqgvnEXaGYFQEOV16FbJDUiwD/Pbwvi6fZR75M
         1FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
        fh=w0SKp6tK1QszxZO3hoIoJNC3IwkEkEtHzXsQ2lOsqj4=;
        b=r0sGxdGgIrzFYdfzRnM6JCkoaio6v1YlORLEBCp0uG94WZmM9t0xyicy5OMHZuzmtG
         gLyYeZdkvgdRnLrXiuzZy511/+eRaKUnDg9lPlPKzmP/OeKVCu+Ldsa/YAPKwUlytYJN
         Vw6dyl9tKy8HJiv9oMMFGQTx96fBKUj8UqaXBgkJMobKuF5Dm620U+Ojuuc0rN4JOBvc
         uJb7zkE3WoFkHcrHTUoaV2FNli3ascNXMdpH1jlWjlMLlUJPhsHOwN/e6M7iY0ddnWHV
         Gc/UrTcl7sCx6H/mmg85Te0g1ZtGffMWwI3pVbGA0K5UFtXtPLv7WRU1D5smmJeCWPuP
         mslw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791895255; x=1792500055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
        b=afM4UA3+7Uh4rCgEPDp1gUBOa56z6Comz1f0HdywN2tscvcRMMa1paYwJnapSgoumZ
         zT1B4r+lsTbSEV74qZt2Kn/dqav80xy2rH/WcAq2OdL7fplgJijFU5qN7wr6kp6LmL34
         9s4e38+IHf53RC1XBMopg5kOxBjhhZVa3K0TxsekU76nci40eMCeaLF2p94+wWffN4Kn
         OY+rd7C7gvEX6foEJ/AKCprNZGv7a23P90PnI1vNxaZLFfVJsjQ113iwHDZ/89LvneaC
         7ocHfpYnxezOTPP+NOrE9F3TlzwoCF8V52NuCZDQGn8VpdBvBVXCVtF3DTd/IrMDmxIG
         Jurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895255; x=1792500055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
        b=POsssNKtaffpdybgRZ4+q/yLDMD1s7kdsYbHwYl633LZ+wMjPBQcFQNW6kf4DmfW1W
         ukrkheBK3qFD/ohecEeeJ1N4/IhARH/c1p5X7j0JfaxntKWO5BugX2XEnJ/ShJSH6ZRT
         n1sEK5W0ajGr/dpcyWVShfXGg6cbsIo6S+nl7ANJT/hQ0PT5pB4XuiomIIiWKSpU7qQu
         WekWpxkmSkJzuyd3zHdi7DjLO+2kkni0BeTDYJ5+J5qp2ef1IM9Hl5ffLJwe1IpDhAqi
         PtPz7YQYm3dLED+EbBcTuEUZ4PpXQLcyjJixbJm6n4axms2++b82qKnLkBanR71IsgZG
         TmvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzsxv+i5pjTW0b2JxsDqAOT5lPWHSqQqf/hrRXXzPEHcin+oYLqkoDvcwzy1Ueng1GMwjMOr00U2l9sAoi@vger.kernel.org
X-Gm-Message-State: AFq9FYKahK65HwTj2DaGT3V3qU4jY1XIdhZ2wOKYzAnKHZWxbsCc7z8Y
	9s8t9jN2GxUYVCj8Ymtt4i/us7JFrvB+sjIC5fupbeydM27G/36euwrcry456ZFs3ZxbxBDopPE
	1zcGiibC9tSUxqJmRUFC7/iLTsS+2UfwdrDT0DEFErU2h0123j3Pk5puTYQlw5AfTa3+JMIXvRl
	i3STmyWVphc1spfUBBkxD3AdiYQrK7CUAAl9B10EngfA==
X-Gm-Gg: AYBFou1s+xWNIsrQsezLGTb7mSZ/6DwRh4FECZIHzpK5duDyE4Oq9BQZmUBYyLho7S1
	P6ddZ+WQLt6TQnf6og/9FOrvPtazOrHeRvAzpXl+jV+85i8aBNXZPQ3jicZmxXrtQ6YQr8pIkMM
	zd5b2qDoIMUgZSNcDaGJDPNQVXyYCvvTwju5N6wSgHV6muxkj+WhlDpJxYvi/Zm3PuL0Pwi7bfY
	teBoRTAWdRTb7+kWUANfBn9yzlpK8VuN1gmeiiB/Lr2iupH7cBXfxbCZvIK1rDGHOoDZF+t7IIl
	hpM=
X-Received: by 2002:a17:907:e00e:10b0:c33:923b:ad66 with SMTP id a640c23a62f3a-c33923bd1damr460790266b.43.1791895254795;
        Tue, 13 Oct 2026 05:40:54 -0700 (PDT)
X-Received: by 2002:a17:907:e00e:10b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c33923bd1damr460788666b.43.1791895254469; Tue, 13 Oct 2026
 05:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
 <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:40:42 -0300
X-Gm-Features: AclHuK_BqgHG9szdxsfF_J8_QomlYVv7uojh01Rda0mXNc18M6GONX950OFpYpA
Message-ID: <CAABTaaCj2Bap_w7mESYhPgT1njd1rQh6kB0HFnnSiMW40SCNUQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 10:18=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Jul 14, 2026 at 3:33=E2=80=AFPM Richard Guy Briggs <rgb@redhat.co=
m> wrote:
> > On 2026-07-03 09:25, Ricardo Robaina wrote:
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > > does not capture the filesystem name string, creating an audit gap fo=
r
> > > filesystem mount operations.
> > >
> > > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > > name string passed to fsopen(2).
> > >
> > >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN=
_CLOEXEC
> > >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> >
> > Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > > ---
> > > Changes in v2:
> > > - Better placement of audit_log_fsopen() call to avoid UAF.
> > >
> > >  fs/fsopen.c                |  3 +++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 13 +++++++++++++
> > >  4 files changed, 27 insertions(+)
>
> My apologies, this patch fell between the cracks, but it looks good to me=
.
>
> As this patch touches both the audit and VFS code, I've merged this
> via a topic branch in the audit tree, topic-7.3-audit_fsopen.  The
> branch will remain static and it will be included in the audit/next
> branch as well as the audit PR for the upcoming merge window.
>
> --
> paul-moore.com
>

Thanks, Paul!

-Ricardo

