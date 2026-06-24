Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BF2F7F0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782268290; cv=pass; b=QyhbXh3f7VZFWPM11A9X+mDa2CU9W2yNw0IeYM/iwgSQ8T6JICVBAAnzFZsCK9hcjxqPiOy3JRbMKEmThd3bf87QNpp11wqUAIJrsWsjw7ELFXkGc7lOMfSiX2MC9H5PwPkKjEHJfLRzRiqMJomplP35+yQ+zHMfblY61Go1a3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782268290; c=relaxed/simple;
	bh=N4POUWvYCLu0BsmCeg/Wl9VL15DujaVsb4Iw9Anbsjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOcmAMRDinl6f1YUMjPod7z+8w5FnVTzcKxzXNBKNM3sE0RCaoHsnaCUZJKtAqghsp9jH4Bs20HH7TrjDCKhBHCqhjJxGc8zHzgfhiuiNeGKyOIzlnIwYnJp/xVOL8eTLXd4xnqnTNcvJlNtaj78xVVld+BuH88DbdL0vN4J8pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHtmqMG2; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHtmqMG2"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-806449d108aso7157997b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 19:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782268288; cv=none;
        d=google.com; s=arc-20240605;
        b=ZehHzsX9kSEZqJR13wa/b7BpBzK33bpbOGWHtTtV125gxvU2py5TxL5TOApeRsFyX1
         mKClfEDLaDM0g/JhSD/rBsKjcAM2e+waw7AKHy6PG86sR9rB4s+N1ELJm0h8cuF0g0Sc
         QbFnZdug6By2t9z8yvuko0J0GYPIFY2e4/iKTltNEKXTyhGRMt4SE7FWfIK4WIAJTCUF
         ZZbRQhHxucgIn/kCv6siwCF/YadYnYszE37eFv2bSHex+HZCkukI5ithK4NYPqn1eMs4
         2VQDCuoL2auH0s9CVV44SECsUYfPI2ThjzxEZpzeMnL5xUcnzY/wEMQcGFx9GV7AaO6l
         X4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N4POUWvYCLu0BsmCeg/Wl9VL15DujaVsb4Iw9Anbsjo=;
        fh=59dRiB8hNYWfEGkiSrn2C/J7pSBN2LW5NCcr+Wc/Pyw=;
        b=Dq7G0nD6xyNjmSEhasuipmlCAeMAIgXovlasBr0caKSfG+PAJC7dI0TSAic1a6diCa
         WJ+BQg/7rAujHHJhbJlhtNMXmNxuhJAPrPnEJfWM78h/Q8zU/9ETwNE6rcaoQHqh592E
         rjfAzLaxES3beWUcrD06mngz5Lp05X1zp/6LiSeG/d6mPIc4TBxTkrBx/l3C/snZelh8
         nozH+Y6PCZZrJPTso7VRwphwPzu3JrA2mfyHm7VsvENPS+tRzpbMhIEHOyE2iyVTWcWU
         97HGIiKlVIY8xkk4Kw8dnmd5NDc9w0d1idc7l4jY3GGXkfqEoi7JbdTgo37OCKcEPec6
         lz5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782268288; x=1782873088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4POUWvYCLu0BsmCeg/Wl9VL15DujaVsb4Iw9Anbsjo=;
        b=gHtmqMG2XnsHFZ4lIE/mN7pJeSH/KQwcP6QtOYW4vdJrRnFKFvOVr2s4ceTqyfmgCq
         3tmsyyw7+ni3k/t5HB1B91kBN44O5nmgMtyUGUC28M6fa5LYqd3NBTGXSsw2AM009+NC
         RVigESTEGCHqLOWqtBZNUflX7d6VmskF5aB9JN6YRVXzM+ybaRPBKPrucypebDQxQSFv
         dnZETmCVwLI6x1kwLXox8rVa676dG2Oof6xsJq3dnHuz8KxqFDr8HleRKl9t7pWHsnoG
         tDDwaN9c+oyKHu/WtAi+RAdl4ND1N14XOVZozN5lIfStuh3jXTSwkdjvN0yqoYGJj3Xy
         U1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782268288; x=1782873088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4POUWvYCLu0BsmCeg/Wl9VL15DujaVsb4Iw9Anbsjo=;
        b=qDl55VqrnniTPadjBNVWRsLvIckSxbHx3Oy9qrQ+Y+KKlKHQV4nJEFhsYm+ab5DgE6
         DcRtpqa6ocBa6LHshBoMjodC6zYljzmXWNTIdLUq+gDBUdV3Tf5+2sC1KznG21Hv22YQ
         VcWqWYlBU6Ouh64mmtjvcs6e8ovPcU5ACu25aaZ1GLsNn7WgFyY3kLPk034DqkeIfyWz
         QZF33XKE50CDFTE8fSG93FTQPacBzO2+oI/q1QyJJlu70jnS7luiIpmkEe3hcYtmVy6Y
         ymju+G09TU7wh1skTyv5ghpCKX6EkfkywtS7e7IHR4Cd2QlYe5USiugeywI7fqXox6Kz
         Im6A==
