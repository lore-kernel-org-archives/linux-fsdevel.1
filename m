Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C24364E81
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303622; cv=none; b=pUcfdhVeygrpeuiEKSgR2ZyLyRPxF7g9puCuEtCK1jVu0DfaHfzxhn2Vv8LBWQT/nQ+zc0qCCkPbFcSbg7hlFYxm/QCOj4+zwl7RI+3iDKZyv3CztKOf7rcTdZuuHgQ6PzeMq6RABknhLLb0MwEMubtW1JVHU7PzJg3RbYZfhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303622; c=relaxed/simple;
	bh=+SlgoleeDtWEdyDxs7WBR/ZnUIxxS9gJz/TRF7FVtPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMYwOSXAH3xnDG9BMezrarwJtUAm0xO2G4ncyZ7YDnXZEEZs+S4CH+jNhRJl0B6ubYgbcJ3h3IOMEktFhaZa615AR7UgjPmPgQ/9007UQanIUns1c/K+jyLCdNSCqZLWJh7a8P/cAWF+OwIh9snvZaRQjXCYlu+PODNoqYo1n18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqXvKNQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqXvKNQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21901F0089C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303620;
	bh=+SlgoleeDtWEdyDxs7WBR/ZnUIxxS9gJz/TRF7FVtPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kqXvKNQwxWUC3X31X05/CR8gxLjoxU1TaUAIM3e810yqoRt1LI6KIEVeg/4D+MeVz
	 nYrxCPGbmeciqeinZ230vtFxTBEnzg9uBB4AkHYpLaqhc59x2yOxCkN98HmT9YnunH
	 izUA2yC0Rwxk4TwlMFZWJM0FDUfklxK1ZADQRYntkFIQWuJrRAWbBl1grdA1lTBkxm
	 ec74oIK1C18TYCghqQbXRKebBoMzEpgbjn+RwSD8r4gauwTJ6dE9hAt+wR7mFHlOoq
	 S7lXo8vVrlUmdzTfSVC/cOCmfT/9BA1AyMiVI2UdIhguCKGBUfGPF9Wwyt7754Xocr
	 kWtDihUrkxVpA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-beabc001b0bso255597566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 01:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8sWoQFEceVXra7uR5OdTl1WrhivQFrtvmyxKaOUOIp7Vt14nGaCRMwZzzmRSELaqoTed6ucH0wCkeCe71b@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIwmBySNKlW1Z3pZm0DiZSU5hqc2LRaKHf4M7AW4MSngH02pQ
	pVbc0+6/bMV2bp17Z8dxLW9WPVrT+28PYz2DZpQVJ10dKX3rWAUH7qnRCgqpV8baZqbbgLMP1nZ
	3vpESCJd2tXR2Ga4L9y7tZCMJpU/iZEg=
X-Received: by 2002:a17:907:7fab:b0:bee:4ddb:2628 with SMTP id
 a640c23a62f3a-bee4ddb3179mr43688766b.30.1780303619542; Mon, 01 Jun 2026
 01:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com> <20260530143514.3083601-7-charsyam@gmail.com>
 <CAKYAXd_-Y1Rx-sUd-2GWS+KBCkTi+DA0DtX9qaD3nT8payRbGg@mail.gmail.com> <CAMrLSE7T6ZyQZ4eutnek7irEWYDeg4im+tvSxWuEHWDgaseK4A@mail.gmail.com>
In-Reply-To: <CAMrLSE7T6ZyQZ4eutnek7irEWYDeg4im+tvSxWuEHWDgaseK4A@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Jun 2026 17:46:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ZABgPfUH+JhWEy47Nx92mMZ153ZQKeBenZ9AsYBt4Cg@mail.gmail.com>
X-Gm-Features: AVHnY4L7h8iIOtEXfvWIJkF74sF30msrRHF6h8YB9oJsv8aD47vs51td3gGuAuI
Message-ID: <CAKYAXd-ZABgPfUH+JhWEy47Nx92mMZ153ZQKeBenZ9AsYBt4Cg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ntfs: validate resident index root values on lookup
To: CharSyam <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:51=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote:
>
> Hi, Namjae.
> I will check it soon. Do you mean 6/6 patch or all of them?
It seems that the generic/013 failure started happening after applying
the 6th patch.
Thanks!
>
> Thanks.
> DaeMyung.
>
> 2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:37, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Sat, May 30, 2026 at 11:35=E2=80=AFPM DaeMyung Kang <charsyam@gmail.=
com> wrote:
> > >
> > > Resident $INDEX_ROOT values carry index header fields that callers
> > > consume after lookup. Some callers already validate parts of the layo=
ut
> > > before walking entries, but those checks are scattered and do not cov=
er
> > > all root header invariants, such as entries_offset alignment and lowe=
r
> > > bound, index_length, and allocated_size consistency.
> > >
> > > Now that ntfs_ir_truncate() updates index.allocated_size before
> > > shrinking the resident value, lookup-time validation can cover these
> > > header invariants without tripping over the driver shrink path.
> > >
> > > Add $INDEX_ROOT to the minimum resident value size table and validate=
 the
> > > resident index header fields before returning the attribute from look=
up.
> > > Require 8-byte aligned index header fields, a sane entries_offset, an
> > > index_length within allocated_size, allocated_size within the residen=
t
> > > value, and enough entry space for at least an index entry header.
> > >
> > > Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> > When this patch is applied, the generic/013 test fails randomly. The
> > failure can be reproduced by running xfstests generic/013 multiple
> > times. Additionally, ntfsprogs-plus must be installed to run fsck
> > checks.
> > Thanks.
