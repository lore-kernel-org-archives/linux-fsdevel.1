Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F53FF8A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089674; cv=pass; b=XJZgOuFy2hT0by4cST5ztBy2QOTMfsfxIqI4mVS1kXXsrAAFCfsA2v4hMXJTQ3WuYsqk8GYDMG89KpH6pBhX4xYjmjdFamf6Qw8hjGxP8bRXyxZCBTrVTFXWQVO8hcDT45E7aTRlKFCqJILN3dEz5lXBYvimC2oTGN0+ltIbWUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089674; c=relaxed/simple;
	bh=8mXpNYNPgECtkzr8AGdyU4Fcoy173GBePp5Ov1p4bmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7BxmDV1Wdvbz45d7ZuacVO3mjdL6vIZ344AEBIT0UlYuELyI2afpSIJzlRCmcptQYm7oFrhIGkNhZLV0J3y35RIy+ZxDT4NfViJLuOMrrKkLYPg/rz0f3bO5WMbKz/KNLf+ub1w2WcL2svGhnCwTsF1IWsd4a7La9STSEfkM6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ACKOd3Ml; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ACKOd3Ml"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso91529576d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 04:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781089664; cv=none;
        d=google.com; s=arc-20240605;
        b=L4dn0AZ+o4CExCgMhrFrFnEt2bfzYhzxUbIwcQmBWWQLttqJTkVBYhF2E2uyOZkgHb
         Z4GylKXo3OG9lcax7ctd1rrNRtBKlAXarOu/k5gM6K5k2N31HyYNKcWTDbzURIMF5Hx4
         hIsW3uEUe2z73uvgtoFyX6b9ci/FWu8EPL3WTWSqqxTOJV3zskKfkMd2e2lCLUstn2ZL
         i0nVxsulRpt6uMCzbTMS91BzIK7PaxBA8NrMFbATDV1YOLtQorB8KpwPTbBhM55C/vG0
         hZn5jokrEQl334FRBm9nTmB/I+VvfKivox6A1KxDmAGaR5bYB8wAF8oXzg7zLUnsyqFX
         M5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FfooajCCb5qkkr/DDxFEIC/q5Pcqtx/WOj5PoiifL7s=;
        fh=4tkCQLoTJnYE6+NaFIa6b0zej+sPpsgUXFDsiWKB2NY=;
        b=XwKtnqHaHXILqgR5r0ri98TxjeavN38xjs1dblf2JKU7oxwsYWLuwmICxmiW/fCm/P
         U2uwSN9zE+4vObe6WDj7oa2Cdzhqa9GxJWz4fzYW9+rkcEguCH16OrxpjnuD5kigZ8Yp
         qOrXaPgIfdMJm9Y7OhIVlb2jDPmLvvp/9DzztfCOKhvxx5NWUhd4ScOvS6Hdjo7kyGH9
         Uwqfx23elShxQdD+pSLULvutxw4tlg8nf6Ybhy4940uEk/koSYQkqzVRRsNBF2I7W5jo
         xAN3tIWX8wJIYH7ZaNyMtjfnFMN6wQl0D5GQsoTwqiP+16DbVuxWw0XEZL5SWGreeyxc
         YHHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781089664; x=1781694464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FfooajCCb5qkkr/DDxFEIC/q5Pcqtx/WOj5PoiifL7s=;
        b=ACKOd3Mlf89XRqEx0UxaN+kUXEs+rByMZvAbSH9YmFT9Jkvt4bztmEOFWuITa1XySL
         tR8uH3/f9II6L4QRYECRktobP9AMaiKxLoDlRelg0mSwW3lueTFoEX5axdUw3jZKSNHp
         JA8dHeq17ITQaoxKyCrs3Ciga9DLNnhi/pvF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089664; x=1781694464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfooajCCb5qkkr/DDxFEIC/q5Pcqtx/WOj5PoiifL7s=;
        b=YXFzDoYeBi5/rjf5FxKr2sOyIc8q8gSQPe4NsDiKqhSeXjSM07L9KgGxPsLS1qwMgy
         x2h7r90bLPEgO7HKQai+spuHNi6AavScdwpGfAtXuz5PqOjp4KgOhgtjfj/SToW+0VDo
         +nM8j7nZvV8vSVGGYH9pZ129TORMtMVvq4HZhzQC45UOsTUYbBNhKc026C2dhCJVCscA
         RYXJzHdQNbMpzKNrEtchZZSBh3WGM9oqoKnvYqWiKxHOt2gn+6shfsERJWLSjl/l/oi0
         I0WI52ujwKo8C3CV3vHkSK7MD+x8779gPnzbevWsvfg6N/U+QhkU+yOVld4rc7W46ISy
         +yeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/L0N5jDZIugfHVY5Y91h0DCk/NAncID9qPhnaSIPtj1i5zQOzhq48w9UUOKdFqxLs/4tk3gMluOjlQSF2N@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcgb1EzVYswyEg4XnNMGIHd8BK5oDWNApSGyClAHjWP3ICbD3
	t2k9vK9WH8/twbjyEe36dU24LZ59E8g4qjpTPiZI3Q9H4z1gFXzDs7We3VbqjlF7jXaxw6H0WfX
	4Z/LdIfrz6Ixyc9snKmgHBK/GRItzdxHTG2jOJokm9g==
X-Gm-Gg: Acq92OHDMfn+s6nMaxWosX//wACLnBjCkBwyueaugUeU1Xt7XxQyhggbJagnuSsZfhT
	6bQcgtHwbpGgcWBJ4JirdOb5GUtSyVZd7ey2rRQM+LqnzXMPAxyRsRPqLUumKsDuLVtOOrIpezq
	oo9Rlp9iRL+lojM1Ij5B0KD8wZFVi2VyNTfaBWZzdlkClNqEBcNL1FnuHVP65rWODz2hjLDfC92
	1DFkBlGCIYs/QlslHh2zfsU6NBh0mD4pMEAdM/iKRztFnvr83Gly+7pjzYoBqMrmCcFRRRe3hf8
	BfLDNE5Jkb6LZzB6ov/+ePB6yrUTAd3OP2z4z+TGEv6EHzvDEYQ=
X-Received: by 2002:a05:622a:47ce:b0:514:5d67:7a30 with SMTP id
 d75a77b69052e-51795c74e62mr337766041cf.43.1781089664278; Wed, 10 Jun 2026
 04:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
 <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
 <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
 <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
 <178056619459.3392745.3091041855723132411@noble.neil.brown.name> <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
In-Reply-To: <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 13:07:33 +0200
X-Gm-Features: AVVi8CcPOrZk3LFY7g50zlOcX2XYfioeMe0IQAA6vK7TOfH2w2RnMqNOAT5Kh5Q
Message-ID: <CAJfpegt4mAXDFOr47XaYPgeN1LFm_BNC_8SX-2A8kHEztWdNHw@mail.gmail.com>
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 15:59, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Okay, so this is about making VFS more scalable?  Can't we just leave
> filesystem code alone in that case?

Unless there are strong objections I'm going to revert commit
cab012375122 ("fuse: fix conversion of fuse_reverse_inval_entry() to
start_removing()") and revert the fuse part of commit c9ba789dad15
("VFS: introduce start_creating_noperm() and
start_removing_noperm()").

Thanks,
Miklos
