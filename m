Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BE4C957B
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595891; cv=pass; b=vFKHMmLJUvs9aXvC2EyxvBBgX+2/SREywHgTcTVsd8Cf+1HEoNQh6CoOyQXVOK8XnBIgPfUe7ds00ZcDJkCGFLZUeRy1iikzlqHp2j9jauh89IIZYruOVZfDQRVZ/sKd0v3QCS4C+9mnCnoYdhrVZKM1TSkvKg0HAPdRXI6vxj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595891; c=relaxed/simple;
	bh=JDBpdTmRiGxd26FL0xwA8RefNqMqJp531Ox8iOS35AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2od7HPJUwzeHc3O9fx49qalVVhHn79D1Q+Srn7lpN7mEBBFQy0lL9Bd8kdiA6C+CpMo1dIOEN/kqyUVheh/21oxH1fAt6SJB8wrA8I0CNPlkgYrfpG4ZqSHwQr8IgTZBNA0MMMEb23AuI8oJd00m7bXpHzAUBbYNYZLBeswy10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0LKtn+o; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0LKtn+o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490afc47455so5287505e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 10:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780595889; cv=none;
        d=google.com; s=arc-20240605;
        b=Re0gR7qnHV6N/ffFtnsmkfRVMlzwO/2VUCPndWVbnTCr9HBc1twdf8TlKTqm13EnYH
         8FohYvYRhIy3ilIIkxoCymH+7rI1hqHFGMPNT/0fSClWY+l1uF7CprOBqUOJH7pRSr9a
         CZipcuxTSq15ZIo/pWOOhT6xIfo+Gz9YPKQFJqfz4oL+FPy9wbU3pC/OzggauqxwNtMQ
         WJk/Be6N2y+QCDEwiJg79gJHRFYRPNrmyCZ9oD1nVFB1lt2LyuE67EBUb5aaZ9A3uE9g
         oi1t7Gd9ze3Ip6hYkVShxWdTzNkiUDabJE6Vy1koUYyKWq3JIF768i8i0EjQBfJ3rvpX
         L/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xF2MKm39aUuVQQhyZRtRX7LK9+Sor0h95VyMNxKj3ak=;
        fh=Lp5OwsOqwv6WRd9IJSKUE/Lgl++5KDGKSlVVdrcy/Ro=;
        b=dEvECpV+Vk+FLfwZ5Tp1cPVrj7b7leIbTzVB4aWbu2SnXOyDaxdvCOTjoUnsZymYh/
         DyoUJiz0+OQ7ubNN3OBXLFkhsn8SGHEGueJoMzZt9zNShGHjcDDLBPBDISkusXqwP6to
         hQWF3+i43Cshlu4OyUAjbowGRr4aPn0+wJPUASqJnltAy44nwri1mJtm6Rj6px2DJQgN
         S7HZq+G5S1NUJlxcqZZ8Op0N2sttuJTWycmyfcjdNtdR2nGK0mRMAiZ+81MAl9xh5mSo
         5EotEz3fczzhmqZgGPTYCvMYUEEK8l3vaPivPyu0+4TQxGmfNSnWVFIjx2KpbT2Vf7+v
         EHdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595889; x=1781200689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF2MKm39aUuVQQhyZRtRX7LK9+Sor0h95VyMNxKj3ak=;
        b=h0LKtn+oOj0Qkl7D1Te/MTt2Tv0GrCLifdjZGkETIBt94WFptZmhLlHDYcRN5eNskJ
         g0J4vC5+L0mC5OHLjbRue9LjQF/613sLZY5w0E99Nau/6/9bKwP0JINT+ZFa/QMf0Y3/
         BZtmnrsck6Aa2pjRl+zTVfleHFzRYiZF+Tov+NbVJrEU7tiIdl/qsCc2u2cUd5Te0q8T
         KYNm3262bdGPGpl3n17TdYwM2/+X9SlvO2pvXxy4OeZ4gEnMflIjf7CEAkCA9gHTQkJr
         LhWtiRe5TF26jkUMs+axDW0KlnGVHKtRzVPwezpm/tzfB3LDp3W8lMxRF0l2J1EhH6Rd
         j8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595889; x=1781200689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xF2MKm39aUuVQQhyZRtRX7LK9+Sor0h95VyMNxKj3ak=;
        b=V2L3awdSNHdrfpzHh8oAMF7hzT85ZDGvD67lxYCGpvhpj6esB4m+B682JVHwMa26cU
         XGNtzTGBco0e93paOXKXM9sBGrxKd3tn3KSMFGKWxZWXSHk7JVDLvGIJ0q4ssPXkNnnn
         QsLfo3svMFyeUNl+ZrWPq7taUsqhP4OY3aTX+ufse3nED77olhBXwusRWBR6TbG0X7xW
         J4UGFwMI7jMTjJRrw7mrkphELrgRfr9teyZb7kATzDENtPt1uL0ztvksaRVhkPV2NeZj
         X/JqMyExHojWBnaajaqgH+44Jl0naVt5dBIeohOdtYLoQ9C9/P9vu8ntZ5ZvP0v7oDws
         j6YA==
