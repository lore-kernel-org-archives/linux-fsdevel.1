Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D521406290
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391050; cv=pass; b=hazrV2IVCo5HoOq/2KsEdguM7W2tMuPXXIHhCCTSImCiIAOmFuWAdgutk8s+fQpu1T6vfvhDr964vO+KGJTNDFk8+EPVAFJO6QPBPGLSWiCDm0uuZmD8n9OFHjrUbZnxE4wGjNaOLdP4GBND1ZqH79YtNln4YrhhN20A9V8szNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391050; c=relaxed/simple;
	bh=avZX3uaG2c7Uv702o7AD1LUF0gJS7cKO12BHK/dtcxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj3TV0ErAze014XAK+C3Vx3NtrKiPVDXYn7Cz42Q8n+cLpkiU4d0ga6aHkwIn9p/daHrAhz0ozC+EFW+jsjgmieajY2wTopp1bQj2H4eN6gwu0mf8lvJBc4mK9w0XauqXB1lLxbeNS+OohGgECHqqeCIv8r9k7YD8lhy7zChZvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU714It1; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU714It1"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69d7b4da91dso371212eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779391043; cv=none;
        d=google.com; s=arc-20240605;
        b=TwnCMVNJjlq/ePzCjLoCglIv/WExzQjlqNug9+UH6D7Qx6o+mU2Bx115KC0Nqafa91
         EgND8HFRtJ3U9MLQQLMHyllqvTO1HH0CZFyHdE/pzGUY2usdubIRWE7xxejqLD9sEesb
         5aT7QL0HXl7okvrr+/ukMDsXEdOHeMtv6KpUEuxRed4Wr3lZBXZQyIDQMUvLrt5vDVBP
         IZx36wI78b9x9/je3VGx+yZXDK4CGR/0K1qlCUvJlQuT1cBkQMFWDCx3jLMxtLVY+UVZ
         q1nsqEKWPt29L9a2XSsOjOj5yHaoYMFAARXSg6gRNIQBD63V0frVdX3juCUj26Amwxoq
         NkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        fh=Ytm2qqwN0tbDjnkR3k2U2wYBvLMd7LKEpP+oVxi1AY8=;
        b=GTWPRR/jko/tEakGWwRUJH12up64ypRbRKIkxMMbo7Zv0VL7LRsh6UlvC86CIDlZ/V
         7koEXmUZH/zJkBEsXf/mQr+MMBtrnH7/PK3huKbRQtgtzz/hjP83gNh8gz/FQdxUkiKp
         urHbIXkA3ryaB8aEELEstPufq+8Voicxmxx1QNO3YPiGikKTkZP8o54HbF9Ax6/j54cC
         L9FWLEw4SssaJI7+3bd/AunV2K50cDOpi+Ksc08U+tikIVNKzkHFRO/z7qoO+suuAyPm
         EMG1dnHA7aqG4k0Cv1RAUr+BMyPq46lZLKA84ucaplYN/rWUaht1JobhGqn+6CfCM/ED
         HzgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779391043; x=1779995843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        b=UU714It1K9cW3oJh8wbU4+AR78RoF9p2w1//ZVK1rKbMDx/c9nDfQMxP0R26N86Tv0
         0uwGbSCw5uaTQEuY+Vb/ULTm21WAqqxJ4xRRTYspYv+gsGncs0jhwRDlM2ZCGoi8we6q
         rTBimFeEvYFQp9mbEYhZzwzTmyV3krNT5C+trPwgukQexe8LUhk3dI+kmDULPk7ruXgP
         YXvvKNtZcOh+capJDsG6zjKyoG5umfNGpKqBqo57hdpeFglMKtLWjJU8aScsN3DpeVb4
         fJUFwVKZiWViqvT2ZJD0ifG9Js4EoCFyghTvtqJYV4rl/wa/72u9irtsnmE5KUtCntR7
         cKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391043; x=1779995843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        b=n6VHpNb7jqKs9t5WimkLG0t8KNwwTpJE3/2cdkU3OnLXm1sSTtEwkH7gfBcY71wNb6
         K0tGTqh3TXkdiXP7M/0vgf68nY98g4Qfjb5EccSKEBfD1lsrd2v8t6qtQcN+phEw8vyu
         Tu7LTE/h13aZLLQCzrCJ09ST7x54kd/ba1PsTGcS8ld3m71TUwdh7JmjvveXIFyLB6Kw
         1hTV3PMeMbePa1jrhR188Xc1kVPmKdyLg0MVtJjEWvkFztxt8dAfwQdsFKSfhlvA4P4y
         hBYl2xp1vrPp0padsi51Nm0cevXazK56CD78GOD04vgZMcGvVMMKHJvwwFvAknoHGmB4
         hApw==
