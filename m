Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38673090E2
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271755; cv=pass; b=mUTxTYSAeMqb5xyCOPI0QIfN7nLxdeOU7G7eTK2EU6iZQMqXyBPsHENrI4OKxGpWkFXF0w9OtHgyfGRgPQW9L+IvmYWFMhZr2bV0+auAMcLr4nnp1GpuUQkNjLO0KVxdKIOuclhPXaekXEJ3zMwBAgFDkfPdueTzuhatHQQHuxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271755; c=relaxed/simple;
	bh=67HFPOQMraA2IF9L6T7Ay7iDPKcTpVfUYIllTU0wk0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g72xp92/Rs4IBWSUkqeEt4mEq4z6zC6++dDoEadUdDhu1OudXylsZbqIEe2xdTe8ku2DwJJJTQ8vcHVIG9ChNkuyd6hk0Y+7Tr0fSyMWIPLBeSEYLOU7cxgbFlhWfEAPWRWofgaB4YCXm2mVlD4rx897CfjxB9ITy3pBcOcuANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmNCwazg; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmNCwazg"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662df6a4fe4so750681d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 20:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782271753; cv=none;
        d=google.com; s=arc-20240605;
        b=eYHWIUEAoW3piTb0jsCVgBgm5QpJT7RZ38rlnGHKMZ9p/G4xp4ifHlSNu1f1r0RTb5
         5HvDfFuwFVFYNwWi6QHr1yOXG9/rqmf/wTFncgiayLKuVUWv25JyvywduTfYyjxOP1Yd
         Rby4BBfOPeuJEhBTAu06MPR/bpHFcOTEHqM2Wj8Auv1uIxmriGL6uoKlvnJLRrFDfm6a
         hePry93rneXxpVILvJFgfv8XhPw3NFRVeYP07EiVkMXJI/qy1GN9zGEkuYjDTTH3HcKD
         nCwUdpCdSGaAI9uUeDqGXCdHLJds/8i/B2csJA9FFkAkfc6ttLJBAE0Svk3jqJJnRlND
         NQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9w9ybFX1EjLq5kZ5i9aFTSKQ0ykzW9QyuEa4uAxGDQ=;
        fh=MXELeXd0tQA+ZL3PK26DzAEzzagRJTJ0F4pF/qGOzQw=;
        b=KX0y5FVYpMB5fyBrBasFY1T70+IlokfCzSOl9j6uHmMoFchIaPSrzCGYwe/gZhDccO
         ZkIBToIWS+xNkNTzSMW6zKHl80M9Rbs+RV08FDC2RuoLKvpvGrhcAcreQeb3qTXroez5
         szJDM/HKYpwqnhY87rSElEJqc7prG27AojbUjYX0r8S+OJK60t+X0nUrsmW8Nu6xlsA5
         zycXDDDJQDrKTYs3fXrKUs6H8x0/h8a+I3vI9oCGrwrZmMfCOIovYyVnuV6cFywmcovx
         l2LLMznba65sLie5OhXyqu4SFd1qFHgrIY3mXeYRt89SBQvmqYAe/9Q0ceIkPGjtOXtw
         rhwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782271753; x=1782876553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9w9ybFX1EjLq5kZ5i9aFTSKQ0ykzW9QyuEa4uAxGDQ=;
        b=KmNCwazgksGIARY4hmn75AM4DanJgR+5VcYfzD4nPV7fLf3q1BSktQvRgfV0FmdlHB
         2hWAuvkyRYpvPl/Sei3ejnL1NKA7ycTULnB+wzFAsHKKmeaxG/a9UsmDl2N4K9DnNYdr
         UT/9jbVHlfgnYzif+f+qFhVDUE3CsKGIGYwyFEr9NS9qk/xipL3mxP5KFIw7GBG/aeoI
         YvDIWuwoYvv9GAHs2yOSiaQkvxIoaljMsa03V4b/FSo0CeBNgtFYGzUawx2x+IedH+Pa
         E3M7UEim3Rb8flluqVqyrzlGSZStYv4qK8bJO7Lvxz7qfxPhrdCk/Z3bUBVvd9pKVqG2
         XpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782271753; x=1782876553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9w9ybFX1EjLq5kZ5i9aFTSKQ0ykzW9QyuEa4uAxGDQ=;
        b=PYtrc4Ikc+ElS1fgiTCK5plWINpKDZpBo7n934AaCrxBpU0Cu5N/JVH4X66hGJ16Ao
         aP/RrQbHd6Qnij71C5UeH/TKq0wgVvsJ2IsOfne0SmRcn/brqfldjNquyrogLJMYkvhB
         /lIsVs0b+xi+IhPEpLeX6R2HbHnP61lifjw0597h6bS5HvvaQE2LnOi7CtpykZ8Rum6m
         G8o2T2t3eZH4rnKgdfsMvuGwD495y1ULRrJB9JdloGkybSU0pgYfqX4auHiXSZFPXKml
         eqxbcF3jPNs3ydlLfq7epubTMHAFwNPF/KagFs6iB3csYCZTttvGikfa4i9XCh/BTnL/
         yr+w==
