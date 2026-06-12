Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BA3EA96F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271565; cv=none; b=oS6Efmb5lShcwWOFmipI85e/ysMY04JPJX4Hus1e7HEjC2/0pkfpgseyx5TKEFo1V1K4I/Xb/MUEcR5lx0a/4hqlpvcVHtWMrMD8MjuIwbXCKX6tfJh2PURdIXZCqyHGLam8B0tW97bzyJwH0GEhI3D9guJ393iuRm7U8U8Tc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271565; c=relaxed/simple;
	bh=dh+h/5J2SE2oP/JA1SnZ75CWesM4j1izxsscwgY/lDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItNWVsg0ADFxfcjXKlxGOVmFKv4uM0KXEANSdfOUpqvOHjV6AGvgkzw4//L/Y6t9Bz9LlMdtnq9vCGDr9s/PoeEux5KEA5K88VwQ2NuNN6041MYoDpm6Fp6hYrkLHtwmosp8E7JiSXwJ6f/VafwV8hFPT1DzdUsIVr5OpGl+TJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyoCbpVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyoCbpVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B261F00A3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271563;
	bh=K3HAYNESaaxBzMOA/ka6s4SDMEiKvvbRh45PU1XRkyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SyoCbpVy/JjuNapqp7PgtcsKYbbBs5KucamwKCVZBeDtva9qFsmBcu1GsskNqMz5+
	 gHYNC+m8Fyn6Bz2EU08Yjy3VJtVvPDp/sCFq0pFDpWqf4KnTDm8yo9a11+rWE0WSf4
	 Vnhctm1qsQN8Ch0A4Phl8PeaHGYwACnvtTK/RZWrTRt0JRhnsXeG89F3pe1fpUaCVR
	 UzVChyMcy5nkCFViI4J8vz46fCk1FUMHNw3HhoxBBdRdpjnZBjTqmrknJqeUnLmxIT
	 RZlovV323Dry+vdvDjyAnxpEFfYDWM7uAceXF72wiSoJgxso+J9rMMSyfkUdrfgdin
	 wLmjKP/VB5d3w==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dee6b76a73so9993847b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 06:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+AKFlc4M/ddjG6pDJVMNRSbNWh7Hpvcia+JdqAd75TSW6vdzqMfOLZWjzM2SkQGAH4Pr72kMl0aQI8HJ0r@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyxLXhvOYO9pyGSgwyRlxQVszCrJWopoza41Y4y7ukEXEPksS
	VBgMY8jCCgR/4t5L66e9O/6GiL/U84XAl9fvNrjRfoWqlQf7QHhtwD2Lb2AyahvZ3z0HuGIldrU
	oA2h46kCIqQhXA9reN2VWVZXaSlcUJ1I=
X-Received: by 2002:a05:690c:62c4:b0:7da:150a:18b6 with SMTP id
 00721157ae682-7f7b6345a51mr25151727b3.16.1781271563163; Fri, 12 Jun 2026
 06:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610135511.203041-1-anmuxixixi@gmail.com>
In-Reply-To: <20260610135511.203041-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Jun 2026 22:39:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ajKbH1xonEKdRTAg=MHS81qRp6v1B_0A8R=0Uet38Zw@mail.gmail.com>
X-Gm-Features: AVVi8CdyiCpUZDu6B_srkyUfJKvZD5VAsH4vP63nlzIFiaU-taJpbJ7Z5qHKKTo
Message-ID: <CAKYAXd8ajKbH1xonEKdRTAg=MHS81qRp6v1B_0A8R=0Uet38Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] preserve the next empty-entry hint after allocation
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       ret = exfat_cache_next_empty_entry(sb, ei, &prev_hint_femp, dentry,
> +                       num_entries);
The empty-entry hint is only an optimization, so failure to advance
the hint should not make file creation fail with -EIO.
Could you make exfat_cache_next_empty_entry() return void and simply
skip caching the hint if exfat_chain_advance() fails?

> +       if (ret) {
> +               exfat_put_dentry_set(es, false);
> +               return ret;
> +       }
> +
>         p_dir->dir = exfat_sector_to_cluster(sbi, es->bh[0]->b_blocknr);
>         p_dir->size -= dentry / sbi->dentries_per_clu;
>
> --
> 2.34.1
>
