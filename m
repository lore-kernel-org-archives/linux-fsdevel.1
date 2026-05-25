Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54E39A078
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691122; cv=none; b=hxeawhSupgiRWiNSCY6fQayKCAgigqYl7Ca8bL4NYzJNQ0y3m39FOtWUXVphT0EWJIsuQHmFxjzAPFw/tKaQZ/9T5BRgCpmwr086AhK5yzKbZgEG7U1f1N6rvkZ2i3a7xuAM2Q8s4NiVSYSBbC2iQfjh9cH8hG6arewy3p5T1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691122; c=relaxed/simple;
	bh=3B9fcceQVwDaZBJEzlW/XbZ1kV8DpFKO3n0UcmVl0Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn1GHBUI6wOxqTWrGkvxznPwjhWpy8alAxF7Smj2ewy7XDiu7vbdcYWUQNiHdi7iBRCse27GE2DX9ypd0baTQ7cGy5i2qpkaiwRNM9OlZOVuL+PdoDGpCIBRiO1m987vAojI1a2+sOy0JfCP5dGgdTiHKslcsvSMysFfkpzn9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMvsEzmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMvsEzmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F91F00A3A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691120;
	bh=3B9fcceQVwDaZBJEzlW/XbZ1kV8DpFKO3n0UcmVl0Go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UMvsEzmfXSr8UmmFBWDpjVl6FMBNZBS10idLPs08+1NRwNtpzRrrh+jOaAkPhljcm
	 cdTpq8qK1DHI9THy6ghANu71/hkkYGDtkPmWPiyPjHabqp3Ecy4Kyf7KI/zBPW6qKG
	 3pNjkOFSBljnF6bwLJEMU+THi/8OvYgkZLyOHpJbsqBcIBkiGh4oQbR99z6xm9EtD1
	 wxwX2HFnzZjsQmrQj0oa5+8/A7mFfqDvw0iculH5AkA83bqw93d/5VYZLeaLdNidkm
	 fxPArwRyjbf3zFE5ZlUamf3hwTN6gcZZ13ACPvOw0eqYz85M7gdIjgsUObRYFH4D6X
	 rdpMGZlnT9Dpg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-687d82dd690so2846491a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 23:38:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/UZ0d9yMWDe5AR7StWIfriH1FJRgw8tL6r0xB88AsmWDPnAtIJDtHL1rpSWT8GuDMZBzqqJqPd9T7zSq4B@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLdDSSQs7awDGE072UBBzyC5F+ErkFFfkBe08Nitdw48J8lvx
	ucBbL/yAuFuxSNztQsi8Fk98HpelGdtahlB1uOoXZ7H3DBseszRGNIcg2QExywWIkaQJtRNXrw8
	SU8luu2GhobKu9L6NrK7vvpNVOG5u+Ww=
X-Received: by 2002:a05:6402:40d4:b0:67b:7d11:758e with SMTP id
 4fb4d7f45d1cf-6889c44d02bmr6453048a12.11.1779691119519; Sun, 24 May 2026
 23:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524054238.3129288-1-charsyam@gmail.com> <20260524054238.3129288-3-charsyam@gmail.com>
In-Reply-To: <20260524054238.3129288-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 25 May 2026 15:38:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_oj1JfnPKxn_CB-_uhzE_RAbcT_QemFKPs6pEO9VZKpA@mail.gmail.com>
X-Gm-Features: AVHnY4IyxKM_ODA4cY-jyj4Xw2T84KeuwVVawfUF5UgGpW7IVhhFoixAL91ZLSE
Message-ID: <CAKYAXd_oj1JfnPKxn_CB-_uhzE_RAbcT_QemFKPs6pEO9VZKpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs: validate resident file name attribute length
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Validate $FILE_NAME before lookup can return the current attribute,
> including the AT_UNUSED enumeration case where callers inspect returned
> attributes directly. Reuse the same self-contained helper for both the
> base-record lookup path and the attribute-list lookup path. Log a
> specific corruption message at the rejection point, matching the
> existing attribute-name validation in ntfs_attr_find().
>
> Reject non-resident $FILE_NAME records too: the format requires
> $FILE_NAME to be resident and callers treat returned records as
> resident.
Could you refactor the existing min_value_length check into a unified
validation helper that covers all resident attributes ? Other resident
attributes(volume name, index root, ea_information, etc.) with
variable-length could be validated similarly.
Thanks!
