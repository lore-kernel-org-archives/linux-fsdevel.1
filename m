Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF92F691D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272517; cv=pass; b=qd7amMtDfODqS8Za7wCqfIdSOfENRmXvrAvFa6Pn/lKpBUP3N68/Q0l7zGZyjW0jCDWVpTtxSH0WkeDIjbfFy9mBpWnZ6HA/5XLswkSMcubhGQua/lfxUkrBpTLKEfJj1vI27/B7R6DLiAoi1MC79sgflf8DTtS2JQh1ZxxkGwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272517; c=relaxed/simple;
	bh=U2UuNuly4gL0+2XrDmm1FfmBDxpUxQXqduxxXaYs6N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da/gvUT4BU7tcwiypG4K0Dw2BnqpftYQrh81oSKjPlUqmMYX10XAK/9kNL/OcTsGiF4wlMkillUcq8Gp8hI9wdn9gNVC6bZcBmvg3rS1Qrrp5xLyuCvqkh1YQjE9/EuN/MesTqPlxXED9ZJPc5X1JTTnbPJeFdtSNVXi+re6Zh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4cqjH0U; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4cqjH0U"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e0b3db3499so5680247b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 20:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782272515; cv=none;
        d=google.com; s=arc-20240605;
        b=MXNh48AwNodl84+i6I9qnZXZas3r7UNwDesFJpIIe+dijeWDJOEiOxEYHRNVAu3ilC
         Zh0DZPa1w39bg13gqEqvSRyObO/LJw8yJ6RvPOrSJUzlAcpMUWtMVYWRwgMgV17M+SG1
         dMsWj5R/6NHSKucdS7FTFRF9/uews42ee03qypEveotGNSf8mBcRsoizLfIq5zxUA4ZA
         v6/eZFPIjMdlhEAnu2HfOMu50WBJjsLp9+SkT3p7jCmTj+GD+6k0AtkBp1U+3tMaaGGg
         s79lya/efiwfQquUROk2CPD5/HHjcJzAP+NX3TRFZ3mlFiUdQJaFdeneNCpqDnxGBkXp
         5f5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P6Gk/nUwBGsoSlBgHUi/aDNnbDSHEio+4Fp7O2GUofM=;
        fh=1VoSXpSW89AWboPdHphnl3b6dT/EIUnaTirvSkny0e0=;
        b=fybqwDdh+xQhAt0gvWMh4R5L8ot/Pt1tgk9iRhfB+etHfjkRZvRiH2aVTIvNCU8CWz
         +sTqJUttDPSyO/j2nbS84jXGrXPiPdM22IPs85+zY4ya4BLFn6GsKozU8xq2qTLZQxpG
         Bwt573PNDema5KejXRYPIGVZkh7ZnbHQH0CWf9jRWZSFg4azeFtCJW5nukp+69Le/KtB
         j04VEf8JRZ8sT8y0D3Ay4vms2avLjGzCZbmT7KVXM5QOY3Grzc/dtpdIvt2LY6eW9Be5
         bgvzLwxSi1Py1GfmX/IGkGQC1Myxgv+SsN4aZFVz5OboamzN2BH+mg1TBuIiUalnlXlw
         bVUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272515; x=1782877315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6Gk/nUwBGsoSlBgHUi/aDNnbDSHEio+4Fp7O2GUofM=;
        b=X4cqjH0Unohy2FbrpqCsgIIG24XxAGkUMF5Fs9QaM08+f44SOG+B5wd+/b3DbcmhdJ
         jhYIdj3u6I35IR7TbsXn0o/sz1y2sKnaNIPbCqnO1GaR6+Hzw4Q60h7IbrFU0cCic438
         85FbWYbDJDZgOZERZn6fThLqCodUjAk4S5Whe1fFHU4PXt9B9ssNfVzB0y4TmhpyJX9T
         tZW/+FxyOFivxmDX2tKTmzt6r/8aCneBAjrzYKrkMuiQGb0b5xuj4G1L/PVXcNl2K/Q4
         oJT+K9gMeU2opnmrtAT7ogIJ2aNVmvNENm9WJBaWhOzx7H2aceN6v2hjxRqAJV9kLUJR
         FvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272515; x=1782877315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6Gk/nUwBGsoSlBgHUi/aDNnbDSHEio+4Fp7O2GUofM=;
        b=fRKAzshRqOJW7dVQePfZMCPldUoCkqV7KVjl9sBEgiM95Z08ynsUzV+meAbfaIll+7
         2s9hW8o+BPEs2K8udIm2A1h9Mega2M/he5lOPsT2neJK0BH7Dm/eyJtK9FjrjC1aFoNi
         NUGH1UoOpOcuXQ8eXkXxx1g6HWQdm/rsIf2MMgpdnWfdVIosWNyaPS6uvVj+l7qZN1Ln
         AMPTGkMYXIDDHssbSusJeQ1FAcQaBwUsVPZ1Qid2i/CVyJcj9TkKF4GapBSvv1eHPqd/
         by4qLzcAw/BR+MYPmHncOIdd813Y4gDmuPSLQ/623uQ2whJfLJJzUK/FPPNMkX6uEEhR
         Kw+g==
