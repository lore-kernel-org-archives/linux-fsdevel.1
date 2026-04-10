Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A283E1D05
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842102; cv=pass; b=aYNfwOLwtehlmg/oXLE16r+aB1ORdHhKyT8ImyXBVj4uzDGKdZOvGDfy5IlrJ0w+kILEDjpSnEyWumAHZrl/p6Blv67n9irJ35Z4IquUi3um4TlHea5cN4Hx3SRb5zut/EyObAI4lPMaOnVp2Ekv/WGP6RzXPHwkZzy+L4QM+QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842102; c=relaxed/simple;
	bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D35t4WKPG9A8QTvfImTULyqlqwyxCdnAYUU6V3cXZ6poKOq2nzOGnaNTkvZVG1ZxnBcTX/U0+8FjqoAfA4EmFLNV8rfR9yHJ+NhBgnV6DLQIa97D5hGsEprGXRPqNN57Ku9jcao627DXFIaedSP8wOStSpffGE8BhcDv+nYEDCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/doCxf4; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/doCxf4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488c2690057so22807015e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775842100; cv=none;
        d=google.com; s=arc-20240605;
        b=Mux5pw+hdV/2A1fJo+G96vKEO6fEdRGJNRHHvS8Ujk9676aWGu9+ZSz1hC8rBq+OmQ
         nYtDbohXmOrgghhusOmHviLqn/EvAEICwpG1n3a9LHAkKJl0k3dswilJ5123MeKegNkF
         XLnKQGEvH3EaTe94cyHsLsBmNW4wnfBX4hTtQj0Z/emqt5rpIxBG2vKidIQ1d0v5PoPD
         78/2Z4ov0E8xmq0acw5vufztGn2z1SPOruGdRrpO9xyrpS//4lArQ0WwzqBAUeQVv+FO
         fP0MjO/RrmZQaCu42+kUkx2wH80hzfqDhp+srPMKTcl6MLDRng9L20xM1c78cJnHFnG0
         sVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        fh=wdBgW+0esGIVkVa9iIBxK/A45jNhTMnozsDkKCBqKGo=;
        b=SO9Plwnc7SJw3NBYaq0fFWt81wjT0NKXsJ4H/MxnaqMXSJas85XMhSWJ+JPwb1ODdg
         ZhYqewf1UvWdgSVB7py+SPMobtpvk+XACqmjjikIA1VXTyQikfjuI7kFYAlI17bgP7g7
         F+Yj0W4v89vf3UCeT5HEZnWJ+c7mB6kXdYUuUnITZP4fntb6LqA04ID3ZyPorl9523Wn
         QaECmPV7nhLmTHjDG1iEQRRDVKaooh6J32Gh86Ee34VLuPAI2sJePaEGhxIiqklx+qWR
         pRU9P5S3VBzf0kO5z66RsvJeaFBv0RqlqZ0csu5QPGLFNvtRW7Ksl2QnRHnmI/a6ndZC
         aHJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842100; x=1776446900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        b=G/doCxf4nvuExAnmxE5TaRgRRXk044LGACoz228o+fpBD1gBo0Js3MeYfpn9zFDsir
         gOalSgw7B08P8jNVcMSTyznIz6U8iQWj4gkE6MkEpaUDxDEn2dLE2wIPTP/GvVCz3aqt
         BKLSYNAcuBVxlAaazNwvewJoKlW+VwESoMDiKje2gNcU40Fyyk/mq/nqku++GF8M0L2G
         gbm8UNlt01y0M12REnHtAiDKt4xnM6Xs8NgmMi2EMZR0MAUd7TGmFEYi35wES7t3k1lR
         BhBpOEpSzKhqq008uwTKRX4Z3Zs0Gz+mwIRbANu1o7qfdExXZRMGmKGwUKzNdmv0voBl
         zM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842100; x=1776446900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        b=goVVCXtnWvzLlM5ECi57V6D5JJ07aoGgcuxQEJT9m8DkrUV92Vw0OTzXB7DmtRk1Fi
         bmfAk0veFcqh5xQm5oyba/vxHySXVJOBg/OGHFmiwSUGPpcydm2Jsl1ZlJwyge0V+qUf
         S5QhEN042xBMFg5Jt9wyxYkhX7EeJZ1EatKkM3P26DdaVj/UVMwToLG4IHlwmhAVMPvZ
         4b0Xwed5XggOZyI7H4/1xtLLMDtxc4rBd0ABsePONStPU5Iez2o3vo0LAJLtK/meQDGA
         re4//R3Q+E1P0RlE8G8hDkDKQR6kX277eW/N5E6sQt5OCPWxzkoWL7laIlkY46vU9fpV
         a3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXqquq6cOWDdurwOttKz6FGXiw1NAxRzaIwbnbqqruxtGMNt6nz32yH187UXaC2Dw2Syi1jVSHZcpfxODCa@vger.kernel.org
