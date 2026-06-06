Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879732D29C8
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780720225; cv=pass; b=mckixDsVSH7hzJGoCP1g7mKRY27uCvECCHoRtxCLQy/Xi/lz5Y8viY9Zf0UF5AfsOkqfBZCKDY9dYg6siSTJ38KTNp2xlPac1ZCa2J/75Fl4hGyKzxt1746QLdjgk1ZxT/siw+vrEuJtlCR9FDAa5lZlL+d9+t/ulVq8iCXpYgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780720225; c=relaxed/simple;
	bh=XQQxDtDzRMmMJZII6PknFXZflwCzsuXUqG5L09Z9OaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3pV9RnqCK//exxdBKA4iUKrUGKCzF7BP4FgBlqZ3v+Ulz6jnM4+Bj03EBcWhioDE5gn2t63F9pSe5ZjySbdHwm2QVJM0YDEiROJ9wAVRu4hMSFzveWmqyV4jFoDyC+TzrFF5JqTnRx7tOt0wjisEgTOB7W9X/Naeb2hS4x8ZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwg4Hgp7; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwg4Hgp7"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66039d3efcbso2838725d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 21:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780720223; cv=none;
        d=google.com; s=arc-20240605;
        b=I9VTBopMfp7nmlcj38J5rQl/W2B1I5DDzsqPAsv5lTdxcMgn6QL+4D7OcGTiVyLP2M
         +crFVfbJSFwqtwQG3ijY+8L8ybyLzxHzttaWk2+smtiaPTwNO6gVgOUVEFVPKSxEaPz4
         iXzK5wOZLDQdskbApjC1wgGTNjQPCrClPqAvPJf2t5/u6Rwn+AfbN0goVY8Vp4Hk25k9
         N+UGxrMNa24OfviKvFh5fusikNwWPOGC1w2OCKeyV7X/3KjDfv9lZvLvqU2W+cYPrenf
         8YlVzAKWAD73z02HWCvO65Lz93o2f8PF/N6z6vWaw9L2xyWYfl7xmDyyf9on021J1vpn
         kf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62WuqERXA5FPJp8ypLKP+GnAfe3bQeATucfgF80FZxA=;
        fh=UYOqPHiSahxtu2GiADOp4ZHKq+Bmga8ErZauh/BSBUs=;
        b=QCMxLAuEAMXUJ5aRLXmGtzVNDdkCzzFQNZd1Me0O7zT5oGE2Ifo1raHK6kScPo64Th
         EeT3NV4X3CgmoDQ3efPKtJjzh/k2iayWl2id6Fp7NYhaX/pB2wmv3ToHjBhELJMyHZPI
         1uQfoJ68X86xIUpuIgyXlrAU3EP+BkfQ23GDblc8c+zdpfBvedL83sz+eMU+sF1jfS7R
         zy1DAUMtb8hPhTi/l6ksGUQhxRS04tfezemle8yty18Yb9cEj2JrN7mSZYDaWN3NfHe5
         JmpRUm7kMyMz6pE9JfpHKVLHdi7ANVUmA7dM+/oCWv3VwQlPMKRQzNG5auy+4Tc8aPTR
         6+lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780720223; x=1781325023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62WuqERXA5FPJp8ypLKP+GnAfe3bQeATucfgF80FZxA=;
        b=hwg4Hgp7zVlcPyiMp7dAJmruLmmSIFHh04i5pnm77WARwxLnwCy98BZsMTkjktQVvw
         mD7GI/RYsdoKtnUJDiw1J+d1D2iDZbCWf9sGOgciTEth2v5vjWFPO3hXV+OtcDf8MLr1
         XkNwI/2k8e+52SJmQEauZw0nzU8lWnB5FAZa2T6RkkDMWFGG+VCtnrtfH2PkJtHloy8t
         nHp51F6OfbiQPMKViJXrxIZfqD84niELSkf0ZP1KZXd+A6KTZC08YtM+7CMhMvZhlPx4
         P4NgU7DhYgMec3h7Xba9jQ1GODbI+c7eNRJvEyzHR1/oH90o8YQlGih5HDln3AT+wtcC
         z1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780720223; x=1781325023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62WuqERXA5FPJp8ypLKP+GnAfe3bQeATucfgF80FZxA=;
        b=APWplt7xTKlSnCD70UpilRez1WlI6HNSVv+83cphD2gM3wjNZDpm5ziu8PD54FSAQb
         15XCIEWUxL7wmxvP7A/FPYmw3rIUkNO/36O2378JzQcGmNFXbhY15iUWVdQTEEvjzc52
         zSvXwgBEUD3C0MiUNnb44yP/6L+vGpj3It3czZGe174LkWBErh3qDdIYaWLYbtoq5t4D
         3Q0pY0q+McazzeYZtw8MNHwfVQX35ET8dTiupmf33FOXRWf6lVnxI4EkHyYmImWA1MIo
         LCUhb11IQodqEklVl5S7ri5cfTHKkBTZPupQWwUkywDN2KPZHgJ/DxE07YW8OFUXzm1F
         aPKg==
