Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F6305E28
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327330; cv=pass; b=sLpaB4S/JKGdL7Tt5Y8DEAKWeWGgImcUlNtIgHgCnoBzy2R0W1jNP49Dq2GOXHzsbrPlq1CvDMoaCflkN7VU1CwOd6bIxG14VpheDsCo7N7BHcQvAZzlLykT3l5dBH5bdsnLPEyKyiSA5wPT9bCAOD7i3SBPRiA7V8kLqMl5jQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327330; c=relaxed/simple;
	bh=s1vJ8mKBOUDI7dmycLNBcqgezjzNgpM8VRQz3CviYJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nljgzTf8ZdlAYXSwaTGVzO8F9NHhCegIwE2r17EbFni0IyqBaLJHuJ4FW5LOevHylj4JZydxMTrfchbYM1UOHJcEqYnAs6BziCxxjzuws+f960rRDmEsVCWEod7MFYl61XzyzOGcTWNoo2bt9WJ5f7qVo1oiVLa+ScWXRVnR4aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+A9UgsD; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+A9UgsD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso714782f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 11:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782327328; cv=none;
        d=google.com; s=arc-20240605;
        b=f4AgSmS8SCzaDT67nPnqyAG2SnwX4iBeTKc7r0Dm4fUSUSzsAlfTP+Q/W4ouwk2hsL
         vndrzwM0Ijc85YyUAdfJ1LH2+sV0C5IQ3jmjEu1GTHAyXxq23BIzmxmXwVY+UbfO8LNA
         QmcUaUIBDfDzxPBly+uDvIpfABXP/jjdlWcuoAtwHJLH6e0d886ocRHnAPC+9mzkIabN
         MT53orRLSYtdI45TITxjts0gi2i7IfkVAjeN7Kew7NHQm5JHJpuALS36447o02SyXf3t
         XRh95OBNZme6oab3GBVt3WaJ8I02GAJWDchja9snyKfSlNVQ2nLWTJ6WO5dLzGJbw4MB
         tQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dutkJQvZ88RyivrUq2VuUFVtInmTzbSSO0Nvd1JQYws=;
        fh=AKDgc6pkmBtW9R30G1jBOAWT/lz5vjY/kmmLmCNmups=;
        b=Qg28syQwoLz78mLyiXBuAcwPDUtHwbDEGnsHHJETTpnhmxjvgea1KscK+7/0bnoDwh
         jonaT4CkbdpIJEhbJ/m6C4ElopbcICHELnrV7uskpGecIRDMIBX5xyqqyU/COhOV0ScB
         BIU/0HHhGGtLG75LmTfBqEF0+qb4zwaUlAMHEAdx61XBsTtKKw0i8okLCCQkj58SeOjx
         SzYaOZ6Kr2ofXV63oM4MoPwu4HUJ53Lx/ZnnijFUfES3oizu2WbtAbNkyza8l22ohWY7
         SfY6cXp0/NbWhiTGXTDfJiTzTjwbGzFS1ojx4AKzB/v+HkIxGDAaaMuV6C3f0hZ9W6Tt
         oOTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327328; x=1782932128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dutkJQvZ88RyivrUq2VuUFVtInmTzbSSO0Nvd1JQYws=;
        b=C+A9UgsDwDKVPR8+ubtCz/IDoPAFtiqMJMpoZbOxljif6UCtvvFeGtNZEMqjBBRBiZ
         6AmmN5g3uLSmkJvwdRsmxujBZeDV/FqeWHVNPz4E+52byjOJEOj9LKZyggBmEtGBucsn
         DY7Sotewle5G3oPHkJMqYXw/IJ7FHxx32Xe22oIL6Ok8i3DqkYJ2+pS8OqL1LGggPoAV
         Q+B503HIiBtRz+S09yKhWy8RdSKqKkvMgCIEMpWrfeIOTzqCpbPb3J4R2PgBDr1etWKh
         RRw98B7bOQJxRNedZbsSTsyjGspygSI1LJJ1KRmL/L43ITMnNd0UeOStg9QxXyOVtv49
         nHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327328; x=1782932128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dutkJQvZ88RyivrUq2VuUFVtInmTzbSSO0Nvd1JQYws=;
        b=EtH/2vrSwhfKs0XqiLH9gvMMOzW+bLMBjaP8T4YbbgnRNpxOCfTrK0zTcH2L/GEF/a
         6FkaGOjjGtEp9qym8Jzf/Kd2apzy8H/qUfJqnjEAyZIqVvtADHRKAPCkYtLgcqTRiI/n
         mEtbfsL+k+I/Ng1/RoPL6L1GyQDn4DNUmO1QEQ11uPahI3MOz6ra00FxmEYGIOtuGiJS
         t/kzWcMCn/yfMjZixyEgdQ3xpyZxkK+86AhYib2683ClfVat7xyPoCQ89QikiYqHuwck
         XnZSvQ6lskkrMoOQyDV8yoOPfqoMp+wQSbwljt6GKU2CJuuVgTrZyCtJYvcH2fMyPWti
         QPmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTIKY001L+iwfnEiOhUJii7cEHOOXtVpjC4/mPiu35fu3e8NgnNbWnDeYFudov3QHQoy3kQrlqcbhQfcyE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/qYdJFMzbTQYHqPL//lIM7fvHv2indkD5ixolt32OLUnb3CZ
	PoYt6hxMURQpxi9jWZE/8JBq/E09i5CtDidyCsyOBI4XxtQ814blCxQIxJ2Z3DppvgmbgbUs7tr
	bh/Za8utEIlnuJikbBpRTqN/2IP/YctU=
