Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661F2F746D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872669; cv=none; b=QHvjODuvWi2tpMt/cuVOuXzen4OiqgyZFrH9mBqFrPPYBntnCEremi8WLcdXNCyY7ya5on8albQrU0F+L/TvlmsfG9Pmn4rdL8CgGABdJ2YPLXy1LEZB0byxk4CB15KEvFZXDAuxzaLwCZxT1yuZStyMvtkvdtAUiPNaOd4pCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872669; c=relaxed/simple;
	bh=vCHK3eD5a1YYxFEE/cCWYRJKm0MMDiJQks2EZFp5bOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSglCkLJrBmuiez/KK/JBAKbn2SPuotpif+1CKGYwZINqWxkKfuJCiry7+I0PLxp6Ij3xe4n/enA6c/mTxvmrKrmN2NiihrUMsklX9ewO5YeEkvOxDFU8jPZGOgS5fCnHeXJ/FE1mftDixEpVYjSJudTkh81Nc2wW4vLDo5Vxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIDe5Fsy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIDe5Fsy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-460166910e6so1816803f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780872666; x=1781477466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7pc2lkubI58ARQJzkeFR/9jUb8hNtasdaJceDwOBns=;
        b=hIDe5FsyEyZBu45CVN67Vk/Lnf+0nM4g73aZCYZHVr6iiM4Vu8/Cl5EEqSldNayn6u
         +agihVGV2A5d1qK51YkzGwOJGl1p/0h6PkoitYM0oJgKDsaR3Sd8xnv6jsos9rbZ0+mv
         Gsp7d6aH8g2CAqXXtSUC+j/25Aeo+z20Y0GwrAuN/v8j2B4SfsiHhH0Jo8kyt4dNc+IR
         rtbEfupxqzaQ/hpe3v1BbIYnBjIpzVsAzpYbOmli3TlA7cXm8E5Q95/9VpriONQWdll8
         g4NjaPxNCk1o4UJvsf7CoCXkanPAOa4P0PsBa7d6dN+PFzCy7O7mi8X8PUeHwY7kmGYc
         eIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780872666; x=1781477466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7pc2lkubI58ARQJzkeFR/9jUb8hNtasdaJceDwOBns=;
        b=nkNRXxxKz0gP+YmlRrNXMosh1CLy09u+ml8YBX2NZozPS7/CSkowHhec/wTFiQijJA
         t2HqpZ5m9+gb4gyGw+Eq44NVzclqo3QvmzC+RYyWU2CTBuODUc/ePTozJcm2QfmahIKT
         7jbf76XwFROxrM5R7zfyZ0lvwrk6D3K9xVVm4eDUB1Gupe6HhMwv1pYPUquzlfKh2Zqp
         TVBoXBes79ESoVM1d6MPURX75cD1ZchfFs6yiw2ndCUNCqDR2yDzkGUKvN+tLFqciLu4
         rlTjjyXuEEV70xSVpKhwLWeu0hnIc+PK/+6rZfOl0GsgAwElY/BCwI81UxpeCzNDCe1G
         dYeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fhLtYcVgwMQ2bevjpa3lvvrAVz3y2aVUiGiESzvCctOIOIytvK2n66BM9mVYNFU/enpwl8IVNB+NrBrXu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53CkuSp3oTXCZbvmk+4aoHZ+nW7xZxQMcUzMaBFoHOtsot0qy
	llgQEW8ccF/mQ+lUtUwIB+flTxTQDEiW8UUlKIHfAAe2TITcFjCn3btjryLJ7w==
