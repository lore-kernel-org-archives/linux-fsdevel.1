Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D83750D7
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787394086; cv=pass; b=PoMwgdjUnF9LK0vbEfdIqa8YkuvGczQEkLTwcI06kQ1mpRDj/CTr1Xc4FTur/45/t8Sj0jrmS30zg8OdMbNyYuKzZwuQwXguug6AOOfDAQvGmKi86k7NLnVALWlHnwgR5QvsEU0zQ39ZyWu2oipktVd58dWeZUPzm/jfc+nEeNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787394086; c=relaxed/simple;
	bh=/REmArqAGflR08+GqMzRbxdUsrqkUc0EZm4Nwfpsi24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUAYrPdp/+S43/U0qWmJlzJcitInFMb8dbGvwqUC38n0zkLcGCPsbO9DZyFpwc9d5HcjzL3/GC+2OB/rpK6oi3v7qKrl6oS1zqneQfmykbOuLtHvmLcWr2MPXUaER50pbLwOQSEOEWJcIDMEToSNVJofO9s7R//8YNcs+YQ0Pqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKH+lcNK; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKH+lcNK"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so2982974a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 03:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787394083; cv=none;
        d=google.com; s=arc-20260327;
        b=YD2msbC97VES4DDoj+exREcZGauHTmimGGYxWxHQgdc387YKK7mP6d5UdOZvgMGRLz
         MCRHw3sMAbJKhJfQ4Gihfb6qjiM5Ops4CWCdU2XnuN+dHdctK1wA7Ev/4j69xUEDZv9i
         yETocb5vCdxr1idsiqSyBjHGnaNC8A51qJLiCeQ1+xj11CYDmh0DJKmXDt/jyjdtHWNY
         ZQA6yZy3HHwfZi8h6dvEYxfNkJrkQzz4MoDFBHcZnv2/DQhpQyU4hODkC6PDyNvQ2oQO
         I39hivFlXT0GmIP2NaTV7tRjAcI5XDCkvBjNKjQ671lDVXvIwzv46N9lL7rHDazJiOQX
         Bmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pk0qhrxFdQA3tThenrKug4RmzTweFzB5qVSaDfnu8M=;
        fh=lAQMXzSChd1U8SvM0zkUWbXe2sVRYIQlejEM9q+obWE=;
        b=jbujaWC54PAnicEbFNbgkzVYp6U0VIRjmZCgvM6229YszR9MfFoeRlf5gFTuuiKXW5
         I3g4Pnx13s0FSZXSutJ21XNmQKu/zuQB0/XPQLJFoeiE/XIMTFIWpMVXwGn5pzskuyQi
         u6H6p6wqcKH9MvzHtpGrIwf46NW3oPUXA6+gbw0KM8m5DBrevuPMx7Rpc8ISOoA6OSaR
         RKHDhxzmSb04kvj3AItb8OIj689g8UOfz3a8VT+JFebztAUwnMpjO2I3+ESHVoUpACBu
         D0OknTSNKIYI2Ep4cbAz4t6TXO+os9F3SS2R58vdfsTw/eoGtWLLzkaPq0U444IlUyhM
         LIhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787394083; x=1787998883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6pk0qhrxFdQA3tThenrKug4RmzTweFzB5qVSaDfnu8M=;
        b=cKH+lcNKxabKRz00tGTWNuSTz+xDpDB8vIQtu6gvsxe3d3MMPn5O58sBNw6PTkf7eC
         tmPMUlq9zyPuYajAEfwgce5gsNdL5vC61ynUku7ulAIxCZxTriBmiwYAT9CX1W/0XqtY
         WDiEIchH+pdK8CNHB0jN+SziRupdUoXlo5E+sgKtApatIKK7DgdlO8BRpCYW567mq/IP
         GcDTM0mbg/PPL9WOVjip0iyGrFjo32H5VYITYL0COYMyVP2cmJ2YEmXYchjnDB4blvrP
         iKRu1wXpkxCSYsFkca1FJOytR+piNKDtKphX26QBPFob1u2ZuUV74xmbtgpWwaAMJgI4
         sSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787394083; x=1787998883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pk0qhrxFdQA3tThenrKug4RmzTweFzB5qVSaDfnu8M=;
        b=ZMDu+pjqKgOUJEMTAmAHpCx39Lp+NSUPzwQzctHoKqcdZTwRmTUpuKEDYzCYOeRQlH
         ljAkVyfEBBh1eXc+RJPTUllZQbszW2I22ygVaeALVnGQaKrPAaQXqoKnSrO/qjHroH9t
         VMFZS8EpjLrYdCEvWJpIBZqdey7Yx2XQqirQHS/HyvzLpHcCalPAfWDB9ePgwHbjHmDp
         5xJQercggB+x+8SsptJjeH25g8PCzqI75T6XhJ7hyu63TRU7T2wE8OaWR2cngRcO8Obm
         hI7Ny4CLORVOxzXxBZeOEBQayYePp5glxx5uNIqA80Bz8FYzWaBYo2XvGC4UMunt3PRg
         foxA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+T+fLON8Bj7Lqv9HuDoToyv+LkoXhvB9Jrkf2np/0A+HzJrOqzkdZjyovtz3OBLPSqq5+Dp3P2nTI2Bka@vger.kernel.org
