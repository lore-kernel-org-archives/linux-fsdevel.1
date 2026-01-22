Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C85346AC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082770; cv=none; b=mOiFb3ruH5qVjetAElfXG/e8I6DwSA4YcAmAYhU7d5VHbKZ4gGj2iaf51wdViSWXWhxBsYeD7GboCWN2qL5BpHwOG61OjFEa1PInks5gwe55B2ehF5k0MApPXmlgywZrxgfWDtqAocxjOk9Osd0du7F3OvPu8Sauk9x4q/0NXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082770; c=relaxed/simple;
	bh=QW5GUjCn3hN08/OBQ1ZdE8ryQywoHVRE+EfMqHC0LRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORAGHhthtlZvUqG7sF2RvWr051CWNEYY9fX8JcmvCaQl8Q1jXyq2LeBTxamoTveH7jEuzR9gRtQpb+aAoNXwlZ27spPKoZcXNFy8kx20aZJIqFlJFdg7HGsAKHIbbEpldh437FbRw5GidOj494IxDoV1GDe/bWTC/ZGOt71zUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+IUwdvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+IUwdvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3514C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769082769;
	bh=QW5GUjCn3hN08/OBQ1ZdE8ryQywoHVRE+EfMqHC0LRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+IUwdvrbPv1Lbz/LHZS6h9th+g1vDGOdGxL8p6VvN4uAkPnJAxMFMWC2Xw/Ofxqs
	 XCfm7I6giVNJTM+sCUjgwWHjVfKp6ad3ajitspAdpVmi08K9P85t0sAG36XxrbzNFQ
	 LYBurURZW7bxXTZPss7OOIs3J+HFcfZ9R4Fvt/aaA/PzL+0kGsFGcDF9OG+gB0PKsr
	 B5h2oaAqvVgTuoZ9MvgeI/15UtW52W2YEG2mbRXZJG5CrtTC84Ul2G/F+++ZvWgocW
	 d8RIKQDf7M3WSjnNkOBrtz3KvzuZnqQXBzQ8CdVDenANv0u2nR255dYzf1tUge+obN
	 GQrTXnrrML34A==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8718187eb6so125397166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 03:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVspfF+Sk4nK0RDA3eYIoINdjzGuDP+TRu/8TnHG0PW86G4gjixA3HDjShZJW4eo1Fut2vtAHOtUbxSIwg@vger.kernel.org
X-Gm-Message-State: AOJu0YypPe+caNoHf+NUky5i5Q/O65LUp0CpNWcwhMWq0BtMmdvbCNw0
	h0+fPs6Jc4XRCMROCHToytCD59qe7zg9lJ3gRNhBBZQjzRLfyIMj+AGO4iT7DS+CQ1rNOiDMF0V
	+l6bQ9SXemB+GIDtXpnPuSZXZbIbCFzw=
X-Received: by 2002:a17:907:1c20:b0:b87:1d30:7ee with SMTP id
 a640c23a62f3a-b8793245526mr1901571466b.32.1769082768298; Thu, 22 Jan 2026
 03:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122000451.160907-1-william.hansen.baird@gmail.com> <20260122000451.160907-2-william.hansen.baird@gmail.com>
In-Reply-To: <20260122000451.160907-2-william.hansen.baird@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 20:52:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8LPeh7g_yUe4FMWXB3sezJRQWx_q+29rA6TgvR_TV+pQ@mail.gmail.com>
X-Gm-Features: AZwV_QiRxzl807UqpOSr3zjEGHUciT4lkipFSMgUWdP2FN7O3PxCDdEwr9wJHo0
Message-ID: <CAKYAXd8LPeh7g_yUe4FMWXB3sezJRQWx_q+29rA6TgvR_TV+pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] exfat: add blank line after declarations
To: William Hansen-Baird <william.hansen.baird@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:05=E2=80=AFAM William Hansen-Baird
<william.hansen.baird@gmail.com> wrote:
>
> Add a blank line after variable declarations in fatent.c and file.c.
> This improves readability and makes code style more consistent
> across the exfat subsystem.
>
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Applied it to #dev.
Thanks!