X-Gm-Message-State: AOJu0YzEBzPTrlZPZ+FOpeYJCR5ms4JsrDQEXfklnKLcu89VnM9pFwaK
	1b+IPwMY86IK39W+ecgCMdQoKsx3SQQTX1xIGaoFojEowo6oWN9Di7gg7LJmYORbMx5/XweO0Tt
	b1PXbsoLeuyhTgsK3u05PRaTLB1iMvQ==
X-Gm-Gg: Acq92OHRsjf7ppiF6O2EZMKKgHxkEuErylmv/GQpKmsUF+udok/UOnmAXsF24/P7W2C
	WEefP455jdD0Xd8v8yPVkjyw6CuU/Mcbj6lBvbsTkLyGHecl7H9WouUtox04082yheOWf4KkoxM
	IhQKi7HchO3Uz8ff0wW8RTW7S5lTG8oUKiNw200VRPI1bYV5ngKBEEWJiy+gSoh0hQ/uG3UK70i
	NZ4lxaN0MCuffk8uiJZ9ROzIWSdjwyedQR8+mVFDoSD6/O/PgdS16e0fNahfkar4OyJOBptcnzA
	7fddbLpb0JGADCZp
X-Received: by 2002:a05:6820:3098:b0:694:8bfa:7819 with SMTP id
 006d021491bc7-69d7eb7713fmr382844eaf.13.1779391043364; Thu, 21 May 2026
 12:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
 <20260518160836.29876-1-rochan.avlur@gmail.com> <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Thu, 21 May 2026 12:16:46 -0700
X-Gm-Features: AVHnY4IaRzsnxbLw2sxucfs2mozFVBFtKemPMfMPvR7vptvaaVQZoKq-_NIPIlM
Message-ID: <CALbtPkUOh6seU3eBo63_D_soq5CTLh+aROXvBxEM=Y03OzPoHw@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: preserve benign secondary entries during rename
 and move
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, "rochan.avlur@skydio.com" <rochan.avlur@skydio.com>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I think we can do this by passing old_es and num_extra_entries to
> exfat_init_ext_entry() and set new_es in the following order.
>
> exfat_init_ext_entry()
> {
>         // 1. set file entry
>         // 2. set stream extension entry
>         // 3. New step: copy benign secondary entries to the tail of new_es
>         // 4. set name entries
> }
>
> > +       /*
> > +        * Relocate when the old slot is too small, or when extra
> > +        * entries exist and the name entry count changes.
> > +        */
> > +       if (old_es.num_entries < num_total_entries ||
> > +           (num_extra_entries && num_old_name_entries != num_new_name_entries)) {
>
> If the above implementation is followed, this change is not needed.

Thanks for the review. The separate exfat_copy_trailing_entries() was
unnecessarily complex, and integrating the benign entry copy into
exfat_init_ext_entry() is cleaner.

> This change will cause the rename operation to fail due to no space, even if
> filename is shortened, when the partition is full.

Good catch. I'll send a v4 with these changes.
