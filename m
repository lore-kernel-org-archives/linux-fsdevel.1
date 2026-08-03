Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3F3932F6
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761892; cv=pass; b=ZRe/qfvR2qAUf9gL85qGzoFTFJUJY5Ld4Zx+yqKsaOuXyUzpIvkHy4tQzM1JxTmPni7HN2KG6VyLD6fU79fu7W4OSh4rt2CJYF9ctAKz8NJRSDymI9TpGRwJ2lStegS9JS37/vjz+cZBtwQM7foguvJTJXXcyTwyywTfZIwz9Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761892; c=relaxed/simple;
	bh=FNY7Ce3oJGc1geg0IrHDEAX/u5vtJaHKFgdO1MGS8RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDcVuCMn/v/tPbMY785MMrX24NRwaWqt5DVQLvIu8O1ZszWSmWxDlImKLoe7Tny7vDdc4tWGTU8fWgelXBNZfYByHtHKnVb63RaKc7WGI3FdmB78jLPY2Ris+wZiysQMpZPXrE0etP1qlls6Nr4D8lKKvMQQ6pEk+5WBrw3J+Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXOOTXz5; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXOOTXz5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f36179dd5so46041307b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785761886; cv=none;
        d=google.com; s=arc-20260327;
        b=BusZTqg6OPoIuhyQCHbNQDLwoeGTrYWFymigEkirlUQNCxQF4tCHOWuPPPMn7+EjC4
         o5dYczExc6LvZobqvgXZro7YLEcwL407SmfMl2dmiyNrjwbDgLI3iOnsDxqto4I4yoKN
         tAYuPzecWFSAyR6zTWbQ3dl+xzzVHgCDpgW8+BPG/L7jyCyE74gFQlC+r7YMR+QNzaIW
         wedulgLBOqIaEQDqPKixog8Y6ssIOhiWCES6ipA5+8x5p/QCowhq+gyRkwkSoNYDY5dg
         PtZPXM1FeJoRYJVXBWQH0iGZCpmSihXSA2Aefzyx3ccz8VOWh2ua/mKvAy4PH2/iUObC
         2zwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FNY7Ce3oJGc1geg0IrHDEAX/u5vtJaHKFgdO1MGS8RU=;
        fh=DtysFAJa3AKwQA6sQ2ie988qw/+rZ8Y3/Z4nwVp8H/Q=;
        b=IxBhE/eE3t4ONRgAwq2PBI9rjP7cT3okFW6T2QkY4ayzhyhsOn1QCEi2WnZPJjt/pc
         GEcKTDzyFMAomaPXIDUEOwxnQm22ED2r9OePFiyWG6IbVMGSY/Tn+Ypx9oiQ5T96pbfS
         lpFqFwK2rwi1W5mho9EzaaeiNuEfPN4i4pfuPYMBlJv/Iaq+f2+8dOmNFa+bZ15OUMPj
         ADpS692Jiq66RlO0AK4osakFgl9AiXrQQbPuuV0PXjFI+zMn0GtmhoHStBnQk+x3dpcB
         maMI7PrBNjHfmjvO+toCRYKvwBFBiAocI4/mFpJNzNhMOtSiv7QTW9czXAZTGM3e+DjO
         3uXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761886; x=1786366686; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNY7Ce3oJGc1geg0IrHDEAX/u5vtJaHKFgdO1MGS8RU=;
        b=EXOOTXz5aBXGcIubIyc/we2MjqtgiWPoP/zgRtLlF44IHAFebAZXNsJ3R3yyPHxP2l
         /KeO4jcCkBj69Xor2c8f6XtGCcH+TWif5jgNhYh5tSpl9rAQv7stiZVt3J7qOeg50I7H
         zyZ2gbeuULWzocdsOodKmUvqAFbqvqEd3mXeKMWAwHR8AppN0Fyli01vLYIoG7qNbPtQ
         7FOuq3owL+e6NvCsGt6yymiSifRBslrXctyRRVeOB+33+2RC88KACgco9jOWpFmK4JYz
         ty4bSQwRymxK71QbZBXzzw0xoykgYkaBFKgvlMAaIFKqtbbrBAILYoUD2k6QfMeKj3oq
         nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761886; x=1786366686;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNY7Ce3oJGc1geg0IrHDEAX/u5vtJaHKFgdO1MGS8RU=;
        b=Sey+mWJASTe5pGBkMl2dy4Qj/NUHE/lbrEotrWZrCZrf1iAMdYBvHAKS2GPU4MO2xE
         GDnyGEnlpUzfGtcSYT7zebqSeXicWisO2iR/h9U86rYGYn6D8HlWMMGJ5rgEZ+LG1+hU
         YIcXRUrGf9GOyF4TzgOjO74P/b+y8uCNjtAeOqGVBqBAEaTBzzdFp8DfcUTTOMNXFG9o
         MbSWoCFoReox9L93+GOKHB7v8sdGDysviyQzbmAzBcla7RPb5qJy4uzQUiucbaIO6TVg
         6CHN5cA/2a3NzT5Rg0dgeMJ/HH834IgtMBJbZa9hbIpv9sOLCqnonRzTiMYp7aW5LIhz
         OkdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7IbDbiU6qc5reHHG3gczeX1LazLI8438LARFbC1x5vtDozwH5TTfhLS5EyHxODjYqacShc/tdWiNLZvRW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/ndnkG1KdwH5IhPxDvBwWweV3Bb20sAe33Me0ZMD6lOgO2Lu
	odBa0gxFF8SKumsOVSKDgfB+YnTK1b0UAiABBluRlOzFw4TlRZcKjDd/GhWkLXEc3VopXPk61hM
	wrA5dUJyk1YeGQOY6ovZLKfKFtwoLJtI=
