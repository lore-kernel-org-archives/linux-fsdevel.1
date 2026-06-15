Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6C3E5A10
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525220; cv=pass; b=r5QvVapGPFJU7fnjC3G7YktZF7YfUz4d1lLUJqYidx9lhwt3KfSH+iqALIAQ6wf5tgC8kH4K7j85SCPyuLipFUIVuhuFj144LfeGFJIgCF9CfrBaW+RXi0wiF/5zUcdGibVVqs1pDBKtkABw4zkuGKOqAwYXzLNsEEkrlDFCz2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525220; c=relaxed/simple;
	bh=U5+Dtyj92Cp1mydLvL6zeGoWBbG9j1QClVDIT7+nrzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEEzH1sl1FhFftuDgALMUtwZ3+YkhA1L0HzPI8NX3kyi460QUYeKXzjhSFUeL7hTqd2O7EY12DlY6TuS11sdXXQtuuzovIPPzfsX232iO0nqfFJubgzuV9fwul/RfdEMyHqEu5oAji2yXU3A2CFU0yRb8Lr3/d4Ev6k0oAYL7k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EPU1YMKt; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EPU1YMKt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5178a42caa3so34016871cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 05:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781525218; cv=none;
        d=google.com; s=arc-20240605;
        b=fHEv0az8dt8hPBMwG4z0mYN1ZZvhCP3XBhbGYLaVXbsWndpxLJFfNmFj6kP3oPnn4y
         r6KXaFp1CZ/fuqf3bl/CsWeOjUMWZGrfMbxu9mRxTqnk6nkIuEKvc8oWFKtKMOEhiuni
         r1X49/UFDk8Sm12vC72sGioACFmkya8MdME+RFIznRvn2UJGvSQs+BCYCQJqJ64DrYjq
         04Q6+2dwhZy6dQQcaGAmfyq3PxmTnZfAQYCwyser37RuGOfYldPwBjOEjq1u1q+ug5bQ
         8VtPc227wuM3X3jeArVgAprkxRrETu0CwjTPHrgRWHAI/NnnDp+vICiCWMU3LFsXBDLw
         vaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5+Dtyj92Cp1mydLvL6zeGoWBbG9j1QClVDIT7+nrzY=;
        fh=IaikjEqKaokxLKygCEIzAjFwdGF95gT2zH3ax2A2mAA=;
        b=AiyikTpW0dn6XlsLWWlMEI+yMgx7rMtdEjBGTLNPDxuxN86/7AN2FuQEue6j4v+i3M
         YerN6FERsS0B3B8WH5nodXYu3QwjsjL40tMEde3hgti3zST3F7i1evoU++Ph18f6YNmK
         9tJcdOPoASyV1BVeNxasFoKmQ2BOEvgouDUjrOXv/59U00Y80jBzhpFKaba/WEGPB3Ej
         bKsF6SQOfRQBysS0lUbqMX71iacIZPFh2TBtmPlnZNVJ3isWUzhwsoLbeOBtLbW0gqOi
         g6sRRVKQ9KBIsQWc5l2Wpx+3HsWPGAwnruISDAlVaeqnnrb9bujv07txRZNYgiOhMJlN
         5vqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781525218; x=1782130018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5+Dtyj92Cp1mydLvL6zeGoWBbG9j1QClVDIT7+nrzY=;
        b=EPU1YMKtPg5j2gElRd5kdhbAKWtogKu8dZ/x32agNq8r0YM1AEoeWsWQRSZhp6H9WV
         i9KO/vPNNVrm07jzSKp5N20xQJsLe6I8PyXncPR1OZ+1FYWuTsbOXjeHatLn57ktUzO+
         Xf4AaB9mUebjPxRjC+93nnZ0wc1gTB1yUwsVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525218; x=1782130018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5+Dtyj92Cp1mydLvL6zeGoWBbG9j1QClVDIT7+nrzY=;
        b=jfO740YLhH/z9UuPRXQ7okFh6Co7ThjbqTgyBYx3uaH3gV4PtYDpBanJaWzQnPIXn3
         xGXtsEfwMeZtTHwqR+cUmLNIwTnyjzW2bveh0kyFmjHaRE9btSlXcV8o8d406L6IRDgs
         0Qxl6poYLVAug94bTUmcTH0dFoNMiGXdLkF9i/ydBBfgBIi12x7Xjb3GGHkbZc25rnCx
         p4abUE8q5K/A9rFaxpL2Sp0HPAS+PtdMydvq1t5gQ0I9UrArC6XsmaMfHwHt5W4YPFNI
         EExTqrYew6xLCc4QuKA9cPAEOUZ3hARZxc34dgoab1rt6uDRssYoniDsXoBcAMD5nPnL
         yzMA==
