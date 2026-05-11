Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8826ED46
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468321; cv=none; b=icbLs2o6nRUILrcwlTbDf4DGty9CSz9HV4V0WxHVV86McmNo379Woa0eplcMmcpXySlR2qz7Lzalm1P3SxNDt4diG3zh0Scw890eko2QkSLGarsKiDbNfy4KCn/9PWc1AGjy0QesnBt2N1RIEU/4HU539NpBVfHwQPkhpYkFPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468321; c=relaxed/simple;
	bh=MMvb5qG7DKg7BZ+qTNXN2A+xUzvq2M7D1NC/PwBnKwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZyeh+4hMX7Ezz+uV084ZuH/HAD8V+uupSytPlblPbNmwVuFh6Au5sGhwyphAgvy1OygPK9n+HYhbVRd/w7j30fTNokXJeEvLBVIQ1gbokFx2/N6qDwYVlI1iZ3tdzVnSO9jnXjQyIMwRjSsOm3XM86m3swdoi/HYZyJ2Ct69UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvZug03z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvZug03z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D2C2BCC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 02:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778468321;
	bh=MMvb5qG7DKg7BZ+qTNXN2A+xUzvq2M7D1NC/PwBnKwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tvZug03zwB2K0e05HdqWIzuqHRd+Kg8W7LdZ6agi5HHo+PhN118VrVHmli/gIoi4R
	 lEzwob+oIZvn0DtgABOb8ytrq5pap+fIY4C0OnGO4wSQV0qfvRe26t060mmlV9AMs2
	 TcpRv9oOPmb0KGB0GdsByHfh76MNcvKI1BKsNRYQ0ZqMPoFuUUPmsViotIruFnK1ie
	 FoTJJ+rKwKhp9a1ie5Zjq8fj8zVLfMwtFErRoAlC13Aoq07DuROpLVFP3PIMEMHuo0
	 bWf2Rh1t6d8NyGfeQRWcVMze7Qc1HRN1COe+ox89be462pVaZNBP3aPm7G43XM2wF/
	 nsrTDVYTj0Eng==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso468792266b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 19:58:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8TnmGfhJ6i4Wdt8XjvYKj4sKjbnLTOGSjES1Qt6PtvsS8qJpAqmxz1FaVH/dqq0XgHXpFrwmUu8o24AZw1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HTekvmqqKxGeBy7y5tiXYfcgA2SJNLrMjwsMxGXJFqJwqiX+
	U6T8m4QNpv7GcGygBITzETSoJPwVZuOGBeWHBkHeGFty2xGO/rQJvrPFDS8kx3B7yK9+42Odi2M
	XCUXRGT/sFvTVCYcuL9xPLAlCz9osqeI=
X-Received: by 2002:a17:907:1c27:b0:ba4:94f8:4df with SMTP id
 a640c23a62f3a-bcc12668f74mr368340066b.17.1778468319593; Sun, 10 May 2026
 19:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510171115.368494-1-charsyam@gmail.com> <20260510171115.368494-3-charsyam@gmail.com>
In-Reply-To: <20260510171115.368494-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 11 May 2026 11:58:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Di8W_B4G6Wt6K3nJMACOsFWvDSm3UZL_Z2ewdO5G-Lw@mail.gmail.com>
X-Gm-Features: AVHnY4JXFttXurbigpQmVykm9s__wtjSjAq8IDYQ7pm20j2zyUiSPCDYyrsI_Lw
Message-ID: <CAKYAXd_Di8W_B4G6Wt6K3nJMACOsFWvDSm3UZL_Z2ewdO5G-Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs: do not mark the volume clean from sync_fs
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:11=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_sync_fs() can be called while the filesystem remains mounted
> read-write, for example by sync(2) or periodic writeback. Clearing
> VOLUME_IS_DIRTY from that path marks the volume clean before the mount
> lifetime has ended.
>
> If the system crashes after sync_fs() clears the bit but before unmount o=
r
> remount-read-only, the volume can be left looking clean even though a cle=
an
> shutdown did not happen. Keep the dirty bit set during sync_fs(); the
> unmount and remount-read-only paths already clear it when no NTFS errors
> were seen.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
The VOLUME_IS_DIRTY flag is set just before write operations. Once
those changes are safely flushed to disk, I think that it should be
reasonable to clear the dirty bit. That said, because many users
generally tend to simply unplug USB drives without unmounting,
clearing it only in the unmount paths causes unnecessary warnings and
chkdsk suggestions on the next mount, even when there is no actual
corruption.

Thanks.
