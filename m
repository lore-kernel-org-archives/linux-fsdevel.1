Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429D2032D
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776596633; cv=pass; b=c48mGqIBhtvUGMjHRo5bHrJTwWOc42ZwSZsyaE7P1Gte/QHLHRVAvUkV8mdNCOf0A7ZZRtkwCtp1TZTARfCIviwUav2gTLj0QKkwez/oYj64or9nU8VCwt4YpRhmLlB+0PJD/npMlEi5dqVNFSTvPjw7yOrWcKucaCgkVjmvxFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776596633; c=relaxed/simple;
	bh=c7zIAVr8UFjLm0+X2Me7QtrejgsWF8odAGkEEaYe+04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POFzbVtPlp1VuH7wbyAnF1jRYS4ubCEFX3OnyhzWk7Zdz0sxAhD5jfcXuxhzmoNTvcOKUJuMBHD+9UWav5VnPdjN226Us4llUIfwunM11TYjk8NpJuqmUYzC3/p0ZGeZiymAcgM9WIZ//RSoEoo0K28wLldWgj5scegg9Ws5E3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWrkRbgg; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWrkRbgg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67482e67171so1441904a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 04:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776596631; cv=none;
        d=google.com; s=arc-20240605;
        b=jAyQhgntuzKjuxnywRfeLFqpj7xawxwkjsi7GgWrPyyQ0S5WUgnxYRbc9nCFt9E1E+
         baBg4AWXPwVDGE966JDs0iFmM/J2vjWJtYFBEVFdazFB4biPxPG3R0j+jRlYujq+1zPg
         vlYn7sMMsfFzrk7cTVkyvVH+hiQO7Cp8SWNoYmawPBSsbXe5ch0njp80ZfDCBshgM+uI
         ny8mmUweQBEvdhOqYWVouZKtQCm80AkZhCA8zq9kRkNJBGI1dZT0rLnzMnNA+Q01Rz+q
         K0fj6BRDp6N8bnU4sa3IIsXeq5y3WXDG1IG9pIYpvfY1Mbp+lF8pA5gAoXxCa8Z+/LI3
         AxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gs7mr6J3kVp2btmikvy4mVvgWujo5IGx13uqLF0eyVA=;
        fh=Wov6kvKlO755NpDkFOJ2vCgXC1IC01Gjs32rID1ElKc=;
        b=jiMs0CyOToLwOwLmgS6QvEhIDfliu9hIRCFJud/byRZL6gJfqBxEKY2bCNx85g+CyZ
         Cfo9MaUf+CtOW/5mJVRnPogxdcpC1omo3U9v3nlHbv7ikJa4SM2Xo4a5sE6pECoehlpe
         Hza4JHFlB3K5FVjgRgEichILadVR85EnXkpj/d3j/wT1TSHDKOjG/yf31r4Ywj76NRKK
         e0uvPGWWmUKeo6j/d1qaBpMglDvrmaG2N3IX5eaUD7SOCG6/vC2TlLTQS9TecOumeEHN
         kSE9nCTDNgftH7lBYg15xhdhIFwThI00FRlIA5gvyGPdffgHip5G/qQMGAXMGoa8jzYx
         toSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776596631; x=1777201431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs7mr6J3kVp2btmikvy4mVvgWujo5IGx13uqLF0eyVA=;
        b=iWrkRbggjAym427p/eRp7iZzFxjwSnfqdnEGhIeg9B8aVhL9j3Rlaepb8LprZzXhRm
         hAjJ31y3a4+aWVfQ9z2wT71s62Z8GKF5Zny7iR+YC4PMlpjmw04YD0rx2ovhLhy8yrRk
         iXIsi6xoVksCr+6rQChLZGDKRv08zA3X4nf4bZVFnVTkc4cRiQAkB1s3bIGyiETkeniz
         cNF4ZziDav32p/1QcqFHAEPSumgfdKc9240UiU1A3npdrJISEE5MgmyRrPGtCyT0jyqZ
         o+9x6uy+j6HNrJKeusXiR+FUshetO3XhTnHM9AHxcKyeRp/akK8qGyWjgMtLbI2UCiY/
         I8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776596631; x=1777201431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gs7mr6J3kVp2btmikvy4mVvgWujo5IGx13uqLF0eyVA=;
        b=dgl3sBHjDNHqDKyXnx2d19tZtX41a/ePjqsU4EqPWY1xArV/R5vWLVhvLc0oDydLnM
         5S0uO4TYAeC25GxdjNJRwx8qyygRepBpNem6+8x6HIOBq02jEIYsm3CTzdy4IIi32WH+
         taNAGNqWfLABrzpKT6R9bSMF4TqOJxrvFy24rbkUr84+MQMNwO4hLOFh0gzIvXX+BPBK
         ZxvK+NV81dN+oOJT9bTISm7unx/JraQCHSo+Uyrw2oqoVxQohvsYJON/HW2XC94jkRCb
         4VhwCYrLKHItJvLGOGW+GYP5J4Shavj9R2UGqb+hdfDkRjscwjZNHCLYrKQbURC6z6ge
         Jg8g==