X-Forwarded-Encrypted: i=1; AFNElJ8dZccU7rp3VnULxvgLx1Nw+hh8wJlsjOvvwldB5KBz83RivD2vtLihyVdvX+uzt2iLDyH/5mAdXSoWeoTe@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEQq9zua6q2W0x0VX9hGCWfcO8Bp0L+pDHcJv+UtMGHDd9sOX
	6ksVxalZZADkkBDlDYxcwhLd+YFiZuaxOyAT+NT68DuPuFrUKbawIqRmu6IdDUO6RRrcgJZU4ZT
	8H4ijJ0aUxFntn9rzurDv5lVdNh/FHLQUDit/njY=
X-Gm-Gg: Acq92OEMDs7yo2qmOazh4eY5cdhaiKKpE7g3CZFzVUEWVTbXyium1KcJ8TFyCV162oi
	HSOJWJoawncY5TR5Hk0FbkieJd+iMjHjpjX/4csq9bg4y+1AI4B/AqIuR2Q79ptO0Swb7yhdc4F
	pw5yO7PYRh8R/hPJ8WwmLd5NnlQp8WmGkcq6po4Od5WcFyYJ91VkSHqOvYqumnCFI1OGQveth3h
	SEpCHcwd55qpILhirbjk7JtWAO20VcqNRo87f79vdHFb0F5DX95B6DfeUuVOCRg4jlioVlZUw/E
	2B2Jw02xyEyg0xG8CLlSV8aMJhvd
X-Received: by 2002:a05:690e:1509:b0:65c:c744:36d4 with SMTP id
 956f58d0204a3-66106ffbf8cmr6262140d50.59.1780720223407; Fri, 05 Jun 2026
 21:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org> <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042109.GG2636677@ZenIV>
In-Reply-To: <20260606042109.GG2636677@ZenIV>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 5 Jun 2026 23:28:24 -0500
X-Gm-Features: AVVi8CcWW1YzayETsqwlp8ktoeoOc2Q7tN3BdxedPp1xN_wSWMPtRLLYYlHV9-A
Message-ID: <CAKqfh0HS1sZ1PQCZN13LgzY1sh_2c_yhaS3hG8aT+XYRYYPzbA@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > As I said, I don't see the point.  Do you have any EFS filesystems?
> >
> > I don't personally have any EFS filesystems but that doesn't mean that
> > others don't.
> >
> > > Are you volunteering to do any major development on it?
> >
> > Like I said, we've already found some problems, and like I said I'd
> > like to fix those before it becomes a FUSE as you suggested. So I
> > guess I'll volunteer to do some major development for it as well.
>
> Out of curiosity - had there been anything beside the "some code that
> had been ifdefed out since forever doesn't even build these days"
> I've seen mentioned a while ago?
>
> FWIW, I've no preferences re efs fate; a simple block-based r/o filesyste=
m
> is not a serious burden, provided that there's somebody to take care of
> conversions on API changes (mount options parsing work, stuff like that).
> However, that really assumes that there's some way to test such changes.
>
> So the first question is whether such images can be found.  If not, there=
's
> no point whatsoever - neither in kernel nor in userland.  If they are ava=
ilable,
> it might make a useful learning experience...

After a quick google search (and take this with a grain of salt), the
utilities to do so are not compatible whatsoever with modern versions
of Linux, however it is possible to emulate the environment in which
one could create an image. I would also guess that images for EFS
filesystems, disks, etc have been archived on the internet.