X-Gm-Gg: AfdE7ckzt3hnDQ5cyiUUjNs1tPZzEKmTQD0ZxKuvhAUF4SmobyCrYhy85CDXUuNeOjB
	u5hLal9t8mubwh6WIDNUleUnUP5jJxoLU/NqhBkdefCqynh2iIj6mpjLkbge/XVDGqMLM+221p4
	E0HuTk8sHNTy5Dqi4W1JnqN3YQxWgiCm9j/nJdt+cOR9Pj+C0kwOF+UsFQOZ3xTZ6BhYSIx/i9j
	DnBUc2f4JY3KYbWW+k+X8mWnNl2+2a/eAJUgCGLnZzWnZIr5NXEFmLbSGDMeh9Yrf+LV0PNTTUc
	/EWcuwigtkqwruZvLieMIne+nc6X0YjrCkDaFGrL506SulUotCk4
X-Received: by 2002:a05:6000:1ace:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-46662334928mr32467994f8f.27.1782327327620; Wed, 24 Jun 2026
 11:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623202843.2064992-1-joannelkoong@gmail.com>
 <20260623202843.2064992-3-joannelkoong@gmail.com> <ajtPMgO65FA1TXhi@casper.infradead.org>
 <20260624073625.GB12359@lst.de>
In-Reply-To: <20260624073625.GB12359@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Jun 2026 11:55:16 -0700
X-Gm-Features: AVVi8Cf_rkFidIUX6JYWCVRDA5nByM1ZWpGheMNA_h_5f27vsvoibl7LK2mr9uw
Message-ID: <CAJnrk1aDt4o3hVLfnW0wEZrGE6xw5XXspB5vAg001gv=Ntu+1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fuse: use iomap helpers to update folio uptodate state
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 12:36=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Wed, Jun 24, 2026 at 04:29:54AM +0100, Matthew Wilcox wrote:
> > I believe this to be a bug.  I talked about this a bit as LSFMM, but th=
e
> > fundamental problem is that the folio uptodate flag DOES NOT BELONG TO =
THE
> > FILESYSTEM (unlike the buffer_head uptodate flag, which definitely does=
).
> >
> > The MM has a number of sanity checks that make sure we haven't
> > done something awful like mapping a !uptodate folio into userspace.
> > That would potentially leak confidential information to userspace.
> > So when a filesystem clears the uptodate flag, the MM can come along
> > and bring down the whole machine because the mapped folio is now !uptod=
ate.
> >
> > I know we have a terrible writeback error handling story.  But I think
> > the right thing to do is just take out the calls to clear uptodate.
> > In all filesystems.  Darrick took it out of iomap in e9c3a8e820ed but
> > it's time to purge it everywhere.

Sounds good, thanks for looking at this. I'll send a patch to remove
this in fuse.

Thanks,
Joanne
