Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51331E85A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800557; cv=pass; b=k9z+1uGGzXJbu09Qn5UWDAuoQkiUrSU7UN2AfLAhjjYj3N5q7PVUcoIQO0721AoYuc+1Au1JOtDp2Cdm2oYlH05H440gndTBRweee9i8pAFjV6uJu2lqtLvcQXvU2eopcIMHAELfQxzZMn7S+3Gjy0KTWNIPA+5kOnYmST9xHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800557; c=relaxed/simple;
	bh=iIKbBk4HKqfervHjsacMkFpVYiehHpkjAY/I2n/kr+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYy0ngBAObJz5dVrJC3XMVXODI0a8B1v+mvUrPFZGcwX6JILjwIOAfLPdWXxwYEFvEnwbxNt+045n0uGjfJao7Yi4l8X0SEA2nVw22cVi/F9y4B2zZLS43cFPjRVXsiWIbE57CNDCienqlYmfPo1nOIclBgqhG3a9DZ4BFLIefk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHIC7X5y; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHIC7X5y"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-676d8a1835cso875844a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 12:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776800555; cv=none;
        d=google.com; s=arc-20240605;
        b=OEb/gGuDTqx+5PZ86zrRaGiBDBaho01fBkOHIZ8HImj9QBWirGelIqqFZF5x6zFp0e
         WwLnUxCbn566izuM/iOy67/4EYELCzY2i6drMpv8IK7eZFJr8zwJpv4ZIoc0MZr39dDQ
         PuJLBSJTVDuVrLEqWM2CFyrjY3OvGXtPZKFff6s7tpk7+N/bllsEqlUSx0l5hDgqvWUH
         b3gq4ymDI7dLIkJ+U81Y2fPJPxpJmJBtYceTifPDTFO9IpRKXNQqNykw8VOExYkvEwOG
         gVXJ3nRb6mQtrK6kO6I2VFwt7RjkFY86s7AKM+ZHU/j85Jjs7zCFTIySNvhSgJHLwoBZ
         A8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bQEGpwlg/tsnfF3dAhfTijBwJZlisda7Mhtu/H/aTdk=;
        fh=0zwYgWMqZNPFDrw4sXP7/4gemqS/H4GKhgLMLoldG7U=;
        b=kpRNrftmJ3BjwgyqU9FmdgmK8upxyM6f0geEs+FWL5hHjTUR5HQCYoZxZf9rsopBGw
         LB4tI5u9xmxqFIHY4a4czabHLrXCTQa2WUnBl8NrcK8Xavpif++i85kYYXGZwnyYSuVC
         TnOQaWlHiv0FW6l93dBEiU1hXB+Z3xgYXZQwuAcxPFwN0DjUQZZVBlr/kWFk2aTBgwFp
         Vh0MsweNF1dRJTz8sAxcqsSJbLpEel66mRN6OQ7StO0yg4GAs6I0m7jTRqmTDVL9Metu
         YxOZx9DftU+4Oadj8nFbPxQebZVpabVIO5KDQHuVBky38vNK0NXKxKCVdfJAjnhm3i1Q
         5GUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800555; x=1777405355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQEGpwlg/tsnfF3dAhfTijBwJZlisda7Mhtu/H/aTdk=;
        b=UHIC7X5yYXVch1fz3EQkWbVb68oaWmC+PbUDx/EWaJk2jYiVvboEY277LLITG76xaP
         CQNtndHoNsArXfuu4As8IIna+ZKA4Hpozup7WmsAtzkTQKITx+6AbYGEApquXarxbMCP
         6keo7LvPzfmvA/q2tchOwT51evBwrlDSBfGkySOLVgTrejJDv1NkowcYP8QrRZzwZhpx
         BHSV9R182q6f0SnRaAdxy2LMiVJDOa/KPJVd2ioJSBRCn+f000n29R2cxizq29lxp0Xp
         5d2nIULYN+JaFeZoNQ30x+O02C5HUhkfkHo1iN6JOrWWY68D9La/9MGCwHSuFAWPIh6g
         vJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800555; x=1777405355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQEGpwlg/tsnfF3dAhfTijBwJZlisda7Mhtu/H/aTdk=;
        b=phyNywPd4XxywDTdGbWV2ObJEj02ZKV+/65jNLf6ZtwVRlTiDrAT04KiwwDeTFW/N+
         0M3e8JrCCUeWrfb7+iuxFTh34CGMjbH2RkcTbLyigp8unCq4gVAfmlkB2ohwXcO0/+Uq
         dGqjdQazgwtFthjYVlqJL746FvdqXExF4HTotWt6QuQZdgkEwsPwlN3A9lkxorr9LoAN
         g4Oqnbr63nYKd29bKWmjj/0DVBsqtuAaklNywR3NQ1bSjzDZ10v0t9IPULBmusFfWKC1
         E3GxYVNXvXh9Vx4qIFQKFFIkTzlMUy3fVV1PbA8UQeqDxNv4U+0fmGis7FGGAdDLI6Cy
         Qpkw==
