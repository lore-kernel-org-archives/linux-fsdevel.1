Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186393D905B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185503; cv=none; b=Mvnpruwx5iHhc6A18RZdAetH1GtgIGzSsMb/R+9+A3FNpXlcirZ4hiNHnMtxZ4zreiabD2kBmQyMJ9WK4R3eMkV2rwNXuxw5/L7GsxRvpkARhV0W4SiHDu4HPCbRadn7UcF+71q28qY/htqXp8Gqfdd6cC70wuoWFBVgphmuC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185503; c=relaxed/simple;
	bh=zDoA35LR+8oFzy3DLHOo9F/hUNTBduyvH6S7rDJd/O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlF8SF3QdcURHlmqKGHU4aRtaufWUDWCDw4yWsz/F8O6LXsVK3rH9NidSPylJyFEcbT2d2lIt86vsUcW//OZxm4LkC8OzTdCDyhWTfJ8hwPish98TGwcePDuDZk8XCPbgj86QgwXaTKNuFPL78vCkSIa4soUVH4KHP2sjcQ3U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH+Lq49v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH+Lq49v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE52C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772185502;
	bh=zDoA35LR+8oFzy3DLHOo9F/hUNTBduyvH6S7rDJd/O4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uH+Lq49vUg6dzs90nwAMK0rB1gt3xqx/b4LHjMPR8O5S9z5AIfOCuVJNMmAQGbqMz
	 giWS5sPslUsXfYNsIvYJXOgaXUAXgFikKoPCO+fWPfgRuIjwsofH1ie6oyb3wI2aqr
	 yp8TJyEAysLkohhy+4+sJgau5WEthV5dtgQ3Jyr7eNkAdcIOi8/aupswydpzendF+A
	 ZzxkjbEuRNnEDnqP9ezZph3MhmHCtR57opDXgt9nHn/gmCbyIXPorRM5go04CesXoO
	 sgkiLlRtysvq4Pzg7C99tBQ5aGI+7jHXZ5BoRXVlGDyk0d2G44VMwj06al6YbAOzcJ
	 /zrG3u+He1H5Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b935b8dcab7so289830766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 01:45:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqHFbbcxKmtHOMBSRbX9WcWlKSJEbXKnZ310qhImrHi90aovd1wf9f7jXiPBGtj3/vfsuY+MH5ZuMSQ+Tu@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3ct+c20j73wjgbk+hDdtuqqepzM4K22KP6Y4SkT20636gMFk
	7/GVzFHkqoC1jazxZeHC2pfBhebRHFF/bRz8lu+4GPTeTDaLibwQH7X75/5zyggR1VGhGz2EP3c
	Q6aXhnbWU77D8wxzQUcVlssBsGR+oOqk=
X-Received: by 2002:a17:907:a0c:b0:b93:5564:1b69 with SMTP id
 a640c23a62f3a-b93764cdadamr138930566b.28.1772185501255; Fri, 27 Feb 2026
 01:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
In-Reply-To: <20260226160906.7175-1-ethantidmore06@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 27 Feb 2026 18:44:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_9FHR1WaN7GuKwSBsYeO1gS4m=2n+wz+LSapu4Tp7kCg@mail.gmail.com>
X-Gm-Features: AaiRm50Q9o5Yed5Q31CihV18hACij6dEbHIq6HX4KtOL8RNw6XXp0Zp-VwKwh14
Message-ID: <CAKYAXd_9FHR1WaN7GuKwSBsYeO1gS4m=2n+wz+LSapu4Tp7kCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ntfs: Bug fixes for attrib.c
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:09=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:
>
> Here are three bug fixes found with Smatch.
>
> Ethan Tidmore (3):
>   ntfs: Place check before dereference
>   ntfs: Add missing error code
>   ntfs: Fix possible deadlock
Applied them to #ntfs-next.
Thanks!
