Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793439523;
	b=34nh9pwZRj32W2uqwBH3yVRn4XvRO55o7XmDhOu92uDCOtJtkX6Tewpu/goDCGl74nJ9
	 epfvewGFy37khliIFl9b6B38GkZc9SVTEQP+CIkJYOnp0c3iOx1tgbFjHNdPmK711Q3MR
	 fEotoQcqF4NaHu77d+mvNJTXfLDDdbLmYAisDu/l4D5I4rzXP5PqWhLwTk4Iwj8MvRUTr
	 NsdvSF3/SWPvCNdZhOlEa9OPqRbEsExX4GbQHYAWdp9cXTIHZR76AmJspNU392rJrCnZ9
	 I1SS8BGPJPytSpPtbnW/MhvJI7IVw2X+iY3mnv3LHoz5tDJBUxYPckIjgsq6y5AM2+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=buIMJ5khhlxZO/tz01EgvSDikePfA4MPtrLPE3r2Xoo=;
	b=jSFiedsCYjeAwP5vJXl7W9A+/rwUmDLDOQ4IZM7K3kN/rm0OvWqK6U5PdD1wFk2Tev69
	 KaAqI9b9HrjbLzu1Zl4vt9ItdHmhf+AVl+QoCNr8n7YgSHZ4WxqI6JktxVoeba9YQClso
	 Xl9a0FyaFM6n2zy4zvXI4VcV+jJidASSYV7U0xg1OO0hrp18mWJ1e6Bi+mlfQRHYVSOmQ
	 ZgTOl1ARcU0FhLqlaRCSLfRfXpZ65Nr3ZXby02JwbyyxNJ+20F2BIWOAtY6vxpaa7LB9G
	 S8t+F97flUbrK5OR1Bqe2os2gql2ruUxLyYq5KcangGvVJK3F0rflnAM7O+UkwG/ecw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+ZroPjE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395D606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 09:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6395D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+ZroPjE
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-545a4fb8d5dso758503b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 02:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439522; cv=none;
        d=google.com; s=arc-20260327;
        b=l1OniK84cXemRGoyokqLHoDT4YCx1Dy5i7Zf4gCZtiLlrvBw8hYeD0KlZHurkaAmHx
         Mm2rUYj77sOoSQqZE5GPU1Gh/fwF3EjiRldrZRmXmNA6fwJ7P9yiR6zHoYebeIsuR98p
         VwiVe7PQtdUKJGTH5k95OSgH0vU8B8q2iJJik5pQEd8sdajTf1Xz+peaPKWgX311P2FE
         xUe59PKMBvdC15TcDUZhI62wQVm432dbSt087WIpUM2naDkMxPmeKZ5O730M3Fg9DkTq
         3LHrSlpYkIoP09QxXaQMgVNG6qGtjGDKku/8kkIu2o/s6MpK0Fb1pwXtgki7h9QIgQP0
         VtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=buIMJ5khhlxZO/tz01EgvSDikePfA4MPtrLPE3r2Xoo=;
        fh=xBKRRcZjWsbijC4ke4JbboYQKBqwdf5RDK/r2qe/FEw=;
        b=l4W1Paf9mCyerh0NfOKCH5grQDLiNH78o/biWy+qLfdcOTSa2bzSYvvllGxy3EfxW/
         TTN793cgGuCBThnDXnJTd27AHsOo7TPQ8nrjtRczfYaGpP/KeEOheyPHDSpKJIJJmzoQ
         1flxEsxvEKkNhZB3x3aB6E4BAEegmx5uoXv5p9KdnlupWKkU++Apay35qlqAxN6xJ6mx
         T5pqJ6INKGsuFvqtodt383l96lH4TQVBQq4UcFhE/d9tkN6eqjNJ9E0pRWkmgvrnBd6y
         NcJJtWYCwmGMGk0cjr0ubmwy0XKAEmOIOmmcYvIF1ehPdqAGkPCa5JDX1Du6fBDVR5e0
         8hJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793439522; x=1794044322; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buIMJ5khhlxZO/tz01EgvSDikePfA4MPtrLPE3r2Xoo=;
        b=z+ZroPjEl0WIHHyNp/2mV+NdrASbrbEojkNmcD0pev+mSvG5dpobdz5jVABf/kXpzh
         qcKagIaWRxcVlV5UnTxhzrwTPZFIX8LB8iLhsZZRMOc7knbJDvin9J8qo1RgqvMwbZaG
         6Kd5H2Htnyoi+XuthFrx6PyNrF/lx53XIen07z20W8zjMtZ8tV0FW2qPxcltgcKvd1OG
         F1vX29rS2ryolmTlna6BlvwtCtWkR5xKNbzYTmHhRlGPwe2sFMLXwkr2LpMCkosxrlyf
         7nQ0m0INErtSIEFJ7zSKGFgyb89XIZxegwPqTkVZB53/iNvwOJweNyG7Rs98uRn54rZa
         Fsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793439522; x=1794044322;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=buIMJ5khhlxZO/tz01EgvSDikePfA4MPtrLPE3r2Xoo=;
        b=04rzrYtyvCTMKNK66QJ03t/K07Q2kC2Mx04egfgDPBxNNs9+ubnyYjBHzlVg8h9vXz
         cV1644LFi5xQG1RNUSEUCSgFE3hUTqRcjloXkLqfrCI06tzj/iiKkZ7ool3/KZtX4oLU
         +E1V6zJ5cUiJkLZX+aKJD5gMlk/cUA0u0rFjowKSe8AAbT0cLp03euowkLZcJF2wWcQJ
         4J4/MHFCW5i1mRMt5HRKuvIcthofaBPtlBGaueuVb49Rn048Qoplw0kFjFRgzZ7kh78F
         GvfKjnyNk1BerGOxSgY/iapS7XsgKdwAoqEHNALY4UGa7hFbCOskDzmg7X+n3wFN8utD
         X+PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwj5PezHoFndaoivEhIGLr3vHImPK8SeDXQ211+I9OItY0mGVyrqcxzDa7p6CjBh7EbJtoCJ7Zfv3SAR4mm@vger.kernel.org
