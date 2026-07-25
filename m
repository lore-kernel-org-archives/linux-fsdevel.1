Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB71C84AB
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784952936; cv=pass; b=Yngle+jZnZa9yxSnZdjZ3rDRWunsJcFAut7mQa+Oq8GO4urwdMOYx5UYXLChfteW8LsEBFEOOZxxoRyJvmxQlM+/7zTsTtTZ4+pCQPZqk916os5bP05WBfFH6iKiFDpNNpxM+H0KigHFgm2QXnmhPN6cl3G25GFB/QvtdClaKec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784952936; c=relaxed/simple;
	bh=PzCFk4xbsY3MKeojRX/yYHw+xRC2LcniEsfPHyAmr2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIylKqQFcUhw/IGzH90KkPqJlB92PyDY3yRCkfE+rCsI4o1ujlkUPRFg3LGzopEkG67BLyEFCJom2CecLBz8PFAJ2PlfhQmqD40atlxL8Z2qiAGqEnHJHmek5TUkQqOqegSZsFVg9XcyImEjo2f2AURks53LXnAUJQS49WcFEM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK/fUSfQ; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK/fUSfQ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb9b427da2so1286711a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784952923; cv=none;
        d=google.com; s=arc-20260327;
        b=NAtcd/SPxEdViv/62vkdcmXFKAfY0j3Coy5Lva3EGXE40ir8gs93RbEfrjloI6HDr/
         JR4U8rjEb94Czi3nkiluJDBCIbuh57u9O9v9TnFdcLMqiT3FxjiPI/CvplFXbBTygwxC
         L1Sevstr1AaLbnyvVS0RSBM/pWXsMiaqyGThWe4wjkD8yfJXuYnFGT/120nqTzMEv3Kn
         /rOP7yTwmb4oE2jOCBubsrwNx4nejAVBKTKWVMtnXiwli26r3v0ji8/twf6Ta+l1OKve
         GaEgJqaKK2RS0VL4rsPS2dqgYXcpI7+KoU6tMLZeCUr4Mapuvg7sLMnZrt5R8Rm++y+L
         aSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PzCFk4xbsY3MKeojRX/yYHw+xRC2LcniEsfPHyAmr2w=;
        fh=Y9flX+QuMGtJXYylyuoLFP6mkKUi9MtV/krAWukZJnA=;
        b=B1QX9ELRoXeZLFrIbsITPA4iQEsDII74sojkB+kULTlDC1G0yI8LUVl6VYkKzqiFMU
         gfDjIMSxsnVngFyRey53F0hqW92g4xHFgtyx21XOF2IDDQE3F6eAeF5n9ToM47RkgQCz
         4nbQBqpI1E+en2qliEymLgyK4n2qb3FfeC0cXdU03NvTfYNpDt4YGgnA7qAuWW0zN0D8
         5gZlfXFbMrRd1SE9x8kzVNz+Qcg2P8mfbhnSXpfmRcmptX6iz5nqKVWFc6wnfKOuTEwk
         N833y4dfaAhKl7NJBgz6EzMDmDvdrZ8+F0Xl23jmt/Dpiru6k189OQwa8aNldfYgIWnB
         ScRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784952923; x=1785557723; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzCFk4xbsY3MKeojRX/yYHw+xRC2LcniEsfPHyAmr2w=;
        b=TK/fUSfQ9wnv+bkA3vQ4YfX5n8I4WhqBY/asT5AKBkCOd4VIu9jilAsnE7pnI+xLov
         1JM7UcnBjT6bki35E25/xfhlr3uQKifU8jt8AYL6sm07EcX3X0ttO2uMLza/Wg6o1qLY
         ivwys3ZZOF3JFI1Oy8kgJ0bX9qqXBvA5M0MKGw87rdnI4SPtEN1zUmecFfnaC9ovIWts
         sAxo6LTeoeFkWy3pib3NyBu6Ywm6LaEI/IooB93GAeD9bKylCLgWFO0xlw9QwTC75tSF
         qbKYzIXaNaV4JCd+YDMmhTAXDzzXv8FyqcH0VjMyoQCQTBo1OWJCZ17/FaJhTU0NBTkX
         MSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784952923; x=1785557723;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PzCFk4xbsY3MKeojRX/yYHw+xRC2LcniEsfPHyAmr2w=;
        b=Sds2tz3FHmAQu/jB1uq0Or2Ao87m3ebmt+U1iRxQbgFGFP/OwM19Pwzxr5+92PuPg7
         t0GB/elwfyz+/XBNNIkJ721PWJ3ERtMhm+ssJfXlWqGAX0fwJqfi+bMuiLhU+ZxGErwo
         kibTxwJfi5BeXJhBwqp4qXsY8KbfOI/6eYy+Y0XdwYF44tXpLXowemq2ADm1/KnPTL3X
         0eWmoiqJmMyBim+4Am32pCwom+NKpJ8Fq8JHXoLY99hNJjtgeE71gUuJBVmbIXnEjwai
         YjiWz0jazSx/mGwIq+Mt1pKnUDxB3WUdN93aweQUpMSePfgxnXZTv4zlftC2CZ+ekcAc
         MQfA==