X-Forwarded-Encrypted: i=1; AFNElJ92UYhHUshEeZbMnwUUrcrqEX1odV6J/wdZUysKGpZ/GEEV7Jm5iVgJv+oxwK1AU2Se0ed6209L70VcD76O@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIqZg+30Xck9mdSvukEh7YHwBt01IQdCC+qrpzr3K7GMOu5JK
	7Wocp693obgFOZl1PZJFvff6p5By3hNj8iwhX5PQJpI6DOF9B0MI6OdiUP3fD0hK25SOIsb+CKF
	TE9ee17zSyz+F6FtufO3TcxpflFvS20nPuGKiKqA=
X-Gm-Gg: AeBDietPrgX2yNfi2VIwmHnR+37VYTfyGnjmfEsj3R0ZXRRx25dsTXlPziHbSJP7gxR
	zZdDBes5ptBbpLpAUs9oiQ7hhbYRCuHS5trmJdEem5QYGofEtpR3fvAnVqIsDFty9nEzYMMiGnQ
	SIb0pdpSRGFftoHvLF/sGuO9af44Ufo/gDF8JiqdnRBeCcinKyxvCiYey6omDNxA4chHtlYwSNV
	90hpL0Dm47oFfE4x/WygeODaGUSHrtTOTRNovDe7y1HM4HPssw6sfgtSrysyfRqFLfHN90yKx9V
	8O/JOV8c6lo/totuZJ8JbPlusidxX4uVxBu3CBTl55O0OGnN7IE=
X-Received: by 2002:a05:6402:3593:b0:674:7363:3e8f with SMTP id
 4fb4d7f45d1cf-67473633f4bmr1414385a12.21.1776596630200; Sun, 19 Apr 2026
 04:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <aeP4gT5T69izWj-m@casper.infradead.org>
In-Reply-To: <aeP4gT5T69izWj-m@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Apr 2026 13:03:39 +0200
X-Gm-Features: AQROBzBsaKG2rBmoyXHq5GzK-hQwCfmxKJZo4ncNlFMXtxYgM_AY3ihcc1juSA4
Message-ID: <CAOQ4uxgNdgJbqu0X+DP59=-fZNOrxx-DZPDo7dt-QNNqV5H0yg@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 11:32=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> > +Be testable
> > +  The filesystem must be testable in a meaningful way.  The
> > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > +  framework (also known as xfstests) is the standard testing infrastru=
cture
> > +  for Linux filesystems and its use is highly recommended.  At a minim=
um,
> > +  there must be a credible and documented way to test the filesystem a=
nd
> > +  detect regressions.  When submitting, include a summary of test resu=
lts
> > +  indicating which tests pass, fail, or are not applicable.
>
> Perhaps we need a section on fuzzing?  Maybe something like this:
>
> Fuzzing
>   Filesystems in the Linux kernel are subjected to various fuzzing
>   activities, by academic researchers, syzbot and malicious actors.
>   Your filesystem will need to be robust against not just random
>   syscalls but also fuzzed (corrupted) filesystem images (for block
>   based filesystems) and crafted hostile network messages (for network
>   filesystems).  It should react appropriately to such attacks,
>   by repairing or reporting a corrupted filesystem, but not hanging
>   executing BUG() or WARN() statements or otherwise corrupting the kernel=
.
>
> Happy for you to reword that.

Too long for me :)

I've included a mention of the fuzzing reality in the obligation for
handling security reports:

 - Handle security issues promptly.  Filesystems parse complex on-disk
   structures from potentially untrusted media and must treat security
   reports with urgency.  Expect the filesystem to be subjected to fuzzing
   of both syscalls and filesystem images.  The filesystem must handle
   corrupted input gracefully without hanging or crashing the kernel.

Thanks,
Amir.
