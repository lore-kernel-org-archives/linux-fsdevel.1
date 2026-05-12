Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A738C41B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572433; cv=pass; b=uI31spx5eAUHQGalrZso407ax8QrG0zCCW4UUqzdi8vvuEHTO7vAcjHRXG4i7Dvwi2XMNHo8fQuss1nuXKqpQYnEwgr9IPqIn49kUpNWp+Lrv/mJ67NpJLpwVAJrofg5pVD65Rp4uUmoOLo1tVFLchmjUr37BBdes7ERu270F9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572433; c=relaxed/simple;
	bh=vK1Y2mmloT+7GbNXvVvlIPeAF7TiqUt8RhvKd2TCTBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGF8+cyuBFYRTMKc8nb1LFm2gn4rtZLRbXKbu2ypXGlFrCPbTVcYNT7lg8TrFoCP9W+FjZrkpWxXd7U63f4qZI+PzAAj3BbpCxRAoYR/Ppk/ZOLbSJZbe98DnvW1/a7GzbbELepozaztFUmG9jEMOEKhr2ZHZ/h39ht0lKXN2mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJR1nuYt; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJR1nuYt"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so8249016a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 00:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778572431; cv=none;
        d=google.com; s=arc-20240605;
        b=I6ZH1TFlc6d/rxJNIe01kxNA99xws4fgHMsWCuqz80/lJ6KRAniByqSsN8Ah4li5WT
         VYLQvLnilb36Jgky1JaJP3kSvW0BQRt2rX4BSa59lmtdXho4jbGUAsf8nYwihUgCnVhu
         8RXYDyiC2051P9Pcie2gWVt3T5fpcOxA2IZAoRjEpEUPFWtpedhaU3S0GmQjAuhHFZ0Q
         sMcrJhlLdPy1jA83aPmiRuZNI8tOdBHdeK4Mi9/0fOTeBRBjoMVM4eGpp1BFYlj7s9DM
         tKP43iaithRV6t0EK+MrCunSrpzzwRJnDb6gft+rN1LjKRcDD+kJHelBWv1HrjI9MDkj
         A8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyyBW2eh1Dp24Y3zk3M8zpYB3+C2r+Au1F9maFjIet0=;
        fh=1dl6V/khCwBgORC748EtcBhzf1esmyJTL3Z8Fyd0vyA=;
        b=CqK7UwVzYCg4+BxgQblTXV2hBNX6NsBkuJT4aDqXTxZgHUI77SjFCuvdpI+Q4gGe1t
         TErtP8KhLYVdRFwl1E6ZaRZxxIvXVfmvO+P+BCsQb4i0edlparahHQThrnqgKDQI1jkO
         bMgTRscD60/LsZ7QeY+nn02XmM9hG0AI49WhEk6fE9r67tvTMdV+wBaSzOUW0ySkKmSC
         rX6zw6EddxTrmUAO/zOI4Tm0r3VAS3l5xT74DDGUaYRt/JgEZ4ErJpToLVTKf7SIJYnX
         40guylg+iZ0oH9Yn4/z7H7lBGH5koFpkrMWZEGkh806Q2JKBFktUPmr22AG4cpjS4wHR
         y1HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778572431; x=1779177231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyyBW2eh1Dp24Y3zk3M8zpYB3+C2r+Au1F9maFjIet0=;
        b=FJR1nuYt93O8kVL1hMXk23flnaVdL7hu4uj/WObEELJxlGsSpj/C97fIK8U5V8Lhfk
         NPumVB27/qTYK5jd1Pe+w4Rkx6ZzTt9Qxcesf1XNPwAad+Rz4I6WYZCtmDQwn/AjYlDt
         Tf0I+J4KMK2FY44pBmTuNfX2cQrctfzSG6erYTXofyy0zWW0IapywveENe/rJWqiez6Q
         q4lteuezNkrYY2mWoz+26Q5ZighinljQPqrKOJWnoApafm9PIlW8SC6JBGJ4q3+6vMLs
         WkSo28vfknfJMkDqASkl9Jf9jWx3gCXePPwemfXVUuMg2/62feBiT/wL6Lh7ZEE971Iw
         p/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572431; x=1779177231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyyBW2eh1Dp24Y3zk3M8zpYB3+C2r+Au1F9maFjIet0=;
        b=JWC+sKd/E6AvrXq2ldfZ/f5+qT0A4f4WCaG/JaP6iBR5fAemQh88eLE9m4rTp+9Wj1
         2QdNHWrgb6OguDSayuyRtxGrK8llbkQt8u80rtVZi1nqwtjCjMf4TDu0dCvbm7HU5n7k
         UBE5JnB1+fJoom1chuWqjTESN7YFUB0HCNyZdp7+RspGcWYmMzs2PMIcK08j0Lqknl2K
         j0dUz7EkorM4ngbz9/IXTcooCOD+SyDTlAMzNpvMbKjGbJWqwu2eGnpjEVsZdhV9JHAj
         crMEQKPF+Z/Pnk+13pJQAZkekcb9VEc8MuTkUFNzHQvN2/fcAFQk1EXqJWQckQdSv5WO
         ZIXw==
