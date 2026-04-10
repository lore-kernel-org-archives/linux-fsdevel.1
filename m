Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79313806DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850836; cv=pass; b=bBBIiYsn8S+WCCydRCT2/0nd1fSHDvpliNg6lhtOGJYPbEJ1jOVuse72zLee1IuWlLjVwQ4tIVgRocAwyZqz+I9pJWBuQ6PMkDmb6qLrhbrdCfGt6szB0FzY1ICYYRsHBCgUHilRyMaCQ7tv/OScL3V5b6JlZxpVyM/n6nm/NqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850836; c=relaxed/simple;
	bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB4gS1ERJFlhh5WCJ220h7wwP4gaHH6ksB1qkAgtTPdSb6w17W/qVEKcPIztmt++h6uNxcn/9NfUOPoPjARIplB5jAOnnzyt6OMZcdFsDXk1kXxNbqefXpLOdBFKkx2Sy5M+tTguWR/SK56FQO2Az1fJNoVYmzbRJS4nuv7CgYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBKCZASJ; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBKCZASJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso1559453f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850833; cv=none;
        d=google.com; s=arc-20240605;
        b=atYvq8TxIs6g0vJrKXxn5W1pBamK7pddqnwVwFUCKcyTq8x2lObRen/JYsTHOmK2vX
         D/JyQtEDUWF8qDqP54kQ8PgrVIPq7InaVX89SXls4lPj3NtXqSctEdtFtsLe8imyVhOx
         SosrSbq2pnRx3k9pB8c2skc8JfW3cMqzIbJTZiGBiDj+VeLiowOV262Q6kCXfR7APxRl
         LyygrksD86dEafI5J2T44qJH2Fe8k+dJKpxqqXrVSbUavgjzXlJFhxGoj2L1cXlsPTHT
         Sefig212fXJ8buczKe7JA9oC54KXcbuVTmc1b0zyjVE9dmlKBKeW3GDZ3ip8VIrrIv6t
         LX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        fh=PvbckDzDZfEoMopo0OSxo5M31l061jDg82sjYGgkufc=;
        b=Dab5isHKlGJRc4LrBeAs11+OiwD5SXx56oXO8IdUdQOWWiMhj1ZispNtFdL6UC27WD
         nGweHLAARk4j8BfxPJg4h8fIZoDC+qcoQ5FZq/JJLnpb5W+UIgdvBLLUGLq9D4LTiMMB
         1vYuDXT2zAwbQv/fzfgYz6ELDA1TSEQTsNip4wtOpJZn5MjGWfPP2wAsUeo54ysGNVHS
         NAto7AB4qJpX755Og8WIMcM15GSUY1yIKO++UgL4nVpZQWCJAfeCf81kQN2UkpREhO8r
         GNpC/LNFGvH9K8XFDFni6YLgmv4HPTaBEhW/rIYA8CcG/htqIN/Mjy9elVxfrkR6gpzM
         ApIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850833; x=1776455633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        b=RBKCZASJbQbiAxcWLSp7HcN49wb4KpWSStYXOApUi6qJ4n9Au9pbnRd/OZGx52S1mS
         kklPfbW36jpRYR0USOkfThu+rXCCb0NHuJRX+VC+XwxymEabLQI26Ou1dsMU3zyPn5lv
         q8sCBG9WfMT+Fjjj+HDqSP3q5mf5c1rNgbLDgq3Gykz6Idz17NVkh8voN6sqyNJNhcr0
         muoZAmQKp4l6Qx6S4dTkugrr8nagxUOTLVCOHzPVAIOSWLrpGgyKrvMpLxJsRQ2bnzCa
         QC4bIvIpevqimHxaG1nxns3Pqxm1+6rCtNM03NXJRpRyTNB0IlB/omAlpGjQTNBAdsL9
         pUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850833; x=1776455633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        b=kwKiyxxhVED6yYoc80BS45GP9kZ8Igru9q6pcfNr7E/5S6Tsu223t3je5OJK2TExMq
         hhKFDwHBVshDIi31LUXPvXfje1ZPiWTfowfvfaR78GgunE8AIqiSktjdw/rm/0H6RuAL
         pwu8Y65aET7MR5YDPPxK48RQJEd36wS4u3FtLhtX0Gp7CDPmPsF6ZXcbb9qFyk4/8bsw
         Luaa5AnQifdLMyMN1wWvHFGKTTozDsQL0iLo59lWAwRnelL1ryCnte1ICU1V6kXU1jgj
         yxyxWS22WeOuoXvTaJ+Ynw6Q30fD3lsP0gg6P01feqWLY7IJfOVe2t7pcguT/rciJWAO
         +8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtzG7ozG8J/P+dlRgADeBXMHOhlqLn/Eds2IXcyEvw2qbpn9zF083F5Ygo754RrnmnCFHHQT7ODJ2xGuL2@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAtCGbKmYKMzlGqNZIZ3PuplECWc7iLgLn5OIedZGsA3VjqxX
	YzGfRhno0+05HxpRAkcL1l/Vs/0Hr6iroZSGBVgPa79IlpWN1tc4yfP914AgzfEZfC8qHj7ZhCc
	TBS89HKDKCv95nGytdteejllQDNIVduo=