X-Forwarded-Encrypted: i=1; AHgh+RobgAHMGK/bEQ/zJ9hlu9XPJT9vl/8iZwDu5ODa6ZUpJ1zN5q28l/BdI0Qn28zcYRc1ShuYHa7tSXA4zpPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzXo9f3Taao+m0MOwh6rf0dEFyXzcszoB0o7Oi5Vq2erXiLnVaO
	F+A0YOEjeg/rFNiZYQ7152lhMwyCDp7sgy2Q3dY/0FJG5+qMIMUjvcepBv+xEZMSUJVZuVy4Tat
	KlIZJtwH++JBK7JfWo/NitOxJLX1yFuQ=
X-Gm-Gg: AfdE7clMST1Xe5XgO4cmmOD1/dY17SK1+2sIBcTSia+nADjD10jYj0aweD15aTaW8Nd
	KUhdmRwmvR12n/9m4ovMQq/RKhVxdt1GZr8ikfTSd7XvxCPE5pQcedfIOtQxFuGpoAdEn7wEUmF
	XIg2/EccohUufcgdMJgqC7xMhm3P43TqSks/2HmRwOkJeJs8GhDfzVGYYvr+6WFKcHTgwtcA/Dq
	dKIxNX9OlBLugnpTna7smMO7rdTFcWzIlH+jyc6nLK4n8nXntQA8syE0LDwbQZJWidTyJy/YYCa
	fgUMcsZP6IK+IYmj8NjWJBPyQjmg9TKXJp+EiIos
X-Received: by 2002:a05:690c:f0c:b0:7e9:9f7e:9f3 with SMTP id
 00721157ae682-807ef6322a8mr16184577b3.35.1782272514505; Tue, 23 Jun 2026
 20:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbAY-3GAd=7DsA74W4ax7aPdXC7ecYt6b+tHoxFu754ZjA@mail.gmail.com>
 <ac56e537-d095-487b-8272-726d6739d0af@linux.alibaba.com> <CALOAHbCBo2eB0xVoSv8Vi+r3DwbwTticismFSL3EXyYuwFkEzA@mail.gmail.com>
 <13bb8cba-c82e-4a41-aff1-0a6418873bf1@linux.alibaba.com> <CALOAHbCkbSBVqUStUbWB=4vUUOEyB63yMsXvS_cZUZOwr-nmew@mail.gmail.com>
 <a5a1b56f-0b1a-473d-8fc9-8cbfba85813e@linux.alibaba.com> <CALOAHbCrvbvT04O3v+p-CmdqVN2BGJYKj6F7we70kPwbs-hmRw@mail.gmail.com>
 <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com> <20260623134240.GA7980@lst.de>
 <1cc0931b-648e-4baf-9667-742175b3f9d0@linux.alibaba.com> <CAOQ4uxhURfuQWMd3y_W1iFebJms3aohn+koy5_sjxbcc4ZBQ-w@mail.gmail.com>
 <CALOAHbBjhqKZPqb9r8qoUoYfzpEe6wYU9By_cZtuGGmnoaAa5g@mail.gmail.com>
 <f650bed9-b049-4576-bbcf-6dd46028c5a4@linux.alibaba.com> <CALOAHbC=2AvZYWEUXR9bk2s=2jk_sVK6zimes1H-TK3iFnn_qQ@mail.gmail.com>
 <33912eb8-6b2c-40c2-b698-837e3f675d61@linux.alibaba.com> <CALOAHbDrWR0eRF9gST14Vm3xOimDZ=iLdn0zRFiF7OeBtqOD=A@mail.gmail.com>
 <56cdf083-99e9-4656-a353-f4d4670917b8@linux.alibaba.com>