X-Forwarded-Encrypted: i=1; AFNElJ+jtaFGUc+nX6EuorqAspnZuHsaljAH8avkn477tx5N15wkME/GxNUQitzEJFK+qYGnczMN1t2kCHjc0wHX@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdyltPoqqehupYwu7lDsWphG+BMT3R0e5U4Ku3/92XISTBIv7
	qxJi/OOcIh1qEfw7LZxDXkDs2RYif2OrDpPwtAevfma1S5/T3qRy2u038XIs7SFtyndj5/PNMPb
	SgZOgHoZpBSd9p/mwFQuDqpFbj7w2pQU=
X-Gm-Gg: Acq92OH78REJjyASV1BjR9rQUL4v17I+infzdl3T9S1WFDcO62SNEkRZkF4A95eBLhG
	ETOJPhALAnCemrUsT6oxLnJcimuf1sOYyAxa5NBhHqmvd/so+PjddkU/qvMmCGGNyHoj48sVqa4
	2waJ8bzTTgTuUSUDHh75Bg96udagr3XBFHkhJ0zB6GincyJRd1xyPZSTf/PwM6JbiNhKNPD8OGA
	q8/wXe8xCYZF0r2QoydyWkRhEFc3pCXnuMCJNquC0+C+5UBCjwcEzuSpkTkkfdryImvY3wBVNYt
	rU6LJEn3cLKY9fwdYgnHEvrPkYqSVXF/u1Uryt6i
X-Received: by 2002:a05:6402:424d:20b0:67b:4aab:1f10 with SMTP id
 4fb4d7f45d1cf-680cdb3839dmr776747a12.5.1778572430530; Tue, 12 May 2026
 00:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com> <943cb464-78f3-44a7-92a7-57a1fe4fbc10@linux.alibaba.com>
In-Reply-To: <943cb464-78f3-44a7-92a7-57a1fe4fbc10@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 09:53:38 +0200
X-Gm-Features: AVHnY4ICpc-P6RT18BoihboGTu-64h_D56tWJzNqKe3nxbInTpNJmuAO6xZ0SN0
Message-ID: <CAOQ4uxh4yKEBdgbkfZTVyYM1P8ahALFVJzQCj7ASkrH746_4xw@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>, 
	Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 5:20=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/5/12 01:18, Amir Goldstein wrote:
> > On Mon, May 11, 2026 at 5:12=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >>
> >> Please let know what I missed.
> >>
> >> CO-MAINTAINER:  Position still open, though we formalized some
> >> subsystem maintainership roles, sent MAINTAINERS patch.
> >>
> >> FAMFS: Let's try to find some common ground between the fuse-iomap api
> >> and the famfs api.  I.e. add striping as a generic mapping method,
> >> even though normal filesystems don't (currently) use it.  Using BPF is
> >> a bad idea.
> >
> > IMO, FAMFS sits somewhere between PASSTHROUGH and IOMAP.
> > The simple nature of the maps, the fact that famfs maps are const and
> > queried at file open time makes me think that famfs is much closer to
> > PASSTHROUGH than it is to IOMAP (in its full capacity).
> >
> > I think Joanne has mentioned that her customers have a use case for
> > multi backing ids per passthrough file and I assume this would be a pre=
tty
> > simple map, so that sounds pretty darn close to famfs already.
>
> I vaguely remembered that Joanne mentioned that mapping multiple
> backing files into one FUSE inode at the end of session.
>
> Is that the case you mentioned here? The requirement _might_ be
> reasonable, but how does the entire page cache work for such cases?
> Each vma can only point to exact one single real vm_file and rmap
> totally relies on it.

The problem is only with  fuse_passthrough_mmap().
Depending on the workload (?) mmap may not be important and
we could fail if trying to map cross-backing-id regions.

For the rest of the I/O passthrough method we could usually do
a short read/write (?).

The main question to ask IMO is "is this useful" and the use case
and workload and customer will determine the answer to this question.

>
> Unless there are some more non-trivial core-MM enhancement (e.g. to
> split into several vmas for each range), I don't think it's possible
> for the current page cache infra. For DAX, it might be possible
> since DAX has a seperate workflow.
>

But we can also say that mapping multiple backing id should be
implemented with IOMAP, but this is also closer to famfs, because
this use case is the const static mapping determined at open time.
In a way, this is exactly the minimal subset of FUSE-IOMAP that
could be implemented and share most of the code needed by famfs.

Joanne, is there an actual workload like this or was your comment
a "maybe in the future" sort of comment?

Thanks,
Amir.
