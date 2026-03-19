Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8093AF649
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923936; cv=none; b=sf0HeSaMwbM8Uf2QZ+YWpBvM8Gg+YaltbwGS+GbKijk/9AGcUxjyv296vjwagsWMyHrTyYQI6Bh7TnHo0wk7drqAwvtAZMTD5k4PHOdHS9rA+797fw0GQidz4rgGv6EZTviPSa631RgQyRTD7WDcsceF5TMcl0MpFbhNvmjQUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923936; c=relaxed/simple;
	bh=Zo+8vWdyGD+nyD8B43AgyKBPgpnM/90ddXHcwLhsZKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKMR0zeNeuAKnxOH6JzVPQfzgKkozPON5M0+PZLO0F5b8U4MKREbcrayxAu5fnDDt7uOz6kGksBNGtNEE5wPC1yA/J1vOvBrTgtzz1kVm3VpjLHQ5du6pLPuE4Ylohl7RX/92AUV0IhWS7Uii2AzPZCTza1teMKx6paoiE4BuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St1TxO05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St1TxO05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09300C2BCAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773923936;
	bh=Zo+8vWdyGD+nyD8B43AgyKBPgpnM/90ddXHcwLhsZKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=St1TxO05CbAIsEgjCP3zUu7g5QHnUsV1/Z64Z1K5FM99LnuN9z/b3Rl3v0VbPjL+y
	 8xxD8glzUQ+AJ1nYIe/lReqK2SBbupL5MYhOYDLCChQMkMld0+nBDzoiljbxNUi+34
	 5ofXSK+aAdQR3xqZt24a4dgHQDwBLCocK9WWXXl+sWx+xtPJvySrCyXjzM8Ghsvu0+
	 OhgvrHtpFiwoMb29qOciGEXszeFKCrCDgJTOrJcW1+Xq4Zons/aMNgBkxR++qStFSD
	 /e0ZUxqA7todyB8bYZ/6MU8jcTK0mO3okT3k9QYsSlNHz2R5I6T0H3oFoEyTqklYGJ
	 9J0s5iEF4Ls8A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-667952fd262so1516758a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 05:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWupfcdUTzes6DiieEdxfJF39HP+IO72s1Q8XtdPid4Bx9g0aQRy/hKVmeqiokfGjPxIs+QiZRZGqW4H02C@vger.kernel.org
X-Gm-Message-State: AOJu0YxOd3fsRLDQqC3idWb3PRGQLK6PxO9dnpLf/9uaKaDDiTIsxMEi
	Gnz9QNiY4VS9ChUfKxhJMAIyLjRwHoyDxePgyS5mWhk/IOtcWLfQqDrUgSDCJyTIpyid1F4fd7U
	g4wNuHWwgpUgsgdXQZ7CyQ9qzxKG3H2o=
X-Received: by 2002:a05:6402:42cb:b0:664:bc6:69a9 with SMTP id
 4fb4d7f45d1cf-667b2c1ad95mr5355226a12.17.1773923934486; Thu, 19 Mar 2026
 05:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316214137.1490070-1-dxdt@dev.snart.me> <20260316214137.1490070-2-dxdt@dev.snart.me>
In-Reply-To: <20260316214137.1490070-2-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Mar 2026 21:38:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-5-uQ=hYY8yd=rCJZ=Jd4zANH3gr5zOTxS3AVwp5X8uw@mail.gmail.com>
X-Gm-Features: AaiRm51Hz8kaZYpv4RHYl-Gcl2fNGqr1q6k6j9cE2N-aAX4hajQAdLRF6YeLf_w
Message-ID: <CAKYAXd-5-uQ=hYY8yd=rCJZ=Jd4zANH3gr5zOTxS3AVwp5X8uw@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] exfat: fix s_maxbytes
To: David Timber <dxdt@dev.snart.me>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:42=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> With fallocate support, xfstest unit generic/213 fails with
>
>    QA output created by 213
>    We should get: fallocate: No space left on device
>    Strangely, xfs_io sometimes says "Success" when something went wrong
>   -fallocate: No space left on device
>   +fallocate: File too large
>
> because sb->s_maxbytes is set to the volume size.
>
> To be in line with other non-extent-based filesystems, set to max volume
> size possible with the cluster size of the volume.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
Applied it #dev.
Thanks!