X-Forwarded-Encrypted: i=1; AHgh+RoWMrDiaH/eCkYxUi4A5uymbDUz1lscjSE+gAW7H93Ue2M6wKTrYNOOEO8bkhp3EVPjWEhn0a2QbK8u3O3K@vger.kernel.org
X-Gm-Message-State: AOJu0YxTg/GiuQeSN5boM3fMAb3J112YLV9uj/0c8qwDmbjXNOIVSoPq
	se1XiZBCtdBUBB7ZXvnKPzh5+ONeqr6DAL3D/yn84PPWY55MlcArPTDM8jypyeWYlYxaSxdb5G4
	2Erxg+DA8ddgPMOV3e1GBoowtvdV2fo4=
X-Gm-Gg: AR+sD1247MU38MqTx5iEtzAG226WRY4pXQoj0CesCpc24YlOOEhBZ8vMWSk01unZJHH
	TrxS+B6fUuL/Ifv8GG0Ut9T5qrSgPJwrqGEeC2W5FjDixoi6/HHdYHWP7+IwHwRz165SZOQJ5aP
	MTNAqQq4mgIhsk/OpJ1Ygmnah8igmrrISmcKujZpW4GAxDw2m2XshTl5opjYp6//dmDTsg+Gvk0
	5xKEdDBeLCXJnN4222/Ld5E5m21kj3/FOA3fIyf2LFFEF9oHe0kJZCkP+DIg6T8NInIeTwW4Tbs
	2UVtzOjCgtz4tj1DS/RlKLAqdicak5ncJayWatoCEw4+VlFtxVxUFJ4RT9HKLg==
X-Received: by 2002:a9d:7ac7:0:b0:7e9:e288:5d45 with SMTP id
 46e09a7af769-7ee6c2012e9mr2468001a34.18.1784952923486; Fri, 24 Jul 2026
 21:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713084140.249515-1-vidhu.linux@gmail.com> <amIXogW-sKfOhuxO@daedalus>
In-Reply-To: <amIXogW-sKfOhuxO@daedalus>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Sat, 25 Jul 2026 09:45:12 +0530
X-Gm-Features: AUfX_mzFsWgUGldvlaqterMEytvI9E0k_JwQopj7dlGejEsO6Kb-qaXvx3qYaTg
Message-ID: <CAFqz8LJLZ4c3qT9LWrW8BMVknrMtiRhJzwqa7VLQuxOMkJJr=A@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/ntfs3: prevent positive E_NTFS_NONRESIDENT from
 reaching writeback error handling
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+57f9327d593d301ce2a2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 23, 2026 at 7:03 PM Jori Koolstra <jkoolstra@xs4all.nl> wrote:
>
> Should attr_data_write_resident() be returning positive values on error?
> If this is correct, and this is a matter of data corruption you can use
> EFSCORRUPTED (EIO may also be fine if this is what NTFS uses in other
> places).

Yes. attr_data_write_resident() intentionally returns the positive
internal status code E_NTFS_NONRESIDENT when it detects that the DATA
attribute has become non-resident. This is an ntfs3 specific
used internally to signal the transition rather than a standard errno.

The issue is that ntfs_writepages() propagates this internal status into
the generic writeback error handling without translating it first. The
MM writeback code expects either 0 or a negative errno, so the positive
value triggers the WARN_ON_ONCE(*error > 0).

I chose -EIO because this is not filesystem metadata corruption. The
race is between is_resident() and attr_make_nonresident(), leaving the
filesystem in a valid state but causing an internal status code to
escape outside ntfs3. I think EFSCORRUPTED would imply metadata
corruption, which didnt happen here.

Thanks,
Vidhu
