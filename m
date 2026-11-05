Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915806;
	b=FinF/YzaH6YKRKtlzXMp2uaFt8YqtwEM+zZtAQRLcYd4l6yc07Ed/y0NE7TQfoO5m6Ht
	 i2lul99FrIYzoIjeezvNUtv5MgldiWn7bIPwLN/I6AsoB4Wk5QkrfkXuPQP1GPf/ZUdcB
	 cuB/PNqrfAQe1N0Jd6sH7GDFDku876c0xn9y9Wfk7JaadDXa8Dlg3Dtv+DF4NobDdt8aW
	 Xixa41FWFNXfsk9EyCZKJ0qj/Z0WELL5F7Ai3DXMQ4f3bOa880t1RXfsdST4s/oLsy8Y8
	 6BsYlmH3w3lMXlY02TxKZc2Ok/RzwCqu8PAcPvovb07gOQK2j8SDJCYcRicUFOLqwvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915806;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=PCg+rr2vd7JHnauc9eR8fQNH2TzRs1epF2+HugzfQAg=;
	b=0VBAIqU6fnKcmB2us1I2GksO7satGwP7DO2gewRc6d19LYU4dt9b0SKPuoq1sP23MIG4
	 0i1G5GMKzBtWaTgnlvflh898vdIyVXjiF7SI844sC9hmemUPydi+m5R4goxFcYWvJiPn2
	 jLa0//nUlz1BsHd/v7Ti+0eCs7gxRozgOc/onA2UnyeXMDsYsCto/9g1MrXvMlwrcvof/
	 bJAiywoqRDHKPBTOqtiMlbCI0Lrx06M+jBa9i8H9abv/4/cxlDrzu1x25+XgEycPsq5eq
	 N7yU25fKF0OsjHBKsDpLO/euCECLTPcVqSFjerIQuRuiQAbNerDkPjZm0lfWygyjZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="czLYYJe/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A987606A336;
	Thu,  5 Nov 2026 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czLYYJe/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B001F008A4;
	Thu,  5 Nov 2026 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915805;
	bh=PCg+rr2vd7JHnauc9eR8fQNH2TzRs1epF2+HugzfQAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=czLYYJe/SlNOt4H2OO/6GlMshrCJIJSwtKLbaFrATGMvH++1A4wYbHUTdKhkowCFv
	 IO1X+3TyJfx1ptrVJ10xfUVem9LK/3jkgJjmyiOfn9R+Ko6yJ7D4NqtC6KGU4mixNF
	 HBD6o+88W0ydxblJSdBXRM8JZvD36cidKG4z4AHo7BrkeyZbAGLEenWS92dqxV+aVO
	 l0hb5KfHXvoXG7D1FoMo/No4nM6/lTOrskKsqouBkUljtq0u4rC2Mvi9m4ammJbrm5
	 Zg53CZ2hfTRs90e9I9uEhgCGJNhzUL3UosKSlDJ7iDhvcTBEf33tsQM1xOZUeIXswD
	 Pkeo2vVajNq4w==
From: Christian Brauner <brauner@kernel.org>
To: Seth Forshee <sforshee@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103163924.641377-1-sashal@kernel.org>
References: <20261103163924.641377-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests/mount_setattr: build with a 64-bit off_t
Message-Id: <20261105-beurteilen-derzeit-auszog-9c0e0ea59233@brauner>
Date: Thu, 05 Nov 2026 22:56:42 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 03 Nov 2026 11:39:23 -0500, Sasha Levin wrote:
> With glibc on 32-bit architectures, off_t is 32 bits unless
> _FILE_OFFSET_BITS=64 is defined, so the 2 GB ftruncate() of the ext4
> image gets a negative length and the test fails:
> 
>   mount_setattr_test.c:1048:30: warning: implicit conversion from 'long long' to '__off_t' (aka 'long') changes value from 2147483648 to -2147483648 [-Wconstant-conversion]
> 
> Build the test with -D_FILE_OFFSET_BITS=64.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests/mount_setattr: build with a 64-bit off_t
      https://git.kernel.org/vfs/vfs/c/8fa19db00bf3