X-Forwarded-Encrypted: i=1; AHgh+RpA34X5mPit475XRmfUJE0mMOLgAXU+83oaC+ZdwM04M4PORUvB21RANrZPnAfY9C6gcTe7Y99J1CpMFl6t@vger.kernel.org
X-Gm-Message-State: AOJu0YznxuclWM0yAMphYwQE23b3tBGE3STvbPsRlXiVApSPjQS1BJJY
	3I28URYnypeVHv6D7oHfjs1xoqNzU4H2FNEex0jB1oEMWV0YxYQShM89RUXa3fTSa0UOUxJuoaV
	Di5pWPWUo2onEjxt6EJTsb7sxglfZY8U=
X-Gm-Gg: AfdE7cnyQ8eWMgkCUKUgsn7j3Mj50uf/IGtgXCHjDUk/FYtmX9ioNuSS6/sksud/2cc
	LjtVsM+EvtcT2qlwbL8CeYmHnwnR0Hpv/jmId2pFWb3PTPzhA9bMiIHfFOVW872ZHmBpP9aKJJB
	2jqVtDimMqIucVuzAHcUsv53+eVQ0J4VEJBBwkB2XD3WEKNvGceiEX6lg2paq6Q6HvL4z6/bKe4
	+NfCLfhgAOvJM2Oyehg+7aRLVNvjmVaNwc0nTflmCKZ59jF5XwgqmwrxIPpVUYJWfyiz0ziKa2f
	V/4YrJ1rkgZuyetuBY7hYxab5pv05g==
X-Received: by 2002:a05:690c:7342:b0:806:8eaf:cf1e with SMTP id
 00721157ae682-806c2e4df8fmr56909717b3.25.1782271753102; Tue, 23 Jun 2026
 20:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbAY-3GAd=7DsA74W4ax7aPdXC7ecYt6b+tHoxFu754ZjA@mail.gmail.com>
 <bfdf1d1e-2313-46e7-8567-da2a363d6b3d@linux.alibaba.com> <CALOAHbAShZ-xYWw5yObqea4hB-4=NmTz1HiKQrApZpxsHvG_wg@mail.gmail.com>
 <ac56e537-d095-487b-8272-726d6739d0af@linux.alibaba.com> <CALOAHbCBo2eB0xVoSv8Vi+r3DwbwTticismFSL3EXyYuwFkEzA@mail.gmail.com>
 <13bb8cba-c82e-4a41-aff1-0a6418873bf1@linux.alibaba.com> <CALOAHbCkbSBVqUStUbWB=4vUUOEyB63yMsXvS_cZUZOwr-nmew@mail.gmail.com>
 <a5a1b56f-0b1a-473d-8fc9-8cbfba85813e@linux.alibaba.com> <CALOAHbCrvbvT04O3v+p-CmdqVN2BGJYKj6F7we70kPwbs-hmRw@mail.gmail.com>
 <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com> <20260623134240.GA7980@lst.de>
 <1cc0931b-648e-4baf-9667-742175b3f9d0@linux.alibaba.com> <CAOQ4uxhURfuQWMd3y_W1iFebJms3aohn+koy5_sjxbcc4ZBQ-w@mail.gmail.com>
 <CALOAHbBjhqKZPqb9r8qoUoYfzpEe6wYU9By_cZtuGGmnoaAa5g@mail.gmail.com>
 <f650bed9-b049-4576-bbcf-6dd46028c5a4@linux.alibaba.com> <CALOAHbC=2AvZYWEUXR9bk2s=2jk_sVK6zimes1H-TK3iFnn_qQ@mail.gmail.com>
 <33912eb8-6b2c-40c2-b698-837e3f675d61@linux.alibaba.com>
