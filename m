Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098302192F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707816; cv=pass; b=rdC5IAUVbCULl3PR0u+pXIIQjSXAmVg/82DQcBua79FK/5Hc3zUjCGvpmuDu2okFAb+9NIppBEpsJ3qPaBsk6Of5iOyNbbzmHFm/JhFSvL0Z5oIRY7rWZP5p5RF23sKyVvVvoN8IR4JLOMHIQ/NNlisJsAWOug2KInje9fTAPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707816; c=relaxed/simple;
	bh=5DYCkR8DbR9FmKek48IbF8Ycm9wxiGvc51MR9rPXf3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8i9DsyQWBL0uzkM8lGRZ+4mh0b50Ia9MOrYX9rLcj+kQzj2NVyTJ2bnVVoIzLTna2IFj/rdomap6cyGy1kCz48gSs8OoNjuzoL9hGOXmZa80n9tUWE+0jJrzS67CrkAKwmvhbTvbsCfTxxlTsV3UgjiFIU7jWP32HYjtzyPWtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZ4wh9fF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSaswPVa; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ4wh9fF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSaswPVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781707814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DYCkR8DbR9FmKek48IbF8Ycm9wxiGvc51MR9rPXf3E=;
	b=fZ4wh9fFZyXeAJ3/tpM26Jfluer37yFiZMAVRW2G1zFT1L6DuVjYCfWel2zfzyYq9gB5pL
	CnQR40lt1avk0v2T8+OWhokd0tTfGOaM5xqteGD04qh+JQ+smeoNkoebodA5imF5F1wRFM
	LuvMrrseT1+aGTVrc4lKIK01TTRH90A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-lkDtK6FMPz21vERroIz4SA-1; Wed, 17 Jun 2026 10:50:12 -0400
X-MC-Unique: lkDtK6FMPz21vERroIz4SA-1
X-Mimecast-MFC-AGG-ID: lkDtK6FMPz21vERroIz4SA_1781707812
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7fd85d01ed0so27455017b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 07:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707812; cv=none;
        d=google.com; s=arc-20240605;
        b=cdVVX4f/8wivdEgNmaEk0dURzmXNLKrsByHbWDAsOvA4SprXDnqWMzjffozLQeaLVp
         qIF7vLJaAFRZIe0f4dVka1HwC8C4nAA5dG+LbcgmE0Si3PkGowVLVv60kZhHjfkyfpLl
         tbHK9UEak7vjGeMrLJVJZgqbPOEdOsxB7ulRdkYMAmqnXDkFdoTESEPzhFOL9RjoI2Ic
         K5DODvxEoFzBw6yMd6nHvJUbAJrAoaKjktX3Y1FyKTIM0+SQoatzbokHHdIG+6BmLoTc
         enJ9fbDFO37BfONUaLgkHyTT8fvDgfBVjk/7PsH8dU4PZZS6BEJuj0+9+jubkCppnCbn
         UPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DYCkR8DbR9FmKek48IbF8Ycm9wxiGvc51MR9rPXf3E=;
        fh=iYidFnoDI34jMG2Ok+/NLKLlBOHuSQoRcVqxyH8hYtA=;
        b=DMy4gO3oWfqjYUcS0E5OV5uiQpXDw2l+cy1L4sKfQIe2CrM9LsloCwiUkTwjZukNwb
         9Lq7Hr6pyu+8bblUkgWUBVWVB+G3/sl1/MSsfra+Nx730sKAsMMd6Tbqj+QTJQDTVWzu
         bd7r8ZqEcdNjWM8EQSGDpDsRC1xLX8sOZhgByjCDRXftOgJNt9bWZZutSZ0dsAM/oPdt
         IOMaZAOMEC5GaxTHS2vFhWmDCZKaw3QO4GB4NkjXjAgioeK2EkPAnQNG3TTcraZV5ESA
         qAX+S4DOGMnO8Wdl0hADGoFE5LJOEHznSMxolLSykJIC+aW+l2EaQVgEB6NsR6OKLCnV
         MmuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781707812; x=1782312612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DYCkR8DbR9FmKek48IbF8Ycm9wxiGvc51MR9rPXf3E=;
        b=BSaswPVaLgDKEiE7HU95zxelfV4ieanI7q/oiOahSgtHR0CfKx2VnCIZ6rrSZ21Kuh
         Y9BcAp4JU4y+tumVUe5oG9qw/7904RF08FC3suBHYq1SKVbLgIsAf+nVsEph/9uQLMB+
         l6IR6cr/9xWsdYDgfHE7TP4ZfyZEgyN80KUdbq9W7LGa/SaR2AukcwDhnO0+huonSoBQ
         /jRURDVIGFdTrqFr8RRKsRBDSuN/STC1YtewbuRuqY5ElfmUyTJGmy0MeCLiW8VScd2l
         WJGcaQP3zEjxLsk6Ve7PA0ZTaAw7wduVIWbWy9PpmHuP5qLBjFR2muyfyj+fsh8/Od+L
         dqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707812; x=1782312612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5DYCkR8DbR9FmKek48IbF8Ycm9wxiGvc51MR9rPXf3E=;
        b=Hu/6hKJsxk9Z4O/rpm9M8PB8ljs6JRbbo0NCxyPXCuzRsJqrTFhUm80TxNlJ9zJmQ9
         tis9XJekR+6RngA5fMtgs7aKEREnzd5vb39l00sWqUCcG7/sjqyFiLbtjeaIxjTYb+S+
         dcyYuZEysvrgP8WzRkVDo4s1Nd8DLrYW57P1uz1gDTRoColk7v3zrIZhOrBCZDSJzmeK
         8wlE0mf5tPAyFootoV3izrNl0hcUyP7Fh92A9ijUobYP6dsSqolJJiTIG6XA5V88Cb/Q
         AZlm6HqN2Vh9AkuO3va1IV8Ajohb3xZtEMXa1CBwMDk0C4bCWcxafykc+1MqSBB2SZEv
         DgmA==
