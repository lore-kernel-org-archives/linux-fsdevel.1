Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C942B72E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558506; cv=none; b=SiNs3j1AYGghJrdvt2A0JTO1BmrXIoQj6n9+8ZKDE/kg3vwH7PbpsAmSP8Bx9ubWw3OzcVegyf+RnXPXFNP3PmptoiuO9GlBZ3WGok+GdItPsG8WxXaHTweQHIj/GNqFHOkhSNQwpHRCqKOETb+0STVt7IXB2rnRR+PyJeBZJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558506; c=relaxed/simple;
	bh=RTgG/fCb+rrJOH1ygwOUxdnEL9JG0s/Ukc/OziB2YOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKx1u2m0zl+W2gwoJVfehBJRA9YpR3b0MYyyljnX1dBz9YFZ+5nT9ssDKJjLoegNWqFHqhb37T6xZtKYT2hD6CilkRkBVtqCdcK6x3NDIu9le0vl+xFt/C/0YW0CC+qOea+zcgI8XfBQr+ho091chUGh20+45FxxMrB4Xxx8TjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQZyCVJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQZyCVJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F29C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777558505;
	bh=RTgG/fCb+rrJOH1ygwOUxdnEL9JG0s/Ukc/OziB2YOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQZyCVJ3U7YvnaZc86kEJJpRxeRshN4ggv8eCIvwqGV97YpFDnVmqlpFWBHbQb5UQ
	 yTHPzOAYavVQ22G9M9lwu8oT31YD1/URcfIx2FUWzC6q++lwL1qSBE6RGgROsNd8q2
	 VDfncw2Vf1+XOgDHtnWBzJ/Tb7LQpy3uNNB2zexyr6XCwIzyKvkseJXr5BzmgMjYlp
	 qbUYiApIFLc+x3zLqaIIL6W5IqIsnzGqx2ERgruR7dtzft2F6jATdluqyX4Eyarn9Q
	 RZfsWDf0qZ5sf3ZYQQCck9tMbOGyRN6YVC2JX2d1ku/xRc5dmYHO1bGE3xZtWdB/Hv
	 zrbAEHFHa0QJw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so951756a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:15:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/FG/9cdnmSEW+VLA68lLnq5de+DcyJCm9Pigc/D9C0lfgGN6sHFfHi8bKM4Fw0bRXLHOV+UDpy/my77k1R@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc6ZmsTV0khVrUB6lQShiv+uTfLTvNlqq4QrO1Rd5W5AkPp7E
	vrc/51qqVdB9dUolaaLzLpLri8wVVR/0QO4oxgP+6xwJga9kNFHKtmuOytpR78AQmeriaUAWL4W
	LiiSMuAuXVM5FISOFonqySS6/RrTwJKQ=
X-Received: by 2002:a05:6402:42d3:b0:676:d85a:5faf with SMTP id
 4fb4d7f45d1cf-67b5d812dbbmr1461002a12.9.1777558504434; Thu, 30 Apr 2026
 07:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6c4e93a-83c3-4a07-ace4-6262cdc0542b@dev.snart.me>
In-Reply-To: <c6c4e93a-83c3-4a07-ace4-6262cdc0542b@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 30 Apr 2026 23:14:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-YqKTWLTudEk6HvkkyE9B2480mCVmTKh9_tPzQDqdJ2w@mail.gmail.com>
X-Gm-Features: AVHnY4LM9Z8EuPRS5mNFWlxmMHgTlJ-3kwCFbC1qmXmHJlUL2NH3MdzKfT2cUU8
Message-ID: <CAKYAXd-YqKTWLTudEk6HvkkyE9B2480mCVmTKh9_tPzQDqdJ2w@mail.gmail.com>
Subject: Re: Host exfatprogs repo on git.kernel.org?
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 9:00=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> Hello maintainers,
>
> After the recent Github incident, it came to my attention that the
> critial companion of exfat fs, exfatprogs, is only hosted on Github. I'd
> like to voice my opinion that the repo also has to be hosted elsewhere,
> preferably on git.kernel.org like the other fs util projects.
>
> I don't think it really has to be git.kernel.org, as long as the main
> one(Github repo) and the secondary repos are synced simultaneously.
>
> Sorry if it's already hosted elsewhere other than Github.
Thank you for the suggestion.
I agree that having a mirror for the project's reliability. I will
check hosting exfatprogs on git.kernel.org.
