Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0798194C98
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693761; cv=none; b=DKc/v3xbG+P6VanABjBGVVv9w/nn0NnfTic42m+kqiL/jpqN2Ek+QJzdT1iXJalei1Q5PLMIM5v1uBN85WeYNMPYuzdqBgXslim+bDyju5oeOcRmy3nhTYxan2GPfal8ucSuEljDpEOvxAbBT93pKUIat3IxpROvg67hzYDi6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693761; c=relaxed/simple;
	bh=onvyvMxJh7UKD/t36rqIrGcDEfy6BFwtyVraUGbLzC4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eOtbynE+qrpEWNK7JR5mWPc2GVhxdu5uamZ8CUPQ6FxMPAUHlVUh1MtiLIof0/PMtPWWcIYlbWJuApJZLe7z7I5ovrdN9k1Lfh72/aCxzX467MHD/YYTo94cStgNqFnfFmTHs9AiEdxGfK5bFAXqJytdhIdMhTR6gwIblXKA1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbtDwk/I; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbtDwk/I"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbd1458a77so257884a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775693759; x=1776298559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wnAEjEllCMkNmnU6SxzJLp3EKy3h7hXrnH8kOTYBGnw=;
        b=fbtDwk/IxNOpKEqIOrddrztrNq++y5ljLjWhFSGECECW1CPXYS9js5haAyXeLwSRAL
         lNddVB3ARVVbfK+qRcznAJ/3Wb9rB4KfQr+oRzcgNyNSgn3tbZzUtCmJvdBvSGqD/VNh
         wlVUGzo7FZ/VCALW4CrtIZeQCnT/WO0eFLJ3evGAkZn+1Np+K0wC4As79kZMYw0Pumxu
         Pf64mE/omFc2oZkQer7faPtCHsfxHNL762pdEcVtBh+Qc4DnBfgc02BKHeGZoQ0ClCPj
         09FDTp38YJpTbop7qol/jthD8XI+5PJ2+tRcwTLSAyX5wJj34rcYmB0MoWzqpHjyAgMT
         L+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775693759; x=1776298559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnAEjEllCMkNmnU6SxzJLp3EKy3h7hXrnH8kOTYBGnw=;
        b=NmBtbC2TpwmMGPJ2708CkK7koLZuUzcgMNQHfHfNZ37BX/zNdZtuwld50MuNzILa0j
         EQxLYcDoiJWIPyqMZtxEkhwL4eXGWJr9di2Eu9+8ATbKH94v4Ua4qLVaOkhUxCcXn9XX
         ShI3gMETEqkfx3sxc4vMUljHX3rSF1EF/TirV18rQJvxIvlnC8zio8kjmLSpe2rU+K5B
         qxnJLYnj3+bFAtGvOExQuGKE+fZJ3CNbnKm8eNaoktGj113Y7Is668Cf+LudZWOmY8P/
         RDo7KMBkSXcScpVPb7AusqmmdifXkQlQITq0+I4C1GE4ACwK/xlDc0ctz4PRSUugr60H
         NFLA==
X-Gm-Message-State: AOJu0YzP9NimPinKjJaaNwooaB+lX2ukqBMw1Dl59TNjl1avH/KEw8IJ
	4iWrBRRDO4wQbPLMsYpXb8U1i19CWG82wo9jpQIpfQPNN2LF+FEppkJqGuJL6dPy
X-Gm-Gg: AeBDievxNoNjkADiYO4Q5dfajMebDW507R2yf53NykO1J7VkI0j9xezC4fmouo6jFNQ
	m6A4hwSMwwa9UGV0bF3Y+sIubRTsdHDlWW86+dX6Cd547po/aXAwroB6u3wUR72b+BCNo2iDO/D
	PSWI3bSeAUuXUtqiv6wJmMjtjjNpA3K6mUm9s3oZd0X22Z9qknokq7Eli3dZGMbuo1TsFKwPaG3
	YE9uc142e+Q9M4JaWuoVJt4ZjJiX4u2xXWJY5ChftctI0mVP/xw5I7T9NvXtW+sdUMpa7Vwf1Ex
	na8YIGutmdjWFZXTKPPMvs3eJYAllc7fCRHbiJnwZ7+XKW/nhxBjpQFIARYsvUZRYAghMS9hUcN
	GxKLH+nfwqhnMm7/SonT+ucc88oMawr/9B7UbTfA3Nowl36JI/LyRVdDsrHrYVNUCFEjJAH51Zp
	8lavHH97phTnUblQX52EOxQGPmtqK2o0MDxxb0Bdmu9Fy3UXLgetIhoRBnxSvzuyOetfNToWT7+
	6HX1jJu