X-Gm-Message-State: AFq9FYInChpNzdWP4Y8k3pEV/2ud4VZmLD9BRvWbhV8Pn5U1l22g6rhS
	QbpoYQ0t60WLw9EpornxaivFMwZ1yFkhuAZ7f2gTpC97HtK2fAi/I0wSmAhmOWbTgfjLeQI9PG5
	K55YA1JacsQZGEFz7Por917KX/DRhNYE=
X-Gm-Gg: AYBFou1NX0IWMCcSpfnEGr2WBCOsp66QPxs3jZGnuD6doabiOw+ZTkNAiXRhZPJQowp
	Rfa9NhgdUhh4+LPwAF7v+5RVPnF9ipzKNnejE/1J57QgQ8oWy7uS0cod5mUDaHx3wXxc+wosMIq
	ZYYiHoR4nXJZgTANom9ailtoVtPKvAg6YpyGyZIGJd2ZIO6PnidP5jv4l+t0WuLFpjoWyFlO35I
	YnF23idew0e5fHBHSeX9F+zzre5epdJcp9TCbbLZm5Tu0oRSjOmfCa3bDAeyjQMuLduaP5A8+kI
	UCkgwIRlBCXJNxBxkpuFIhD0u+pVVL9OoZdu+0Pu6fY5hEdHq34DA3VJO4MZhJfaWMFu8aKCH2U
	mHbH6Fw5vKd1rmpj3Qc6uSzOemsc3jk7n+eVXaCd9Lzmu1CERSYm2gBbadvmHgjemPxnTtqQ=
X-Received: by 2002:a05:6808:2e44:b0:4f7:d324:bc36 with SMTP id
 5614622812f47-5640decbf43mr2997896b6e.43.1793439522296; Sat, 31 Oct 2026
 02:38:42 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030113201.2921633-1-amir73il@gmail.com> <CAGEkeHekpqv5ncd8tFP2v-OAy-ujTf9_RBbed3dgmTTAQrsPzA@mail.gmail.com>
In-Reply-To: <CAGEkeHekpqv5ncd8tFP2v-OAy-ujTf9_RBbed3dgmTTAQrsPzA@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Sat, 31 Oct 2026 02:38:31 -0700
X-Gm-Features: AclHuK-X6GKlHTisqtiHyK9eKC4cZ99r0QQanZe3vnYDJQb2Sgwxn-ctseguvNY
Message-ID: <CAGEkeHeBcz2Atc7zz6u-Evd40+AOBtx9Ke+REthvTppxw-vpRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Overlayfs casefold fixes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Amir,

I've posted two tests to fstests, with you Cc'd:
https://lore.kernel.org/r/20261031091948.18985-1-dennylin0707@gmail.com

On arm64/QEMU with ext4 and tmpfs, both tests fail on ovl-fixes
(1d27da7de3f7) and pass with the series applied.

For patch 1, changing the empty upper root's casefold flag between
layer setup and FSCONFIG_CMD_CREATE triggers the WARN on the
baseline. With the series, CREATE fails with EINVAL without the
WARN. I tested both directions on ext4 and tmpfs.

I haven't run the full quick group on overlayfs. Feedback on the
test coverage and structure would be appreciated.

Thanks,
Hungyu