In-Reply-To: <56cdf083-99e9-4656-a353-f4d4670917b8@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jun 2026 11:41:18 +0800
X-Gm-Features: AVVi8CckYDPxpxM_bRXwTTUr5KwCRBp7mzrJEc2POq-lQJEUvksQEVYlqip4VFs
Message-ID: <CALOAHbDzuxZ1Nx+viPg33Fnb1aBLw_Sw4GFeM3ngshjGpVvdcA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: conduct@kernel.org, Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	miklos@szeredi.hu, linux-unionfs@vger.kernel.org, fuweid89@gmail.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	derek@mcg.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:36=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2026/6/24 11:28, Yafang Shao wrote:
> > On Wed, Jun 24, 2026 at 11:17=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>
> >> Hi,
> >>
> >> On 2026/6/24 10:30, Yafang Shao wrote:
> >>> On Wed, Jun 24, 2026 at 10:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.a=
libaba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/6/24 10:09, Yafang Shao wrote:
> >>>>> On Tue, Jun 23, 2026 at 10:52=E2=80=AFPM Amir Goldstein <amir73il@g=
mail.com> wrote:
> >>>>>>
> >>>>>> On Tue, Jun 23, 2026 at 3:47=E2=80=AFPM Gao Xiang <hsiangkao@linux=
.alibaba.com> wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>>
> >>>>> Since the "volatile" option has been working fine for over a year
> >>>>> across our large fleet of Kubernetes production servers, I submitte=
d
> >>>>> this change to upstream. In Kubernetes environments, there is no us=
e
> >>>>> case for remounting the workdir to the same directory, so the volat=
ile
> >>>>> file won't cause any issues =E2=80=94 which is why the "volatile" s=
etting has
> >>>>> been working well there.
> >>>> That is not an excuse to introduce such new incompatible behavior
> >>>> to the linux upstream starting only for your customized fleet and
> >>>> bother every single opensource user/application to adapt this
> >>>> behavior which uses overlayfs now.
> >>>>
> >>>> If you insist to work on a breaking change, please gather
> >>>> userspace feedback boardly first.
> >>>>
> >>>> And here I just say you and your employer are lucky since I
> >>>> know it's also risky even on the generic kubernate perspective.
> >>>> Please just maintain your livepatch downstream, thanks.
> >>>>
> >>>> No need to reply, and I won't reply this either, it's just
> >>>> waste of my time to explain a basic upstream principle again
> >>>> and again.
> >>>
> >>> I'll just go ahead and redirect you to /dev/null ;)
> >>
> >> The whole thread is:
> >> https://lore.kernel.org/linux-unionfs/20260623084337.54344-1-laoar.sha=
o@gmail.com/T/#u
> >>
> >> Personally, I feel offensive due to Yafang's expression
> >> written above.  I keep maintain my replies in technical
> >> discussion, but the replies above already include the
> >> following words:
> >>
> >> "No wonder containerd is getting harder and harder to use ;)"
> >>
> >> "Please do your homework."
> >>
> >> "Again, pls do your homework."
> >>
> >> and the emotional texts `;)` make me feel uneasy over the
> >> time,
> >>
> >> especially the final words "I'll just go ahead and redirect
> >> you to /dev/null ;)"
> >>
> >> So I write an email as a public report to the CoC since I'm
> >> not sure how to proceed to comment the community patches
> >> because I could get offence as a result.
> >
> > I believe you could learn a thing or two from Amir about how to
> > comment on others' patches ;)
>
> ;) Please let me know why you commented:
>
> "No wonder containerd is getting harder and harder to use ;)"
>
> ;)

Because I find it harder to use than Docker ;)

--=20
Regards
Yafang
