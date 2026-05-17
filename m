Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC717148850
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981674; cv=none; b=H1KkuIQYl30xasQZytyMh1Jqi8w+hoENQDeUODJ2n0KwAYa8Qlc2jqT/tg0CcgWhAPXN0eo0hc4sZOtHISh7tRtyOEcWqf4qiWMx+wZgRR4BKI1+PQ7foKud1QAy8njZ4g5KxJ0b4AspXdlmUyTNhD58hYPdZTn7koXnRhIHSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981674; c=relaxed/simple;
	bh=oIYijt7rG+B52nlKNQ8yZGkeZCCHuLQt3VVqRXkZ9cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtmfItvGtQhOfq3X+9CU4o5cGgvsHowHboff8eRs6zqhZIvGnJFobkeiDNfsfzCqTiW8k/QN3hFfk+fhTLBrozVi5wwaqBWErci7hbz3xWpRsEdaNG+DnSVS9uURTSVcHmTPg/iWOhlz7XMpSZNw95LON2MuFDiYq4OUVI+QkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbXEIp4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbXEIp4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F6C2BCB7
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778981674;
	bh=oIYijt7rG+B52nlKNQ8yZGkeZCCHuLQt3VVqRXkZ9cU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mbXEIp4wP3CPZ0gdcZydYcIyVf1/cxNQ6RfnMywTGImfnkJGlSukmcfSsKclT3GMR
	 DsruFhn3CVwdhCsgXQkA+7KqS9LGi4x/TRZIitK2mnirF374G44WQuIJn33LbmaPfL
	 8NxuGR/ClRLu4gmWiJAaTefAJERbf0OPdLzvJcYxyLsaMOKOp3LunK7WHfvVjUCacK
	 /O/rQ/MaVaqNmuDXrDUnlCYnjn0IG+ZCsgPyfzEcCeAk7d/Jq6bBrPtHSfVBcRR5aC
	 KmJjDfLDV/9NCGTpq1uw88ZuK7fw0hbv8WFGZpQW+IHHszkWB64VuIYIVAOpm8lqI3
	 iDLWBV9rw+shw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso3103533a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 18:34:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTdgNi1g332QOQP+JF1ZYy8FBiWy9S4wXGx/45Z6lS98DU0omy
	6RmIGD+yBB4q26lGQMraP15/906LZZ1KExvtAQq9r+19d2/ziNzO6seE5RVzmF6lqFur0vzQRxP
	2L5VEsgwy4+Sf1ETOXYeDdwcI+/i01xk=
X-Received: by 2002:a05:6402:1357:b0:680:ccda:55bf with SMTP id
 4fb4d7f45d1cf-683bd095c51mr3025065a12.16.1778981673182; Sat, 16 May 2026
 18:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com>
In-Reply-To: <CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 17 May 2026 10:34:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
X-Gm-Features: AVHnY4Jqpafql9sdTwy8eERYvQfMRAz4m2Wk0X6tQy4xpXsCxmTJ3mJS_SOZZdM
Message-ID: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
Subject: Re: [BUG] exfat: rename/move destroys unrecognized benign secondary entries
To: Rochan Avlur <rochan.avlur@skydio.com>
Cc: linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"

> Root cause commit:
>   8258ef28001a ("exfat: handle unreconized benign secondary entries")
>
> I have a fix and can send a patch.
Please send the patch to the list.
Thanks!