X-Gm-Gg: AeBDiesRfTX/6FT/HRo3941AWjgp5hfHVl+UNwqLfBlpJ7cxeKS6vQB9lU2lgGUgF8U
	g4RwTXc4VHxLOSf6ePedySaEer+NcyKAyna+Gz+MO2i9C6GscL8wcMooMuJE8kiOtU0muCHa1Xs
	1+5cElcA4siiWu6yx4/yqy8Hmd40/IANLwIVFuF4nF8X5m66+KIK3rZva8VTHyAvRVn2iF1cx7V
	gAsqC0yVJYrv3Q7SgJtxc6cmAJB4Z4b+bx9KllNFdj23KthtYgpK3wkF2kqw4G3LGzJjniMr2j2
	Mlv6Jg==
X-Received: by 2002:a5d:5f86:0:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-43d642ba100mr6806377f8f.31.1775850833273; Fri, 10 Apr 2026
 12:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com> <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
 <b002dbde-cea0-4558-a918-db228ce8b48d@bsbernd.com>
In-Reply-To: <b002dbde-cea0-4558-a918-db228ce8b48d@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 12:53:41 -0700
X-Gm-Features: AQROBzDxP9-80eNSj2SoQ5dSv_Bn_mZ0OHqdTPbG7UFLIbNMGGzdiwcfkv3JkME
Message-ID: <CAJnrk1Y8yV6R6k2+x5zmO8P-KnhW7Rh+qxKbspHHcX1nYn=Bxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:32=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 4/10/26 19:28, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 10:18=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>
> >>
> >>
> >> On 4/10/26 19:09, Joanne Koong wrote:
> >>> On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birt=
helmer.de> wrote:
> >>>>
> >>>> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> >>>>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>>>> Do not merge yet, the current series has not been tested yet.
> >>>>>>
> >>>>>> I'm glad that that I was hesitating to apply it, the DDN branch ha=
d it
> >>>>>> for ages and this patch actually introduced a possible fc->num_wai=
ting
> >>>>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop a=
nd
> >>>>>> flush the queues without another addition.
> >>>>>>
> >>>>>
> >>>>> Hi Bernd and Jian,
> >>>>>
> >>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> >>>>> from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> >>>>> just going to write my reply to that patch here instead, hope that'=
s
> >>>>> ok.
> >>>>>
> >>>>> Just to summarize, the race is that during unmount, fuse_abort() ->
> >>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> >>>>> fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> >>>>> are being registered, which results in new ents that are created (a=
nd
> >>>>> leaked) after the teardown logic has finished and the queues are
> >>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> >>>>> never gets scheduled because at the time of teardown, queue->refs i=
s 0
> >>>>> as those sqes have not fully created the ents and grabbed refs yet.
> >>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> >>>>> the created ents because those registered ents got put on the
> >>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> >>>>> to free, resulting in those ents being leaked.
> >>>>>
> >>>>> The root cause of the race is that ents are being registered even w=
hen
> >>>>> the queue is already stopped/dead. I think if we at registration ti=
me
> >>>>> check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> >>>>> eliminate the race altogether. If we see that the abort path has
> >>>>> already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> >>>>> ent and return an error instead of adding it to a list, eg
> >>>>
> >>>> In my case (Bernd mentioned that I was investigating a hang during u=
mount)
> >>>> there were a lot of requests created during teardown, so what happen=
ed
> >>>> was very similar, but for exact the opposite reason.
> >>>> In fuse_uring_abort() queue_refs was already 0 due to an optimizatio=
n
> >>>> where the ring teardown ran before fuse_abort_conn().
> >>>
> >>> Hi Horst,
> >>>
> >>> Just to clarify, is this with running locally patched changes on your
> >>> ddn kernel? In the upstream code I'm seeing that teardown is only
> >>> called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> >>> -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> >>> it's possible for teardown to run before fuse_abort_conn(). Is there
> >>> something I'm missing?
> >>
> >> See my mail please it explains the history and shows the patch I had
> >> posted to the list and which is not applied yet. The DDN branches have
> >> it applied.
> >
> > Hi Bernd,
> >
> > Can you link to which mail you are referring to? Which patch are you
> > talking about?
>
> The mail I had sent earlier today, a few hours after Horsts. Somehow I
> have the bad feeling that half of my mails are going into a spam folder.
> I hope you get this one.
>
> Here is the link to the message-id
> https://lore.kernel.org/all/3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.=
com/

Thanks for the link! To summarize, what Horst was saying in this
paragraph then is that with this patchset applied, there's that
queue_refs =3D=3D 0 problem (since queue refs is now dropped in the
fuse_uring_cancel() path) where abort then doesn't trigger since abort
checks queue_refs > 0 which is the same as the situation in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/4b5a8040-b62c-4d75-a474-70d0b4759=
461@bsbernd.com/

>
>
> Thanks,
> Bernd
