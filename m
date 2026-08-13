Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702030E858
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635231; cv=pass; b=Dj41oRNLFgCziE9Y6RP3xXhcEXoYzvEnroTE1YTxgSxCkrYDEuP1Re1VudutPjzU/otoA4vuh6VLo65OX6avbRtIHGYxuMksRLghIHU3rqLmaAVTy21IeAzgrMhXB/FDZid+5NrGAjvSfmjlTaO5mkupprvpSEsuEgu9dtzoyV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635231; c=relaxed/simple;
	bh=KXwEE5WL+XxspylU/Cp+wTetUGnTvmiBG9aljKhxtd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWVElBTMsWr4uvKONwF3Z/8CjkhvLuG9LHXf9sYi4Frd0f1KDgauthuCXC85sW1v2OXHOBfaZkcLckxpSEU/cVQfX5QkKSnHD/uCcK8Hcv+3fHr6V/KrIIVjfvTvqVIomQEKGK1NOQj26YHvqFdL+H6Mu13Fon1nXrZdc8GeJBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSr8h4xZ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSr8h4xZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so1122001a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 08:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786635228; cv=none;
        d=google.com; s=arc-20260327;
        b=AQ3BrrFdwwnLs9PjRQHtIb0IjMWcERhJWY38fo1xRvWj++nuA4K/1TnMhAujnVNPvr
         JJda7YgSLh4+4mAejFpPPncAY1mb+hqxZ6MnAc8Sl5VrcofTIWcECwf8Dv8Sq5P2OKa8
         Fi6kRWc20eVoBGcfoRe5sdW9JdHoq80JriBTeohH4JOtjU6vl7X+EhYXFjsVnMCa2QrQ
         OEAAlWzsm9zv1ET7EdRxGiF1pePTAQViGa7lx/dqX77FsB9jJ+9oePECyvgjmzSNhg6e
         dGG8v9IMw+/CvjisKTsMsglor0vGbHtuRJ1Nhs8UNsMgWomdke3CcvgQOkYr5nxmWmrR
         Eoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3G+HX2gOoa9ZkykcsH0eZfMxDw2FlU9wcFC1Q+vFZ0=;
        fh=D0bAVI6wPegG/Smh/GO9RRZujQhsfY0YJBeWxT+t1vE=;
        b=WB2wcCQymfOoNLBOYuTRd7oojMvZAijzlRLacEvZ1rhQwQOXGZ4cmRnwKMQG4Xh5oP
         qY6wznciLxMTethnW1hS3qriPEjiio8/WvybtF38UN+0Bct9CLTx+eU94nvgwxu73GAK
         x3KuxVOhcCmRtg/FcTM32InHsYkGxA3Vtt/NZ/tzOaBmqpI7Fr/B3GyeKojYmlWdu6iB
         aRsPo0LLSnX25zOwuAjXeVHsMaVgpYDDPrqslhBOYgS9szLXsr4cC3zoDdpIst1AKxYV
         grWpHo39Pe7eT2aSh3GL+UYJ2a6a4+3nj9OcNgYwryf57wccKNnHQhGa3NuF8UegDcSX
         FxwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635228; x=1787240028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y3G+HX2gOoa9ZkykcsH0eZfMxDw2FlU9wcFC1Q+vFZ0=;
        b=mSr8h4xZbJbMDAT1ReDt56IIB5OV7XTHKO/6Xt97zdw+NscB+jqX5zFW3fhnqQInaq
         n5VvaqRIweDZ+7vEHhNsY7JHLCIUfEzIiaFM1u4r3GEUeTbtMFM4c2WKvQwPnrEipC9w
         RMjRHhoCQNX9hp0cGQ6KFoPHhakrLECR6AA2Wo9TWvQILd04vGp94tBhYqhW+CyxnaFL
         ZA37HXooJwpkv+SxXZ52ulEbNvgjpMH4bcziVSDDTrDQq2J86M4EadacHojr40nqvU6L
         9GrtpBP/Zh3jzLf9nGL9Cd0K+mjUS8r8ZFIA3k15kMXZ+d6Gj47o2MXfv9k46QLRn7OW
         MLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635228; x=1787240028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3G+HX2gOoa9ZkykcsH0eZfMxDw2FlU9wcFC1Q+vFZ0=;
        b=RSCGIrlll/3U2CgeNgoQ/Kto8LjEl7DMstNUWF1Y4TfQhkan/ZulM/ocMaoptPl8nh
         UyDW6p22xPZhDJ0GfmDBB/UVlESTXhaP4yVrzARDsMVmnTaHBmeXvxqFxcrphRqiojI3
         NYKYOmpEZpLxoMDBBp1WJrtb3eP8xFYClBnJPZNGYfWZT/LIUXCBieIgkf3neGa7hgnN
         7vavD4JPcHVwfD2KWe8qqwy/o4w9O4z70aQoBDb8EaaQjAQP/eOS4nciE+TRkylrtoRv
         56QBfrv/leYP3UzO660xC2BHX2yj5CMctkM5FROCOuhA/WFya1WBPYP/U9fdLtBC11vG
         2m3g==