X-Forwarded-Encrypted: i=1; AFNElJ8bxcZWBEakeTpq2VAnC/ys6hmPLMlb9L+CP9VMm/zid0L6N01oPmh7MFuXUb2L5JxQyvIRiQIobBaWo4IZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNJL5dqpeOX8I3vVGBHNU2o3tmxLz1garJOs1/W+IDEYKV8qP
	2YlYiHxmu5Hypsw/xO+Pmg1PLuDWfClhejOREKlYvxlPI5jr7fnIk9dqDA+Sp/fIIhNeVXZB30F
	GejsNVsa7QMg6sUlTwcrGjvHEhJb1Z0WpIuRNGi+Ghw==
X-Gm-Gg: Acq92OERUiNLKbZx7pOPNUD0+bkcBSnSWxI9Yff6M3ogL0vAT2EFbOxduYoJuvxwJqG
	d8hOnzaub7gulcn9t7N/JErHqo+hjfrB7tkfLBWiRxqAE8GdoC7uNFPt5OYdjUdtqCuCGPF0MDM
	zuNVDX5UgRWA8b684mVki/khLOZCQZmdoJy2GYtddMwcgEwCUk88r136+PRliNnxp6b7X7ggIwd
	LDh49Ngr4Ey0afSrBVvcJaGdCw18v5qvytlBI+TGgPTlhkiA+hIO0YZIvvlGOzZqGGXX81sGQa2
	YW17HnzACzIKK44ozE1POAZCIl/QB18K3f9qiHES
X-Received: by 2002:a05:622a:4087:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-517fbe63f9fmr172980451cf.22.1781525217657; Mon, 15 Jun 2026
 05:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514124102.2703313-1-chengzhihao1@huawei.com>
 <20260515210719.GD9568@frogsfrogsfrogs> <953d1dc7-f1a4-88a8-1db4-0902b902055f@huawei.com>
 <da9772f5-d20c-0efe-2fb8-74f14e8d490b@huawei.com>
In-Reply-To: <da9772f5-d20c-0efe-2fb8-74f14e8d490b@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Jun 2026 14:06:46 +0200
X-Gm-Features: AVVi8Cf46ToXFLUljrVLT-E9tsS9hq2SQ-TDV4c09SjHVvSVJt0bE74a-szir4A
Message-ID: <CAJfpegv0SYbE_TB7Xy24VWDFSvghHexwzxLJ-SyNQ7BXky4hLw@mail.gmail.com>
Subject: Re: [PATCH] fuse: virtiofs: fix illegal inode address access in fuse_release_end
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 at 13:08, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> =E5=9C=A8 2026/5/16 11:20, Zhihao Cheng =E5=86=99=E9=81=93:
> > =E5=9C=A8 2026/5/16 5:07, Darrick J. Wong =E5=86=99=E9=81=93:
> >> [add fuse-devel]
> >>
>
> friendly ping

This is fixed in fuse.git#for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=
=3Dfor-next&id=3D19e8d6bd9ec35db2221e84bfeb1862ab6688a4bc

I added your Reported-by.

Thanks,
Miklos
