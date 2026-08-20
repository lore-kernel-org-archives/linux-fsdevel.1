Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0C47D932;
	Thu, 20 Aug 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243947; cv=none; b=u2gp/h8NBrWao+IsGe9FCENI0j+5T+Y+blVi0xIfYOl33i4HKvZyVtd/MrGHcFmasZ6uIMJJQmXXVokN7uFetcB1bnRzQ2WDvVCNGx7aJvywxQMQ+jQRlAcx3b6e8KcpVg8VXgYTvHyz9WNUkONqF9/f0U72KvYjxSy7xWvAzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243947; c=relaxed/simple;
	bh=L1LvN3yhF8tra3DrAiIfdw6c1BTMhI3ogpV7R/Mhg74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B3kntUhjERMlfszeiIoK5Imw7xV36EAlDDC42Vu+l1YLf6MY046t1slJNjTPjLc8zOv/9aJ32yohTsdWZhrV1b13DzhKiuZnPO5VlowXK9On8HmtdASrpRAokUVTcwb+h+z0k4L9yt2aVXvesTkO6B8fxX4IreOoKDH2P/dwK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7st5NjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7st5NjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130991F00A3A;
	Thu, 20 Aug 2026 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787243946;
	bh=49UPXugT8aacI/8c5sUvSZdeK0pjUOwXBeUvJUMsfDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=S7st5NjKX8nmWkrGWZPwmcDTKXFCYkMPWrEcheXlksZoZP24xnlja7kwlUnwL1G3W
	 CQsGndT54p2S2z1n0GsJxX4NDGNBNhUm6EOdyUHkT8aD/FHO9SMCw1FLuyTW7c4CrL
	 fr1lcvQ1ZAVdMcPtjRgbavXTcQAhNNG8Ia9nb/P5q/PpsWihIOvoVZf/WvigGtPV5x
	 TrFDRce0Ca7rlvkI05h1qJ0mF6lOg5c5vqM/YqElxGqZ8VmbnrRxfZmfJLoANWb5s2
	 l6th91Of39TK/ZkvK1QEdSRKi6KGA3iiQCFboAwMstm+wF65eUPmxSJpScR0njqQC7
	 b8JYmUBHubzBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93F7D3811A7B;
	Thu, 20 Aug 2026 16:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v7.03-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <zeiezeji5xxupnhdapw5pcsitpou7ysgzavigp3jnp5i2vhuik@zxklkd53i6gz>
References: <zeiezeji5xxupnhdapw5pcsitpou7ysgzavigp3jnp5i2vhuik@zxklkd53i6gz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <zeiezeji5xxupnhdapw5pcsitpou7ysgzavigp3jnp5i2vhuik@zxklkd53i6gz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.03-rc1
X-PR-Tracked-Commit-Id: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d2ed026f031f764e9450ac9aada2f46bc977397
Message-Id: <178724389623.361479.16364599466879270405.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 16:38:16 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, Bradley Morgan <include@grrlz.net>, Oleg Nesterov <oleg@redhat.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 14:17:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.03-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d2ed026f031f764e9450ac9aada2f46bc977397

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
