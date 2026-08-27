Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337B346E63
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834776; cv=pass; b=lcD/s5J3mP8bmuqmV/9efo88OEpAlvh0aTkGY35CULrdrG3JXL7NCUKhBF74ZsdVIXrLb+i4sUCOQYG80G89JlikD2ffG08YTwCgxb8L5Uw7nhfqvTIFOS6k3ioJt3cXMET2d+b5zOCbTqiR8hyXy1gxRxOfcWDj7SxbdSFAy9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834776; c=relaxed/simple;
	bh=VtSG3PkCoqr4SYLiHTFlkhdpj+dkerjUWfVmiPHXaOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaYCE5nxG2siTCmsGkRjmSQkKIqX7uc+R1l0tqb3JhYNT7SivtVDlnQqIr7fby8wtXbualM4yQ76/4MMeJ0Ly/j7ok+EGRmuJpXlSGM7MmoQpDob1gxY6bdbKaKTz/3eIyTPsNEl8diwBHJB2ICLB3dU1a32S2pexQy3sR9IAUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/vm6d6d; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/vm6d6d"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3328017a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 05:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787834768; cv=none;
        d=google.com; s=arc-20260327;
        b=hqtYCHnpPMTqsHSWJOUCU4JGjNhGpb/iUEzWx4py+HW9FOnw3uOWpIvRS4joe51UyN
         iBM3f3ELab3WRR6QJF/6ge+rlQ96JxsaEQxo4BW+UcYvaeLwvowmzmZ9Yf3K7Xp/E1eT
         Gzgb9c33/ZAudNgvIkr2JdmKf/kuJ2yCpgSd8PYDzbuXbGy40LeQZvAgYCdr9tDLMPjc
         OmvqdObVapLd2I18bHOhvHqHokx/3/+6NHgXuoCB3cXV4R8lzml/gNYAkKptJ9DxVpii
         bCLvb9WOEYQ1klTRcHDGQ/HAbvjC2IDvXSXlgnooL59UI4RSGoM/rDXZpVAdL5rHEE9T
         RYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiFeCb1mWzRNV32sFee9OVcleAQF9Zjh0wO6Dwjz8+0=;
        fh=kNmSDfRNdQ28MiWBOqouKl6gP08jxbpd7kZcniv8hCA=;
        b=YiW7W3C483HvHYozY4crRDJlZWcTdfNKUInQhEcwWqLuOvpBgNWBqpYogEiVZ5rkgM
         /WNXy6UCOOAsRh6EDwtOK5IvZPlQvp/udkqnvXt3xM0pXpfiJCX82NuilJ07tbPvsZ7/
         EF3XatXFJrlrZV+G9Bg4aebW8UBpfZfJwbCd/GfE1p9iUBYAsGE+UUNBGJXPXf0tmYdb
         f72ZYtMSUimSQwxTWoVn4ljY06KEBgzhoJPsoGmpzSV0IryaaoJZIyDNN7n9w7sPxOvQ
         gAWDgkuSer9+5ZoVjEMNz5IGCTLjSfbxxHw99zzrdb5V2DfqWK332QZ9vAbQgp8FaaRG
         Z3Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787834768; x=1788439568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiFeCb1mWzRNV32sFee9OVcleAQF9Zjh0wO6Dwjz8+0=;
        b=L/vm6d6d5ux+ohBM4fopVrFQC9bKM2XHBZBJH5iEzFSDNszsbth7B+xPRqj/BCMyEN
         aC45FkFw3w5kn6b4PpNo2P2tISSntXCJLe4VbLkbmo0lSOYaKQtP33tDZlYSt7kRs6tz
         VwUIEeKlAhTQQCpITMFsrdTE9sbJMtaL38xBAFjx8Z1SVRsGOlskl1p9FGel9HppLEC9
         qjClF5MKbb6lGV4xBjgRcAo+/bGD9HpzeGewXaZv9sHqXauo92LbONN0E+dF6N0DZObR
         npDayFBIt5QLcPnmJLj3MWHUQrTWfIdKeqq/Nw3u4o2FsUDYxvC8ovi4qxDoM85Lj0my
         OLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787834768; x=1788439568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiFeCb1mWzRNV32sFee9OVcleAQF9Zjh0wO6Dwjz8+0=;
        b=JErBnyLp19SnRMs1nGupj2q2E4b7nFh7vr7spNJ+UTWs3zbeNMUBk5WeB7zE0SFMOK
         53RpWCTi3hNxINyz3R4kWAIzHF4MwuW8r5Vy8hIONS0mQqy0DY/tdcT8bq3A/NzRkPY0
         S6uVv8wfn1GOfKHWEUxhQDshFfUn5+D+lLjJ/i6ht0PK65BB17A51mqFPMRIsm9VC9ie
         w8m66AIRGgi5eWY8us7/T3zStLfWc9+QjfbdP8qyaRLaDHRgg36e96CCzYQGfIjIT5mn
         oxe2mlPVdtzMywXWUPRAUUl4V/+zWVlFoJ9bvbus46Wj4p/H03l9KZH1U/wobddXit3C
         vR8w==