X-Forwarded-Encrypted: i=1; AFNElJ+5lVebevpVduhD8ZggbvOW8jLbQ8i6O3A2he2foSgWD7SPIA2fzmja7ZLJTdVHkA0IDRtCJD9m6fOnELKW@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLFN5rDgt01xLSaBloAADrlyoyVf51FWBz9xvux9XLcgrZ3gA
	O1TN5nJ0dKuEog/SZXTOpahPiQzyN4AOgVO9JaIoXE8CgAHACZRzfbkeKmDnaxIPRhGXldc3EAH
	8KAZZU/42thW389v9/YmrgVw2vPsm2/tQ4wLWiOeVvobBUEVEvu8/hSsXf6mXfPRrPuWUc9gHjb
	2H7mnxNYu7ONhp0xVf3d8AQu32Rl+5RsIKfIzatN30tQ==
X-Gm-Gg: AfdE7ck+xaa+66N1UTm/PW6s8BPVKS13I7mVDwDB6P97/jU6Tp2EAI3vTNbZMsWpQzN
	qXydCRby8vWhBfNXFhaf2MT0NmtX2KUzXBBD6SfkgmtKiSleoalW037ZfbAeRCxc8lVrzkQDFPP
	n4EePajeAw3xEvuAWiAZwmdt6N9kNHEGXiTKZ34+8m0um+8a5xOCNflGcuP/0Rbmy/pNVoaSS45
	82GXpwXpSr97cq427DtHwqUpAzuItDhKS2j33eKUKiAPFwMbJOPrhs=
X-Received: by 2002:a05:690c:4911:b0:7fd:add6:f271 with SMTP id 00721157ae682-7fe5e99e391mr43805457b3.49.1781707811886;
        Wed, 17 Jun 2026 07:50:11 -0700 (PDT)
X-Received: by 2002:a05:690c:4911:b0:7fd:add6:f271 with SMTP id
 00721157ae682-7fe5e99e391mr43804907b3.49.1781707811251; Wed, 17 Jun 2026
 07:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607164136.2948550-1-agruenba@redhat.com> <20260617-marge-gelehnt-fernreise-758645450688@brauner>
In-Reply-To: <20260617-marge-gelehnt-fernreise-758645450688@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Jun 2026 16:50:00 +0200
X-Gm-Features: AVVi8CdqxI_T3ApJ4tZPjWRqp_NwMeGW48VhHGo6VdbRo2Q_XcHO2fcYN6-PveA
Message-ID: <CAHc6FU6QucixT5jkatPpawaCT4O4JO2kXSeSejb-qQEeUTnzVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] file: add fd_except cleanup class
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian,

On Wed, Jun 17, 2026 at 3:41=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sun, Jun 07, 2026 at 06:41:34PM +0200, Andreas Gruenbacher wrote:
> > CLASS(fd_except, f)(fd, mask) allows to specify whether to accept or re=
ject
> > O_PATH file descriptors by passing a mode value of 0 or FMODE_PATH rath=
er than
> > using a specific cleanup class for each case (CLASS(fd, f)(fd) or CLASS=
(fd_raw,
> > f)(fd)).
>
> My main objection to such patches continues to be that it keeps watering
> down the meaning of O_PATH if it continues being usable for performing
> ever more actions including write-like operations like setting extended
> attributes.

I see where you're going, but let me argue that extended attributes
are different from file data. For example, the
"system.posix_acl_access" and "system.posix_acl_default" attributes
are about file permissions. They are an extension of the classical
file mode permission bits which are accessed via stat*() and chmod*(),
operations which accept O_PATH file descriptors today.

The "security.selinux" attribute is in a similar category as
"system.posix_acl_access" and "system.posix_acl_default".

The "trusted.*" namespace is proctected by CAP_SYS_ADMIN, so it's
obviously also not about file data like information.

The "user.*" namespace may appear different because access is guarded
by the file permissions. In that sense, you could say that setting
"user.*" attributes is a bit more like writing to the file. It's still
only arbitrary information attached to the inode itself, though. For
example, operations on "user.*" attributes affect the ctime (when
changing), but never the atime or mtime.

Also, you're clearly aware that the same operations are possible via
"/proc/self/fd/<num>" today, just in a messy way. The exception are
environments that don't make /proc available. It seems fairly bizarre
to me to make O_PATH file descriptors available to environments
restricted in that way in the first place. And that's the only case in
which processes would effectively gain new abilities.

By the way, I forgot to mention previously that this patch set is
related to the following change:

5daeb41a6fc9 ("fchmodat2: add support for AT_EMPTY_PATH")

Thanks,
Andreas