X-Forwarded-Encrypted: i=1; AFNElJ93/HYEI/bBkCGh40LJPXHmbEiVjaXUKRDnTPUJmOzxC9W1Fy4FLeP/hpKa7/rKhr1rlFKaTB1VL0orikCw@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/ez3NhDOInxxAbqNA0CPGIrbTwP9LgO7NZbPNlTyghIKDE6B
	2lVS/RKFrs0kY7hNXubD2LdG7JWU2tLiVYTx2qzq8GQOd3/QQ/SmRl/mPbakDgOzpVd7AaPUqSF
	adyHbJrMFKI7FC6bQBTZTZROBDBIUTMk=
X-Gm-Gg: AeBDiesTK46BO5BbMIebNR6/uhNuW3z+44/yvLV2M2P4SwG07Bz+zLL8pJ19KzvNXPD
	kVM/4BLr3xYSw8GliiIQZQHROq2OHgSqaNAmd4/wMqxFo3bwCM95DBb1c7zjABQvtIj/sDBeRzW
	bvDG5yqinrZKh2Ihk3yV8EC95gJa7KA5FhRzfZIWeLMudSoV44cBdnSnjIqndC1hScl4eFW79am
	1jg1QmS2vOkFjpLls0Jz0uXkhao2iaKiiWKF2tcbEwvhO0AyecRf80vOMAODJhOeba9U6ssLxDR
	lT9XvGqrSVqoE5C4y+QmWQxqwStSXm7zmuzurrMfethId2OUIeQE
X-Received: by 2002:a17:907:6e8c:b0:ba6:e18f:1568 with SMTP id
 a640c23a62f3a-ba6e18f1a53mr555491166b.32.1776800554382; Tue, 21 Apr 2026
 12:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr> <20260421181026.GG7765@frogsfrogsfrogs>
In-Reply-To: <20260421181026.GG7765@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2026 21:42:23 +0200
X-Gm-Features: AQROBzDzrb7-xpMSuMGwEPrWzB8WpnEp6ZfuNkn2u_oPFShEYZ8NbkT7alq9dGo
Message-ID: <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 8:10=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Apr 21, 2026 at 02:08:13PM +0200, Jan Kara wrote:
> > On Tue 21-04-26 13:17:34, Amir Goldstein wrote:
> > > On Tue, Apr 21, 2026 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > I definitely want to keep a clause like this. Maybe I'd just reform=
ulate it
> > > > like:
> > > >
> > > >   - Handle security issues promptly.  Both those reported by ordina=
ry users
> > > >     as well as those reported by fuzzing tools. Expect that your fi=
lesystem
> > > >     will be subject to syscall fuzzing as well as filesystem image =
fuzzing.
> > > >     Dealing with maliciously corrupted filesystem images is not gen=
erally
> > > >     considered a high severity security issue but still it is consi=
dered a
> > > >     quality-of-implementation issue that should be fixed.
> > > >
> > >
> > > I can take this version, but tbh feels like debating this clause miss=
es
> > > the main goal of the doc, so I'd rather go with something a lot short=
er:
> > >
> > > - Handle security issues and regression promptly.  Both those reporte=
d
> > >   by ordinary users as well as those reported by test bots.
> > >
> > > IMO, getting into more details doesn't really add much value to the
> > > prospect reader of the doc before submitting a new filesystem nor to
> > > the filesystem reviewer.
> >
> > Agreed. Your shorter version conveys the idea and the details aren't th=
at
> > useful. So the short version is fine.
>
> I still want
>
> "The filesystem must handle corrupted input gracefully without hanging
> or crashing the kernel."
>
> to be part of this.  Not screwing over a running system is important,
> The guidelines ought to make that explicit.

Agree.

 - Handle security issues and regression promptly.  Both those reported
   by ordinary users and those reported by test bots and fuzzing tools.
   The filesystem must handle corrupted input gracefully without hanging
   or crashing the kernel.

Thanks,
Amir.