X-Forwarded-Encrypted: i=1; AHgh+RphvyXhP7rMAI8ycm/OD7UEtHyIbPZcjXKTeNBywb7YC1yhs1H5/e9gNXkGDDJwxKBiXEFTGGzSQzDUcg/H@vger.kernel.org
X-Gm-Message-State: AFuF++mbhHnNeVid/upPA54YHBiVqU/9LBV5Bx/iclSPRqKvzpeO/oSb
	EaOgMM/l/fuZWfQXAMOY77XACYBoHa3G94EGHeupJ1NV2LkYHdjVNmaRE8G1KTFY3Bt6JquG9Ba
	cc5wAUL+ykIoPla2hgNRJw6H01idcNsM=
X-Gm-Gg: AR+sD101aVsg3jC0dCL0iHeWvUHynt9DweTlU7fq3mgCmmjmAHep3KjU5/svPNrVDq3
	acp15DvkdCjKCHQG2uMqpdOVDwGI25G5sQSPtYbCqqau6qxZ1vA9EWQWIt8B6Au1FNmFzlZIXrT
	RQQFp0jKPeqBzxTQcCcdpcSWuCiN6tJlKTIUNH4v8XnF3AwzkwYL+5FXFKw23li3+j2N0Qskk84
	/Vcf4RUx2mBtCvOTwRPmndyeW9bZr2hqzbT3TcfDrjOZ2qfQO6kthZcfQ9494zuND3fIh9ntmQH
	qvaG/fAQba4W3h4uKD8+5uG/2adlebK9R2+Lp9B4fQ8avnyZCEcBiu3U
X-Received: by 2002:a05:6402:a5cf:10b0:6a5:f912:b092 with SMTP id
 4fb4d7f45d1cf-6a5f912ba3emr2236191a12.6.1787834767865; Thu, 27 Aug 2026
 05:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com>