X-Gm-Gg: Acq92OGOy5qIjTOWYZeSSbvTKD6DLXl5rCqRBiGmULsNpobpjx60TXIU9wOLCCizQXW
	IFjmb+20CYNPDbSmfVchlkvkfDaZiH72sC2NU3JVUR6CNSK6j/GT+X2/Z0XjJjs7uQ59FoJzb4e
	Z4tHc8Pha1stqq4hdMgLo+KmHm75icIXqZgkonSkBn9y2pPL9G1CnjbGTYWHlFCcEMxO0MZcRBp
	u0uRdIaHRsqVsbMhJgCl8r2KYSTWoCG34RWKBPGgyc/dkBnxRp0OMcWxL5TfRoeUcFaJBSA69v2
	kBeG7saST76kzT9aEJOVaKpcUYimMZMi8jFSg/pnJLQEkYEN9H/cGO2b7naF2XGWUTjwgKTeE1R
	RqNe83UtWD/9rT5c3ewKkOXrtQgPsKcSEHsShQsWhVWjmph/CyegfJUi8/df0Wjy5Mh2Lg6r3mN
	XCst8JT7IyMHMHPjp69Z+vO3QBVXmCIgim9kIl9Q+Q4Hlp42KvajNoEXvhFZKHpWtazJFcI+kT/
	ZXwnHwU4Q==
X-Received: by 2002:a05:600d:6446:10b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490c259a227mr147330405e9.3.1780872666058;
        Sun, 07 Jun 2026 15:51:06 -0700 (PDT)
Received: from f (cst-prg-95-114.cust.vodafone.cz. [46.135.95.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d5d2b4sm207383455e9.2.2026.06.07.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 15:51:05 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:50:58 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <zeso7ucog4r7rcpul5oandqu36kdlz457fvh4smmplbu4yxj3p@lxitjovf6s7q>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org>
 <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042109.GG2636677@ZenIV>
 <CAKqfh0HS1sZ1PQCZN13LgzY1sh_2c_yhaS3hG8aT+XYRYYPzbA@mail.gmail.com>
 <CAKqfh0Eke4S3rtbJEx_QbN=Ruz5k+=eQQEHJUyWTRVGfdmpUxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0Eke4S3rtbJEx_QbN=Ruz5k+=eQQEHJUyWTRVGfdmpUxQ@mail.gmail.com>

On Sat, Jun 06, 2026 at 12:17:53AM -0500, Maxwell Doose wrote:
> On Fri, Jun 5, 2026 at 11:28 PM Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > On Fri, Jun 5, 2026 at 11:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > > > On Fri, Jun 5, 2026 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > As I said, I don't see the point.  Do you have any EFS filesystems?
> > > >
> > > > I don't personally have any EFS filesystems but that doesn't mean that
> > > > others don't.
> > > >
> > > > > Are you volunteering to do any major development on it?
> > > >
> > > > Like I said, we've already found some problems, and like I said I'd
> > > > like to fix those before it becomes a FUSE as you suggested. So I
> > > > guess I'll volunteer to do some major development for it as well.
> > >
> > > Out of curiosity - had there been anything beside the "some code that
> > > had been ifdefed out since forever doesn't even build these days"
> > > I've seen mentioned a while ago?
> > >
> 
> Forgot to answer this; I've been looking through the files and already
> found more ifdefs but also a lot of style issues, most notably
> trailing whitespace (eek!). I'm still auditing the files but it's 1am
> over here so I'm going to continue in the morning.
> 

A glance at your patch history suggests you are not tied to EFS in any
capacity. By your admission you don't even use it.

It seems like you are just looking for an area to contribute to and
figured EFS would make a good choice.

I would argue EFS is an excellent candidate for git rm instead. Nobody
knows if it even works. Even if it happens to work and it gets removed,
the absolute worst case for anyone interested in extracting data from
EFS is having to boot up a vm with an older kernel to do it. I think
that's something the (likely non-existent) users can live with.

Note there is no write support.

I did a quick search and found the following userspace tooling:
https://github.com/sgi-demos/sgi-efs2tar
https://github.com/jkbenaim/efsextract

I have no idea if it works, presumably it does (and better than the
kernel module).

So... I don't believe there is any practical value in keeping the fs,
even for hobbyists.

Perhaps you could submit a removal instead.

If you are looking for something to do, there is plenty of non-obsolete
code suffering all kinds of breakage. All it takes is picking an area
and digging into it.