X-Gm-Gg: AR+sD118y9jUZIbDb3ryOW3AxTJtkZZ8Xzw2HB0uCklQdZ41k+s++JRKZAph32lFl8y
	2sV5swlBysuYj1Dd6/8XUdX7f6eeJHRkz6zp0NhBi3MLiJaRHeSeidKNFluJ7gr2Xwen+dqoaoR
	uG1bQ4E1iRwGYsKLR140Eo4/h8SI1ZOh5zZk+P0BFpBp/z62xZVD30I3m8GDdPhnPVbvV1wplg0
	NUgYnReMQh+5EAIoToW0oTVkThhIt34REhK/fYP0VDqywIRSXA6+nXBOtCL0ZqYwnYEMzd6MLQA
	KgyDpW+Y19ay1ShSEirfIkUB0s3e/hulLOybRA0Cs98LGaGY/eKancuHiwWpYddo7gYg4GxYRR2
	7
X-Received: by 2002:a05:690c:368f:b0:81e:7dfa:b799 with SMTP id
 00721157ae682-81fd4bab2b6mr127193657b3.24.1785761886420; Mon, 03 Aug 2026
 05:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK+_RLmWU-GjYu9Z+AWnoKd__AiaWZUt=zOkx3jr2-a4Hv3KHg@mail.gmail.com>
 <am_gplyBEyvbuHM_@archie.me> <fmdp3k4efrv44yqjmukk47ifa3rxrjvj2ndfin5lu6c3x5b5lh@5vv2yblzxy7b>
In-Reply-To: <fmdp3k4efrv44yqjmukk47ifa3rxrjvj2ndfin5lu6c3x5b5lh@5vv2yblzxy7b>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Mon, 3 Aug 2026 13:57:55 +0100
X-Gm-Features: AUfX_mzj7188YY1Ej-krLaz5Tumhl2nXjtPLXZK8jysM9R3mbh5fOF21zeZkgPY
Message-ID: <CAK+_RLkvc3b0vC7SHygRv+4xdk_mC-362T60NbtQT4Zmpp6fxg@mail.gmail.com>
Subject: Re: ext4: spurious "orphan cleanup on readonly fs" due to remount,ro
 failing to reset orphan_file structures
To: Jan Kara <jack@suse.cz>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux ext4 <linux-ext4@vger.kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 3 Aug 2026 at 13:36, Jan Kara <jack@suse.cz> wrote:
> No need to, the behavior didn't change for a long time. In fact, any
> read-only mount with orphan_file feature enabled will result in the
> spurious "orphan cleanup on readonly fs" message. I've just checked that.
> It is only a cosmetic problem but nobody noticed so far.

You say it is a cosmetic problem, but here I somewhat disagree.
Logically, seeing "orphan cleanup on readonly fs" implies an unclean
shutdown that caused those orphans. Consequently, I spent time
debugging it by instrumenting scripts in
/usr/lib/systemd/system-shutdown/ and even suspecting the NVMe
controller caches, etc. Any sysadmin who doesn't like leaving
"mysteries" on their Linux host would have done the same.

Kind regards,
Tigran