In-Reply-To: <20260827045007.3831259-1-4ncienth@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Aug 2026 14:45:56 +0200
X-Gm-Features: AcwNN1V-c4xu4UcDTK90nLAOAcPgyGpCSFwT49PXfHRzCVesR89Joqxdat255j0
Message-ID: <CAOQ4uxjtzGLVHeQT+J1rCaPhhT+NG237EVJC+3DhP3DRH6Npqw@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:50=E2=80=AFAM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> Hello,
>
> I found an unprivileged race in fsnotify_destroy_marks() that can leave a=
n
> attached fanotify mark on a detached connector. On unmodified Linux v7.2 =
and
> v6.12.105 source builds, it naturally reaches the fsnotify_conn_mask()
> warning from fanotify_mark(). On unmodified builds, the only observed
> system-wide failure was a v7.2 panic when panic_on_warn=3D1; no memory
> corruption or privilege escalation was observed.
>
> Tested and source-inspected versions:
>
>   - Linux v7.2, commit
>     8d3ae59288f1e7d58d76558a6ee96d533bc5019f: reproduced.
>   - Linux v6.12.105, commit
>     14c37ff05f22da2fa7076d10f6a07c7ede330c83: reproduced.
>   - Torvalds master at
>     73e3f0710014fe6d4ed98cfc02292f6121db7558: the relevant destroy
>     iterator and fdinfo consumer remain present. Commit e422777fdd47
>     changed mark-mask updates and can mask the immediate warning, but it
>     did not change this iterator or the detached-connector state.
>
> The unconditional connector detachment involved in the race appears to
> originate in commit 6b3f05d24d35 ("fsnotify: Detach mark from object list
> when last reference is dropped"), released in v4.12-rc1. My unprivileged
> runtime results are limited to the two versions listed above. The limited
> unprivileged fanotify functionality used by this reproducer was introduce=
d
> by 7cea2a3c505e ("fanotify: support limited functionality for unprivilege=
d
> users"), released in v5.13-rc1; I am not asserting ordinary-user
> reachability before that change.
>
> Root cause:
>
> fsnotify_destroy_marks() holds a reference to the current mark, drops
> conn->lock, destroys that mark, and then continues the hlist walk. While =
the
> lock is dropped, an equal-priority mark can be inserted immediately befor=
e
> the current entry. The walk resumes from the current entry's next pointer=
,
> so it never visits the new predecessor, but it still detaches the connect=
or
> from the object after the walk.
>
> The skipped mark remains ALIVE|ATTACHED and remains on both its group lis=
t
> and the connector list. At the same time, the object no longer points to =
the
> connector, conn->obj is NULL, and conn->type is DETACHED.
>
> Representative v6.12.105 output is:
>
>   WARNING: CPU: 1 PID: 163 at fs/notify/mark.c:128
>   fsnotify_conn_mask+0x113/0x150
>   CPU: 1 UID: 65534 PID: 163 Comm: fanotify_destro
>   ...
>   do_fanotify_mark
>   __x64_sys_fanotify_mark
>
> The source reproducer ran on ext4 as UID/GID 65534 with CapEff=3D0 and
> NoNewPrivs=3D1. It uses ordinary FAN_REPORT_FID groups and races final un=
link
> against fd-based mark insertion. Both builds used a KASAN-enabled researc=
h
> configuration, but neither positive was a KASAN report.
>
> With panic_on_warn=3D0 and panic_on_oops=3D0, the unmodified v7.2 run emi=
tted the
> warning and then completed 10,000 iterations and powered off cleanly. A
> separate fresh v7.2 run with panic_on_warn=3D1 reached the same warning a=
nd
> panicked through check_panic_on_warn(). The v6.12.105 run emitted seven
> warnings and reached its 10,000-iteration progress line; it later timed o=
ut
> during post-loop teardown, for which I am not assigning a kernel cause.
>
> A timing-only diagnostic kernel also demonstrated that fdinfo can combine
> the old INODE type with the detached NULL object and reach
> fanotify_show_fdinfo() -> igrab(NULL). I have not reproduced that Oops on=
 an
> unmodified kernel, so it is not part of the impact claim. The skipped mar=
k's
> group-list reference keeps the connector allocated; I have no evidence of=
 a
> connector UAF, arbitrary read or write, information disclosure, or LPE.
>
> I do not have a submission-ready patch. During fix development I rejected=
 a
> survivor-preservation prototype because it introduced a mask race, a
> drain/restart prototype because additions could starve cleanup, and a bou=
nded
> retry prototype because review found an unresolved lock-order/deadlock ri=
sk
> when generic callers hold external locks needed by cleanup. I am reportin=
g
> the root cause rather than sending an unsafe fix.
>
> A tested source reproducer, full serial logs, configs, and diagnostic det=
ails
> are available privately to the maintainers on request. AI-assisted toolin=
g
> was used during discovery and analysis; I reviewed the source and the lit=
eral
> runtime evidence above and am reporting publicly without the reproducer a=
s
> required by Documentation/process/security-bugs.rst.
>

Hi Daehyeon,

Thanks for the detailed report.

Without getting into discussions on solutions to the race, do we even care
that a detached connector has a leftover attached mark in this tiny corner =
case?

I mean the assertion was added because we did not anticipate it,
but now that we understand that it can happen, the assertion could be remov=
ed
or relaxed if there are no other major consequences.

Regarding the reproduced igrab(NULL), this could be fixed by
using a helper like this in show fdino code:

static inline struct inode *fsnotify_conn_get_inode_safe(struct
fsnotify_mark_connector *conn)
{
        struct inode *inode =3D conn->obj;

        return inode ? igrab(inode) : NULL;
}

WDYT?

Thanks,
Amir.