X-Forwarded-Encrypted: i=1; AHgh+RoLWxfHX8lxoiFxJ+r9eyPJ5uOt8p6t6wgwhcvGYWjLF61ZfBUynbLxjUQdyTzmyRiuPAZY1h315NP4g4Ww@vger.kernel.org
X-Gm-Message-State: AOJu0YznRXzonqVM+Tq8ryrq+gZtfF1RYv0qAX6jy0uxkmJZ9tqfuurC
	9wLckC7FBNkoYbN0xx0xHjGL3Jro0S4VUXA/Yqzk7RN1reI5fdbglLtIAL7hy00sdzvOBp+o/sL
	3ld9kDSlObx0+DnVpMXJ4drM2Vffnhc8=
X-Gm-Gg: AfdE7ckjh1WJp0pfyIrjGqfdVuegOMi2TEKz+LzPtuvM3+gK7go6jDkGhMaJPypGzEA
	fGi84wQxt4/4aMMfGmPjT3xm+mFiIk4tHoXkCEvVRFooEFrvFaWLABQ4RvToC9LylQMelH6Aog+
	Eo6Ayea/p1qjBxyWpbPquIL86DDRpWPpe0wnkqxG2pSbB2V2UZp6ayUv7qdlUR6KH2eHk3GJ0nJ
	dZI/+BJxCq0DL453LuaCfJpRXuIPruBRmy7/5NLk48cKjeA88yY1xw74Vazty/YvvOQNZfo+4Ok
	j238ef/KuExUUdETswp9fnjH9PLPdA==
X-Received: by 2002:a05:690c:4486:b0:7db:b027:6166 with SMTP id
 00721157ae682-807f2be793fmr13876827b3.22.1782268288394; Tue, 23 Jun 2026
 19:31:28 -0700 (PDT)
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
 <CALOAHbBjhqKZPqb9r8qoUoYfzpEe6wYU9By_cZtuGGmnoaAa5g@mail.gmail.com> <f650bed9-b049-4576-bbcf-6dd46028c5a4@linux.alibaba.com>
In-Reply-To: <f650bed9-b049-4576-bbcf-6dd46028c5a4@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jun 2026 10:30:51 +0800
X-Gm-Features: AVVi8CfS2zoJV8luPHkguUpjQ2Td-WyBgnKGjQ4yu0nAqcn50NS0ZE5BbKknLmw
Message-ID: <CALOAHbC=2AvZYWEUXR9bk2s=2jk_sVK6zimes1H-TK3iFnn_qQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, fuweid89@gmail.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	derek@mcg.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2026/6/24 10:09, Yafang Shao wrote:
> > On Tue, Jun 23, 2026 at 10:52=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 3:47=E2=80=AFPM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
>
> ...
>
> >
> > Since the "volatile" option has been working fine for over a year
> > across our large fleet of Kubernetes production servers, I submitted
> > this change to upstream. In Kubernetes environments, there is no use
> > case for remounting the workdir to the same directory, so the volatile
> > file won't cause any issues =E2=80=94 which is why the "volatile" setti=
ng has
> > been working well there.
> That is not an excuse to introduce such new incompatible behavior
> to the linux upstream starting only for your customized fleet and
> bother every single opensource user/application to adapt this
> behavior which uses overlayfs now.
>
> If you insist to work on a breaking change, please gather
> userspace feedback boardly first.
>
> And here I just say you and your employer are lucky since I
> know it's also risky even on the generic kubernate perspective.
> Please just maintain your livepatch downstream, thanks.
>
> No need to reply, and I won't reply this either, it's just
> waste of my time to explain a basic upstream principle again
> and again.

I'll just go ahead and redirect you to /dev/null ;)

--=20
Regards
Yafang
