Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894632;
	b=DH5MV62vW7D5GPLZtEvQkdHbEWP50MliM2xgNt/+5/RHJyVSzfywqpRY2YfFoUEhAkbE
	 s9hDb5ugWOyBpIQFMa/GcRvUDMKS/DH6sp7rbpNPA1pMlRIf79w6I/VOi/hiZIMs2RjGs
	 RtczV9uk1QRDjwz00t3YyF+vn1FNh08JAMpw7od0e+hCuKgARQNXkOUSQL1urESYsfGKV
	 u2848K7ZoXcUmaZBaXxwuVBd/axGxZ6FaNaHRT1eFwIGELaA+q99di6Cc28t0V4I4+Tgv
	 D8go9Z7Zz94dz9bRNzfKrje6O4/DmThGFOR6kbG3JXynF8ZlwOTDylfBcpyf11SvoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894632;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=msGgG9mVnqkr3M+emaUDYoadKzi54X+6orZEmGrQfBs=;
	b=Ln0JoEJFEl2tSB5MzrJpAqQ833pq+Vq5QSo2Ba2/gG3LF/nWXnBrN0yr9cXHxvqBWXLe
	 SxYkf6JzKGFr/1Fzk797ZPO88rZFhnYaJ971REAZTjvYlgvJMJ5dWDXUyAqakYWPTQ3EB
	 5UKnDsLWR2DHtpnAITUT4YfcmQn3wN+541YtTaWIRpCKkagCiRMmlCME4DFjLoOJP2qII
	 9IxjDyNZUmYgguJf3Cyt21CAFPeg5CR9+Vu402QMxl0/twoOq92C5E3iuMSmho/3AwIWs
	 VfO89AtrdjcRofmP+hwuMnWQrFX4tsJoYiyxCv/+lQbIWeggeqU/AsPMeYUjuDeQW4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3BI+v6v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA207606BE88;
	Thu,  5 Nov 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3BI+v6v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2021F000C1;
	Thu,  5 Nov 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894631;
	bh=msGgG9mVnqkr3M+emaUDYoadKzi54X+6orZEmGrQfBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G3BI+v6vCZfbyQCqMtVL7EJeIFAz0EcsIUEQcxJi9JQJ4QQTPhJ14gBG13ejwaUqw
	 r971ocxjIXXHjaebCGMoq9Fl0Wof+lW92MltYDYp1xfLdQXTZgRGZVhi9VVh5Z64ui
	 vb1vlnQ7/fTYRCcsB9gTnQwJNP+s+05c5CVxhT3pj8vaJoHYy7hGxdwKCsAZyw34DX
	 QI+VobyXgu5zNy/FyE4bwFBfsri/ztZeaWhMSYfD23RJu9h083mktyJ11Pl0WQmTeE
	 mZn+DwwUFL2w7m19yFILDFT4yhoPsQvRj9xODx8LacxSiQD+/Q0r4QXfBbOZIiKAMl
	 23AxSrVh6UpDA==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Thomas Maarseveen <maarseveent@gmail.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260927051726.71337-1-jain.sm@gmail.com>
References: <20260927051726.71337-1-jain.sm@gmail.com>
Subject: Re: [PATCH 0/2] errseq: fix lost writeback errors in
 errseq_check_and_advance()
Message-Id: <20261105-rauszuholen-mitkommen-mineral-4754a8543ff3@brauner>
Date: Thu, 05 Nov 2026 17:03:46 +0100
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

On Sun, 27 Sep 2026 10:47:24 +0530, Shashank Mohan Jain wrote:
> errseq_check_and_advance() advances the caller's cursor to the value it
> tried to store even when its cmpxchg() failed. If errseq_set() stored a
> different errno in the meantime, the cursor holds a value that was
> never in the errseq_t. errseq_set() does not bump the counter while the
> current error is unseen, so recording the first errno again recreates
> exactly that value, and once another subscriber has marked it seen, the
> cursor's next check returns 0. For fsync() (file->f_wb_err) and
> syncfs() (sb->s_wb_err) this means that a writeback error recorded
> after the previous call returned is not reported. The race is rare: it
> needs two different errnos, an error recorded while the check runs, and
> a second subscriber consuming the value. There is no user report; it
> was found with a model checker.
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

[1/2] errseq: don't let errseq_check_and_advance() hide later errors
      https://git.kernel.org/vfs/vfs/c/d0a6315b5b37
[2/2] lib/tests: errseq: add a concurrent check_and_advance test
      https://git.kernel.org/vfs/vfs/c/2f3389d99e36