X-Gm-Message-State: AOJu0YxohrWrDD0kqNOMx+GYAQCSu9wJaLUI5UZb/Isj/IhOCHT8o+aS
	Oe0nNbUKHc+dds8TClsPuA86E4bgnijzs/6yW80ETlNeQAh5268EobYoAwdPWno6oiX2FwKfDUu
	y5LJrhjXyw/0PROnRY5mzcdDlzV2lBjY=
X-Gm-Gg: AeBDieuD0IUSWigbfiAjDhS8UzIqW5w4ZOcVQat5a4szBmrzB9eQrFr8RA1kN1hVFlv
	EBiTNHIKxTJTWprN5CTIqF/yRgMpwxx5K3C6ctGYWeN1uDlXEtn2T6mseuxf000LjMII5KXHZIY
	srkInz4gjXZ0YzhL3yQTT/UwJXnApKVRmYvVbc/UC0/3mIjLqJSgBEyEQkvikJOUzoDkcwXE7nH
	ezk/uAVlVJfZJRqa4wULi9VYWuzFeFP4bRGKkkULS6b/xxv0nso70U/K09JXMirfArd2o1Zj7Fr
	hSm1Og==
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id
 5b1f17b1804b1-488d680851fmr53226865e9.6.1775842099481; Fri, 10 Apr 2026
 10:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
In-Reply-To: <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 10:28:07 -0700
X-Gm-Features: AQROBzCBpnM0YmTlP8NptZ8FmIfA4r2lRbJ75c7O27XrO_0_1rvbDAboqFdeYds
Message-ID: <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:18=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 4/10/26 19:09, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> >>
> >> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> >>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>> Do not merge yet, the current series has not been tested yet.
> >>>>
> >>>> I'm glad that that I was hesitating to apply it, the DDN branch had =
it
> >>>> for ages and this patch actually introduced a possible fc->num_waiti=
ng
> >>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> >>>> flush the queues without another addition.
> >>>>
> >>>
> >>> Hi Bernd and Jian,
> >>>
> >>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> >>> from fuse_uring_cancel" email was never delivered to my inbox, so I a=
m
> >>> just going to write my reply to that patch here instead, hope that's
> >>> ok.
> >>>
> >>> Just to summarize, the race is that during unmount, fuse_abort() ->
> >>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> >>> fuse_uring_entry_teardown() gets run but there may still be sqes that
> >>> are being registered, which results in new ents that are created (and
> >>> leaked) after the teardown logic has finished and the queues are
> >>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues()=
)
> >>> never gets scheduled because at the time of teardown, queue->refs is =
0
> >>> as those sqes have not fully created the ents and grabbed refs yet.
> >>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
> >>> the created ents because those registered ents got put on the
> >>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
> >>> to free, resulting in those ents being leaked.
> >>>
> >>> The root cause of the race is that ents are being registered even whe=
n
> >>> the queue is already stopped/dead. I think if we at registration time
> >>> check the queue state before calling fuse_uring_prepare_cancel(), we
> >>> eliminate the race altogether. If we see that the abort path has
> >>> already triggered (eg queue->stopped =3D=3D true), we manually free t=
he
> >>> ent and return an error instead of adding it to a list, eg
> >>
> >> In my case (Bernd mentioned that I was investigating a hang during umo=
unt)
> >> there were a lot of requests created during teardown, so what happened
> >> was very similar, but for exact the opposite reason.
> >> In fuse_uring_abort() queue_refs was already 0 due to an optimization
> >> where the ring teardown ran before fuse_abort_conn().
> >
> > Hi Horst,
> >
> > Just to clarify, is this with running locally patched changes on your
> > ddn kernel? In the upstream code I'm seeing that teardown is only
> > called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> > -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> > it's possible for teardown to run before fuse_abort_conn(). Is there
> > something I'm missing?
>
> See my mail please it explains the history and shows the patch I had
> posted to the list and which is not applied yet. The DDN branches have
> it applied.

Hi Bernd,

Can you link to which mail you are referring to? Which patch are you
talking about?

Thanks,
Joanne

>
> Thanks,
> Bernd