In-Reply-To: <33912eb8-6b2c-40c2-b698-837e3f675d61@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jun 2026 11:28:36 +0800
X-Gm-Features: AVVi8Ccywfv8INUcKNw9ZBGfqnyagnG08Ez-eeCcHS_qs6k1llTDKaKEY-xs-s8
Message-ID: <CALOAHbDrWR0eRF9gST14Vm3xOimDZ=iLdn0zRFiF7OeBtqOD=A@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: conduct@kernel.org, Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	miklos@szeredi.hu, linux-unionfs@vger.kernel.org, fuweid89@gmail.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	derek@mcg.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:17=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi,
>
> On 2026/6/24 10:30, Yafang Shao wrote:
> > On Wed, Jun 24, 2026 at 10:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>
> >>
> >>
> >> On 2026/6/24 10:09, Yafang Shao wrote:
> >>> On Tue, Jun 23, 2026 at 10:52=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com> wrote:
> >>>>
> >>>> On Tue, Jun 23, 2026 at 3:47=E2=80=AFPM Gao Xiang <hsiangkao@linux.a=
libaba.com> wrote:
> >>
> >> ...
> >>
> >>>
> >>> Since the "volatile" option has been working fine for over a year
> >>> across our large fleet of Kubernetes production servers, I submitted
> >>> this change to upstream. In Kubernetes environments, there is no use
> >>> case for remounting the workdir to the same directory, so the volatil=
e
> >>> file won't cause any issues =E2=80=94 which is why the "volatile" set=
ting has
> >>> been working well there.
> >> That is not an excuse to introduce such new incompatible behavior
> >> to the linux upstream starting only for your customized fleet and
> >> bother every single opensource user/application to adapt this
> >> behavior which uses overlayfs now.
> >>
> >> If you insist to work on a breaking change, please gather
> >> userspace feedback boardly first.
> >>
> >> And here I just say you and your employer are lucky since I
> >> know it's also risky even on the generic kubernate perspective.
> >> Please just maintain your livepatch downstream, thanks.
> >>
> >> No need to reply, and I won't reply this either, it's just
> >> waste of my time to explain a basic upstream principle again
> >> and again.
> >
> > I'll just go ahead and redirect you to /dev/null ;)
>
> The whole thread is:
> https://lore.kernel.org/linux-unionfs/20260623084337.54344-1-laoar.shao@g=
mail.com/T/#u
>
> Personally, I feel offensive due to Yafang's expression
> written above.  I keep maintain my replies in technical
> discussion, but the replies above already include the
> following words:
>
> "No wonder containerd is getting harder and harder to use ;)"
>
> "Please do your homework."
>
> "Again, pls do your homework."
>
> and the emotional texts `;)` make me feel uneasy over the
> time,
>
> especially the final words "I'll just go ahead and redirect
> you to /dev/null ;)"
>
> So I write an email as a public report to the CoC since I'm
> not sure how to proceed to comment the community patches
> because I could get offence as a result.

I believe you could learn a thing or two from Amir about how to
comment on others' patches ;)

--=20
Regards
Yafang
