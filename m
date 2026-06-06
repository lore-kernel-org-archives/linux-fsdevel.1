Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDB2F7F18
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723195; cv=pass; b=W2QxNRuCw1cCb6zJWYoO/VKjir2namu4H/JEr257axiYKlemVidh39IwJdVA18CsR0Q71xhb08c+ooodPXYKfneRbK1e3oyUzoXrmf7aonEcN29aZ1wMnspGOjLv6exV4hCajR835ZQY5ceE0CjFMx7A8MIaS2JkMBucao9695Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723195; c=relaxed/simple;
	bh=e/PvDCE88b21UILd6B6sWFIECY3F+VcPGk/iutZRMkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro+s4OZY5Qvie2pu81l1jc0ZTP0cH/oYbsneSx4NrTth94RE8kcz1NBuPq4qidbQdyeEuNsaU5UJRPLgQie5miSNxbL05PwNfjlMeXDuQAk7NfGK5hrhrJtjsBLL1nN8Z0Q/KhN8GH234EymDXJeRohsDoSJ0EXxbhceBVXSjdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2RCFKFa; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2RCFKFa"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e0fc8ead7eso29902617b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 22:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780723193; cv=none;
        d=google.com; s=arc-20240605;
        b=EjXKUXuevH/+oUELMKxc0OWb3nj9FM7EHAxscy2Xz0GyYwAfeLx1indI4r2OlDOE25
         nolt87R2SNENfLXAGJvIvVBnGF0+xZaOHQMlI0SLNE0mAht6XzRGW044gcZGWKcfu464
         ZPLyEKq6XOTJSdxYBZ3ThMm3E8jY1+6k4jvV0jOfD/NgoXlKhkuFbPJAl6bUlDphDm2M
         d2ZBWQE1YVDSEn/aqCX2zT9S/XPvOfkZgIbSnoRwm3PINWAKw5AlUnUnYsLp6oicZdAe
         88iPQlXCSR0SCIM1K4hktQ0RZYI+uR5fe2YyrTGiS4gKLR5bk4sQJRqriDiUf1AJ9ZZI
         JjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36+Vh8GSxswEU0+CIQjYXLxDJIyv7+fj9cxjdqqtPBY=;
        fh=8SqcMrPbLtmWjYPBi1DMKX51pbOq3k7QeaiQCZ6Od60=;
        b=HUSaATG9H4oWs/pGBYO9ihu6x6saQlecGCA+gmnDfG4nI3pqKS8H2a2gIMLpWnquQX
         dgQd1kHwnTrnu8lCUGQjN3JvY1MMpLi3HL7pyHGSumQUc5z08P5YUeWw+GiPYIYnfzBV
         1snN9XmMzKicwKqBLeBi81lxlLNUMKhE4hFB3LuC+wZMsFwxWz18Zpn8mbTkNl1l1sam
         e71FUFmWtpK0LFJFwHuLd45g+qtJjZEqV60bGQjNpWApVrLhJA3pX8odcN4L4JYPcgtF
         RpiPF6ruAtpsagqFi42sFi08VfNqd1p89/FwMmiiiexgNR5kkmEiAo2KJQWTP/grdrOk
         xB8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780723193; x=1781327993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36+Vh8GSxswEU0+CIQjYXLxDJIyv7+fj9cxjdqqtPBY=;
        b=I2RCFKFag0Ex3SBTaYVNe/V4Qd6MFfFPydJ5ImhnJaxu575XKp9J9ccezxouYZg2bz
         k/IaAPZKx8usWeU+b+/LjSiFRyR9YHqWnE2SRAYVg0yJOdb2OW+jU6V1sX+g3X6WVt1S
         ob9jaZAO8yRmgx+7kXL181nUkH9m4LgWzfdGSZQgZKhUS897egqaezfxQKea8PGkRbEe
         MebaG3P+/jgqYaaKahaf/lAePC0NAqAL6MPfGnZfo2xHZ7K2HnBRp5QWDyex4pDCxYXx
         mOR6KYyu0Gr6Z7s2e42FDS4K8bcZmKowwemB00JUPoH+DuybrgCX8c+k137YsRvKJbnn
         +KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780723193; x=1781327993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36+Vh8GSxswEU0+CIQjYXLxDJIyv7+fj9cxjdqqtPBY=;
        b=BHiZCkuUMumya56l+zDIDH09WNcTfpaRtbEG5vka0OYgAMCrEhrJWwg02ICCHchE2O
         TfG0+zcPGVFCpNbpjMgQ7rG5SNDdjB61lNC7NTtZXQ/ZxD9VlSI41cr6bRZxnwXGuKXk
         HJBDOqVt2QfuVBZfwlac2yjUsb1LXhF8v7xTHAhg/2yAjzr0xqNRQhZujbliN2J9fyg5
         wzge91aVGvEVEBu+XJsC+uXa18IogUvYmMMQY6HiOrBzf7g3utN7fZI+QjI4fvD0rkX/
         MYVmn34p9bXpdDOMQopz6HQ/JXCrP8iSdHOnodON56zmXaumO4q86KKF1eSb3eteBCPO
         Zqkw==