X-Forwarded-Encrypted: i=1; AHgh+RpuAy/w8h3C4+86j2LXVw7WR4m8KRdSA1LoxcArTlKmGskbV6gce/4WMXcE4GtAuDh7NeZsschCv+DUSwhO@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6rYvU1iLFnbcPriawgQWpJBqP1+4o8Feq8CLXUKmC9hlu7Et
	rWJLv97Drd+FFoUs8i82Br38NpUPO48MSo0tXF8s5cTDtfwnlvYD9WjKskO28k6jWXX7M8oav5e
	/fEFOzY1HUhJvlVaAyU4eWzOqJqWGcdo=
X-Gm-Gg: AR+sD11Zl4RCew5Cyq3zQTcLi5oPZ0n4kp7RzRgNOflaUihJ8Kp6pt5kbuZ0U2nKWXo
	bAPdIbttGfZQwFLvobRCAaxXmyjQeiavh5sIKbysEM4tP1yPZlmcNJxALD8aXcJ3vRqCcePAZsD
	R5pLOzSLIjbIQwEJdqx/rRCu1z9KTdsEBL7Fj5sYuHXDgXoyrvkluyj6PNKUW7w0Jh+7MzUxImY
	drVgSjFXU2V2+Jfg4MoplTvgumFzjUdCVM/8zVEQqwB0l/0GCdynNVbyvvdSLSylHNnX+d+q3m0
	cEEmiXlsCfHfwkDULL1hdNJkEGjUHtbZh2R4T8WphBGhRQ==
X-Received: by 2002:a05:6402:24c1:b0:6a1:f3b5:f7dc with SMTP id
 4fb4d7f45d1cf-6a381514b57mr2685867a12.4.1786635227983; Thu, 13 Aug 2026
 08:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805071414.3414870-1-matthias.goergens@gmail.com> <20260812-gastgewerbe-dementieren-landzunge-db991673a96a@brauner>
In-Reply-To: <20260812-gastgewerbe-dementieren-landzunge-db991673a96a@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Aug 2026 17:33:36 +0200
X-Gm-Features: AUfX_mzx9a4SvW7UM7HD100LUuXw85p1wyTjNt2Qg4tiJdK2H2wZLn7je4Bjhn0
Message-ID: <CAOQ4uxiiE0kks+4F92qJu2QnkL+rkHFvEz2ujZDgVYjGw0AVYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs: report truthful FIDEDUPERANGE progress safely
To: Christian Brauner <brauner@kernel.org>
Cc: Matthias Goergens <matthias.goergens@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@kom.tu-darmstadt.de>, 
	"Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 9:46=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-08-05 15:14 +0800, Matthias Goergens wrote:
> > FIDEDUPERANGE currently reports the requested length even when the
> > filesystem shortens a destination range and deduplicates fewer bytes. A
> > previous one-line correction was reverted after generic/517 exposed the=
 old
> > expectation and reviewers raised the risk that existing consumers could=
 loop
> > on a successful zero-progress result.
> >
> > Patch 1 makes a non-zero request shortened to zero fail per destination=
 with
> > -EINVAL, while preserving explicit zero-length success. Patch 2 then re=
ports
> > the filesystem's actual positive progress. This ordering keeps every
> > intermediate kernel safe for callers that advance by bytes_deduped.
> >
> > The paired fstests update corrects generic/517 and adds raw ioctl cover=
age for
> > zero-length and mixed multi-destination results. Both tests pass on Btr=
fs and
> > XFS. Installed duperemove exits successfully on the measured corpus. In=
stalled
> > rmlint does not hang or silently over-report; it exits 1 after the fina=
l
> > unaligned tail receives -EINVAL, which is recorded explicitly for revie=
w.
> >
> > A current-source consumer audit supports that ABI choice: duperemove co=
mpletes
> > the request on a non-zero status; rmlint, bees and jdupes surface -EINV=
AL as
> > failure without retrying; dduper and xfs_io stop but can still report c=
ommand
> > success. None retries, hangs or risks data corruption. Thus -EINVAL is =
the
> > only truthful result that also avoids exposing successful zero progress=
 to
> > deployed duperemove binaries.
> >
> > Matthias Goergens (2):
> >   vfs: fail dedupe requests that cannot make progress
> >   vfs: report the amount of bytes actually deduplicated
>
> Needs input from Amir.
>

The logic seems sound to me.
Main well tested and accounted for,
the suggested fixed already aligned with the man page documentation
even:
EINVAL The  filesystem does not support deduplicating the ranges of
the given files.
could be interpreted to apply to this unaligned dedupe case

Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

to both patches,

Thanks,
Amir.
