Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB353D3CF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177594; cv=pass; b=pCK3YahkRgfJIyCF4Z4xlmBzbhiO8DufxVxbvOyuJAvIX81S/RT8KEKtx/jXyhO6yglS1LBYPJYxiD6VkhHsLRCGFRU8hEPm11TPPxdCP+RHSa1TKj5C/YYp3GzOPRKNhW2gGBew0RBGWevo3tBHXRAQ0dVsAQIZfwf/WO/Revg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177594; c=relaxed/simple;
	bh=gBCre1Um+if/uEhzyyBB14P0yHe7klLtMEk1Sen/6CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIFazpWsGDPOuccPK8xbCc2cxDZnDKV/2wgAlz97mKIZtWRRM4Wh59FPHaTKaiS6qiKgokarxNKqw6CTwFTucJTU1o357xTyVI6hunQ2bTiiHomDFRUO4tIZgv1zFSsZhH9WPoFDb0OQKwmOnnaJTcbE/enNSkKYWfhSdvMhvnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OsjZ7gCE; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OsjZ7gCE"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50babbce85fso60522971cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 07:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177592; cv=none;
        d=google.com; s=arc-20240605;
        b=blZmyX65s4m8fBwdAQGf488s93G2V3GtkBGumwetEzLeoUhauBrrHXj8tTRcaiE8lA
         0P3Z830R3vkwpVuFhZ/mxrlsN8L5PcSgnGzdDmhwn1QzVlg9wjTujeWnbAxA5JiT6H8r
         /cby2WJR6rLjEAEROAMlFom/dcNaru4SEV9Pj4dEnYpA2fKvHHVa1QFm2BI/icmCKwlU
         M9ilaaOklvOjaNHLLP0Fc73dZplcmjl9AjwzQjU7mF4pJ8gID2YaCfSFpLhotBd6lTP6
         Z2ojFRKgdXo4JR20gGfXKOTNc40BuE5Ddf0vuwtVWH9asK1CiByBQo+0zaalSP4vtNCh
         J5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4EcfSCmC+jBrLkjkvPNn/5Oowyd9l/0x1OUXzwYof+k=;
        fh=/Mb/ioVqMRBLQUzt7ozvXntQQRmdN09U0BasMOCuZds=;
        b=IjTo2SYie8yH3RyXDv0zKDYKTAKyWaWZueApGbvs4A4fwyMuXwT9aVcaDsjXpHhX7q
         Y06NgWpY/iANRdRhzSfJAqKFocJcf4VpFPPCycOE7C5dMMEUZeIC/yFuy0spY+OZQdmd
         C3jVgHZa52npM4ufgcYO+x/nzm2Wlut0Eps5u3Y0xdlQT8emmDB0VHehwghuy000q5lu
         WM+fDnueIVuVVzKwOrlG2hCs82X/F0UTbYxSbdpW9kJt3xXyEEmyiDzLFkiJFVVASz4S
         4oQhPl9KPk0Yc+VYlFcw1W6oXVVdCQaEq2WMEAhSD9ekfkEXMe5Rd1BZ7bqWz/s+3Ycm
         oNlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776177592; x=1776782392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4EcfSCmC+jBrLkjkvPNn/5Oowyd9l/0x1OUXzwYof+k=;
        b=OsjZ7gCEPdPvk1QOlqFPOxwUFFhPvimRCnYVtTpp/2bRy5bsV0mHkGMfFEI+/NFmJg
         6IZIatmpwrVzI7i7bBcyKHqJXgNlhJTuXXebZV7eIxFyc0opW6nRJ7lLpskqAGaCUXN2
         khbB8d2PBT8oNqwRZFGEfsyDSViUPIXCoRDxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177592; x=1776782392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EcfSCmC+jBrLkjkvPNn/5Oowyd9l/0x1OUXzwYof+k=;
        b=Sn2lE+3LSWGqeEOqnuNKFDJ9YO0ZKQ5NvlmArd6iKqpUCNAg/GzLIdR4aOjFHInUqQ
         aeBnhbmdSDTPNWPE5bafiTDAcPjNCbKZsgalm4cK6lwqgMc3uIoZov7vcUlggTeJSdfx
         zdklJAdG7ZvVrKOx4gsM3m0wGuFzMIGt2hB8vquVAMV6Z6Juakzgov68YUzq6SK29TLA
         1DswOhFWLy3m37h7tCPF9V44sTwqWfrhze4vuh6mMs6YoClNLFfgQVTjIsB+OWr3S/99
         TAvN0Ry1NecRylAnz+78PenZ4dSbsFPqnFQ4Dd5LZ2xWbOrIVcnzUQeiv+v0GyMoiFUP
         WtIQ==
X-Gm-Message-State: AOJu0YzpW72ajEuGtZw1HvFr5bSYbNWqMG4LKbWTb/RMHO6FMCX2Kjl1
	WM7gwytbG93EFwKVNYh2W4udEqKMIGRJzaLtfr7lHV1cxgKtTdzlfB3fo/Sl2/K7kdU0G4wRz2I
	FfLrGCB6bbZeWrLjcK0FrtSP1OXK0xGjPptF24K4DVg==
X-Gm-Gg: AeBDiev8VKz/SojGZRNoVPKxCkOoXVPKcTFqviXTSJdjoDzk4B2Sr0Lkc+CHQnr/R9v
	h4m2P1u8tdJKWg3MdTaxokOwGZc6KQF+wKxcgunO5mQGwtgwJrNpqARFeR9gYTuIgwPwedDsNN2
	5kieHPFV48pT3QwUsrI6oZxyPvuOxqeuS4Pu3tgxBy3IgkBtjTcltaMnfK+Z7I5DzKiqPxFotai
	obqwoNl/FfyzNi0Fcxk9Ti7WEVXtyWChBtxOdEfKfCSWeVRw4+2WFATyCG6xLLikX04J6Tgtga4
	acZBsNLoXxWoJ7+lF2yxw1MwSc/Ms6rBlsc9
X-Received: by 2002:a05:622a:2505:b0:50d:e2ea:7232 with SMTP id
 d75a77b69052e-50de2ea7996mr218430461cf.31.1776177591930; Tue, 14 Apr 2026
 07:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407005040.1929492-1-rdunlap@infradead.org>
In-Reply-To: <20260407005040.1929492-1-rdunlap@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 16:39:41 +0200
X-Gm-Features: AQROBzCMSkzJ76-j4C_O8wHJrhM_xTPXA6a9511QV3oQbPdGZUTdhtkR48l8A64
Message-ID: <CAJfpegtRFgW2z5PSrMM1YwdtR8=sNktkMOHWacB-FNoQ=2BOGw@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] fuse: {io-uring} drop kernel-doc notation for a comment
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Apr 2026 at 02:50, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use regular C comment syntax for a non-kernel-doc comment to avoid
> a kernel-doc warning:
>
> Warning: fs/fuse/dev_uring_i.h:104 This comment starts with '/**', but
>  isn't a kernel-doc comment.
>  * Describes if uring is for communication and holds alls the data needed
>
> Binary build output is the same before and after this change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: rebase and resend

Thanks, series applied.

Miklos