X-Forwarded-Encrypted: i=1; AFNElJ9HNs7EBdThWDuuUl4KHHHU6E1kb2/nar1Zclr1jPBaPrZd2tX4/9GDUkQWv2hXH9DVXCJzNQj20wXdOFuO@vger.kernel.org
X-Gm-Message-State: AOJu0YytziUha37crwx+QdBrn6nq+ukZA1vsQe3479ZzmZGqjYOr74Jz
	rXCUAslFKG9BWbFpQ0oXyLgciH0RJeOT0mGp9g622VhAPoNKv5aL0D1APddfMHJ+2kHmJ2x2qYw
	oPuYR630kA+hn6boy8k8vj0OYn2NrOJM=
X-Gm-Gg: Acq92OFOECTmzjabiyG4v+OC03eoF57Y9zJh6VHnzbRKV+dUVtpv5YgNdY6c8JEJkyQ
	99f3JCLMoEgs4LaDcK8YWxDybGwxMoFrBq2LKlvG1csEMABNkWkf6FxaeYTsQ+00gRWtOlx3Kq3
	47NaeMTyZwYuGlwqY6y0qUIMlvXnftFHwDUBveXOnEeq6mkrir855Gre0ScaEnEVnYvWkqeadbW
	7uwM68uKALuWTgt29/fpYx8OXvJMKKL6zVMR8U/g6BofLZmTRIEX7rtH5uuYm4+e2CJORXlyfFH
	GWJTjj1ZyIQ3+Zv2
X-Received: by 2002:a05:600c:c103:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490b5e79656mr113878435e9.5.1780595888742; Thu, 04 Jun 2026
 10:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178059213410.15421.10567268398539539875@gmail.com>
 <CAJnrk1YH_SC9doHp60Vuajc-mzQiopPExMPQVVDtFHzB8vTM6Q@mail.gmail.com> <d486fde6-c78d-4a78-8dbd-43b8afaa90cd@ddn.com>
In-Reply-To: <d486fde6-c78d-4a78-8dbd-43b8afaa90cd@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Jun 2026 10:57:56 -0700
X-Gm-Features: AVVi8CdEoBMunfXMb21c5leIrwhYiBa4AbRAQKWLZIRv0EOU_e4f9mYPVnGRF7I
Message-ID: <CAJnrk1YTqVMg+-giph=YH8UCJjsfG7uLSPSK-68G0h=WC2sXDg@mail.gmail.com>
Subject: Re: [PATCH] fuse: {io-uring} use request cleanup helper on commit
 setup failure
To: Bernd Schubert <bschubert@ddn.com>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuse-devel <fuse-devel@lists.linux.dev>, Zhenghang Xiao <kipreyyy@gmail.com>, 
	Berkant Koc <me@berkoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:36=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 6/4/26 19:33, Joanne Koong wrote:
> > On Thu, Jun 4, 2026 at 10:09=E2=80=AFAM Shuvam Pandey <shuvampandey1@gm=
ail.com> wrote:
> >>
> >> fuse_uring_commit_fetch() removes the request from the processing
> >> list and clears req->ring_entry before moving the ring entry to the
> >> commit state. If fuse_ring_ent_set_commit() fails, the request is
> >> currently ended directly with fuse_request_end().
> >>
> >> That bypasses fuse_uring_req_end(), leaving ent->fuse_req pointing at
> >> the ended request. A later ring entry teardown can observe the stale
> >> pointer and try to end the same request again.
> >>
> >> Use fuse_uring_req_end() for this error path as well. The helper clear=
s
> >> ent->fuse_req under the queue lock before ending the request, matching
> >> the other io_uring request cleanup paths.
> >>
> >> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support"=
)
> >> Cc: stable@vger.kernel.org # v6.14
> >> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> >> ---
> >>  fs/fuse/dev_uring.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index 7b9822e88..7523569ff 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -924,9 +924,7 @@ static int fuse_uring_commit_fetch(struct io_uring=
_cmd *cmd, int issue_flags,
> >>                 pr_info_ratelimited("qid=3D%d commit_id %llu state %d"=
,
> >>                                     queue->qid, commit_id, ent->state)=
;
> >>                 spin_unlock(&queue->lock);
> >> -               req->out.h.error =3D err;
> >> -               clear_bit(FR_SENT, &req->flags);
> >> -               fuse_request_end(req);
> >> +               fuse_uring_req_end(ent, req, err);
> >>                 return err;
> >>         }
> >>
> >
> > Hi Shuvam,
> >
> > There was a similar fix for this submitted a few weeks ago by
> > Zhenghang that was sent offlist to security@kernel.org (which I think
> > was before the announcement came out to cc the public mailing lists
> > when sending fixes to security@). Berkant submitted this fix offlist a
> > few days after that as well. Sorry for the duplicate work.
>
> Out of interest, did you see the entire series I had submitted?

Not sure if you're asking Shuvam or me, but could you post a link to the se=
ries?

Thanks,
Joanne
>
> Thanks,
> Bernd