X-Forwarded-Encrypted: i=1; AFNElJ/FJoleMAZEi2FlOJQCQfY0DFcR430W87N+pYChV2YQqW4MYlx52BiKCsEdcu5OjQY6EvMQuUWJ/F7BUsTv@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZLDcNThC15pVJOuD7t3KS2u8DMdWz3GBunJXhRdqmoXn0/JQ
	8QoAuixP+Rw+4VDmmqJ1emjEdDTSLJKfHuUeGOLySvyGL4AzByRb0OtOVgCCQqKpaPelv+1uPsw
	UC3kx4IRP0Nbd2WHglslO6wxty9d0/Vs=
X-Gm-Gg: Acq92OEVZiWKI0f4yr4VVPL8FqVlJJZ2phDP3BRUX2/rAfbQ0BhoDMuzyhC8z5A7p/1
	okiph5EwSFMu1NTC3FGu58Mkt19ctT0nX6PMFUppY/8cIFlEs4RhmSdlSX6f2w2L/lQWwLTF8Ea
	EY6SrdWLJOWJvy/qpJAFspoqvpeN1gtq9T0BTY/Q9eFEijatFavGjAafhbIgdYtIoH+TzVxgO5v
	E5dBxp+iQxeibmbCq5hZmFgRv6LeH0HVZuQpRtyTY51j32L0l0TTPXWCpVCu8ZRn1yA0zil+X4y
	grcBoXh7JQl6WaHapjQhawc7hUP3
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id
 956f58d0204a3-66106e01386mr6191406d50.4.1780723193247; Fri, 05 Jun 2026
 22:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org> <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042109.GG2636677@ZenIV> <CAKqfh0HS1sZ1PQCZN13LgzY1sh_2c_yhaS3hG8aT+XYRYYPzbA@mail.gmail.com>
In-Reply-To: <CAKqfh0HS1sZ1PQCZN13LgzY1sh_2c_yhaS3hG8aT+XYRYYPzbA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 6 Jun 2026 00:17:53 -0500
X-Gm-Features: AVVi8CeU4VjwEf7ZuOF5_nBJ2qzHNXnpoMyasnivil8JBOLZ4WWoFlRDQ6z-6Zw
Message-ID: <CAKqfh0Eke4S3rtbJEx_QbN=Ruz5k+=eQQEHJUyWTRVGfdmpUxQ@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:28=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> On Fri, Jun 5, 2026 at 11:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > > On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > As I said, I don't see the point.  Do you have any EFS filesystems?
> > >
> > > I don't personally have any EFS filesystems but that doesn't mean tha=
t
> > > others don't.
> > >
> > > > Are you volunteering to do any major development on it?
> > >
> > > Like I said, we've already found some problems, and like I said I'd
> > > like to fix those before it becomes a FUSE as you suggested. So I
> > > guess I'll volunteer to do some major development for it as well.
> >
> > Out of curiosity - had there been anything beside the "some code that
> > had been ifdefed out since forever doesn't even build these days"
> > I've seen mentioned a while ago?
> >

Forgot to answer this; I've been looking through the files and already
found more ifdefs but also a lot of style issues, most notably
trailing whitespace (eek!). I'm still auditing the files but it's 1am
over here so I'm going to continue in the morning.

--=20
best regards,
max