X-Received: by 2002:a05:6830:43a5:b0:7d7:b6f0:c609 with SMTP id 46e09a7af769-7dbb7289cfemr14631507a34.24.1775693758519;
        Wed, 08 Apr 2026 17:15:58 -0700 (PDT)
Received: from [192.168.50.127] (c-73-5-99-191.hsd1.la.comcast.net. [73.5.99.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fd409sm14997234a34.16.2026.04.08.17.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 17:15:57 -0700 (PDT)
From: Sean Smith <defendthedisabled@gmail.com>
X-Google-Original-From: Sean Smith <DefendTheDisabled@gmail.com>
Message-ID: <a0ee95fd-9366-4ddf-a5e8-bd8431c1738d@gmail.com>
Date: Wed, 8 Apr 2026 19:15:56 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] provenance_time (ptime): a new settable
 timestamp for cross-filesystem provenance
To: Theodore Tso <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, dsterba@suse.com, david@fromorbit.com,
 brauner@kernel.org, osandov@osandov.com, hirofumi@mail.parknet.co.jp,
 linkinjeon@kernel.org
References: <20260405225442.GA1763@macsyma-wired.lan>
 <20260407000558.417-1-DefendTheDisabled@gmail.com>
 <20260407233618.GB12536@macsyma-wired.lan>
 <92e61267-eb24-4f94-b9a1-e009b5e00d65@gmail.com>
 <20260408133324.GA18443@macsyma-wired.lan>
Content-Language: en-US
In-Reply-To: <20260408133324.GA18443@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/8/2026 08:33, Theodore Tso wrote:
> AI models which don't consider secord order effects (or used by people 
> who have different priorities than others) can result in...
> suboptimal results.>
> And this is why it's important why it's important to have humans in
> the loop instead of blindly trusting AI models.
> 
> I'd also suggest that you consider the value of patience.  Linux is 35
> years old as of this writing.  One of the reasons why Linux has stuck
> around this long is because we take the long view.  Sure, it might
> take longer to shift the ecosystem to use some new interface or new
> feature; but everyone will have to live with muddled interface
> semantics *forever*.


> MacOS doesn't have this Windows-style timestamp support, 
> and it hasn't stopped many users from switching from Windows 
> to MacOS.


I think this thread demonstrates the value of humans in the
loop. Despite my efforts to be careful, my earlier claim that
"Windows, macOS, and SMB have supported a settable creation
timestamp for decades — Linux is the outlier" was wrong. macOS
doesn't preserve date created on copy either. Windows is now
the outlier. Working with AI, it feels like drowning in
information which no single individual has the time or ability
to fully verify. Your years of experience caught what I and
agents did not.

From the sound of it, the issues with rename() will block an
upstream merge of a kernel-based ptime. I can maintain my
kernel patch on GitHub for those that want it. The file_attr
design work that came out of Darrick Wong's engagement was
productive and worth doing despite this outcome.

I see long-term value in our discussion. As agents become more
involved in projects, this LKML thread will establish ptime
as a solution to this specific problem. Someone migrating from
Windows to Linux who asks their agents how to preserve
date created are going to find this thread.

The tools I used to build my kernel patch didn't exist six
months ago. My AI harness is just as much a dependency, and
it didn't exist three months ago. My harness undergoes rapid
development and increases in capabilities, even without newer,
smarter models releasing every few months.

I think there's a real risk of a negative feedback loop. As
implementation costs drop, people who could contribute to
upstream will find it easier to build and maintain a custom
stack rather than try to get changes through a multi-year
review process. I think experienced developers need to lead
a shift in how contributions are reviewed and organized. I
think the key challenge for maintainers is figuring out how
to work with a new class of contributor, and direct them so
they work in a coordinated manner.

Thanks for taking the time to engage with me.

- Sean