X-Gm-Message-State: AFuF++l4hFYb7P555h634YEHDpRgH1HZhF2F6zdEdtsuv8js01xvCzQ6
	OoFCELdME7WVy/sbqNExTcLuuyXHAjLjYY8lFc4VXidyKcp208duJcjYyBLZx12eg1SVh2OkDpg
	9x4nRAAqoHixBGIOzCH1d9dDml9a+RA0=
X-Gm-Gg: AR+sD12JnEcQ1bYj6H5sEdySNJI1ivzhP5ZSpTvkcfbyNLmMzZNaeCCqxUmBeYdRwOQ
	RbpcrSs41/0MZ4ccOgOmggLMXfMbvVB8PnGANcmPqE+miYtX2u89FUpIQ8j2MUfpSfqTZ5KCX6m
	7YuczkJhXOk6hgHVhGLFWd8Vg9OZPDLQ2+voTfEe/D07vi0Du15qmMQTFe3suhqDF03P99smArH
	paaKsLSS5gEK85TsmCCYv7/1CcnUTMhfh4IMlxBVxX2BVmr7Y3Kbii73e5+kX1qK19tEt3mpGC0
	9hCzorkfWAoaAfBiSg7rB1YlAvHpoM7cJz/J6/uRmI6h2A==
X-Received: by 2002:a05:6402:5042:b0:6a3:eb58:dcfb with SMTP id
 4fb4d7f45d1cf-6a42f1ddad2mr13653297a12.10.1787394083030; Sat, 22 Aug 2026
 03:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818225715.572140-1-ameer.hamza@truenas.com>
 <aoVHBkmPNSRakbYW@infradead.org> <9ad95194-983d-427d-9a07-c9eb0891d1a0@app.fastmail.com>
In-Reply-To: <9ad95194-983d-427d-9a07-c9eb0891d1a0@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 22 Aug 2026 12:21:12 +0200
X-Gm-Features: AcwNN1XzemKu-d2TUHxowW_SDTAK17OPxEP916mNVScXWxTH88lttphBtBvhGEs
Message-ID: <CAOQ4uxgUOqFv6pVmdT_+4DjA0KQoQDCzN2Xz=xm1FyumewHZXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix duplicate fsnotify access events for
 iterator READs
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ameer Hamza <ameer.hamza@truenas.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:04=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Aug 19, 2026, at 2:02 AM, Christoph Hellwig wrote:
> > Well, that is the underlying bug here.  ->splice_read should not
> > skip fsnotify events and nfsd should not work around this as
> > fsnotify is not the business of the users of VFS APIs.
>
> I asked for the duplicate event to be split out of Ameer's larger
> series as a backportable fix because there is clearly a bug here.
> But NFSD might not be the correct place to address it.
>
> Today the fsnotify event comes from the system call implementations,
> not from the splice helpers. do_sendfile() calls fsnotify_access()
> once do_splice_direct() returns, and do_splice() does the same for
> splice(2), while vfs_splice_read() and splice_direct_to_actor()
> emit nothing. vfs_iocb_iter_read() is the outlier, emitting from
> inside the helper.
>
> NFSD calls splice_direct_to_actor() directly, so on that path it
> acts like do_sendfile() and emits the event itself. That is why
> the fsnotify event counts differ between NFSD's two read paths.
> Moving the fsnotify call site down into ->splice_read would double
> up sendfile events unless the system call implementations stop
> emitting it at the same time.
>
> Jan, Amir, what are your thoughts?
>

Here are some thoughts and points for consideration.

(1) In this series
https://lore.kernel.org/linux-fsdevel/20231122122715.2561213-1-amir73il@gma=
il.com/
we intentionally moved the permission hook outside
of the splice iterators because we wanted to avoid calling them
with freeze protection held and also there were some duplicate calls
for this work.

At this point in time, the fsnotify_{access,modify} post hooks are
usually called
from the same context as the matching permission/security hooks.
It doesn't have to be this way, but it's a good mental model IMO.

(2) emitting many READ events from an iterator instead of one event for
the user's READ request is more noisy and serves no purpose to users.
In most cases (but not always) those events could be merged, but at the
cost of futile CPU cycles.

From a quick inspection of the code, it looks like:
- fsnotify_access() is missing in vfs_splice_read()
- the naming convention for splice_ do_splice_ vfs_splice_ is a horror
- we could make the low level splice_direct_to_actor() static and possibly
  rename it to splice_direct_to_actor_sd() or something
- we could export vfs_splice_direct_to_actor() for nfsd which wraps
  splice_direct_to_actor() with permission hook and fsnotify_access

Whether or not this is prettier than nfsd adding the fsnotify hooks
is a matter of taste, but I can live with either.

Thanks,
Amir.
