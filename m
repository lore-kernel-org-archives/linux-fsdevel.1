Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FF3EFFA4
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411087; cv=none; b=Hh3A5lnxUyrjwMOnMRuYs7LOxGq9W42RYuKf2LxTZMIjggZW3zxAxoCljw3Zf3a78eoeNY53lnH8gxesuXLnp5qC5+4iwzimdVxhwlUln/ZWuVJAfAeYtB3vYwaoIzZjIoSaGctTPnE9H8ZJU15Har57jEtLX6ORIH1xxYHzQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411087; c=relaxed/simple;
	bh=lOWYO0IXcSMgvLA0nu62U8Qnqn6C/7Nw0hKlvRO8bnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkjF5OSrvWKhQ0BqwFeH9avVg8NSmRpz7kSEgDGSBNWu/If310Yj4rikUT97+vEeMctpbS4vLOuvJBs3nC2mxTzSsMaejUtr3CFoyIEQtOomRfObrRmEsC5qz99OjoNc6m0rCMw3XS/MO/LAYh4nYjpnoYQk1m9yOuHx4NWeJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhVCI9XM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhVCI9XM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F1B1F00898
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411085;
	bh=lOWYO0IXcSMgvLA0nu62U8Qnqn6C/7Nw0hKlvRO8bnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XhVCI9XMSmKsj3sYyrQphz5WkJX55FeGBIiP+SiNxp6ePjv0n+XgcILNrlTAmpNzW
	 ARs0GNKG2URRCb8axI4EFtJkoI8vdNKTX3EXsQDzWUEA/nsORczouEZISTQac6TICN
	 Eb5QfakE/OamNRUW5eB6ZP0BZ45ezIjfZkJdCV7td/cP30Nh4LtWxuZ+zjzyN31oHO
	 N3HOXZQTuZZMx9RxheKFnd9yrp3RhLvplmqHp6RJCv2nlPx8oJr3FrdhahQBUnsRQN
	 tqr+CgBfteNeGLBLepsMo8MFYIM7FPXC3+g4YtYy6TUXYd+GK1HpGH2rTjDqfUo5n5
	 SImlYKRswNj2A==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ddd3d67084so55908117b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 07:38:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YwmTJNrQlZ2Yujq+mBEYGSU97KWVo2lFDLB7mUMU565DqNDy2Ze
	n9Qgt2DpgWzZyyiTsxzBqA7qOZ7JZ439gO/RZKQ7ANf2pkSO9vLxuCCzq7IeOMXRmISVGzovNvj
	X2oBfV4h09bmdnTIDUAFb7nJuGwzgoI4=
X-Received: by 2002:a05:690c:c529:b0:7e2:6f3c:2aa7 with SMTP id
 00721157ae682-7e946514d57mr25183897b3.47.1780411085198; Tue, 02 Jun 2026
 07:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260602141434eucas1p15746f013244db658407ada4f3cea7b89@eucas1p1.samsung.com>
 <20260602141427.2301354-1-m.szyprowski@samsung.com>
In-Reply-To: <20260602141427.2301354-1-m.szyprowski@samsung.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Jun 2026 23:37:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd87d8pycHVc7GLu5jTemowzRaLOSVfHLaBXYkUtetUN9A@mail.gmail.com>
X-Gm-Features: AVHnY4LuoUFATDg9XGoAmNc5_dn-sDe43EZG-5I56IgoSfFEQWdInv95949CSLo
Message-ID: <CAKYAXd87d8pycHVc7GLu5jTemowzRaLOSVfHLaBXYkUtetUN9A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix missing alloc_workqueue() flag
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:14=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Commit 21c05ca88a54 ("workqueue: Add warnings and ensure one among
> WQ_PERCPU or WQ_UNBOUND is present") added a check for the proper
> workqueue flags (WQ_PERCPU or WQ_UNBOUND). NTFS driver lacks them,
> what triggers the following warning:
>
> WARNING: kernel/workqueue.c:5855 at __alloc_workqueue+0x688/0x70c, CPU#0:=
 swapper/0/1
> workqueue: ntfs-bg-io is using neither WQ_PERCPU or WQ_UNBOUND. Setting W=
Q_PERCPU.
>
> Fix this by explicitely requesting WQ_PERCPU workqueue.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Applied it to #ntfs-next.
Thanks!
