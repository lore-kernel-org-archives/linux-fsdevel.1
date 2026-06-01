Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928B1A6831
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288669; cv=none; b=cd2H1HjhVneYKA/GXFSkzUvuzvLid9W9BxVZlCci04Fg9mgVrVAzihMXkOdLBDZm3psUkvQ24zWwwNLbY15HyAl8pbqWIVYPnfsnrtD9SruzqQM3wFbXMCF/bnpfCv2A0IwLhb8593clSgCIs8cj3+fkgKIz1U2bf/8/39GLFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288669; c=relaxed/simple;
	bh=tf45mNGVC1N2gBWGAiHRL1ouyZ/J+BOESiySq4bZYTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcfGhDf/MAkj70T1rVn0wuPKmFSJ1FHyDnMTtMO6O2OccK3dZPu5YXQt9NgiWJx1lLlRLmgCLWC/4BabrGzvKb538midmh/rmkJ7c8N5PRdQcxdMyIMmZ9zlj9VJBRz27Qfj1E7seyirimxKQl3GKL+lMsd+7HGqmtt/YO18fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTiPFCCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTiPFCCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45EB1F00898
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 04:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780288666;
	bh=tf45mNGVC1N2gBWGAiHRL1ouyZ/J+BOESiySq4bZYTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iTiPFCCZw2derFZvthRL/leww8H1F6PHLg9htN6N9aR3Nn7JEhKC64JH1Ao6fAAcC
	 njQxcLWaKDADQWtCR1m0LI63JYtRrKN2VrmVs0HWcHEMREH6fCcJ+lKoa0cQWKJLUG
	 ucZC1akEkzSTsyuG8jlbwvtrJke+ZofT95KU+Dc6rGebGpgJ6iQu8dNlCQgeuDgCdc
	 kISAwDVsQe0NoNheZBuQpfUV/OSvTALc2bhfOP76HFHW9OW8+McTMiPCvCp3cRuAi0
	 0AsrQQmWCAjfpVqbNn57rdVmb8fx5fRsus4dR+DCFH4n1yHuiH/9Bo+DGNnbjkKgnW
	 SZw0HbooOiBUg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bdb3fd39045so1482344266b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 21:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/M4ZKKmibXT8CW4xr3VUfWGmAeJrRVVv9LOuGkabQjUmoIGw+w66x9a89qXrB2VXljwGM3AXZPhgyQhqZs@vger.kernel.org
X-Gm-Message-State: AOJu0YxJroYuxsfyRVXaKSg/SNGJ4M5dQPpE448cazqQcZkQ5WEAZPX2
	XsroNwa3AxgdfeygmFpIpQ0GVgfCku98eYLbaFdxTIRmgUJw9NoeQkWKaUazcfEQWyrTZxbDfSH
	2boaF2MI5906IIwyhjEOLpTmq+tNqegU=
X-Received: by 2002:a17:906:5a59:b0:bd3:7c7c:b817 with SMTP id
 a640c23a62f3a-beab4d25a9emr354675766b.1.1780288665490; Sun, 31 May 2026
 21:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com> <20260530143514.3083601-7-charsyam@gmail.com>
In-Reply-To: <20260530143514.3083601-7-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Jun 2026 13:37:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_-Y1Rx-sUd-2GWS+KBCkTi+DA0DtX9qaD3nT8payRbGg@mail.gmail.com>
X-Gm-Features: AVHnY4LKTBmT8TWSzmguYmGusgWCzY_SYfrmuRx6wt0Qi4gLvK9WPIylHKDigys
Message-ID: <CAKYAXd_-Y1Rx-sUd-2GWS+KBCkTi+DA0DtX9qaD3nT8payRbGg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ntfs: validate resident index root values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:35=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> Resident $INDEX_ROOT values carry index header fields that callers
> consume after lookup. Some callers already validate parts of the layout
> before walking entries, but those checks are scattered and do not cover
> all root header invariants, such as entries_offset alignment and lower
> bound, index_length, and allocated_size consistency.
>
> Now that ntfs_ir_truncate() updates index.allocated_size before
> shrinking the resident value, lookup-time validation can cover these
> header invariants without tripping over the driver shrink path.
>
> Add $INDEX_ROOT to the minimum resident value size table and validate the
> resident index header fields before returning the attribute from lookup.
> Require 8-byte aligned index header fields, a sane entries_offset, an
> index_length within allocated_size, allocated_size within the resident
> value, and enough entry space for at least an index entry header.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
When this patch is applied, the generic/013 test fails randomly. The
failure can be reproduced by running xfstests generic/013 multiple
times. Additionally, ntfsprogs-plus must be installed to run fsck
checks.
Thanks.
